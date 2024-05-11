Return-Path: <linux-arch+bounces-4327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1A68C31D5
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 16:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101B71F218A8
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC7E5381A;
	Sat, 11 May 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnu+PfEJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68686FC6;
	Sat, 11 May 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715437728; cv=none; b=qZO2hJaz+b5oRFL7/0lMHEbz5Kny+afMc9RRQLRLfDyN6ET5Wn4TjwK9iClW+Cv1JCys87x05pzGUU9T2IEf5L1ewK3DuGjT/SU5kpYce2zPbsc2FdMBU66YcP5MbOlBusX6D9qwmOGIaoMjG97kLOgB4vKVrBgw7yEgXhWu/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715437728; c=relaxed/simple;
	bh=hVfcUB6YKy1TPaPObfF0ZH0LYE3QeixYLkT+X70y2W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOL1Fb1MXA0fCTzLRCiS4J7Oc4dGiOjxn/GmpjGwSiyuNY6vV8/El1JnC3FL29XFSWhHllrMTYxWeAI9FhjNAaQSrmkKnut+vrAHG9CioQS3xRcofebtpM3N8gCBahhfIUtOvSlckBo7G1Offyv1EhASb7OPc/W2lJ1wQTlczZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnu+PfEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB00C2BBFC;
	Sat, 11 May 2024 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715437728;
	bh=hVfcUB6YKy1TPaPObfF0ZH0LYE3QeixYLkT+X70y2W8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nnu+PfEJGjGmGgBroc5jGVFnyvQpbNL2PUvAjMk38AWUWnIaN1HGd+UJ0eMgNDNSc
	 P2psasTiG4tcFU6QstXSouDzgyTesp7HArJCxBbMtZzNfYDO/S+XN376hKfRncU5o4
	 dIHPSiZV5TdcZ4+pnLZNbikd4463oZ/R5rhgBQxdwbMGUW8aNUYjettwu3AwF+0RhR
	 LJx+1Lqtj5vr9j74vpu75PsGPbBErDCNNImXB05ejRU5lGI0prmRrt/zclERizUkqj
	 2fthMVQhKlDev4TPCt+8/2MWChc4Q//y2ImJQH/4WpiizTxniHKO9YX3sM6KdDxwmW
	 B0EcJaYNqWDDQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a387fbc9so767600066b.1;
        Sat, 11 May 2024 07:28:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmMmbUQCL2nYjHNB54mUQQXQ5/+Nrf8Kt/XAMzttmo9CycKuliP8eDL0Re5qjpWj48NQzqC70QLoRI5itlrVb+KeefBNUsluu9TJ/ErdF15L1yLYv9CwToYaYtMXy5U21SNVg7oUF1+adH3+MCf5PWPBkDT0Em/l/VePIfmSgpCw==
X-Gm-Message-State: AOJu0YxSjy43d++nIAO8rFctShXaksuLnI+jY+7iTixLalWdRHUDFzD5
	+4giTvv6Ar7JYvjOZYaGeSXtMb9tdGLR8pEjnoJ46W50InczuVXj71n+BLDzdRDQAjqPI9uwdp3
	7apVzbq1OzEbldUTYAHl7l9A/vSk=
X-Google-Smtp-Source: AGHT+IFcDqRIXjIuKbUG9WiRrS4MwBW3gLgvFZbjFjbtR5/V1z73E6frqocpLZRKTfsXevGcTIzd6ty66lSctEvFB7k=
X-Received: by 2002:a17:906:1c10:b0:a59:9b75:b84 with SMTP id
 a640c23a62f3a-a5a2d5d4492mr330834966b.35.1715437726856; Sat, 11 May 2024
 07:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511100157.2334539-1-chenhuacai@loongson.cn> <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
In-Reply-To: <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 11 May 2024 22:28:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
Message-ID: <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Arnd,

On Sat, May 11, 2024 at 8:17=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sat, May 11, 2024, at 12:01, Huacai Chen wrote:
> > Chromium sandbox apparently wants to deny statx [1] so it could properl=
y
> > inspect arguments after the sandboxed process later falls back to fstat=
.
> > Because there's currently not a "fd-only" version of statx, so that the
> > sandbox has no way to ensure the path argument is empty without being
> > able to peek into the sandboxed process's memory. For architectures abl=
e
> > to do newfstatat though, glibc falls back to newfstatat after getting
> > -ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
> > inspecting the path argument, transforming allowed newfstatat's into
> > fstat instead which is allowed and has the same type of return value.
> >
> > But, as LoongArch is the first architecture to not have fstat nor
> > newfstatat, the LoongArch glibc does not attempt falling back at all
> > when it gets -ENOSYS for statx -- and you see the problem there!
>
> My main objection here is that this is inconsistent with 32-bit
> architectures: we normally have newfstatat() on 64-bit
> architectures but fstatat64() on 32-bit ones. While loongarch64
> is the first 64-bit one that is missing newfstatat(), we have
> riscv32 already without fstatat64().
Then how to move forward? Xuerui said that he wants to improve
seccomp, but a long time has already passed. And I think we should
solve this problem before Debian loong64 ports become usable.

>
> Importantly, we can't just add fstatat64() on riscv32 because
> there is no time64 version for it other than statx(), and I don't
> want the architectures to diverge more than necessary.
> I would not mind adding a variant of statx() that works for
> both riscv32 and loongarch64 though, if it gets added to all
> architectures.
As far as I know, Ren Guo is trying to implement riscv64 kernel +
riscv32 userspace, so I think riscv32 kernel won't be widely used?

Huacai
>
>       Arnd
>

