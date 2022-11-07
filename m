Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B645A61FBDE
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 18:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiKGRuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 12:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiKGRuN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 12:50:13 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E084F1BE91
        for <linux-arch@vger.kernel.org>; Mon,  7 Nov 2022 09:50:11 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id n83so12925439oif.11
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2022 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEIMn8yqnncddf2soubhdtYLY8R/bDuksYkV1v2yJJ8=;
        b=gsWIhAmJkCj/pDqvlfTvmGGHXTec+3xsAlHiGqvich0ae/2X0dr3YdhOdvpU8fu7p3
         03o79I4zjzsK+JnNAGz1SZVnLLeG0/3zpmjWta6Bdw3TfJNncQhOP644oV2Sk+wCNAE/
         E4oCbDuXXOl96XPJQP0y6G7hzPUo5GBDnWrLZogb2YhZ/ohSq17hTwIajq7JEcBdFTF/
         Ei0GRQi19yMFHYqYmiq7jUmkdEhVURMmD9L93TKH+JaoAXpZfLIgroINO+90FsgJJSKc
         HRxUq+sMt3csfRVC3js6oXGKaQLqbA2TZgIgUqSuEK9MmSpVZRFomAlZ3H1u1I8pBCFX
         uLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEIMn8yqnncddf2soubhdtYLY8R/bDuksYkV1v2yJJ8=;
        b=PYTQ8zSfIx4rej3Btx/GLf/QhFw0EQeM1IH6r1uRAZAhAPVT8/6C2mEJC8/9hen/j2
         a0nuZ56p2IEdrk1LGQ3pk8n6DRNpVOBd362DXW0+IWY2OSR3puYJGIM+pQJJPi8aBiwl
         a/axVmnWmST7Nn3cXl1MMRJ2xNydavFRt0AF7gjhzUVuC6TalqF5+6RO8SGXy9FcIBDj
         wMoUlVB5bTeEVBfc7zy3yjxtUl/KJ53UJUu1WO1nfNjUFhKPHleTZhml4MRtIy9PCkaQ
         eauHDFSEZyeAfOdlzcTcaJ0RFBkNuRaVWMSZvDex61UE4anTMDr5xiqe9cZBjHRYg472
         hdSg==
X-Gm-Message-State: ACrzQf21GceVVX8jiKES1ZHo2dF/6G2YCuJI22j1bY6NP92FfkDePWeA
        AiAhKq+GYQlPVktCzwjPqyopFrHxpqb3kfEnEWKt+g==
X-Google-Smtp-Source: AMsMyM66pCOdJZ3V3LrQphyPnVqAcg7VvWLLBfKE2G3RaoEuSGRdx3sOMPWvfL7ss8o7lxFOP/iSzgbjo5DJMCZMnUQ=
X-Received: by 2002:a05:6808:e88:b0:351:2725:ed84 with SMTP id
 k8-20020a0568080e8800b003512725ed84mr34709844oil.17.1667843410876; Mon, 07
 Nov 2022 09:50:10 -0800 (PST)
MIME-Version: 1.0
References: <20221031213225.912258-1-geomatsi@gmail.com> <CALE4mHo2yFPpF68RvvDbKji6_peAX60_cXqnFMxydJTLjnLnUQ@mail.gmail.com>
 <Y2WGIQ+m7jk5RPZv@curiosity> <CAAhSdy0bZsX1CCYvGJjHH4bXMJZU7eZ7dLcYR87CV4UaS+Kgeg@mail.gmail.com>
 <CALE4mHq0+iJju23rDKQiR1PbY-2Cy0jqRCkCKBBOy6JB4e_z3Q@mail.gmail.com>
 <CAK9=C2UmfeY2JJ9YLH6Ve392N9LrY2jdNi6CFADMNQgN=vVFxg@mail.gmail.com> <CALE4mHp2vvv3tFVsDHn_hCrN7iF2aTugsu57cSXE=wrxq7wa2w@mail.gmail.com>
