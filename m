Return-Path: <linux-arch+bounces-2028-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C578847B86
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 22:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC64B2787E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA0839E4;
	Fri,  2 Feb 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="kJYzCHo6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KsqblSve"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DD7CF3F;
	Fri,  2 Feb 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909490; cv=none; b=s6QGXtodnyuUIO+jZF/rDaMAXN1osLgR2lDfoTqYdav5rxLhLo3FK4G9ILFz73u2wPTLtQGMMI2UsBipG7fTslCO8NHPNn6LLQS6x9671bIRaeCnWrI2k1/JXOrm5kIkEfEF/zNct1j9k1jdDM/akgOI0bYIiFOAoO/yjc4Kwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909490; c=relaxed/simple;
	bh=GZn2RPQk6SbEn/s/Sbfuic93/awRSAyfMfvV1+Vrw1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSoMHAPq/i83gj1bVtANQnVnXHt0wjg2TrcZ8XB2bV1DuA+n2BEV6rp+r0gYMir4Humaqu7WNRuWeUkovwR2IILm558b5dO1qZTOeyGC7WyeAUa/5G/o5fwoUOYV9wpSSXw2FNBIOcDCQQG75IUMH8dhPK6WUNlJwr2p4VZ6MZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=kJYzCHo6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KsqblSve; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 3DC403200A48;
	Fri,  2 Feb 2024 16:31:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 16:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706909485;
	 x=1706995885; bh=DYDb62ASAO+7468yzkEHNBIMHhgVPwqNfMHXZN7z5uY=; b=
	kJYzCHo67NJQ+tGmByKa44EmqkmF2dI+rInMf7dUKlALkvfBwObk5SJ8JimFrvA3
	aryt9i0hqElHcNR9A2RVfqU+H9VYSGbEJgcQyq+gzVSGAtX/x/OwEBXkUHHwSkWP
	lXeZvBYZUo49eURQ5ZSDTJ81MpE55L/N+fJgYWErxyfMSaKnydVYqzeRk1X9lFYF
	EXAdQ5l0Qkm4/qVVs6qu1DFGcM2vF6fQxgX8kbbwKbrvoqHg4OQ27V0TqlkR/9/+
	KXvNSZmfgLpCja0wxebxTh9lQv1USNEiO1xVdSyecr3T24pnp2xxSa7oUMWaST8p
	v0IzkXIvBCzKQmEdMPuf2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706909485; x=
	1706995885; bh=DYDb62ASAO+7468yzkEHNBIMHhgVPwqNfMHXZN7z5uY=; b=K
	sqblSve46eltPJrilQStnN11oNRppN3TF9Taba6gsmyPCf2t3Ojlo8qA8Gy7jVDJ
	RFNmdhN/Lr70NAL0KZMROL0EGugO0A5h39guVya5JYU2WUDYY1AllwQIPg7i2ek9
	IuZ9fZJh45t6LEJWhNWMPPlVCXoIl3JTEAEblqpqCDqlZNxDm2RTzUup82rxIsxa
	xLAXxXTrE7a1SL8GbKQVZPAvG5n843MUrAC7R0CaoE+hD3mQDFjrV+EJBceq2aMO
	tW6iRHX0nKJT1be3EFEk2xKQnCCIUKVm7EXakV+dH5zxT9vhX4efGoAAGoiFdxlR
	5Ck6Oe0AyUlUt++C2ulQw==
X-ME-Sender: <xms:LV-9ZVx48v-V-bwZB-wqFFpqrY6Ny-Mg4RoCswEqwytVJofBZWoTdw>
    <xme:LV-9ZVQDJtfcF3FJav-8dOT4SX7Cf4k-HIirPYrOU4RKb30LjFlBSutKVqKPjy1-g
    xB_X4DSy-PlM0rjMQ8>
X-ME-Received: <xmr:LV-9ZfU6_aIZTRY3uhYQlrci08XJNR_VYarpk-kQz_2-1syiLWgNtoL_xVItA11STS_f_FKRZC_1HN5-UPjrKZAtsiP-H-Mhv9ySPJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeelueffheehgeeluedvlefghfeukeejteeuveeuhffftdfg
    uefhgefgueekffeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:LV-9ZXikif2PPF1vsmVBQ84PS5-rwOLZ--KwPBsSWDDEb3wZ8wHd2g>
    <xmx:LV-9ZXCbQog9GHS81eQOYt3k07P96ecJ_6Z9TnELCXbMBeYTn1y7Mg>
    <xmx:LV-9ZQJrKcjlsNDaEsPY6qYi4j6QeLlAP9TMOwPMlIdmHcURX2xH4g>
    <xmx:LV-9Zb3KdCuyAXjjmzigjrPisMcR-k3h27zTUZBKTf6UeeK7UCw1gA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 16:31:23 -0500 (EST)
Message-ID: <21ed604c-8607-43b7-853a-9bd1623bd918@flygoat.com>
Date: Fri, 2 Feb 2024 21:31:22 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Xi Ruoyao <xry111@xry111.site>
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
 <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
Content-Language: en-US
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/2 18:39, Linus Torvalds 写道:
> On Fri, 2 Feb 2024 at 04:30, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>        ptrace: Introduce exception_ip arch hook
>>        MIPS: Clear Cause.BD in instruction_pointer_set
>>        mm/memory: Use exception ip to search exception tables
> Just to clarify: does that second patch fix the problem that
> __isa_exception_epc() does a __get_user()?

No it only covers an obvious case when I was playing around exception_ip 
with kgdb.
There are still potential cases __isa_exception_epc may touch user space.

> Because that mm/memory.c use of "exception_ip()" most definitely
> cannot take a page fault.
>
> So if MIPS cannot do that whole exception IP thing without potentially
> touching user space, I do worry that we might just have to add a
>
>     #ifndef __MIPS__
>
> around this all.

It is possible to perform exception_ip() without touching user space by 
saving "BadInstr" in pt_regs
at exception entries. For newer hardware it's as simple as saving an 
extra CP0 register, on older hardware
we may have to read it from user space.

+ Thomas (MIPS maintainer), what's your opinion?

Thanks
>
> Possibly somehow limited to just the microMIPS/MIPS16e case in Kconfig instead?
>
>              Linus

-- 
---
Jiaxun Yang


