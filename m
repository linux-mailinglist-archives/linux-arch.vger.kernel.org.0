Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D79869D7CB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Feb 2023 01:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjBUA66 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 19:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBUA66 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 19:58:58 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1059B93D3
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 16:58:56 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id f1so3909802qvx.13
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 16:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtHN1DgoRqr2Ay47r+sHQwKz0JkWSbPOHgkJwWGWT+c=;
        b=trh3wO2P5RoBJwzLqkMPs6xcj+FmWrZwVJ/4Ft1dD4xgWxOGzAuFdNpVJNmdEsYqhP
         PbFDPBn3D/1QpFpgPB6e7loUh4U4u2Iu7WJDK1u/uOAkinwfZakAZWext1O3rmWW9zW+
         63NMxTE22XNpsNBZY5r9iaG7hutz/+N3DFfoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtHN1DgoRqr2Ay47r+sHQwKz0JkWSbPOHgkJwWGWT+c=;
        b=r0ujTGAPjfl9rpcxTlBJ4T785ADyn0sp1dRrRj1wW9HmSel/4WGLaw8VG2BZackukd
         LSUmrOWuCYZGPKeP6WkMqZNpGpE84ude6L5I/Q7jSP6qaLyjtW8UY5P+TZJhO/LYyR1K
         wKjbjfd6xlZJYoJN+50juavZqJwW7AyzJLUvIwO+WQCSvQtAgiNu5fcKpCw1M7gOj4Ok
         EI8S+fYBHbqpYDiWgI9aF1AOl+plmajN08U2F5CI6Nd4Hx8x1McukQ/T/t5SYjQozeZL
         ltYUxvDu0mu4l5o/Mmn/WWvH6YNvY41G4D9X8fJQDfOQOVl0jY9jzQ2pKbnvbBDnkEsZ
         7sjg==
X-Gm-Message-State: AO0yUKWcucTeQl09D4tBX4cWka3VzLp6QbkLWNnLURahOz0ik0lxE0HX
        1LoQrlsaCTfoauWXzUskiM2Z3g==
X-Google-Smtp-Source: AK7set90yXQoiEC6YPRTOsb5vuGyvmifVmCKz0YBoQL5M+/0tEor6TfkR8GTsV40W+UmLmmuwf6p4g==
X-Received: by 2002:a05:6214:dc6:b0:56f:979:b1e8 with SMTP id 6-20020a0562140dc600b0056f0979b1e8mr6908461qvt.48.1676941135016;
        Mon, 20 Feb 2023 16:58:55 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id 3-20020a05620a048300b007290be5557bsm1825868qkr.38.2023.02.20.16.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 16:58:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] tools/memory-model: Add details about SRCU read-side critical sections
Date:   Mon, 20 Feb 2023 19:58:43 -0500
Message-Id: <BCA3CF43-3F03-4DFB-AB2F-FC1A638D743E@joelfernandes.org>
References: <Y/PgxRorDQZ7wPKU@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        =?utf-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
In-Reply-To: <Y/PgxRorDQZ7wPKU@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Feb 20, 2023, at 4:06 PM, Alan Stern <stern@rowland.harvard.edu> wrote:=

>=20
> =EF=BB=BFOn Sun, Feb 19, 2023 at 12:13:14PM -0500, Joel Fernandes wrote:
>>> On Sun, Feb 19, 2023 at 12:11 PM Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>>> Even though it may be redundant: would it be possible to also mention
>>> (after this paragraph) that this case forms an undesirable "->rf" link
>>> between B and C, which then causes us to link A and D as a result?
>>>=20
>>> A[srcu-lock] ->data B[once] ->rf C[once] ->data D[srcu-unlock].
>>=20
>> Apologies, I meant here, care must be taken to avoid:
>>=20
>> A[srcu-lock] ->data B[srcu-unlock] ->rf C[srcu-lock] ->data D[srcu-unlock=
].
>=20
> Revised patch below.  I changed more than just this bit.  Mostly small=20
> edits to improve readability, but I did add a little additional=20
> material.

Looks good to me. Thanks!

 - Joel


