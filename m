Return-Path: <linux-arch+bounces-14874-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38072C69A58
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 14:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5CBB34E02C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4C327204;
	Tue, 18 Nov 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KvIYD0vF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MixAv3b7"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4730E822;
	Tue, 18 Nov 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473326; cv=none; b=dpCPrUwYIMOENfHBo2j/8RD9DVJSkB1IqXfK0md0H0iDJsGF/Mmli6Je2dZNcMXE0+3HjloNxLTV86sa4Ux9OkyzN899M+PXc89D0CwbGHhhumyLcUKiMxu8Fe3+AapzqBEmuxWLz3BFvksmrO2B7opiCUFbKA4asQ/hEpxGv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473326; c=relaxed/simple;
	bh=1vKkiuCv3tF3FDXYU/cgFuNSWlR2vYn7x5Rk3J5TQGI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fcDRod6wkdqwb3AeSvqaO0gHkT4GN6/yLjY+LeiTz7dwmiWrXPjWQ7o1SSwvZZ/1aEOmjfBwFGfOLJi/MyxClPmiOJHDf3nBO1wuARucv9D4YYb2be7mJJGJXaK66lw0UnTWn46i9DpSBdM5MYM6ej7acasDUOQw0N0yxkizVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KvIYD0vF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MixAv3b7; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5910A1400315;
	Tue, 18 Nov 2025 08:42:02 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 08:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763473322;
	 x=1763559722; bh=0dWNaPFbuwXQuyveDoRET9j1iGRCuWn48cS4ouwo/t0=; b=
	KvIYD0vFPgGSF5oLMxIz1V6ocFAvWZxXzl8jfPRfuKCXTMoz24Hm/ZQd3ezHg6uw
	4iCV2PFTdqJnkIFDNzXt1OOsM9HA7/XrSoDqfLUgjuiEVPS811JShZIF4yJVyecM
	o/3wzb1p0D3ISKBnFfWMaN88A/vkTRbNCK4DL7eH1xUFx79LRsJXkaC95/sSi78Q
	R0El4KTrcI6pL0HIgCakABYqU2KbEDzKBy0ZdnjYlPHc9TH/iz4Spr/2oRdAzrRl
	yUgFqbMdNwDyKxh1neXKQvP04gSHYngAUppK+g7Nq3rRbkTFezlDPK4zgFLOzltC
	ApnaVJfn8GEaCGBZ+dENVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763473322; x=
	1763559722; bh=0dWNaPFbuwXQuyveDoRET9j1iGRCuWn48cS4ouwo/t0=; b=M
	ixAv3b7Nrq5Oeph2Ot6/aEM2/1Fyy0fICwTNUOq3bHT9xZWpZQxBpUTq6b9Xv2vn
	RG4ZiGTr76KBCeQbT/BfWHc6H4MeV8LvD2x6PQpcTX+Wfse/i2lEUfjbK9LB1qHq
	CkW8rL6HYaWxNZ6oChZQXJQopJfA1c1gxph0Zzghar7m/96HVRgio+/vAkaaw/3c
	fKcQmo0vobtChMDfFTtQ1VO1l0xbDRehuKJUWuHvSV+ziepfKXalZsROFicWAblb
	UVk+wfF1u7Uxl+b+zLHyhFJcoetMuz1/rzFhrsnAUZmopPOsTWYzWBlyFbfY7z/Z
	ZlQckEo3ocvZnhd6Tf8KQ==
X-ME-Sender: <xms:qXccaYGFvfYvE9EMQRWWcLMsszOchIl9a7IuooOxnIpQOPLCQhLdsw>
    <xme:qXccacKRHiG5Ae1J2eEyKu-Aon76DcXNdV8YNyEvcRLo_LwvE8NDUho08QyfAJJAu
    uF8vsAwtBwH9z8GRMiAyC9zanFiVGzHN3EyLSRRTHv-KOAiaexkoOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtph
    htthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhu
    ohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhonhhgrghrtghhsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhvghnhhhurggtrghisehlohho
    nhhgshhonhdrtghnpdhrtghpthhtoheplhhigihuvghfvghngheslhhoohhnghhsohhnrd
    gtnhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgv
X-ME-Proxy: <xmx:qXccadEnfU0Lfsn6mnPj9u_oSayKSuUyHWQCQfx-auZsJh7RiUnrqQ>
    <xmx:qXccae6gh9qmPYPYYJxNcKtc_yZ1W8-pWCWJWFCtt4G_kiSGKhOHcw>
    <xmx:qXccaTmSYxnq0yWLHUjYdFrnVFKP1AJ3yyYTOi7EQXQpuO9fC9gxHA>
    <xmx:qXccaZ55xa8sd0gjgP0OTdqFV_gKtr0Iy_48GYDNfWZMyspiXeTpQg>
    <xmx:qnccaZkqZEkzck9hKCc2brS43T0MVzxspdNe-oUknvkuQvOX9j4ns1Qn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0DDAA700054; Tue, 18 Nov 2025 08:42:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWKx_ip9zbKJ
Date: Tue, 18 Nov 2025 14:41:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org
Message-Id: <4155a60c-81da-4c23-8a66-9a748b3383e4@app.fastmail.com>
In-Reply-To: <20251118112728.571869-13-chenhuacai@loongson.cn>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-13-chenhuacai@loongson.cn>
Subject: Re: [PATCH V2 12/14] LoongArch: Adjust VDSO/VSYSCALL for 32BIT/64BIT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 18, 2025, at 12:27, Huacai Chen wrote:
> Adjust VDSO/VSYSCALL because read_cpu_id() for 32BIT/64BIT are
> different, and LoongArch32 doesn't support GENERIC_GETTIMEOFDAY now.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Are you planning to add vdso_clock_gettime() later, or is the
architecture missing hardware access to the timer register
on loongarch32?

It would be good to add some comments here to ensure this is
done correctly if someone adds the vdso32 support later:
There should be clock_gettime32 support, but not the old
clock_gettime(), clock_getres() or time().

       Arnd

