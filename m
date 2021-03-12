Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C25B338858
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhCLJMh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 04:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhCLJMZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Mar 2021 04:12:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E78C061761
        for <linux-arch@vger.kernel.org>; Fri, 12 Mar 2021 01:12:25 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id k16so1807645ejx.1
        for <linux-arch@vger.kernel.org>; Fri, 12 Mar 2021 01:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zIjnsp8rd4xdPpAuuxIncOMqaUFXDk2H646FhKXhrQI=;
        b=FRs0DrvPBmFDVfjqtOrlSjtpxm2+npfQyr6b/8S1viwCakO54j+Ph4+I3oEQfBEcWJ
         cn6P5amhR1QkaHIdtdPuMCPLFwn/fu8mDumYTAGGx38RFzK9OimucKszR/tSf57O42sB
         KLtaS6uS6r9Zeg6EPSqA3X51WKoyUYNg/mMCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIjnsp8rd4xdPpAuuxIncOMqaUFXDk2H646FhKXhrQI=;
        b=MS5OvXq1OgjccVYgvy5wRr5VQjP3YwOXR+akpIRvSZplM9Yg3SoahO1MpJ4S1qGBPk
         PGMFJR9xFR1SE3EsqgPc3z3SJLsGFc2bzNaoCpqzGfbTK6RJ0QTuUlVcZu5COFLynB4M
         7V7FFH8QMmEd/Io3ch6Je9iakkp+2bN0i3HmvzWgvuWOHcSt/V5hfRmv+kqvHG+RpKEL
         I+brcc5FQwZVBY0n32hafcZBbEyJqCuDY/Fzub9eExXGDapWd5lQCzwT8n2/689ZKM3b
         5Gruqzn1IDn8Xgup+lkaCn+XNb2ZdXUpTnkqLO5HevzuvXefjoKP7kJG7L0vHMUcPkhc
         XiGw==
X-Gm-Message-State: AOAM530GObQRO0O5Hgn9CXsrDtfNuFjMIIa1CEKzc/zp9WZOZ3S1/xvI
        CJ0z/6ucrLSyObsemm6PUYEo5A==
X-Google-Smtp-Source: ABdhPJzaNywOtntiAGWEgNJuka3SQSKInwwsFwvR7RB/6MD51tlrbDsdPtWseQ7eoarQLQfZKyTgWg==
X-Received: by 2002:a17:906:f896:: with SMTP id lg22mr7223027ejb.124.1615540343895;
        Fri, 12 Mar 2021 01:12:23 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id l18sm2429944ejk.86.2021.03.12.01.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 01:12:23 -0800 (PST)
Subject: Re: [PATCH 06/14] bitsperlong.h: introduce SMALL_CONST() macro
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-7-yury.norov@gmail.com>
 <55f1e25a-3211-8247-9dd3-3777e29287db@rasmusvillemoes.dk>
 <20210312052812.GB137474@yury-ThinkPad>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c672b661-1921-f61c-a118-d51c650e41f4@rasmusvillemoes.dk>
Date:   Fri, 12 Mar 2021 10:12:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312052812.GB137474@yury-ThinkPad>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/03/2021 06.28, Yury Norov wrote:
> On Fri, Feb 19, 2021 at 12:07:27AM +0100, Rasmus Villemoes wrote:
>> On 18/02/2021 05.05, Yury Norov wrote:
>>> Many algorithms become simpler if they are passed with relatively small
>>> input values. One example is bitmap operations when the whole bitmap fits
>>> into one word. To implement such simplifications, linux/bitmap.h declares
>>> small_const_nbits() macro.
>>>
>>> Other subsystems may also benefit from optimizations of this sort, like
>>> find_bit API in the following patches. So it looks helpful to generalize
>>> the macro and extend it's visibility.
>>
>> Perhaps, but SMALL_CONST is too generic a name, it needs to keep "bits"
>> somewhere in there. So why not just keep it at small_const_nbits?
>>
>>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>>> ---
>>>  include/asm-generic/bitsperlong.h |  2 ++
>>>  include/linux/bitmap.h            | 33 ++++++++++++++-----------------
>>>  2 files changed, 17 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
>>> index 3905c1c93dc2..0eeb77544f1d 100644
>>> --- a/include/asm-generic/bitsperlong.h
>>> +++ b/include/asm-generic/bitsperlong.h
>>> @@ -23,4 +23,6 @@
>>>  #define BITS_PER_LONG_LONG 64
>>>  #endif
>>>  
>>> +#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
>>> +
>>>  #endif /* __ASM_GENERIC_BITS_PER_LONG */
>>> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
>>> index adf7bd9f0467..e89f1dace846 100644
>>> --- a/include/linux/bitmap.h
>>> +++ b/include/linux/bitmap.h
>>> @@ -224,9 +224,6 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
>>>   * so make such users (should any ever turn up) call the out-of-line
>>>   * versions.
>>>   */
>>> -#define small_const_nbits(nbits) \
>>> -	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
>>> -
>>>  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
>>>  {
>>>  	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
>>> @@ -278,7 +275,7 @@ extern void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
>>>  static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
>>>  			const unsigned long *src2, unsigned int nbits)
>>>  {
>>> -	if (small_const_nbits(nbits))
>>> +	if (SMALL_CONST(nbits - 1))
>>
>> Please don't force most users to be changed to something less readable.
>> What's wrong with just keeping small_const_nbits() the way it is,
>> avoiding all this churn and keeping the readability?
> 
> The wrong thing is that it's defined in include/linux/bitmap.h, and I
> cannot use it in include/asm-generic/bitops/find.h, so I have to either
> move it to a separate header, or generalize and share with find.h and
> other users this way. I prefer the latter option, thougt it's more
> verbose.

The logical place would be the same place the BITS_PER_LONG macro is
defined, no? No need to introduce a new header for that, and all current
users of small_const_nbits() must already (very possibly indirectly)
include asm-generic/bitsperlong.h.

I do prefer to keep both the name small_const_nbits() and its current
semantics, which, although not currently spelled out that way anywhere,
is "is BITMAP_SIZE(nbits) known at compile time and equal to 1", which
is precisely what allows the static inlines to unconditionally
dereference the pointer (that's the "exclude the 0 case") and just deal
with that one word.

I don't like either SMALL_CONST or small_const_size, because nothing in
there says it has anything to do with bit ops. As I said, if you have
some special place that for some reason cannot handle
nbits==BITS_PER_LONG, then just add that as an additional constraint
with a comment why.

Rasmus
