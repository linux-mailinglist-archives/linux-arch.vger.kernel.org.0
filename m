Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B16E642F8B
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 19:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiLESBE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 13:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiLESAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 13:00:39 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0A1B1C5
        for <linux-arch@vger.kernel.org>; Mon,  5 Dec 2022 10:00:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id x22so355531ejs.11
        for <linux-arch@vger.kernel.org>; Mon, 05 Dec 2022 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OTxU34tkj39G1aWSGFb5j48Mzj7TOWDGiuSjGzpbZz0=;
        b=KG9AuH9GKNntYdmBy35gI24xW/mhiKXzpeCgjhzPh+kg1+HEuQXd0gX1AYLfLqY+o8
         AdrD4JpDbfX8pSBGWzFRoOm+8vSpySjLhRXESACOwFbRm1EZkMH7kUaD6r+vRgW07Aj5
         rhcenk+NMO+aajnw2DDG3e1sH+hgj23t5jrvIlMioyrUAji4QP31aobbnD+JKMUBX4XL
         igKdTrY4/51bWd4Wzpts6lFfErmGXNkZk+ySRwCFr3pjQkgMAU7GIYNDGFosgZy9r85i
         exsWJZn1Pa4LenAk0POacBKL0JPX9tdhuriUmLot9Ohlx9syLdnNuWIWz+cPHDhUg7JS
         cboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTxU34tkj39G1aWSGFb5j48Mzj7TOWDGiuSjGzpbZz0=;
        b=KzK4pbNCwjV9jhG2A6hIj6ggxEfrp8Valbxj5RvQAv1hvzq8d/NCWBMx+mzS9axS7o
         oD7B9/2M9noln/BqOq6y2yhN7lo7IXb2wKaAwdWxPd7Q+rGadNv5tB1EmTWstPK/WSEP
         6gfq3h7cmXR9I0GQojPALM5m+UUGYHOCrStENkmXMNkFgkyZwP/iqwIpfzpWrJ4U4p+u
         1NHavpYHKA2/QuO1Spg90DifHH4aYUOiA7So/pSHJ+cyB9zkVkOgx/7tAEOchZcoLGzE
         28cuaUqzDJoWGQIpylyK/LDFthKQgKPjXT4fegxxe2wGBpI2eLSO/A1M4INs5LER/NF1
         hqnQ==
X-Gm-Message-State: ANoB5pmGZVaY6Av3iRbY0JTRYmOE9iXDcmWEFZYTnjF+Q+YMqWbRR7NS
        3FAk/8f3jfihw1sjV+rri+vFcRPgLowMf4okXbhoVw==
X-Google-Smtp-Source: AA0mqf6jGm6nEQQBAFFzNRAYYTbSbuaQ8l8GIB85YR3v2N0Tp1qS7z/vIkl1kDQBEnux2yayFRdRmfpV+/tg69zv6Gs=
X-Received: by 2002:a17:906:6782:b0:7ad:7d50:dec2 with SMTP id
 q2-20020a170906678200b007ad7d50dec2mr73437273ejp.37.1670263236237; Mon, 05
 Dec 2022 10:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20221203215535.208948-1-geomatsi@gmail.com> <20221203215535.208948-4-geomatsi@gmail.com>
In-Reply-To: <20221203215535.208948-4-geomatsi@gmail.com>
From:   Andrew Bresticker <abrestic@rivosinc.com>
Date:   Mon, 5 Dec 2022 13:00:25 -0500
Message-ID: <CALE4mHrrxTJaQ5YYZamS9GmNhGopiUA3jk5+iw1XAn=8=XT=fg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/3] riscv: hw-breakpoints: add more trigger controls
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sergey,

On Sat, Dec 3, 2022 at 4:55 PM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
>
> RISC-V SBI Debug Trigger extension proposal defines multiple functions
> to control debug triggers. The pair of install/uninstall functions was
> enough to implement ptrace interface for user-space debug. This patch
> implements kernel wrappers for start/update/stop SBI functions. The
> intended users of these control wrappers are kgdb and kernel modules
> that make use of kernel-wide hardware breakpoints and watchpoints.
>
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

