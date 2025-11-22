Return-Path: <linux-arch+bounces-15052-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF881C7CF00
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 12:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 098D63554B8
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 11:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54C2F3C02;
	Sat, 22 Nov 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IX2e92f5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QnVaF7rx"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D192FA0E9;
	Sat, 22 Nov 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812649; cv=none; b=uZX48L8u+sbcxyhXKQtHnZzj5TzQojwdpN67lIgntGV7D+iNW9VzbqsLqTEJI5A9vuLYjZ4RmAJMG9lSTwGx3s4QnTn5DintDiq2m5mIZ37BZbR/VaD59p5D/1kNUrFEMqU5f3z/fIqcmTGrwiPjXHtxN3NhKQ+1K2QU0/a6wEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812649; c=relaxed/simple;
	bh=mZcm+0V7eo21fakAtLMCCoVtRwTR6UO4b55wipxHxyU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HJgWIzC7Emkdk+SinSk9g34o1qN2HNSVrJPsnPxGjDBGUfbmd6dnkTWc8CH8YlUc9Bo+YOydeCv/b0Fvo7CaOC0FJaJKopmxTHY+6g6lp5DSXNJ2AILL2FEYHNMBEvk8IKLNHNYx7Cl2V71JWcGm8K5bQJFtkid4Jdc/PHz89kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IX2e92f5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QnVaF7rx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 419A61D0014F;
	Sat, 22 Nov 2025 06:57:26 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sat, 22 Nov 2025 06:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763812646;
	 x=1763899046; bh=k9NvlEaBtVcuxazixF9pIt28NlkS+zYWHRHO9Ac5XQA=; b=
	IX2e92f5+iaQ86D2jXreWxxSWxbBioZMlPGfrxsQabrFtVK/xC8Zz8doXBr8I7eU
	2HINAkmkukeBbMHObYXxHOgbn1wG6LfFBz7qIW2b0ruor/iBbAc92yawVVBKQF5m
	v79BFLQO2hWwslq8uiMP1HtuNfgT+kJlfcWRN3SLFW20eT3P1eF+gh8Nd/HpPT3S
	SKqk4usy7cD5wp0FqTlTkqXiHubeCyXKfc1t3MT+SiuTxgvduKplE4pWM5mdQRFb
	huzeRgAIvA8jTy4TEucER2K1ML6EmUEpXcFKJzcRIhyDEKUtQ7y6uSfEM5wgAPQQ
	mYfwLFZQ9dKF1kMAFQXu+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763812646; x=
	1763899046; bh=k9NvlEaBtVcuxazixF9pIt28NlkS+zYWHRHO9Ac5XQA=; b=Q
	nVaF7rxc6PbmPBfAMq2MxEAkQ5kJ0ljrP9ZBxfFBTmB7XfxDj+Dx08pE2/1uybaK
	jKIRsRGbPENyhnbbdWnWPPnUqu2GkwTbAiCMRnBhzxYgfGyJZgyCWwUed/luSPyA
	w9Zpm2eSnWlwogcGjzZmAP0hORER50xy7i7Kjk0soocJ49TZUKDEME2MjgVLh1Aj
	Aw5N9cohxQSvuYBKBqS8ToFtHf3HAI+TQzs+Ez9HyNduhf2k8/c2pQjh9Vsq8F9o
	GC4py4/tDoaqocfoBfbOCZol/4n8vi1k8HaC+ReOBZcrzfzP7wud+DLgXm5TvO5O
	6JZs16zL6rTJsnu5Es4Xg==
