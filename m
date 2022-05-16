Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC61527C8E
	for <lists+linux-arch@lfdr.de>; Mon, 16 May 2022 05:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiEPDwL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 23:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiEPDvu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 23:51:50 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FDAEE19;
        Sun, 15 May 2022 20:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652673103; bh=Z71zRCq+dshK3U5Kgw1jKAD9VUgjjOItP3j/oz3YKXc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rulWXkCgxaSLAImIBl0wNW+vvtjmepp2O7Y1CDKpR0hscjCG1Or/EwLHqlhmHvcE7
         Bsq8Ad+d2rq9CnAw4fLwI8pGwXgm6ODQdbae50JVxhKkgyFz6ZdC2EYUy9nfWpcUNV
         RyKnEVek/UrVXNsPPNdONTnOru3nPlJXYXHI0yf0=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 5853060074;
        Mon, 16 May 2022 11:51:43 +0800 (CST)
Message-ID: <b30e5b28-2a3a-f3a6-1bb1-592323f6eadd@xen0n.name>
Date:   Mon, 16 May 2022 11:51:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V10 14/22] LoongArch: Add signal handling support
Content-Language: en-US
To:     Huacai Chen <chenhuacai@gmail.com>, WANG Xuerui <kernel@xen0n.name>
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
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-15-chenhuacai@loongson.cn>
 <ef37e578-d843-6a2f-2108-2a26dc54bece@xen0n.name>
 <CAAhV-H7UwLJLiMtjkW0xxfsBBaCPXqkQ-d+ZW4rm+=igvVP6ew@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H7UwLJLiMtjkW0xxfsBBaCPXqkQ-d+ZW4rm+=igvVP6ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 5/15/22 21:48, Huacai Chen wrote:
> diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
> new file mode 100644
> index 000000000000..efeb8b3f8236
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Author: Hanlu Li <lihanlu@loongson.cn>
> + *         Huacai Chen <chenhuacai@loongson.cn>
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _UAPI_ASM_SIGCONTEXT_H
> +#define _UAPI_ASM_SIGCONTEXT_H
> +
> +#include <linux/types.h>
> +#include <linux/posix_types.h>
> +
> +/* FP context was used */
> +#define USED_FP                      (1 << 0)
> +/* Load/Store access flags for address error */
> +#define ADRERR_RD            (1 << 30)
> +#define ADRERR_WR            (1 << 31)
>> I've searched GitHub globally, and my local glibc checkout, for usages
>> of these 3 constants, and there seems to be none; please consider
>> removing these if doable. We don't want cruft in uapi right from the
>> beginning.
> They will be used in our glibc, I promise.
Okay then. Seems simple enough, and from my quick grepping these appear 
to be original creations -- not carried over from somewhere else, so 
it's already highly likely that some of the userland tools need these 
anyway, just not released yet.
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
>>> +
>>> +/* FPU context */
>>> +#define FPU_CTX_MAGIC                0x46505501
>>> +#define FPU_CTX_ALIGN                8
>>> +struct fpu_context {
>>> +     __u64   regs[32];
>>> +     __u64   fcc;
>>> +     __u32   fcsr;
>>> +};
>> The 3 structs above should already see usage downstream (glibc and other
>> low-level friends), so they probably shouldn't be touched by now. At
>> least I can't see problems.
>>> +
>>> +/* LSX context */
>>> +#define LSX_CTX_MAGIC                0x53580001
>>> +#define LSX_CTX_ALIGN                16
>>> +struct lsx_context {
>>> +     __u64   regs[2*32];
>>> +     __u64   fcc;
>>> +     __u32   fcsr;
>>> +     __u32   vcsr;
>>> +};
>>> +
>>> +/* LASX context */
>>> +#define LASX_CTX_MAGIC               0x41535801
>>> +#define LASX_CTX_ALIGN               32
>>> +struct lasx_context {
>>> +     __u64   regs[4*32];
>>> +     __u64   fcc;
>>> +     __u32   fcsr;
>>> +     __u32   vcsr;
>>> +};
>> Do we want to freeze the LSX/LASX layout this early, before any detail
>> of said extension are published? We'll need to update kernel later
>> anyway, so I'd recommend leaving them out for the initial bring-up.
> Yes, they are freezed.
Okay too, I remember these are the same values as in the old world, so 
it should be easy to support both worlds at least in this regard.
>>> +
>>> +#endif /* _UAPI_ASM_SIGCONTEXT_H */
Then I have no problems with this patch then ;-)
