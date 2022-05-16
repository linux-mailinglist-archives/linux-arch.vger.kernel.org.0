Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAEF5287E0
	for <lists+linux-arch@lfdr.de>; Mon, 16 May 2022 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244682AbiEPPDG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 May 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEPPDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 May 2022 11:03:05 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4163B546;
        Mon, 16 May 2022 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652713378; bh=g2WNRPhTJkGKr3gGAVCpuHs4QwNIkre+XOqlLFTxREo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZYk45tK3RZHkE2O1xOgac3NkJ4XhYM66poTQ7PwYwQleliXHDQaVV2T1QuajbZybG
         DcoCsmRm34ALRnZCfuTAXjBU2Nqkm9LWiHJ3CMEt0jw1c9p5thbhfuJv0pGlu8GBD9
         zaeIH56QmV3058m0Yt+UMj+lnn6H0zS3hnR7JvOo=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id F226660691;
        Mon, 16 May 2022 23:02:57 +0800 (CST)
Message-ID: <6bb4c861-c310-18f8-f2f2-5c3f85c541b4@xen0n.name>
Date:   Mon, 16 May 2022 23:02:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V10 14/22] LoongArch: Add signal handling support
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-15-chenhuacai@loongson.cn>
 <ef37e578-d843-6a2f-2108-2a26dc54bece@xen0n.name>
 <CAAhV-H7UwLJLiMtjkW0xxfsBBaCPXqkQ-d+ZW4rm+=igvVP6ew@mail.gmail.com>
 <b30e5b28-2a3a-f3a6-1bb1-592323f6eadd@xen0n.name>
 <87bkvxd12b.fsf@email.froward.int.ebiederm.org>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <87bkvxd12b.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/16/22 22:06, Eric W. Biederman wrote:

> WANG Xuerui <kernel@xen0n.name> writes:
>
>> Hi,
>>
>> On 5/15/22 21:48, Huacai Chen wrote:
>>> diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
>>> new file mode 100644
>>> index 000000000000..efeb8b3f8236
>>> --- /dev/null
>>> +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
>>> @@ -0,0 +1,63 @@
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
>>> +#define USED_FP                      (1 << 0)
>>> +/* Load/Store access flags for address error */
>>> +#define ADRERR_RD            (1 << 30)
>>> +#define ADRERR_WR            (1 << 31)
>>>> I've searched GitHub globally, and my local glibc checkout, for usages
>>>> of these 3 constants, and there seems to be none; please consider
>>>> removing these if doable. We don't want cruft in uapi right from the
>>>> beginning.
>>> They will be used in our glibc, I promise.
>> Okay then. Seems simple enough, and from my quick grepping these appear to be
>> original creations -- not carried over from somewhere else, so it's already
>> highly likely that some of the userland tools need these anyway, just not
>> released yet.
> I can understand exporting these values but the names aren't very
> well namespaced at all.  Which means they could accidentially
> conflict with things.
>
> It would probably be better to do:
> SC_USED_FP
> SC_ADDRERR_RD
> SC_ADDRERR_WR
>
> And with two D's please.  It breaks my fingers to have to
> make a typo like that on purpose.
>
> This is very much a bikeshed comment, but I think the
> bikeshed should be painted.
IIUC, the ADRERR spelling is because of influence of BUS_ADRERR. But the 
prefix idea sounds good.
>>>>> +
>>>>> +struct sigcontext {
>>>>> +     __u64   sc_pc;
>>>>> +     __u64   sc_regs[32];
>>>>> +     __u32   sc_flags;
>>>>> +     __u64   sc_extcontext[0] __attribute__((__aligned__(16)));
>>>>> +};
>>>>> +
>>>>> +#define CONTEXT_INFO_ALIGN   16
>>>>> +struct _ctxinfo {
>>>>> +     __u32   magic;
>>>>> +     __u32   size;
>>>>> +     __u64   padding;        /* padding to 16 bytes */
>>>>> +};
>>>>> +
>>>>> +/* FPU context */
>>>>> +#define FPU_CTX_MAGIC                0x46505501
>>>>> +#define FPU_CTX_ALIGN                8
>>>>> +struct fpu_context {
>>>>> +     __u64   regs[32];
>>>>> +     __u64   fcc;
>>>>> +     __u32   fcsr;
>>>>> +};
>>>> The 3 structs above should already see usage downstream (glibc and other
>>>> low-level friends), so they probably shouldn't be touched by now. At
>>>> least I can't see problems.
>>>>> +
>>>>> +/* LSX context */
>>>>> +#define LSX_CTX_MAGIC                0x53580001
>>>>> +#define LSX_CTX_ALIGN                16
>>>>> +struct lsx_context {
>>>>> +     __u64   regs[2*32];
>>>>> +     __u64   fcc;
>>>>> +     __u32   fcsr;
>>>>> +     __u32   vcsr;
>>>>> +};
>>>>> +
>>>>> +/* LASX context */
>>>>> +#define LASX_CTX_MAGIC               0x41535801
>>>>> +#define LASX_CTX_ALIGN               32
>>>>> +struct lasx_context {
>>>>> +     __u64   regs[4*32];
>>>>> +     __u64   fcc;
>>>>> +     __u32   fcsr;
>>>>> +     __u32   vcsr;
>>>>> +};
>>>> Do we want to freeze the LSX/LASX layout this early, before any detail
>>>> of said extension are published? We'll need to update kernel later
>>>> anyway, so I'd recommend leaving them out for the initial bring-up.
>>> Yes, they are freezed.
>> Okay too, I remember these are the same values as in the old world, so it should
>> be easy to support both worlds at least in this regard.
> You know.  I really don't like this including code for hardware that may
> be frozen but is not publicly documented yet.  Especially when the plan
> is to publicly document the hardware.  It has the real problem that no
> one else can review the code.
>
> In ever design I have worked with there have been places where the
> people putting it together have had blind spots.  The only way I know to
> get past blind spots is to get as many people as possible looking,
> and to listen to the feedback.
>
> Given that neither lsx_context nor lasx_context are used in the kernel
> code yet I would very much prefer that their inclusion wait until there
> is actual code that needs them.
>
> If nothing else that will put the definitions in context so people can
> more easily see the big picture and understand how the pieces fit.

Hmm, thinking twice, the code actually doesn't get destroyed, nor 
magically "thawed" and modified, if not upstreamed initially; just that 
these same lines would go in later. Maybe I overlooked the problem 
because I've tried to reverse-engineer the LSX/LASX back in the MIPS 
days of Loongson, and that I've seen early version of the port that 
contained the same handling, so all of this come as familiar.

So actually removing the code is the sensible thing to do here. We don't 
really lose anything or waste too much time for that.

>
> Eric