X-ME-Sender: <xms:JaUhaYA4D_re064N8xBZx_6CWup3r6PzaewaJKRFZR-1NRHXHh3YpQ>
    <xme:JaUhaVXizBZGdoSgw_N3Puuypy6SFZh4y5EdKosujDzYA53DSEqKr4eoX0h9lioek
    m8r2kweNxCYsOke71Z5rJGJm7e_e9wu1Ejj0AlBl11xkNVXi7smBOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtg
    hpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    uhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthhgvnhhhuhgrtggriheslhho
    ohhnghhsohhnrdgtnhdprhgtphhtthhopehlihiguhgvfhgvnhhgsehlohhonhhgshhonh
    drtghnpdhrtghpthhtohepthhhohhmrghssehtqdektghhrdguvgdprhgtphhtthhopehl
    ihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JaUhabmA01_oCrg_ln_mfVLcfi9v3yxmUootQDWXBk4PmApGjxMySw>
    <xmx:JaUhaXAVsq2zvBJjyEpd968TqtUCypSrfCZjJvPifteV4_UD5BOpDA>
    <xmx:JaUhadOC0GCsl5zwx35Awfjrz7CB3k3V7J4JUapq31bg05QTEVxw8Q>
    <xmx:JaUhaePLTYV1k-WEoHRxWdGNydDf-m5InXB2JSPnT3qKqsjAF8M8sA>
    <xmx:JqUhaXvD5NsX9ahRx1UeHmyPoYVRNKamBSgWLWnvvLHiwfMepON79V2o>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0151F700054; Sat, 22 Nov 2025 06:57:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsIcsmVbKmaR
Date: Sat, 22 Nov 2025 12:56:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 "Huacai Chen" <chenhuacai@loongson.cn>
Cc: "Huacai Chen" <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org
Message-Id: <3407d536-a9b5-48e8-a9cf-4bb590941d0a@app.fastmail.com>
In-Reply-To: <0b2bf90e-f148-46ad-92e4-b177d412fd11@t-8ch.de>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
 <20251122043634.3447854-14-chenhuacai@loongson.cn>
 <0b2bf90e-f148-46ad-92e4-b177d412fd11@t-8ch.de>
Subject: Re: [PATCH V3 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025, at 10:45, Thomas Wei=C3=9Fschuh wrote:
> On 2025-11-22 12:36:33+0800, Huacai Chen wrote:
>> Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
>> loongson64_defconfig (for 64BIT).
>>=20
>> Also adjust graphics drivers, such as FB_EFI is replaced with EFIDRM.
>>=20
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>  arch/loongarch/Makefile                       |    7 +-
>>  arch/loongarch/configs/loongson32_defconfig   | 1104 +++++++++++++++=
++
>>  ...ongson3_defconfig =3D> loongson64_defconfig} |    6 +-
>>  3 files changed, 1113 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/loongarch/configs/loongson32_defconfig
>>  rename arch/loongarch/configs/{loongson3_defconfig =3D> loongson64_d=
efconfig} (99%)
>>=20
>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>> index 96ca1a688984..cf9373786969 100644
>> --- a/arch/loongarch/Makefile
>> +++ b/arch/loongarch/Makefile
>> @@ -5,7 +5,12 @@
>> =20
>>  boot	:=3D arch/loongarch/boot
>> =20
>> -KBUILD_DEFCONFIG :=3D loongson3_defconfig
>> +ifdef CONFIG_32BIT
>
> Testing for CONFIG options here doesn't make sense, as the config is n=
ot yet
> created.

Right

> Either test for $(ARCH) or uname or just use one unconditionally.

I don't really like the $(ARCH) hacks, nobody is going to build kernels
natively on loongarch32, and for the rest it's fine to set the option.

> Also as mentioned before, snippets can reduce the duplication.
>
>> +KBUILD_DEFCONFIG :=3D loongson32_defconfig
>> +else
>> +KBUILD_DEFCONFIG :=3D loongson64_defconfig
>> +endif
>> +

This is also not the change I had suggested in my review. I think this
should be a fragment along the lines of arch/mips/configs/generic/32r2.c=
onfig
and arch/powerpc/configs/book3s_32.config.

See arch/powerpc/Makefile for the integration into the build system.

      Arnd

