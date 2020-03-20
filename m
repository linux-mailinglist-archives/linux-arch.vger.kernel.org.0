Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9725218D25C
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 16:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCTPHL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 11:07:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49679 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726843AbgCTPHL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 11:07:11 -0400
Received: (qmail 29646 invoked by uid 500); 20 Mar 2020 11:07:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2020 11:07:10 -0400
Date:   Fri, 20 Mar 2020 11:07:10 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Andrea Parri <parri.andrea@gmail.com>
cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        <linux-arch@vger.kernel.org>, Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where
 updater frees object
In-Reply-To: <20200320102603.GA22784@andrea>
Message-ID: <Pine.LNX.4.44L0.2003201104220.27303-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 20 Mar 2020, Andrea Parri wrote:

> On Fri, Mar 20, 2020 at 02:55:50AM -0400, Joel Fernandes (Google) wrote:
> > This adds an example for the important RCU grace period guarantee, which
> > shows an RCU reader can never span a grace period.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  .../litmus-tests/RCU+sync+free.litmus         | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > 
> > diff --git a/tools/memory-model/litmus-tests/RCU+sync+free.litmus b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > new file mode 100644
> > index 0000000000000..c4682502dd296
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > @@ -0,0 +1,40 @@
> > +C RCU+sync+free
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * This litmus test demonstrates that an RCU reader can never see a write after
> > + * the grace period, if it saw writes that happen before the grace period. This
> > + * is a typical pattern of RCU usage, where the write before the grace period
> > + * assigns a pointer, and the writes after destroy the object that the pointer
> > + * points to.
> > + *
> > + * This guarantee also implies, an RCU reader can never span a grace period and
> > + * is an important RCU grace period memory ordering guarantee.
> > + *)
> > +
> > +{
> > +x = 1;
> > +y = x;
> > +z = 1;
> 
> FYI, this could become a little more readable if we wrote it as follows:
> 
> int x = 1;
> int *y = &x;
> int z = 1;

Also, the test won't work with klitmus7 unless you do this.

> The LKMM tools are happy either way, just a matter of style/preference;
> and yes, MP+onceassign+derefonce isn't currently following mine...  ;-/
> 
> 
> > +}
> > +
> > +P0(int *x, int *z, int **y)
> > +{
> > +	int r0;
> 
> This would need to be "int *r0;" in order to make klitmus7(+gcc) happy.
> 
> 
> > +	int r1;
> > +
> > +	rcu_read_lock();
> > +	r0 = rcu_dereference(*y);
> > +	r1 = READ_ONCE(*r0);
> > +	rcu_read_unlock();
> > +}
> > +
> > +P1(int *x, int *z, int **y)
> > +{
> > +	rcu_assign_pointer(*y, z);
> 
> AFAICT, you don't need this "RELEASE"; e.g., compare this test with the
> example in:
> 
>   https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Grace-Period%20Guarantee
> 
> What am I missing?

If z were not a simple variable but a more complicated structure, the
RELEASE would be necessary to ensure that all P1's prior changes to z
became visible before the write to y.

Besides, it's good form always to match rcu_dereference() with 
rcu_assign_pointer(), for code documentation if nothing else.

Alan

