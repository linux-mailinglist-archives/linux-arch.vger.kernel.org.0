Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B858F55A756
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jun 2022 07:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiFYFaH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jun 2022 01:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFYFaH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jun 2022 01:30:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD16506F6;
        Fri, 24 Jun 2022 22:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02989B819B6;
        Sat, 25 Jun 2022 05:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A34C385A2;
        Sat, 25 Jun 2022 05:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656135003;
        bh=mnoBIoF19WTREit/OFp0UMtQJBPgcsW6KTo4b1GeSyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sGrFKdHuaVCmEdM4BeJ2EJBnKGgbmR8ETnICMuSfwb8UJx1N/Uo1oURvz4iJ4Ejsq
         qyof+KsRV32RhXv47a+v/0YQuNS+Ew9dnvlf46tC8k9hFESLKnChVzLVNiu5gNe3NR
         wsvwelk9LxqTaFe0HJyAVcpKiVTM0YL2O4Hbhwz7NyVHIA2ViNcCxiz8LA7GiH2EYm
         VD/c9uNv/1ngxrrjSR5wsxoI44DsUO65U16q5BOwzFFWQi4P2g5AJnQ+Tjb6hM74fd
         QqSdHgZba9bCLm8lcyzTXdRSs0k5GBELaKhr4jLFGuj3Wv9PWTxuI0OG0k72a9XuUc
         M0udVRfk7NFUQ==
Received: by mail-ua1-f51.google.com with SMTP id k19so1565675uap.7;
        Fri, 24 Jun 2022 22:30:03 -0700 (PDT)
X-Gm-Message-State: AJIora9JIcv4izHCHzsysoP/KZnWZczGK2YrxPD/Zfj95EUMl8JMcZdf
        PpPwjQR/NAek7E3b6mAVEM9lKs/Ox5SZEPywshw=
X-Google-Smtp-Source: AGRyM1v1PVMAlmmyTQvw1T5Buy1abcKX9NLW1pRTDn84YsMzjTcDrlcWJvMYTGVxkac4HHDacgG7t+DZtoI2FY0xuUo=
X-Received: by 2002:ab0:4384:0:b0:37f:1bac:b425 with SMTP id
 l4-20020ab04384000000b0037f1bacb425mr1075170ual.12.1656135002651; Fri, 24 Jun
 2022 22:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJF2gTQoSQq_S4UvAiXgMviT040Ls8+VkDszQSke1a0zbXZ82A@mail.gmail.com>
 <mhng-7a274375-0d99-41c8-98a3-853d110f62e9@palmer-ri-x1c9>
 <CAJF2gTTXO42_TsZudaQuB9Re0teu__EZ11JZ96nktMqsQkMYNA@mail.gmail.com>
 <20220614110258.GA32157@anparri> <YrPei6q4rIAx6Ymf@boqun-archlinux> <fd664673-c4cc-be8f-9824-5272c5c79b40@nvidia.com>
In-Reply-To: <fd664673-c4cc-be8f-9824-5272c5c79b40@nvidia.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 25 Jun 2022 13:29:50 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSEBQd75VWyyMwKuSDsLFoiBqB0WJfYsiEHVQbJgAgBvA@mail.gmail.com>
Message-ID: <CAJF2gTSEBQd75VWyyMwKuSDsLFoiBqB0WJfYsiEHVQbJgAgBvA@mail.gmail.com>
Subject: Re: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops with
 .aqrl annotation
To:     Dan Lustig <dlustig@nvidia.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
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

