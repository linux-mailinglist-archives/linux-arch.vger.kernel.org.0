Return-Path: <linux-arch+bounces-14877-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E2C69FD3
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 15:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DCDA72BFDD
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B906035F8BD;
	Tue, 18 Nov 2025 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQTUj8J8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929A235CB8D
	for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476247; cv=none; b=RqFSl9nIgcE9EKz9MoXTYUTGYfWfRMnXjOrE1nPks318SN4f2nstVAAJ9yAE0b58p4cN9Dx84Sn4mXEeNPPFn3G4OJOrZmqjGC6/b5FavAmu2kZk57bZAUNP8O7maaoYVs63wUfaGbG0XTPKyKaM4xbF5j3u5FTXOipKmZJbdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476247; c=relaxed/simple;
	bh=RTlEDJM4zf3XzyQ52tNaw6SPf955+fUqtCKPTwoXrQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntUudPJiYx2knuAdwBArpcQkPORdfpHu4v36ymzsHOEKyK+1rVReABQrzJHJNmKpEpI+QkqQdT8Okb/4dEvX5MtVJblONSvhVB7KQ4150JQkJ6tK8xqbc5wvMuPVCYXifde0olO2z8ispcZTzeAxn2JmUX4T8PdKH0btrxhUUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQTUj8J8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30176C116D0
	for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763476247;
	bh=RTlEDJM4zf3XzyQ52tNaw6SPf955+fUqtCKPTwoXrQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SQTUj8J8NuYhBA4r+oFTFlBSiVn3h0LflTXRPsHN4tsyPxG3QXMcnG7hgQWl93SCt
	 f9KpSr+8aziGL5OC76/23YhFd/zSsu9gywEWtu6Z/BsdIrvWuriHuyd578rSCuJTmD
	 MzdS+gpqQ4rj83clSuXIze48aEYX8eNy2fohd+hNxll6Yw7gLMK1u+dTpnnKOf9CMg
	 JoC6CzPHMeRPw6NqxgpHNADZkyT3RwbeuuHjABQul0x1tpnN3Vm2Nqddl/nYlUQXJQ
	 rpIXYobk3UeChCiCKAZnYCKbAxOyL+d4vqxPgdZo8rdXqNunD7Pn9pm4x3P/TzN3pr
	 KjLQYece1fzlw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so8339830a12.0
        for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 06:30:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDtI1IpAx7wWn/zaGiZ17JnuYZS/eVudFBz9+pzEpfcsEr9m7fNkCF8glpwZc57mAar7eSGVJIw46t@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcsGjS6qcliAwW4rJz640c+9Ouasq8h1sn/1igbZ54IXQ4er4
	rWOacVK/m3D8T+vRasRTL9HOVx5NF1qliXy2hhmtQD0yJZ/IGR0rBchJ7qvru6NU6u5bdkvfOVg
	E7MGzS6dEmjFwDdV9tW2yE90AjQgFdMs=
X-Google-Smtp-Source: AGHT+IHOfmAsODieQa7yO4M2bltxnxticN5wrY4rmJ0f/xd2BfwCLb2KsFArM9McFCe/Rmo6VBZS2jwVdTYXAjI3ZD8=
X-Received: by 2002:a17:907:a4c:b0:b73:594e:1c47 with SMTP id
 a640c23a62f3a-b7367829b07mr1927862766b.26.1763476245769; Tue, 18 Nov 2025
 06:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn> <29e20a47-3752-49a6-8e3d-ae4ce9ffce5b@app.fastmail.com>
In-Reply-To: <29e20a47-3752-49a6-8e3d-ae4ce9ffce5b@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 18 Nov 2025 22:30:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7qmUUkRJ3N0rK_PwOHNsQi+FH6U70cJk+P9xZUA5pfBw@mail.gmail.com>
X-Gm-Features: AWmQ_blYOMjp62p0Ln1pKHregJFk-B2FIUKLy5PoapKsTA8UvsvBLTX8DYi2R6w
Message-ID: <CAAhV-H7qmUUkRJ3N0rK_PwOHNsQi+FH6U70cJk+P9xZUA5pfBw@mail.gmail.com>
Subject: Re: [PATCH V2 00/14] LoongArch: Add basic LoongArch32 support
To: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	Yawei Li <liyawei@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Arnd,

On Tue, Nov 18, 2025 at 10:08=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Tue, Nov 18, 2025, at 12:27, Huacai Chen wrote:
> > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > version (LA32S) and a 64-bit version (LA64). LoongArch32 use FDT as its
> > boot protocol which is already supported in LoongArch64. LoongArch32's
> > ILP32 ABI use the same calling convention as LoongArch64.
> >
> > This patchset is adding basic LoongArch32 support in mainline kernel, i=
t
> > is the successor of Jiaxun Yang's previous work (V1):
> > https://lore.kernel.org/loongarch/20250102-la32-uapi-v1-0-db32aa769b88@=
flygoat.com/
> >
> > We can see a complete snapshot here:
> > https://github.com/chenhuacai/linux/tree/loongarch-next
>
> I looked through all the patches, and this seems completely fine
> implementation-wise. I replied with a few minor comments, but
> found no show-stoppers.
Thank you very much, I will try to solve those problems if possible.

>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> I'm still skeptical about the usefulness overall and would warn you
> that you may regret merging this in a few years: 32-bit Linux is
> clearly in decline, and the amount of work in bringing up and
The motivation is explained by Jiaxun Yang, and maybe I should keep it
in the cover letter.

> maintaining another ABI (or two if you count LA32R/S separately)
> is substantial.
The ABI of LA32R/S is the same (I mean they are both ILP32), but
something is not compatible so we can not use a single kernel binary.

>
> In your cover letter, I'm missing information about running LA32
> code on LA64 hardware. Specifically, do you plan to add CONFIG_COMPAT
> support later, and do you plan to support LA32 kernels running
> on LA64-capable hardware?
Yes, Jiaxun is working on CONFIG_COMPAT.


Huacai

> I would suggest supporting COMPAT 32-bit userspace here, but not
> 32-bit kernels: based on the experience with x86, arm, powerpc
> and mips platforms that allow both, the compat mode usually
> results in a much better experience overall. Compat support should
> probably be a follow-up and not part of the initial submission
> though, so what you have here is fine.
>
>        Arnd

