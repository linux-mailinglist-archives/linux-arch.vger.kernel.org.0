Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8BE558B28
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 00:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiFWWPg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiFWWPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 18:15:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC04D9C2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 15:15:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d14so938279pjs.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Lv8fuWFnEj20dY6Qx6c1WZJrE8ba+8p1inUKoTp96/w=;
        b=Q+0Esb0n2/u7z284w/2pQMS+0TVuNu6k0/7WLW24wexCyAgcQwp+DAfYFf8Oxr8yLy
         YaaNFmwr3QJj5X8BNXFNoZnHNzVgja8+rOaAxS9N3DZ9YqDTPPdrsu4ZQtohcQuo+z0L
         QZMVRLaa6gWm/8OFFgs5pDT1EH0f0kfBQBz7OAH9v+6SOeNh+UH1q5nLHKHx9Wk/LywJ
         uT+6DfRqUnwDtE6ePjpfA3Pj2F9AagWyeK0kD4HRo5dr8XxV4YQHGkYWDbS1NI0dnYG5
         ILiDCkRf3Bv2E1AXYRLQeRnHmsKCwBm91EJ36T/eB/KdqZaMmMGNMMcAoftajwGt4gdu
         taxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Lv8fuWFnEj20dY6Qx6c1WZJrE8ba+8p1inUKoTp96/w=;
        b=eVpgNQiMandWGds4AYP91TYb30uE3++POW3kxRlSR2DoJ08O55MKtrhyG3sMlPor9x
         KLYNSSy30VZJd2hKMaaVvIJja8WZ4orqFbpVfTPufzKpRvr9uqKkcvDFB+CJ7fTBLl+b
         6GNnIu7TyVuSvuDWLr0uXSLyDLuVMLD4P+IPmUtTmYiMJXzEWF2mRVp3uslNBtQc39/A
         caalrbcYWFD6V3dp6spGsiF9WjkOjz2FVgG7RMSv0Z8Ki7Aq8qoUzX0vkWWa/tSv0pR0
         ZIyBnQCA2y69qS4rNneWMylw9gzDUXOpOZGxo5lCtjdU0hmL2r/4MVAaMuxVxOx6hQpS
         wCpg==
X-Gm-Message-State: AJIora88kKpVeyIBg8y4bZibpm2g1ken7rSQHomrp6ygCKNJysBLRg36
        ICKQ0KPoaDDRbainSWDbNt0woQ==
X-Google-Smtp-Source: AGRyM1sDFdjef/jMRpZMZdy7OCVQG8uP4Lz9rjzDx/2mDnhKUwt7lRQbLU4mNGlSzQQWN3pYnbqW7w==
X-Received: by 2002:a17:903:2347:b0:16a:33cd:5308 with SMTP id c7-20020a170903234700b0016a33cd5308mr17395122plh.122.1656022533229;
        Thu, 23 Jun 2022 15:15:33 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902710400b00162037fbb68sm274884pll.215.2022.06.23.15.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 15:15:32 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:15:32 -0700 (PDT)
X-Google-Original-Date: Thu, 23 Jun 2022 15:15:29 PDT (-0700)
Subject:     Re: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops with .aqrl annotation
In-Reply-To: <YrSo/3iUuO0AL76T@boqun-archlinux>
CC:     Daniel Lustig <dlustig@nvidia.com>, parri.andrea@gmail.com,
        guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        mark.rutland@arm.com, Will Deacon <will@kernel.org>,
        peterz@infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     boqun.feng@gmail.com
