Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6161C32F276
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCES0y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 13:26:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhCES0u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 13:26:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F40D6509F;
        Fri,  5 Mar 2021 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614968810;
        bh=A3PkStTTXlj6BCOB8jvhdJl283IF9fvcmU9TsaiUi/M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FXiFp8+DmQ579azbC1TyUDKF2IPvDY+JLH7j/FxbaaRv+T7076SKqZ4axcADR/oYD
         sK9rY0PTNI3yQwgJ0Itj8tpZS2TlaHTgDPF7wcPPZHS7PqTLeuYDp8Z7cTTjwVPbhD
         XEHBX0d4LAE4qse0K64mlfwDk7R4ZbjR+Z8SxK44FeFGQh9I3oyxZiXKD6ELMGq4zz
         IbboEWQ7sG272SK6poJBkoMa02jX13psyyd7r22u+FVJG6/kjkzxz1Qy6kQQgZIxsB
         UD4+7L1e2Jgv/hzyWOlKvXuVFZw6KaHWPPgg0XQSTK3NK/dOoBO0F8WBnDSSB5zRzB
         r67v6VuOi9U0w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1434E3523946; Fri,  5 Mar 2021 10:26:50 -0800 (PST)
Date:   Fri, 5 Mar 2021 10:26:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] tools/memory-model: Fix smp_mb__after_spinlock() spelling
Message-ID: <20210305182650.GA2713@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210305102823.415900-1-bjorn.topel@gmail.com>
 <20210305153655.GC38200@rowland.harvard.edu>
 <e90fee12-a29e-cddb-5db3-24d92d4e03f8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e90fee12-a29e-cddb-5db3-24d92d4e03f8@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 04:41:49PM +0100, Björn Töpel wrote:
> On 2021-03-05 16:36, Alan Stern wrote:
> > On Fri, Mar 05, 2021 at 11:28:23AM +0100, Björn Töpel wrote:
> > > From: Björn Töpel <bjorn.topel@intel.com>
> > > 
> > > A misspelled invokation of git-grep, revealed that
> > -------------------^
> > 
> > Smetimes my brain is a little slow...  Do you confirm that this is a
> > joke?
> > 
> 
> I wish, Alan. I wish.
> 
> Looks like I can only spel function names correctly.

Heh!  I missed that one completely.  Please see below for a wortschmied
commit.

							Thanx, Paul

------------------------------------------------------------------------

commit 1c737ce34715db9431f6b034f92dbf09d954126d
Author: Björn Töpel <bjorn.topel@intel.com>
Date:   Fri Mar 5 11:28:23 2021 +0100

    tools/memory-model: Fix smp_mb__after_spinlock() spelling
    
    A misspelled git-grep regex revealed that smp_mb__after_spinlock()
    was misspelled in explanation.txt.
    
    This commit adds the missing "_" to smp_mb__after_spinlock().
    
    Fixes: 1c27b644c0fd ("Automate memory-barriers.txt; provide Linux-kernel memory model")
    [ paulmck: Apply Alan Stern commit-log feedback. ]
    Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index f9d610d..5d72f31 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -2510,7 +2510,7 @@ they behave as follows:
 	smp_mb__after_atomic() orders po-earlier atomic updates and
 	the events preceding them against all po-later events;
 
-	smp_mb_after_spinlock() orders po-earlier lock acquisition
+	smp_mb__after_spinlock() orders po-earlier lock acquisition
 	events and the events preceding them against all po-later
 	events.
 
