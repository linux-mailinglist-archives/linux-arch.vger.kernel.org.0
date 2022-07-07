Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330BF5696B7
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 02:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiGGAEJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 20:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiGGAEH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 20:04:07 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8BA1902B;
        Wed,  6 Jul 2022 17:04:06 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b24so12281155qkn.4;
        Wed, 06 Jul 2022 17:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=egYv15cXkA5RpPdPdInxwHuoYF9xGZOxfekqWFe0C9c=;
        b=GwM0NHat2U8pX71R1qnS62+slU9mefwq/s9YBnSLXYw4DRADz2gf7HZHLtcHa9acgK
         CiOX+j/LqJPvg8DLU32IqVEi8a8U0O98IGzzPO4dxyRsXmFtGOdfs+UgizGbu28s99KF
         EhQx/JUjrd21/jzwfg6ea25gOa6nkzRPjuE4TsLqhnItj/H53yEjW/y8Y4o9OSGULtRE
         g5Z4a7shQR9ZPkiCECNGiEDghqVIG8RAXCYPt9zPhVrhi+Vq3X87XBzeNHbOCScAFTbX
         NcR23wuT1z9OX9tGR5x2f5pGJBL2Xi3DMXhwwfKQHkWyblpVflAHkoAJF/HpG7klvv8A
         0GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=egYv15cXkA5RpPdPdInxwHuoYF9xGZOxfekqWFe0C9c=;
        b=1Ka0vDvzETCpuEiCCmT/lQD7XmYt7gXUIEjNEdnyapZwTjfRNk6KvlIHp0rJ7nDRdH
         SVHc+Hh5znmYYPsRaHEr099pkkTjrYxBrWU839fgk4E8w48FszOEcBS6D8YU8KfiZ3iZ
         lwCr+wF/sZv7fdkLeddWSwVscJJNx/cfmS9I18WNcNGtnvHw1ecu31SgecMAaYvOtoeC
         iW+8+3KgvrF3f8TQvZyUFxrCya0C9QuEUsBKnu1gk/gUneMNCbLx+U0WVK84U+oMgctA
         f/ifXfehhEwMCSgDKgvQ2iuD0wk4JV3l156DsZH0ayBDzygFQHgpeBDHdyj2jId9FXbn
         SH8Q==
X-Gm-Message-State: AJIora9i2NEyqnSLT8VIRkhrTM/IHNN0NdWOk4fJrPqNtQKI67r9V/yB
        zYkrrqjEsyM7ZrW9V2uxsO4=
X-Google-Smtp-Source: AGRyM1s8wlVaTUmg4hECDVOwDwbH2eEUQQYqtVJ75ghJoTPH5GVm7OZyfjfQ0GBQyfR71wYpmPlxLA==
X-Received: by 2002:a05:620a:1b8f:b0:6af:337a:5067 with SMTP id dv15-20020a05620a1b8f00b006af337a5067mr28799459qkb.343.1657152245657;
        Wed, 06 Jul 2022 17:04:05 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id bs24-20020ac86f18000000b00304fa21762csm17824263qtb.53.2022.07.06.17.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 17:04:04 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3BC1127C0054;
        Wed,  6 Jul 2022 20:04:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 06 Jul 2022 20:04:04 -0400
X-ME-Sender: <xms:8yLGYqt5mcXP06hhWtOGg6SmrTwOOyDrLdl4pa4yqBaZ8GW5s4K5qA>
    <xme:8yLGYveLQsGc0b2yS-NTHDAHDnsfiZJ6IWYLL6jrwA2z-Ec3-6hJsOMcfu2bZEb08
    4Cd1Lpw8uM18IDBTg>
X-ME-Received: <xmr:8yLGYlzaKUT2FQgS1DBmykpVtChQxFQO9ezy_3fRVngvhwU6Ll6Ml4QTXtVd0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggu
    jgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfh
    gvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedugfeghfekveekveet
    tddtgeehieefledttdegudeuledthfdvheeileeftdfffeenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgpdhgohhoghhlvgdrtghomhdprhhishgtvhdrohhrghdpghhithhhuhgs
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:8yLGYlMNtPmqK-WsxqwawZ_NmeqUAR1VS44l5mIuUrBHVEUlWgKwnA>
    <xmx:8yLGYq8CapQHbyONWIdey2L4v02EOjk_wtjbQfvWQzhZxCKgSUf5yw>
    <xmx:8yLGYtX6xiuLTGsmuTvr6rJlo5t_U2nuDqIoiR1sw7Te4m2H8lysPg>
    <xmx:9CLGYtVslXJQuBgzT5qENf1h1gVoapA-OJAEQ3Xy8TS8Qre29_8HoQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Jul 2022 20:04:02 -0400 (EDT)
