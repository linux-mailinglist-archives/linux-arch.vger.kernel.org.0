Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E216F5D2
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 03:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgBZCvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 21:51:41 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37212 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbgBZCvk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 21:51:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id m9so1305800qke.4;
        Tue, 25 Feb 2020 18:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H1WBwrieSTLF8fO+JG2Kpf/pCvdrGgRWSvttc2WBbmE=;
        b=Mg37B9ELw1vesbtMhlWR3KRq+n1dCP9/OZoY+o4FuFJorS74dl7gWIXTF5y+NJbUsn
         +Ihu1g44Ho0FYDRBWICYOB6z2Yu2qm9bP4QVhmiEU5rJS085c+2wgbad5VNL8zc7PU9g
         TxwOmboK0U2zyVOcGOl5NxdG8CzKUz300Z5gX63LjRlatKp+KfhjiWAIO4XlCsFwQX5E
         aE+fhxukiqSlrlE92iDn6qnIbbpHdZ2nQy9lfmNTHGpw15eKEKPPkd5FNcz2o0tXVAP0
         gjshRvXEJk0265aACfrpFO4BKya/gL9XpC0RtX+pSie33Tiic5Chn54b7iOqBYsJ4T/o
         3t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H1WBwrieSTLF8fO+JG2Kpf/pCvdrGgRWSvttc2WBbmE=;
        b=AXMBWR2HFRhjOmrzLUdblKJs+9WtDkHsFxcZOQGaHjF8fO2ZT/k+BoeLUEKTYMnn+h
         hoaxV1EpwW0DHuB2prZR0bbnkK4j3x4oeMo48B9ii1WXbhF1CTRGAkA0cMGwotX/4Hyh
         keZc34otJi0QyAjeyBf3xNVzLltnYbYPCW4+5iyKHLuvb3ZQY2nroR8nSi8/e/XDy6h/
         aEx+mlU8iSIAAZ0gdS3+1ILi2nH8Q3TtBUvRrX5N9fw75WoaxpNbbYoofQYlQP+KLADb
         qKrJ0jZhf9Rl4NAJGkVcOefv521s/ptrnmyDcSgwglVgO0+/O9rkfbFBuzM8BzI/7hKx
         188Q==
X-Gm-Message-State: APjAAAV4A5uCbKved0aTzgb69OknQ9kgbBGJMi+jCE73T+KUvb4Xk0HI
        3aN2MDAZos4IwQoZQbnZ0oY=
X-Google-Smtp-Source: APXvYqxbwsGTkpsaHww1mi0v33NQAZAHjxabWxGUzrQ1g2UbPFzgK+LgKGS4OncK/tQpL2tSZOCGDQ==
X-Received: by 2002:a05:620a:709:: with SMTP id 9mr2706660qkc.331.1582685499213;
        Tue, 25 Feb 2020 18:51:39 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n1sm338544qkk.52.2020.02.25.18.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 18:51:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 30FB421EAD;
        Tue, 25 Feb 2020 21:51:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 25 Feb 2020 21:51:37 -0500
X-ME-Sender: <xms:N91VXs-BAqmp6qON14lmLw8q3I0AKR9VHG3h0i9v2BbAT9pt930L4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleefgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:N91VXsOWfBtORDvq3rpALRu-KOMBKOIim_h150vliXdJzqcoos-wBw>
    <xmx:N91VXoF550LzlQmv0v4TiJta3ez4o9BgYETuWhM96iWYgpRzu1JtDA>
    <xmx:N91VXqirVaTg6ZpXdj68K_j0Rzo372xHwC3jHZfdRhpyqDWy_kxwDQ>
    <xmx:Od1VXmOREi97f4aoaJcsHaXB-OASD_mnvgmKsIB2OP6zejpmEmw-uMUxxUs>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7EFC93280060;
        Tue, 25 Feb 2020 21:51:35 -0500 (EST)
Date:   Wed, 26 Feb 2020 10:51:34 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Luc Maranget <luc.maranget@inria.fr>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Message-ID: <20200226025134.GQ69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-3-boqun.feng@gmail.com>
 <20200214081213.GA17708@andrea>
 <20200214104003.GC20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200225073451.GP69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200225130102.wsz3bpyhjmcru7os@yquem.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225130102.wsz3bpyhjmcru7os@yquem.inria.fr>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 25, 2020 at 02:01:02PM +0100, Luc Maranget wrote:
> Hi,
> 
> As far as I can remember I have implemented atomic_add_unless in herd7.
> 
> As to your test, I have first run a slightly modified version of your test
> as a kernel module (using klitmus7).
> 
> C atomic_add_unless-dependency
> {
>         atomic_t y = ATOMIC_INIT(1);
> }
>   P0(int *x, atomic_t *y, int *z)
> {
>         int r0;
>         r0 = READ_ONCE(*x);
>         if (atomic_add_unless((atomic_t *)y, 2, r0))
>                 WRITE_ONCE(*z, 42);
>         else
>                 WRITE_ONCE(*z, 1);
> }
>   P1(int *x, int *z)
> {
>         int r0;
>         r0 = smp_load_acquire(z);
>         WRITE_ONCE(*x, 1);
> }
> locations [y]
> exists
> (1:r0 = 1 /\ 0:r0 = 1)
> 
> 
> The test is also accepted by herd7, here producing teh same final values
> as actual run on a raspberry PI4B.
> 

