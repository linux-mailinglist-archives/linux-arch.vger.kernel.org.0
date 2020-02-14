Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5B015DAE9
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 16:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgBNP1q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 10:27:46 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:39726 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387401AbgBNP1q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 10:27:46 -0500
Received: (qmail 2571 invoked by uid 2102); 14 Feb 2020 10:27:44 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Feb 2020 10:27:44 -0500
Date:   Fri, 14 Feb 2020 10:27:44 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Boqun Feng <boqun.feng@gmail.com>
cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-arch@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
In-Reply-To: <20200214040132.91934-1-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2002141024141.1579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 Feb 2020, Boqun Feng wrote:

> A recent discussion raises up the requirement for having test cases for
> atomic APIs:
> 
> 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> 
> , and since we already have a way to generate a test module from a
> litmus test with klitmus[1]. It makes sense that we add more litmus
> tests for atomic APIs into memory-model.

It might be worth discussing this point a little more fully.  The 
set of tests in tools/memory-model/litmus-tests/ is deliberately rather 
limited.  Paul has a vastly more expansive set of litmus tests in a 
GitHub repository, and I am doubtful about how many new tests we want 
to keep in the kernel source.

Perhaps it makes sense to have tests corresponding to all the examples
in Documentation/, perhaps not.  How do people feel about this?

Alan

