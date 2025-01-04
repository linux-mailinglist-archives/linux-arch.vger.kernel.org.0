Return-Path: <linux-arch+bounces-9590-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D9A01596
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 16:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D00216287E
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163E1C3BF1;
	Sat,  4 Jan 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ALqDXrKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XwKjc87f"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA021C1F23;
	Sat,  4 Jan 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736005411; cv=none; b=cS34PczMxD1qVA2bAaEDiv1zWqbvOCnREH7jq5zeiZQSaGuwg5K1vTQHB4/Xk7+tsDlVzzSTafd0adKo3YAnio0CozQA8EKCvyCzNyMgomLBWYHPJaWoDpqExz8xFk9OMOrk27keh10sHIYilZOvPiHCqMVy5uH5aI4ElWC13dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736005411; c=relaxed/simple;
	bh=/MoTeM+WXhbhErpVL46QMXtZoOpgGIyJx/cNIuEWx/A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s0EvF6uk9/x4AZFmOPOktZbZQ6oLqMrdnLKpTXnslNOSbnSHAjGAe9QiTHVvonrO1zoJRq//nLeGa00R6vYW/BJY/+p1guZVAsQN689nol8Dl3Fh05Iedvsuhun2uY+tnOg9xKlO3WZGDffIX1PaYZgRk5hcFGuGBN0bLbp/2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=ALqDXrKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XwKjc87f; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 54FC3114011B;
	Sat,  4 Jan 2025 10:43:29 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sat, 04 Jan 2025 10:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736005409;
	 x=1736091809; bh=ZY2vwJ+PT/TNPIb2gb36fT35alFp36wB8j7DvuEx3To=; b=
	ALqDXrKb55fuAOhLBUlXsQnwqGKZFkP28lApQKw/6dzmyXo4zO0Vp2SM0FPzRdFO
	b1aj/ZNFdTJTG3/sT5pVmVvmGP1uGRANEmhwbyA7aLHWfJNIeOiXdgnUXs1WFzCZ
	SI2bQ7s+01sx8GJuweCNE3TlYS/MFFvgNAqSgCl9FnpYdn+5EpI09tn6eRbQK/4b
	DEB9HPubL3m9dCCmyh21B4I670ozM2u8JWYZ/PRUzIkx6ynSZ1RuHeGjMBqRi+rJ
	J5fi23vJ2n7jwjtzE2FUmyjSjgOIkJAmjm6Nd5otIg6lbzF+wcdgaqKu441Dq06r
	T+HGV/XNqGOprQwe3rW1YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736005409; x=
	1736091809; bh=ZY2vwJ+PT/TNPIb2gb36fT35alFp36wB8j7DvuEx3To=; b=X
	wKjc87faBDdL9M4jjISx+M87YBCmeKbW/zFx1TcdhYjqv5uT/riXt2fqRs5fa62o
	IyejC6puEs9ahR+7Po0EdXo0QNJHNhBWn/eCMnpdTIegZ0lvc/P5LxTiHBJUexJX
	F2CFtZuAkLP66Of/1HBGxDyuT62ftU9j3/tDw023WSpm/bacCwS8gjbepNDXQvdB
	wqH54jWPKeFNlxixl1UBZVUArvVp+NFICHK8S7PxKwaQd00iwAql0aup7PHCmRBQ
	rIWtheoUE7jR8MOI+p3cmYZR+K6lyh+I1C5xLs4UOwmmG812z+7LU0BmVLMqLlRE
	A6hOr2yDeE49iN+Xj2DIg==
X-ME-Sender: <xms:IFd5Z1tirE-ChhBnIdXc7nM8WZlrkVIw5CwXnRf1NFooOpc4D-yWgQ>
    <xme:IFd5Z-e-nappDulr3rOTWwra_Jx-6UU9ybf7kOQNivzcHdniqh9ATVR68hGWBLMyE
    ci5IaTMwvLLbkZKbTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedgkedtucetufdoteggodetrfdotf
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
    hinhhugidruggvvhdprhgtphhtthhopehshhgvnhhjihhnhigrnhhgsehlohhonhhgshho
    nhdrtghnpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhgvrhhnvghlseigvghntdhnrdhnrghmvg
X-ME-Proxy: <xmx:IFd5Z4wqAqUvsjJvYT2ZZIdz3wH99SRiG2cUTBmYLtIRtpnZVTNCjA>
    <xmx:IFd5Z8NRGRq0925lnNfJvxlzOaC1nEv1xcpz-5Kk9PrytgeiKkDZVg>
    <xmx:IFd5Z1_GRJJOv2QE7t7YtRqt2Xf7uAw9lQ5azpTXR9ub68g42BxsJA>
    <xmx:IFd5Z8Vs_NOWMg4MekGKtBb_J-_d1HK6kBqeD4FC-iz1BWygYDswmg>
    <xmx:IVd5Z1wUM_BqmXZgLGpWwXXqaErxtBaOBzm2f-JIuacYo7J829Czeah8>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2F5BE1C20066; Sat,  4 Jan 2025 10:43:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Jan 2025 15:42:51 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Arnd Bergmann" <arnd@arndb.de>, "Jinyang Shen" <shenjinyang@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <e82f8eaa-39ea-4d64-90a8-e2edd3769a9c@app.fastmail.com>
In-Reply-To: <fbde518f-ffea-40dc-ab11-f37b7bd1615e@app.fastmail.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <20250102-la32-uapi-v1-2-db32aa769b88@flygoat.com>
 <c47a9589-bc19-4e0a-866c-08e022e89539@loongson.cn>
 <fbde518f-ffea-40dc-ab11-f37b7bd1615e@app.fastmail.com>
Subject: Re: [PATCH 2/3] loongarch: Introduce sys_loongarch_flush_icache syscall
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=884=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=883:07=EF=BC=8CArnd Bergmann=E5=86=99=E9=81=93=EF=BC=9A
[...]

Hi Arnd,

Thanks for your comments!

>
> I think for consistency with other architectures, we want start/length=
/flags
> instead of start/end/flags.
>
> The meaning of the third argument is rather inconsistent between
> architectures already, but at least the second argument is always
> length so far.

So this is actually designed to be aligned with RISC-V's semantics,
and thus all arguments are aligned with RISC-V.

IMO RISC-V's semantics is a better design that we should take, as
I replied to Jinyang above.

>
>
>>> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
>>> index ebbdb3c42e9f74613b003014c0baf44c842bb756..723fe859956809f26d6e=
c50ad7812933531ef687 100644
>>> --- a/scripts/syscall.tbl
>>> +++ b/scripts/syscall.tbl
>>> @@ -298,6 +298,8 @@
>>>   244	csky	set_thread_area			sys_set_thread_area
>>>   245	csky	cacheflush			sys_cacheflush
>>>  =20
>>> +259	loongarch       loongarch_flush_icache	sys_loongarch_flush_icac=
he
>>
>> Can we use cacheflush as arc, csky and nios2?
>
> Agreed. I would also use the number 244 instead of 259 here.

259 is also selected to be aligned with RISC-V.

Thanks
>
>      Arnd

--=20
- Jiaxun

