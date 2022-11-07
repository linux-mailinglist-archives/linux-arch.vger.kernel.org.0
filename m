Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580161FFD8
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 21:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiKGUwQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 15:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiKGUwP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 15:52:15 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1224F35
        for <linux-arch@vger.kernel.org>; Mon,  7 Nov 2022 12:52:13 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j16so18380864lfe.12
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2022 12:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljWDyV8wNeeRtLN+IMD41v2BcNY5eNwfoFOEwTA/0zo=;
        b=giRuxQN/uXEkxs1LQyc+VNVSvqRO5T847JxrPW3jjWMXyWwh2nO9zh2CZt1TCkvBV6
         udwfalmwHZ0DNOr3JUyN6jK1x4iNtmFRFsE6Vtc1TlHUmJ3qgpdkafl4UgNWhv//fmC3
         QQnHqC91BdkKJKjFpbCxdzUfZ43O+E1E42dP48MsM9MoozhGkROMAit5lGP0m7coZRFg
         WIa82fekdVtpEuv0SMzKty86D74I8lc313GiJacbfh4EnXiwioUcz27MrxLRNEczKX8E
         poJRs59omzxF79jfYRCiFJ1qUx8nTiFtcNe9iklXlmTSplOH2B7uYvJYTVYbPyqqpu3G
         GB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljWDyV8wNeeRtLN+IMD41v2BcNY5eNwfoFOEwTA/0zo=;
        b=0tFcewaHY6xtM9vQsligzq7vuQyhgxOXmwKTQqOyVtVAmCR1cCTNryXLvrNkHTZfpF
         uGhAqQe+jZCr+/SfBPtsdB2ZvqL5830UD7tGhvlSMGcuYvuwWbS+b/3A5bgyXTC98ee2
         eiAqzsWzIJjGfoahhvLRTEYQcswndEA0gwLZuGQSuIZPT5VTZTPyE4+MAzU853Tp69RX
         jkDUae7PIsieicZvaS19lhSlDpOvJk4i56gr2rgNJOZMouyFqFvQzaBryx/Jxk04G+hR
         hxfFB/Gs2m6OOknTjDCCfynX9qeaU3ZV+/3QGr8Z/8BZVx7O18ZboF51f6JmNvnfwI0N
         VDMw==
X-Gm-Message-State: ACrzQf2K/BQoIjSHlBEnfDoi5Z1ua265RPQ/fHW4JAQsNK3k0eEmXaaa
        5pAPbeVI747f7MciWqIJ5pk=
X-Google-Smtp-Source: AMsMyM4Mhp/NO5fVOCEn/0jU9d+yhnzZDjk0W3/VeZ/rp5SJqpP5gbebj/ljIim+BuEB1TezjfYfWg==
X-Received: by 2002:a05:6512:3da2:b0:4a2:6f93:2895 with SMTP id k34-20020a0565123da200b004a26f932895mr18946183lfv.437.1667854331821;
        Mon, 07 Nov 2022 12:52:11 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id u8-20020a05651c130800b0026e02eb613csm1430120lja.18.2022.11.07.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:52:11 -0800 (PST)
Date:   Mon, 7 Nov 2022 23:52:10 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Andrew Bresticker <abrestic@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: Re: [RFC PATCH v1] riscv: support for hardware
 breakpoints/watchpoints