In-Reply-To: <CALE4mHp2vvv3tFVsDHn_hCrN7iF2aTugsu57cSXE=wrxq7wa2w@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 7 Nov 2022 23:19:59 +0530
Message-ID: <CAK9=C2V_DZ+8jQ0Dg+P7sbke_SPzOnYydfwNGc-P0abvBkWB-A@mail.gmail.com>
Subject: Re: [RFC PATCH v1] riscv: support for hardware breakpoints/watchpoints
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 7, 2022 at 10:55 PM Andrew Bresticker <abrestic@rivosinc.com> wrote:
>
> On Mon, Nov 7, 2022 at 11:06 AM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Mon, Nov 7, 2022 at 8:21 PM Andrew Bresticker <abrestic@rivosinc.com> wrote:
> > >
> > > On Sat, Nov 5, 2022 at 5:10 AM Anup Patel <anup@brainfault.org> wrote:
> > > >
> > > > On Sat, Nov 5, 2022 at 3:07 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> > > > >
> > > > > Hi Andrew,
> > > > >
> > > > > > > RISC-V Debug specification includes Sdtrig ISA extension. This extension
> > > > > > > describes Trigger Module. Triggers can cause a breakpoint exception,
> > > > > > > entry into Debug Mode, or a trace action without having to execute a
> > > > > > > special instruction. For native debugging triggers can be used to
> > > > > > > implement hardware breakpoints and watchpoints.
> > > > >
> > > > > ... [snip]
> > > > >
> > > > > > > Despite missing userspace debug, initial implementation can be tested
> > > > > > > on QEMU using kernel breakpoints, e.g. see samples/hw_breakpoint and
> > > > > > > register_wide_hw_breakpoint. Hardware breakpoints work on upstream QEMU.
> > > > > >
> > > > > > We should also be able to enable the use of HW breakpoints (and
> > > > > > watchpoints, modulo the issue mentioned below) in kdb, right?
> > > > >
> > > > > Interesting. So far I didn't think about using hw breakpoints in kgdb.
> > > > > I took a quick look at riscv and arm64 kgdb code. It looks like there
> > > > > is nothing wrong in adding arch-specific implementation of the function
> > > > > 'kgdb_arch_set_breakpoint' that will use hw breakpoints if possible.
> > > > > Besides it looks like in this case it makes sense to handle KGDB earlier
> > > > > than hw breakpoints in do_trap_break.
> > > > >
> > > > > > > However this is not the case for watchpoints since there is no way to
> > > > > > > figure out which watchpoint is triggered. IIUC there are two possible
> > > > > > > options for doing this: using 'hit' bit in tdata1 or reading faulting
> > > > > > > virtual address from STVAL. QEMU implements neither of them. Current
> > > > > > > implementation opts for STVAL. So the following experimental QEMU patch
> > > > > > > is required to make watchpoints work:
> > > > > > >
> > > > > > > :  diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > > > > > :  index 278d163803..8858be7411 100644
> > > > > > > :  --- a/target/riscv/cpu_helper.c
> > > > > > > :  +++ b/target/riscv/cpu_helper.c
> > > > > > > :  @@ -1639,6 +1639,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> > > > > > > :           case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
> > > > > > > :               tval = env->bins;
> > > > > > > :               break;
> > > > > > > :  +        case RISCV_EXCP_BREAKPOINT:
> > > > > > > :  +            tval = env->badaddr;
> > > > > > > :  +            env->badaddr = 0x0;
> > > > > > > :  +            break;
> > > > > > > :           default:
> > > > > > > :               break;
> > > > > > > :           }
> > > > > > > :  diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> > > > > > > :  index 26ea764407..b4d1d566ab 100644
> > > > > > > :  --- a/target/riscv/debug.c
> > > > > > > :  +++ b/target/riscv/debug.c
> > > > > > > :  @@ -560,6 +560,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
> > > > > > > :
> > > > > > > :       if (cs->watchpoint_hit) {
> > > > > > > :           if (cs->watchpoint_hit->flags & BP_CPU) {
> > > > > > > :  +            env->badaddr = cs->watchpoint_hit->hitaddr;
> > > > > > > :               cs->watchpoint_hit = NULL;
> > > > > > > :               do_trigger_action(env, DBG_ACTION_BP);
> > > > > > > :           }
> > > > >
> > > > > ... [snip]
> > > > >
> > > > > > > +int arch_install_hw_breakpoint(struct perf_event *bp)
> > > > > > > +{
> > > > > > > +       struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > > > > > > +       struct sbi_dbtr_data_msg *xmit;
> > > > > > > +       struct sbi_dbtr_id_msg *recv;
> > > > > > > +       struct perf_event **slot;
> > > > > > > +       struct sbiret ret;
> > > > > > > +       int err = 0;
> > > > > > > +
> > > > > > > +       xmit = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*xmit)), GFP_ATOMIC);
> > > > > > > +       if (!xmit) {
> > > > > > > +               err = -ENOMEM;
> > > > > > > +               goto out;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       recv = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*recv)), GFP_ATOMIC);
> > > > > > > +       if (!recv) {
> > > > > > > +               err = -ENOMEM;
> > > > > > > +               goto out;
> > > > > > > +       }
> > > > > >
> > > > > > Do these really need to be dynamically allocated?
> > > > >
> > > > > According to SBI extension proposal, base address of this memory chunk
> > > > > must be 16-bytes aligned. To simplify things, buffer with 'power of two
> > > > > bytes' size (and >= 16 bytes) is allocated. In this case alignment of
> > > > > the kmalloc buffer is guaranteed to be at least this size. IIUC more
> > > > > efforts are needed to guarantee such alignment for a buffer on stack.
> > >
> > > You should be able to declare the struct with __aligned(16) to get the
> > > desired alignment on the stack.
> > >
> > > > Stack is not appropriate for this. Please use a per-CPU global
> > > > data for this purpose which should be 16 byte aligned as well.
> > >
> > > Is the desire to not use the stack purely a defensive measure, i.e. to
> > > defend against a buggy or malicious firmware/hypervisor? That's fine,
> > > I'm just curious if there's rationale beyond that (though I'd argue
> > > we're already implicitly trusting whatever software is sitting below
> > > us).
> >
> > The kernel stack is fixed size so it is best to avoid large structures
> > or arrays on kernel stack.
>
> Of course, though I'm not sure I'd consider 32 bytes "large" :)