>=20
> Alan
>=20
>=20
>=20
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -28,9 +28,10 @@ Explanation of the Linux-Kernel Memory C
>   20. THE HAPPENS-BEFORE RELATION: hb
>   21. THE PROPAGATES-BEFORE RELATION: pb
>   22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, an=
d rb
> -  23. LOCKING
> -  24. PLAIN ACCESSES AND DATA RACES
> -  25. ODDS AND ENDS
> +  23. SRCU READ-SIDE CRITICAL SECTIONS
> +  24. LOCKING
> +  25. PLAIN ACCESSES AND DATA RACES
> +  26. ODDS AND ENDS
>=20
>=20
>=20
> @@ -1848,14 +1849,169 @@ section in P0 both starts before P1's gr
> before it does, and the critical section in P2 both starts after P1's
> grace period does and ends after it does.
>=20
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
> +1.    Unlike the analogous RCU primitives, synchronize_srcu(),
> +    srcu_read_lock(), and srcu_read_unlock() take a pointer to a
> +    struct srcu_struct as an argument.  This structure is called
> +    an SRCU domain, and calls linked by srcu-rscsi must have the
> +    same domain.  Read-side critical sections and grace periods
> +    associated with different domains are independent of one
> +    another; the SRCU version of the RCU Guarantee applies only
> +    to pairs of critical sections and grace periods having the
> +    same domain.
> +
> +2.    srcu_read_lock() returns a value, called the index, which must
> +    be passed to the matching srcu_read_unlock() call.  Unlike
> +    rcu_read_lock() and rcu_read_unlock(), an srcu_read_lock()
> +    call does not always have to match the next unpaired
> +    srcu_read_unlock().  In fact, it is possible for two SRCU
> +    read-side critical sections to overlap partially, as in the
> +    following example (where s is an srcu_struct and idx1 and idx2
> +    are integer variables):
> +
> +        idx1 =3D srcu_read_lock(&s);    // Start of first RSCS
> +        idx2 =3D srcu_read_lock(&s);    // Start of second RSCS
> +        srcu_read_unlock(&s, idx1);    // End of first RSCS
> +        srcu_read_unlock(&s, idx2);    // End of second RSCS
> +
> +    The matching is determined entirely by the domain pointer and
> +    index value.  By contrast, if the calls had been
> +    rcu_read_lock() and rcu_read_unlock() then they would have
> +    created two nested (fully overlapping) read-side critical
> +    sections: an inner one and an outer one.
> +
> +3.    The srcu_down_read() and srcu_up_read() primitives work
> +    exactly like srcu_read_lock() and srcu_read_unlock(), except
> +    that matching calls don't have to execute on the same CPU.
> +    (The names are meant to be suggestive of operations on
> +    semaphores.)  Since the matching is determined by the domain
> +    pointer and index value, these primitives make it possible for
> +    an SRCU read-side critical section to start on one CPU and end
> +    on another, so to speak.
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
> +    A: idx1 =3D srcu_read_lock(&s);
> +    B: idx2 =3D srcu_read_lock(&s);
> +    C: srcu_read_unlock(&s, idx1);
> +    D: srcu_read_unlock(&s, idx2);
> +
> +the LKMM will treat A and B as loads from s yielding values saved in
> +idx1 and idx2 respectively.  Similarly, it will treat C and D as
> +though they stored the values from idx1 and idx2 in s.  The end result
> +is much as if we had written:
> +
> +    A: idx1 =3D READ_ONCE(s);
> +    B: idx2 =3D READ_ONCE(s);
> +    C: WRITE_ONCE(s, idx1);
> +    D: WRITE_ONCE(s, idx2);
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
> +    idx1 =3D srcu_read_lock(&s);
> +    srcu_read_unlock(&s, idx1);
> +    idx2 =3D srcu_read_lock(&s);
> +    srcu_read_unlock(&s, idx2);
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
> +    struct srcu_struct s;
> +    int x;
> +
> +    P0()
> +    {
> +        int r0;
> +
> +        A: r0 =3D srcu_down_read(&s);
> +        B: WRITE_ONCE(x, r0);
> +    }
> +
> +    P1()
> +    {
> +        int r1;
> +
> +        C: r1 =3D READ_ONCE(x);
> +        D: srcu_up_read(&s, r1);
> +    }
> +
> +Assuming that P1 executes after P0 and does read the index value
> +stored in x, we can write this (using brackets to represent event
> +annotations) as:
> +
> +    A[srcu-lock] ->data B[once] ->rf C[once] ->data D[srcu-unlock].
> +
> +The LKMM defines a carries-srcu-data relation to express this
> +pattern; it permits an arbitrarily long sequence of
> +
> +    data ; rf
> +
> +pairs (that is, a data link followed by an rf link) to occur between
> +an srcu-lock event and the final data dependency leading to the
> +matching srcu-unlock event.  carry-srcu-data is complicated by the
> +need to ensure that none of the intermediate store events in this
> +sequence are instances of srcu-unlock.  This is necessary because in a
> +pattern like the one above:
> +
> +    A: idx1 =3D srcu_read_lock(&s);
> +    B: srcu_read_unlock(&s, idx1);
> +    C: idx2 =3D srcu_read_lock(&s);
> +    D: srcu_read_unlock(&s, idx2);
> +
> +the LKMM treats B as a store to the variable s and C as a load from
> +that variable, creating an undesirable rf link from B to C:
> +
> +    A ->data B ->rf C ->data D.
> +
> +This would cause carry-srcu-data to mistakenly extend a data
> +dependency from A to D and give the impression that D was the
> +srcu-unlock event matching A's srcu-lock.  To avoid such problems,
> +carry-srcu-data does not accept sequences in which the ends of any of
> +the intermediate ->data links (B above) is an srcu-unlock event.
>=20
>=20
> LOCKING
>=20
