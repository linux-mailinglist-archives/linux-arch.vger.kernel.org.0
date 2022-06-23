Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70275587DA
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiFWSxi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbiFWSvD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 14:51:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7606DF9903;
        Thu, 23 Jun 2022 10:55:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id r138so5000551qke.13;
        Thu, 23 Jun 2022 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UL6VZe4xX6RusXDF47C8DXFCgl3ZVmVUhDz9s8GH6hE=;
        b=PLmUuzq/7uSgu04xUBGadLJkUoeOBkEc+KT9X2ETfZHJDR8nD1kNpHOsuO1B+vqEZo
         22pGZC/jwG2fuWRSRHMId8eLN8dgegaAdk5QnUZOE+wtbBKouUj8NCIWyaJRwWyRoNSP
         B0VfuZMup2C1Y5GHBikeVcj4SJFDEzO3YYY7p3qEPPiLykTiyNdRGWaFrP8zjER4QD64
         PPuDvu03DybJNLk95Kl9FslOWyPX0vPN41FOOA56luFEYDqh2lrMwp5uFI/XkCfb3gVz
         X0jJ9cZvUS6+oPM7z+qjDyVTLArhQlu0FBdJ8uRQMJfsKNfr0bBAg9RQet9lFaZpEpGc
         1qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UL6VZe4xX6RusXDF47C8DXFCgl3ZVmVUhDz9s8GH6hE=;
        b=Kq6NCl1jE3CfN1niBmwc4CWgU8IK9ZmgmbN21Kgnq0iPszuicpgArRwNtpGVKk/d3M
         jEiYIhq/REx+Af7dIhMxa3LKNAvfzziv/wdOaLMeiEDRfFV8NaWZ9019tndsWILZimol
         i81FardrMzV9IaREtPzScPvo151wwKmTkI672C+hmki1X1HCXm4t+GPdHHzDMHIAD6ws
         8aRjKG45ah8k6FV2ISRXnLDLax82inv6Vx2b7hUGLk23KtqpxDLct/v3rGsoMJIBY6XM
         cDJf/3QOk8DaSY5POA3lj5Bj96Y8eAA4mMXMIS2y7WlnmFOcnkW1/I4ijfGMOq0mMxxY
         E4IQ==
X-Gm-Message-State: AJIora+ljNhjgrRcRzLLJHHYtzG9hh82yCkIYWdNdvOimaU3vD/tJxvr
        BIiHDO5H0C+OqmtAAKmi0g3XEbOlaXQ=
X-Google-Smtp-Source: AGRyM1uYXqyDlmIqV1TNqLVKGZNJVjFMdHZOQ6z/NGMJ1jlnG39b+iYhRNvViAr8Vmww95m00eY9Iw==
X-Received: by 2002:a05:620a:d53:b0:6ae:f9c8:f6a4 with SMTP id o19-20020a05620a0d5300b006aef9c8f6a4mr2259123qkl.343.1656006928488;
        Thu, 23 Jun 2022 10:55:28 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b00304dd83a9b1sm18670431qtx.82.2022.06.23.10.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:55:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 54FBA27C0054;
        Thu, 23 Jun 2022 13:55:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 23 Jun 2022 13:55:27 -0400
X-ME-Sender: <xms:Dqm0YhEnueb_OOGhXG6s1RMyvWz6RxwjVypk0DEolW9Fv3IVEzRFcA>
    <xme:Dqm0YmUEkZ-JG1crYZ-ABedloCYpv5AoQ92I19YMNAHKfJ7mw4BROfeq8i4iy3Z37
    zfHHZvhXfpUbzBsNg>
X-ME-Received: <xmr:Dqm0YjL1LdX7LCq6TAAN1eoPd4xPHvGsJpbIC-rqdRmSeg_za1W5NJ4V83ESxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefjedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggt
    uggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrd
    hfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffekvedvjeehuddt
    tefhjeeitddttdfhteffudefudelkedtvdfguddvhfejleeunecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghdpghhoohhglhgvrdgtohhmpdhrihhstghvrdhorhhgpdhgihhthhhu
    sgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Dqm0YnG-17kvC6ytGlhCEhXPjgvcKTDkeLg8oQrcgDT20Ibx3TudKw>
    <xmx:Dqm0YnVgZcBokeogHutY1LPnMK5bm5HWmTDpUjvQ93BvSlzMVVYhQQ>
    <xmx:Dqm0YiPMleLP5LJ3PoABrA9PqWoKr_h6-EoxwrGbv9V628DOe5TzgA>
    <xmx:Dqm0YqMtE5JUeF_5RvSNogrULcifiH3c6cWi5StRee4QiNCBQGn8pA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jun 2022 13:55:25 -0400 (EDT)