Thanks, so I'm planning to make the following change to README file in
memory-model

I will add a separate patch in my v3 patchset of atomic-tests.

Regards,
Boqun

----->8
diff --git a/tools/memory-model/README b/tools/memory-model/README
index fc07b52f2028..d974a96ad273 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -207,11 +207,15 @@ The Linux-kernel memory model (LKMM) has the following limitations:
 		case as a store release.
 
 	b.	The "unless" RMW operations are not currently modeled:
-		atomic_long_add_unless(), atomic_add_unless(),
-		atomic_inc_unless_negative(), and
-		atomic_dec_unless_positive().  These can be emulated
+		atomic_long_add_unless(), atomic_inc_unless_negative(),
+		and atomic_dec_unless_positive().  These can be emulated
 		in litmus tests, for example, by using atomic_cmpxchg().
 
+		One exception of this limitation is atomic_add_unless(),
+		which is provide directly by herd7 (so no corresponding
+		definition in linux-kernel.def). atomic_add_unless() is
+		modeled by herd7 therefore it can be used in litmus tests.
+
 	c.	The call_rcu() function is not modeled.  It can be
 		emulated in litmus tests by adding another process that
 		invokes synchronize_rcu() and the body of the callback

> --Luc
> 
> > Luc,
> > 
> > Could you have a look at the problem Andrea and I discuss here? It seems
> > that you have done a few things in herd for atomic_add_unless() in
> > particular, and based on the experiments of Andrea and me, seems
> > atomic_add_unless() works correctly. So can you confirm that herd now
> > can handle atomic_add_unless() or there is still something missing?
> > 
> > Thanks!
> > 
> > Regards,
> > Boqun
> > 
> > On Fri, Feb 14, 2020 at 06:40:03PM +0800, Boqun Feng wrote:
> > > On Fri, Feb 14, 2020 at 09:12:13AM +0100, Andrea Parri wrote:
> > > > > @@ -0,0 +1,24 @@
> > > > > +C Atomic-set-observable-to-RMW
> > > > > +
> > > > > +(*
> > > > > + * Result: Never
> > > > > + *
> > > > > + * Test of the result of atomic_set() must be observable to atomic RMWs.
> > > > > + *)
> > > > > +
> > > > > +{
> > > > > +	atomic_t v = ATOMIC_INIT(1);
> > > > > +}
> > > > > +
> > > > > +P0(atomic_t *v)
> > > > > +{
> > > > > +	(void)atomic_add_unless(v,1,0);
> > > > 
> > > > We blacklisted this primitive some time ago, cf. section "LIMITATIONS",
> > > > entry (6b) in tools/memory-model/README; the discussion was here:
> > > > 
> > > >   https://lkml.kernel.org/r/20180829211053.20531-3-paulmck@linux.vnet.ibm.com
> > > > 
> > > 
> > > And in an email replying to that email, you just tried and seemed
> > > atomic_add_unless() works ;-)
> > > 
> > > > but unfortunately I can't remember other details at the moment: maybe
> > > > it is just a matter of or the proper time to update that section.
> > > > 
> > > 
> > > I spend a few time looking into the changes in herd, the dependency
> > > problem seems to be as follow:
> > > 
> > > For atomic_add_unless(ptr, a, u), the return value (true or false)
> > > depends on both *ptr and u, this is different than other atomic RMW,
> > > whose return value only depends on *ptr. Considering the following
> > > litmus test:
> > > 
> > > 	C atomic_add_unless-dependency
> > > 
> > > 	{
> > > 		int y = 1;
> > > 	}
> > > 
> > > 	P0(int *x, int *y, int *z)
> > > 	{
> > > 		int r0;
> > > 		int r1;
> > > 		int r2;
> > > 
> > > 		r0 = READ_ONCE(*x);
> > > 		if (atomic_add_unless(y, 2, r0))
> > > 			WRITE_ONCE(*z, 42);
> > > 		else
> > > 			WRITE_ONCE(*z, 1);
> > > 	}
> > > 
> > > 	P1(int *x, int *y, int *z)
> > > 	{
> > > 		int r0;
> > > 
> > > 		r0 = smp_load_acquire(z);
> > > 
> > > 		WRITE_ONCE(*x, 1);
> > > 	}
> > > 
> > > 	exists
> > > 	(1:r0 = 1 /\ 0:r0 = 1)
> > > 
> > > , the exist-clause will never trigger, however if we replace
> > > "atomic_add_unless(y, 2, r0)" with "atomic_add_unless(y, 2, 1)", the
> > > write on *z and the read from *x on CPU 0 are not ordered, so we could
> > > observe the exist-clause triggered.
> > > 
> > > I just tried with the latest herd, and herd can work out this
> > > dependency. So I think we are good now and can change the limitation
> > > section in the document. But I will wait for Luc's input for this. Luc,
> > > did I get this correct? Is there any other limitation on
> > > atomic_add_unless() now?
> > > 
> > > Regards,
> > > Boqun
> > > 
> > > > Thanks,
> > > >   Andrea