Message-ID: <Y2lv+smon7d9tP4Y@curiosity>
References: <20221031213225.912258-1-geomatsi@gmail.com>
 <CALE4mHo2yFPpF68RvvDbKji6_peAX60_cXqnFMxydJTLjnLnUQ@mail.gmail.com>
 <Y2WGIQ+m7jk5RPZv@curiosity>
 <CAAhSdy0bZsX1CCYvGJjHH4bXMJZU7eZ7dLcYR87CV4UaS+Kgeg@mail.gmail.com>
 <CALE4mHq0+iJju23rDKQiR1PbY-2Cy0jqRCkCKBBOy6JB4e_z3Q@mail.gmail.com>
 <CAK9=C2UmfeY2JJ9YLH6Ve392N9LrY2jdNi6CFADMNQgN=vVFxg@mail.gmail.com>
 <CALE4mHp2vvv3tFVsDHn_hCrN7iF2aTugsu57cSXE=wrxq7wa2w@mail.gmail.com>
 <CAK9=C2V_DZ+8jQ0Dg+P7sbke_SPzOnYydfwNGc-P0abvBkWB-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9=C2V_DZ+8jQ0Dg+P7sbke_SPzOnYydfwNGc-P0abvBkWB-A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 07, 2022 at 11:19:59PM +0530, Anup Patel wrote:
