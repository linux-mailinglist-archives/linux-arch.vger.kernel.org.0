Return-Path: <linux-arch+bounces-4426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3078C6892
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429C11F235C5
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1470E13F459;
	Wed, 15 May 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qUW0E3IH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbiCqNfi"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530313F450;
	Wed, 15 May 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783160; cv=none; b=TmB9IxIC0GQCLVWB8lMUprWmFQUM1x7r4pBmmjSCPY+hz8S2PcbMqG3Z/u9dO2f0GJUC1opOJGe/x4Nqg3j57/Fg3WJgtm8dA6Alt7c8C5X+PCb+wCfbHogX/4v0TEv55UxhEzPdTWfY/La+MQ0Q29qR6QkZ1BmPUWF6rypFUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783160; c=relaxed/simple;
	bh=v0x+DpEEQ/CULK66tGCdFakqHf6CBwbzeJc6dtqG+8g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QnMUR+EaR3BH+RtPT2xS0Gaxb5BS54Rn3LnH+HjO5OPhEwDyDHum0RUPGDD7TBzFri1XYI2qoZKYs5gdKjamOi2vlSFsyojTw2qUjx0mhK8ipMYKBz6Dx3rcLZluMkOWJRNn+EketzZdrlGqVh8MTnb7W5BEFQhzuawx+L43xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qUW0E3IH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbiCqNfi; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id BD2AF1C0011F;
	Wed, 15 May 2024 10:25:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 15 May 2024 10:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1715783156;
	 x=1715869556; bh=VYHmieqUmmpUUBGaoj5sdegT+mtMw56IFZEbX0OZWos=; b=
	qUW0E3IHNV0pMPfRqgt3mn0hnA8AU1orLPsgNR0eNOGBxcuNTg3SL/qTJRCCP6kP
	Xui8DnRR4yqxxl3JMLgAvGSiWr0XrOolLOQyp86RNtqeEb9fw5wu0y+nDO1OsTVi
	2T7DqYFoxMQa2FCkCyJ/1yRHcRCPGTR8eSeFUb9jVU2aIcFl0zaaUbNfINpOcC4Q
	59M8mVWNVfZLFsb/QXGUevN391ZYCw/b+voZqxwrn0tZlfI/uLHdtn6sLk52fZgS
	nECiNlthidEQb4PpjMg0QEp50ubzSOXXLTUbfkvto3CAY82cWNuQVCQLjHi/qDcL
	ncIiJVj/+E/IJRUKXRQilw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715783156; x=
	1715869556; bh=VYHmieqUmmpUUBGaoj5sdegT+mtMw56IFZEbX0OZWos=; b=J
	biCqNfiVIax+RcCdhhNfmby2OPYHVF7LWKY7r6n8K/T+KRi7Uh52540l96Ad+XiO
	ERixAx5aV4eQ7LI0sLf7BDSyvDo86KCXkaCw3DH5wzobEo5eq50pDoLYBFnhOWat
	e9S0D5m3ZiBtSDvE2D0+YSL/3uoiJa5jQpIREvianAscw3E1P/d8m6vskqoeYuWM
	2pkcqursle3l1LSA1uP3e9X5miby8ZHOG/6aN3NKP7TOUO/wWkmT12itJsHYiAC3
	iDtzW2VBOE93gSQIm8EZatH2OoZiGriTMfiGB4iT7PkaZlqq9ca+rD62Au3n+ClU
	e3EYrozltGACD81fU3zDQ==
X-ME-Sender: <xms:88VEZoTdUKmTrcPG2c6voHcpRiC-Od89384GN0_rJhqWAq8ka4QnuA>
    <xme:88VEZlwFGbQHWrqAmxTghND0O3mPmrBXy9jDUbdA1F18l8XwLZ2b3KcEGUnYPODUy
    dSKRIWVMQGga_J_Dl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:88VEZl1IqNmRq9DlG7cKJVIOlix6oQfEknqQ_DlZAfuNbc1WYoKevA>
    <xmx:88VEZsDJSX4kacEqo1M0zNJLMWLI9XtdAensOXh6WAW3n3pPu8ssVw>
    <xmx:88VEZhgr8cnFpel30Fg1F9ZA9AnYr_rlZmwe9OI2YxqSqIXPUXKQOg>
    <xmx:88VEZoqFbbPnfc9LPvtAMDO6BWdU08Lv0xMMide6EtGiYKki_jfVfw>
    <xmx:9MVEZsoO-OoTCATxnm_eq2u9bS3zpPI2lvIwcqnhyQvjkC-iYO468hVA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 23041B6008D; Wed, 15 May 2024 10:25:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-455-g0aad06e44-fm-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebf493ee-1e8b-426d-bcf4-d8e17d10844a@app.fastmail.com>
In-Reply-To: <3937d6b1-119b-195e-8b9b-314a0bfbeaeb@loongson.cn>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
 <3937d6b1-119b-195e-8b9b-314a0bfbeaeb@loongson.cn>
Date: Wed, 15 May 2024 14:25:28 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bibo Mao" <maobibo@loongson.cn>, "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024, at 09:30, maobibo wrote:
> On 2024/5/11 =E4=B8=8B=E5=8D=888:17, Arnd Bergmann wrote:
>> On Sat, May 11, 2024, at 12:01, Huacai Chen wrote:
>>=20
>> Importantly, we can't just add fstatat64() on riscv32 because
>> there is no time64 version for it other than statx(), and I don't
>> want the architectures to diverge more than necessary.
> yes, I agree. Normally there is newfstatat() on 64-bit architectures b=
ut=20
> fstatat64() on 32-bit ones.
>
> I do not understand why fstatat64() can be added for riscv32 still.
> 32bit timestamp seems works well for the present, it is valid until
> (0x1UL << 32) / 365 / 24 / 3600 + 1970 =3D=3D 2106 year. Year 2106 sho=
uld
> be enough for 32bit system.

There is a very small number of interfaces for which we ended up
not using a 64-bit time_t replacement, but those are only for
relative times, not epoch based offsets. The main problems
here are:

- time_t is defined to be a signed value in posix, and we need
  to handle file timestamps before 1970 in stat(), so changing
  this one to be unsigned is not an option.

- A lot of products have already shipped that will have to
  be supported past 2038 on existing 32-bit hardware. We
  cannot regress on architectures that have already been
  fixed to support this.=20

- file timestamps can also be set into the future, so applications
  relying on this are broken before 2038.

      Arnd

