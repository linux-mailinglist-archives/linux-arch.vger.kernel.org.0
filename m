Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AE2AA233
	for <lists+linux-arch@lfdr.de>; Sat,  7 Nov 2020 03:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgKGCcf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 21:32:35 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59771 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728111AbgKGCcf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 21:32:35 -0500
Received: (qmail 65132 invoked by uid 1000); 6 Nov 2020 21:32:14 -0500
Date:   Fri, 6 Nov 2020 21:32:14 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of
 LKMM terms
Message-ID: <20201107023214.GA64998@rowland.harvard.edu>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-5-paulmck@kernel.org>
 <20201106165930.GC47039@rowland.harvard.edu>
 <20201106180445.GX3249@paulmck-ThinkPad-P72>
 <20201106192351.GA53131@rowland.harvard.edu>
 <20201106195912.GA3249@paulmck-ThinkPad-P72>
 <20201106204008.GA55521@rowland.harvard.edu>
 <20201106210413.GB3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106210413.GB3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 01:04:13PM -0800, Paul E. McKenney wrote:
> On Fri, Nov 06, 2020 at 03:40:08PM -0500, Alan Stern wrote:
> > Is it really true that data dependencies are so easily destroyed?  I 
> > would expect that a true "semantic" dependency (i.e., one where the 
> > value written really does vary according to the value read) would be 
> > rather hard to second guess.
> 
> The usual optimizations apply, for but one example:
> 
> 	r1 = READ_ONCE(x);
> 	WRITE_ONCE(y, (r1 + 1) % MAX_ELEMENTS);
> 
> If MAX_ELEMENTS is 1, so long, data dependency!

Sure, but if MAX_ELEMENTS is 1 then the value written will always be 0 
no matter what value r1 has, so it isn't a semantic dependency.  
Presumably a semantic data dependency would be much more robust.

I wonder if it's worth pointing out this distinction to the reader.

> With pointers, the compiler has fewer optimization opportunities,
> but there are still cases where it can break the dependency.
> Or transform it to a control dependency.

Transforming a data dependency into a control dependency wouldn't make 
any important difference; the hardware would still provide the desired 
ordering.

Alan
