Return-Path: <linux-arch+bounces-9591-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E91A015AF
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 17:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293483A2A6D
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9D1C1F23;
	Sat,  4 Jan 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Z+3Mxv6O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LLeae78G"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77118D63C;
	Sat,  4 Jan 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736006690; cv=none; b=m0Xd+kZLy8WXKXfUhLyD9cWhUf+HqFTlG9/zuHzA7WACIgrqbnq7g8RzOws6iMyZq78s+C1ieZXG/uiApEo/KwX+qoV+1QQwPTdG8hgbQTSlAoxHE8YJ5K6dMI7tArvT5XTeB2209Jj4hZrQjYyFxaGfDjW/8pTtmEv3JcKyePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736006690; c=relaxed/simple;
	bh=BYWuQOobYtzbqVNm/mUQZ0i8mHcYkwaT5YmcQk+SfNY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=unuNLqAJYCdicHQmhQF05MX428/rzmb+8Qzr/oTW5ndG8udqe3cUGV4ZxctBW5LXnWqCMPp258RwmpMwCY8jzVCTMqi52dZwU/FqBk72Gc6M4kz7df6CCscIGoA2HJT9aIvEAHg8f0cpR6k6ce/Q0BFJuhMRTpGOVEMTwAoTHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Z+3Mxv6O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LLeae78G; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D8AD25400E3;
	Sat,  4 Jan 2025 11:04:48 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sat, 04 Jan 2025 11:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736006687;
	 x=1736093087; bh=Mbyt44dZlLEFYJcdZCno5wcqIFk9L+FG7tKjRc1DPL0=; b=
	Z+3Mxv6OrY1ZXMvbsxgkZwMaV+XTM3FXMDAVmwgFCmPwFF9oGcB2oGTrXbzpEJc/
	taKN9Rch1LFmB6+LsOKuWb+4QeskX5yj9nptILi1IZyNy5Css+UKNZe5gNi9ryuq
	lBGrwsYNpahZOPl9qOl2qgwQDmN+zHsmtuatcjUV7hA3Sj9Dr86L09nQtCEskk4y
	KHAz3HjP/j+CaXg75FdEntX7yBvUrfwlJjkjb/Ud7nIrurkJLn0rlvgmc49KjIfp
	3oIeIdYgA1uvrKdWw9HVhJgG7fC7a/k9c6DuKmih7eJSab/CAtonLKHK63qxUvTX
	vwakXayhZsG9ti+fI5TbtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736006687; x=
	1736093087; bh=Mbyt44dZlLEFYJcdZCno5wcqIFk9L+FG7tKjRc1DPL0=; b=L
	Leae78Gl2Ly8X5jLPvZuap7WINhXEfOQCQHgDsFF/2XWyATyd/r/PTdJ1Q4Tyrue
	390TRsR/VwcDuoQDrvJO26Ivs2uvTuCah1/lQYVTv2v/+bT8utFYSFmlsL36ON4B
	hF0T8We5lfoOdFmLnD0GHW0bw9Fjfqpw2v5xtjU0tbGw4cEunnk/SWSzxw3eTNks
	nhJ3RHr65B7qB1euE9ktEP+8H/gMrotY1C3NphN4neajL5iYhE/ySMhnZxkvpyGr
	zJCUoZmgW33aLySt8ifUBJ43hWKkx5Xemi3xI5oP9zCikHrv+BImVfysYxXYn2bv
	Zmd113z4XhG7h+LGcUMgA==
X-ME-Sender: <xms:H1x5Z54mFmLoHs4ayECVWiMoplEf-uYdKcu-gv1DwmaDgQHdLAcW1g>
    <xme:H1x5Z26Bvo8-gQog0bZz0WN4cmRoVRHSevi2jfrwL2mXnaomdXz1aZ9FuDZT03A8T
    1LK_h2FSHy63t3SCoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegthhgvnhhhuhgrtggrihes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdrlh
    hinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgvpdhr
    tghpthhtohepgihrhiduudduseigrhihudduuddrshhithgv
