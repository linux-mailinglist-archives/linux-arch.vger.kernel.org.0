Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3202D15FF72
	for <lists+linux-arch@lfdr.de>; Sat, 15 Feb 2020 18:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBORNb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Feb 2020 12:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgBORNb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 Feb 2020 12:13:31 -0500
Received: from paulmck-ThinkPad-P72.home (smb-adpcdg2-04.hotspot.hub-one.net [213.174.99.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF00D24676;
        Sat, 15 Feb 2020 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581786811;
        bh=5l8Vi8hleqqzVtD4lt7Lj3hIV69+fYnulxZp4qYnC7Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OD6SuASqhLkiSk3WfOyp1pmpybaGcqpvStW+3m4XqP2l9Lb3Xu7kZVMTXPOL8162t
         MKy04wUvMR2KxNoCJtdGNkCGGMQsY5xZQ3+DqZnb9X38qnicVnNwv3rsXlrH3M2eo7
         69MW/dngshLWwqZ3/ULZG9SY1qsKhIa0e3SvNja8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E84FE35219C1; Sat, 15 Feb 2020 07:25:50 -0800 (PST)
Date:   Sat, 15 Feb 2020 07:25:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Message-ID: <20200215152550.GA13636@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141024141.1579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002141024141.1579-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 10:27:44AM -0500, Alan Stern wrote:
> On Fri, 14 Feb 2020, Boqun Feng wrote:
> 
> > A recent discussion raises up the requirement for having test cases for
> > atomic APIs:
> > 
> > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > 
> > , and since we already have a way to generate a test module from a
> > litmus test with klitmus[1]. It makes sense that we add more litmus
> > tests for atomic APIs into memory-model.
> 
> It might be worth discussing this point a little more fully.  The 
> set of tests in tools/memory-model/litmus-tests/ is deliberately rather 
> limited.  Paul has a vastly more expansive set of litmus tests in a 
> GitHub repository, and I am doubtful about how many new tests we want 
> to keep in the kernel source.

Indeed, the current view is that the litmus tests in the kernel source
tree are intended to provide examples of C-litmus-test-language features
and functions, as opposed to exercising the full cross-product of
Linux-kernel synchronization primitives.

For a semi-reasonable subset of that cross-product, as Alan says, please
see https://github.com/paulmckrcu/litmus.

For a list of the Linux-kernel synchronization primitives currently
supported by LKMM, please see tools/memory-model/linux-kernel.def.

> Perhaps it makes sense to have tests corresponding to all the examples
> in Documentation/, perhaps not.  How do people feel about this?

Agreed, we don't want to say that the set of litmus tests in the kernel
source tree is limited for all time to the set currently present, but
rather that the justification for adding more would involve useful and
educational examples of litmus-test features and techniques rather than
being a full-up LKMM test suite.

I would guess that there are litmus-test tricks that could usefully
be added to tools/memory-model/litmus-tests.  Any nomination?  Perhaps
handling CAS loops while maintaining finite state space?  Something else?

							Thanx, Paul
