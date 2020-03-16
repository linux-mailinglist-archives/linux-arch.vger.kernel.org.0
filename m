Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6819B186EA4
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 16:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbgCPPdJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 11:33:09 -0400
Received: from foss.arm.com ([217.140.110.172]:50670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731505AbgCPPdJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 11:33:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F0F41FB;
        Mon, 16 Mar 2020 08:33:08 -0700 (PDT)
Received: from [10.37.9.38] (unknown [10.37.9.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EBBC3F534;
        Mon, 16 Mar 2020 08:33:03 -0700 (PDT)
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp> <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
 <20200316103437.GD3005@mbp> <77a2e91a-58f4-3ba3-9eef-42d6a8faf859@arm.com>
 <20200316112205.GE3005@mbp> <9a0a9285-8a45-4f65-3a83-813cabd0f0d3@arm.com>
 <20200316144346.GF3005@mbp>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <427064ee-45df-233c-0281-69e3d62ba784@arm.com>
Date:   Mon, 16 Mar 2020 15:33:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200316144346.GF3005@mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 3/16/20 2:43 PM, Catalin Marinas wrote[...]

>> To me does not seem optimized out. Which version of the compiler are you using?
> 
> I misread the #ifdef'ery in asm/processor.h. So with 4K pages,
> TASK_SIZE_32 is (1UL<<32)-PAGE_SIZE. However, with 64K pages _and_
> CONFIG_KUSER_HELPERS, TASK_SIZE_32 is 1UL<<32 and the check is removed
> by the compiler.
> 
> With the 4K build, __vdso_clock_gettime starts as:
> 
> 00000194 <__vdso_clock_gettime>:
>  194:   f511 5f80       cmn.w   r1, #4096       ; 0x1000
>  198:   d214            bcs.n   1c4 <__vdso_clock_gettime+0x30>
>  19a:   b5b0            push    {r4, r5, r7, lr}
>  ...
>  1c4:   f06f 000d       mvn.w   r0, #13
>  1c8:   4770            bx      lr
> 
> With 64K pages:
> 
> 00000194 <__vdso_clock_gettime>:
>  194:   b5b0            push    {r4, r5, r7, lr}
>  ...
>  1be:   bdb0            pop     {r4, r5, r7, pc}
> 
> I haven't tried but it's likely that the vdsotest fails with 64K pages
> and compat enabled (requires EXPERT).
>

This makes more sense. Thanks for the clarification.

I agree on the behavior of 64K pages and I think as well that the
"compatibility" issue is still there. However as you correctly stated in your
first email arm32 never supported 16K or 64K pages, hence I think we should not
be concerned about compatibility in this cases.

To make it more explicit we could make COMPAT_VDSO on arm64 depend on
ARM64_4K_PAGES. What do you think?

>> Please find below the list of errors for clock_gettime (similar for the other):
>>
>> passing UINTPTR_MAX to clock_gettime (VDSO): terminated by unexpected signal 7
>> clock-gettime-monotonic/abi: 1 failures/inconsistencies encountered
> 
> Ah, so it uses UINTPTR_MAX in the test. Fair enough but I don't think
> the arm64 check is entirely useful. On arm32, the check was meant to
> return -EFAULT for addresses beyond TASK_SIZE that may enter into the
> kernel or module space. On arm64 compat, the kernel space is well above
> the reach of the 32-bit code.
> 
> If you want to preserve some compatibility for this specific test, what
> about checking for wrapping around 0, I think it would make more sense.
> Something like:
> 
> 	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
> 

Ok, sounds good to me. But it is something that this patch series inherited,
hence I would prefer to send a separate patch that introduces what you are
proposing and removes TASK_SIZE_32 from the headers. How does it sound?

-- 
Regards,
Vincenzo