The current patch only configures one trigger at a time but if
we are configuring multiple triggers in one-go then the trigger
array will grow.

Regards,
Anup

>
> -Andrew
>
> >
> > Regards,
> > Anup
> >
> > >
> > > -Andrew
> > >
> > > >
> > > > You may also allocate a per-CPU 4K page at boot-time where
> > > > CPU X will use it's own 4K page for xmit (upper half) and
> > > > recv (lower half).
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > > >
> > > > > > > +
> > > > > > > +       xmit->tdata1 = info->trig_data1.value;
> > > > > > > +       xmit->tdata2 = info->trig_data2;
> > > > > > > +       xmit->tdata3 = info->trig_data3;
> > > > > > > +
> > > > > > > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_INSTALL,
> > > > > > > +                       1, __pa(xmit) >> 4, __pa(recv) >> 4,
> > > > > > > +                       0, 0, 0);
> > > > > > > +       if (ret.error) {
> > > > > > > +               pr_warn("%s: failed to install trigger\n", __func__);
> > > > > > > +               err = -EIO;
> > > > > > > +               goto out;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       if (recv->idx >= dbtr_total_num) {
> > > > > > > +               pr_warn("%s: invalid trigger index %lu\n", __func__, recv->idx);
> > > > > > > +               err = -EINVAL;
> > > > > > > +               goto out;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       slot = this_cpu_ptr(&bp_per_reg[recv->idx]);
> > > > > > > +       if (*slot) {
> > > > > > > +               pr_warn("%s: slot %lu is in use\n", __func__, recv->idx);
> > > > > > > +               err = -EBUSY;
> > > > > > > +               goto out;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       *slot = bp;
> > > > > > > +
> > > > > > > +out:
> > > > > > > +       kfree(xmit);
> > > > > > > +       kfree(recv);
> > > > > > > +
> > > > > > > +       return err;
> > > > > > > +}
> > > > >
> > > > > ... [snip]
> > > > >
> > > > > > > +static int __init arch_hw_breakpoint_init(void)
> > > > > > > +{
> > > > > > > +       union riscv_dbtr_tdata1 tdata1;
> > > > > > > +       struct sbiret ret;
> > > > > > > +
> > > > > > > +       if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
> > > > > > > +               pr_info("%s: SBI_EXT_DBTR is not supported\n", __func__);
> > > > > > > +               return 0;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > > > > > > +                       0, 0, 0, 0, 0, 0);
> > > > > > > +       if (ret.error) {
> > > > > > > +               pr_warn("%s: failed to detect triggers\n", __func__);
> > > > > > > +               return 0;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       pr_info("%s: total number of triggers: %lu\n", __func__, ret.value);
> > > > > > > +
> > > > > > > +       tdata1.value = 0;
> > > > > > > +       tdata1.type = RISCV_DBTR_TRIG_MCONTROL6;
> > > > > > > +
> > > > > > > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > > > > > > +                       tdata1.value, 0, 0, 0, 0, 0);
> > > > > > > +       if (ret.error) {
> > > > > > > +               pr_warn("%s: failed to detect triggers\n", __func__);
> > > > > > > +               dbtr_total_num = 0;
> > > > > > > +               return 0;
> > > > > > > +       }
> > > > > >
> > > > > > nit: This is basically identical to hw_breakpoint_slots() -- just call
> > > > > > it here, or perhaps pull the DBTR_NUM_TRIGGERS ECALL into its own
> > > > > > function to reduce the duplication, e.g. 'dbtr_num_triggers(unsigned
> > > > > > long type)'?
> > > > >
> > > > > Good point. More similar requests will be added, e.g. for MCONTROL and
> > > > > possibly other trigger types. So I will add a separate
> > > > > 'dbtr_num_triggers' function.
> > > > >
> > > > > > > +
> > > > > > > +       pr_info("%s: total number of type %d triggers: %lu\n",
> > > > > > > +               __func__, tdata1.type, ret.value);
> > > > > > > +
> > > > > > > +       dbtr_total_num = ret.value;
> > > > > > > +
> > > > > > > +       return 0;
> > > > > > > +}
> > > > >
> > > > > Thanks!
> > > > > Sergey
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
