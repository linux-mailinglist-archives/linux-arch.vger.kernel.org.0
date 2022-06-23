Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E30557210
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 06:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiFWEoT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 00:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbiFWDbm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 23:31:42 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CB23584F;
        Wed, 22 Jun 2022 20:31:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id p21so2098177qki.7;
        Wed, 22 Jun 2022 20:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iETqc+0lijFZ14zCNnfCSiDsY3yxYpnuYnsCd/H37sM=;
        b=XKQr60hHEpIr7iE2oQMJHBd/HDGQCZhaSPpmeuw6TyKQkYL2MF+8jdtsqUCz7uL090
         Rc90KAFbCLt0JwHQ7vCIyEX0mj9/duP+7TF6SlIMyM86A8tJXhvp6mW5g1QMYcFMm06q
         OZhDv9iwxJwHYCl8D05Sv3M3yI+gUsqDtuKv/FhshrgMg3aaZz2lgZeLKguk6uF7IRXr
         cNriRKL9+D3vNavHkaKAfctj+1iVXUr8uNGq3KbwjLdVPWLWbnlMjLar4aOtzfnqqsG1
         IsuxOEdrqkfV7FuJV0wVV7InjeaCmRhOkIonyeI7vJokQaKzp0nLlHjjfWTw37p0n1hs
         m3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iETqc+0lijFZ14zCNnfCSiDsY3yxYpnuYnsCd/H37sM=;
        b=kdRh89l19FS7/sg2UmPC1+PIRxpnLY5vK9YK75uJJXDANv+XHqCCsYbV+nn18IdCIB
         Wbiwk5Dcs7MgchFiRiA/7Psf2YzQNQEJUyew+mn5mvdxxH0Rm+EmEG6H/9Kkg57h48f6
         nT9jLFpXdj9AWYxc8g4RpIJfrB4d+EwhrPlJiOCNXhdKuwag4cD5VFDiaLI7p6dGoCjt
         HNh/Hp9VS3h4WYuv6GrVaB28PBB5UOuScvRXcEBIM9YIW5MT9jyXGcl4luDhyIe51gp4
         s+z5DnawSjmTFW3Yh8uYpVVerwHfquIXa29nSeNHGawumf7fbdgQkUI5mj+UX/7zDa2T
         Bz+A==
X-Gm-Message-State: AJIora9lLR/l7tCpUUwqijNWEIa5YZvD73KnK1J28sX0rLcmVBRSLIIg
        m0dxmDIzKxsx2j5r/6dsoPXVvFOgk84=
X-Google-Smtp-Source: AGRyM1tog79QF/BM4XYNYwOk5JDAVQGSrmJOA/BPSicl6+PpfP5C/VU3C9rh50h8yJ2wwtZJnXowiQ==
X-Received: by 2002:a05:620a:410:b0:6a6:abbe:2018 with SMTP id 16-20020a05620a041000b006a6abbe2018mr4736397qkp.645.1655955098873;
        Wed, 22 Jun 2022 20:31:38 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a444800b006a6f68c8a87sm19125307qkp.126.2022.06.22.20.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:31:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9792927C005A;
        Wed, 22 Jun 2022 23:31:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Jun 2022 23:31:37 -0400
X-ME-Sender: <xms:mN6zYnQKaLySnOd9VxDXjDwnGZmLTZp5pcoBSLC14CVRiYD-4dkwPw>
    <xme:mN6zYozHljR1xtO0TqSrgYgIzlLhQmxyZxq-d-vd8Ei8eOXyjVJa_tZojuQ7z_4o6
    _v48XaZ7RZMfdGxPw>
X-ME-Received: <xmr:mN6zYs0W6y8qNOg5L2xB5Yu6taF9iYJdInFUKKN7W13mLFGdaxvUbx6732EQ7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefiedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggu
    jgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfh
    gvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffkeevvdejhedutdet
    hfejiedttddthfetffdufeduleektddvgfduvdfhjeelueenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgpdhgohhoghhlvgdrtghomhdprhhishgtvhdrohhrghdpghhithhhuhgs
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:mN6zYnBPdK3t52BMAfRz2zUIZllzPyUBJ7JsU8Y-7lOZuHAn8dqQow>
    <xmx:mN6zYgg3aPGAOi1epe1R9Xa01Nw-9_ZY9KGDjke08_7ALt_XuFsALw>
    <xmx:mN6zYro6F5dpRtrEpiVoyiFeKvd60ifj5XAEsR_CwzN6Y-SSRVXdow>
    <xmx:md6zYvpvOSZfhora_uKsjFdbpAJiFHSus5asheFt3AsquhBWIzp1ug>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 23:31:36 -0400 (EDT)
