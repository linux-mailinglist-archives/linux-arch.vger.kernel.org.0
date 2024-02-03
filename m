Return-Path: <linux-arch+bounces-2073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A71884869B
	for <lists+linux-arch@lfdr.de>; Sat,  3 Feb 2024 14:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6498CB282E8
	for <lists+linux-arch@lfdr.de>; Sat,  3 Feb 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EB45DF2E;
	Sat,  3 Feb 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="mEF+Ph5F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xc5Oj+Vl"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D258206;
	Sat,  3 Feb 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706968614; cv=none; b=btM+JCWcEUpgPS8gxGMto3Ez7ay3XcNWinSJTMdsdDWV+TDn9Wnj9pX3ZCeECSYnMmoCY/yLOgcfyjKiDfiURTYJYaQmhdk6Bki3KSXdFcqtYRgeGCFnKruFh5rCS4mRoBSqxk5U3co10JrfA41/Z/nA/PuEPlOahVehQXhgdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706968614; c=relaxed/simple;
	bh=IxdoSDanbspVEE40NG9hB8hZCtFlgS2f70QPmZu1vVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpLwAtVL+2DvDPu3y4f8gq/+R2w4wssf5grSBEf0X5TJXXVdVmKhGYabxLsX6Cep+YMuuA1lWFewbp01QG7+kcUdSPzKi4Ftn+RSNoQUCS5fVDpg5ErtRPZMRZUfxtBv8fvZuy6HE4QNtBtk6M6YYXul7714UiKpDn2/9qVVGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=mEF+Ph5F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xc5Oj+Vl; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id F1A623200AF6;
	Sat,  3 Feb 2024 08:56:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 03 Feb 2024 08:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706968607;
	 x=1707055007; bh=mLqlcryUIStpRqzennhZ+4KphRKLiiH95cS6m9g+jYk=; b=
	mEF+Ph5FsFu9wQyBBKmdYfXVLlgHd7TRLkaT6Uq0PxHrjDatLPe69UYNFuxFwEi/
	E5TSnvzjxFxXdnR026XtQAoLNFpmaPT5G3hDBOz8bmW+5c5Ib4nR1UuLppEZJpxX
	CcICYmL0K1z4kwjOCjnXj5CLmcK7xy9HG18dWepGrdsyQGmMDsALlLrZd2isDVoT
	CZwpTd6nxRCMFHauSddlXlaeswAYGZbPNAu8EoaIWOkMKjneQFNouE6YciwkuWEC
	VSrpyW0cNw/1nS5AUON9lA1a5cRYN19iFl6e7nV7wpDjsIYBpA1d9B0u2Dc8Dboo
	ZFb9CT8M1+Dhsl9Z8BdrxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706968607; x=
	1707055007; bh=mLqlcryUIStpRqzennhZ+4KphRKLiiH95cS6m9g+jYk=; b=x
	c5Oj+Vl8pxAwFFABzQaNQgsSNOB+7SBSjkyH2fTqfq5j5wOaw1Zms7txzh3pOPi7
	QOwb257+PuFpnek6GSucCek4IHnJFaBrcVonBBI4ho+p/tm+WheHVBh8+vXhqnGt
	YnOo3MKeG4/jYhgG26KIYtvuiv2NfvBSwdeH+mijoYPZZkNC+/E3KYFzjLvLUYkA
	8qkae73PTjUcfBHhufZlm6rCqRu0FB/WCrHRpyj5DD8QlBLnC6AOETXZJDvQQ6rO
	4v9Gh9Ltr0gHzfQMji4asuaYG2ZdlxErvkW3X9VuQ0GOV5riACgC3bDJm0MGJqmZ
	595zeom841wVv3NkJej2Q==
X-ME-Sender: <xms:Hka-ZYvweBRyI2vLsxKh-ybHcLGrf_7KbH0uAN9yPTm0UemghxhJwA>
    <xme:Hka-ZVdptfGRjgJYADLhGnUBFm9Yszmdqa07ck1iYtSou2bl8r44qgXQS--pT6dRK
    wwemwFjLpVfrU3Kmfc>
