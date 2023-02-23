Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2379E6A10E5
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 20:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjBWTzB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 14:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBWTzB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 14:55:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9E456510
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2023 11:54:59 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s22so15074570lfi.9
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2023 11:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a4U4rQDieB3+PErrPuOZzC4ruO9cgcOiB3ZnT+4FxE0=;
        b=AV95KhLqE7FX5lzrt0W0+iSRH0OO5I9K0le17AnRiCJ98H+OOWPgosNoWPOKhtHhoJ
         nHpfQjWteyUk1uUMNc/hjeszD9BIJvPYLlRAVAgg4qbagNi5vdQeAVNinbqTouOCwXh3
         ssfhw+24ocFOPzcyalwsLjB46AF2PqDfZ7rek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4U4rQDieB3+PErrPuOZzC4ruO9cgcOiB3ZnT+4FxE0=;
        b=GX88QycstFz3wnJwb0y070bBJ0917jiJsjUKMUuYPYKLPv3OdYB4hjhH33nwBIRj9t
         rKC+ES7CZ8VtKXepHvJaQYcPn5Yj9kKbQ4RZK0rr1xHJkqRhuWtXoS/xYEvMQrH6rjJy
         NXe6G4HJR3fAVUqftWghy93eIXK3JiC3xa/pzHGO6Y2OisdNNQ1KM3K/sQBZcYKjm8ub
         iI19gi+T1YcWm6xp40yhgRYkap8P5gS8ETwLJn1FB+9y1/P3YgU0ATm81LUD9u1YU0Ol
         HacH42P0rHWrXG/cFdu6RDOrgftCR/DVs9oqoe+qrnfX/Y9kuHIGz53XYGymLluRG1sk
         L5IQ==
X-Gm-Message-State: AO0yUKWwkr5TDfgU46M6ych0tJA5kMBi593uVGCU4hBxXLKbhmnnV6G3
        vgS6ihdfhBoiUFaCsbjsHpS7QJkP4YOWIkhN+bATLQ==
X-Google-Smtp-Source: AK7set9z8xowq/12NOQvH+NweN+PtWimjbUsfRrP+1654wMDDFK/wRabOmRamd9s6IcF05fzmWMWsLEOtRhgOp7ir8E=
X-Received: by 2002:a05:6512:208:b0:4d5:ca32:9bdf with SMTP id
 a8-20020a056512020800b004d5ca329bdfmr4174276lfo.11.1677182097479; Thu, 23 Feb
 2023 11:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20230213015506.778246-1-joel@joelfernandes.org>
 <Y/JS5SYKPeeDQErL@rowland.harvard.edu> <CAEXW_YQrFSiDEM9cuhkTT2_1+CZoGbg7vC9oL-D-Wd5OQ2mm2w@mail.gmail.com>
 <CAEXW_YR6eKDCv+E8Xv2aX=Eo=H0667cqrXkMqKhc_QMZ4Vf59A@mail.gmail.com>
 <Y/PgxRorDQZ7wPKU@rowland.harvard.edu> <20230222195051.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/bRFNrzjIRjFgxz@rowland.harvard.edu>