Date:   Wed, 6 Jul 2022 17:03:09 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Dan Lustig <dlustig@nvidia.com>,
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
Subject: Re: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops
 with .aqrl annotation
Message-ID: <YsYivaDEksXPQPaH@boqun-archlinux>
References: <CAJF2gTQoSQq_S4UvAiXgMviT040Ls8+VkDszQSke1a0zbXZ82A@mail.gmail.com>
 <mhng-7a274375-0d99-41c8-98a3-853d110f62e9@palmer-ri-x1c9>
 <CAJF2gTTXO42_TsZudaQuB9Re0teu__EZ11JZ96nktMqsQkMYNA@mail.gmail.com>
 <20220614110258.GA32157@anparri>
 <YrPei6q4rIAx6Ymf@boqun-archlinux>
 <fd664673-c4cc-be8f-9824-5272c5c79b40@nvidia.com>
 <CAJF2gTSEBQd75VWyyMwKuSDsLFoiBqB0WJfYsiEHVQbJgAgBvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSEBQd75VWyyMwKuSDsLFoiBqB0WJfYsiEHVQbJgAgBvA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 25, 2022 at 01:29:50PM +0800, Guo Ren wrote:
> On Fri, Jun 24, 2022 at 1:09 AM Dan Lustig <dlustig@nvidia.com> wrote:
> >
> > On 6/22/2022 11:31 PM, Boqun Feng wrote:
> > > Hi,
> > >
> > > On Tue, Jun 14, 2022 at 01:03:47PM +0200, Andrea Parri wrote:
> > > [...]
> > >>> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> > >>> is about fixup wrong spinlock/unlock implementation and not relate to
> > >>> this patch.
> > >>
> > >> No.  The commit in question is evidence of the fact that the changes
> > >> you are presenting here (as an optimization) were buggy/incorrect at
> > >> the time in which that commit was worked out.
> > >>
> > >>
> > >>> Actually, sc.w.aqrl is very strong and the same with:
> > >>> fence rw, rw
> > >>> sc.w
> > >>> fence rw,rw
> > >>>
> > >>> So "which do not give full-ordering with .aqrl" is not writen in
> > >>> RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
> > >>>
> > >>>>
> > >>>>>> describes the issue more specifically, that's when we added these
> > >>>>>> fences.  There have certainly been complains that these fences are too
> > >>>>>> heavyweight for the HW to go fast, but IIUC it's the best option we have
> > >>>>> Yeah, it would reduce the performance on D1 and our next-generation
> > >>>>> processor has optimized fence performance a lot.
> > >>>>
> > >>>> Definately a bummer that the fences make the HW go slow, but I don't
> > >>>> really see any other way to go about this.  If you think these mappings
> > >>>> are valid for LKMM and RVWMO then we should figure this out, but trying
> > >>>> to drop fences to make HW go faster in ways that violate the memory
> > >>>> model is going to lead to insanity.
> > >>> Actually, this patch is okay with the ISA spec, and Dan also thought
> > >>> it was valid.
> > >>>
> > >>> ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw
> > >>
> > >> "Thoughts" on this regard have _changed_.  Please compare that quote
> > >> with, e.g.
> > >>
> > >>   https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/
> > >>
> > >> So here's a suggestion:
> > >>
> > >> Reviewers of your patches have asked:  How come that code we used to
> > >> consider as buggy is now considered "an optimization" (correct)?
> > >>
> > >> Denying the evidence or going around it is not making their job (and
> > >> this upstreaming) easier, so why don't you address it?  Take time to
> > >> review previous works and discussions in this area, understand them,
> > >> and integrate such knowledge in future submissions.
> > >>
> > >
> > > I agree with Andrea.
> > >
> > > And I actually took a look into this, and I think I find some
> > > explanation. There are two versions of RISV memory model here:
> > >
> > > Model 2017: released at Dec 1, 2017 as a draft
> > >
> > >       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/hKywNHBkAXM/m/QzUtxEWLBQAJ
> > >
> > > Model 2018: released at May 2, 2018
> > >
> > >       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/xW03vmfmPuA/m/bMPk3UCWAgAJ
> > >
> > > Noted that previous conversation about commit 5ce6c1f3535f happened at
> > > March 2018. So the timeline is roughly:
> > >
> > >       Model 2017 -> commit 5ce6c1f3535f -> Model 2018
> > >
> > > And in the email thread of Model 2018, the commit related to model
> > > changes also got mentioned:
> > >
> > >       https://github.com/riscv/riscv-isa-manual/commit/b875fe417948635ed68b9644ffdf718cb343a81a
> > >
> > > in that commit, we can see the changes related to sc.aqrl are:
> > >
> > >        to have occurred between the LR and a successful SC.  The LR/SC
> > >        sequence can be given acquire semantics by setting the {\em aq} bit on
> > >       -the SC instruction.  The LR/SC sequence can be given release semantics
> > >       -by setting the {\em rl} bit on the LR instruction.  Setting both {\em
> > >       -  aq} and {\em rl} bits on the LR instruction, and setting the {\em
> > >       -  aq} bit on the SC instruction makes the LR/SC sequence sequentially
> > >       -consistent with respect to other sequentially consistent atomic
> > >       -operations.
> > >       +the LR instruction.  The LR/SC sequence can be given release semantics
> > >       +by setting the {\em rl} bit on the SC instruction.  Setting the {\em
> > >       +  aq} bit on the LR instruction, and setting both the {\em aq} and the {\em
> > >       +  rl} bit on the SC instruction makes the LR/SC sequence sequentially
> > >       +consistent, meaning that it cannot be reordered with earlier or
> > >       +later memory operations from the same hart.
> > >
> > > note that Model 2018 explicitly says that "ld.aq+sc.aqrl" is ordered
> > > against "earlier or later memory operations from the same hart", and
> > > this statement was not in Model 2017.
> > >
> > > So my understanding of the story is that at some point between March and
> > > May 2018, RISV memory model folks decided to add this rule, which does
> > > look more consistent with other parts of the model and is useful.
> > >
> > > And this is why (and when) "ld.aq+sc.aqrl" can be used as a fully-ordered
> > > barrier ;-)
> > >
> > > Now if my understanding is correct, to move forward, it's better that 1)
> > > this patch gets resend with the above information (better rewording a
> > > bit), and 2) gets an Acked-by from Dan to confirm this is a correct
> > > history ;-)
> >
> > I'm a bit lost as to why digging into RISC-V mailing list history is
> > relevant here...what's relevant is what was ratified in the RVWMO
> > chapter of the RISC-V spec, and whether the code you're proposing
> > is the most optimized code that is correct wrt RVWMO.
> >
> > Is your claim that the code you're proposing to fix was based on a
> > pre-RVWMO RISC-V memory model definition, and you're updating it to
> > be more RVWMO-compliant?
> Could "lr + beq + sc.aqrl" provides a conditional RCsc here with
> current spec? I only found "lr.aq + sc.aqrl" despcriton which is
> un-conditional RCsc.
> 

/me put the temporary RISCV memory model hat on and pretend to be a
RISCV memory expert.

I think the answer is yes, it's actually quite straightforwards given
that RISCV treats PPO (Preserved Program Order) as part of GMO (Global
Memory Order), considering the following (A and B are memory accesses):

	A
	..
	sc.aqrl // M
	..
	B

, A has a ->ppo ordering to M since "sc.aqrl" is a RELEASE, and M has
a ->ppo ordeing to B since "sc.aqrl" is an AQUIRE, so

	A ->ppo M ->ppo B

And since RISCV describes that PPO is part of GMO:

"""
The subset of program order that must be respected by the global memory
order is known as preserved program order.
"""

also in the herd model:

	(* Main model axiom *)
	acyclic co | rfe | fr | ppo as Model

, therefore the ordering between A and B is GMO and GMO should be
respected by all harts.

Regards,
Boqun

> >
> > Dan
> >
> > > Regards,
> > > Boqun
> > >
> > >>   Andrea
> > >>
> > >>
> > > [...]
> 
> 
> 
> --
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
