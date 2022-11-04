Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439E561A374
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 22:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKDViB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 17:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiKDVhx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 17:37:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E4C4B99D
        for <linux-arch@vger.kernel.org>; Fri,  4 Nov 2022 14:37:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g7so9071268lfv.5
        for <linux-arch@vger.kernel.org>; Fri, 04 Nov 2022 14:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvSWpxJgGl2A+yuTtFFpWgClmp36FYJZSW8HWdXrt58=;
        b=aQCjWQq9itbtlAHPWgZJ2akFWRpo1nfp/o0HYGdZRWAWjrKKYjkZwNf3TJCjGr3+iw
         lztqvPmWUnww+WpH5I2pgE0BPb/wfvX6IH/JB8uDHnxssHR6FaHs3tOLFH1vvSaJrw5p
         BoMxVLfhg97/92Q5ChBY1JuLkjl/CiCAyRCk1JGQe3EVaU/8s9qLkT/rUchQ4smvoVU5
         HxGF/7qT9whWKKeuTFs2OoSdWoz4WRuH0h09Sc7oTQjzH6aGy3ZKmtMmP8RGGWJMTopb
         SQg9fvVhBkClGARk14E73QP7efmSwL/9ipoDD4++q30bZ8yXB0mN4DU1u4bibRKik8fW
         G1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvSWpxJgGl2A+yuTtFFpWgClmp36FYJZSW8HWdXrt58=;
        b=z+I90BlGwWdOAiwC7lDduL9/+k9i/geAy5MAKUVVX7nLa1c8X2H5Q4Mpy6aOrnDv5K
         wUBXXwYVfPSi5CnsfWgtfIH7tjezG+T/CNPJZth9ihNhpOngE3zZjGWyAzAdkHmKLe2I
         MocR89mMnwWNN9PBsEZEbz3ezRRORAdwC/zrSEOP0rH5YbJAEjHdJKGYi5qoxkVilxbP
         fRr+Flc/EY984TxHDloVNmUdH50/PytbZgJg2RoLmSbFKXaYSwNxxlHOjbzfZgrdbzRx
         5YG7PGrIFrO+JnMpjjgkqo7AuYHqoJnt2nHzTgmpkUnOzM34FjctJtWP4zluuG0HB8HM
         FkVQ==
X-Gm-Message-State: ACrzQf25lFWRb9vKZ4LtwRnewJt7g8l2Ipy4ssfgwVWtSUCU8LaWEqpk
        yzr5oZIauMJepjUGtilXhCDNR3JY1eCh7A==
X-Google-Smtp-Source: AMsMyM6pxHxMT0FlYTCZm1EKL1Elt3l5nMSi/KgrXNQr3YqAI2f3xC0M9rJRxWsv16xDhMMP16z9Eg==
X-Received: by 2002:a05:6512:e83:b0:4a2:cdaa:5e3e with SMTP id bi3-20020a0565120e8300b004a2cdaa5e3emr13578764lfb.308.1667597859685;
        Fri, 04 Nov 2022 14:37:39 -0700 (PDT)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id k19-20020a192d13000000b00492b0d23d24sm34468lfj.247.2022.11.04.14.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:37:38 -0700 (PDT)
Date:   Sat, 5 Nov 2022 00:37:37 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: Re: [RFC PATCH v1] riscv: support for hardware
 breakpoints/watchpoints
Message-ID: <Y2WGIQ+m7jk5RPZv@curiosity>
References: <20221031213225.912258-1-geomatsi@gmail.com>
 <CALE4mHo2yFPpF68RvvDbKji6_peAX60_cXqnFMxydJTLjnLnUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALE4mHo2yFPpF68RvvDbKji6_peAX60_cXqnFMxydJTLjnLnUQ@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

> > RISC-V Debug specification includes Sdtrig ISA extension. This extension
> > describes Trigger Module. Triggers can cause a breakpoint exception,
> > entry into Debug Mode, or a trace action without having to execute a
> > special instruction. For native debugging triggers can be used to
> > implement hardware breakpoints and watchpoints.

... [snip]

> > Despite missing userspace debug, initial implementation can be tested
> > on QEMU using kernel breakpoints, e.g. see samples/hw_breakpoint and
> > register_wide_hw_breakpoint. Hardware breakpoints work on upstream QEMU.
> 
> We should also be able to enable the use of HW breakpoints (and
> watchpoints, modulo the issue mentioned below) in kdb, right?

Interesting. So far I didn't think about using hw breakpoints in kgdb.
I took a quick look at riscv and arm64 kgdb code. It looks like there
is nothing wrong in adding arch-specific implementation of the function
'kgdb_arch_set_breakpoint' that will use hw breakpoints if possible.
Besides it looks like in this case it makes sense to handle KGDB earlier
than hw breakpoints in do_trap_break. 

