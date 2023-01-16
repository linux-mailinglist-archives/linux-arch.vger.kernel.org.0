Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4955566CC17
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jan 2023 18:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjAPRWM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Jan 2023 12:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjAPRVA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jan 2023 12:21:00 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71D36B18
        for <linux-arch@vger.kernel.org>; Mon, 16 Jan 2023 08:59:35 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j9so19912633qvt.0
        for <linux-arch@vger.kernel.org>; Mon, 16 Jan 2023 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KjSZzRBMAdo4mybRNiLTxM/648Q8PCOSrlXM8wfEg/Y=;
        b=bbWXX/J2n8gGWFtUKJ79/dybMp54eeRhJ8ySSIK9ik1Ce0uUusco6vLIjhKxkkmNR2
         k1+hK2DvdvTiwjmrwaSfpBBiEZCkBvHNFSblOid49EHhugPTMqxH1LznEPX7jA+7DZC6
         emQgnqb2QmJAnhgv5aqvzEUPOTkyNDkQF4oR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjSZzRBMAdo4mybRNiLTxM/648Q8PCOSrlXM8wfEg/Y=;
        b=1Xvd2n1ew7vC2pbC2TYOxJCsnj9J6iKCOH98w6sr9mwOCP4a7AYZfRUjO5yoAmtQFI
         1Iem4qjEj/9JXGnguldBLPnP0q59Gn0Ryu+fxfmrAqs7pE4cmUe9r+L8Bin+jQTwskb4
         mgdgWu9WhS5k0HtnY1dX7X2ST3yPZo+fSXHIZAnWEeOncAQzaOiPY1AhHeOUyMgPjzTh
         wfIsWizcGNk3CEI8Fu30H0V/39CgH6OCpWV3aFPXMgyzfl2yARdJZysPuNCUw+dZWTZz
         0cOOP9+JNm1FCjanYNE9Luk5br5REUyWMA8M7c0pqDurw6SinmpXCuLEFdFGnE/wwzFg
         CGKg==
X-Gm-Message-State: AFqh2krSJwparB4GPVs+l8Bkl4Hn+e2jfVY9HASOkcrr4+S/xlVSycov
        CfRpBp9qwCKICz7Hik899ZHK3pdJGha8IJyF
