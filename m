Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE46952C188
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 19:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbiERRR0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbiERRRZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 13:17:25 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B812A1A076C;
        Wed, 18 May 2022 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652894240; bh=yVInD2ur8lshXLO5aqsUYWbjdUNfxk5T6cUDSenQZ3I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lZK46HNW4fJXLujCWUhLHT+kiSe/ZidY50cfUAUUDAHliDzwGoesdBndz3PXWbnzB
         qpzwN8AdlFv5eabPkHgztrrxQifxYbuzEEC5ghng/ZEs3Kl5AsOB8r0OUWXuDMS4cD
         9nVNUaEQyyYJ4q0alshFYulLAf8Uk+KSzeIcrhNg=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 4947960691;
        Thu, 19 May 2022 01:17:20 +0800 (CST)
Message-ID: <36f11c19-0cc5-cf56-b41d-6cad4878ddb3@xen0n.name>
Date:   Thu, 19 May 2022 01:17:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V11 14/22] LoongArch: Add signal handling support
Content-Language: en-US
To:     Huacai Chen <chenhuacai@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-15-chenhuacai@loongson.cn>
 <87ilq294mg.fsf@email.froward.int.ebiederm.org>
 <CAAhV-H5Aov1NVsbNWZa9psPhBiNssYWWEzNOyLooeXGKsYxN+w@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H5Aov1NVsbNWZa9psPhBiNssYWWEzNOyLooeXGKsYxN+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/19/22 00:54, Huacai Chen wrote:
> Hi, Eric,
>
> On Thu, May 19, 2022 at 12:40 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Huacai Chen <chenhuacai@loongson.cn> writes:
>>
>>> Add ucontext/sigcontext definition and signal handling support for
>>> LoongArch.
>>>
>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>>   arch/loongarch/include/uapi/asm/sigcontext.h |  44 ++
>>>   arch/loongarch/include/uapi/asm/signal.h     |  13 +
>>>   arch/loongarch/include/uapi/asm/ucontext.h   |  35 ++
>>>   arch/loongarch/kernel/signal.c               | 566 +++++++++++++++++++
>>>   4 files changed, 658 insertions(+)
>>>   create mode 100644 arch/loongarch/include/uapi/asm/sigcontext.h
>>>   create mode 100644 arch/loongarch/include/uapi/asm/signal.h
>>>   create mode 100644 arch/loongarch/include/uapi/asm/ucontext.h
>>>   create mode 100644 arch/loongarch/kernel/signal.c
>>>
>>> diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
>>> new file mode 100644
>>> index 000000000000..be3d3c6ac83e
>>> --- /dev/null
>>> +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
>>> @@ -0,0 +1,44 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>>> +/*
>>> + * Author: Hanlu Li <lihanlu@loongson.cn>
>>> + *         Huacai Chen <chenhuacai@loongson.cn>
>>> + *
>>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>>> + */
>>> +#ifndef _UAPI_ASM_SIGCONTEXT_H
>>> +#define _UAPI_ASM_SIGCONTEXT_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/posix_types.h>
>>> +
>>> +/* FP context was used */
>>> +#define SC_USED_FP           (1 << 0)
>>> +/* Address error was due to memory load */
>>> +#define SC_ADDRERR_RD                (1 << 30)
>>> +/* Address error was due to memory store */
>>> +#define SC_ADDRERR_WR                (1 << 31)
>>> +
>>> +struct sigcontext {
>>> +     __u64   sc_pc;
>>> +     __u64   sc_regs[32];
>>> +     __u32   sc_flags;
>>> +     __u64   sc_extcontext[0] __attribute__((__aligned__(16)));
>>> +};
>>> +
>>> +#define CONTEXT_INFO_ALIGN   16
>>> +struct _ctxinfo {
>>> +     __u32   magic;
>>> +     __u32   size;
>>> +     __u64   padding;        /* padding to 16 bytes */
>>> +};
>> This is probably something I a missing but what is struct _ctxinfo and
>> why is it in a uapi header?
>>
>> I don't see anything else in the uapi implementation using it.
> This is used by get_ctx_through_ctxinfo() in signal.c and I think
> similar function is also needed by userspace.
>
> Its name is once before called context_info but conflict with another
> software, then I want to use ctx_info but conflict with another kernel
> struct. :(
>> Symbols that start with an underscore "_" are reserved and should not
>> be used in general, and especially not in uapi header files.
> Then, maybe we can use sctx_info here?

Actually it seems to me that this struct is the header of each 
sc_extcontext; i.e. one struct sigcontext with 0~N trailing 
"sc_extcontext", and each "sc_extcontext" consists of one "struct 
_ctxinfo" header plus the real content. For now there's only the FPU 
context but the LSX/LASX/LBT contexts will come later. The "magic" and 
"size" fields also matches the definitions following.

So I'd suggest something like "struct sc_extcontext_head" while naming 
the individual contexts like "struct sc_extcontext_foo", e.g. "struct 
sc_extcontext_fpu". The "sc_extcontext" part could use some further 
abbreviation but the end result should be something intuitive.

>
> Huacai
>> Eric
