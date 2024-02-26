Return-Path: <linux-arch+bounces-2719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8376A866A58
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 07:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0982B211F6
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 06:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F81B951;
	Mon, 26 Feb 2024 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eC5LQlMC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DT7FJBbR"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217EF1BDC3;
	Mon, 26 Feb 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930695; cv=none; b=eWzLH0Jb7WO84DitpOi0HJwyf+2kg4QjqnoGX6DhAYf16cibFYUSgSqF0ciQEVW6Lb/wGn2+4353MwxEqeo3McILluA/iHfERn1Dl1dscF4wya0QF5A+sfJeAwmkBOr2szFQoAlTA6GoW2ihhx0z+TuuX8+Hk5zngKprdSrFxc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930695; c=relaxed/simple;
	bh=YvskMQL6vh3LHIbEKjAML+XytC66oTun1i9E9paZEoA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Kv25Dmt+c1jYFcFrs9JpKuNftCzUvi8s0isQOZn7AQLXyiA75kvkPOmU8CCkU0EmGvEap5E+ivNpTwgkC4al2bCZtB9pvPWPX0IXvM+jK4y5FA41nKjk3Zu1JGTHdbvk7QgVHvKMKGqiRS3zhu7rkPJBTdHmGUyjjpp3Ty1IEoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eC5LQlMC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DT7FJBbR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 480DF1380083;
	Mon, 26 Feb 2024 01:58:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 01:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708930692;
	 x=1709017092; bh=JF2cDLEh4oupc3MOcy1bJ24fHuVp+oZVdvi9yntqhTs=; b=
	eC5LQlMCgf6UFx421hPwE1Ne2iCquVkJzx/vOnsyi+GVCrjGuQkJxIoVqWBNd5FV
	h1opcO/GgjifYyckc+tPoUdMSIV6D4D8zYKXpDRIJOK6zYN8kaJ5Pnzgzb3E7Qca
	MoTXP/h68V8uJxvZ49opRfs40Jeg9+RfQRHgzLg56uY669E6ssWCunPG9Xf0G8XA
	BMcjPCjlAvL0tSzsFqHh9wwFjZeW/z5deSfXP7JhmXYL2p6tws4hg2moHj6Fgcl4
	OBaOPIfv07n7u41Ymjq6VACPL2vAowlGIfS1SZkejVMuNetC8BW22W3XjsurjDwR
	STgVsFDZe1bLi/BdhueaaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708930692; x=
	1709017092; bh=JF2cDLEh4oupc3MOcy1bJ24fHuVp+oZVdvi9yntqhTs=; b=D
	T7FJBbR7x0v/24ipJPfItK+0hxVcbs9Xky4ADQNVeSFADRu1FnPUM7OrcJ9qre62
	4nazByWE9ms4o0ZdldxeOVdyswtBGgW9N+dApv2OnY71STv7f4TGEIShKqFyWs57
	iq01PwXw6BxSqw7Kdl6a2mWnK9gthJz8OOlWty5Q8vEixZYFPWohFrMZmAUvQ4NU
	HRGe+SBThMSeKF+uvLnGz9mqNbcDNk642dZIHm8V37BgKJER23hONWAdsG9z3anD
	V5aXAh4elNvOl+w3A/FfpLxLjmktMLf15+7Y0qYVNBzDiw0WPZpCVfpCqfgyTCk2
	LCmJ2S7fDu2aUaZaJ+3Mw==
X-ME-Sender: <xms:gzbcZbDcvKWLVESyuSYP-WAejrVYdKrMTvlhDn79x4twC6XLl2fRUg>
    <xme:gzbcZRgz5pkSn6ffhBHC0VwX75hEaZy1qgdECraVPJU5QegE_BDQdiXwKhLpijTvP
    kzzqGM8gUBgwinBJDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffkeejkeevveetfedugeefgffhjeeihefgleffhfegleeuffduheeijeel
    geeuhfenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdgu
    vg
X-ME-Proxy: <xmx:gzbcZWmpazowYXdJH3A35_myKG16ol1yv6nV_hsK_S3pkwuw14PRVA>
    <xmx:gzbcZdzjuhmReXfuYQCxnt3Musutnwrcb2sYbHjXMEmU-o-lsOe-_Q>
    <xmx:gzbcZQRxXvCIgOUwnNgi1O95bsjvsOeuX3WTaqs2ViqFxMcnbc74kA>
    <xmx:hDbcZcoi5ftvkS__B4edMHkfsG_cO5UpTXQrj6mW2TFegUkWFWLYnw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 61857B6008D; Mon, 26 Feb 2024 01:58:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
In-Reply-To: <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
Date: Mon, 26 Feb 2024 07:56:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Icenowy Zheng" <uwu@icenowy.me>, "Xi Ruoyao" <xry111@xry111.site>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>
Cc: linux-api@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "Xuefeng Li" <lixuefeng@loongson.cn>,
 "Jianmin Lv" <lvjianmin@loongson.cn>, "Xiaotian Wu" <wuxiaotian@loongson.cn>,
 "WANG Rui" <wangrui@loongson.cn>, "Miao Wang" <shankerwangmiao@gmail.com>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024, at 07:03, Icenowy Zheng wrote:
> =E5=9C=A8 2024-02-25=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 15:32 +0800=EF=
=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
>> On Sun, 2024-02-25 at 14:51 +0800, Icenowy Zheng wrote:
>> > My idea is this problem needs syscalls to be designed with deep
>> > argument inspection in mind; syscalls before this should be
>> > considered
>> > as historical error and get fixed by resotring old syscalls.
>>=20
>> I'd not consider fstat an error as using statx for fstat has a
>> performance impact (severe for some workflows), and Linus has
>> concluded
>
> Sorry for clearance, I mean statx is an error in ABI design, not fstat.

The same has been said about seccomp(). ;-)

It's clear that the two don't go well together at the moment.

>> "if the user wants fstat, give them fstat" for the performance issue:
>>=20
>> https://sourceware.org/pipermail/libc-alpha/2023-September/151365.html
>>=20
>> However we only want fstat (actually "newfstat" in fs/stat.c), and it
>> seems we don't want to resurrect newstat, newlstat, newfstatat, etc.
>> (or
>> am I missing any benefit - performance or "just pleasing seccomp" -
>> of them comparing to statx?) so we don't want to just define
>> __ARCH_WANT_NEW_STAT.=C2=A0 So it seems we need to add some new #if to
>> fs/stat.c and include/uapi/asm-generic/unistd.h.
>>=20
>> And no, it's not a design issue of all other syscalls.=C2=A0 It's jus=
t the
>> design issue of seccomp.=C2=A0 There's no way to design a syscall all=
owing
>> seccomp to inspect a 100-character path in its argument unless
>> refactoring seccomp entirely because we cannot fit a 100-character
>> path
>> into 8 registers.
>
> Well my meaning is that syscalls should be designed to be simple to
> prevent this kind of circumstance.

The problem I see with the 'use use fstat' approach is that this
does not work on 32-bit architectures, unless we define a new
fstatat64_time64() syscall, which is one of the things that statx()
was trying to avoid.

Whichever solution we end up with should work on both
loongarch64 and on armv7 at least.

    Arnd

