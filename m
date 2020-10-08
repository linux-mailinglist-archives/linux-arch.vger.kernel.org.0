Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4FE286CEE
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 04:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgJHCu0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 22:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgJHCu0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Oct 2020 22:50:26 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7205B20B1F;
        Thu,  8 Oct 2020 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602125425;
        bh=Ahw4XLG+COp/KABA/mlzHjKniQAn5iQQc/XMo8kcOX8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ttD6FM2U6VGQHB9QCE/BLTv3zJOnTF3kqkH8ha3/pMMawZbzd7xC7Gb8qNmbJ9Z8v
         X6EY31gCjbdLK6+Q/TjGkO0lmgFT96TYNePIcb5rie66mgvUTMr275pbgGHbXxekAv
         YN44yCjiBcg6RtmF2duTLZSaEvIeSA42dnVNcCc0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A2183523039; Wed,  7 Oct 2020 19:50:25 -0700 (PDT)
Date:   Wed, 7 Oct 2020 19:50:25 -0700
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
Message-ID: <20201008025025.GX29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201005165223.GB29330@paulmck-ThinkPad-P72>
 <20201005181949.GA387079@rowland.harvard.edu>
 <20201005191801.GF29330@paulmck-ThinkPad-P72>
 <20201005194834.GB389867@rowland.harvard.edu>
 <20201006163954.GM29330@paulmck-ThinkPad-P72>
 <20201006170525.GA423499@rowland.harvard.edu>
 <20201007175040.GQ29330@paulmck-ThinkPad-P72>
 <20201007194050.GC468921@rowland.harvard.edu>
 <20201007223851.GV29330@paulmck-ThinkPad-P72>
 <20201008022537.GA480405@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008022537.GA480405@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 07, 2020 at 10:25:37PM -0400, Alan Stern wrote:
> On Wed, Oct 07, 2020 at 03:38:51PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 07, 2020 at 03:40:50PM -0400, Alan Stern wrote:
> > > On Wed, Oct 07, 2020 at 10:50:40AM -0700, Paul E. McKenney wrote:
> > > > And here is the updated version.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit b7cd60d4b41ad56b32b36b978488f509c4f7e228
> > > > Author: Alan Stern <stern@rowland.harvard.edu>
> > > > Date:   Tue Oct 6 09:38:37 2020 -0700
> > > > 
> > > >     manual/kernel: Add LB+mb+data litmus test
> > > 
> > > Let's change this to:
> > > 
> > >       manual/kernel: Add LB data dependency test with no intermediate variable
> > > 
> > > Without that extra qualification, people reading just the title would
> > > wonder why we need a simple LB litmus test in the archive.
> 
> > I might get this right sooner or later.  You never know.
> > 
> > Like this?
> > 
> > 							Thanx, Paul
> 
> Paul, I think you must need new reading glasses.  You completely missed 
> the text above.

There are some distractions at the moment.

Please see below.  If this is not exactly correct, I will use "git rm"
and let you submit the patch as you wish.

						Thanx, Paul

------------------------------------------------------------------------

commit dc0119c24b64f9d541b94ba5d17eec0cbc265bfa
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Tue Oct 6 09:38:37 2020 -0700

    manual/kernel: Add LB data dependency test with no intermediate variable
    
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
