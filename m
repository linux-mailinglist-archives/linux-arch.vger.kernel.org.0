Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D98258D42E
	for <lists+linux-arch@lfdr.de>; Tue,  9 Aug 2022 09:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiHIHGo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Aug 2022 03:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiHIHGn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2022 03:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1741A6;
        Tue,  9 Aug 2022 00:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2435861255;
        Tue,  9 Aug 2022 07:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D8EC433B5;
        Tue,  9 Aug 2022 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660028800;
        bh=d7u06MyJmpLesNkm5cSnlW0NGio88o7LILjpUBUSYps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N0lbVOO9KOtkL6YRGzqFszgtLdGFO/hetH6C6lTo148OgGYjO5ftMlnH1E+O8bcKD
         c2FZWkAegaXHgNDcswFOTx/vpJRNswWsHco6QEfg+YTl9I3/TNn8uIrDpwP0hh9yBX
         LzkAMbazEO0QVinK9ymd3ElmBcU72W9b7sFPiDmxk3qf2nuFVmkLVIyGWMKsI/fHTJ
         l55O2xoEscah7ICukXZ7mSrhET8G6wP3xERdrCbINQo7h8/qgvdGu5qclKQJBxCQmM
         la7rHiVnMPGJSJwpUUffCmzNReC9WacAAiXUxT8gTGjQI+4E1Leb75uOx1R1evhLsP
         V+fgqJb+gPnfg==
Received: by mail-oi1-f179.google.com with SMTP id w196so7829634oiw.10;
        Tue, 09 Aug 2022 00:06:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo2LdUO+XGAm03+E+9md/lbOV4sB0aTqzJ4GHYRozvNkV9XvAYnG
        HGuvBw3jmotxvPU/Dr3G8bATHXcq+OVpExnqHv0=
X-Google-Smtp-Source: AA6agR78NnJywvVZqMX25JDxFdB8ajyCDauOFlG+yJGN9fZTYYAPQrcwHC+hs6SVkQ5ZrWtX9VrI1QYm0nkp4mAtnNU=
X-Received: by 2002:a05:6808:a10:b0:33a:d654:bf98 with SMTP id
 n16-20020a0568080a1000b0033ad654bf98mr12273684oij.112.1660028799516; Tue, 09
 Aug 2022 00:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJF2gTQoSQq_S4UvAiXgMviT040Ls8+VkDszQSke1a0zbXZ82A@mail.gmail.com>
 <mhng-7a274375-0d99-41c8-98a3-853d110f62e9@palmer-ri-x1c9>
 <CAJF2gTTXO42_TsZudaQuB9Re0teu__EZ11JZ96nktMqsQkMYNA@mail.gmail.com>
 <20220614110258.GA32157@anparri> <YrPei6q4rIAx6Ymf@boqun-archlinux>
 <fd664673-c4cc-be8f-9824-5272c5c79b40@nvidia.com> <CAJF2gTSEBQd75VWyyMwKuSDsLFoiBqB0WJfYsiEHVQbJgAgBvA@mail.gmail.com>
 <YsYivaDEksXPQPaH@boqun-archlinux> <CAJF2gTT=7+qYC-y1PapVx5yprmsr4mZGzRqz3hPq1i4SM-xqXg@mail.gmail.com>
 <4179929a-5062-7bf6-4115-121582822504@nvidia.com>
