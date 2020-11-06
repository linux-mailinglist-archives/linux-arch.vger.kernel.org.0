Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885C32A9DF2
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 20:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgKFTYM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 14:24:12 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33549 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727069AbgKFTYM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 14:24:12 -0500
Received: (qmail 53248 invoked by uid 1000); 6 Nov 2020 14:23:51 -0500
Date:   Fri, 6 Nov 2020 14:23:51 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of
 LKMM terms
Message-ID: <20201106192351.GA53131@rowland.harvard.edu>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-5-paulmck@kernel.org>
 <20201106165930.GC47039@rowland.harvard.edu>
 <20201106180445.GX3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106180445.GX3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 10:04:46AM -0800, Paul E. McKenney wrote:
> On Fri, Nov 06, 2020 at 11:59:30AM -0500, Alan Stern wrote:
> > > +	 See also "Control Dependency".
> > 
> > There should also be an entry for "Data Dependency", linked from here
> > and from Control Dependency.
> > 
> > > +Marked Access:  An access to a variable that uses an special function or
> > > +	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".
> > 
> > How about "r1 = READ_ONCE(x)"?
> 
> Good catches!  I am planning to squash the commit below into the
> original.  Does that cover it?

No, because you didn't add a glossary entry for "Data Dependency" and 
there's no link from "Control Dependency" to "Data Dependency".

Alan

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 27c694f5a049d3edac1f258b888d02650cec936a
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Nov 6 10:02:41 2020 -0800
> 
>     squash! tools/memory-model: Add a glossary of LKMM terms
>     
>     [ paulmck: Apply Alan Stern feedback. ]
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
> index 383151b..471bf13 100644
> --- a/tools/memory-model/Documentation/glossary.txt
> +++ b/tools/memory-model/Documentation/glossary.txt
> @@ -22,7 +22,7 @@ Address Dependency:  When the address of a later memory access is computed
>  	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
>  	 for more information.
>  
> -	 See also "Control Dependency".
> +	 See also "Control Dependency" and "Data Dependency".
>  
>  Acquire:  With respect to a lock, acquiring that lock, for example,
>  	using spin_lock().  With respect to a non-lock shared variable,
> @@ -109,7 +109,7 @@ Happens-Before (hb): A relation between two accesses in which LKMM
>  	section of explanation.txt.
>  
>  Marked Access:  An access to a variable that uses an special function or
> -	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".
> +	macro such as "r1 = READ_ONCE(x)" or "smp_store_release(&a, 1)".
>  
>  	See also "Unmarked Access".
>  
