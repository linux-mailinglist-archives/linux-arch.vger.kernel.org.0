Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B955813E4
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jul 2022 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiGZNKg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 09:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiGZNKf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 09:10:35 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6249B248DC
        for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2022 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1658841029; bh=x7WA91iRfVC/BGSIei4xY4J8WmyeNkSfsaRtinGLAiI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tL+o7eG0RiJRCJC5Xp9ynC2sLs9/1+KBqnbIblJPH3Z1yqWRonjpXJSMZTShLOfG9
         ePdaU/hbxc1MnoVncF7mUqHzyeq6OYXGp84eDLNavMqr942vSLHS/07iRg3N1Mlawx
         jca2Wsv4wbjuD8gtCr8I3DiClQBf8ijYrbL2H/tY=
Received: from [100.100.35.250] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 6F5FD60104;
        Tue, 26 Jul 2022 21:10:29 +0800 (CST)
Message-ID: <c873f358-628a-72d9-42e3-5f40354745b1@xen0n.name>
Date:   Tue, 26 Jul 2022 21:10:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH] LoongArch: Disable executable stack by default
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220726130224.3987623-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220726130224.3987623-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022/7/26 21:02, Huacai Chen wrote:
> Disable executable stack for LoongArch by default, as all modern
> architectures do.

I don't know why this slipped in under everyone's eyes... Struggling to 
recall some of my mental activities during the initial review, I may be 
not too familiar with the code at that time (maybe still the case now), 
and didn't check what exactly "read_implies_exec" means in this 
particular context. That could be just the reason for my part.

But better mention the discussion leading to the discovery of this bug: 
"The problematic behavior was initially discovered by Andreas Schwab in 
a binutils discussion [1], fix suggested by WANG Xuerui" or something 
along the line.

[1]: https://sourceware.org/pipermail/binutils/2022-July/121992.html

> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/elf.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
> index f3960b18a90e..5f3ff4781fda 100644
> --- a/arch/loongarch/include/asm/elf.h
> +++ b/arch/loongarch/include/asm/elf.h
> @@ -288,8 +288,6 @@ struct arch_elf_state {
>   	.interp_fp_abi = LOONGARCH_ABI_FP_ANY,	\
>   }
>   
> -#define elf_read_implies_exec(ex, exec_stk) (exec_stk == EXSTACK_DEFAULT)
> -
>   extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
>   			    bool is_interp, struct arch_elf_state *state);
>   

I've tested the same change on my local test branch and can confirm 
nothing is broken. Actually, no visible changes whatsoever, everything 
is just the same.

Tested-by: WANG Xuerui <git@xen0n.name>

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