> On Mon, Nov 7, 2022 at 10:55 PM Andrew Bresticker <abrestic@rivosinc.com> wrote:
> >
> > On Mon, Nov 7, 2022 at 11:06 AM Anup Patel <apatel@ventanamicro.com> wrote:
> > >
> > > On Mon, Nov 7, 2022 at 8:21 PM Andrew Bresticker <abrestic@rivosinc.com> wrote:
> > > >
> > > > On Sat, Nov 5, 2022 at 5:10 AM Anup Patel <anup@brainfault.org> wrote:
> > > > >
> > > > > On Sat, Nov 5, 2022 at 3:07 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> > > > > >
> > > > > > Hi Andrew,
> > > > > >
> > > > > > > > RISC-V Debug specification includes Sdtrig ISA extension. This extension
> > > > > > > > describes Trigger Module. Triggers can cause a breakpoint exception,
> > > > > > > > entry into Debug Mode, or a trace action without having to execute a
> > > > > > > > special instruction. For native debugging triggers can be used to
> > > > > > > > implement hardware breakpoints and watchpoints.
> > > > > >
> > > > > > ... [snip]
> > > > > >
> > > > > > > > Despite missing userspace debug, initial implementation can be tested
> > > > > > > > on QEMU using kernel breakpoints, e.g. see samples/hw_breakpoint and
> > > > > > > > register_wide_hw_breakpoint. Hardware breakpoints work on upstream QEMU.
> > > > > > >
> > > > > > > We should also be able to enable the use of HW breakpoints (and
> > > > > > > watchpoints, modulo the issue mentioned below) in kdb, right?
> > > > > >
> > > > > > Interesting. So far I didn't think about using hw breakpoints in kgdb.
> > > > > > I took a quick look at riscv and arm64 kgdb code. It looks like there
> > > > > > is nothing wrong in adding arch-specific implementation of the function
> > > > > > 'kgdb_arch_set_breakpoint' that will use hw breakpoints if possible.
> > > > > > Besides it looks like in this case it makes sense to handle KGDB earlier
> > > > > > than hw breakpoints in do_trap_break.
> > > > > >
> > > > > > > > However this is not the case for watchpoints since there is no way to
> > > > > > > > figure out which watchpoint is triggered. IIUC there are two possible
> > > > > > > > options for doing this: using 'hit' bit in tdata1 or reading faulting
> > > > > > > > virtual address from STVAL. QEMU implements neither of them. Current
> > > > > > > > implementation opts for STVAL. So the following experimental QEMU patch
> > > > > > > > is required to make watchpoints work:
> > > > > > > >
> > > > > > > > :  diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > > > > > > :  index 278d163803..8858be7411 100644
> > > > > > > > :  --- a/target/riscv/cpu_helper.c
> > > > > > > > :  +++ b/target/riscv/cpu_helper.c
> > > > > > > > :  @@ -1639,6 +1639,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> > > > > > > > :           case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
> > > > > > > > :               tval = env->bins;
> > > > > > > > :               break;
> > > > > > > > :  +        case RISCV_EXCP_BREAKPOINT:
> > > > > > > > :  +            tval = env->badaddr;
> > > > > > > > :  +            env->badaddr = 0x0;
> > > > > > > > :  +            break;
> > > > > > > > :           default:
> > > > > > > > :               break;
> > > > > > > > :           }
> > > > > > > > :  diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> > > > > > > > :  index 26ea764407..b4d1d566ab 100644
> > > > > > > > :  --- a/target/riscv/debug.c
> > > > > > > > :  +++ b/target/riscv/debug.c
> > > > > > > > :  @@ -560,6 +560,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
> > > > > > > > :
> > > > > > > > :       if (cs->watchpoint_hit) {
> > > > > > > > :           if (cs->watchpoint_hit->flags & BP_CPU) {
> > > > > > > > :  +            env->badaddr = cs->watchpoint_hit->hitaddr;
> > > > > > > > :               cs->watchpoint_hit = NULL;
> > > > > > > > :               do_trigger_action(env, DBG_ACTION_BP);
> > > > > > > > :           }
> > > > > >
> > > > > > ... [snip]
> > > > > >
> > > > > > > > +int arch_install_hw_breakpoint(struct perf_event *bp)
> > > > > > > > +{
> > > > > > > > +       struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > > > > > > > +       struct sbi_dbtr_data_msg *xmit;
> > > > > > > > +       struct sbi_dbtr_id_msg *recv;
> > > > > > > > +       struct perf_event **slot;
> > > > > > > > +       struct sbiret ret;
> > > > > > > > +       int err = 0;
> > > > > > > > +
> > > > > > > > +       xmit = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*xmit)), GFP_ATOMIC);
> > > > > > > > +       if (!xmit) {
> > > > > > > > +               err = -ENOMEM;
> > > > > > > > +               goto out;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       recv = kzalloc(SBI_MSG_SZ_ALIGN(sizeof(*recv)), GFP_ATOMIC);
> > > > > > > > +       if (!recv) {
> > > > > > > > +               err = -ENOMEM;
> > > > > > > > +               goto out;
> > > > > > > > +       }
> > > > > > >
> > > > > > > Do these really need to be dynamically allocated?
> > > > > >
> > > > > > According to SBI extension proposal, base address of this memory chunk
> > > > > > must be 16-bytes aligned. To simplify things, buffer with 'power of two
> > > > > > bytes' size (and >= 16 bytes) is allocated. In this case alignment of
> > > > > > the kmalloc buffer is guaranteed to be at least this size. IIUC more
> > > > > > efforts are needed to guarantee such alignment for a buffer on stack.
> > > >
> > > > You should be able to declare the struct with __aligned(16) to get the
> > > > desired alignment on the stack.
> > > >
> > > > > Stack is not appropriate for this. Please use a per-CPU global
> > > > > data for this purpose which should be 16 byte aligned as well.
> > > >
> > > > Is the desire to not use the stack purely a defensive measure, i.e. to
> > > > defend against a buggy or malicious firmware/hypervisor? That's fine,
> > > > I'm just curious if there's rationale beyond that (though I'd argue
> > > > we're already implicitly trusting whatever software is sitting below
> > > > us).
> > >
> > > The kernel stack is fixed size so it is best to avoid large structures
> > > or arrays on kernel stack.
> >
> > Of course, though I'm not sure I'd consider 32 bytes "large" :)
> 
> The current patch only configures one trigger at a time but if
> we are configuring multiple triggers in one-go then the trigger
> array will grow.

Existing architecture-specific calls (e.g. arch_install_hw_breakpoint)
handle a single breakpoint. IIUC we may have to setup multiple triggers
at once for masked watchpoints. A masked watchpoint watches many
addresses simultanously, e.g. see https://sourceware.org/gdb/onlinedocs/gdb/Set-Watchpoints.html.
Masked watchpoints can be converted into chained triggers which would
require configuring multiple triggers in one-go.

Do you have any other use-cases in mind ?

Regards,
Sergey
