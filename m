Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC4258451
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 01:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgHaXMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 19:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgHaXMl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 19:12:41 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CD82064B;
        Mon, 31 Aug 2020 23:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598915560;
        bh=OYx4gWy0INzeUxyzwos2MBa9BzopDIOMq38s9ZL0LxE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pmj09cjbzIDHktRbdLtunZYruAU7xs8CUARjslGhZo0wPCacthFKZtoc2Ip8GAAXI
         DAOr9tTrFgwlg0sz+fdqz5WGw1x8KKOPj+3cqQ+7AO+ZzFLu7ucbNaq17OnVUtfzM1
         fhpWjrmCnqtd6P5l/d2Jnx3KblMFrBFFAOhrbWPU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6F7ED35230F1; Mon, 31 Aug 2020 16:12:40 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:12:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Subject: Re: [PATCH kcsan 8/9] tools/memory-model: Document categories of
 ordering primitives
Message-ID: <20200831231240.GG2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-8-paulmck@kernel.org>
 <48f1fcd2-de89-b21e-f5a6-96c8e8861706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f1fcd2-de89-b21e-f5a6-96c8e8861706@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 01, 2020 at 07:34:20AM +0900, Akira Yokosawa wrote:
> On Mon, 31 Aug 2020 11:20:36 -0700, paulmck@kernel.org wrote:
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
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  tools/memory-model/Documentation/README       |  24 +-
> >  tools/memory-model/Documentation/ordering.txt | 462 ++++++++++++++++++++++++++
> >  tools/memory-model/control-dependencies.txt   | 256 ++++++++++++++
> >  3 files changed, 740 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/memory-model/Documentation/ordering.txt
> >  create mode 100644 tools/memory-model/control-dependencies.txt
> 
> Hi Paul,
> 
> Didn't you mean to put control-dependencies.txt under tools/memory-model/Documentation/ ?

Indeed I did, good catch, thank you!

							Thanx, Paul

>         Thanks, Akira
> 
> > 
> > diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
> > index 4326603..16177aa 100644
> > --- a/tools/memory-model/Documentation/README
> > +++ b/tools/memory-model/Documentation/README
> > @@ -8,10 +8,19 @@ number of places.
> >  
> >  This document therefore describes a number of places to start reading
> >  the documentation in this directory, depending on what you know and what
> > -you would like to learn:
> > +you would like to learn.  These are cumulative, that is, understanding
> > +of the documents earlier in this list is required by the documents later
> > +in this list.
> >  
> >  o	You are new to Linux-kernel concurrency: simple.txt
> >  
> > +o	You have some background in Linux-kernel concurrency, and would
> > +	like an overview of the types of low-level concurrency primitives
> > +	that are provided:  ordering.txt
> > +
> > +	Here, "low level" means atomic operations to single locations in
> > +	memory.
> > +
> >  o	You are familiar with the concurrency facilities that you
> >  	need, and just want to get started with LKMM litmus tests:
> >  	litmus-tests.txt
> > @@ -20,6 +29,9 @@ o	You are familiar with Linux-kernel concurrency, and would
> >  	like a detailed intuitive understanding of LKMM, including
> >  	situations involving more than two threads: recipes.txt
> >  
> > +o	You would like a detailed understanding of what your compiler can
> > +	and cannot do to control dependencies: control-dependencies.txt
> > +
> >  o	You are familiar with Linux-kernel concurrency and the
> >  	use of LKMM, and would like a cheat sheet to remind you
> >  	of LKMM's guarantees: cheatsheet.txt
> > @@ -37,12 +49,16 @@ o	You are interested in the publications related to LKMM, including
> >  DESCRIPTION OF FILES
> >  ====================
> >  
> > -Documentation/README
> > +README
> >  	This file.
> >  
> >  Documentation/cheatsheet.txt
> >  	Quick-reference guide to the Linux-kernel memory model.
> >  
> > +Documentation/control-dependencies.txt
> > +	A guide to preventing compiler optimizations from destroying
> > +	your control dependencies.
> > +
> >  Documentation/explanation.txt
> >  	Describes the memory model in detail.
> [...]
