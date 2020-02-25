Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A181B16BABD
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 08:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgBYHe7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 02:34:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41917 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgBYHe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 02:34:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so8417500qtr.8;
        Mon, 24 Feb 2020 23:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2BaVUFSv/to+L4aW8kB/7KAen05ZTlbgy3P8SSzYyyg=;
        b=FZJEEX8lRPAawuOMkBShF4iPQyGKh1OhCpM41mbm1RM+6Im0p5s413VaTMkhsXDuLn
         FGOyjdv4/Y8XioBGmeRFV+SRiwSfz1+U6SpmjeRYhfyXBeM0MPbgv/Yacbiklvn7iiu3
         3/NYPR6qkj67TguKnT7EOIF3Va0ySN14Y7kM3h8bpnTz/IQJjd9MiChu3M7ifeWr8wSZ
         uM0Par3HzzzUxhuqKWdFmz0/x+M4vTJc8CHcJoheIHyBJtvvLDCKeJmxbSlSDRxdL+MU
         Zg/Cf1fELu/miLUUNE9VNKoMzW8DBe+Y84Uoo/iftwaslyResSljjFCt7qH4A42honES
         +KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2BaVUFSv/to+L4aW8kB/7KAen05ZTlbgy3P8SSzYyyg=;
        b=ni9SOkDCrB7eCmt+UrZ/p2xCZIyhJLksjoTzayKjeZvRZYK3hrRDVsesNsgiLVmyWx
         zzGLEJ4pxf62Qwsh075rv6mAtLrBTKyzrZtShWcNiTGpeooIEaYA1Wd6an4s4+gYXxn0
         XRFEhxJaYtkHLY5aIzcg750cbywRuA/emSAZfeOtJemGHA90BxZtbhUoQRDBq0ckd7JT
         mmYa//RX2beo4kd2OzW673T5MUlHxJvgJGRenaELq+FE4aIrXLSA5kusXTeVfp8swayj
         41lrdL9nRvBg/zI5nRHqXa08iAEzIKkAsUe8U5lixi3o0tISwFIkMdKiDtj8/KQDWcLJ
         nfhg==
X-Gm-Message-State: APjAAAXeyeF3lQD5UjmFDk7Q5XWmLjvBwU5BHptBUAl5KIgUvfKTwEbm
        hdQDfWc3MkZ5rI6Engdl7mg=
X-Google-Smtp-Source: APXvYqywTZDhAdh3NYPytHrJJk2ltG5NxK2z+z8bIKzbiNbHj8UZk1/j4E+V0ojLvcqS4T4WgBkNUA==
X-Received: by 2002:aed:2862:: with SMTP id r89mr3014031qtd.289.1582616097470;
        Mon, 24 Feb 2020 23:34:57 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s19sm5768916qkj.88.2020.02.24.23.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 23:34:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5118122007;
        Tue, 25 Feb 2020 02:34:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 25 Feb 2020 02:34:55 -0500
X-ME-Sender: <xms:Hc5UXhVwiLZjPi8Zy32BVQ5q_GcJs79WH_xonRpschzx-W6miszgLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledugdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduuddurdejudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Hc5UXl2MS3dmEFw2qDCmK8Rd6wZTuSgOQ8mjdMmLYAi2jXTbRmm9tA>
    <xmx:Hc5UXoY-rXgllqAh7VdF29FiJ3LSrje7eqcUVF_OyjAuYGuy03XVbg>
    <xmx:Hc5UXooMd-4XpZf3_zfPoGZOwc6q_SzHpcx6Wd6NKXtpsOBf-7retQ>
    <xmx:H85UXm8uGqLq75NQwRRsuhNFCzY3jq_Pb5Ilrik4aJBw6R8Zkj1x-CHC6NY>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id A2B75328005D;
        Tue, 25 Feb 2020 02:34:52 -0500 (EST)
Date:   Tue, 25 Feb 2020 15:34:51 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        Luc Maranget <luc.maranget@inria.fr>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20200225073451.GP69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-3-boqun.feng@gmail.com>
 <20200214081213.GA17708@andrea>
 <20200214104003.GC20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214104003.GC20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Luc,

Could you have a look at the problem Andrea and I discuss here? It seems
that you have done a few things in herd for atomic_add_unless() in
particular, and based on the experiments of Andrea and me, seems
atomic_add_unless() works correctly. So can you confirm that herd now
can handle atomic_add_unless() or there is still something missing?

Thanks!

Regards,
Boqun

On Fri, Feb 14, 2020 at 06:40:03PM +0800, Boqun Feng wrote:
> On Fri, Feb 14, 2020 at 09:12:13AM +0100, Andrea Parri wrote:
> > > @@ -0,0 +1,24 @@
> > > +C Atomic-set-observable-to-RMW
> > > +
> > > +(*
> > > + * Result: Never
> > > + *
> > > + * Test of the result of atomic_set() must be observable to atomic RMWs.
> > > + *)
> > > +
> > > +{
> > > +	atomic_t v = ATOMIC_INIT(1);
> > > +}
> > > +
> > > +P0(atomic_t *v)
> > > +{
> > > +	(void)atomic_add_unless(v,1,0);
> > 
> > We blacklisted this primitive some time ago, cf. section "LIMITATIONS",
> > entry (6b) in tools/memory-model/README; the discussion was here:
> > 
> >   https://lkml.kernel.org/r/20180829211053.20531-3-paulmck@linux.vnet.ibm.com
> > 
> 
> And in an email replying to that email, you just tried and seemed
> atomic_add_unless() works ;-)
> 
> > but unfortunately I can't remember other details at the moment: maybe
> > it is just a matter of or the proper time to update that section.
> > 
> 
> I spend a few time looking into the changes in herd, the dependency
> problem seems to be as follow:
> 
> For atomic_add_unless(ptr, a, u), the return value (true or false)
> depends on both *ptr and u, this is different than other atomic RMW,
> whose return value only depends on *ptr. Considering the following
> litmus test:
> 
> 	C atomic_add_unless-dependency
> 
> 	{
> 		int y = 1;
> 	}
> 
> 	P0(int *x, int *y, int *z)
> 	{
> 		int r0;
> 		int r1;
> 		int r2;
> 
> 		r0 = READ_ONCE(*x);
> 		if (atomic_add_unless(y, 2, r0))
> 			WRITE_ONCE(*z, 42);
> 		else
> 			WRITE_ONCE(*z, 1);
> 	}
> 
> 	P1(int *x, int *y, int *z)
> 	{
> 		int r0;
> 
> 		r0 = smp_load_acquire(z);
> 
> 		WRITE_ONCE(*x, 1);
> 	}
> 
> 	exists
> 	(1:r0 = 1 /\ 0:r0 = 1)
> 
> , the exist-clause will never trigger, however if we replace
> "atomic_add_unless(y, 2, r0)" with "atomic_add_unless(y, 2, 1)", the
> write on *z and the read from *x on CPU 0 are not ordered, so we could
> observe the exist-clause triggered.
> 
> I just tried with the latest herd, and herd can work out this
> dependency. So I think we are good now and can change the limitation
> section in the document. But I will wait for Luc's input for this. Luc,
> did I get this correct? Is there any other limitation on
> atomic_add_unless() now?
> 
> Regards,
> Boqun
> 
> > Thanks,
> >   Andrea
