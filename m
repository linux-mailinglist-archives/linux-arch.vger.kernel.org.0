Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3961D8FE
	for <lists+linux-arch@lfdr.de>; Sat,  5 Nov 2022 10:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKEJK5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Nov 2022 05:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEJKz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Nov 2022 05:10:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F48E26117
        for <linux-arch@vger.kernel.org>; Sat,  5 Nov 2022 02:10:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sc25so18693860ejc.12
        for <linux-arch@vger.kernel.org>; Sat, 05 Nov 2022 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/S4Nm/C1Ue9AZYxd9MIbfz68XRVc7JF1TnQINz4VAIQ=;
        b=cR/1Oo66x/Brv/JEj+qO1hbi3kih15mf9A3s7lxPdYH+0l1tJmlCIbcTTHkeWpDBRP
         Cxy1GAFj9LlnWPbnGkJXZ5Xm7j93DRWWog8SugNO1B2kelqp1quoK0GnIp7FX4Vg+2bP
         /et+yWe2ceBGTwztAALuWlDYCiuxkdTErlEXs01nqvj7Lfpx9v8zX3n/x+/61J04FCH+
         Xa2p3ScsbyZeb+z9cLaFW/aJBplRA6k+G5pNh/WYc1wW2vAvc6lYfQ1eMx6tkRXjLgJW
         LSfrwuyeVRplBVzBheixxhPyrMbsygWH9AEKFjcZadqivu5rr9fdJMJ87AzBTqXmE/TO
         EJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/S4Nm/C1Ue9AZYxd9MIbfz68XRVc7JF1TnQINz4VAIQ=;
        b=wpLMvFRJZiwa54jkx3BkaKx/bOU/N8x6eL53IZ4dXFIRiqiV90r5XxJS9Tc8rYKsYn
         Lstj+nXhRamqBsOeq38hPUuGnsVJv290m+inPAYV4DHcqPsaVLxkomfxzu7yemuezWFc
         SCXBKy6vfS7C3DQg4/LvJ4zxR9e/49Dw3AnWf1LqbeRaPKRDGkkEdUTBTOaTTOhNNVVs
         HuXeLRa/LwKDilg9ndirPD6Lcrs3uV8g47LOLyhV8Q4J1HLUGIyFV22liirw1GK6CEHq
         g5PrQLJ9gXI/xtXUdAdX9RbU90f21tVKtdSSleBnk8CH9VTE4w0jz6rAUZtMKyE7YALq
         Earw==
X-Gm-Message-State: ACrzQf14RHzLt+bSbxTL6K9j7/DHgfd5uHJqR5iMsLtBS0ulYL3VrHlI
        vx4l7cxSxb66x4o7eb2eKxCq3BOjgTG/ujIINSxAzg==
X-Google-Smtp-Source: AMsMyM5K/jvxRswoU4vnLuI5/+nOJ+I6WDcT5/WPAL6zKOeDQXmn7rJGWo+qao3LTg0DgaufUCRjBldD4YyYzK7MkFo=
X-Received: by 2002:a17:906:dac8:b0:741:545b:796a with SMTP id
 xi8-20020a170906dac800b00741545b796amr38075449ejb.240.1667639446681; Sat, 05
 Nov 2022 02:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221031213225.912258-1-geomatsi@gmail.com> <CALE4mHo2yFPpF68RvvDbKji6_peAX60_cXqnFMxydJTLjnLnUQ@mail.gmail.com>
 <Y2WGIQ+m7jk5RPZv@curiosity>
