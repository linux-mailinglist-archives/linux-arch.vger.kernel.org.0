Return-Path: <linux-arch+bounces-14886-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67419C6CDA8
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 07:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C53F4EFAD1
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 06:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2A3126CE;
	Wed, 19 Nov 2025 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="XbCE5UAx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nFk9lyy2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487062D6E44;
	Wed, 19 Nov 2025 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763532207; cv=none; b=MTLEKbaGSTYURUtZ6m+rWLh3njXVuSudm+jWCOuII2tbKdjSZ15dzFFZ12/Ph2wuJ3OakGw3iKVFhKxEMqQpMg5oLSZIiHiRFOE4SVk7NXjK7yI/Dx4WS2cIz+Ih8Kz3thvnvj/3crjhuMzlwgbYfXoGCd0BuUA0kxXIhip/66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763532207; c=relaxed/simple;
	bh=W1vOcYg74ooxfJY5nvz6IM63KW7ZvhVMyoJo0Vprsnw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GH84wweiJLHI+8jKGy4ZRWeMCu8dCjvTzyHriVZE2KEvF0KaPKRl2oEOXKClr0RIA9GJtOMDCOeRZEBYOxvdSTGUpgcRkULbi0tGL6bCz5+SwBRztMH7J7X1VN2bzJhZJUDjtLdlUQbWuHOIggVRp6A/On80nls/Fubk/AZ9lqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=XbCE5UAx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nFk9lyy2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 373927A010E;
	Wed, 19 Nov 2025 01:03:24 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Wed, 19 Nov 2025 01:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1763532204;
	 x=1763618604; bh=jUSoJ6fafuXmWl1wBQP5lDmyx0/SWetJ2BhVKFAnETY=; b=
	XbCE5UAxNQHX2p6uAsBpg2lLcQEPqDxwmY70/yZqsOjpx4E+jIxxKjJU6c3h2kzV
	ecBbT7B8JkWypzsV4w5zZCoc7Vzy3b59QeaC3iU1pWtNNidOacnjeNDoJTI7TLRN
	R+0cnPVZu5+iT+bSbSOk3W0tncXH3lgREqGSFDR+mxvNepmXGhTqPrxvyUc1kSz7
	+inEPjQ4Um8rYPjIdozcaF35RA7oZJWhew/RTQ9HIW8zFQt82HEnAlfBUke5L9Jf
	wqeOYYi41xoHb4+6x/3j3O7w3t/Iu6A6I7ZiTHl/aMmJQKSNx8A/UgKPVFyS3qx3
	e34wQFexDDki9iBrELz1IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763532204; x=
	1763618604; bh=jUSoJ6fafuXmWl1wBQP5lDmyx0/SWetJ2BhVKFAnETY=; b=n
	Fk9lyy2pcjGYnq3/Ag1Qe7wMvXMW7Vq4tJca4qNB1mVWxe0qD1r+olEdDc9NE9oi
	uNtBKRc0nE/r/kKlRPbkgfUKtcCUw7BWklWn6KWcVkLvPaP+MHztaoVeAu3P7q7D
	tPWN5in6RuEfqCKnVn0f8Dt4JWVTW5gY4fUM6EliXZcXxhCvvq5U0S9wCWWx3BHw
	lYiNXfAC7vGIA1pnnwJ44MseAWF1nFneSH4uV6s9fmElblrX5v+TjPdM1+uYznXn
	mWwEsCgicVVkjKkTRgLZW1pHN2wBQvZHM+SsPqcMMxqlG1fRtTj0mmgAHAYxZUdf
	2M8oh9g0o9N30KGSMDNIw==
X-ME-Sender: <xms:q10dabTXgVCKAIPYZlQK12LY58KmEcLDcoUorBwaByrkKoWFtU3EFw>
    <xme:q10daXljk7wNss50kjwjTjTA43DpfE8g0y_Z3TcdNvtiDnWKVd5nCIJrV8hTbt-Sk
    rLo4VQgTzOq72wkwWdKvpd-IPuZ9aLj19RiGTvKT5RgAsuA3HITXu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhirgig
    uhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhephfethfdutdeigeelueeitddtheehudevffejtedtkedvueei
    tddujeefieejieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghp
    thhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnh
    gusgdruggvpdhrtghpthhtohepfhesughishhrohhothdrohhrghdprhgtphhtthhopeii
    ihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtoheptghhvghnhhhurggtrghise
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhorhgvnheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvhdprh
    gtphhtthhopegthhgvnhhhuhgrtggriheslhhoohhnghhsohhnrdgtnhdprhgtphhtthho
    pehlihiguhgvfhgvnhhgsehlohhonhhgshhonhdrtghnpdhrtghpthhtoheplhhinhhugi
    dqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q10daV41pg1jI9OyqXRZr9sQPxDxks9TCoAsWLQ06c8syyC9JVrdog>
    <xmx:q10daeuXkJf4uHyykVN7g9E7CWBILrnQwInqGQ7hzBjsREq15RCQ9g>
    <xmx:q10daX0KAxDKIzOPNwluDv3gCz7kDxFhAn0rL1uZjYSjQIN5vz1NEw>
    <xmx:q10daXoCotB6U1u5JKnfMKC4WnqQpO_YVEp6n_dtW5G2DfpLW8lkAg>
    <xmx:rF0daWNfHx91cc2sZqyBHJFde3svh-iaxe-gNFzv9J8H4AkakH_oXeMK>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 259D12CE0067; Wed, 19 Nov 2025 01:03:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMQGwR9H1XIg
Date: Wed, 19 Nov 2025 14:03:01 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@kernel.org>, "Yao Zi" <ziyao@disroot.org>
Cc: "Huacai Chen" <chenhuacai@loongson.cn>, "Arnd Bergmann" <arnd@arndb.de>,
 f@disroot.org, loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
 "Xuefeng Li" <lixuefeng@loongson.cn>, "Guo Ren" <guoren@kernel.org>,
 "Xuerui Wang" <kernel@xen0n.name>, linux-kernel@vger.kernel.org
Message-Id: <04b04b74-ef13-4dd0-a35a-d629acb617cb@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H5uoDjBRYpK_e7Z+vrcqLAbLXhEbEQP_aJ9f3aTdA+-eQ@mail.gmail.com>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-5-chenhuacai@loongson.cn> <aRyoLBjD_8Hz91DV@pie>
 <CAAhV-H5uoDjBRYpK_e7Z+vrcqLAbLXhEbEQP_aJ9f3aTdA+-eQ@mail.gmail.com>
Subject: Re: [PATCH V2 04/14] LoongArch: Adjust boot & setup for 32BIT/64BIT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, 19 Nov 2025, at 12:28 PM, Huacai Chen wrote:
[...]
>> Per the schema for LoongArch CPUs (loongarch/cpus.yaml), "clocks"
>> property is also described as mandantory, thus I don't think such
>> fallback makes sense.
> Yes, "clocks" is mandatory in theory, but sometimes is missing in
> practice, at least in QEMU. On the other hand, if "clocks" really
> always exist, then the error checking in fdt_cpu_clk_init() can also
> be removed. So the fallback makes sense.

IMHO this should be fixed on QEMU side, but I recall QEMU do have clock
supplied in generic fdt?

>
> Why pick 200MHz? That is because we assume the constant timer is
> 100MHz (which is true for all real machines), 200MHz is the minimal
> multiple of 100MHz, it is more reasonable than 0MHz.

Maybe better panic here :-)

Thanks
-- 
- Jiaxun

