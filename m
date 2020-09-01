Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2F258519
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 03:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgIABXK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 21:23:10 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56653 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725987AbgIABXK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 21:23:10 -0400
Received: (qmail 571107 invoked by uid 1000); 31 Aug 2020 21:23:09 -0400
Date:   Mon, 31 Aug 2020 21:23:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 8/9] tools/memory-model: Document categories of
 ordering primitives
Message-ID: <20200901012309.GA571008@rowland.harvard.edu>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-8-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831182037.2034-8-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 31, 2020 at 11:20:36AM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The Linux kernel has a number of categories of ordering primitives, which
> are recorded in the LKMM implementation and hinted at by cheatsheet.txt.
> But there is no overview of these categories, and such an overview
> is needed in order to understand multithreaded LKMM litmus tests.
> This commit therefore adds an ordering.txt as well as extracting a
> control-dependencies.txt from memory-barriers.txt.  It also updates the
> README file.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

This document could use some careful editing.  But one pair of errors
stands out in particular:

> diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
> new file mode 100644
> index 0000000..4b2cc55
> --- /dev/null
> +++ b/tools/memory-model/Documentation/ordering.txt

> +2.	Ordered memory accesses.  These operations order themselves
> +	against some or all of the CPUs prior or subsequent accesses,
> +	depending on the category of operation.
> +
> +	a.	Release operations.  This category includes
> +		smp_store_release(), atomic_set_release(),
> +		rcu_assign_pointer(), and value-returning RMW operations
> +		whose names end in _release.  These operations order
> +		their own store against all of the CPU's subsequent
---------------------------------------------------------^^^^^^^^^^
> +		memory accesses.
> +
> +	b.	Acquire operations.  This category includes
> +		smp_load_acquire(), atomic_read_acquire(), and
> +		value-returning RMW operations whose names end in
> +		_acquire.  These operations order their own load against
> +		all of the CPU's prior memory accesses.
---------------------------------^^^^^

Double-oops!

Alan