<snip>

> diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
> index 5bb3b55cd464..afc59f8e034e 100644
> --- a/arch/riscv/include/asm/hw_breakpoint.h
> +++ b/arch/riscv/include/asm/hw_breakpoint.h
> @@ -137,6 +137,9 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>  int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>                                     unsigned long val, void *data);
>
> +void arch_enable_hw_breakpoint(struct perf_event *bp);
> +void arch_update_hw_breakpoint(struct perf_event *bp);
> +void arch_disable_hw_breakpoint(struct perf_event *bp);
>  int arch_install_hw_breakpoint(struct perf_event *bp);
>  void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>  void hw_breakpoint_pmu_read(struct perf_event *bp);
> @@ -153,5 +156,17 @@ static inline void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
>  {
>  }
>
> +void arch_enable_hw_breakpoint(struct perf_event *bp)
> +{
> +}
> +
> +void arch_update_hw_breakpoint(struct perf_event *bp)
> +{
> +}
> +
> +void arch_disable_hw_breakpoint(struct perf_event *bp)
> +{
> +}

I don't see any references to {enable,update,disable}_hw_breakpoint in
common kernel code, nor do any other architectures define these
functions. Who are the intended users? Do we even need them for kgdb
on RISC-V?

> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
> index 8eddf512cd03..ca7df02830c2 100644
> --- a/arch/riscv/kernel/hw_breakpoint.c
> +++ b/arch/riscv/kernel/hw_breakpoint.c
> @@ -2,6 +2,7 @@
>
>  #include <linux/hw_breakpoint.h>
>  #include <linux/perf_event.h>
> +#include <linux/spinlock.h>
>  #include <linux/percpu.h>
>  #include <linux/kdebug.h>
>
> @@ -9,6 +10,8 @@
>
>  /* bps/wps currently set on each debug trigger for each cpu */
>  static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM_MAX]);
> +static DEFINE_PER_CPU(unsigned long, msg_lock_flags);
> +static DEFINE_PER_CPU(raw_spinlock_t, msg_lock);

I'm not sure I understand the point of this per-CPU spinlock. Just
disable preemption (and interrupts, if necessary).

Also, arch_{install,uninstall}_hw_breakpoint are already expected to
be called from atomic context; is the intention here that they be
callable from outside atomic context?

-Andrew

