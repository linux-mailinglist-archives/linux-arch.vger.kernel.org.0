Return-Path: <linux-arch+bounces-9584-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A402A01414
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 12:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53B97A1CEE
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5966E186E2E;
	Sat,  4 Jan 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="qiz7oWqs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZgAVRzs"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDAA932;
	Sat,  4 Jan 2025 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735989518; cv=none; b=mSi06KidTRNBZdVQxVkDwbhs7sXh3Mv45ZB9WSLFSpyhbQlBvxFgcRME/MKZJUhSupLHR4ZPlSd6fC2ZwOakn3ULEzltIqKdJYDA4M5ERrbKR6NRQutTeNMh3+RxIl08fBPxIJgQfDvd3TITtbq9biNCrByx66PkI6/T4md9slw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735989518; c=relaxed/simple;
	bh=SmaysFuZ96LuQ65wTE3BBxozBy8PBLsgn9KY9pnpn/8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pZTFmNH70IToSZUOUSr5LaL7V3TyXUQ9AXeXDH5ziiq725rBHhsjOeOI4rqLRz2hH764gW/T/gZZrY4+9AU/jE4MihSGDIQm0/SxWI1fT1Hj3X6/FrMbI4gRc668M1B+yd0YoWznjb7xmWHalFU1w/N2SdJZ7S6g97YY4SK1MTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=qiz7oWqs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZgAVRzs; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 42309138020B;
	Sat,  4 Jan 2025 06:18:35 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sat, 04 Jan 2025 06:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1735989515;
	 x=1736075915; bh=OWAb7sjW0oE21T2vi4FtjeJPiBdGprSVhTIcNjmJhsE=; b=
	qiz7oWqsLV9xsCRW4sLcTd+fWOYJy2ToYvsYAx3aV6zyysobd97Liep2eb2P4wYk
	Cc/Zco0aaZ6e8iuZYCHpgIEHTmGrU/fhnfPYyoJFObpjnc+/ue/W3/CGQWlNUB4j
	SfdOHNwsiiNEIJYqD1D2iTgUCe2e6RwLun/rIIca2Cbeb8+tO6aKYEZYQ/uhJfqm
	hAtc9346yIPYxjXpiMKbzuTyNd8YGHTZ+d/Q1czkzlBcHuzWpIg3WUexPxmbO6Je
	np/UNeDzPrkmxRAIbBZwPJBlwAijmCKxwZuPEQ01unM7RDotWGP/lFug48oWUKx7
	payArVlY7rl14u+SsbxWsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735989515; x=
	1736075915; bh=OWAb7sjW0oE21T2vi4FtjeJPiBdGprSVhTIcNjmJhsE=; b=T
	ZgAVRzsidYQ2GHUrkv9VrO4v9AyT5fBbHglUh8d8/Q5BP8mqfYuy6YwlQ9nldLfY
	jFo7Gzrr8WCyjFLDOjSrQtH1b8wCgUMs5e9tSWQdMsXvz7fD8yTtlZhBte/lRkUH
	vuWCQcUYDx+nO2FJQCa716i1NSJ+Fnpe4COT8DlgrTprxjwCGuUCWmXUzqATQT11
	6wEjHHnGDhYLuoLJ5O7gwgynhVvmV6LwEExlASoI0H9ndnIRyP1rf0uyvr4XDlNE
	4wGVVoEzy8FDRMx3dTT6dvGrs9HQeJ+DcUZl3eE5sMSOJ1va7vkQRX5lI/PGR22g
	0c7RdL79yTdYeVfy8dQ/g==
X-ME-Sender: <xms:Chl5Z9f0_8XIYUO-XbJU3SWdFIdg_5fbDFVEDjEXCCV2VYU04D6B3g>
    <xme:Chl5Z7OFHrTPJomb6oVO67zBFr9Nxm6kLFrhZNJJTm7B7I_btx0wsxKJhU42nwiVv
    GFeyxU6BvoNfgW0Hmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefiedgvdejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:Chl5Z2gXgo_BJiMitYe-Nvcefu63RRvAAgKpCLy7abPTQcenracCUA>
    <xmx:Chl5Z2_TLgSzPoIeYXdlraG5mxKRfGMhtFX1uuGShtilyyi655tO8Q>
    <xmx:Chl5Z5uEfUKzNIVMnueSFtr6Xl7oNmAqaGlgPeXRW5J6dcA3D27uuQ>
    <xmx:Chl5Z1FUXz64ZH_68JC9QccQUJ0lGAxH-VOnMKn1moweh1a-tAF1NQ>
    <xmx:Cxl5Z9g9wII4AkTtXfB-lHloWudEq8XuCc_k9womY1pNmqwVnL87wxNx>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 58DEC1C20066; Sat,  4 Jan 2025 06:18:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Jan 2025 11:18:17 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Jinyang Shen" <shenjinyang@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>
Cc: "Arnd Bergmann" <arnd@arndb.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <f8769713-d9a4-4057-8df5-f1ea57707ebc@app.fastmail.com>
In-Reply-To: <c47a9589-bc19-4e0a-866c-08e022e89539@loongson.cn>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
 <20250102-la32-uapi-v1-2-db32aa769b88@flygoat.com>
 <c47a9589-bc19-4e0a-866c-08e022e89539@loongson.cn>
Subject: Re: [PATCH 2/3] loongarch: Introduce sys_loongarch_flush_icache syscall
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B41=E6=9C=884=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=E5=
=8D=889:04=EF=BC=8CJinyang Shen=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>  =20
>> -# No special ABIs on loongarch so far
>> -syscall_abis_64 +=3D
>> +syscall_abis_64 +=3D loongarch
>
> LoongArch64 need arch-specific syscall, but LoongArch32 needn't?

My bad, lost in rebasing :-)

>
[...]
>> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
>> index ebbdb3c42e9f74613b003014c0baf44c842bb756..723fe859956809f26d6ec=
50ad7812933531ef687 100644
>> --- a/scripts/syscall.tbl
>> +++ b/scripts/syscall.tbl
>> @@ -298,6 +298,8 @@
>>   244	csky	set_thread_area			sys_set_thread_area
>>   245	csky	cacheflush			sys_cacheflush
>>  =20
>> +259	loongarch       loongarch_flush_icache	sys_loongarch_flush_icache
>
> Can we use cacheflush as arc, csky and nios2?

I think cacheflush syscall is more or less an outdated design inherited
from...MIPS...

Exposing flush of other cache levels to user space is not wise in securi=
ty
perspective. The design of cacheflush syscall is also not vDSO friendly.
riscv_flush_icache is designed to avoid those drawbacks, and we should f=
ollow.

Thanks

>
> Jinyang
>
[...]

--=20
- Jiaxun