Date:   Wed, 22 Jun 2022 20:31:23 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lustig <dlustig@nvidia.com>,
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
Message-ID: <YrPei6q4rIAx6Ymf@boqun-archlinux>
References: <CAJF2gTQoSQq_S4UvAiXgMviT040Ls8+VkDszQSke1a0zbXZ82A@mail.gmail.com>
 <mhng-7a274375-0d99-41c8-98a3-853d110f62e9@palmer-ri-x1c9>
 <CAJF2gTTXO42_TsZudaQuB9Re0teu__EZ11JZ96nktMqsQkMYNA@mail.gmail.com>
 <20220614110258.GA32157@anparri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614110258.GA32157@anparri>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Tue, Jun 14, 2022 at 01:03:47PM +0200, Andrea Parri wrote:
[...]
> > 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> > is about fixup wrong spinlock/unlock implementation and not relate to
> > this patch.
>
> No.  The commit in question is evidence of the fact that the changes
> you are presenting here (as an optimization) were buggy/incorrect at
> the time in which that commit was worked out.
> 
> 
> > Actually, sc.w.aqrl is very strong and the same with:
> > fence rw, rw
> > sc.w
> > fence rw,rw
> > 
> > So "which do not give full-ordering with .aqrl" is not writen in
> > RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
> > 
> > >
> > > >> describes the issue more specifically, that's when we added these
> > > >> fences.  There have certainly been complains that these fences are too
> > > >> heavyweight for the HW to go fast, but IIUC it's the best option we have
> > > > Yeah, it would reduce the performance on D1 and our next-generation
> > > > processor has optimized fence performance a lot.
> > >
> > > Definately a bummer that the fences make the HW go slow, but I don't
> > > really see any other way to go about this.  If you think these mappings
> > > are valid for LKMM and RVWMO then we should figure this out, but trying
> > > to drop fences to make HW go faster in ways that violate the memory
> > > model is going to lead to insanity.
> > Actually, this patch is okay with the ISA spec, and Dan also thought
> > it was valid.
> > 
> > ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw
> 
> "Thoughts" on this regard have _changed_.  Please compare that quote
> with, e.g.
> 
>   https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/
> 
> So here's a suggestion:
> 
> Reviewers of your patches have asked:  How come that code we used to
> consider as buggy is now considered "an optimization" (correct)?
> 
> Denying the evidence or going around it is not making their job (and
> this upstreaming) easier, so why don't you address it?  Take time to
> review previous works and discussions in this area, understand them,
> and integrate such knowledge in future submissions.
> 

I agree with Andrea.

And I actually took a look into this, and I think I find some
explanation. There are two versions of RISV memory model here:

Model 2017: released at Dec 1, 2017 as a draft

	https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/hKywNHBkAXM/m/QzUtxEWLBQAJ

Model 2018: released at May 2, 2018

	https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/xW03vmfmPuA/m/bMPk3UCWAgAJ

Noted that previous conversation about commit 5ce6c1f3535f happened at
March 2018. So the timeline is roughly:

	Model 2017 -> commit 5ce6c1f3535f -> Model 2018

And in the email thread of Model 2018, the commit related to model
changes also got mentioned:

	https://github.com/riscv/riscv-isa-manual/commit/b875fe417948635ed68b9644ffdf718cb343a81a

in that commit, we can see the changes related to sc.aqrl are:

	 to have occurred between the LR and a successful SC.  The LR/SC
	 sequence can be given acquire semantics by setting the {\em aq} bit on
	-the SC instruction.  The LR/SC sequence can be given release semantics
	-by setting the {\em rl} bit on the LR instruction.  Setting both {\em
	-  aq} and {\em rl} bits on the LR instruction, and setting the {\em
	-  aq} bit on the SC instruction makes the LR/SC sequence sequentially
	-consistent with respect to other sequentially consistent atomic
	-operations.
	+the LR instruction.  The LR/SC sequence can be given release semantics
	+by setting the {\em rl} bit on the SC instruction.  Setting the {\em
	+  aq} bit on the LR instruction, and setting both the {\em aq} and the {\em
	+  rl} bit on the SC instruction makes the LR/SC sequence sequentially
	+consistent, meaning that it cannot be reordered with earlier or
	+later memory operations from the same hart.

note that Model 2018 explicitly says that "ld.aq+sc.aqrl" is ordered
against "earlier or later memory operations from the same hart", and
this statement was not in Model 2017.

So my understanding of the story is that at some point between March and
May 2018, RISV memory model folks decided to add this rule, which does
look more consistent with other parts of the model and is useful.

And this is why (and when) "ld.aq+sc.aqrl" can be used as a fully-ordered
barrier ;-)

Now if my understanding is correct, to move forward, it's better that 1)
this patch gets resend with the above information (better rewording a
bit), and 2) gets an Acked-by from Dan to confirm this is a correct
history ;-)

Regards,
Boqun

>   Andrea
> 
> 
[...]
