Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5413C52BFAD
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbiERQNl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiERQNg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 12:13:36 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D191E011D;
        Wed, 18 May 2022 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652890408; bh=JZ/umXW1BGSt1/z+uE4svncYRr0FcuqSnCI25i7a5Ho=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dnSn784KVjHWto1/GJceQf4qHrnCdSxrLcdinanIGqOVulpmfmIGWzChrJ+jhhzgC
         2FyM6lSRIVz1QqfWF3s5pi3gz5rd3fyALs0WoFCHOHqS3jEv3IC4l47Wx1lGBPHSrY
         ZtQPX/XQhhDBfEhTXFEac0caIXRkuU6b/qbP0O+k=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 2914A60691;
        Thu, 19 May 2022 00:13:28 +0800 (CST)
Message-ID: <739ba6e4-d11b-44a0-c5fc-6fb430d10d5a@xen0n.name>
Date:   Thu, 19 May 2022 00:13:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V11 14/22] LoongArch: Add signal handling support
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-15-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220518092619.1269111-15-chenhuacai@loongson.cn>
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

On 5/18/22 17:26, Huacai Chen wrote:
> Add ucontext/sigcontext definition and signal handling support for
> LoongArch.
>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/uapi/asm/sigcontext.h |  44 ++
>   arch/loongarch/include/uapi/asm/signal.h     |  13 +
>   arch/loongarch/include/uapi/asm/ucontext.h   |  35 ++
>   arch/loongarch/kernel/signal.c               | 566 +++++++++++++++++++
>   4 files changed, 658 insertions(+)
>   create mode 100644 arch/loongarch/include/uapi/asm/sigcontext.h
>   create mode 100644 arch/loongarch/include/uapi/asm/signal.h
>   create mode 100644 arch/loongarch/include/uapi/asm/ucontext.h
>   create mode 100644 arch/loongarch/kernel/signal.c
>
> diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
> new file mode 100644
> index 000000000000..be3d3c6ac83e
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
> @@ -0,0 +1,44 @@
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
> +#define SC_USED_FP		(1 << 0)
> +/* Address error was due to memory load */
> +#define SC_ADDRERR_RD		(1 << 30)
> +/* Address error was due to memory store */
> +#define SC_ADDRERR_WR		(1 << 31)

Looks nice.

BTW: following some communication it appears that the SC_ADDRERR_* 
constants are not tightly coupled to BUS_ADRERR after all, so the 
spelling is "fixed".

I don't have anything more to comment, because the rest are either 
reviewed or non-userspace-ABI that don't exactly require getting right 
from the beginning. (Not to say they're flawed.)

Reviewed-by: WANG Xuerui <git@xen0n.name>

