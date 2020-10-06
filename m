Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC1285004
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 18:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJFQjz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 12:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFQjz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Oct 2020 12:39:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15289206D4;
        Tue,  6 Oct 2020 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602002395;
        bh=qs6G6DRG9Lu5raspre8LCFciDiPCKYMfx6/YZHUKyE8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Qa3XB31xbFCSaPJ4w+vo1Xnk9VTGvJM8xwjvU8vob3iU9xzSFCuy6XwtCim4WCbnW
         kv1RjfF53aW5gGGmrOcac6Id5dUjG1aQDu18UlClWjmf7VlCMVYyPLlM/GLWmtqnwP
         mvVcWWxrarB+/7NzC+jdHO9WZHAdfp8nqX91VGOg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C153A3520A8C; Tue,  6 Oct 2020 09:39:54 -0700 (PDT)
Date:   Tue, 6 Oct 2020 09:39:54 -0700
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
Message-ID: <20201006163954.GM29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
 <20201005155310.GH376584@rowland.harvard.edu>
 <20201005165223.GB29330@paulmck-ThinkPad-P72>
 <20201005181949.GA387079@rowland.harvard.edu>
 <20201005191801.GF29330@paulmck-ThinkPad-P72>
 <20201005194834.GB389867@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005194834.GB389867@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 03:48:34PM -0400, Alan Stern wrote:
> On Mon, Oct 05, 2020 at 12:18:01PM -0700, Paul E. McKenney wrote:
> > Aside from naming and comment, how about my adding the following?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > C crypto-control-data-1
> 
> Let's call it something more along the lines of 
> dependencies-in-nested-expressions.  Maybe you can think of something a 
> little more succinct, but that's the general idea of the test.
> 
> > (*
> >  * LB plus crypto-mb-data plus data.
> 
> The actual pattern is LB+mb+data.
> 
> >  *
> >  * Result: Never
> >  *
> >  * This is an example of OOTA and we would like it to be forbidden.
> >  * If you want herd7 to get the right answer, you must use herdtools
> >  * 0f3f8188a326 (" [herd] Fix dependency definition") or later.
> 
> Versions of herd7 prior to commit 0f3f8188a326 ("[herd] Fix dependency 
> definition") recognize data dependencies only when they flow through an 
> intermediate local variable.  Since the dependency in P1 doesn't, those
> versions get the wrong answer for this test.
> 
> >  *)
> > 
> > {}
> > 
> > P0(int *x, int *y)
> > {
> > 	int r1;
> > 
> > 	r1 = READ_ONCE(*x);
> > 	smp_mb();
> > 	WRITE_ONCE(*y, r1);
> > }
> > 
> > P1(int *x, int *y)
> > {
> > 	int r2;
> 
> No need for r2.

Thank you for looking this over!

Like this, then?

							Thanx, Paul

------------------------------------------------------------------------

commit 51898676302d8ebc93856209f7c587f1ac0fdd11
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Tue Oct 6 09:38:37 2020 -0700

    manual/kernel: Add LB+mb+data litmus test
    
    Versions of herd7 prior to commit 0f3f8188a326 ("[herd] Fix dependency
    definition") recognize data dependencies only when they flow through an
    intermediate local variable.  Since the dependency in P1 doesn't, those
    versions get the wrong answer for this test.
    
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/manual/kernel/C-LB+mb+data.litmus b/manual/kernel/C-LB+mb+data.litmus
new file mode 100644
index 0000000..673eec9
--- /dev/null
+++ b/manual/kernel/C-LB+mb+data.litmus
@@ -0,0 +1,29 @@
+C LB+mb+data.litmus
+(*
+ * LB plus crypto-mb-data plus data.
+ *
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
