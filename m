Return-Path: <linux-arch+bounces-3890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C618AD155
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 17:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C6FB25FB4
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE94153560;
	Mon, 22 Apr 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ALn6xlHG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YUVxInp6"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E696153514;
	Mon, 22 Apr 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801359; cv=none; b=KYz0CWffLy9Qf8KdIF26+OMCcTkKbULf8Pq6iooBBZKZbvronG9K8x88+LQ3A3aQ7imYqy3s8R49L2imorNSNbYjaHfJO5LP1KKJLvwly2EhS3ckYK1vsH0uJzIT0fJvoYFeRiuB26g5bp03XZxFFbon2JIdEWSOHqykJB4qTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801359; c=relaxed/simple;
	bh=9I4+qB+/XalnNvDY0Lu/NgvbWxoEth7z2LMxfahexxM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PsUbFQtQDjSWePcuBmjIFw5m0OuqnqPQnPU5aZcprQ2ZxI25RbL2cc+QjtqNgEBOqZ4QmEJMo/SGVDxsWaAY/nch61dmaK4bfbFkn5y1JBpeNhRQvkJpUV+HkjT4SJDaVumA/N2DBD8gzpxGJ3x04ZqvQxnWb8CLW9y8sjS/V6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ALn6xlHG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YUVxInp6; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 683021C0014E;
	Mon, 22 Apr 2024 11:55:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 22 Apr 2024 11:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1713801354;
	 x=1713887754; bh=ZSHrYyPgFLrQZ8O8HWVsVt4/XQWCMDmHcdcpgfWAfj8=; b=
	ALn6xlHGM1zKqXALbMu8nurp7ObkDdTDr79lIpJQRXrl9RL8H+/aOA73xDHPkqCh
	Pfgseg5+ifMjLhwb40HuiCebbQMl64OqK14DW5HYBcjbrD9ZkF7mCJBGEvnxJjgS
	gDnSbgkReW+uRas/Nkydik+BYZ53ZaNIXsq8AR16cC1nSk51jJJsuzx1GulFB4VN
	ZMnaGGUKdvEdUiDFIk4LF5+SvN0/plTlyiasY7WKGXRcD4OXOx2C2RWFk3M7KO83
	rHacifNdWyMCx5KFGv9cPvBjx3FAHkR6PIP7FXkBT+OcvEDDOcCgUegpD6LzPXkc
	Nj9PjctdvJ2Xq2SZwisR1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713801354; x=
	1713887754; bh=ZSHrYyPgFLrQZ8O8HWVsVt4/XQWCMDmHcdcpgfWAfj8=; b=Y
	UVxInp6tITMe9D6C4O+4b5n3ddou/qOf16eMckhAMiFfJ7EsErSDPm511oy0jtt2
	ZvvwTbziLgXeYZoce7iY6LMHgaYrbFM1Gw3m6EXBaN3OfufgwkbVHz5NhdDXM3tZ
	GjW9Cz0dGzTj9DHd6/zUoSZKBRO7a9V7ds6XBsZPFsh9kr7jmu6F8zKcL8lrH8eF
	2nUiLmfCXkla9S6hUdmvWUO72qlF1v+PJc0YIb19cQyX0VKUq7nfWzIKpmGR9w/3
	20NrSumJfEppCWuc32kFHe4jDn40t8ZEGHHmNH5KyodI+8hyG05buLW19JWg07DW
	LIiGtDevaGAFxafNvuCbQ==
X-ME-Sender: <xms:iYgmZueyyuiVCA5bgohQCU3Y4BCG_62evA1bQleiEJ9A4HzfRnP3Ww>
    <xme:iYgmZoPS88FCDfhWx8XKwmECqNsGVDrsDVWBZUExCC7hef9nLpwhu7xThQe20UPQJ
    AbB8P8PoTbxZABNRkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:iYgmZvirFkZCQF2wjMuOd4-5mHzIvjWoJVLTUc0-PvkSAljkSaBntw>
    <xmx:iYgmZr90qxPSserCN03KK4YndHJ5OWuEeVzBwbg0lQdGqRHPSyIb7g>
    <xmx:iYgmZqsTPOkpBEQ9u7_v0qaHmVzXc0JTuipmKrtuHKwzR6xKoBshwA>
    <xmx:iYgmZiGeyjQEP9Gj4-R2__Zt86wStoqzA0bwgB-oyZnspljnWxqtVg>
    <xmx:iogmZiF7OEI55XW0pncz7go-rvrEpFKVYCzU-ZBapq4TlWEVwv4ZdnbP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C7E95B6008D; Mon, 22 Apr 2024 11:55:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7e4ff27-ebb3-4ed6-a7cc-36c36ab90a36@app.fastmail.com>
In-Reply-To: <C0856D2E-53FF-45EB-B0F9-D4F836C7222C@toblux.com>
References: <20240420223836.241472-1-thorsten.blum@toblux.com>
 <42e6a510-9000-44a4-b6bf-2bca9cf74d5e@linux.intel.com>
 <C0856D2E-53FF-45EB-B0F9-D4F836C7222C@toblux.com>
Date: Mon, 22 Apr 2024 17:55:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thorsten Blum" <thorsten.blum@toblux.com>,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: "Xiao W Wang" <xiao.w.wang@intel.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>,
 "Namhyung Kim" <namhyung@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Youling Tang" <tangyouling@loongson.cn>,
 "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Jinyang He" <hejinyang@loongson.cn>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: Change function return types from long to int
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024, at 16:30, Thorsten Blum wrote:
> On 22. Apr 2024, at 09:44, Amadeusz S=C5=82awi=C5=84ski=20
> <amadeuszx.slawinski@linux.intel.com> wrote:
>>=20
>> I don't mind the idea, but in the past I've send some patches trying =
to align some arch specific implementations with asm-generic ones. Now y=
ou are changing only asm-generic implementation and leaving arch specifi=
c ones untouched (that's probably why you see no size change on some of =
them).
>
> I would submit architecture-specific changes in another patch set to k=
eep it
> simple and to be able to review each arch separately.

I can generally merge such a series with architecture specific
changes through the asm-generic tree, with the appropriate Acks
from the maintainers.

     Arnd

