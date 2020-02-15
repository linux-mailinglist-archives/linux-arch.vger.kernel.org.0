Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6C15FB55
	for <lists+linux-arch@lfdr.de>; Sat, 15 Feb 2020 01:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBOAJv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 19:09:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46236 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgBOAJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 19:09:51 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so10436035qkh.13;
        Fri, 14 Feb 2020 16:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ia2+KV8baoEH8oMfE5Wevs73qaESjR2Z5zdSBZxQuI=;
        b=ewso7YgViAjicIdY5qB7ZIpRtTj3iM1Q+4PKWdPGJHfD4A99zuGXyXr/t5xEFa3jEq
         olay1KllHUW5Oqn+Wk2+PmZ0DF2mjJIabUM11l+G3ENZsiQJfHoOmEXdLJVgeBdV8GB3
         gr8w3J2eXhOFBue7Amiftm3hpQD+ptBgEBKa47hox8SEEUTClzJP5nOYJNxx1OoCTmrQ
         Lyo+NG+Csvf4TBZkXx/gvpfOsF+B93oT2p3AjoeL+i+NKuam1OSs8RSIXiHETWEweiAo
         j9JmTUztfawQAIZqQJE2xArDaEo3KTHvkf1wfUwCmWFJc7useC37SSqAgSQfTBjMop7P
         i8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ia2+KV8baoEH8oMfE5Wevs73qaESjR2Z5zdSBZxQuI=;
        b=GbtYTdhmlczaiXT8AWDZXevpg3N2XU+SKTHT0sjciE1tpjTtTuH2VqD64tIDbmuRh+
         355d/WUmuagSWcd8OvlqizIDmb/b6WwjCJ4TroNlQVd+NAziMwJYk47WE3QUB8PvTHNM
         f2faKJ98dyHcKZX5/6pYa7p7+6m9ZKGVKYyb1gIfWQnYWIS0UFiQFUdhIhs1goVp0/hL
         OXJwT/aW8Wu5bHMX9OPZir3SZrguNjgwJeITbhFJ/X7RGUrJxeOGbD3bDgmHefav6b28
         JX8yWoIxTf8mt6svx16khLbTqJ9x5WtHaK5vQu5pS0VG88qb1jW42PZKzNBURGqUg62B
         cEwA==
X-Gm-Message-State: APjAAAV8mHd7q4LcAQrM46S+aZAH7AcID4yeM1v8WwgcOGmU2/4p2iBL
        ZAQFE120ksI6V2XbULINi7o=
X-Google-Smtp-Source: APXvYqyLaKbhc7BeMpPDAhC6zqtopsqrr8YevaVEmVAvqoCcgqnF5dodi7bMWW/sNU+bzLhXBQUdSw==
X-Received: by 2002:a37:b602:: with SMTP id g2mr5038285qkf.174.1581725389745;
        Fri, 14 Feb 2020 16:09:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k37sm4523990qtf.70.2020.02.14.16.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 16:09:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A38F721C05;
        Fri, 14 Feb 2020 19:09:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Feb 2020 19:09:48 -0500
X-ME-Sender: <xms:yjZHXuYecYXr0T4Oc1zIRDVs3Ygt4QtLfRAMmESzGOwHXKHK0hEWdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedugddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:yjZHXt3KJ6L-g-tXJMEr3rbbZsCl_mSAlR6cc1SK3nH3ajCvP0YpeQ>
    <xmx:yjZHXgt2li36ZsKGv-OZzIvEu27WHRc1v0FqPNghMKN84KLkYLpK7w>
    <xmx:yjZHXhh_hz9rEFyU-oV3hZOiZ0gC5LGswqdvlqO1yKv4rMEkmYzoRQ>
    <xmx:zDZHXvkyCFa20zdkhQrUt18gHTQLjyVN9hxpcb9P1k_QQVibq2GPo-yKwes>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id B27723280062;
        Fri, 14 Feb 2020 19:09:45 -0500 (EST)
Date:   Sat, 15 Feb 2020 08:09:44 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 3/3] tools/memory-model: Add litmus test for RMW +
 smp_mb__after_atomic()
Message-ID: <20200215000944.GC110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-4-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141049310.1579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002141049310.1579-100000@iolanthe.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 10:58:57AM -0500, Alan Stern wrote:
> On Fri, 14 Feb 2020, Boqun Feng wrote:
> 
> > We already use a litmus test in atomic_t.txt to describe atomic RMW +
> > smp_mb__after_atomic() is "strong acquire" (both the read and the write
> > part is ordered).
> 
> "strong acquire" is not an appropriate description -- there is no such
> thing as a strong acquire in the LKMM -- nor is it a good name for the
> litmus test.  A better description would be "stronger than acquire", as
> in the sentence preceding the litmus test in atomic_t.txt.
> 

Agreed, I will change it. 

And I can't help feeling this is another reason to add more litmus tests
into kernel directory. During the review process you found two places
where we can improve the text of the documents to be aligned to LKMM. I
think we all want to use a unversial language (LKMM) to discuss things
of parallel programming in kernel, and providing more litmus tests to
people so that they can handly use them will cerntainly be helpful on
this ;-)

> >  So make it a litmus test in memory-model litmus-tests
> > directory, so that people can access the litmus easily.
> > 
> > Additionally, change the processor numbers "P1, P2" to "P0, P1" in
> > atomic_t.txt for the consistency with the processor numbers in the
> > litmus test, which herd can handle.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  Documentation/atomic_t.txt                    |  6 ++--
> >  ...+mb__after_atomic-is-strong-acquire.litmus | 29 +++++++++++++++++++
> >  tools/memory-model/litmus-tests/README        |  5 ++++
> >  3 files changed, 37 insertions(+), 3 deletions(-)
> >  create mode 100644 tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> > 
> > diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> > index ceb85ada378e..e3ad4e4cd9ed 100644
> > --- a/Documentation/atomic_t.txt
> > +++ b/Documentation/atomic_t.txt
> > @@ -238,14 +238,14 @@ strictly stronger than ACQUIRE. As illustrated:
> >    {
> >    }
> >  
> > -  P1(int *x, atomic_t *y)
> > +  P0(int *x, atomic_t *y)
> >    {
> >      r0 = READ_ONCE(*x);
> >      smp_rmb();
> >      r1 = atomic_read(y);
> >    }
> >  
> > -  P2(int *x, atomic_t *y)
> > +  P1(int *x, atomic_t *y)
> >    {
> >      atomic_inc(y);
> >      smp_mb__after_atomic();
> > @@ -260,7 +260,7 @@ This should not happen; but a hypothetical atomic_inc_acquire() --
> >  because it would not order the W part of the RMW against the following
> >  WRITE_ONCE.  Thus:
> >  
> > -  P1			P2
> > +  P0			P1
> >  
> >  			t = LL.acq *y (0)
> >  			t++;
> > diff --git a/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> > new file mode 100644
> > index 000000000000..e7216cf9d92a
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> > @@ -0,0 +1,29 @@
> > +C Atomic-RMW+mb__after_atomic-is-strong-acquire
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * Test of an atomic RMW followed by a smp_mb__after_atomic() is
> 
> s/Test of/Test that/
> 
> > + * "strong-acquire": both the read and write part of the RMW is ordered before
> 
> This should say "stronger than a normal acquire".  And "part" should be
> "parts", and "is ordered" should be "are ordered".
> 

Thanks! I will improve in the next version.

> Also, please try to arrange the line breaks so that the comment lines
> don't have vastly different lengths.
> 
> Similar changes should be made for the text added to README.
> 

Got it.

Regards,
Boqun

> Alan Stern
> 
