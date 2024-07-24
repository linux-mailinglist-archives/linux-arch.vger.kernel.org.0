Return-Path: <linux-arch+bounces-5611-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5EA93B011
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 13:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855231F22D9D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F215696E;
	Wed, 24 Jul 2024 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hl0E9Xn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TEpgTwBG"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B402595;
	Wed, 24 Jul 2024 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819013; cv=none; b=RdjD3flNs06Q4RqQ83ycbB5Rjj4XwUzTS4vb3WYc51ZjPeZqaNN+HvenCGOqwgIYXfVC5zVgqgQYVO0JX3xugB9m1cjylL3DErO4Djw15ChuPPXqhmscdGJlGQ03jcbzHukk1UCU7JuueT6duSThryimIsaCKY8oLBGpSupG3hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819013; c=relaxed/simple;
	bh=MqzgztNulWn6ps+zt1kJxLxjw6K7gLx3zBJw3z+G0fY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DLLCoxUzcOjY90jK63W7ixN64Xis1pO7GyzTUGsfHvUSZXrz6Wn0Jse3XjONJCGqt0YVmjRrpze9j2gVJenhepgDAuZWxMWBvxXRM21mdZCCJ+5kmw+dn/XUxsQ5sjGWTICtjjNQ4RasIBOpNLW0LG/5SqLDViSYgn/+ewU1mXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hl0E9Xn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TEpgTwBG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 543A5114028F;
	Wed, 24 Jul 2024 07:03:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 07:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721819010; x=1721905410; bh=lEWGhgTjsE
	RsXXuFoYCD9j3Lo6IvAdsriZK45kT9e10=; b=hl0E9Xn2SANSl/aXFa7gaZo1fE
	Ol/yUocvSHn0LoYw+8V5udPPZPDxR8aDceBCtjLzpmAoQivb96RtMoazQvK0jZpA
	fbZ4WjTj2Si0GquKWUZM1zbMPwKy3/HIb3/0TPlrJ2o9ydERLiF0zo8YsFzWxH78
	FvDKS2K2TDdCaH1iQT0pF8+2x2NKuJJRg9wwCCCfasgOM2T4OcJ7m5flr5H8nVC8
	NNH1JT69/SE50DuDLAQmi8NElCXTYzOORLeW9Hyq83jpdIbQIaUrGTKZLkiTbnYf
	pFwViye9/xIxE6Dg7iCJE5k7L2w2EfkhxphBL/SB5nKqeHaJJLKweBkOwcXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721819010; x=1721905410; bh=lEWGhgTjsERsXXuFoYCD9j3Lo6Iv
	AdsriZK45kT9e10=; b=TEpgTwBGEYwZAKexU6xoI0LG9kRu47dV5ep9BhLhCaic
	H1h8ddqy4p2X6QiCO1f1XEDOPhOMPUDhMwJDQmyattfaW84RN48xhYxvEGdS0wSg
	Box6Gmu8etFsNbbZ9VsQ+Y22uFrhM5xr6uysn5apRsgAdbKwFXzWsYIMYYAI9VF+
	2q/VeuC7CX/+AufWBjVIEGAh0OiaXNkLFOtIaWi/de1k54LD/kwF9J58acfRdLaz
	SSdSzQ4GKoEVWEFwlvdh/Gll+0WK5meTecTgYxmLqe54bNspWiupCEDFYVOmgRq9
	XZ0x+JMRXKw4rT5MAAGEmV8LkVV0Na/4jAwpjwuabQ==
X-ME-Sender: <xms:gt-gZua86hUF2EmTXWWY9zAqWSW0e-V6A5USOc0kZpqjqO5RMScoqw>
    <xme:gt-gZhYupxpsYH-JKLRuQ7VDawck3kmXwFMEk43Bh9OIemEJBlDYz0vTgO8NJFdYJ
    TsD0XVUjS3j9-Q4TR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeefkedvheehjeejteeguedvgeevfeduffdvveeuhfdvudeltddtjeevvefggfei
    geenucffohhmrghinhepghhouggsohhlthdrohhrghdpshhtrggtkhhovhgvrhhflhhofi
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:gt-gZo-7PhRfB1Z6_clK-Yv54DhqRRaMt6tBfTDod9Z90TGwyKeVSA>
    <xmx:gt-gZgrC7ylEA5YwwravPQnjWmBxw3eq1mCMMRyID9dj2sRTQgVydQ>
    <xmx:gt-gZppe5gzvPvzwusv243H3xwCbo0OVMXV6S6okO0TiZMEBzo-p_Q>
    <xmx:gt-gZuQ_87mgAVPECBUkpbGp-LeFLC_75G2o8Qr5gZQSMT78sMelAQ>
    <xmx:gt-gZiC1U3B-sNmyZ30O7pQ1s30kUTb0ekpZoB6845Xv1b5HXKSYRI6->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 163EAB6008D; Wed, 24 Jul 2024 07:03:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d0fadaa3-94d4-4600-8e92-a8fe5b0f141b@app.fastmail.com>
In-Reply-To: <20240724103142.165693-2-anshuman.khandual@arm.com>
References: <20240724103142.165693-1-anshuman.khandual@arm.com>
 <20240724103142.165693-2-anshuman.khandual@arm.com>
Date: Wed, 24 Jul 2024 13:03:09 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anshuman Khandual" <anshuman.khandual@arm.com>,
 linux-kernel@vger.kernel.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/2] uapi: Define GENMASK_U128
Content-Type: text/plain

On Wed, Jul 24, 2024, at 12:31, Anshuman Khandual wrote:
> --- a/include/uapi/asm-generic/bitsperlong.h
> +++ b/include/uapi/asm-generic/bitsperlong.h
> @@ -28,4 +28,8 @@
>  #define __BITS_PER_LONG_LONG 64
>  #endif
> 
> +#ifndef __BITS_PER_U128
> +#define __BITS_PER_U128 128
> +#endif

I would hope we don't need this definition. Not that it
hurts at all, but __BITS_PER_LONG_LONG was already kind
of pointless since we don't run on anything else and
__BITS_PER_U128 clearly can't have any other sensible
definition than a plain 128.

>  #define __AC(X,Y)	(X##Y)
>  #define _AC(X,Y)	__AC(X,Y)
>  #define _AT(T,X)	((T)(X))
> +#define _AC128(X)	((unsigned __int128)(X))

I just tried using this syntax and it doesn't seem to do
what you expected. gcc silently truncates the constant
to a 64-bit value here, while clang fails the build.
See also https://godbolt.org/z/rzEqra7nY
https://stackoverflow.com/questions/63328802/unsigned-int128-literal-gcc

The __GENMASK_U128() macro however seems to work correctly
since you start out with a smaller number and then shift
it after the type conversion.

     Arnd

