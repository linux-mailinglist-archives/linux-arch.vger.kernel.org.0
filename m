Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2361E466E55
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 01:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349694AbhLCAOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 19:14:40 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39035 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233413AbhLCAOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 19:14:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CFF15C0316;
        Thu,  2 Dec 2021 19:11:16 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 19:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=4lwOqAOjiqgPdGNyVJBcnRov6B/MBYi
        /SQsQ344Kws8=; b=iZTEsHJPzFYGerrtuIFEF8lvFfZ1myqisgEcFN1ffbWQ+3E
        v+C/FJbVGEoXsjAIOMpneXLU5eFM2354eY9ExknLCU8BXqlwsSTRZ8YHbCghdyWh
        SUrBWT16y0q0fa4mzL8/EBn74/lTQ/pxV1u0sxO0h72ULPDUY/ov0wM9HASMW2R0
        RYn8ABqRMMKLHe6W3diodUPobl5qanP2mqsTrtIKalZL1VJv5WBAlcWb1k3Pg3vy
        vTr/w58e2e8iKduW2f9a1KBdOPZwNLvOoPKBADUJY1li+R9Bvp1PWugAH8YzgvzL
        xgGFIb2H9A/PS5I3wgGIGdRaqeQd9kCC72Pyz6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4lwOqA
        OjiqgPdGNyVJBcnRov6B/MBYi/SQsQ344Kws8=; b=F+4V/vqA0mdN07pmSi4Sup
        bZ1wYJ3VkqKHUSAz5fxinzf6sNcTmp0nQuUkyXu/4bNq1sDcqapETlmRLBJLldX6
        djLlx9XPYcYpT5cW+U1wcRmFQvbJNnVYe0tNOUwYIB/HpKQMcz5jT6H3XIwBpoDQ
        Wb5NowOmSx10GLEtFgoDgSR84RiPvi3O9fa7TPLtPetKWSxo8vGRz33CuGQ7GkvE
        Tsg6XNNQCb8kqe7y78xm9tFPdQ1SV/snIQnb6X74Rmy/FwxGeQ8w6rFE1ty88//T
        14h1TrMJnRmELFu+QejOxgW3t+DyX2DgMLWawiuYXVhgw9jPlziCyEYROYm8Rosw
        ==
X-ME-Sender: <xms:o2CpYVkFEV2f4rfGPZevc3_fyVsSkOlmrjf2nSkQsi-flCYkAf3DRA>
    <xme:o2CpYQ1ZD0-Sgjs_ufHCwHaI1gnEubYppLUKG1Nga-LEDZKGoYNfSgTfwFEDdrLPT
    xSyys-agwM36sUdAKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfkggrtghk
    ucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholhhiohdrohhrgheqnecuggftrf
    grthhtvghrnhephfeuhfevueffteffgfejtefgkeekheeftdeflefgheffffevheekleef
    gfehffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epiigrtghksehofihlfhholhhiohdrohhrgh
X-ME-Proxy: <xmx:o2CpYbrw5sjhOj-qcwg0AljYtdAcB4SNvKWJfO21fsb9OlLPajktvw>
    <xmx:o2CpYVkH94KabekVxhFbhMPVxZGUtPX3A4_QMMU_JSkwpC82XWlC4w>
    <xmx:o2CpYT3bF-Q8WARuO9lFtFvyRTvYe8M1FfNbToVDvt_3MSMt6psgNw>
    <xmx:pGCpYeSifUh_WhZNjYJBjKUDgNgWJwSIhrs3URgu5Fb3E1dWRGpxSQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 34AB724A0074; Thu,  2 Dec 2021 19:11:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <9d24f699-386a-4881-b09a-ebd747310187@www.fastmail.com>
In-Reply-To: <855a47d1-a89c-bbc8-7ddd-b89104c6138a@linaro.org>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
 <20211202153422.GH7074@brightrain.aerifal.cx>
 <20211202232954.GI7074@brightrain.aerifal.cx>
 <855a47d1-a89c-bbc8-7ddd-b89104c6138a@linaro.org>
