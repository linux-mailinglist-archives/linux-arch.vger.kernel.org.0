Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFBC591982
	for <lists+linux-arch@lfdr.de>; Sat, 13 Aug 2022 11:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiHMJG4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Aug 2022 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJGz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Aug 2022 05:06:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3611312D3E;
        Sat, 13 Aug 2022 02:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D88A8B80E91;
        Sat, 13 Aug 2022 09:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB70C433D6;
        Sat, 13 Aug 2022 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660381611;
        bh=IE71pC3gJVMYiIDCJlQv5lk5MCb5GFtiPfcKFxGxJCA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Igg7WX9TFQbWMKTIXdog9DeE8Lh4G0chFA+s5gsR3wCiixdtiCavfPTWoJBC69CdG
         hmAYvi+xngkR0IWzaqKd2rJEX+TAHLbDlEGaQvAOe8M0jzmvPsV7ONxp48nt00x7Q+
         /jg12h9qopKoqpXn+I6QJzneoiJCtR+d7upX8CG3wPtVnixxbQvVXRT0mEDJCkbm64
         hRoLjrE69l3HPWjZOdQH2Ggcn+T59u+JeBDoL5jcrH01F2LxPjK4bgNKlaQOvcU6Oo
         Lgb25wY6wKxZvwJA/E+GDq2jGUL6T9LH8Japu589nNs1ZKE3NmM7BS5HgLJMybVLbH
         LKBuLcy7+fkXw==
Received: by mail-oi1-f173.google.com with SMTP id n133so3625870oib.0;
        Sat, 13 Aug 2022 02:06:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo0e0IjaYHe0B6VXOdC36YcWb9iXK5hhXaYEElP1nRLL3Jo8Lgdq
        kbN5xArwcT6Zedv8+SrHkvEbLO01QvZI7xA+/OY=
X-Google-Smtp-Source: AA6agR5OYg7fwlhu7JgYZ/mi/oE1LdDX1hVxq6qSWkkpHJmVRIpAgnyBXIoROAz8FlxXqZz4JnQlfDYTUYh8X0INdg4=
X-Received: by 2002:a05:6808:2028:b0:344:246d:2bed with SMTP id
 q40-20020a056808202800b00344246d2bedmr938060oiw.19.1660381610789; Sat, 13 Aug
 2022 02:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220813085839.58414-1-guoren@kernel.org>
In-Reply-To: <20220813085839.58414-1-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 13 Aug 2022 17:06:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR61ojv4wmZUxZ_Kv+uKN+FjnKjBrwWL_sFVzH_Fe+W8g@mail.gmail.com>
Message-ID: <CAJF2gTR61ojv4wmZUxZ_Kv+uKN+FjnKjBrwWL_sFVzH_Fe+W8g@mail.gmail.com>
Subject: Re: [PATCH] loongarch: irq: Move to generic_handle_arch_irq
To:     chenhuacai@kernel.org, kernel@xen0n.name, zhangqing@loongson.cn,
        arnd@arndb.de, linux-arch@vger.kernel.org, mark.rutland@arm.com,
        frederic@kernel.org
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        jiaxun.yang@flygoat.com, yangtiezhu@loongson.cn,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Abandon this patch because of the wrong commit log. Please see
"[RESEND PATCH] loongarch: irq: Move to generic_handle_arch_irq".

On Sat, Aug 13, 2022 at 4:58 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> No reason to keep custom handle_loongarch_irq, and move to the generic
> one. No reason to keep custom handle_loongarch_irq, and move to the
> generic one. The patch also the fixup HAVE_CONTEXT_TRACKING_USER
> feature, because handle_loongarch_irq missed ct_irq_enter/exit.
>
> Fixes: 0603839b18f4 ("LoongArch: Add exception/interrupt handling")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/loongarch/kernel/traps.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index aa1c95aaf595..06211640ba1f 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -588,17 +588,6 @@ asmlinkage void cache_parity_error(void)
>         panic("Can't handle the cache error!");
>  }
>
> -asmlinkage void noinstr handle_loongarch_irq(struct pt_regs *regs)
> -{
> -       struct pt_regs *old_regs;
> -
> -       irq_enter_rcu();
> -       old_regs = set_irq_regs(regs);
> -       handle_arch_irq(regs);
> -       set_irq_regs(old_regs);
> -       irq_exit_rcu();
> -}
> -
>  asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
>  {
>         register int cpu;
> @@ -608,7 +597,7 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
>         cpu = smp_processor_id();
>
>         if (on_irq_stack(cpu, sp))
> -               handle_loongarch_irq(regs);
> +               generic_handle_arch_irq(regs);
>         else {
>                 stack = per_cpu(irq_stack, cpu) + IRQ_STACK_START;
>
> @@ -619,7 +608,7 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
>                 "move   $s0, $sp                \n" /* Preserve sp */
>                 "move   $sp, %[stk]             \n" /* Switch stack */
>                 "move   $a0, %[regs]            \n"
> -               "bl     handle_loongarch_irq    \n"
> +               "bl     generic_handle_arch_irq \n"
>                 "move   $sp, $s0                \n" /* Restore sp */
>                 : /* No outputs */
>                 : [stk] "r" (stack), [regs] "r" (regs)
> --
> 2.36.1
>


-- 
Best Regards
 Guo Ren
