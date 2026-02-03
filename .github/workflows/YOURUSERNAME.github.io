<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Valentine?</title>

  <style>
    :root{
      --bg1:#ffeff5;
      --bg2:#ffe3ee;
      --card:rgba(255,255,255,0.92);
      --shadow:0 20px 60px rgba(0,0,0,0.12);
      --pink:#ff3b7a;
      --pink2:#ff7aa2;
      --text:#2b2b2b;
    }
    *{box-sizing:border-box;}
    body{
      margin:0;
      min-height:100svh;
      display:grid;
      place-items:center;
      font-family:ui-sans-serif,system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
      color:var(--text);
      background:
        radial-gradient(circle at 20% 10%, #fff 0, transparent 40%),
        radial-gradient(circle at 80% 30%, #fff 0, transparent 45%),
        linear-gradient(180deg,var(--bg1),var(--bg2));
      overflow:hidden;
    }

    /* confetti canvas */
    #confetti{
      position:fixed;
      inset:0;
      width:100%;
      height:100%;
      pointer-events:none;
      z-index:50;
    }

    /* floating hearts background */
    .heart{
      position:absolute;
      width:18px;height:18px;
      background:var(--pink);
      transform:rotate(45deg);
      opacity:0.18;
      animation:floatUp linear infinite;
      border-radius:3px;
      pointer-events:none;
      z-index:0;
    }
    .heart:before,.heart:after{
      content:"";
      position:absolute;
      width:18px;height:18px;
      background:var(--pink);
      border-radius:50%;
    }
    .heart:before{left:-9px;top:0;}
    .heart:after{top:-9px;left:0;}
    @keyframes floatUp{
      from{transform:translateY(35svh) rotate(45deg);}
      to{transform:translateY(-120svh) rotate(45deg);}
    }

    .wrap{
      width:min(520px,92vw);
      padding:18px;
      position:relative;
      z-index:2;
    }
    .card{
      background:var(--card);
      border:1px solid rgba(255,255,255,0.65);
      border-radius:22px;
      box-shadow:var(--shadow);
      padding:26px 22px 22px;
      text-align:center;
      backdrop-filter:blur(8px);
    }
    h1{
      margin:10px 0 6px;
      font-size:clamp(26px,4vw,34px);
      letter-spacing:0.2px;
    }
    p{
      margin:0 0 14px;
      font-size:16px;
      opacity:0.9;
    }
    .gif{
      width:230px;height:230px;
      border-radius:18px;
      object-fit:cover;
      box-shadow:0 10px 25px rgba(255,59,122,0.18);
      border:2px solid rgba(255,255,255,0.85);
      background:#fff;
    }
    .subprompt{
      min-height:28px;
      margin-top:10px;
      font-size:15px;
      color:rgba(43,43,43,0.78);
      transition:transform .18s ease;
      font-weight:700;
    }

    .btnRow{
      margin-top:18px;
      display:flex;
      justify-content:center;
      gap:14px;
      flex-wrap:wrap;
      position:relative;
    }

    button{
      border:0;
      border-radius:14px;
      padding:12px 18px;
      font-weight:900;
      cursor:pointer;
      transition:transform .18s ease, filter .18s ease, opacity .18s ease;
      user-select:none;
      -webkit-tap-highlight-color:transparent;
      position:relative;
    }

    #yesBtn{
      background:linear-gradient(135deg,var(--pink),var(--pink2));
      color:white;
      box-shadow:0 14px 25px rgba(255,59,122,0.28);
      transform:scale(1);
    }
    #yesBtn:hover{filter:brightness(1.05);}
    #noBtn{
      background:rgba(0,0,0,0.06);
      color:rgba(0,0,0,0.70);
      transform:scale(1);
    }

    .wiggle{ animation:wiggle 0.22s ease-in-out 1; }
    @keyframes wiggle{
      0%{transform:translateX(0) scale(var(--s,1));}
      30%{transform:translateX(-8px) scale(var(--s,1));}
      60%{transform:translateX(8px) scale(var(--s,1));}
      100%{transform:translateX(0) scale(var(--s,1));}
    }

    .hidden{display:none;}
    .yay h1{font-size:clamp(30px,5vw,42px);}
    .smallNote{font-size:14px;opacity:0.8;margin-top:10px;}

    /* little helper button on yay screen if Pinterest image doesn't load */
    .linkBtn{
      display:inline-block;
      margin-top:10px;
      background:rgba(0,0,0,0.06);
      color:rgba(0,0,0,0.75);
      text-decoration:none;
      padding:10px 14px;
      border-radius:12px;
      font-weight:900;
    }
  </style>
</head>

