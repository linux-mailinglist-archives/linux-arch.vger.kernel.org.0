Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1BF4A6320
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 19:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbiBASCm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 13:02:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47722 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiBASCm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 13:02:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C51DB82F45;
        Tue,  1 Feb 2022 18:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB62C340EC;
        Tue,  1 Feb 2022 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643738559;
        bh=RgTrOkLtWsYqhbH1QGUsruLsxp4i3lng0IFmNIyILIA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WbvjgAOKq1FdAloutmsFJGq4lawYZwKp9qs9UBoOXLsZ9mbNVJMw7xtakNCb/q9cU
         0reqDdMiq1UO/sByG9insFKBqd2aJuhKlzD8PNPscX96G4AHYKpEKO5BekRnVnkBnk
         ExjxkhLJRyg/vmDIJxzxIkvzMJTChHl2PbYAnWumNRTURGlurTZ2NPbY8RAGE0UwZC
         E3A283h+eWrrtTk3oiav2Gg3E5mBIKmEk+BhvlXqeISWIQMrKyOyzGTimOBdMkcbu2
         m88r2HNwDpsT+lH6h+yoEn/q9yzPV1yA5QHCHRBHhNtLpUKC67GFK/u0dtz9uhYOIA
         /etjLJZCiNj/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7505B5C0326; Tue,  1 Feb 2022 10:02:39 -0800 (PST)
Date:   Tue, 1 Feb 2022 10:02:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Subject: Re: [PATCH] tools/memory-model: Explain syntactic and semantic
 dependencies
Message-ID: <20220201180239.GZ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220125172819.3087760-1-paul.heidekrueger@in.tum.de>
 <YfBk265vVo4FL4MJ@rowland.harvard.edu>
 <YfJ7Rr9Kdk4u78lt@Pauls-MacBook-Pro.local>
 <YfLQmgsXp6pg0XIy@rowland.harvard.edu>
 <YfMFQ5IZiGBRw7SH@Pauls-MacBook-Pro.local>
 <YfMKlLInsK0Qr77f@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfMKlLInsK0Qr77f@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 27, 2022 at 04:11:48PM -0500, Alan Stern wrote:
> Paul Heidekrüger pointed out that the Linux Kernel Memory Model
> documentation doesn't mention the distinction between syntactic and
> semantic dependencies.  This is an important difference, because the
> compiler can easily break dependencies that are only syntactic, not
> semantic.
> 
> This patch adds a few paragraphs to the LKMM documentation explaining
> these issues and illustrating how they can matter.
> 
> Suggested-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> 
> [as1970]
> 
> 
>  tools/memory-model/Documentation/explanation.txt |   47 +++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> Index: usb-devel/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -485,6 +485,53 @@ have R ->po X.  It wouldn't make sense f
>  somehow on a value that doesn't get loaded from shared memory until
>  later in the code!
>  
> +Here's a trick question: When is a dependency not a dependency?  Answer:
> +When it is purely syntactic rather than semantic.  We say a dependency
> +between two accesses is purely syntactic if the second access doesn't
> +actually depend on the result of the first.  Here is a trivial example:
> +
> +	r1 = READ_ONCE(x);
> +	WRITE_ONCE(y, r1 * 0);
> +
> +There appears to be a data dependency from the load of x to the store of
> +y, since the value to be stored is computed from the value that was
> +loaded.  But in fact, the value stored does not really depend on
> +anything since it will always be 0.  Thus the data dependency is only
> +syntactic (it appears to exist in the code) but not semantic (the second
> +access will always be the same, regardless of the value of the first
> +access).  Given code like this, a compiler could simply eliminate the
> +load from x, which would certainly destroy any dependency.

Are you OK with that last sentence reading as follows?

	Given code like this, a compiler could simply discard the value
	return by the load from x, which would certainly destroy any
	dependency.

My concern with the original is that it might mislead people into thinking
that compilers can omit volatile loads.

> +
> +(It's natural to object that no one in their right mind would write code
> +like the above.  However, macro expansions can easily give rise to this
> +sort of thing, in ways that generally are not apparent to the
> +programmer.)
> +
> +Another mechanism that can give rise to purely syntactic dependencies is
> +related to the notion of "undefined behavior".  Certain program behaviors
> +are called "undefined" in the C language specification, which means that
> +when they occur there are no guarantees at all about the outcome.
> +Consider the following example:
> +
> +	int a[1];
> +	int i;
> +
> +	r1 = READ_ONCE(i);
> +	r2 = READ_ONCE(a[r1]);
> +
> +Access beyond the end or before the beginning of an array is one kind of
> +undefined behavior.  Therefore the compiler doesn't have to worry about
> +what will happen if r1 is nonzero, and it can assume that r1 will always
> +be zero without actually loading anything from i.

And similarly here:

	... and it can assume that r1 will always be zero regardless of
	the value actually loaded from i.

> +                                                   (If the assumption
> +turns out to be wrong, the resulting behavior will be undefined anyway
> +so the compiler doesn't care!)  Thus the load from i can be eliminated,
> +breaking the address dependency.
> +
> +The LKMM is unaware that purely syntactic dependencies are different
> +from semantic dependencies and therefore mistakenly predicts that the
> +accesses in the two examples above will be ordered.  This is another
> +example of how the compiler can undermine the memory model.  Be warned.
> +
>  
>  THE READS-FROM RELATION: rf, rfi, and rfe
>  -----------------------------------------

Looks great otherwise, and thank you all for your work on this!

Alan, would you like me to pull this in making those two changes and
applying Akira's Reviewed-by, or would you prefer to send another version?

For that matter, am I off base in my suggested changes.

							Thanx, Paul