> > However this is not the case for watchpoints since there is no way to
> > figure out which watchpoint is triggered. IIUC there are two possible
> > options for doing this: using 'hit' bit in tdata1 or reading faulting
> > virtual address from STVAL. QEMU implements neither of them. Current
> > implementation opts for STVAL. So the following experimental QEMU patch
> > is required to make watchpoints work:
> >
> > :  diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > :  index 278d163803..8858be7411 100644
> > :  --- a/target/riscv/cpu_helper.c
> > :  +++ b/target/riscv/cpu_helper.c
> > :  @@ -1639,6 +1639,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> > :           case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
> > :               tval = env->bins;
> > :               break;
> > :  +        case RISCV_EXCP_BREAKPOINT:
> > :  +            tval = env->badaddr;
> > :  +            env->badaddr = 0x0;
> > :  +            break;
> > :           default:
> > :               break;
> > :           }
> > :  diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> > :  index 26ea764407..b4d1d566ab 100644
> > :  --- a/target/riscv/debug.c
> > :  +++ b/target/riscv/debug.c
> > :  @@ -560,6 +560,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
> > :
> > :       if (cs->watchpoint_hit) {
> > :           if (cs->watchpoint_hit->flags & BP_CPU) {
> > :  +            env->badaddr = cs->watchpoint_hit->hitaddr;
> > :               cs->watchpoint_hit = NULL;
> > :               do_trigger_action(env, DBG_ACTION_BP);
> > :           }

... [snip]

> > +int arch_install_hw_breakpoint(struct perf_event *bp)
> > +{
> > +       struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > +       struct sbi_dbtr_data_msg *xmit;
> > +       struct sbi_dbtr_id_msg *recv;
> > +       struct perf_event **slot;
> > +       struct sbiret ret;
> > +       int err = 0;
> > +
> > +       xmit = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*xmit)), GFP_ATOMIC);
> > +       if (!xmit) {
> > +               err = -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       recv = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*recv)), GFP_ATOMIC);
> > +       if (!recv) {
> > +               err = -ENOMEM;
> > +               goto out;
> > +       }
> 
> Do these really need to be dynamically allocated?

According to SBI extension proposal, base address of this memory chunk
must be 16-bytes aligned. To simplify things, buffer with 'power of two
bytes' size (and >= 16 bytes) is allocated. In this case alignment of
the kmalloc buffer is guaranteed to be at least this size. IIUC more
efforts are needed to guarantee such alignment for a buffer on stack.
 
> > +
> > +       xmit->tdata1 = info->trig_data1.value;
> > +       xmit->tdata2 = info->trig_data2;
> > +       xmit->tdata3 = info->trig_data3;
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_INSTALL,
> > +                       1, __pa(xmit) >> 4, __pa(recv) >> 4,
> > +                       0, 0, 0);
> > +       if (ret.error) {
> > +               pr_warn("%s: failed to install trigger\n", __func__);
> > +               err = -EIO;
> > +               goto out;
> > +       }
> > +
> > +       if (recv->idx >= dbtr_total_num) {
> > +               pr_warn("%s: invalid trigger index %lu\n", __func__, recv->idx);
> > +               err = -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       slot = this_cpu_ptr(&bp_per_reg[recv->idx]);
> > +       if (*slot) {
> > +               pr_warn("%s: slot %lu is in use\n", __func__, recv->idx);
> > +               err = -EBUSY;
> > +               goto out;
> > +       }
> > +
> > +       *slot = bp;
> > +
> > +out:
> > +       kfree(xmit);
> > +       kfree(recv);
> > +
> > +       return err;
> > +}

... [snip]

> > +static int __init arch_hw_breakpoint_init(void)
> > +{
> > +       union riscv_dbtr_tdata1 tdata1;
> > +       struct sbiret ret;
> > +
> > +       if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
> > +               pr_info("%s: SBI_EXT_DBTR is not supported\n", __func__);
> > +               return 0;
> > +       }
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > +                       0, 0, 0, 0, 0, 0);
> > +       if (ret.error) {
> > +               pr_warn("%s: failed to detect triggers\n", __func__);
> > +               return 0;
> > +       }
> > +
> > +       pr_info("%s: total number of triggers: %lu\n", __func__, ret.value);
> > +
> > +       tdata1.value = 0;
> > +       tdata1.type = RISCV_DBTR_TRIG_MCONTROL6;
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > +                       tdata1.value, 0, 0, 0, 0, 0);
> > +       if (ret.error) {
> > +               pr_warn("%s: failed to detect triggers\n", __func__);
> > +               dbtr_total_num = 0;
> > +               return 0;
> > +       }
> 
> nit: This is basically identical to hw_breakpoint_slots() -- just call
> it here, or perhaps pull the DBTR_NUM_TRIGGERS ECALL into its own
> function to reduce the duplication, e.g. 'dbtr_num_triggers(unsigned
> long type)'?

Good point. More similar requests will be added, e.g. for MCONTROL and
possibly other trigger types. So I will add a separate
'dbtr_num_triggers' function.

> > +
> > +       pr_info("%s: total number of type %d triggers: %lu\n",
> > +               __func__, tdata1.type, ret.value);
> > +
> > +       dbtr_total_num = ret.value;
> > +
> > +       return 0;
> > +}

Thanks!
Sergey
