Return-Path: <linux-arch+bounces-5614-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B293B0F7
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A581C21144
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219F156898;
	Wed, 24 Jul 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="i2hqZ0nQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cn17tpS8"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9C148FFA;
	Wed, 24 Jul 2024 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721824707; cv=none; b=ZpuuyxTAFPXPHaUq3b9QqjnceZqm/gU+Va3cufYwEJjS6aH7oZ0ss79sW5S6XIBWeAmjIc6fjVTVdw3iTHz/xYLU9BUsi7vcNlBMU/Gw9gt99lTQBsWkbTSbolfVa/zbO5auMBozDSDNCt0IZoMKNxUnRF1iGj8pzmGwDj3qUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721824707; c=relaxed/simple;
	bh=VCtfH/V0Iqx1XPif/WwmAUcbxCcUhHIUQTbsFA2wHqI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=cXxU6PyiyMBvCjB7A8cdc9Bz6YaQ1i7BDbHLjqj7eg+dfi4f9q5AwXLF2uqZHutCkJM/fyJrk+/A63uaAZ5iP8AD9u/cUkmghqLzASoyTQcXP5W2ogcJufJveFgxZWavGC19PFZy3t8d6y8MElfo8Kgc9eUnDMr/9m1ItmUgaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=i2hqZ0nQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cn17tpS8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 68CEA1380458;
	Wed, 24 Jul 2024 08:38:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 08:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721824703; x=1721911103; bh=BE8v/r/tmA
	JHpoLd92xEdYbBTbQFCV/bIoOEAgGWt20=; b=i2hqZ0nQEaKoHogGh5Aw01bCZZ
	TyfQyU4U08WB7UzmeQa0+MDjK43BP7gpX02P4V3nN50HT9BWuy1Xg9+a7HOSsZ3S
	FLVlJjQ4QPlQJuzNXEKzU4TvvsZwyFKL5ZsBqSuS7/FB1xyhn1rqPZ7k1EH4v9mw
	CTApw4d2+3ZSWnyNdqnu5q720rAxWmPZFZOGpAu5DJFzfN+KuOcmBxf5OKayBoIQ
	prE+sLxnEO/ObGkXqaJ4/R1YTeCk3/5zGemR28bZkwGq3UpD012emOwk8V5gvbb2
	WbsVjimTUmOpGBCHHs46N/1CgnQV7Y/GT5M7JmVw6gKb2pivA/HL22sJpzwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721824703; x=1721911103; bh=BE8v/r/tmAJHpoLd92xEdYbBTbQF
	CV/bIoOEAgGWt20=; b=Cn17tpS8g0M4W4HTBQSfre5jyOKh+fLxBQRXK7vgIoGM
	3Q65h4+CNy7vhndrBG48Tt/wdfbysqhQ2i42Uj8tavNyQkJDXLlOLbxFLnGr0aH8
	6osOS9trs+1CcB82SS29rCFiV7r+a1HF/uB5BteHGFFGwxbFkO+chM278qABW8rp
	rSElyBourESTEbdSX57cGcPLpIFten8dfvCZXJGO/otAY46lPQbjttm4Rlo9DHgS
	JEtvCC7bN/0TnaS+35GLgr2umSR+oMhb/VkUOKiXbWG6ORRtkny0zds+A6khNvn2
	Jk4FF1pHWfgfabbPR8vfqtLOKBjK+M8bKLqPzQ51NA==
