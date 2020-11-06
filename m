Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44BC2A9A1C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 18:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgKFQ7v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 11:59:51 -0500
Received: from netrider.rowland.org ([192.131.102.5]:51841 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726408AbgKFQ7v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 11:59:51 -0500
Received: (qmail 47392 invoked by uid 1000); 6 Nov 2020 11:59:30 -0500
Date:   Fri, 6 Nov 2020 11:59:30 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of
 LKMM terms
Message-ID: <20201106165930.GC47039@rowland.harvard.edu>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-5-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105220017.15410-5-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 05, 2020 at 02:00:14PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/memory-model/Documentation/glossary.txt | 155 ++++++++++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 tools/memory-model/Documentation/glossary.txt
> 
> diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
> new file mode 100644
> index 0000000..036fa28
> --- /dev/null
> +++ b/tools/memory-model/Documentation/glossary.txt
> @@ -0,0 +1,155 @@
> +This document contains brief definitions of LKMM-related terms.  Like most
> +glossaries, it is not intended to be read front to back (except perhaps
> +as a way of confirming a diagnosis of OCD), but rather to be searched
> +for specific terms.
> +
> +
> +Address Dependency:  When the address of a later memory access is computed
> +	based on the value returned by an earlier load, an "address
> +	dependency" extends from that load extending to the later access.
> +	Address dependencies are quite common in RCU read-side critical
> +	sections:
> +
> +	 1 rcu_read_lock();
> +	 2 p = rcu_dereference(gp);
> +	 3 do_something(p->a);
> +	 4 rcu_read_unlock();
> +
> +	 In this case, because the address of "p->a" on line 3 is computed
> +	 from the value returned by the rcu_dereference() on line 2, the
> +	 address dependency extends from that rcu_dereference() to that
> +	 "p->a".  In rare cases, optimizing compilers can destroy address
> +	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
> +	 for more information.
> +
> +	 See also "Control Dependency".

There should also be an entry for "Data Dependency", linked from here
and from Control Dependency.

> +Marked Access:  An access to a variable that uses an special function or
> +	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".

How about "r1 = READ_ONCE(x)"?

Alan
