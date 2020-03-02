Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2D1761A9
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 18:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCBR5A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 12:57:00 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34134 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727261AbgCBR5A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 12:57:00 -0500
Received: (qmail 4289 invoked by uid 2102); 2 Mar 2020 12:56:59 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Mar 2020 12:56:59 -0500
Date:   Mon, 2 Mar 2020 12:56:59 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Marco Elver <elver@google.com>
cc:     linux-kernel@vger.kernel.org, <kasan-dev@googlegroups.com>,
        <parri.andrea@gmail.com>, <will@kernel.org>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <paulmck@kernel.org>, <akiyks@gmail.com>,
        <dlustig@nvidia.com>, <joel@joelfernandes.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3] tools/memory-model/Documentation: Fix "conflict"
 definition
In-Reply-To: <20200302172101.157917-1-elver@google.com>
Message-ID: <Pine.LNX.4.44L0.2003021256130.1555-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2 Mar 2020, Marco Elver wrote:

> The definition of "conflict" should not include the type of access nor
> whether the accesses are concurrent or not, which this patch addresses.
> The definition of "data race" remains unchanged.
> 
> The definition of "conflict" as we know it and is cited by various
> papers on memory consistency models appeared in [1]: "Two accesses to
> the same variable conflict if at least one is a write; two operations
> conflict if they execute conflicting accesses."
> 
> The LKMM as well as the C11 memory model are adaptations of
> data-race-free, which are based on the work in [2]. Necessarily, we need
> both conflicting data operations (plain) and synchronization operations
> (marked). For example, C11's definition is based on [3], which defines a
> "data race" as: "Two memory operations conflict if they access the same
> memory location, and at least one of them is a store, atomic store, or
> atomic read-modify-write operation. In a sequentially consistent
> execution, two memory operations from different threads form a type 1
> data race if they conflict, at least one of them is a data operation,
> and they are adjacent in <T (i.e., they may be executed concurrently)."
> 
> [1] D. Shasha, M. Snir, "Efficient and Correct Execution of Parallel
>     Programs that Share Memory", 1988.
> 	URL: http://snir.cs.illinois.edu/listed/J21.pdf
> 
> [2] S. Adve, "Designing Memory Consistency Models for Shared-Memory
>     Multiprocessors", 1993.
> 	URL: http://sadve.cs.illinois.edu/Publications/thesis.pdf
> 
> [3] H.-J. Boehm, S. Adve, "Foundations of the C++ Concurrency Memory
>     Model", 2008.
> 	URL: https://www.hpl.hp.com/techreports/2008/HPL-2008-56.pdf
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> v3:
> * Apply Alan's suggestion.
> * s/two race candidates/race candidates/

Looks good!

Alan

