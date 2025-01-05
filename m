Return-Path: <linux-arch+bounces-9593-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03153A01902
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jan 2025 11:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95EB1622A4
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jan 2025 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5591B143C7E;
	Sun,  5 Jan 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="tt5MYjJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qfRwb+V0"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A36146A6C;
	Sun,  5 Jan 2025 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736072867; cv=none; b=D5z5hsKrtxzeWb5tPVSoEtmksJO2Vmzntsl15MwF6pslJq9zyrtqGsJa1UNfRdFa52HqsRDwe8lmmKiKwqNylKANhHxfueYaiaRCudUWhZcLPO9yHa+3EE9ARwuEcfUOxllnISMp7KJFWpirHssL1+fnb+L00udaUe9Iqh60mU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736072867; c=relaxed/simple;
	bh=LumO54xb4PvWPCsNyzkj5esTUjMh0Jw6Auw6d6itl6s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OJjxtSL3RXDEBn8K+XLpBEcJkJYorwFhnXXrSHINvzzikuptbTq4zGI36eSk9tQaaJ4InEUSSVgdN9wjsUQoqXUMABOOaTnwjpC6nBTRTh2ow+IfyznxWYU2wh4XkWOKXS1AkV2QS4ouaemvwv8OY+dklk05QFokB6cmOFU/WXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=tt5MYjJB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qfRwb+V0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 695791380205;
	Sun,  5 Jan 2025 05:27:44 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sun, 05 Jan 2025 05:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736072864;
	 x=1736159264; bh=4MHYEFXb+4RGhNVFfN8LWwXnp30QH818yjdgmV/ObBg=; b=
	tt5MYjJBsFaj7gjNGATT5yf1ajE+w/i6loSlIJ8M3Xnify36gKehOzGC83oW/f/S
	8Aj/LnQSHZtfBdBPErE5gK0Jfb3ogjdz25CMVRqbHzTll86DcMP0YlbeklY6RuWn
	uvx7//FORF9h3MPTcQ+5a4gobCoVp/Vrkc68GFegteTL9DNa7pJu5bJb1o9ABw3p
	kpvkNPT5uVM9lYziJ97392vAbdNLcf/lRopWPg8bbO1Y7u97DAzR5a03CWP+DbCA
	EplREcESs2/bdWGf/YvQgbD9+UG5ZekcVumKj1RQ8DGK6UUb0cm17CDYxX7kf2ZN
	pOEWNHn+UMdI+/ylpKlnmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736072864; x=
	1736159264; bh=4MHYEFXb+4RGhNVFfN8LWwXnp30QH818yjdgmV/ObBg=; b=q
	fRwb+V0wiqRZug2oB0RYLkUlH8D3OazcSiteiQUobHur71hBJzcxLu9ViB7cH7ph
	zF3mTLRc8ftNBvs7O51KjyRZkD0bZlPk6PS47OTVmRdTtdHkepr49YVi3P5idMw/
	6UefF6RkpvIzVOnboE8DI31gCcMDcm9XJoXvc4YM4S8NHXdrNGCmJpdDl4YNy2JB
	7qYTKB+8DPvNYUkc6lKz1qYvz+BpWEDHQ0g08xIHmhCXlnjuppRzbna1QqWs4NCX
	2YfSGpPGDyeROLsCoVuO9ZZ1hvDolE21Lf5e6aRUy4R56xNx4aEW8F9f+2jp6n31
	nzCU/8STerkZ7CU6JuPHQ==
X-ME-Sender: <xms:n156ZwLX33DpKjJQRoaArBNpAQkCYZiIL6CVjcyJn4KijBnHdEHHeQ>
    <xme:n156ZwJ0SGS8Yyekw1e_XA29HOaGUPSfFY-Ndp1EZ4ZEN-gzZlJv0Y7QdC9oxwBrM
    MuJ4dd9mRnbDHXVMKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefkedgudehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:n156ZwuJS3DRR5J0NEQHZ37fH4e1DgSEMHhI7KsK9BwoDhruNlJ5oA>
    <xmx:n156Z9anUNIt3bYuI0vYQ1YrcaZWwiToWmaVEnai2hznv0oPOgofNA>
    <xmx:n156Z3Z-rYyOUZd2tkFX0wX2Z4odH6JxMt3QyV3EEa4hB_PtYbsWFQ>
    <xmx:n156Z5B4Ky8K-TTz-HO2kO5PfdhEsjsY_0ZYWNVvIVTTd7MlKr3oVg>
    <xmx:oF56Z8MA2UDT77bGIwcNq7RTtGsbPr_g2cU1uZnqW2ekKaBoNAZ34yYp>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C50731C20066; Sun,  5 Jan 2025 05:27:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 05 Jan 2025 10:27:25 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Arnd Bergmann" <arnd@arndb.de>, "Xi Ruoyao" <xry111@xry111.site>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <6b2e8382-e4d6-46ce-9d1d-02ddbae76ad3@app.fastmail.com>
In-Reply-To: <1def7604-634d-4dd9-a8c3-7168409a72cf@app.fastmail.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <d4e4253b-1a06-499a-879b-e6b3c672d213@app.fastmail.com>
 <4504b10e4a0bfd09d9a3c719d234295bb638aa3f.camel@xry111.site>
 <2c46fc29-d24b-40b9-a64b-081a1f2a7a25@app.fastmail.com>
 <1def7604-634d-4dd9-a8c3-7168409a72cf@app.fastmail.com>
Subject: Re: [PATCH 0/3] LoongArch: initial 32-bit UAPI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=885=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=E5=
=8D=884:43=EF=BC=8CArnd Bergmann=E5=86=99=E9=81=93=EF=BC=9A
[...]
> If both the ISA and the ABI get it right, it should be possible to
> build 32-bit userspace that is compatible with both when targeting
> a 32-bit hardware, but still use 64-bit registers inside a single
> function when the compiler is building for a 64-bit capable CPU
> (e.g. "-march=3Dla464 -m32"). There is a small cost in the calling
> conventions for passing u64 arguments in pairs of registers
> (unlike n32/x32/aarch64ilp32/rv64ilp32), but a huge benefit in
> not maintaining two incompatible ABIs.

Thanks Arnd for elaborating this!

I actually more or less have this in mind when I was designing this ABI,
thus GRs were designed to be 64bit in sigcontext. But I never look into
that closely.

I'll try to explore that option, maybe come up with a COMPAT implementat=
ion
first.

Thanks
>
>      Arnd

--=20
- Jiaxun

