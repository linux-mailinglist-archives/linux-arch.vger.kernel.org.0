Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2315FB13
	for <lists+linux-arch@lfdr.de>; Sat, 15 Feb 2020 00:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBNXw1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 18:52:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44139 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgBNXw1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 18:52:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id k7so8139171qth.11;
        Fri, 14 Feb 2020 15:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q1VFlGpNJsAugpu1KvzTN0fxzKwDkCIDswD9pZg8AZw=;
        b=lnaPM1Ux7tMqY7Inxp1gY8SCVAynAufvY1Hi8Y6GQ4RGy5gFWjw57QwwxBok/gbR1F
         O9SDtPaytcJmOabGw23EiZCD4DcE6H5kTRx3JnGFlohLLtsEoAa4LxmKZ8N6fUTaH+zv
         Ko54oPJOOFpamXNIKus06PywT60wkFP0guepQjVP85Y+/kE4ljhU1VripiRPgEYAOtKe
         DGtwr09TDhMdcMRTjcBqGjwr6OO2FJl+gyVvqVoKScxO/MPsTRAG6ZM9gUvN5xtlv+zx
         V1Yenr5y2V4b01mLsQhchPEc8nBj8O9K4t+0T3GjFooSOOh7cvVwgAg+wdSw+Zh5mTnr
         qXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q1VFlGpNJsAugpu1KvzTN0fxzKwDkCIDswD9pZg8AZw=;
        b=QTuQ/FutNTXUw2b+8eSaazkt0NsrR2kjsd11ie3ThJ25cVtRy3Yu+Czqb+53REf83j
         cYiZ9tMRmTwVvUmoFo/xIDzNAyW/tGtR94amZVc2jcimv3MBba0u6HT7nVmCGBxZkNLd
         zPD3z4Q0+KB5GVigL2GzKepUbaDYE+XhMorWj3ef6MSq8Fvcbrg39r75u3xbGGVRUoRP
         t/BYkNSxvns0r1RDPm9qou56zXu2gB45iB/dzo4Mxg+gdPHkHZzWfUEGipqpyUBmF24x
         W4Q4yXzL3ACjKDCQRiZpmREjGDlSxPy/eQ+4gkUyzH8B22bcCbyZ+6SRT1dES2/HzcmB
         Ehfw==
X-Gm-Message-State: APjAAAWCOrocm5iOEtsuo2030TZpQTD9KbxpEGTcFfuDIJJSYJn4Yn/I
        sWGzJtTWamoN6kXmF6CuZL0=
X-Google-Smtp-Source: APXvYqxxmMJgCvrIu/iQqqthI+VePZ+HxvSYy2WAVset21yj2vg41EnXl5otXp6ogCWHLN8KwNu/2Q==
X-Received: by 2002:ac8:5502:: with SMTP id j2mr4753304qtq.127.1581724345607;
        Fri, 14 Feb 2020 15:52:25 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u4sm4264894qkh.59.2020.02.14.15.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 15:52:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7C566216CA;
        Fri, 14 Feb 2020 18:52:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 14 Feb 2020 18:52:24 -0500
X-ME-Sender: <xms:sTJHXqHm_YhHPfxxbBxVnorClNluEQ_0CZiQPJV7yv3vdwnCV2CzZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedugddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:sTJHXmdBL_AF0iH3ooRZ4feHCdDmQTZla8D4yZu_deEHHAYIpcEL5w>
    <xmx:sTJHXqgJg-gn0VqXop_EUImB8yAbyV85il6QOmzKYi2hnRh8v6g5Tg>
    <xmx:sTJHXvD86pPozdk0IL-DVtZBrPQmSq-NXw8O5zIWqUaazWAMnI8y5A>
    <xmx:uDJHXnfRahX5eMwHYwkX8LJzGKjVOQnQcbr1njGraF0tKM7blE6GhXzlSmU>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7B7A93060BD1;
        Fri, 14 Feb 2020 18:52:17 -0500 (EST)
Date:   Sat, 15 Feb 2020 07:52:15 +0800
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
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Message-ID: <20200214235215.GB110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-3-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141028280.1579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002141028280.1579-100000@iolanthe.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 10:47:48AM -0500, Alan Stern wrote:
> On Fri, 14 Feb 2020, Boqun Feng wrote:
> 
> > We already use a litmus test in atomic_t.txt to describe the behavior of
> > an atomic_set() with the an atomic RMW, so add it into the litmus-tests
> > directory to make it easily accessible for anyone who cares about the
> > semantics of our atomic APIs.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  .../Atomic-set-observable-to-RMW.litmus       | 24 +++++++++++++++++++
> >  tools/memory-model/litmus-tests/README        |  3 +++
> >  2 files changed, 27 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
> 
> I don't like that name, or the corresponding sentence in atomic_t.txt:
> 
> 	A subtle detail of atomic_set{}() is that it should be
> 	observable to the RMW ops.
> 
> "Observable" doesn't get the point across -- the point being that the
> atomic RMW ops have to be _atomic_ with respect to all atomic store
> operations, including atomic_set.
> 
> Suggestion: Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus, with 
> corresponding changes to the comment in the litmus test and the entry 
> in README.
> 

I agree, and thanks for the suggestion! And I change the sentence in
atomic_t.txt with:

	A note for the implementation of atomic_set{}() is that it
	cannot break the atomicity of the RMW ops.

, since I think that part of the doc is more about the suggestion to
anyone who want to implement the atomic_set(). Peter, is that OK to you?

Regards,
Boqun

> Alan
> 
> > diff --git a/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
> > new file mode 100644
> > index 000000000000..4326f56f2c1a
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
> > @@ -0,0 +1,24 @@
> > +C Atomic-set-observable-to-RMW
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * Test of the result of atomic_set() must be observable to atomic RMWs.
> > + *)
> > +
> > +{
> > +	atomic_t v = ATOMIC_INIT(1);
> > +}
> > +
> > +P0(atomic_t *v)
> > +{
> > +	(void)atomic_add_unless(v,1,0);
> > +}
> > +
> > +P1(atomic_t *v)
> > +{
> > +	atomic_set(v, 0);
> > +}
> > +
> > +exists
> > +(v=2)
> > diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> > index 681f9067fa9e..81eeacebd160 100644
> > --- a/tools/memory-model/litmus-tests/README
> > +++ b/tools/memory-model/litmus-tests/README
> > @@ -2,6 +2,9 @@
> >  LITMUS TESTS
> >  ============
> >  
> > +Atomic-set-observable-to-RMW.litmus
> > +	Test of the result of atomic_set() must be observable to atomic RMWs.
> > +
> >  CoRR+poonceonce+Once.litmus
> >  	Test of read-read coherence, that is, whether or not two
> >  	successive reads from the same variable are ordered.
> > 
> 
