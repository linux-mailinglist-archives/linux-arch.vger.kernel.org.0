Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73D552768E
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 11:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiEOJUa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 05:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiEOJU3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 05:20:29 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8AC18E0C;
        Sun, 15 May 2022 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652606422; bh=K+t+73P0OJHpvhXeE0o3aQOX0ORvL1BWBaZ6rStzBaQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QnP7oL+rFHqI00ojDu4Q4L1nWt0PWmGubZJOgzXJTRtPlCMft9TZVnNf0XquLd+8Y
         cAYnLuwAKfD/pHYJj/FLXAxftqsXDmrmO0Po9AOu0v4dVI3Qpb9GF/tnoa1At44/is
         VlZVLTxOM32t8Y5jJDhgVF+UEIYcG0z7BIcxfuYo=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id AE210600B5;
        Sun, 15 May 2022 17:20:21 +0800 (CST)
Message-ID: <8c6b0c27-26e3-6668-06b2-57dd27f77496@xen0n.name>
Date:   Sun, 15 May 2022 17:20:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V10 11/22] LoongArch: Add process management
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
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-12-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220514080402.2650181-12-chenhuacai@loongson.cn>
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

On 5/14/22 16:03, Huacai Chen wrote:
> Add process management support for LoongArch, including: thread info
> definition, context switch and process tracing.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/fpu.h         | 129 +++++++
>   arch/loongarch/include/asm/idle.h        |   9 +
>   arch/loongarch/include/asm/mmu.h         |  16 +
>   arch/loongarch/include/asm/mmu_context.h | 152 ++++++++
>   arch/loongarch/include/asm/processor.h   | 209 +++++++++++
>   arch/loongarch/include/asm/ptrace.h      | 152 ++++++++
>   arch/loongarch/include/asm/switch_to.h   |  37 ++
>   arch/loongarch/include/asm/thread_info.h | 106 ++++++
>   arch/loongarch/include/uapi/asm/ptrace.h |  52 +++
>   arch/loongarch/kernel/fpu.S              | 264 ++++++++++++++
>   arch/loongarch/kernel/idle.c             |  16 +
>   arch/loongarch/kernel/process.c          | 260 ++++++++++++++
>   arch/loongarch/kernel/ptrace.c           | 431 +++++++++++++++++++++++
>   arch/loongarch/kernel/switch.S           |  35 ++
>   14 files changed, 1868 insertions(+)
>   create mode 100644 arch/loongarch/include/asm/fpu.h
>   create mode 100644 arch/loongarch/include/asm/idle.h
>   create mode 100644 arch/loongarch/include/asm/mmu.h
>   create mode 100644 arch/loongarch/include/asm/mmu_context.h
>   create mode 100644 arch/loongarch/include/asm/processor.h
>   create mode 100644 arch/loongarch/include/asm/ptrace.h
>   create mode 100644 arch/loongarch/include/asm/switch_to.h
>   create mode 100644 arch/loongarch/include/asm/thread_info.h
>   create mode 100644 arch/loongarch/include/uapi/asm/ptrace.h
>   create mode 100644 arch/loongarch/kernel/fpu.S
>   create mode 100644 arch/loongarch/kernel/idle.c
>   create mode 100644 arch/loongarch/kernel/process.c
>   create mode 100644 arch/loongarch/kernel/ptrace.c
>   create mode 100644 arch/loongarch/kernel/switch.S

The context handling code already saw use in released version of strace 
[1] [2], so it appears appropriate to consider the user-space additions 
to be in a reasonably good shape already.

Reviewed-by: WANG Xuerui <git@xen0n.name>

[1]: https://github.com/strace/strace/pull/205
[2]: https://github.com/strace/strace/pull/207

