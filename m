Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060F116C18E
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 14:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgBYNBG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 08:01:06 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:11270
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729179AbgBYNBG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Feb 2020 08:01:06 -0500
From:   Luc Maranget <luc.maranget@inria.fr>
X-IronPort-AV: E=Sophos;i="5.70,484,1574118000"; 
   d="scan'208";a="340371138"
Received: from yquem.paris.inria.fr (HELO yquem.inria.fr) ([128.93.101.33])
  by mail3-relais-sop.national.inria.fr with ESMTP; 25 Feb 2020 14:01:02 +0100
Received: by yquem.inria.fr (Postfix, from userid 18041)
        id 65A98E1AAB; Tue, 25 Feb 2020 14:01:02 +0100 (CET)
Date:   Tue, 25 Feb 2020 14:01:02 +0100
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Luc Maranget <luc.maranget@inria.fr>,
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
Message-ID: <20200225130102.wsz3bpyhjmcru7os@yquem.inria.fr>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-3-boqun.feng@gmail.com>
 <20200214081213.GA17708@andrea>
 <20200214104003.GC20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200225073451.GP69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200225073451.GP69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

As far as I can remember I have implemented atomic_add_unless in herd7.

As to your test, I have first run a slightly modified version of your test
as a kernel module (using klitmus7).

C atomic_add_unless-dependency
{
        atomic_t y = ATOMIC_INIT(1);
}
  P0(int *x, atomic_t *y, int *z)
{
        int r0;
        r0 = READ_ONCE(*x);
        if (atomic_add_unless((atomic_t *)y, 2, r0))
                WRITE_ONCE(*z, 42);
        else
                WRITE_ONCE(*z, 1);
}
  P1(int *x, int *z)
{
        int r0;
        r0 = smp_load_acquire(z);
        WRITE_ONCE(*x, 1);
}
locations [y]
exists
(1:r0 = 1 /\ 0:r0 = 1)


The test is also accepted by herd7, here producing teh same final values
as actual run on a raspberry PI4B.

--Luc

> Luc,
> 
> Could you have a look at the problem Andrea and I discuss here? It seems
> that you have done a few things in herd for atomic_add_unless() in
> particular, and based on the experiments of Andrea and me, seems
> atomic_add_unless() works correctly. So can you confirm that herd now
> can handle atomic_add_unless() or there is still something missing?
> 
> Thanks!
> 
> Regards,
> Boqun
> 
> On Fri, Feb 14, 2020 at 06:40:03PM +0800, Boqun Feng wrote:
> > On Fri, Feb 14, 2020 at 09:12:13AM +0100, Andrea Parri wrote:
> > > > @@ -0,0 +1,24 @@
> > > > +C Atomic-set-observable-to-RMW
> > > > +
> > > > +(*
> > > > + * Result: Never
> > > > + *
> > > > + * Test of the result of atomic_set() must be observable to atomic RMWs.
> > > > + *)
> > > > +
> > > > +{
> > > > +	atomic_t v = ATOMIC_INIT(1);
> > > > +}
> > > > +
> > > > +P0(atomic_t *v)
> > > > +{
> > > > +	(void)atomic_add_unless(v,1,0);
> > > 
> > > We blacklisted this primitive some time ago, cf. section "LIMITATIONS",
> > > entry (6b) in tools/memory-model/README; the discussion was here:
> > > 
> > >   https://lkml.kernel.org/r/20180829211053.20531-3-paulmck@linux.vnet.ibm.com
> > > 
> > 
> > And in an email replying to that email, you just tried and seemed
> > atomic_add_unless() works ;-)
> > 
> > > but unfortunately I can't remember other details at the moment: maybe
> > > it is just a matter of or the proper time to update that section.
> > > 
> > 
> > I spend a few time looking into the changes in herd, the dependency
> > problem seems to be as follow:
> > 
> > For atomic_add_unless(ptr, a, u), the return value (true or false)
> > depends on both *ptr and u, this is different than other atomic RMW,
> > whose return value only depends on *ptr. Considering the following
> > litmus test:
> > 
> > 	C atomic_add_unless-dependency
> > 
> > 	{
> > 		int y = 1;
> > 	}
> > 
> > 	P0(int *x, int *y, int *z)
> > 	{
> > 		int r0;
> > 		int r1;
> > 		int r2;
> > 
> > 		r0 = READ_ONCE(*x);
> > 		if (atomic_add_unless(y, 2, r0))
> > 			WRITE_ONCE(*z, 42);
> > 		else
> > 			WRITE_ONCE(*z, 1);
> > 	}
> > 
> > 	P1(int *x, int *y, int *z)
> > 	{
> > 		int r0;
> > 
> > 		r0 = smp_load_acquire(z);
> > 
> > 		WRITE_ONCE(*x, 1);
> > 	}
> > 
> > 	exists
> > 	(1:r0 = 1 /\ 0:r0 = 1)
> > 
> > , the exist-clause will never trigger, however if we replace
> > "atomic_add_unless(y, 2, r0)" with "atomic_add_unless(y, 2, 1)", the
> > write on *z and the read from *x on CPU 0 are not ordered, so we could
> > observe the exist-clause triggered.
> > 
> > I just tried with the latest herd, and herd can work out this
> > dependency. So I think we are good now and can change the limitation
> > section in the document. But I will wait for Luc's input for this. Luc,
> > did I get this correct? Is there any other limitation on
> > atomic_add_unless() now?
> > 
> > Regards,
> > Boqun
> > 
> > > Thanks,
> > >   Andrea