X-ME-Received: <xmr:Hka-ZTxcdmyVjV4TDLEawfZdPzoj42yx8RCVlAx_gG9ozOzJJ_94w98mewyN0ph8Da60zqb9j1eLaOfamIpa7UBjjC11_46z-kflqwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduiedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:Hka-ZbOZdtk3lewIW3TCNEzHY8PTEwnnVEU3Q0u4DvSjiRxEsksyUg>
    <xmx:Hka-ZY8H3kxwkTklmr0CmIKfXbEVSQIx5nty4HzmhJq6T8qLRav4nw>
    <xmx:Hka-ZTVODrAWeVnwS5PjHTEgfgzL9IUU6wKXxbBY0iPHfsTuPRdnnQ>
    <xmx:H0a-ZcTLpPm1nNWQKqgE7JwDmWzhMi6C_he0hcWKM2BLV8jiYf8ICw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Feb 2024 08:56:45 -0500 (EST)
Message-ID: <eeb92d70-44d6-47f4-a059-66546be5f62a@flygoat.com>
Date: Sat, 3 Feb 2024 13:56:43 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ben Hutchings <ben@decadent.org.uk>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, Xi Ruoyao <xry111@xry111.site>
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
 <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
Content-Language: en-US
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= xsFNBFnp/kwBEADEHKlSYJNLpFE1HPHfvsxjggAIK3ZtHTj5iLuRkEHDPiyyiLtmIgimmD3+
 XN/uu2k1FFbrYiYgMjpGCXeRtdCLqkd+g9V4kYMlgi4MPHLt3XEuHcoKD1Yd2qYPT/OiQeGM
 6bPtGUZlgfOpze1XuqHQ2VMWATL+kLYzk6FUUL715t8J5J9TgZBvSy8zc6gvpp3awsCwjFSv
 X3fiPMTC2dIiiMh4rKQKGboI1c7svgu6blHpy/Q5pXlEVqfLc7tFTGnvUp95jsK639GD8Ht3
 0fSBxHGrTslrT775Aqi+1IsbJKBOmxIuU9eUGBUaZ00beGE09ovxiz2n2JKXKKZklNqhzifb
 6uyVCOKdckR8uGqzRuohxDS7vlDZfFD5Z5OhplFY/9q+2IjCrWMmbHGSWYs9VV52XGM+wiEG
 sM5bup03N2q1kDXUWJ+zNNYowuOJKN9uxF3jBjdXSDi3uJu/ZUL/mBqI58SkHq5NTaHypRoE
 5BxVmgDMCGQe93adKHUNmt4HK28R506S7019+umg1bq5vA/ncmh/J2k8MFGPXqO8t1xVI2O5
 qrRheRKu1oST46ZJ7vKET1UwgcXTZ1iwqFlA26/iKxXoL7R7/AqWrapokEsUzRblGcutGZ/b
 4lJVOxxAWaRcajpWvwqscI2mUF++O7DxYbhOJ/EFY2rv0i6+/QARAQABzSVKaWF4dW4gWWFu
 ZyA8amlheHVuLnlhbmdAZmx5Z29hdC5jb20+wsGRBBMBCAA7AhsjAh4BAheABQsJCAcCBhUK
 CQgLAgQWAgMBFiEEmAN5vv6/v0d+oE75wRGUkHP8D2cFAmKcjj8CGQEACgkQwRGUkHP8D2fx
 LxAAuNjknjfMBXIwEDpY+L2KMMU4V5rvTBATQ0dHZZzTlmTJuEduj/YdlVo0uTClRr9qkfEr
 Nfdr/YIS6BN6Am1x6nF2PAqHu/MkTNNFSAFiABh35hcm032jhrZVqLgAPLeydwQguIR8KXQB
 pP6S/jL3c7mUvVkoYy2g5PE1eH1MPeBwkg/r/ib9qNJSTuJH3SXnfZ4zoynvf3ipqnHsn2Sa
 90Ta0Bux6ZgXIVlTL+LRDU88LISTpjBITyzn5F6fNEArxNDQFm4yrbPNbpWJXml50AWqsywp
 q9jRpu9Ly4qX2szkruJ/EnnAuS/FbEd4Agx2KZFb6LxxGAr4useXn6vab9p1bwRVBzfiXzqR
 WeTRAqwmJtdvzyo3tpkLmNC/jC3UsjqgfyBtiDSQzq0pSu7baOjvCGiRgeDCRSWq/T3HGZug
 02QAi0Wwt/k5DX7jJS4Z5AAkfimXG3gq2nhiA6R995bYRyO8nIa+jmkMlYRFkwWdead3i/a0
 zrtUyfZnIyWxUOsqHrfsN45rF2b0wHGpnFUfnR3Paa4my1uuwfp4BI6ZDVSVjz0oFBJ5y39A
 DCvFSpJkiJM/q71Erhyqn6c1weRnMok3hmG0rZ8RCSh5t7HllmyUUWe4OT97d5dhI7K/rnhc
 ze8vkrTNT6/fOvyPFqpSgYRDXGz2qboX/P6MG3zOOARlnqgjEgorBgEEAZdVAQUBAQdAUBqi
 bYcf0EGVya3wlwRABMwYsMimlsLEzvE4cKwoZzEDAQgHwsF2BBgBCAAgFiEEmAN5vv6/v0d+
 oE75wRGUkHP8D2cFAmWeqCMCGwwACgkQwRGUkHP8D2dXlw/8CGKNXDloh1d7v/jDgcPPmlXd
 lQ4hssICgi6D+9aj3qYChIyuaNncRsUEOYvTmZoCHgQ6ymUUUBDuuog1KpuP3Ap8Pa3r5Tr6
 TXtOl6Zi23ZWsrmthuYtJ8Yn5brxs6KQ5k4vCTkbF8ukue4Xl4O0RVlaIgJihJHZTfd9rUZy
 QugM8X98iLuUqYHCq2bAXHOq9h+mTLrhdy09dUalFyhOVejWMftULGfoXnRVz6OaHSBjTz5P
 HwZDAFChOUUR6vh31Lac2exTqtY/g+TjiUbXUPDEzN4mENACF/Aw+783v5CSEkSNYNxrCdt8
 5+MRdhcj7y1wGfnSsKubHTOkBQJSanNr0cZZlPsJK0gxB2YTG6Nin13oX8mV7sAa3vBqqwfj
 ZtjNA+Up9IJY4Iz5upykUDAtCcvm82UnJoe5bMuoiyVccuqd5K/058AAxWv8fIvB4bSgmGMM
 aAN9l7GLyi4NhsKCCcAGSc2YAsxFrH6whVqY6JIF+08n1kur5ULrEKHpTTeffwajCgZPWpFc
 7Mg2PDpoOwdpKLKlmIpyDexGVH0Lj/ycBL8ujDYZ2tA9HhEaO4dW6zsQyt1v6mZffpWK+ZXb
 Cs8oFeACbrtNFF0nhNI6LUPH3oaVOkUoRQUYDuX6mIc4VTwMA8EoZlueKEHfZIKrRf2QYbOZ
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
>
> Because that mm/memory.c use of "exception_ip()" most definitely
> cannot take a page fault.

I reconsidered this issue today and I believe that exception_ip() usage 
here won't trigger
page_fault anyway.

Given that exception_ip is guarded by !user_mode(regs), EPC must points 
to a kernel
text address. There is no way accessing kernel text will generate such 
exception..

Thanks
>
> So if MIPS cannot do that whole exception IP thing without potentially
> touching user space, I do worry that we might just have to add a
>
>     #ifndef __MIPS__
>
> around this all.
>
> Possibly somehow limited to just the microMIPS/MIPS16e case in Kconfig instead?
>
>              Linus

-- 
---
Jiaxun Yang


