Return-Path: <linux-arch+bounces-2732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67274867A73
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996E41C2469F
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E427612BF04;
	Mon, 26 Feb 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDxVS0q8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D212BEAF;
	Mon, 26 Feb 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962032; cv=none; b=n/wr0d2PaDruVpVlnqpNnZDK63R2c+y1YtfMI7GCjpEbxj5uNR2JFAEE4bimPzyMIR39r9TNu7DhCdylPzvEFKv2GKqH+DMmDeCg3erPmiwPHNd2PlARirh7T5BocvOGHHnsA+GH0qx97BDTzlxt3vT1Ed8+dwb4YZdYyzpCBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962032; c=relaxed/simple;
	bh=LqdZVF/5a5y9c7R0XJh34mAsJKHFvghTFVi0Kr3+2NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwC30FoeTXpKO/dNmwnO9GJXrNSRMXrZmgKg5AQFX/95eUR5VX2+WuDrRFU5OvLCLo7scsCVKbYanCm7Vo3IcpmhFL7qX2sTUAr0dT/t56SSBHZU0LN+NI3Ic4sd6jQNH3uVqMBjziUVb3/8SZEFRVhHhhrqNuGEv2KUFW+WdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDxVS0q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C92C433C7;
	Mon, 26 Feb 2024 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708962032;
	bh=LqdZVF/5a5y9c7R0XJh34mAsJKHFvghTFVi0Kr3+2NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDxVS0q8Z3vpInLZ2QGBmd3bVTIaQVmD0Lg1FYweLvPwIbiCpQkMP7ZsWJjB8XGxz
	 gzfyUh1+Ri7hI47ZLD0r2BbaP4NKvMOkYaCvn8A6uukIq4ZRgoAEGku8/mMxhNqzkA
	 yvH2C6zhpPfy58dvkw+7jlsSzx5UfhYSmHsA0+tq1nwW+D9zb3A5R/sPl88jfUmX1O
	 C2bPKjjaN4znMiobBOe3M/Kr19GSPeS6tZECdBbtUYH87T3HRdbua3LgIychQrhL6L
	 E4SFQz52hUoq8sS6Y1U0lSrRsoxaUm8Lk/mld0Yd6oJw3qUFfKO2RjYMYTv722TFJQ
	 aki7mnG1lzw/g==
Date: Mon, 26 Feb 2024 16:40:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <uwu@icenowy.me>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-api@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xiaotian Wu <wuxiaotian@loongson.cn>, 
	WANG Rui <wangrui@loongson.cn>, Miao Wang <shankerwangmiao@gmail.com>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Linux-Arch <linux-arch@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Message-ID: <20240226-sandbank-bewerben-219120323e29@brauner>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
 <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
 <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
 <20240226-graustufen-hinsehen-6c578a744806@brauner>
 <ef732971-bf70-4d8c-9fe8-3ca163a0c29c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef732971-bf70-4d8c-9fe8-3ca163a0c29c@app.fastmail.com>

On Mon, Feb 26, 2024 at 02:46:49PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 26, 2024, at 14:32, Christian Brauner wrote:
> > On Mon, Feb 26, 2024 at 10:20:23AM +0100, Arnd Bergmann wrote:
> >> On Mon, Feb 26, 2024, at 08:09, Xi Ruoyao wrote:
> >
> > What this tells me without knowing the exact reason is that they thought
> > "Oh, if we just return ENOSYS then the workload or glibc will just
> > always be able to fallback to fstat() or fstatat()". Which ultimately is
> > the exact same thing that containers often assume.
> >
> > So really, just skipping on various system calls isn't going to work.
> > You can't just implement new system calls and forget about the rest
> > unless you know exactly what workloads your architecure will run on.
> >
> > Please implement fstat() or fstatat() and stop inventing hacks for
> > statx() to make weird sandboxing rules work, please.
> 
> Do you mean we should add fstat64_time64() for all architectures
> then? Would use use the same structure layout as statx for this,
> the 64-bit version of the 'struct stat' layout from
> include/uapi/asm-generic/stat.h, or something new that solves
> the same problems?
> 
> I definitely don't want to see a new time32 API added to
> mips64 and the 32-bit architectures, so the existing stat64
> interface won't work as a statx replacement.

I don't specifically care but the same way you don't want to see newer
time32 apis added to architectures I don't want to have hacks in our
system calls that aren't even a clear solution to the problem outlined
in this thread.

Short of adding fstatx() the problem isn't solved by a new flag to
statx() as explained in my other mails. But I'm probably missing
something here because I find this notion of "design system calls for
seccomp and the Chromium sandbox" to be an absurd notion and it makes me
a bit impatient.

And fwiw, once mseal() lands seccomp should be a lot easier to get deep
argument inspection.

