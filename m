Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B706425DB
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 10:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiLEJe3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 04:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLEJeK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 04:34:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE636164A8;
        Mon,  5 Dec 2022 01:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4972760FE3;
        Mon,  5 Dec 2022 09:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C23CC433C1;
        Mon,  5 Dec 2022 09:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670232847;
        bh=hhxfe9O1j9bXMKcb6DIOoGo0OtXBulLjFf1+gfBvZV4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HAksjyRuFV+pe91zXzJTvXxyW4uss2YMpKYluA8Z/zOgcS5ED8J1iAhoArTh3JA/o
         bUCM+VdxaRtwByi8W1wPvgb9/3vwgWJuck+5RgnowSVlp2kiJb2iVua2NO/CILpc0H
         ngMBanq0ExROqw4OCKdGvENwFRZapvlh8hJwjTo2GxQ1Myd/aP6oRktX/C3aOaS4ln
         UMK5Ldmx2s7iCj0YxH74TaY55ZlH43G/xcUsGlT7ZBlGYC04BsYjmgnRXWt79/KPXE
         G8SN3tTKCGTcQYItgjDyPyB4jI56XiloAP7mqZLuMt1TJkeT+gALz9eh5flVSM5wLk
         dLT/gjNdb0XPg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH -next V8 04/14] riscv: ptrace: Remove duplicate operation
In-Reply-To: <20221103075047.1634923-5-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
 <20221103075047.1634923-5-guoren@kernel.org>
Date:   Mon, 05 Dec 2022 10:34:05 +0100
Message-ID: <87bkoi9otu.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Guo Ren <guoren@linux.alibaba.com>
>
> The TIF_SYSCALL_TRACE is controlled by a common code, see
> kernel/ptrace.c and include/linux/thread.h.

                                    ^^^ thread_info.h
>
> clear_task_syscall_work(child, SYSCALL_TRACE);
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/riscv/kernel/ptrace.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 2ae8280ae475..44f4b1ca315d 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -212,7 +212,6 @@ unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
>  
>  void ptrace_disable(struct task_struct *child)
>  {
> -	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
>  }
>  
>  long arch_ptrace(struct task_struct *child, long request,

This patch is also not neccesary for the series, but should be a
separate cleanup.