In-Reply-To: <4179929a-5062-7bf6-4115-121582822504@nvidia.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 9 Aug 2022 15:06:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTJF4eOsFgbEN5HpKskjVtFNDha8Wmy=cYJxYZQ4UUjLg@mail.gmail.com>
Message-ID: <CAJF2gTTJF4eOsFgbEN5HpKskjVtFNDha8Wmy=cYJxYZQ4UUjLg@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 9:06 PM Dan Lustig <dlustig@nvidia.com> wrote:
>
> On 7/13/2022 7:47 PM, Guo Ren wrote:
> > On Thu, Jul 7, 2022 at 8:04 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>
> >> On Sat, Jun 25, 2022 at 01:29:50PM +0800, Guo Ren wrote:
> >>> On Fri, Jun 24, 2022 at 1:09 AM Dan Lustig <dlustig@nvidia.com> wrote:
> >>>>
> >>>> On 6/22/2022 11:31 PM, Boqun Feng wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On Tue, Jun 14, 2022 at 01:03:47PM +0200, Andrea Parri wrote:
> >>>>> [...]
> >>>>>>> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> >>>>>>> is about fixup wrong spinlock/unlock implementation and not relate to
> >>>>>>> this patch.
> >>>>>>
> >>>>>> No.  The commit in question is evidence of the fact that the changes
> >>>>>> you are presenting here (as an optimization) were buggy/incorrect at
> >>>>>> the time in which that commit was worked out.
> >>>>>>
> >>>>>>
> >>>>>>> Actually, sc.w.aqrl is very strong and the same with:
> >>>>>>> fence rw, rw
> >>>>>>> sc.w
> >>>>>>> fence rw,rw
> >>>>>>>
> >>>>>>> So "which do not give full-ordering with .aqrl" is not writen in
> >>>>>>> RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>> describes the issue more specifically, that's when we added these
> >>>>>>>>>> fences.  There have certainly been complains that these fences are too
> >>>>>>>>>> heavyweight for the HW to go fast, but IIUC it's the best option we have
> >>>>>>>>> Yeah, it would reduce the performance on D1 and our next-generation
> >>>>>>>>> processor has optimized fence performance a lot.
> >>>>>>>>
> >>>>>>>> Definately a bummer that the fences make the HW go slow, but I don't
> >>>>>>>> really see any other way to go about this.  If you think these mappings
> >>>>>>>> are valid for LKMM and RVWMO then we should figure this out, but trying
> >>>>>>>> to drop fences to make HW go faster in ways that violate the memory
> >>>>>>>> model is going to lead to insanity.
> >>>>>>> Actually, this patch is okay with the ISA spec, and Dan also thought
> >>>>>>> it was valid.
> >>>>>>>
> >>>>>>> ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw
> >>>>>>
> >>>>>> "Thoughts" on this regard have _changed_.  Please compare that quote
> >>>>>> with, e.g.
> >>>>>>
> >>>>>>   https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/
> >>>>>>
> >>>>>> So here's a suggestion:
> >>>>>>
> >>>>>> Reviewers of your patches have asked:  How come that code we used to
> >>>>>> consider as buggy is now considered "an optimization" (correct)?
> >>>>>>
> >>>>>> Denying the evidence or going around it is not making their job (and
> >>>>>> this upstreaming) easier, so why don't you address it?  Take time to
> >>>>>> review previous works and discussions in this area, understand them,
> >>>>>> and integrate such knowledge in future submissions.
> >>>>>>
> >>>>>
> >>>>> I agree with Andrea.
> >>>>>
> >>>>> And I actually took a look into this, and I think I find some
> >>>>> explanation. There are two versions of RISV memory model here:
> >>>>>
> >>>>> Model 2017: released at Dec 1, 2017 as a draft
> >>>>>
> >>>>>       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/hKywNHBkAXM/m/QzUtxEWLBQAJ
> >>>>>
> >>>>> Model 2018: released at May 2, 2018
> >>>>>
> >>>>>       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/xW03vmfmPuA/m/bMPk3UCWAgAJ
> >>>>>
> >>>>> Noted that previous conversation about commit 5ce6c1f3535f happened at
> >>>>> March 2018. So the timeline is roughly:
> >>>>>
> >>>>>       Model 2017 -> commit 5ce6c1f3535f -> Model 2018
> >>>>>
> >>>>> And in the email thread of Model 2018, the commit related to model
> >>>>> changes also got mentioned:
> >>>>>
> >>>>>       https://github.com/riscv/riscv-isa-manual/commit/b875fe417948635ed68b9644ffdf718cb343a81a
> >>>>>
> >>>>> in that commit, we can see the changes related to sc.aqrl are:
> >>>>>
> >>>>>        to have occurred between the LR and a successful SC.  The LR/SC
> >>>>>        sequence can be given acquire semantics by setting the {\em aq} bit on
> >>>>>       -the SC instruction.  The LR/SC sequence can be given release semantics
> >>>>>       -by setting the {\em rl} bit on the LR instruction.  Setting both {\em
> >>>>>       -  aq} and {\em rl} bits on the LR instruction, and setting the {\em
> >>>>>       -  aq} bit on the SC instruction makes the LR/SC sequence sequentially
> >>>>>       -consistent with respect to other sequentially consistent atomic
> >>>>>       -operations.
> >>>>>       +the LR instruction.  The LR/SC sequence can be given release semantics
> >>>>>       +by setting the {\em rl} bit on the SC instruction.  Setting the {\em
> >>>>>       +  aq} bit on the LR instruction, and setting both the {\em aq} and the {\em
> >>>>>       +  rl} bit on the SC instruction makes the LR/SC sequence sequentially
> >>>>>       +consistent, meaning that it cannot be reordered with earlier or
> >>>>>       +later memory operations from the same hart.
> >>>>>
> >>>>> note that Model 2018 explicitly says that "ld.aq+sc.aqrl" is ordered
> >>>>> against "earlier or later memory operations from the same hart", and
> >>>>> this statement was not in Model 2017.
> >>>>>
> >>>>> So my understanding of the story is that at some point between March and
> >>>>> May 2018, RISV memory model folks decided to add this rule, which does
> >>>>> look more consistent with other parts of the model and is useful.
> >>>>>
> >>>>> And this is why (and when) "ld.aq+sc.aqrl" can be used as a fully-ordered
> >>>>> barrier ;-)
> >>>>>
> >>>>> Now if my understanding is correct, to move forward, it's better that 1)
> >>>>> this patch gets resend with the above information (better rewording a
> >>>>> bit), and 2) gets an Acked-by from Dan to confirm this is a correct
> >>>>> history ;-)
> >>>>
> >>>> I'm a bit lost as to why digging into RISC-V mailing list history is
> >>>> relevant here...what's relevant is what was ratified in the RVWMO
> >>>> chapter of the RISC-V spec, and whether the code you're proposing
> >>>> is the most optimized code that is correct wrt RVWMO.
> >>>>
> >>>> Is your claim that the code you're proposing to fix was based on a
> >>>> pre-RVWMO RISC-V memory model definition, and you're updating it to
> >>>> be more RVWMO-compliant?
> >>> Could "lr + beq + sc.aqrl" provides a conditional RCsc here with
> >>> current spec? I only found "lr.aq + sc.aqrl" despcriton which is
> >>> un-conditional RCsc.
> >>>
> >>
> >> /me put the temporary RISCV memory model hat on and pretend to be a
> >> RISCV memory expert.
> >>
> >> I think the answer is yes, it's actually quite straightforwards given
> >> that RISCV treats PPO (Preserved Program Order) as part of GMO (Global
> >> Memory Order), considering the following (A and B are memory accesses):
> >>
> >>         A
> >>         ..
> >>         sc.aqrl // M
> >>         ..
> >>         B
> >>
> >> , A has a ->ppo ordering to M since "sc.aqrl" is a RELEASE, and M has
> >> a ->ppo ordeing to B since "sc.aqrl" is an AQUIRE, so
> >>
> >>         A ->ppo M ->ppo B
> > That also means M must fence.rl + sc + fence.aq. But in the release
> > consistency model, "rl + aq" is not legal and has no guarantee at all.
> >
> > So sc.aqrl should be clarified in spec, but I only found "lr.aq +
> > sc.aqrl" description, see the patch commit log.
>
> The spec doesn't try to enumerate every possible synchronization
> instruction sequence.  That's why the RVWMO rules are in place.
Okay, I just want to confirm "lr + sc.aqrl" is correct here.


