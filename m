Return-Path: <linux-arch+bounces-9594-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE29A0194F
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jan 2025 13:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33603A33EF
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jan 2025 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881D5142633;
	Sun,  5 Jan 2025 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="rghK0G27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f8UPIVjD"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C6849C;
	Sun,  5 Jan 2025 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736078620; cv=none; b=LoNykHabxxuup32/BpDDRrdhRWf6NOBJdr1xvgTdkUiZAsXPKzHHbB0qacSdtJRLAEFskfvEXu3a4YV5Lb8D2l3tZMRWghQ241/5VoyOKJHfMN/pei6pV8fDjk55iblgIHhTPtr9sohA29mn0omAinVg2gFhxN2MRI58Yg5QOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736078620; c=relaxed/simple;
	bh=qLgcnB0EfIYFeMQmo+OT0UyQy5nfjeGSyg7091NPPUM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cd5AQFpjGH4DRAszvbsPQmeVG3Gg2HdCu7+FpIX2NFAh12GeTdHDE8qWv5hNU8EpBrgEf6LgKTK+7iL8T0QZNKdSJs8dKV7pbKJaawCYRRMuVy8T1LxZK7t1YcbPmxIONMzofQ2U2J7P7nerN7FyYIRMNoztUI3qEUhUq07m6I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=rghK0G27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f8UPIVjD; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A6E791140114;
	Sun,  5 Jan 2025 07:03:37 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sun, 05 Jan 2025 07:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736078617;
	 x=1736165017; bh=EfjD5baz6+eIzNQv3HaEdfLFYIFRwqkmgYmt55DTuoY=; b=
	rghK0G27tIe4XlLVjbclfwK2kO8fjy4BoGSpyRnzMSY5Ok7h6drng0iuj+DwNqaB
	/3Wgv/C7UemhJzrpfrNHgdgS8IVe3JxGNXU77XPcS4EodNnr05dJTdka/4HjXKJn
	2TrnvcgDrjL+Eu4MAU2ubWq7QVNW1ggMsy8sZowtoVIB+ksaKJDVIF+b5Ldd3Yhg
	c7iBlHVOCqiKZfJlyAwVv6cTBRVZP2lNO0v/0U3xH3Kw9rK51OL5o0qFcbt22DsM
	Hfo7EB3qbKFUPfETQn/ONSvMrvidBpf23++B/eyjcUylxCoiTe6YN30AXiIFkXR3
	86Yzsvt7lM7taMSaBwY+1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736078617; x=
	1736165017; bh=EfjD5baz6+eIzNQv3HaEdfLFYIFRwqkmgYmt55DTuoY=; b=f
	8UPIVjDzGlFUQD5j7rDcnZ7G2cQC6612BYxU/VYQ6AFceOBB7ssWhTtHH15o7def
	kIS2FthIT9V0GbYdXcQSMSZtQ+h0xI6FSRTlHcM/kg7I5qZKCmogVV3QhZuqBnQe
	Cr6XII6spQ3jKKZdJQxyZxhHkssTzI9cPpA5sg8yE6I8FGqU6okJslxZkOAnNMbI
	9cyw1QvdAvqOrP0nlEPY5A/uVFxRcNKz9AraapamElRqoDoeoT+LrQJK0BYg8c6l
	uW4IMBVD8eRJDviwgeDAbINmZgiyZbgH37Pzjoo3Sz5cW7qfJ1QgCgfGeyN8upBE
	rVCVAWzmQtOU8E52XHIlA==
X-ME-Sender: <xms:GHV6Z5q0w1c-wblx8Lp78yEY6uZU4NG6AyNXnkh6WTOUVc8x4KV6rw>
    <xme:GHV6Z7pdhISPUpsN5LksQWr0S7IHTVYIK_8VYfGyUZOLQiwP50K8L-A37Zchf2_Sf
    cLD4Ha0dRRHG750Nxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefkedgfeehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:GHV6Z2NcaQPRQ7ie25RpSlm4oGFKzOmpTO45_bdCm70RRyyaBF-2NA>
    <xmx:GHV6Z060BGfyEz74cD87Di5E4m3dyJuHFE6bgrTxYSfbwli1hNeB8A>
    <xmx:GHV6Z46dKi8bt6w0DmMGOM5x8BXrcHuF_9AN2BVAdcR6Zk2TEzhqjw>
    <xmx:GHV6Z8hFgUKoEZVJpyElUWMtMZ80ZyLXO-U103-VPM9FG1btm_enLw>
    <xmx:GXV6Z1t0TxEnYDrCCxpMhURYmLs5wk7CZNFScadZA5PrACcCkeZxOi2E>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 452BA1C20067; Sun,  5 Jan 2025 07:03:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 05 Jan 2025 12:03:17 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Arnd Bergmann" <arnd@arndb.de>, "Xi Ruoyao" <xry111@xry111.site>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <69d0df0e-9e44-4227-b2a5-02ce87b1de7e@app.fastmail.com>
In-Reply-To: <6b2e8382-e4d6-46ce-9d1d-02ddbae76ad3@app.fastmail.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <d4e4253b-1a06-499a-879b-e6b3c672d213@app.fastmail.com>
 <4504b10e4a0bfd09d9a3c719d234295bb638aa3f.camel@xry111.site>
 <2c46fc29-d24b-40b9-a64b-081a1f2a7a25@app.fastmail.com>
 <1def7604-634d-4dd9-a8c3-7168409a72cf@app.fastmail.com>
 <6b2e8382-e4d6-46ce-9d1d-02ddbae76ad3@app.fastmail.com>
Subject: Re: [PATCH 0/3] LoongArch: initial 32-bit UAPI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=885=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:27=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A82025=E5=B9=B41=E6=9C=885=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=
=E5=8D=884:43=EF=BC=8CArnd Bergmann=E5=86=99=E9=81=93=EF=BC=9A
> [...]
>> If both the ISA and the ABI get it right, it should be possible to
>> build 32-bit userspace that is compatible with both when targeting
>> a 32-bit hardware, but still use 64-bit registers inside a single
>> function when the compiler is building for a 64-bit capable CPU
>> (e.g. "-march=3Dla464 -m32"). There is a small cost in the calling
>> conventions for passing u64 arguments in pairs of registers
>> (unlike n32/x32/aarch64ilp32/rv64ilp32), but a huge benefit in
>> not maintaining two incompatible ABIs.
>

Upon having a closer look, I think there's an issue regarding having uni=
formed
ABI for LA32 and LA64. I'll call them ILP32GRLEN32 and ILP32GRLEN64 belo=
w.

If we allow interlinking, we must treat the upper 32 bits of all GPRs as
caller-saved, since an ILP32GRLEN32 callee would be unaware of them. This
could incur significant performance overhead.

Alternatively, we can disallow interlinking. However, this effectively c=
reates
a new, incompatible ABI. I'm not sure if it still fits our design goal.

Thanks

>>      Arnd
>
> --=20
> - Jiaxun

--=20
- Jiaxun