X-ME-Proxy: <xmx:H1x5ZwdILgnBBWO9piJxa_WWJ_B2nj5z6brwlfCnIMHgWtl02jv6sA>
    <xmx:H1x5ZyJhwjr1Scb587vjIu2yG1h3lPT4XONw2r0K6Det5Et_VXf88g>
    <xmx:H1x5Z9Kro-szBv1CmUHziZ0Ivhve59OLgmzzoc_Odi01Ff3_kz_Nng>
    <xmx:H1x5Z7xwjWMNrdzgXeqSZCGTOoMou34l3J-j_DR6R3Izi-KlEwQF0g>
    <xmx:H1x5Z19v8n5mHpW_yqP9_ESHv0fw_AkwBTb3J0BfQ5hSLHRcfWuqcjTC>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1162C1C20066; Sat,  4 Jan 2025 11:04:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Jan 2025 16:03:29 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Xi Ruoyao" <xry111@xry111.site>, "Arnd Bergmann" <arnd@arndb.de>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <2c46fc29-d24b-40b9-a64b-081a1f2a7a25@app.fastmail.com>
In-Reply-To: <4504b10e4a0bfd09d9a3c719d234295bb638aa3f.camel@xry111.site>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <d4e4253b-1a06-499a-879b-e6b3c672d213@app.fastmail.com>
 <4504b10e4a0bfd09d9a3c719d234295bb638aa3f.camel@xry111.site>
Subject: Re: [PATCH 0/3] LoongArch: initial 32-bit UAPI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=884=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=883:13=EF=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>=20
>> I assume the MIPS legacy means that a 64-bit kernel is going to be
>> able to run the same ILP32 binaries as a 32-bit kernel running on
>> pure 32-bit hardware, similar to powerpc/s390/x86, but unlike
>> riscv/arm?
>
> LoongArch has instructions like addi.d/addi.w, instead of addi/addi.w,
> thus on 32-bit implementation it's simply addi.d is missing, not the
> semantic of addi is changed.  So I cannot see a real reason we cannot
> support the same ILP32 userspace binaries compiled for 32-bit hardware
> on 64-bit hardware.

The only concern is the behaviour of PC relative instructions will change
in VA32 mode for LoongArch64 systems, i.e. address will be signed extend=
ed.
However I think this serves ILP32 purpose well.

>
>> We need to be careful in defining the ABI to ensure that this covers
>> all the corner cases, such as defining a signal stack layout with
>> room to save 64-bit user register contents if there is a chance that
>> a 32-bit userspace will end up using the wide registers when
>> running on a 64-bit kernel, but also avoid any dependency on 64-bit
>> registers in the ABI itself.
>
> Yes such issues are nasty, we'd already need something in the calling
> convention like "on 64-bit hardware, in ILP32 ABI the saved registers
> may be unchanged or changed to the sign-extension from the lower 32 bi=
ts
> of the original value."

Makes sense to me. For MIPS the n32 (ILP32 for 64bit) ABI has a new set =
of
UAPI definition (also mandate 64bit GPR). While the vanilla o32 ABI is 3=
2bit
only, which disallows any 64bit instruction in user space.

When I'm designing current LA32 ABI I actually have o32 ABI in mind. How=
ever
LoongArch64 hardware is not capable to disable 32bit instructions alone.=
 So
if we end up doing something like o32 the limitation of 32bit instructio=
n needs
to be enforced at compiler side.

So I think the question would do we want to allow 64bit instructions for
LoongArch's ILP32 kernel UAPI. We can either go through MIPS's o32 PATH,
making 32bit ABI truly 32bit, or maybe reusing the UAPI for ILP32 on 64.

From Guo Ren's RISC-V's compat work and arm64ilp32 I can certainly see
the benefit of ILP32 on 64. Maybe we can bring that to LoongArch as well.

Thanks=20

>
> --=20
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

--=20
- Jiaxun