Date:   Thu, 23 Jun 2022 10:55:11 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Dan Lustig <dlustig@nvidia.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>, Guo Ren <guoren@kernel.org>,
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
Message-ID: <YrSo/3iUuO0AL76T@boqun-archlinux>
References: <CAJF2gTQoSQq_S4UvAiXgMviT040Ls8+VkDszQSke1a0zbXZ82A@mail.gmail.com>
 <mhng-7a274375-0d99-41c8-98a3-853d110f62e9@palmer-ri-x1c9>
 <CAJF2gTTXO42_TsZudaQuB9Re0teu__EZ11JZ96nktMqsQkMYNA@mail.gmail.com>
 <20220614110258.GA32157@anparri>
 <YrPei6q4rIAx6Ymf@boqun-archlinux>
 <fd664673-c4cc-be8f-9824-5272c5c79b40@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd664673-c4cc-be8f-9824-5272c5c79b40@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 23, 2022 at 01:09:23PM -0400, Dan Lustig wrote:
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
> > 	https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/hKywNHBkAXM/m/QzUtxEWLBQAJ
> > 
> > Model 2018: released at May 2, 2018
> > 
> > 	https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/xW03vmfmPuA/m/bMPk3UCWAgAJ
> > 
> > Noted that previous conversation about commit 5ce6c1f3535f happened at
> > March 2018. So the timeline is roughly:
> > 
> > 	Model 2017 -> commit 5ce6c1f3535f -> Model 2018
> > 
> > And in the email thread of Model 2018, the commit related to model
> > changes also got mentioned:
> > 
> > 	https://github.com/riscv/riscv-isa-manual/commit/b875fe417948635ed68b9644ffdf718cb343a81a
> > 
> > in that commit, we can see the changes related to sc.aqrl are:
> > 
> > 	 to have occurred between the LR and a successful SC.  The LR/SC
> > 	 sequence can be given acquire semantics by setting the {\em aq} bit on
> > 	-the SC instruction.  The LR/SC sequence can be given release semantics
> > 	-by setting the {\em rl} bit on the LR instruction.  Setting both {\em
> > 	-  aq} and {\em rl} bits on the LR instruction, and setting the {\em
> > 	-  aq} bit on the SC instruction makes the LR/SC sequence sequentially
> > 	-consistent with respect to other sequentially consistent atomic
> > 	-operations.
> > 	+the LR instruction.  The LR/SC sequence can be given release semantics
> > 	+by setting the {\em rl} bit on the SC instruction.  Setting the {\em
> > 	+  aq} bit on the LR instruction, and setting both the {\em aq} and the {\em
> > 	+  rl} bit on the SC instruction makes the LR/SC sequence sequentially
> > 	+consistent, meaning that it cannot be reordered with earlier or
> > 	+later memory operations from the same hart.
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
> 

Well, first it's not my code ;-)

The thing is that this patch proposed by Guo Ren kinda fixes/revertes a
previous commit 5ce6c1f3535f ("riscv/atomic: Strengthen implementations
with fences"). It looks to me that Guo Ren's patch fits the current
RISCV memory model and Linux kernel memory model, but the question is
that commit 5ce6c1f3535f was also a fix, so why do we change things
back and forth? If I understand correctly, this is also what Palmer and
Andrea asked for.

My understanding is that commit 5ce6c1f3535f was based on a draft RVWMO
that was different than the current one. I'd love to record this
difference in the commit log of Guo Ren's patch, so that later on we
know why we changed things back and forth. To do so, the confirmation
from RVWMO authors is helpful.

Hope that I make things more clear ;-)

Regards,
Boqun

> Dan
> 
> > Regards,
> > Boqun
> > 
> >>   Andrea
> >>
> >>
> > [...]
