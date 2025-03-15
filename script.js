let mediaRecorder;
let audioChunks = [];

document.getElementById("startRecord").addEventListener("click", async function () {
    let speechStatus = document.getElementById("speechStatus");
    speechStatus.innerHTML = "🎤 Recording... Speak now!";
    
    let stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    mediaRecorder = new MediaRecorder(stream);
    
    audioChunks = [];
    
    mediaRecorder.ondataavailable = event => audioChunks.push(event.data);
    mediaRecorder.onstop = async () => {
        let audioBlob = new Blob(audioChunks, { type: "audio/wav" });
        let formData = new FormData();
        formData.append("file", audioBlob);

        speechStatus.innerHTML = "⏳ Processing...";
        
        try {
            let response = await fetch("http://127.0.0.1:8000/check-speech", {
                method: "POST",
                body: formData
            });

            let result = await response.json();

            if (result.fraud_status) {
                document.getElementById("speechResult").innerHTML = result.fraud_status;
            } else if (result.error) {
                document.getElementById("speechResult").innerHTML = "❌ Error: " + result.error;
            }

            speechStatus.innerHTML = "🎤 Recording stopped.";
        } catch (error) {
            document.getElementById("speechResult").innerHTML = "❌ Server error!";
            speechStatus.innerHTML = "⚠️ Try again.";
        }
    };

    mediaRecorder.start();
    document.getElementById("stopRecord").disabled = false;
    document.getElementById("startRecord").disabled = true;
});

document.getElementById("stopRecord").addEventListener("click", function () {
    mediaRecorder.stop();
    document.getElementById("stopRecord").disabled = true;
    document.getElementById("startRecord").disabled = false;
});
