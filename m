Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B632A9D9C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 20:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgKFTLt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 14:11:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgKFTLt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 14:11:49 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6BE20882;
        Fri,  6 Nov 2020 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604689908;
        bh=e9go00OPM1UzmcwI9P1HigeeZ+n07Z6Qs6e/rNp0WL4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ql+d1620nolPyv30ofEW4z95xWVHKap8Ay9fFXMHQ/G/GCznnJUbAExvq2JYVhZ8+
         OUJmy80KnbcOBsR4kxKimQ4HJEwXPVMGtA3Zpq35PVFyKgXH/7zbHPzsDgWLjJFxe4
         qlAa8ueRVGaYIL5XzcqBXLOX56KIQnjLwGEm8YRk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AECDF352097B; Fri,  6 Nov 2020 11:11:47 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:11:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 3/8] tools/memory-model: Document categories
 of ordering primitives
Message-ID: <20201106191147.GY3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-3-paulmck@kernel.org>
 <20201106165654.GB47039@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106165654.GB47039@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 11:56:54AM -0500, Alan Stern wrote:
> On Thu, Nov 05, 2020 at 02:00:12PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The Linux kernel has a number of categories of ordering primitives, which
> > are recorded in the LKMM implementation and hinted at by cheatsheet.txt.
> > But there is no overview of these categories, and such an overview
> > is needed in order to understand multithreaded LKMM litmus tests.
> > This commit therefore adds an ordering.txt as well as extracting a
> > control-dependencies.txt from memory-barriers.txt.  It also updates the
> > README file.
> > 
> > [ paulmck:  Apply Akira Yokosawa file-placement feedback. ]
> > [ paulmck:  Apply Alan Stern feedback. ]
> > [ paulmck:  Apply self-review feedback. ]
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> > diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
> > index 2d9539f..a50ea81 100644
> > --- a/tools/memory-model/Documentation/README
> > +++ b/tools/memory-model/Documentation/README
> 
> > @@ -41,13 +50,21 @@ README
> >  cheatsheet.txt
> >  	Quick-reference guide to the Linux-kernel memory model.
> >  
> > +control-dependencies.txt
> > +	Guide to preventing compiler optimizations from destroying
> > +	your control dependencies.
> > +
> >  explanation.txt
> > -	Detailed description of the memory model.
> > +	Detailed description of the memory model in detail.
> 
> A redundantly redundant change.

I will revert the reversion of the removal of the added detail "in
detail".  ;-)

Good catch, thank you!

						Thanx, Paul
