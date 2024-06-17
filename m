Return-Path: <linux-arch+bounces-4940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D587090A624
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 08:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F881C25DDB
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7DE1862B8;
	Mon, 17 Jun 2024 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RAK1/bkL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIiiLBFG"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56C17C7B3;
	Mon, 17 Jun 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607222; cv=none; b=Uf93jI0CDLX507gwPBxkeV+NqjOm0w1t/fBkXOLsSYTYamaYC550xo1l/Bm8OFjvl23cNiksgFb0tiF1JtlTySEyYIEeJJPEIMczIDd+LwjCEmkQAIxHzh7fQXvQLvn++LAqBwC36/qcB5e3AeDCBch55FPRHl1ZXruSnf4tZ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607222; c=relaxed/simple;
	bh=HMhxQrMvqhxThBZMHTW2DHWQNufej71aVz9xF7xevoY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=fIQoSuXelITMLN8vshF2AGBIieJM9/rmeUeqiIghb0hRC+BlYNjg0yTmA5+YU4wfagK/89I55kkm1vT8ZqdphnMLmXndb3FetOkdZWU9GkQify4mgefP19Yk5bYTOCLnzQlIUj8S0IbMAo1ulNclfM8Lw08RjGYhk8MnkLB2yI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RAK1/bkL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIiiLBFG; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id C6C841C00063;
	Mon, 17 Jun 2024 02:53:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 17 Jun 2024 02:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718607219;
	 x=1718693619; bh=GSghH2pGRZY52mc9Nnpt/iaApIrYJkTOUDPXGN87ZU0=; b=
	RAK1/bkLXXdzhoxtzur2KOZgv1xIcdw7UM0NkLGD4DoqnrAny11zDCzbj9LgtfZ/
	N9W53tLZd/1oaG+/x1nEjcgIp11PBemwv0eUEIkHQsgVRTRCSqH0FElTiVVwsDQo
	TOKxG42ulgjspEGeGBD0W3WWbp3Ev4lJsp47db5GOnF/DWkLJ9HfPT3A2QjmCJXH
	b7MQc30Q5n6BJwy7+lTkfocnH1frV9NAUJiVv3ruutsN5xI9oqUYoIy2HVxUDz4r
	gwEF4VwealGgBNROSQhLGKhQdOStMGQRp9iZveaxSBRFhscLdqoKLQL+XlIw68Rx
	vm0CcalxFRA6Uv6OBYRBcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718607219; x=
	1718693619; bh=GSghH2pGRZY52mc9Nnpt/iaApIrYJkTOUDPXGN87ZU0=; b=f
	IiiLBFGhZS483HDigcAvBs7UqE3myYVnxVe0RE4jk/YwKsWCgaTqGN2U6zqwOi5O
	CqYhGtijE3LUmAYIAAQodOhRyLbpFJnAMp42aiWXOEi7CcCttpL8TB7pv1qy3QRP
	EhPP/IC/ciRpeJczGWeQK45+JlMvZsEf+a4Pif2Aq9Nl9gJeqjjrHreeO8+Sr1Bk
	DxcZ8pVWbIYMNpZqOrXz4O0cWWKak10mw5b/jYGKv1d/CWY52rSvI5zTW18etzJW
	sVOkt8NAoSDZagqFDBji/pD+5Bh6Pa3uo+EXi7tcZ/HqpENNpxgBEcCGJPFEgcpw
	tKdUzA8Cv/wVG4KrRxCEg==
X-ME-Sender: <xms:cd1vZv8HRk5x7oZzuWR4fCr_rzNvsR5meCOAV2f78VS_fV5mEXEK8w>
    <xme:cd1vZrudCgjJJYD4-KjGjm9B9L1BcUu4VkqBHwwyXvfvUGGDE9ayaI8E3AUPsZ12f
    HhaGeIfkDlwCgIOhmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeuuedujeehgedvvddvjefgkeekudegffeuiedukefgieeivdefjeehvefh
    heduteenucffohhmrghinhepshgvrghrtghhfhhogidrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cd1vZtCC_3_-mUKmHnnZmEIGsVyA-4D88iPYGxl9AfV60NKuX4ffLw>
    <xmx:cd1vZrf-9EvkBAtAqBXfFrm3GWaz6W2Js3Ft9RYoO-5UCfHBd0HwUg>
    <xmx:cd1vZkOiIDN4FUkZYySZcq6Z8kyyQgXEn94oE0hpK39yiBfx9eEmUA>
    <xmx:cd1vZtnkV0eqVfpX0CWZFEj0mATNwXpcZcPAQ-vaAkkS0zLqzApRDA>
    <xmx:c91vZtnfBB5Bfsia32vJMRD6-SdXefEoHHJ5TqWN-l6WLzfmo6flsq3a>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 97BECB6008D; Mon, 17 Jun 2024 02:53:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b783ee7b-1d27-4793-91cc-ff9d3f4f2103@app.fastmail.com>
In-Reply-To: <c2b1ca127504e519c04a36179ba6c486f2ec0a08.camel@xry111.site>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
 <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
 <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
 <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com>
 <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
 <cdef45d36d0e71da5f0534b3783b81c82405bda3.camel@xry111.site>
 <CAAhV-H4R_HJAB0baqUgA8ucbwWNVN4sc9EV91zAk9Ch302_7zg@mail.gmail.com>
 <56ace686-d4b4-4b4c-a8a6-af06ec0d48f2@app.fastmail.com>
 <08ff168afc09fd108ec489a3c9360d4e704fa7dc.camel@xry111.site>
 <a70e8b062fc422e351fe2369b9979a623fa05dfa.camel@xry111.site>
 <4fd0531d-e8f8-4a4c-9136-50fcc31ba5f2@app.fastmail.com>
 <c2b1ca127504e519c04a36179ba6c486f2ec0a08.camel@xry111.site>
Date: Mon, 17 Jun 2024 08:53:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Xi Ruoyao" <xry111@xry111.site>, "Huacai Chen" <chenhuacai@kernel.org>
Cc: "Huacai Chen" <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024, at 08:45, Xi Ruoyao wrote:
> On Mon, 2024-06-17 at 08:35 +0200, Arnd Bergmann wrote:
>> On Sat, Jun 15, 2024, at 15:12, Xi Ruoyao wrote:
>> > On Sat, 2024-06-15 at 20:12 +0800, Xi Ruoyao wrote:
>> > >=20
>> > > [Firefox]:
>> > > https://searchfox.org/mozilla-central/source/security/sandbox/linu
>> > > x/SandboxFilter.cpp#364
>> >=20
>> > Just spent some brain cycles to make a quick hack adding a new statx
>> > flag.=C2=A0 Patch attached.
>> >=20
>>=20
>> Thanks for the prototype. I agree that this is not a good API
>
> What is particular bad with it?  Maybe we can improve before annoying
> VFS guys :).

I can't come up with anything better either, the problem I
see is mainly that the man page has to explain both AT_EMPTY_PATH
and AT_FORCE_EMPTY_PATH, which are very similar for compatibility
reasons only. We would clearly not design a new interface to have
both, but we can't change existing behavior either.

       Arnd

