Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0D28EC94
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 07:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgJOFP2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 01:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgJOFP2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Oct 2020 01:15:28 -0400
Received: from coco.lan (ip5f5ad5a1.dynamic.kabel-deutschland.de [95.90.213.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7ECA22247;
        Thu, 15 Oct 2020 05:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602738926;
        bh=UUsWGH9b1ZdDvymt42wNCT8MtrgbJyIDyU8ZdeDpNs4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vq9497tz27EaiI/qe14dYkrz2GUski7j2T81gN5OLP96nudYno11z/03rVeoGvY6I
         HVdtsOzcku/thytSAjLnGCa5lfCj8WJ+sdtyfNjXRELBFPvNFG+tLGrEpcNKXrz+fl
         iikd3fMF6hdB6Ak7/l8mPbhZSeDocCQR355pbru8=
Date:   Thu, 15 Oct 2020 07:15:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/24] tools: docs: memory-model: fix references for
 some files
Message-ID: <20201015071518.5d9f8dc1@coco.lan>
In-Reply-To: <20201014185720.GA28761@paulmck-ThinkPad-P72>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
        <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
        <20201013163354.GO3249@paulmck-ThinkPad-P72>
        <20201013163836.GC670875@rowland.harvard.edu>
        <20201014015840.GR3249@paulmck-ThinkPad-P72>
        <20201014185720.GA28761@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

Em Wed, 14 Oct 2020 11:57:20 -0700
"Paul E. McKenney" <paulmck@kernel.org> escreveu:

> On Tue, Oct 13, 2020 at 06:58:40PM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 13, 2020 at 12:38:36PM -0400, Alan Stern wrote:  
> > > On Tue, Oct 13, 2020 at 09:33:54AM -0700, Paul E. McKenney wrote:  
> > > > On Tue, Oct 13, 2020 at 02:14:29PM +0200, Mauro Carvalho Chehab wrote:  
> > > > > - The sysfs.txt file was converted to ReST and renamed;
> > > > > - The control-dependencies.txt is not at
> > > > >   Documentation/control-dependencies.txt. As it is at the
> > > > >   same dir as the README file, which mentions it, just
> > > > >   remove Documentation/.
> > > > > 
> > > > > With that, ./scripts/documentation-file-ref-check script
> > > > > is now happy again for files under tools/.
> > > > > 
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > > > 
> > > > Queued for review and testing, likely target v5.11.  
> > > 
> > > Instead of changing the path in the README reference, shouldn't 
> > > tools/memory-model/control-dependencies.txt be moved to its proper 
> > > position in .../Documentation?  
> > 
> > You are of course quite right.  My thought is to let Mauro go ahead,
> > given his short deadline. 

I guess there might be some misunderstanding here. My fault. The plan
is to have zero doc warnings for 5.10[1].

In order to get there, The patches for it were split on two series,
both for 5.10:

- The /80 series with patches that already applies on the top of master;
- This /24 patch series, which depends on trees that weren't merged
  upstream yet (back on Oct, 13). Those applies on the top of
  next-20201013.

I'm intending to submit later today (after next-20201015) a PR with 
patches from the /80 series.

The remaining ones should be sent as a late pull request by the end 
of the merge window, if the patch that caused the issue gets merged
for 5.10. That's the case of this patch.


[1] With Sphinx < 3. Sphinx 3 and above brings some additional
    warnings that depends on a fix at the toolset. The fixup patches
    for Sphinx were proposed yesterday by the Sphinx maintainer
    of the C domain parser. More details can be seen here:

	https://github.com/sphinx-doc/sphinx/pull/8313


> >  We can then make this "git mv" change once
> > v5.10-rc1 comes out, given that it should have Mauro's patches.  I have
> > added a reminder to my calendar.  
> 
> Except that I cannot find a commit where control-dependencies.txt is
> in tools/memory-model.  And this file is not yet in mainline, but
> only in -rcu and -next.  In both places, it is here:
> 
> 	tools/memory-model/Documentation/control-dependencies.txt
> 
> Mauro, to what commit in what tree are you applying this patch?

This is against next-20201013. The specific commit adding
README and control-dependencies.txt is this one:

commit d34a972f67252457158122e5ba7a0ce5ece62067
Author:     Paul E. McKenney <paulmck@kernel.org>
AuthorDate: Tue Aug 11 11:27:33 2020 -0700
Commit:     Paul E. McKenney <paulmck@kernel.org>
CommitDate: Sun Oct 4 17:21:31 2020 -0700

    tools/memory-model: Document categories of ordering primitives
    
    The Linux kernel has a number of categories of ordering primitives, which
    are recorded in the LKMM implementation and hinted at by cheatsheet.txt.
    But there is no overview of these categories, and such an overview
    is needed in order to understand multithreaded LKMM litmus tests.
    This commit therefore adds an ordering.txt as well as extracting a
    control-dependencies.txt from memory-barriers.txt.  It also updates the
    README file.
    
    [ paulmck: Apply Akira Yokosawa file-placement feedback. ]
    [ paulmck:  Apply Alan Stern feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Btw, after re-checking the patch, I would drop this hunk:

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 16177aaa9752..004969992bac 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -55,7 +55,7 @@ README
 Documentation/cheatsheet.txt
 	Quick-reference guide to the Linux-kernel memory model.
 
-Documentation/control-dependencies.txt
+control-dependencies.txt
 	A guide to preventing compiler optimizations from destroying
 	your control dependencies.

The ./scripts/documentation-file-ref-check doesn't complain about
broken references for Documentation/ files outside the main
docs dir. So, this hunk is not really needed to fix warnings with
5.10. Besides that, there are other references to those files:

	$ git grep Documentation tools/memory-model/Documentation/README
	tools/memory-model/Documentation/README:tools/memory-model/Documentation directory.  It has been said that at
	tools/memory-model/Documentation/README:Documentation/cheatsheet.txt
	tools/memory-model/Documentation/README:Documentation/control-dependencies.txt
	tools/memory-model/Documentation/README:Documentation/explanation.txt
	tools/memory-model/Documentation/README:Documentation/litmus-tests.txt
	tools/memory-model/Documentation/README:Documentation/ordering.txt
	tools/memory-model/Documentation/README:Documentation/recipes.txt
	tools/memory-model/Documentation/README:Documentation/references.txt
	tools/memory-model/Documentation/README:Documentation/simple.txt

That also refer to the files inside tools/memory-model/Documentation/.
So, they should ether all be replaced to just the file name without
the directory (IMHO, that makes more sense) or kept as-is.

In any case, for 5.10, all we need is to fix this reference:

	Documentation/RCU/rcu_dereference.txt -> Documentation/RCU/rcu_dereference.rst

Also, the patch description is wrong. I suspect that, when this patch
was originally written, there were more hunks being touched, but
fixes for everything else were already merged. So, the only thing that
is left is the above change.

It follows a new version. feel free to either pick (or merge) this one at 
the same tree as tools/memory-model/Documentation/ordering.txt if you
think that this works best for you.

Otherwise, I'll keep this on my -next tree together with this series,
aiming to submit by the end of the merge window, if ordering.txt gets
merged for 5.10.

Thanks,
Mauro

[PATCH v2.1 02/24] tools/memory-model: fix a broken doc reference

Documentation/RCU/rcu_dereference.txt -> Documentation/RCU/rcu_dereference.rst

Fixes: d34a972f6725 ("tools/memory-model: Document categories of ordering primitives")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
index 3d020bed8585..629b19ae64a6 100644
--- a/tools/memory-model/Documentation/ordering.txt
+++ b/tools/memory-model/Documentation/ordering.txt
@@ -346,7 +346,7 @@ o	Accessing RCU-protected pointers via rcu_dereference()
 
 	If there is any significant processing of the pointer value
 	between the rcu_dereference() that returned it and a later
-	dereference(), please read Documentation/RCU/rcu_dereference.txt.
+	dereference(), please read Documentation/RCU/rcu_dereference.rst.
 
 It can also be quite helpful to review uses in the Linux kernel.
 