>
> > Could we treat sc.aqrl as a whole in ISA? Because in micro-arch, we
> > must separate it into pieces for implementation.
> >
> > That is what the RVWMO should give out.
>
> What exactly would you like the spec to say about this?  RVWMO and the
> RISC-V spec in general describe the required architecturally observable
> behavior.  They're not implementation guides.
>
> Generally speaking, I would expect splitting an sc.aqrl into a
> ".rl; sc; .aq" pattern to be OK.  That wouldn't introduce new observable
> behaviors compared to treating the sc.aqrl as a single indivisible
> operation, would it?
Yes, I think the below modification is correct, and it could improve
the performance in the fast path. Adding .aq annotation during the
false loop won't cause side effects. right?
                "0:     lr.d     %[p],  %[c]\n"
                "       beq      %[p],  %[u], 1f\n"
                "       add      %[rc], %[p], %[a]\n"
-               "       sc.d.rl  %[rc], %[rc], %[c]\n"
+               "       sc.d.aqrl  %[rc], %[rc], %[c]\n"
                "       bnez     %[rc], 0b\n"
-               "       fence    rw, rw\n"

>
> Dan
>
> >> And since RISCV describes that PPO is part of GMO:
> >>
> >> """
> >> The subset of program order that must be respected by the global memory
> >> order is known as preserved program order.
> >> """
> >>
> >> also in the herd model:
> >>
> >>         (* Main model axiom *)
> >>         acyclic co | rfe | fr | ppo as Model
> > If the herd7 model has defined that, I think it should be legal. Good catch.
> >
> >
> >>
> >> , therefore the ordering between A and B is GMO and GMO should be
> >> respected by all harts.
> >>
> >> Regards,
> >> Boqun
> >>
> >>>>
> >>>> Dan
> >>>>
> >>>>> Regards,
> >>>>> Boqun
> >>>>>
> >>>>>>   Andrea
> >>>>>>
> >>>>>>
> >>>>> [...]
> >>>
> >>>
> >>>
> >>> --
> >>> Best Regards
> >>>  Guo Ren
> >>>
> >>> ML: https://lore.kernel.org/linux-csky/
> >
> >
> >



--
Best Regards
 Guo Ren
