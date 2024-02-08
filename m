Return-Path: <linux-arch+bounces-2117-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A1E84DCAA
	for <lists+linux-arch@lfdr.de>; Thu,  8 Feb 2024 10:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4746A1C212FC
	for <lists+linux-arch@lfdr.de>; Thu,  8 Feb 2024 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB086BFBB;
	Thu,  8 Feb 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="BIq10Xut";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkVFonMY"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688246BB55;
	Thu,  8 Feb 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384054; cv=none; b=aCt/SftxJVUqiEuD3QpNVBa0oEh83mrMlWcUbdey9jQxv/k6k+z6HsczGbKWH0dXMG5w8hzrQvE1rMNIzJJQGskSaNDA6Kea2O/PBQKGjVBJf7oK8hJyt2TGAd2yJtHShuN5YHWu2xjMvWSUCtvi3dRR65D4F3EGodoM/RCKHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384054; c=relaxed/simple;
	bh=UmsQQy0GxSUlPjTMxhqBJwATE/FEB2iKU59BoDw0V7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utiH12Ff/7BQcD2ds06mdsZbvWBC1kU5S7kvugKjYSGmpyFUUGWx+5Ph6hcGykk998vC9DUwYONMqWgstSD43LienNfymqQAeO8i8xO3tHPAUP9lVFRG1OblD40Rj4BaMCq0IGdeNLOrjuqB4541HEYOPUpN35b3B9o/fzr+jL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=BIq10Xut; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kkVFonMY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2FAD911400B0;
	Thu,  8 Feb 2024 04:20:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Feb 2024 04:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707384051;
	 x=1707470451; bh=uj690mHzuaDMd47zJhc5iPw+H6HEefWEcHIBsad9VjU=; b=
	BIq10Xut73VD6H6regi/+2wPfSkPy33QTMhOMs081bX2aSkLfge28ftOpCpNcVI2
	ioH86AUrNsJ9REbkbiCoc49gWt7zOLHld7xp3GGPe6TaKoclkdVOZU4zPn94coOt
	JO/wH6Hg06UYXeo9YGe5AiKAPZnx3XKi5wUILe5l9JImxi7Z1Yeiabg4e47ox3Jj
	71mxi3a2GEm1GeJZSj512dHK+E7cAjBrr4nZBNk06RMF9hVaZy6VgnXd2NFoUG3Q
	FiH8zTKOkMVDgZk1RFLDYPoJU1GrafCi8pCYo+ly/AlZgctW3kDslPWRCiuhjqX2
	rsqiLxPxpBLwRQ7h+VJ7GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707384051; x=
	1707470451; bh=uj690mHzuaDMd47zJhc5iPw+H6HEefWEcHIBsad9VjU=; b=k
	kVFonMYqFfhH5K+T2CBvJRzN6ZPX0ewEW3DIIlx7YfKeJCTw13ZBdN/APNyo5pQE
	t+LPjd9mVFmr33xqdmrsjhI3IkBYBG3XZkl08Vhu/1+6XffMjklgzxG5SC2sXVPg
	I3LGMML+Lauf52ZeXZyc16/PuK+s2dGx/3nEY68y0tDCjyZ5iJAf6ncvP2YLV9Nw
	KLaSdr4OO+lmGIDXN/Jxc8gJ6vg/EnpcHdwDTKG0wgammD/+EoilBNd6jSNLChsk
	wFzIbLNcYL8km6ExbO/rDorefjYKjICktt8uIz2U5WO8xK5wZfsWpChoxW21VApn
	bp/+2W2flP9BSX+jmBdFQ==
X-ME-Sender: <xms:8pzEZVkGgZ-MoLxVaht4XIv4j6w1hm57B3fq4ugNjg4LUh6Fw1pcCA>
    <xme:8pzEZQ3GpSXmw4TKLwizOVFU7PmYNeJLN1ehhkdu9tt6_IlrKcJXsoip2xp-couGw
    bFSFXPZfBQjWJkXeM8>
X-ME-Received: <xmr:8pzEZbpZ4chCQfKlby_RlrcmBBpJIgF_4fIAYFkyEiSWqwsz5X6XJpYV5BvyPywjYOXsmwiN1qydEh6PyE_uBQf-wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduheejgfetvdekvedvveeikeelkefhveekveelheeikeefudet
    ueffudfhhedtheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:8pzEZVm860aT6mMJSJVgqE2cTq1Bjw4_kfXQdas5mc5jMWFBM-vmQQ>
    <xmx:8pzEZT3s5gmfppZZSAGFVhHfpj2oacryALtPFZRBiz5mosesSubb3A>
    <xmx:8pzEZUsAtN7fzXnAfeoEEvspZw_ZexqTrnv311CAG7fdEq3Lj0qCHw>
    <xmx:85zEZcsHhc1dBbznnJqztiirRSmeltrJyv4kFaomgWnMaiRwH5rpCw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 04:20:49 -0500 (EST)
Message-ID: <63a1738c-5755-4c2e-a4d4-f5047cdb3660@flygoat.com>
Date: Thu, 8 Feb 2024 09:20:47 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
To: Oleg Nesterov <oleg@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Xi Ruoyao <xry111@xry111.site>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
Content-Language: en-US
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/2 12:30, Jiaxun Yang 写道:
> Hi all,
>
> This series fixed extable handling for architecture delay slot (MIPS).
>
> Please see previous discussions at [1].
>
> There are some other places in kernel not handling delay slots properly,
> such as uprobe and kgdb, I'll sort them later.

A gentle ping :-)

This series fixes a regression, perhaps it should go through fixes tree.

Thanks
- Jiaxun

>
> Thanks!
>
> [1]: https://lore.kernel.org/lkml/75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site
>
> To: Oleg Nesterov <oleg@redhat.com>
>
> To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Ben Hutchings <ben@decadent.org.uk>
>
> Cc:  <linux-arch@vger.kernel.org>
> Cc:  <linux-kernel@vger.kernel.org>
>
> Cc:  <linux-mips@vger.kernel.org>
>
> Cc:  <linux-mm@kvack.org>
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v2:
> - Reduce diffstat by implemente fallback macro in linux/ptrace.h (linus)
> - Link to v1: https://lore.kernel.org/r/20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com
>
> ---
> Jiaxun Yang (3):
>        ptrace: Introduce exception_ip arch hook
>        MIPS: Clear Cause.BD in instruction_pointer_set
>        mm/memory: Use exception ip to search exception tables
>
>   arch/mips/include/asm/ptrace.h | 3 +++
>   arch/mips/kernel/ptrace.c      | 7 +++++++
>   include/linux/ptrace.h         | 4 ++++
>   mm/memory.c                    | 4 ++--
>   4 files changed, 16 insertions(+), 2 deletions(-)
> ---
> base-commit: 06f658aadff0e483ee4f807b0b46c9e5cba62bfa
> change-id: 20240131-exception_ip-194e4ad0e6ca
>
> Best regards,

-- 
---
Jiaxun Yang


