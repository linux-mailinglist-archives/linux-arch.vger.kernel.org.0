Return-Path: <linux-arch+bounces-2076-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4B0848D03
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 12:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8ED283574
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 11:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAB421A04;
	Sun,  4 Feb 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="klD336ts";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgyI4Lqb"
X-Original-To: linux-arch@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFEA219EB;
	Sun,  4 Feb 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707044601; cv=none; b=ED+XEE1oSZvn/cIkevynK/AnlaNdcMqAprdoYtt+mHekOSopU3qvv2bJbuLs//cW6JGOLRgOGxu6ikDc06J2WnvCEgEOcassnUfpY7k9rkHBGU4Kmkwssz8AFh4Ed4a+w5R2GRse4nNtPQjOfwWX6sEpdt+sVj+xpVCA017dAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707044601; c=relaxed/simple;
	bh=Y2D//G+8jRO7QyOnjxy4nQr1hf6l/qJNHpnyOYklcGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsE/EXB7UJE2xGJ07CCuB+FUkIaDzX7mLy1r7ohrklkiHgbniiTRCcmonC3854o8hGnD08x8JnuScNa3Sjdj6Myv9f3Z9tWJ86aFm8TJlu+rBp2L6KNC3RgkAs9/5+u7HYsODnuqr4jsj3jlnwFLlwGk8zVtpBGn7Dp/UYigtn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=klD336ts; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgyI4Lqb; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 31F905C00D1;
	Sun,  4 Feb 2024 06:03:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 04 Feb 2024 06:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707044598;
	 x=1707130998; bh=Bf+fUOrYXcGEM/eDTspqcwbDeCrIad7HJCkL0vJjXLo=; b=
	klD336tsM1X2o9/VFc1F2tiyrPMCN8vuP1BjytGFIGBJ2Rxb6lHcG6Me/Ha3i3Uh
	S+nERwVD4tqcNLb6cHAY9q4XCdA3LV7MMa2d4ELjiej+BZZaN/NgNaBo1CS0/PWo
	zc23jK3N5jqKT06eN35uWiOsqGNGOmW87/mQEne68vI9D7wjsYWy6JkeYnYk8yR/
	vSOsLLd8m5Sr9il4Sdh4K/RG2/BZ0U9545PTRgKJlOtQwkhQDEVdt6OF9/1BvRqg
	FCpLP+9017MxqjF81tLyXFsCSNnmY47CmuR4e9FKfanzOdJ7Aa6hfLqX408qPDZv
	M/kipRaZCnX85eXc5Wkt/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707044598; x=
	1707130998; bh=Bf+fUOrYXcGEM/eDTspqcwbDeCrIad7HJCkL0vJjXLo=; b=J
	gyI4Lqb8jFaFM6HQMVA+uf8nSiSvbsykpqRFok0ht0Nz1lM48osxHhH+Jdjmk3Es
	+iz/gr39XspwzhpwifTFJcL6Ki4Y/HXAmT6SVzPEQjvWqDuZtrJvpnr4jJVc8aIL
	7MB7PHU9WmcbzB3WdAdsIj3KeIlw10sNsn3zTcZnRpxGGwYpn9iyQBrsMAL3q53E
	vTclfAnK+diImUUk5L6rZV0gioei3wO5lP6i7gPq87Pcd9l6GpBRMn7OObC2tcu8
	LZ4vp0Wf4jEUVe6V4fHID9Q1hX7xsTIcHYR2iFJKaZru6jaQxjzHClqIpT92kEX5
	0JhLy2Lqfz6NSMIhgU4Tw==
X-ME-Sender: <xms:9W6_ZeNM8W5rJoFiz3tR799_85vDw1q-4xEFWEhEgEeIvB0nA-mPqw>
    <xme:9W6_Zc_KCwu_u6Q5c_U9GQlAAhyokw5FadsNWHl1rOQgC-d9NLTQuUTnZIybRURkg
    jXd8rsS7Wqq6NS1SIE>
X-ME-Received: <xmr:9W6_ZVSsb7zULL22ychE4jCwhFVXwOSjbuG8aVgeobi9RjiuppStxA6wQSn-csJ-ah5GIZp7Vv4ptyAS76gsmxClryMB9-5s0h2i9gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:9W6_ZetDs4oxeb9fA48aayR_EcvMPlerTX4oBiPvSbAVrwtmVSqGUw>
    <xmx:9W6_ZWfRQMC4uOt-90jXLePBVPjpGDL3uCggxFeGs3F__Oi4-GUQLA>
    <xmx:9W6_ZS1PlvUeqaojsU16jHW-zKDdh7EPrfZLblb10YIX251RpUNi3g>
    <xmx:9m6_ZdxRcoWByLpSgiF_e4ZSv4wPpg2dV5l8DNbI3URIjTVC5GQ_iQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Feb 2024 06:03:16 -0500 (EST)
Message-ID: <716af17c-136b-4852-86ce-a23bafe34fbb@flygoat.com>
Date: Sun, 4 Feb 2024 11:03:15 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ben Hutchings <ben@decadent.org.uk>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, Xi Ruoyao <xry111@xry111.site>
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
 <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
 <eeb92d70-44d6-47f4-a059-66546be5f62a@flygoat.com>
 <CAHk-=wiUb1oKMHqrxZ6pA7OjNmtgw6giTKWiagUC2kt-ePCakg@mail.gmail.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <CAHk-=wiUb1oKMHqrxZ6pA7OjNmtgw6giTKWiagUC2kt-ePCakg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/4 07:41, Linus Torvalds 写道:
[...]
> The thing is, the only reason for the code in
> get_mmap_lock_carefully() is for kernel bugs. IOW, some kernel bug
> with a wild pointer, and we do not want to deadlock on the mm
> semaphore, we want to get back to the fault handler and it should
> report an oops.
>
> ... and one of the "wild pointers" might in fact be the instruction
> pointer, in case we've branched through a NULL function pointer or
> similar. IOW, the exception *source* might be the instruction pointer
> itself.

Well this is the tricky part of my assumption.
In `exception_epc()` `__isa_exception_epc()` stuff is only called if we 
are in delay slot.
It is impossible for a invalid instruction_pointer to be considered as 
"in delay slot"
by hardware.

I'd agree that sounds fragile though.

Thanks
>
> So I realy think that MIPS needs to have some kind of "safe kernel
> exception pointer" helper. One that is guaranteed not to fault when
> evaluating the exception pointer.
>
> Assuming the kernel itself is never built with MIPS16e instructions,
> maybe that's a safe assumption thanks to the "get_isa16_mode()" check
> of EPC. But all of this makes me nervous.
>
>                Linus

-- 
---
Jiaxun Yang