Message-ID: <mhng-f42f1283-50c1-48f1-ab2e-c5700b352aa1@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 23 Jun 2022 10:55:11 PDT (-0700), boqun.feng@gmail.com wrote:
> On Thu, Jun 23, 2022 at 01:09:23PM -0400, Dan Lustig wrote:
>> On 6/22/2022 11:31 PM, Boqun Feng wrote:
>> > Hi,
>> >
>> > On Tue, Jun 14, 2022 at 01:03:47PM +0200, Andrea Parri wrote:
>> > [...]
>> >>> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
>> >>> is about fixup wrong spinlock/unlock implementation and not relate to
>> >>> this patch.
>> >>
>> >> No.  The commit in question is evidence of the fact that the changes
>> >> you are presenting here (as an optimization) were buggy/incorrect at
>> >> the time in which that commit was worked out.
>> >>
>> >>
>> >>> Actually, sc.w.aqrl is very strong and the same with:
>> >>> fence rw, rw
>> >>> sc.w
>> >>> fence rw,rw
>> >>>
>> >>> So "which do not give full-ordering with .aqrl" is not writen in
>> >>> RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
>> >>>
>> >>>>
>> >>>>>> describes the issue more specifically, that's when we added these
>> >>>>>> fences.  There have certainly been complains that these fences are too
>> >>>>>> heavyweight for the HW to go fast, but IIUC it's the best option we have
>> >>>>> Yeah, it would reduce the performance on D1 and our next-generation
>> >>>>> processor has optimized fence performance a lot.
>> >>>>
>> >>>> Definately a bummer that the fences make the HW go slow, but I don't
>> >>>> really see any other way to go about this.  If you think these mappings
>> >>>> are valid for LKMM and RVWMO then we should figure this out, but trying
>> >>>> to drop fences to make HW go faster in ways that violate the memory
>> >>>> model is going to lead to insanity.
>> >>> Actually, this patch is okay with the ISA spec, and Dan also thought
>> >>> it was valid.
>> >>>
>> >>> ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw
>> >>
>> >> "Thoughts" on this regard have _changed_.  Please compare that quote
>> >> with, e.g.
>> >>
>> >>   https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/
>> >>
>> >> So here's a suggestion:
>> >>
>> >> Reviewers of your patches have asked:  How come that code we used to
>> >> consider as buggy is now considered "an optimization" (correct)?
>> >>
>> >> Denying the evidence or going around it is not making their job (and
>> >> this upstreaming) easier, so why don't you address it?  Take time to
>> >> review previous works and discussions in this area, understand them,
>> >> and integrate such knowledge in future submissions.
>> >>
>> >
>> > I agree with Andrea.
>> >
>> > And I actually took a look into this, and I think I find some
>> > explanation. There are two versions of RISV memory model here:
>> >
>> > Model 2017: released at Dec 1, 2017 as a draft
>> >
>> > 	https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/hKywNHBkAXM/m/QzUtxEWLBQAJ
>> >
>> > Model 2018: released at May 2, 2018
>> >
>> > 	https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/xW03vmfmPuA/m/bMPk3UCWAgAJ
>> >
>> > Noted that previous conversation about commit 5ce6c1f3535f happened at
>> > March 2018. So the timeline is roughly:
>> >
>> > 	Model 2017 -> commit 5ce6c1f3535f -> Model 2018
>> >
>> > And in the email thread of Model 2018, the commit related to model
>> > changes also got mentioned:
>> >
>> > 	https://github.com/riscv/riscv-isa-manual/commit/b875fe417948635ed68b9644ffdf718cb343a81a
>> >
>> > in that commit, we can see the changes related to sc.aqrl are:
>> >
>> > 	 to have occurred between the LR and a successful SC.  The LR/SC
>> > 	 sequence can be given acquire semantics by setting the {\em aq} bit on
>> > 	-the SC instruction.  The LR/SC sequence can be given release semantics
>> > 	-by setting the {\em rl} bit on the LR instruction.  Setting both {\em
>> > 	-  aq} and {\em rl} bits on the LR instruction, and setting the {\em
>> > 	-  aq} bit on the SC instruction makes the LR/SC sequence sequentially
>> > 	-consistent with respect to other sequentially consistent atomic
>> > 	-operations.
>> > 	+the LR instruction.  The LR/SC sequence can be given release semantics
>> > 	+by setting the {\em rl} bit on the SC instruction.  Setting the {\em
>> > 	+  aq} bit on the LR instruction, and setting both the {\em aq} and the {\em
>> > 	+  rl} bit on the SC instruction makes the LR/SC sequence sequentially
>> > 	+consistent, meaning that it cannot be reordered with earlier or
>> > 	+later memory operations from the same hart.
>> >
>> > note that Model 2018 explicitly says that "ld.aq+sc.aqrl" is ordered
>> > against "earlier or later memory operations from the same hart", and
>> > this statement was not in Model 2017.
>> >
>> > So my understanding of the story is that at some point between March and
>> > May 2018, RISV memory model folks decided to add this rule, which does
>> > look more consistent with other parts of the model and is useful.
>> >
>> > And this is why (and when) "ld.aq+sc.aqrl" can be used as a fully-ordered
>> > barrier ;-)
>> >
>> > Now if my understanding is correct, to move forward, it's better that 1)
>> > this patch gets resend with the above information (better rewording a
>> > bit), and 2) gets an Acked-by from Dan to confirm this is a correct
>> > history ;-)
>>
>> I'm a bit lost as to why digging into RISC-V mailing list history is
>> relevant here...what's relevant is what was ratified in the RVWMO
>> chapter of the RISC-V spec, and whether the code you're proposing
>> is the most optimized code that is correct wrt RVWMO.
>>
>> Is your claim that the code you're proposing to fix was based on a
>> pre-RVWMO RISC-V memory model definition, and you're updating it to
>> be more RVWMO-compliant?
>>
>
> Well, first it's not my code ;-)
>
> The thing is that this patch proposed by Guo Ren kinda fixes/revertes a
> previous commit 5ce6c1f3535f ("riscv/atomic: Strengthen implementations
> with fences"). It looks to me that Guo Ren's patch fits the current
> RISCV memory model and Linux kernel memory model, but the question is
> that commit 5ce6c1f3535f was also a fix, so why do we change things
> back and forth? If I understand correctly, this is also what Palmer and
> Andrea asked for.

That's essentially my confusion.  I'm not really a formal memory model 
guy so I can easily get lost in these bits, but when I saw it I 
remembered having looked at a fix before.  I dug that up, saw it was 
from someone who likley knows a lot more about formal memory models than 
I do, and thus figured I'd ask everyone to see what's up.

IMO if that original fix was made to a pre-ratification version of WMO, 
this new version is legal WRT the ratified WMO then the code change is 
fine to take on for-next.  That said, we should be explicit about why 
it's legal and why the reasoning in the previous patch is no loger 
connect, just to make sure everyone can follow along.

> My understanding is that commit 5ce6c1f3535f was based on a draft RVWMO
> that was different than the current one. I'd love to record this
> difference in the commit log of Guo Ren's patch, so that later on we
> know why we changed things back and forth. To do so, the confirmation
> from RVWMO authors is helpful.

Agreed.  IMO that's always good hygine, but it's extra important when 
we're dealing with external specifications in a complex field like 
formal models.

> Hope that I make things more clear ;-)
>
> Regards,
> Boqun
>
>> Dan
>>
>> > Regards,
>> > Boqun
>> >
>> >>   Andrea
>> >>
>> >>
>> > [...]
