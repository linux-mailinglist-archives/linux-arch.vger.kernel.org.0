Return-Path: <linux-arch+bounces-9364-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4A29EE6E1
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 13:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F8E165872
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD677212B03;
	Thu, 12 Dec 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrLrmx1N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEDD2080D8;
	Thu, 12 Dec 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007230; cv=none; b=iVshOwETsZhu8pn/P28+FZA8YYmHBDSnhUhkVnVqwJHnn5kS7qHpebyxJFs+pB3rQnfFlS/frx9KkZcaHueGAfzX7wTAgQCE5U2gcOymM57YDvIu/BGprQv7Rts6xP+sO7fg5o2AtEdrxgW47w8q2lge+UK7r1Yk5M0YjX0KovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007230; c=relaxed/simple;
	bh=r1wFQ2XEw4h3NqlPy/Ig8PdgIYeLmggghPp5vpM+aTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6aILJeHbwT5JxI+Z0VxwqS1C79Gfc+Z2gs2xv2PaFYuoUIHrpmkcM7RS/ZInwDs2WOkUegQ8+a6abN889f+5YPQGtWDhzL4N1lJ1HR1hIKxyHplaqHM2XoUXiFdt7WZCbJpekO8G77k/Aj/UXFcR/GiGwwCZKnzEL6V3QxXr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrLrmx1N; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef718cb473so76879a91.1;
        Thu, 12 Dec 2024 04:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734007227; x=1734612027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1wFQ2XEw4h3NqlPy/Ig8PdgIYeLmggghPp5vpM+aTg=;
        b=YrLrmx1Nl9HgF4rHw8ojYJ7uBKTZ6+UIrreGLX3+FP/601cVHoAnJ6FXwkNWgO7yuv
         hhrk7WizxUbLR3hkV9vbj6MUKZY/gWk0SfwiUE2QaGw6aqNNZ3ltdualyQIbm2RyOFaq
         Pzx/zSJKtj9IPrTSSrsCxs2Yr4790e2/NraElW+7UEDeiWlxxkRnq711G9Yr06DYZYrz
         kVPb8NTA8pt6V0rnVqRT+40+sHl+c8THeRyQLA8x2c8gwPvFEmN1nUtDheaYls7mszXU
         cw0InI17MT2DKqOnLYjwkVCgJ5fx5tC8efmTK3ZeqcWsKj7ChFuTEnF45sg1E0IfEVjF
         roOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007227; x=1734612027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1wFQ2XEw4h3NqlPy/Ig8PdgIYeLmggghPp5vpM+aTg=;
        b=GU0q2ORZc+y3L0pt0DfCx8UYyIj4Nn8FbdwOhGkLEzTgVmp7yY2+WsqNNSLdK4zB2d
         Ur5WGRSz84vV3OfgQvDvy4UkFQ84gapSh0wpDAGPsYMI2BV6k+CHvKVApod/aAqxBkXa
         vCgDKzc1e9smkK3+0VR+0mVkbHnP6/08eXwwNRyf7G16fbg3R9ibktvYpw3Ir4A0YEFy
         Hm/n0nGafSxuyYaomRuPPwmQwAdpEuP4HpGQ6Uu7KZ5ByJAes1bdP0W1Yzxql6EOGKMZ
         GYJp3/K2lCT67wJJY2AzOEPa6Se/4vX3Ipe2XUDTD8zlaX/3RxAn+mEHaeIXyVG9WwkR
         wzbA==
X-Forwarded-Encrypted: i=1; AJvYcCUFb2PC4mIWh3GM/6ED3oMWzQiW321PKtxPlNYGUuPiaamC40HV+htXeSODs/DrfPDPI4izjHPLeO20lm69@vger.kernel.org, AJvYcCW5NKhBVpbq987xL4M9nA/KCRzlEZ3nWPq0Y9vZcl/4ptGQyVSGj7YG4z2Pul8nNh6U+iGbO8iXtC9T@vger.kernel.org, AJvYcCWshMxfdc1IcnN8grUk5dngzj1AE5ULpsJWGyBfikeBxEvDxko8LkYv+wW24MsJKyMkUEdJMDzkgWHx2e3dnbynWQz5@vger.kernel.org, AJvYcCXz/WfFquriyPulsI4/c8cOVTrKrr9m3eEh9kwkwHrkuRd3+draZSkZLlYvKqkxdMwBxfm2FTuotzvJG3mXT0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxryXLDazyHIPrVjDcv9KunsiQK/nOkKH/yRoZxU5mZta+/xpYq
	xKgRE0YrcfVjOcagWWyo1qSxodg4s2sfHpeGmrT546/PMm5v8PX+X1F3a5mc418zVStd949rH44
	SQBvghrrFDleRtYmIN+Esn3XJh/8=
X-Gm-Gg: ASbGncuSbUiw5UJnWRLpYpUCypk937dyvrvZ9dgqko1IC0b9R4nQy/FAEBuBqwsOxcs
	M5MyRudfhvTHDGe3tG5cN8I/Euw7KRNlvSwOc/g==
X-Google-Smtp-Source: AGHT+IGFpqHYpP+ryhHdXHcJSw/i/CLG0LKsPNa9VsJsTDjRyGichTiBKLOQwEEn9jpAx0lNH3xQvXBViE9Iz/QqtPc=
X-Received: by 2002:a17:90b:3b87:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2f127e2416fmr3955460a91.0.1734007227479; Thu, 12 Dec 2024
 04:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com> <173395634899.1729195.7492083712432982213.git-patchwork-notify@kernel.org>
In-Reply-To: <173395634899.1729195.7492083712432982213.git-patchwork-notify@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Dec 2024 13:40:13 +0100
Message-ID: <CANiq72mmO5SswxmdcLc0i_rY+ZVo4zY8AsmHPPBKb_Vmzk8+aw@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Tracepoints and static branch in Rust
To: patchwork-bot+linux-riscv@kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>, linux-riscv@lists.infradead.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, 
	ubizjak@gmail.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, mark.rutland@arm.com, ryan.roberts@arm.com, 
	tabba@google.com, linux-arm-kernel@lists.infradead.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	apatel@ventanamicro.com, ajones@ventanamicro.com, alexghiti@rivosinc.com, 
	conor.dooley@microchip.com, samuel.holland@sifive.com, chenhuacai@kernel.org, 
	kernel@xen0n.name, maobibo@loongson.cn, yangtiezhu@loongson.cn, 
	akpm@linux-foundation.org, zhaotianrui@loongson.cn, loongarch@lists.linux.dev, 
	cmllamas@google.com, palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:32=E2=80=AFPM <patchwork-bot+linux-riscv@kernel.=
org> wrote:
>
> This series was applied to riscv/linux.git (fixes)
> by Steven Rostedt (Google) <rostedt@goodmis.org>:

Hmm... This is already in mainline, and I don't see it in
riscv/linux.git (fixes) -- I guess it was a mistake?

Cheers,
Miguel