Date:   Thu, 02 Dec 2021 19:10:52 -0500
From:   "Zack Weinberg" <zack@owlfolio.org>
To:     "Adhemerval Zanella" <adhemerval.zanella@linaro.org>,
        "Rich Felker" <dalias@libc.org>
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 2, 2021, at 6:43 PM, Adhemerval Zanella via Libc-alpha wrote:
> On 02/12/2021 20:29, Rich Felker wrote:
>> On Thu, Dec 02, 2021 at 10:34:23AM -0500, Rich Felker wrote:
>>> On Mon, Nov 22, 2021 at 10:19:59PM +0000, Zack Weinberg via Libc-alpha wrote:
>>>> On Mon, Nov 22, 2021, at 4:43 PM, Cyril Hrubis wrote:
>>>>> This changes the __u64 and __s64 in userspace on 64bit platforms from
>>>>> long long (unsigned) int to just long (unsigned) int in order to match
>>>>> the uint64_t and int64_t size in userspace.
>>>> ....
>>>>> +
>>>>> +#include <asm/bitsperlong.h>
>>>>> +
>>>>>  /*
>>>>> - * int-ll64 is used everywhere now.
>>>>> + * int-ll64 is used everywhere in kernel now.
>>>>>   */
>>>>> -#include <asm-generic/int-ll64.h>
>>>>> +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
>>>>> +# include <asm-generic/int-l64.h>
>>>>> +#else
>>>>> +# include <asm-generic/int-ll64.h>
>>>>> +#endif
>>>>
>>>> I am all for matching __uN / __sN to uintN_t / intN_t in userspace, but may I suggest the technically simpler and guaranteed-to-be-accurate
>>>>
>>>>  /*
>>>> - * int-ll64 is used everywhere now.
>>>> + * int-ll64 is used everywhere in kernel now.
>>>> + * In user space match <stdint.h>.
>>>>   */
>>>> +#ifdef __KERNEL__
>>>>  # include <asm-generic/int-ll64.h>
>>>> +#elif __has_include (<bits/types.h>)
>>>> +# include <bits/types.h>
>>>> +typedef __int8_t __s8;
>>>> +typedef __uint8_t __u8;
>>>> +typedef __int16_t __s16;
>>>> +typedef __uint16_t __u16;
>>>> +typedef __int32_t __s32;
>>>> +typedef __uint32_t __u32;
>>>> +typedef __int64_t __s64;
>>>> +typedef __uint64_t __u64;
>>>> +#else
>>>> +# include <stdint.h>
>>>> +typedef int8_t __s8;
>>>> +typedef uint8_t __u8;
>>>> +typedef int16_t __s16;
>>>> +typedef uint16_t __u16;
>>>> +typedef int32_t __s32;
>>>> +typedef uint32_t __u32;
>>>> +typedef int64_t __s64;
>>>> +typedef uint64_t __u64;
>>>> +#endif
>>>>
>>>> The middle clause could be dropped if we are okay with all uapi
>>>> headers potentially exposing the non-implementation-namespace names
>>>> defined by <stdint.h>. I do not know what the musl libc equivalent
>>>> of <bits/types.h> is.
>>>
>>> We (musl) don't have an equivalent header or __-prefixed versions of
>>> these types.
>>>
>>> FWIW I don't think stdint.h exposes anything that would be problematic
>>> alongside arbitrary use of kernel headers.
>> 
>> Also, per glibc's bits/types.h:
>> 
>> /*
>>  * Never include this file directly; use <sys/types.h> instead.
>>  */
>> 
>> it's not permitted (not supported usage) to #include <bits/types.h>.
>> So I think the above patch is wrong for glibc too. As I understand it,
>> this is general policy for bits/* -- they're only intended to work as
>> included by the libc system headers, not directly by something else.
>
> You are right, the idea is to allow glibc to create and remove internal headers.

As a general rule yes, but we could make a deal that some specific bits headers are permanent API for use by things like this. They probably should be less of a dumping ground than bits/types.h though.
