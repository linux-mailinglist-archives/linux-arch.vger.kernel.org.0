Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59653D625
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jun 2022 10:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiFDIjL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Jun 2022 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiFDIjL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Jun 2022 04:39:11 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBAA12AD9
        for <linux-arch@vger.kernel.org>; Sat,  4 Jun 2022 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654331944; bh=wnJCQgiks65tnpwmZMojl0NF2945XgSFg2uzvwe7pss=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wEyiQnRVPqVt0gSLUcI34DRXfttQlUZSWpET7q2MfSrASkli3nYnkTpabPvKoUA0E
         pj72Yy1QE9tFubHb9oBzFl3YxgdwjYUMnNT4xoD904orix0eU0jQsa0M13J3mxOpFy
         CXLVbu3EGi+Wp4nIO9dsRIr7NJyWxEpT1P9GcmP4=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 7F0E7600FF;
        Sat,  4 Jun 2022 16:39:04 +0800 (CST)
Message-ID: <fefe35c1-4bcc-b8e8-6f3f-8d71209a2c13@xen0n.name>
Date:   Sat, 4 Jun 2022 16:39:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH] LoongArch: Fix copy_thread() build error
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220604080614.268078-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220604080614.268078-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/4/22 16:06, Huacai Chen wrote:
> Commit c5febea0956fd387 ("fork: Pass struct kernel_clone_args into
> copy_thread") change the prototype of copy_thread() and cause build
> error, fix it.
>
> Fixes: c5febea0956fd387 ("fork: Pass struct kernel_clone_args into copy_thread")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/kernel/process.c | 7 +++++--
>   include/linux/efi.h             | 1 +
>   include/linux/pe.h              | 2 ++
>   3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> index 6d944d65f600..5e090ffd16b9 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -120,10 +120,13 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>   /*
>    * Copy architecture-specific thread state
>    */
> -int copy_thread(unsigned long clone_flags, unsigned long usp,
> -	unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
> +int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   {
>   	unsigned long childksp;
> +	unsigned long tls = args->tls;
> +	unsigned long usp = args->stack;
> +	unsigned long clone_flags = args->flags;
> +	unsigned long kthread_arg = args->stack_size;
>   	struct pt_regs *childregs, *regs = current_pt_regs();
>   
>   	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
Please confirm if the patch is inadvertently truncated? I see there are 
3 files in the diffstat, yet only one hunk below.