<body>
  <canvas id="confetti"></canvas>
  <div id="hearts"></div>

  <div class="wrap">
    <!-- MAIN CARD -->
    <div class="card" id="mainCard">
      <img
        class="gif"
        alt="Cute animation giving a heart"
        src="https://media.giphy.com/media/Fu3OjBQiCs3s0ZuLY3/giphy.gif"
      />
      <h1>Will you be my Valentine, Avery? 💘</h1>

      <!-- Keep this (now used for the "No" click messages) -->
      <div class="subprompt" id="subprompt"></div>

      <div class="btnRow">
        <button id="yesBtn" type="button">Yes 💖</button>
        <button id="noBtn" type="button">No 😅</button>
      </div>

      <div class="smallNote">*(Try pressing “No”… if you dare.)*</div>
    </div>

    <!-- YAY SCREEN -->
    <div class="card yay hidden" id="yayCard">
      <img
        class="gif"
        id="happyWolf"
        alt="Happy animation"
        src="https://pin.it/7gEz1GlTb"
      />
      <h1>YAYYYY!!! 🥳💗</h1>
      <p>Best decision ever. I love you.</p>

      <!-- Fallback if Pinterest blocks embedding -->
      <a class="linkBtn" href="https://pin.it/7gEz1GlTb" target="_blank" rel="noopener">
        If the image doesn’t load, tap here 💗
      </a>
    </div>
  </div>

  <script>
    // ===== Background hearts =====
    (function spawnHearts(){
      const hearts = document.getElementById("hearts");
      const count = 22;
      for(let i=0;i<count;i++){
        const h = document.createElement("div");
        h.className = "heart";
        h.style.left = (Math.random()*100) + "vw";
        h.style.animationDuration = (6 + Math.random()*8) + "s";
        h.style.animationDelay = (Math.random()*6) + "s";
        const size = 10 + Math.random()*16;
        h.style.width = size + "px";
        h.style.height = size + "px";
        h.style.transform = "rotate(45deg) scale(" + (size/18) + ")";
        hearts.appendChild(h);
      }
    })();

    const yesBtn = document.getElementById("yesBtn");
    const noBtn  = document.getElementById("noBtn");
    const subprompt = document.getElementById("subprompt");
    const mainCard = document.getElementById("mainCard");
    const yayCard  = document.getElementById("yayCard");

    let noClicks = 0;

    // Text rotates each time "No" is clicked (no wolf references)
    const messages = [
      "Are you sure? 🥺",
      "Like… REALLY sure??",
      "Think again for me 💗",
      "Okay okay—pause 😅",
      "That’s kinda heartbreaking 😭",
      "What if I ask nicely… pretty please?",
      "Wait wait—don’t do this",
      "I am literally begging",
      "This is the wrong button 😤",
      "I’m going to cry",
      "There is ONE correct answer",
      "No is starting to look suspicious…",
      "I’m making Yes easier for you 😌",
      "Be honest… you want to press Yes",
      "Final warning: No will vanish"
    ];

    noBtn.addEventListener("click", () => {
      noClicks++;

      const msgIndex = Math.min(noClicks - 1, messages.length - 1);
      subprompt.textContent = messages[msgIndex];

      // Shrink No + Grow Yes
      const noScale  = Math.max(0.08, 1 - noClicks * 0.12);
      const yesScale = 1 + noClicks * 0.18;

      yesBtn.style.transform = `scale(${yesScale})`;

      // Wiggle No as desperation increases
      noBtn.style.setProperty("--s", noScale);
      noBtn.classList.remove("wiggle");
      void noBtn.offsetWidth;
      noBtn.classList.add("wiggle");

      noBtn.style.transform = `scale(${noScale})`;
      noBtn.style.opacity = Math.max(0.15, noScale);

      // Eventually remove No's power
      if (noScale <= 0.18) {
        noBtn.style.pointerEvents = "none";
        noBtn.textContent = "Nope";
      }
    });

    yesBtn.addEventListener("click", () => {
      blastConfetti(260);

      setTimeout(() => {
        mainCard.classList.add("hidden");
        yayCard.classList.remove("hidden");
      }, 250);
    });

    // ===== Confetti (colorful) =====
    const canvas = document.getElementById("confetti");
    const ctx = canvas.getContext("2d");

    function resizeCanvas(){
      canvas.width = Math.floor(window.innerWidth * devicePixelRatio);
      canvas.height = Math.floor(window.innerHeight * devicePixelRatio);
      canvas.style.width = "100%";
      canvas.style.height = "100%";
      ctx.setTransform(devicePixelRatio, 0, 0, devicePixelRatio, 0, 0);
    }
    window.addEventListener("resize", resizeCanvas);
    resizeCanvas();

    let confettiPieces = [];
    let animating = false;

    const colors = [
      "#ff3b7a", "#ff7aa2", "#ffcc00", "#7cdbff",
      "#a78bfa", "#34d399", "#fb7185", "#f97316"
    ];

    function rand(min,max){ return Math.random()*(max-min)+min; }

    function blastConfetti(amount){
      const w = window.innerWidth;
      const h = window.innerHeight;
      const originX = w * 0.5;
      const originY = h * 0.35;

      for(let i=0;i<amount;i++){
        confettiPieces.push({
          x: originX,
          y: originY,
          vx: rand(-7, 7),
          vy: rand(-10, -3),
          g: rand(0.18, 0.32),
          size: rand(5, 10),
          rot: rand(0, Math.PI*2),
          vr: rand(-0.25, 0.25),
          life: rand(80, 140),
          color: colors[Math.floor(Math.random()*colors.length)]
        });
      }

      if(!animating){
        animating = true;
        requestAnimationFrame(tickConfetti);
      }
    }

    function tickConfetti(){
      ctx.clearRect(0,0,window.innerWidth,window.innerHeight);

      confettiPieces = confettiPieces.filter(p => p.life > 0);

      for(const p of confettiPieces){
        p.life--;
        p.vy += p.g;
        p.x += p.vx;
        p.y += p.vy;
        p.rot += p.vr;

        ctx.save();
        ctx.globalAlpha = Math.max(0, Math.min(1, p.life / 120));
        ctx.translate(p.x, p.y);
        ctx.rotate(p.rot);
        ctx.fillStyle = p.color;
        ctx.fillRect(-p.size/2, -p.size/2, p.size, p.size);
        ctx.restore();
      }

      if(confettiPieces.length > 0){
        requestAnimationFrame(tickConfetti);
      } else {
        animating = false;
        ctx.clearRect(0,0,window.innerWidth,window.innerHeight);
      }
    }
  </script>
</body>
</html>