X-Google-Smtp-Source: AMrXdXsDAIcpaTY+Ksg4r3NEtHybFdiJ8TIFyzI9UPghTw1dL6wXTUxYFIZyu3kqAVLBmqwB5CIqBg==
X-Received: by 2002:a05:6214:3113:b0:534:97bb:af73 with SMTP id ks19-20020a056214311300b0053497bbaf73mr595164qvb.4.1673888374074;
        Mon, 16 Jan 2023 08:59:34 -0800 (PST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id bl24-20020a05620a1a9800b007059c5929b8sm2698277qkb.21.2023.01.16.08.59.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:59:33 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id l14so16030261qvw.12
        for <linux-arch@vger.kernel.org>; Mon, 16 Jan 2023 08:59:32 -0800 (PST)
X-Received: by 2002:a05:6214:5d11:b0:531:7593:f551 with SMTP id
 me17-20020a0562145d1100b005317593f551mr11158qvb.89.1673888372051; Mon, 16 Jan
 2023 08:59:32 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
 <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo> <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com>
 <1966767.1673878095@warthog.procyon.org.uk>
In-Reply-To: <1966767.1673878095@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jan 2023 08:59:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whjFwzEq0u04=n=t7-kNJdX0HkAOjAMjmLXDDycJ+j9yQ@mail.gmail.com>
Message-ID: <CAHk-=whjFwzEq0u04=n=t7-kNJdX0HkAOjAMjmLXDDycJ+j9yQ@mail.gmail.com>
Subject: Re: Memory transaction instructions
To:     David Howells <dhowells@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, tony.luck@intel.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Jan Glauber <jan.glauber@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 16, 2023 at 6:08 AM David Howells <dhowells@redhat.com> wrote:
>
> I'm not sure how relevant it is to the topic, but I seem to remember you
> having a go at implementing spinlocks with x86_64 memory transaction
> instructions a while back.  Do you have any thoughts on whether these
> instructions are ever likely to become something we can use?

Nope.

Not only are they buggy, the actual cost of them was prohibitive too.

The only implementation I ever did was what then became 'lockref' (so
this was about a decade ago), and using transactional memory was
actually quite noticeably *slower* than just using a spinlock in the
common cases (particularly the uncontended case - which is actually
the common one by far, despite some benchmarks).

And while the argument could be that transactional memory has improved
in the last decade (narrator: "It hasn't"), the problem is actually
quite fundamental.

The whole "best case scenario" for transactional memory concept is
literally optimized and designed for the rare circumstance - the case
where you have contention, but where the locking part is basically an
idempotent operation (so "lock+unlock" ends up undoing each other and
can use shared cachelines rather than bouncing the cacheline).

And contention pretty much happens in one situation, and one situation
only: in a combination of (a) bad locking and (b) benchmarks.

And for the kernel, where we don't have bad locking, and where we
actually use fine-grained locks that are _near_ the data that we are
locking (the lockref of the dcache is obviously one example of that,
but the skbuff queue you mention is almost certainly exactly the same
situation): the lock is right by the data that the lock protects, and
the "shared lock cacheline" model simply does not work. You'll bounce
the data, and most likely you'll also touch the same lock cacheline
too.

I was quite excited about transactional memory, but have (obviously)
come to the conclusion that it was one of those "looks good in theory,
but is just garbage in reality".

So this isn't an "the x86 implementation was bad" issue. This is a
"transactional memory is a bad idea" situation. It complicates the
most important part of the core CPU (the memory pipeline) enormously,
and it doesn't actually really work.

Now, with that "transactional memory is garbage" in mind, let me just
mention that there are obviously other circumstances:

 (a) horrendously bad locking

If you have a single centralized lock, and you really have serious
contention on it in real life all the time (and not just under
microbenchmarks), and the data that gets touched is spread out all
over, and you simply cannot fix the locking, then all those
theoretical advantages of transactional memory can actually come into
play.

But again: even then, there's an absolutely huge cost to the memory
pipeline.  So that advantage really doesn't come free. Nobody has ever
gotten transactional memory to actually work well in real life. Not
Intel, not IBM with powerpc HTM.

That should tell you something. The hw complexity cost is very very real.

But Intel actually had some loads where TSX helped. I think it was SAP
HANA, and I really think that what you should take away from that is
that SAP HANA locking is likely horrible garbage inside. But maybe I'm
biased, and maybe SAP HANA is lovely, and maybe it just happened to
work really well for TSX. I've never actually looked at that load, but
if I were a betting man...

 (b) very *limited* transactions are probably a great idea

LL/SC is arguably a form of "transactional memory", just with a single
word. Now, I think atomics are generally usually better than LL/SC
when it really is just a single word (because most of the time,
"single word" also means "simple semantics", and while CMPXCHG loops
aren't lovely when the semantics are a bit more complex, it's actually
nice and portable and works at a higher level than assembler sequences
and as such is actually a *lot* better than LL/SC in practice).

But a "N-word LL/SC with forward progress guarantees" would be
objectively stronger than atomics, and would allow for doing low-level
data structures in ways that atomics don't. Doubly linked lists
together with a lock check would argue for "N" being ~5 memory
operations. So I do believe in potentially *limited* memory
transactions, when they can be made limited enough that you have

 (1) forward progress guarantees with no "separate fallback on
contention" garbage

 (2) can keep the hw implementation simple enough with just a store
buffer and an (architecturally) very limited number of cacheline
accesses that you can actually order in HW so that you don't have ABBA
situations.

But the generic kind of transactional memory that Intel tried with TSX
(and IBM with HTM) is pure garbage, and almost certainly always will
be.

And all of the above is obviously just my opinionated input on it. But
I just happen to be right.

                Linus