In-Reply-To: <Y/bRFNrzjIRjFgxz@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 23 Feb 2023 14:54:45 -0500
Message-ID: <CAEXW_YT=bvet=tEXQ=VL-SB1p8XuhKrivRrMatgtJGsZo5VgQQ@mail.gmail.com>
Subject: Re: [PATCH] tools/memory-model: Add documentation about SRCU
 read-side critical sections
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 22, 2023 at 9:36 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Expand the discussion of SRCU and its read-side critical sections in
> the Linux Kernel Memory Model documentation file explanation.txt.  The
> new material discusses recent changes to the memory model made in
> commit 6cd244c87428 ("tools/memory-model: Provide exact SRCU
> semantics").
>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonas Oberhauser <jonas.oberhauser@huawei.com>
>
> ---
>
> Joel, please feel free to add your Co-developed-by and Signed-off-by
> tags to this patch.

Thanks!

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


 - Joel


>
>  tools/memory-model/Documentation/explanation.txt |  178 +++++++++++++++++++++--
>  1 file changed, 167 insertions(+), 11 deletions(-)
>
> Index: usb-devel/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -28,9 +28,10 @@ Explanation of the Linux-Kernel Memory C
>    20. THE HAPPENS-BEFORE RELATION: hb
>    21. THE PROPAGATES-BEFORE RELATION: pb
>    22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
> -  23. LOCKING
> -  24. PLAIN ACCESSES AND DATA RACES
> -  25. ODDS AND ENDS
> +  23. SRCU READ-SIDE CRITICAL SECTIONS
> +  24. LOCKING
> +  25. PLAIN ACCESSES AND DATA RACES
> +  26. ODDS AND ENDS
>
>
>
> @@ -1848,14 +1849,169 @@ section in P0 both starts before P1's gr
>  before it does, and the critical section in P2 both starts after P1's
>  grace period does and ends after it does.
>
> -Addendum: The LKMM now supports SRCU (Sleepable Read-Copy-Update) in
> -addition to normal RCU.  The ideas involved are much the same as
> -above, with new relations srcu-gp and srcu-rscsi added to represent
> -SRCU grace periods and read-side critical sections.  There is a
> -restriction on the srcu-gp and srcu-rscsi links that can appear in an
> -rcu-order sequence (the srcu-rscsi links must be paired with srcu-gp
> -links having the same SRCU domain with proper nesting); the details
> -are relatively unimportant.
> +The LKMM supports SRCU (Sleepable Read-Copy-Update) in addition to
> +normal RCU.  The ideas involved are much the same as above, with new
> +relations srcu-gp and srcu-rscsi added to represent SRCU grace periods
> +and read-side critical sections.  However, there are some important
> +differences between RCU read-side critical sections and their SRCU
> +counterparts, as described in the next section.
> +
> +
> +SRCU READ-SIDE CRITICAL SECTIONS
> +--------------------------------
> +
> +The LKMM models uses the srcu-rscsi relation to model SRCU read-side
> +critical sections.  They are different from RCU read-side critical
> +sections in the following respects:
> +
> +1.     Unlike the analogous RCU primitives, synchronize_srcu(),
> +       srcu_read_lock(), and srcu_read_unlock() take a pointer to a
> +       struct srcu_struct as an argument.  This structure is called
> +       an SRCU domain, and calls linked by srcu-rscsi must have the
> +       same domain.  Read-side critical sections and grace periods
> +       associated with different domains are independent of one
> +       another; the SRCU version of the RCU Guarantee applies only
> +       to pairs of critical sections and grace periods having the
> +       same domain.
> +
> +2.     srcu_read_lock() returns a value, called the index, which must
> +       be passed to the matching srcu_read_unlock() call.  Unlike
> +       rcu_read_lock() and rcu_read_unlock(), an srcu_read_lock()
> +       call does not always have to match the next unpaired
> +       srcu_read_unlock().  In fact, it is possible for two SRCU
> +       read-side critical sections to overlap partially, as in the
> +       following example (where s is an srcu_struct and idx1 and idx2
> +       are integer variables):
> +
> +               idx1 = srcu_read_lock(&s);      // Start of first RSCS
> +               idx2 = srcu_read_lock(&s);      // Start of second RSCS
> +               srcu_read_unlock(&s, idx1);     // End of first RSCS
> +               srcu_read_unlock(&s, idx2);     // End of second RSCS
> +
> +       The matching is determined entirely by the domain pointer and
> +       index value.  By contrast, if the calls had been
> +       rcu_read_lock() and rcu_read_unlock() then they would have
> +       created two nested (fully overlapping) read-side critical
> +       sections: an inner one and an outer one.
> +
> +3.     The srcu_down_read() and srcu_up_read() primitives work
> +       exactly like srcu_read_lock() and srcu_read_unlock(), except
> +       that matching calls don't have to execute on the same CPU.
> +       (The names are meant to be suggestive of operations on
> +       semaphores.)  Since the matching is determined by the domain
> +       pointer and index value, these primitives make it possible for
> +       an SRCU read-side critical section to start on one CPU and end
> +       on another, so to speak.
> +
> +In order to account for these properties of SRCU, the LKMM models
> +srcu_read_lock() as a special type of load event (which is
> +appropriate, since it takes a memory location as argument and returns
> +a value, just as a load does) and srcu_read_unlock() as a special type
> +of store event (again appropriate, since it takes as arguments a
> +memory location and a value).  These loads and stores are annotated as
> +belonging to the "srcu-lock" and "srcu-unlock" event classes
> +respectively.
> +
> +This approach allows the LKMM to tell whether two events are
> +associated with the same SRCU domain, simply by checking whether they
> +access the same memory location (i.e., they are linked by the loc
> +relation).  It also gives a way to tell which unlock matches a
> +particular lock, by checking for the presence of a data dependency
> +from the load (srcu-lock) to the store (srcu-unlock).  For example,
> +given the situation outlined earlier (with statement labels added):
> +
> +       A: idx1 = srcu_read_lock(&s);
> +       B: idx2 = srcu_read_lock(&s);
> +       C: srcu_read_unlock(&s, idx1);
> +       D: srcu_read_unlock(&s, idx2);
> +
> +the LKMM will treat A and B as loads from s yielding values saved in
> +idx1 and idx2 respectively.  Similarly, it will treat C and D as
> +though they stored the values from idx1 and idx2 in s.  The end result
> +is much as if we had written:
> +
> +       A: idx1 = READ_ONCE(s);
> +       B: idx2 = READ_ONCE(s);
> +       C: WRITE_ONCE(s, idx1);
> +       D: WRITE_ONCE(s, idx2);
> +
> +except for the presence of the special srcu-lock and srcu-unlock
> +annotations.  You can see at once that we have A ->data C and
> +B ->data D.  These dependencies tell the LKMM that C is the
> +srcu-unlock event matching srcu-lock event A, and D is the
> +srcu-unlock event matching srcu-lock event B.
> +
> +This approach is admittedly a hack, and it has the potential to lead
> +to problems.  For example, in:
> +
> +       idx1 = srcu_read_lock(&s);
> +       srcu_read_unlock(&s, idx1);
> +       idx2 = srcu_read_lock(&s);
> +       srcu_read_unlock(&s, idx2);
> +
> +the LKMM will believe that idx2 must have the same value as idx1,
> +since it reads from the immediately preceding store of idx1 in s.
> +Fortunately this won't matter, assuming that litmus tests never do
> +anything with SRCU index values other than pass them to
> +srcu_read_unlock() or srcu_up_read() calls.
> +
> +However, sometimes it is necessary to store an index value in a
> +shared variable temporarily.  In fact, this is the only way for
> +srcu_down_read() to pass the index it gets to an srcu_up_read() call
> +on a different CPU.  In more detail, we might have soething like:
> +
> +       struct srcu_struct s;
> +       int x;
> +
> +       P0()
> +       {
> +               int r0;
> +
> +               A: r0 = srcu_down_read(&s);
> +               B: WRITE_ONCE(x, r0);
> +       }
> +
> +       P1()
> +       {
> +               int r1;
> +
> +               C: r1 = READ_ONCE(x);
> +               D: srcu_up_read(&s, r1);
> +       }
> +
> +Assuming that P1 executes after P0 and does read the index value
> +stored in x, we can write this (using brackets to represent event
> +annotations) as:
> +
> +       A[srcu-lock] ->data B[once] ->rf C[once] ->data D[srcu-unlock].
> +
> +The LKMM defines a carry-srcu-data relation to express this pattern;
> +it permits an arbitrarily long sequence of
> +
> +       data ; rf
> +
> +pairs (that is, a data link followed by an rf link) to occur between
> +an srcu-lock event and the final data dependency leading to the
> +matching srcu-unlock event.  carry-srcu-data is complicated by the
> +need to ensure that none of the intermediate store events in this
> +sequence are instances of srcu-unlock.  This is necessary because in a
> +pattern like the one above:
> +
> +       A: idx1 = srcu_read_lock(&s);
> +       B: srcu_read_unlock(&s, idx1);
> +       C: idx2 = srcu_read_lock(&s);
> +       D: srcu_read_unlock(&s, idx2);
> +
> +the LKMM treats B as a store to the variable s and C as a load from
> +that variable, creating an undesirable rf link from B to C:
> +
> +       A ->data B ->rf C ->data D.
> +
> +This would cause carry-srcu-data to mistakenly extend a data
> +dependency from A to D, giving the impression that D was the
> +srcu-unlock event matching A's srcu-lock.  To avoid such problems,
> +carry-srcu-data does not accept sequences in which the ends of any of
> +the intermediate ->data links (B above) is an srcu-unlock event.
>
>
>  LOCKING
