Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5D2DBB5
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 13:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfE2LXf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 07:23:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:48952 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfE2LXf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 May 2019 07:23:35 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hVwg1-00037i-FP; Wed, 29 May 2019 14:23:25 +0300
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
To:     Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
 <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net>
 <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net>
 <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <377465ba-3b31-31e7-0f9d-e0a5ab911ca4@virtuozzo.com>
Date:   Wed, 29 May 2019 14:23:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/29/19 1:57 PM, Dmitry Vyukov wrote:
> On Wed, May 29, 2019 at 12:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Wed, May 29, 2019 at 12:16:31PM +0200, Marco Elver wrote:
>>> On Wed, 29 May 2019 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>> On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
>>>>> For the default, we decided to err on the conservative side for now,
>>>>> since it seems that e.g. x86 operates only on the byte the bit is on.
>>>>
>>>> This is not correct, see for instance set_bit():
>>>>
>>>> static __always_inline void
>>>> set_bit(long nr, volatile unsigned long *addr)
>>>> {
>>>>         if (IS_IMMEDIATE(nr)) {
>>>>                 asm volatile(LOCK_PREFIX "orb %1,%0"
>>>>                         : CONST_MASK_ADDR(nr, addr)
>>>>                         : "iq" ((u8)CONST_MASK(nr))
>>>>                         : "memory");
>>>>         } else {
>>>>                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
>>>>                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
>>>>         }
>>>> }
>>>>
>>>> That results in:
>>>>
>>>>         LOCK BTSQ nr, (addr)
>>>>
>>>> when @nr is not an immediate.
>>>
>>> Thanks for the clarification. Given that arm64 already instruments
>>> bitops access to whole words, and x86 may also do so for some bitops,
>>> it seems fine to instrument word-sized accesses by default. Is that
>>> reasonable?
>>
>> Eminently -- the API is defined such; for bonus points KASAN should also
>> do alignment checks on atomic ops. Future hardware will #AC on unaligned
>> [*] LOCK prefix instructions.
>>
>> (*) not entirely accurate, it will only trap when crossing a line.
>>     https://lkml.kernel.org/r/1556134382-58814-1-git-send-email-fenghua.yu@intel.com
> 
> Interesting. Does an address passed to bitops also should be aligned,
> or alignment is supposed to be handled by bitops themselves?
> 

It should be aligned. This even documented in Documentation/core-api/atomic_ops.rst:

	Native atomic bit operations are defined to operate on objects aligned
	to the size of an "unsigned long" C data type, and are least of that
	size.  The endianness of the bits within each "unsigned long" are the
	native endianness of the cpu.


> This probably should be done as a separate config as not related to
> KASAN per se. But obviously via the same
> {atomicops,bitops}-instrumented.h hooks which will make it
> significantly easier.
> 

Agreed.