>
>  static struct sbi_dbtr_data_msg __percpu *sbi_xmit;
>  static struct sbi_dbtr_id_msg __percpu *sbi_recv;
> @@ -318,6 +321,10 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>         struct perf_event **slot;
>         unsigned long idx;
>         struct sbiret ret;
> +       int err = 0;
> +
> +       raw_spin_lock_irqsave(this_cpu_ptr(&msg_lock),
> +                         *this_cpu_ptr(&msg_lock_flags));
>
>         xmit->tdata1 = cpu_to_lle(info->trig_data1.value);
>         xmit->tdata2 = cpu_to_lle(info->trig_data2);
> @@ -328,25 +335,31 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>                         0, 0, 0);
>         if (ret.error) {
>                 pr_warn("%s: failed to install trigger\n", __func__);
> -               return -EIO;
> +               err = -EIO;
> +               goto done;
>         }
>
>         idx = lle_to_cpu(recv->idx);
>
>         if (idx >= dbtr_total_num) {
>                 pr_warn("%s: invalid trigger index %lu\n", __func__, idx);
> -               return -EINVAL;
> +               err = -EINVAL;
> +               goto done;
>         }
>
>         slot = this_cpu_ptr(&bp_per_reg[idx]);
>         if (*slot) {
>                 pr_warn("%s: slot %lu is in use\n", __func__, idx);
> -               return -EBUSY;
> +               err = -EBUSY;
> +               goto done;
>         }
>
>         *slot = bp;
>
> -       return 0;
> +done:
> +       raw_spin_unlock_irqrestore(this_cpu_ptr(&msg_lock),
> +                              *this_cpu_ptr(&msg_lock_flags));
> +       return err;
>  }
>
>  /* atomic: counter->ctx->lock is held */
> @@ -375,6 +388,96 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
>                 pr_warn("%s: failed to uninstall trigger %d\n", __func__, i);
>  }
>
> +void arch_enable_hw_breakpoint(struct perf_event *bp)
> +{
> +       struct sbiret ret;
> +       int i;
> +
> +       for (i = 0; i < dbtr_total_num; i++) {
> +               struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> +
> +               if (*slot == bp)
> +                       break;
> +       }
> +
> +       if (i == dbtr_total_num) {
> +               pr_warn("%s: unknown breakpoint\n", __func__);
> +               return;
> +       }
> +
> +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_ENABLE,
> +                       i, 1, 0, 0, 0, 0);
> +       if (ret.error) {
> +               pr_warn("%s: failed to install trigger %d\n", __func__, i);
> +               return;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(arch_enable_hw_breakpoint);
> +
> +void arch_update_hw_breakpoint(struct perf_event *bp)
> +{
> +       struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +       struct sbi_dbtr_data_msg *xmit = this_cpu_ptr(sbi_xmit);
> +       struct perf_event **slot;
> +       struct sbiret ret;
> +       int i;
> +
> +       for (i = 0; i < dbtr_total_num; i++) {
> +               slot = this_cpu_ptr(&bp_per_reg[i]);
> +
> +               if (*slot == bp)
> +                       break;
> +       }
> +
> +       if (i == dbtr_total_num) {
> +               pr_warn("%s: unknown breakpoint\n", __func__);
> +               return;
> +       }
> +
> +       raw_spin_lock_irqsave(this_cpu_ptr(&msg_lock),
> +                         *this_cpu_ptr(&msg_lock_flags));
> +
> +       xmit->tdata1 = cpu_to_lle(info->trig_data1.value);
> +       xmit->tdata2 = cpu_to_lle(info->trig_data2);
> +       xmit->tdata3 = cpu_to_lle(info->trig_data3);
> +
> +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UPDATE,
> +                       i, 1, __pa(xmit) >> 4,
> +                       0, 0, 0);
> +       if (ret.error)
> +               pr_warn("%s: failed to update trigger %d\n", __func__, i);
> +
> +       raw_spin_unlock_irqrestore(this_cpu_ptr(&msg_lock),
> +                              *this_cpu_ptr(&msg_lock_flags));
> +}
> +EXPORT_SYMBOL_GPL(arch_update_hw_breakpoint);
> +
> +void arch_disable_hw_breakpoint(struct perf_event *bp)
> +{
> +       struct sbiret ret;
> +       int i;
> +
> +       for (i = 0; i < dbtr_total_num; i++) {
> +               struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> +
> +               if (*slot == bp)
> +                       break;
> +       }
> +
> +       if (i == dbtr_total_num) {
> +               pr_warn("%s: unknown breakpoint\n", __func__);
> +               return;
> +       }
> +
> +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_DISABLE,
> +                       i, 1, 0, 0, 0, 0);
> +       if (ret.error) {
> +               pr_warn("%s: failed to uninstall trigger %d\n", __func__, i);
> +               return;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(arch_disable_hw_breakpoint);
> +
>  void hw_breakpoint_pmu_read(struct perf_event *bp)
>  {
>  }
> @@ -406,6 +509,8 @@ void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
>
>  static int __init arch_hw_breakpoint_init(void)
>  {
> +       unsigned int cpu;
> +
>         sbi_xmit = __alloc_percpu(sizeof(*sbi_xmit), SZ_16);
>         if (!sbi_xmit) {
>                 pr_warn("failed to allocate SBI xmit message buffer\n");
> @@ -418,6 +523,9 @@ static int __init arch_hw_breakpoint_init(void)
>                 return -ENOMEM;
>         }
>
> +       for_each_possible_cpu(cpu)
> +               raw_spin_lock_init(&per_cpu(msg_lock, cpu));
> +
>         if (!dbtr_init)
>                 arch_hw_breakpoint_init_sbi();
>
> --
> 2.38.1
>
