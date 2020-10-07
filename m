Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D5E286AF4
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 00:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgJGWiw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 18:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgJGWiw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Oct 2020 18:38:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2702083B;
        Wed,  7 Oct 2020 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602110331;
        bh=s+E4diQaUoles/wvU02TGDNEIMhFsUXsvArP98/GAJY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=encrKLzgTu9qv8pgWJTw5SYUYRj3dFE75oPzVPpNleQKgHvV3t5a8pfmC+plxH1wK
         0lLPDKG9OMcBpHnhYmuOm4WFbAN2xHZMtHDmMCjNwbggFOSmnoiJDMCQH0nof+CRt8
         wiuJdYO5vgj7HCwPk6z706LyuxoAlOB9yGs/VYgM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3F2123522FA4; Wed,  7 Oct 2020 15:38:51 -0700 (PDT)
Date:   Wed, 7 Oct 2020 15:38:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
Message-ID: <20201007223851.GV29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
 <20201005155310.GH376584@rowland.harvard.edu>
 <20201005165223.GB29330@paulmck-ThinkPad-P72>
 <20201005181949.GA387079@rowland.harvard.edu>
 <20201005191801.GF29330@paulmck-ThinkPad-P72>
 <20201005194834.GB389867@rowland.harvard.edu>
 <20201006163954.GM29330@paulmck-ThinkPad-P72>
 <20201006170525.GA423499@rowland.harvard.edu>
 <20201007175040.GQ29330@paulmck-ThinkPad-P72>
 <20201007194050.GC468921@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007194050.GC468921@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 07, 2020 at 03:40:50PM -0400, Alan Stern wrote:
> On Wed, Oct 07, 2020 at 10:50:40AM -0700, Paul E. McKenney wrote:
> > And here is the updated version.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit b7cd60d4b41ad56b32b36b978488f509c4f7e228
> > Author: Alan Stern <stern@rowland.harvard.edu>
> > Date:   Tue Oct 6 09:38:37 2020 -0700
> > 
> >     manual/kernel: Add LB+mb+data litmus test
> 
> Let's change this to:
> 
>       manual/kernel: Add LB data dependency test with no intermediate variable
> 
> Without that extra qualification, people reading just the title would
> wonder why we need a simple LB litmus test in the archive.
> 
> >     
> >     Test whether herd7 can detect a data dependency when there is no
> >     intermediate local variable, as in WRITE_ONCE(*x, READ_ONCE(*y)).
> >     Commit 0f3f8188a326 in herdtools fixed an oversight which caused such
> >     dependencies to be missed.
> >     
> >     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/manual/kernel/C-LB+mb+data.litmus b/manual/kernel/C-LB+mb+data.litmus
> > new file mode 100644
> > index 0000000..0cf9a7a
> > --- /dev/null
> > +++ b/manual/kernel/C-LB+mb+data.litmus
> > @@ -0,0 +1,27 @@
> > +C LB+mb+data
> > +(*
> > + * Result: Never
> > + *
> > + * Test whether herd7 can detect a data dependency when there is no
> > + * intermediate local variable, as in WRITE_ONCE(*x, READ_ONCE(*y)).
> > + * Commit 0f3f8188a326 in herdtools fixed an oversight which caused such
> > + * dependencies to be missed.
> 
> You changed this comment!  It should have remained the way it was:

I might get this right sooner or later.  You never know.

Like this?

							Thanx, Paul

------------------------------------------------------------------------

commit 5b6a4ff2c8ad25fc77f4151e71e6cbd8f3268d7b
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Tue Oct 6 09:38:37 2020 -0700

    manual/kernel: Add LB+mb+data litmus test
    
    Test whether herd7 can detect a data dependency when there is no
    intermediate local variable, as in WRITE_ONCE(*x, READ_ONCE(*y)).
    Commit 0f3f8188a326 in herdtools fixed an oversight which caused such
    dependencies to be missed.
    
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/manual/kernel/C-LB+mb+data.litmus b/manual/kernel/C-LB+mb+data.litmus
new file mode 100644
index 0000000..e9e24e0
--- /dev/null
+++ b/manual/kernel/C-LB+mb+data.litmus
@@ -0,0 +1,27 @@
+C LB+mb+data
+(*
+ * Result: Never
+ *
+ * Versions of herd7 prior to commit 0f3f8188a326 ("[herd] Fix dependency
+ * definition") recognize data dependencies only when they flow through
+ * an intermediate local variable.  Since the dependency in P1 doesn't,
+ * those versions get the wrong answer for this test.
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r1;
+
+	r1 = READ_ONCE(*x);
+	smp_mb();
+	WRITE_ONCE(*y, r1);
+}
+
+P1(int *x, int *y)
+{
+	WRITE_ONCE(*x, READ_ONCE(*y));
+}
+
+exists (0:r1=1)
