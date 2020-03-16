Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810D6186902
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 11:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgCPK2v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 06:28:51 -0400
Received: from foss.arm.com ([217.140.110.172]:45530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730550AbgCPK2v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 06:28:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 236D31FB;
        Mon, 16 Mar 2020 03:28:50 -0700 (PDT)
Received: from [10.37.9.38] (unknown [10.37.9.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E38D43F534;
        Mon, 16 Mar 2020 03:28:45 -0700 (PDT)
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp> <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
 <20200316102214.GA5746@lakrids.cambridge.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c1ebab37-4df5-a763-129c-bb088cc0b151@arm.com>
Date:   Mon, 16 Mar 2020 10:29:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200316102214.GA5746@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 3/16/20 10:22 AM, Mark Rutland wrote:
> Hi Vincenzo,
> 
> On Mon, Mar 16, 2020 at 09:42:32AM +0000, Vincenzo Frascino wrote:
>> On 3/15/20 6:30 PM, Catalin Marinas wrote:
>>> On Fri, Mar 13, 2020 at 03:43:37PM +0000, Vincenzo Frascino wrote:
>>>> --- /dev/null
>>>> +++ b/arch/arm64/include/asm/vdso/processor.h
>>>> @@ -0,0 +1,31 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (C) 2020 ARM Ltd.
>>>> + */
>>>> +#ifndef __ASM_VDSO_PROCESSOR_H
>>>> +#define __ASM_VDSO_PROCESSOR_H
>>>> +
>>>> +#ifndef __ASSEMBLY__
>>>> +
>>>> +#include <asm/page-def.h>
>>>> +
>>>> +#ifdef CONFIG_COMPAT
>>>> +#if defined(CONFIG_ARM64_64K_PAGES) && defined(CONFIG_KUSER_HELPERS)
>>>> +/*
>>>> + * With CONFIG_ARM64_64K_PAGES enabled, the last page is occupied
>>>> + * by the compat vectors page.
>>>> + */
>>>> +#define TASK_SIZE_32		UL(0x100000000)
>>>> +#else
>>>> +#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
>>>> +#endif /* CONFIG_ARM64_64K_PAGES */
>>>> +#endif /* CONFIG_COMPAT */
>>>
>>> Just curious, what's TASK_SIZE_32 used for in the vDSO code? You don't
>>> seem to move TASK_SIZE.
>>>
>>
>> I tried to fine grain the headers as much as I could in order to avoid
>> unneeded/unwanted inclusions:
>>  * TASK_SIZE_32 is used to verify ABI consistency on vdso32 (please refer to
>>    arch/arm64/kernel/vdso32/vgettimeofday.c).
>>  * TASK_SIZE is not required by the vdso library hence it is not present in
>>    these headers.
> 
> It would be worth noting the former point in the commit message, since
> it can be surprising.
>

Sure it is a good point, I will add this to the commit message.

> I also think it's worth keeping the definitions together if that's easy,
> as it makes it easier to navigate the codebase, even if TASK_SIZE isn't
> necessary for the VDSO itself.

This can't be done because TASK_SIZE on arm64 requires test_thread_flag() with
is not suited for vDSO. In other words can cause the same problem we are trying
to solve.

> 
> Thanks,
> Mark.
> 

-- 
Regards,
Vincenzo
