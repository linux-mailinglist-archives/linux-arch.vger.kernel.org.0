Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4148D43E8DB
	for <lists+linux-arch@lfdr.de>; Thu, 28 Oct 2021 21:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJ1TN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Oct 2021 15:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhJ1TN5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Oct 2021 15:13:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7BA8610CA;
        Thu, 28 Oct 2021 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635448289;
        bh=PBuQUDyQPItfI5/5GVVGaXD+Rn5Sly4yCrQif0PrqlU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HuMoPLFuILwiid1xm1mrLz2zD6xlvto5BTk17vS/eL8DEAE6RXXWpMpPLwK7cuan7
         nTKGEsWdYloKHMADLnBw4uzqrW7zSz+VZV732wep1gy6xEitRJPK+aFmayaddwjTkg
         oJxd+bLniRISMaaHM/bPRFUDRduIYZBzUD2/fgq/KE07hyOGnNT4+B5RcH52N+13oP
         PV7UGvq8eLWYuEAkA4lLzgYpWGYnjrTUVRri6uzdK6A6ByODKo6HVGxA88PjSqvcwU
         6llKeBBaxTZgaXs8yWPA87Xnre6e3qQZgMDiaNCIVx5uS4FypTwWXJ5PArGmz2z3QF
         FNNcL3WgV5wjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 288E05C04B3; Thu, 28 Oct 2021 12:11:29 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:11:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC v2 3/3] tools/memory-model: litmus: Add two tests for
 unlock(A)+lock(B) ordering
Message-ID: <20211028191129.GJ880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211025145416.698183-1-boqun.feng@gmail.com>
 <20211025145416.698183-4-boqun.feng@gmail.com>
 <YXenrNeS+IaSDwvU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXenrNeS+IaSDwvU@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 26, 2021 at 09:01:00AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 25, 2021 at 10:54:16PM +0800, Boqun Feng wrote:
> > diff --git a/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> > new file mode 100644
> > index 000000000000..955b9c7cdc7f
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> > @@ -0,0 +1,33 @@
> > +C LB+unlocklockonceonce+poacquireonce
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * If two locked critical sections execute on the same CPU, all accesses
> > + * in the first must execute before any accesses in the second, even if
> > + * the critical sections are protected by different locks.
> 
> One small nit; the above "all accesses" reads as if:
> 
> 	spin_lock(s);
> 	WRITE_ONCE(*x, 1);
> 	spin_unlock(s);
> 	spin_lock(t);
> 	r1 = READ_ONCE(*y);
> 	spin_unlock(t);
> 
> would also work, except of course that's the one reorder allowed by TSO.

I applied this series with Peter's Acked-by, and with the above comment
reading as follows:

+(*
+ * Result: Never
+ *
+ * If two locked critical sections execute on the same CPU, all accesses
+ * in the first must execute before any accesses in the second, even if the
+ * critical sections are protected by different locks.  The one exception
+ * to this rule is that (consistent with TSO) a prior write can be reordered
+ * with a later read from the viewpoint of a process not holding both locks.
+ *)

Thank you all!

							Thanx, Paul