On Fri, Jun 24, 2022 at 1:09 AM Dan Lustig <dlustig@nvidia.com> wrote:
>
> On 6/22/2022 11:31 PM, Boqun Feng wrote:
> > Hi,
> >
> > On Tue, Jun 14, 2022 at 01:03:47PM +0200, Andrea Parri wrote:
> > [...]
> >>> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> >>> is about fixup wrong spinlock/unlock implementation and not relate to
> >>> this patch.
> >>
> >> No.  The commit in question is evidence of the fact that the changes
> >> you are presenting here (as an optimization) were buggy/incorrect at
> >> the time in which that commit was worked out.
> >>
> >>
> >>> Actually, sc.w.aqrl is very strong and the same with:
> >>> fence rw, rw
> >>> sc.w
> >>> fence rw,rw
> >>>
> >>> So "which do not give full-ordering with .aqrl" is not writen in
> >>> RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
> >>>
> >>>>
> >>>>>> describes the issue more specifically, that's when we added these
> >>>>>> fences.  There have certainly been complains that these fences are too
> >>>>>> heavyweight for the HW to go fast, but IIUC it's the best option we have
> >>>>> Yeah, it would reduce the performance on D1 and our next-generation
> >>>>> processor has optimized fence performance a lot.
> >>>>
> >>>> Definately a bummer that the fences make the HW go slow, but I don't
> >>>> really see any other way to go about this.  If you think these mappings
> >>>> are valid for LKMM and RVWMO then we should figure this out, but trying
> >>>> to drop fences to make HW go faster in ways that violate the memory
> >>>> model is going to lead to insanity.
> >>> Actually, this patch is okay with the ISA spec, and Dan also thought
> >>> it was valid.
> >>>
> >>> ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw
> >>
> >> "Thoughts" on this regard have _changed_.  Please compare that quote
> >> with, e.g.
> >>
> >>   https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/
> >>
> >> So here's a suggestion:
> >>
> >> Reviewers of your patches have asked:  How come that code we used to
> >> consider as buggy is now considered "an optimization" (correct)?
> >>
> >> Denying the evidence or going around it is not making their job (and
> >> this upstreaming) easier, so why don't you address it?  Take time to
> >> review previous works and discussions in this area, understand them,
> >> and integrate such knowledge in future submissions.
> >>
> >
> > I agree with Andrea.
> >
> > And I actually took a look into this, and I think I find some
> > explanation. There are two versions of RISV memory model here:
> >
> > Model 2017: released at Dec 1, 2017 as a draft
> >
> >       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/hKywNHBkAXM/m/QzUtxEWLBQAJ
> >
> > Model 2018: released at May 2, 2018
> >
> >       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/xW03vmfmPuA/m/bMPk3UCWAgAJ
> >
> > Noted that previous conversation about commit 5ce6c1f3535f happened at
> > March 2018. So the timeline is roughly:
> >
> >       Model 2017 -> commit 5ce6c1f3535f -> Model 2018
> >
> > And in the email thread of Model 2018, the commit related to model
> > changes also got mentioned:
> >
> >       https://github.com/riscv/riscv-isa-manual/commit/b875fe417948635ed68b9644ffdf718cb343a81a
> >
> > in that commit, we can see the changes related to sc.aqrl are:
> >
> >        to have occurred between the LR and a successful SC.  The LR/SC
> >        sequence can be given acquire semantics by setting the {\em aq} bit on
> >       -the SC instruction.  The LR/SC sequence can be given release semantics
> >       -by setting the {\em rl} bit on the LR instruction.  Setting both {\em
> >       -  aq} and {\em rl} bits on the LR instruction, and setting the {\em
> >       -  aq} bit on the SC instruction makes the LR/SC sequence sequentially
> >       -consistent with respect to other sequentially consistent atomic
> >       -operations.
> >       +the LR instruction.  The LR/SC sequence can be given release semantics
> >       +by setting the {\em rl} bit on the SC instruction.  Setting the {\em
> >       +  aq} bit on the LR instruction, and setting both the {\em aq} and the {\em
> >       +  rl} bit on the SC instruction makes the LR/SC sequence sequentially
> >       +consistent, meaning that it cannot be reordered with earlier or
> >       +later memory operations from the same hart.
> >
> > note that Model 2018 explicitly says that "ld.aq+sc.aqrl" is ordered
> > against "earlier or later memory operations from the same hart", and
> > this statement was not in Model 2017.
> >
> > So my understanding of the story is that at some point between March and
> > May 2018, RISV memory model folks decided to add this rule, which does
> > look more consistent with other parts of the model and is useful.
> >
> > And this is why (and when) "ld.aq+sc.aqrl" can be used as a fully-ordered
> > barrier ;-)
> >
> > Now if my understanding is correct, to move forward, it's better that 1)
> > this patch gets resend with the above information (better rewording a
> > bit), and 2) gets an Acked-by from Dan to confirm this is a correct
> > history ;-)
>
> I'm a bit lost as to why digging into RISC-V mailing list history is
> relevant here...what's relevant is what was ratified in the RVWMO
> chapter of the RISC-V spec, and whether the code you're proposing
> is the most optimized code that is correct wrt RVWMO.
>
> Is your claim that the code you're proposing to fix was based on a
> pre-RVWMO RISC-V memory model definition, and you're updating it to
> be more RVWMO-compliant?
Could "lr + beq + sc.aqrl" provides a conditional RCsc here with
current spec? I only found "lr.aq + sc.aqrl" despcriton which is
un-conditional RCsc.

>
> Dan
>
> > Regards,
> > Boqun
> >
> >>   Andrea
> >>
> >>
> > [...]



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
