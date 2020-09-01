Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A712585D1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 04:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAC6z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 22:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgIAC6z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 22:58:55 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F339E2073A;
        Tue,  1 Sep 2020 02:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598929135;
        bh=Kl90djY9Z+jLZiVePHoF79IH1UsM/genhw7o/0XlZYA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RcTznFJ/0I8CL7E0JV7trzqKIt8bfB8EMhfUfqDqkR4Z5iYCCM8UvkaUTJPQH0l7l
         afmfoLVT6lw9aoLC6k0kK0dgRigXB1g39RoRHIzG9RRNJnjxwd2TWMsj3B5DGGHKPb
         vp/nop1I+TLTzhD0HkcjFAbChozoeW14DRXvENGg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C220335231E8; Mon, 31 Aug 2020 19:58:54 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:58:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 8/9] tools/memory-model: Document categories of
 ordering primitives
Message-ID: <20200901025854.GA29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-8-paulmck@kernel.org>
 <20200901012309.GA571008@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901012309.GA571008@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 31, 2020 at 09:23:09PM -0400, Alan Stern wrote:
> On Mon, Aug 31, 2020 at 11:20:36AM -0700, paulmck@kernel.org wrote:
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
> 
> This document could use some careful editing.  But one pair of errors
> stands out in particular:
> 
> > diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
> > new file mode 100644
> > index 0000000..4b2cc55
> > --- /dev/null
> > +++ b/tools/memory-model/Documentation/ordering.txt
> 
> > +2.	Ordered memory accesses.  These operations order themselves
> > +	against some or all of the CPUs prior or subsequent accesses,
> > +	depending on the category of operation.
> > +
> > +	a.	Release operations.  This category includes
> > +		smp_store_release(), atomic_set_release(),
> > +		rcu_assign_pointer(), and value-returning RMW operations
> > +		whose names end in _release.  These operations order
> > +		their own store against all of the CPU's subsequent
> ---------------------------------------------------------^^^^^^^^^^
> > +		memory accesses.
> > +
> > +	b.	Acquire operations.  This category includes
> > +		smp_load_acquire(), atomic_read_acquire(), and
> > +		value-returning RMW operations whose names end in
> > +		_acquire.  These operations order their own load against
> > +		all of the CPU's prior memory accesses.
> ---------------------------------^^^^^
> 
> Double-oops!

Hey, at least I am consistently wrong!  ;-)

Fixed, thank you!

							Thanx, Paul