X-ME-Sender: <xms:v_WgZiMPUf3BHuUBrAvXQRYjCJWhdfnmVUz_0tlIls3ZRpi8SUtoCw>
    <xme:v_WgZg8AV0WZfS3gNKzsFTuMFIfZgyHTHAMouXrykSxQFGWLyJwEbo3ntxmCqOHB4
    3RKDWVw4iXyfDJdifg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeefkedvheehjeejteeguedvgeevfeduffdvveeuhfdvudeltddtjeevvefggfei
    geenucffohhmrghinhepghhouggsohhlthdrohhrghdpshhtrggtkhhovhgvrhhflhhofi
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:v_WgZpTYTLcArbG03DKzen6YFTUwuMpkYVOs9kAkaYX7bC0ogqLa1g>
    <xmx:v_WgZiuboFu-1lPdpL9K6KRCJXCcs6vF7pImwN5DJnwdxqmLgEkxmQ>
    <xmx:v_WgZqd3suB6ftOaEXFSo3xiUUa3fZvRV91x81zRZtMRzig4jfAZ2w>
    <xmx:v_WgZm2YV6S_BX6wZH8p_O08uiExUwQa6AaEaTzYwjfZipylvdFXTw>
    <xmx:v_WgZnEU0Fos8cyBPOVasxJ628REHu865IZ1Ghr2hCC6Vbam7JFvMq0e>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F3E6BB6008D; Wed, 24 Jul 2024 08:38:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <19ed618c-5be9-4658-a2a3-031f4eded19a@app.fastmail.com>
In-Reply-To: <7d075af2-e94e-4201-9d5d-35fd53124c4c@arm.com>
References: <20240724103142.165693-1-anshuman.khandual@arm.com>
 <20240724103142.165693-2-anshuman.khandual@arm.com>
 <d0fadaa3-94d4-4600-8e92-a8fe5b0f141b@app.fastmail.com>
 <7d075af2-e94e-4201-9d5d-35fd53124c4c@arm.com>
Date: Wed, 24 Jul 2024 14:37:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anshuman Khandual" <anshuman.khandual@arm.com>,
 linux-kernel@vger.kernel.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/2] uapi: Define GENMASK_U128
Content-Type: text/plain

On Wed, Jul 24, 2024, at 13:59, Anshuman Khandual wrote:
> On 7/24/24 16:33, Arnd Bergmann wrote:
>> I would hope we don't need this definition. Not that it
>> hurts at all, but __BITS_PER_LONG_LONG was already kind
>> of pointless since we don't run on anything else and
>> __BITS_PER_U128 clearly can't have any other sensible
>> definition than a plain 128.
>
> Agreed, although this just followed __BITS_PER_LONG_LONG.
> But sure __BITS_PER_U128 can be plain 128.
>
> So would you like to have #ifndef __BITS_PER_LONG_LONG dropped here 
> as well ? But should that be folded or in a separate patch ?

A separate patch is probably better, but you can also
just leave it.

>>>  #define __AC(X,Y)	(X##Y)
>>>  #define _AC(X,Y)	__AC(X,Y)
>>>  #define _AT(T,X)	((T)(X))
>>> +#define _AC128(X)	((unsigned __int128)(X))
>> 
>> I just tried using this syntax and it doesn't seem to do
>> what you expected. gcc silently truncates the constant
>
> But numbers passed into _AC128() are smaller in the range [128..0].
> Hence the truncation might not be problematic in this context ? OR
> could it be ?
>
>> to a 64-bit value here, while clang fails the build.
>
> Should this be disabled for CC_IS_CLANG ?
>
>> See also https://godbolt.org/z/rzEqra7nY
>> https://stackoverflow.com/questions/63328802/unsigned-int128-literal-gcc
>
> So unless the value in there is beyond 64 bits, it should be good ?
> OR am I missing something.
>
>> The __GENMASK_U128() macro however seems to work correctly
>> since you start out with a smaller number and then shift
>> it after the type conversion.
>
> _U128() never receives anything beyond [127..0] range. So then this
> should be good ?

Since you define _U128() right next to _ULL(), I would argue
that it should have the corresponding behavior for any value
that can fit into the type. Since that is currently not
possible with gcc, I would prefer to not define it at all.

However, I think you can just define a _BIT128() macro
that behaves the same way as _BITULL() and define
__GENMASK_U128() based on that. Maybe something like

#define _BIT128(x) ((unsigned __int128)1 << (x))
#define __GENMASK_U128(h, l) (_BIT128((h) + 1)) - (_BIT128(l))

     Arnd