In-Reply-To: <Y2WGIQ+m7jk5RPZv@curiosity>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 5 Nov 2022 14:40:34 +0530
Message-ID: <CAAhSdy0bZsX1CCYvGJjHH4bXMJZU7eZ7dLcYR87CV4UaS+Kgeg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] riscv: support for hardware breakpoints/watchpoints
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     Andrew Bresticker <abrestic@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 5, 2022 at 3:07 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> Hi Andrew,
>
> > > RISC-V Debug specification includes Sdtrig ISA extension. This extension
> > > describes Trigger Module. Triggers can cause a breakpoint exception,
> > > entry into Debug Mode, or a trace action without having to execute a
> > > special instruction. For native debugging triggers can be used to
> > > implement hardware breakpoints and watchpoints.
>
> ... [snip]
>
> > > Despite missing userspace debug, initial implementation can be tested
> > > on QEMU using kernel breakpoints, e.g. see samples/hw_breakpoint and
> > > register_wide_hw_breakpoint. Hardware breakpoints work on upstream QEMU.
> >
> > We should also be able to enable the use of HW breakpoints (and
> > watchpoints, modulo the issue mentioned below) in kdb, right?
>
> Interesting. So far I didn't think about using hw breakpoints in kgdb.
> I took a quick look at riscv and arm64 kgdb code. It looks like there
> is nothing wrong in adding arch-specific implementation of the function
> 'kgdb_arch_set_breakpoint' that will use hw breakpoints if possible.
> Besides it looks like in this case it makes sense to handle KGDB earlier
> than hw breakpoints in do_trap_break.
>
> > > However this is not the case for watchpoints since there is no way to
> > > figure out which watchpoint is triggered. IIUC there are two possible
> > > options for doing this: using 'hit' bit in tdata1 or reading faulting
> > > virtual address from STVAL. QEMU implements neither of them. Current
> > > implementation opts for STVAL. So the following experimental QEMU patch
> > > is required to make watchpoints work:
> > >
> > > :  diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > :  index 278d163803..8858be7411 100644
> > > :  --- a/target/riscv/cpu_helper.c
> > > :  +++ b/target/riscv/cpu_helper.c
> > > :  @@ -1639,6 +1639,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> > > :           case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
> > > :               tval = env->bins;
> > > :               break;
> > > :  +        case RISCV_EXCP_BREAKPOINT:
> > > :  +            tval = env->badaddr;
> > > :  +            env->badaddr = 0x0;
> > > :  +            break;
> > > :           default:
> > > :               break;
> > > :           }
> > > :  diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> > > :  index 26ea764407..b4d1d566ab 100644
> > > :  --- a/target/riscv/debug.c
> > > :  +++ b/target/riscv/debug.c
> > > :  @@ -560,6 +560,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
> > > :
> > > :       if (cs->watchpoint_hit) {
> > > :           if (cs->watchpoint_hit->flags & BP_CPU) {
> > > :  +            env->badaddr = cs->watchpoint_hit->hitaddr;
> > > :               cs->watchpoint_hit = NULL;
> > > :               do_trigger_action(env, DBG_ACTION_BP);
> > > :           }
>
> ... [snip]
>
> > > +int arch_install_hw_breakpoint(struct perf_event *bp)
> > > +{
> > > +       struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > > +       struct sbi_dbtr_data_msg *xmit;
> > > +       struct sbi_dbtr_id_msg *recv;
> > > +       struct perf_event **slot;
> > > +       struct sbiret ret;
> > > +       int err = 0;
> > > +
> > > +       xmit = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*xmit)), GFP_ATOMIC);
> > > +       if (!xmit) {
> > > +               err = -ENOMEM;
> > > +               goto out;
> > > +       }
> > > +
> > > +       recv = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*recv)), GFP_ATOMIC);
> > > +       if (!recv) {
> > > +               err = -ENOMEM;
> > > +               goto out;
> > > +       }
> >
> > Do these really need to be dynamically allocated?
>
> According to SBI extension proposal, base address of this memory chunk
> must be 16-bytes aligned. To simplify things, buffer with 'power of two
> bytes' size (and >= 16 bytes) is allocated. In this case alignment of
> the kmalloc buffer is guaranteed to be at least this size. IIUC more
> efforts are needed to guarantee such alignment for a buffer on stack.

Stack is not appropriate for this. Please use a per-CPU global
data for this purpose which should be 16 byte aligned as well.

You may also allocate a per-CPU 4K page at boot-time where
CPU X will use it's own 4K page for xmit (upper half) and
recv (lower half).

Regards,
Anup

>
> > > +
> > > +       xmit->tdata1 = info->trig_data1.value;
> > > +       xmit->tdata2 = info->trig_data2;
> > > +       xmit->tdata3 = info->trig_data3;
> > > +
> > > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_INSTALL,
> > > +                       1, __pa(xmit) >> 4, __pa(recv) >> 4,
> > > +                       0, 0, 0);
> > > +       if (ret.error) {
> > > +               pr_warn("%s: failed to install trigger\n", __func__);
> > > +               err = -EIO;
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (recv->idx >= dbtr_total_num) {
> > > +               pr_warn("%s: invalid trigger index %lu\n", __func__, recv->idx);
> > > +               err = -EINVAL;
> > > +               goto out;
> > > +       }
> > > +
> > > +       slot = this_cpu_ptr(&bp_per_reg[recv->idx]);
> > > +       if (*slot) {
> > > +               pr_warn("%s: slot %lu is in use\n", __func__, recv->idx);
> > > +               err = -EBUSY;
> > > +               goto out;
> > > +       }
> > > +
> > > +       *slot = bp;
> > > +
> > > +out:
> > > +       kfree(xmit);
> > > +       kfree(recv);
> > > +
> > > +       return err;
> > > +}
>
> ... [snip]
>
> > > +static int __init arch_hw_breakpoint_init(void)
> > > +{
> > > +       union riscv_dbtr_tdata1 tdata1;
> > > +       struct sbiret ret;
> > > +
> > > +       if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
> > > +               pr_info("%s: SBI_EXT_DBTR is not supported\n", __func__);
> > > +               return 0;
> > > +       }
> > > +
> > > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > > +                       0, 0, 0, 0, 0, 0);
> > > +       if (ret.error) {
> > > +               pr_warn("%s: failed to detect triggers\n", __func__);
> > > +               return 0;
> > > +       }
> > > +
> > > +       pr_info("%s: total number of triggers: %lu\n", __func__, ret.value);
> > > +
> > > +       tdata1.value = 0;
> > > +       tdata1.type = RISCV_DBTR_TRIG_MCONTROL6;
> > > +
> > > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > > +                       tdata1.value, 0, 0, 0, 0, 0);
> > > +       if (ret.error) {
> > > +               pr_warn("%s: failed to detect triggers\n", __func__);
> > > +               dbtr_total_num = 0;
> > > +               return 0;
> > > +       }
> >
> > nit: This is basically identical to hw_breakpoint_slots() -- just call
> > it here, or perhaps pull the DBTR_NUM_TRIGGERS ECALL into its own
> > function to reduce the duplication, e.g. 'dbtr_num_triggers(unsigned
> > long type)'?
>
> Good point. More similar requests will be added, e.g. for MCONTROL and
> possibly other trigger types. So I will add a separate
> 'dbtr_num_triggers' function.
>
> > > +
> > > +       pr_info("%s: total number of type %d triggers: %lu\n",
> > > +               __func__, tdata1.type, ret.value);
> > > +
> > > +       dbtr_total_num = ret.value;
> > > +
> > > +       return 0;
> > > +}
>
> Thanks!
> Sergey
