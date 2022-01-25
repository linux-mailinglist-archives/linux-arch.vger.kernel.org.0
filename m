Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC549BD8E
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jan 2022 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiAYVAO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jan 2022 16:00:14 -0500
Received: from netrider.rowland.org ([192.131.102.5]:48081 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232685AbiAYVAM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jan 2022 16:00:12 -0500
Received: (qmail 117653 invoked by uid 1000); 25 Jan 2022 16:00:11 -0500
Date:   Tue, 25 Jan 2022 16:00:11 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Subject: Re: [PATCH] tools/memory-model: Clarify syntactic and semantic
 dependencies
Message-ID: <YfBk265vVo4FL4MJ@rowland.harvard.edu>
References: <20220125172819.3087760-1-paul.heidekrueger@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125172819.3087760-1-paul.heidekrueger@in.tum.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 25, 2022 at 05:28:19PM +0000, Paul Heidekrüger wrote:
> Dependencies which are purely syntactic, i.e. not semantic, might imply
> ordering at first glance. However, since they do not affect defined
> behavior, compilers are within their rights to remove such dependencies
> when optimizing code.
> 
> Since syntactic dependencies are not related to any kind of dependency
> in particular, explicitly distinguish syntactic and semantic
> dependencies as part of the 'A WARNING' section in explanation.txt,
> which gives examples of how compilers might affect the LKMM's dependency
> orderings in general.

The "A WARNING" section is a bad place to put this material, because it 
comes before dependencies have been introduced.  It would be better to 
put this at the end of the "DEPENDENCY RELATIONS: data, addr, and ctrl" 
section.

> Link: https://lore.kernel.org/all/20211102190138.GA1497378@rowland.harvard.edu/
> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> Cc: Marco Elver <elver@google.com>
> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> ---
>  .../Documentation/explanation.txt             | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 5d72f3112e56..6d679e5ebdf9 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -411,6 +411,31 @@ Given this version of the code, the LKMM would predict that the load
>  from x could be executed after the store to y.  Thus, the memory
>  model's original prediction could be invalidated by the compiler.
>  
> +Caution is also advised when dependencies are purely syntactic, i.e.
> +not semantic.  A dependency between two marked accesses is purely
> +syntactic iff the defined behavior of the second access is unaffected
> +by its dependency.

That's a very abstract way of describing the situation; it doesn't do a 
good job of getting the real idea across.  It also mixes up two separate 
ideas: behaviors being unaffected by a syntactic dependency and 
behaviors being undefined.  They should be described separately.  I 
would prefer something along these lines...

----------------------------------------

Here's a trick question: When is a dependency not a dependency? Answer: 
When it is purely syntactic rather than semantic.  We say a dependency 
between two accesses is purely syntactic if the second access doesn't 
actually depend on the result of the first.  Here is a trivial example:

	r1 = READ_ONCE(x);
	WRITE_ONCE(y, r1 * 0);

There appears to be a data dependency from the load of x to the store of 
y, since the value to be stored is computed from the value that was 
loaded.  But in fact, the value stored does not really depend on 
anything since it will always be 0.  Thus the data dependency is only 
syntactic (it appears to exist in the code) but not semantic (the second 
access will always be the same, regardless of the value of the first 
access).  Given code like this, a compiler could simply eliminate the 
load from x, which would certainly destroy any dependency.

(It's natural to object that no one in their right mind would write code 
like the above.  However, macro expansions can easily give rise to this 
sort of thing, in ways that generally are not apparent to the 
programmer.)

Another mechanism that can give rise to purely syntactic dependencies is 
related to the notion of "undefined behavior". Certain program behaviors 
are called "undefined" in the C language specification, which means that 
when they occur there are no guarantees at all about the outcome.  
Consider the following example:

	int a[1];
	int i;

	r1 = READ_ONCE(i);
	r2 = READ_ONCE(a[r1]);

Access beyond the end or before the beginning of an array is one kind of 
undefined behavior.  Therefore the compiler doesn't have to worry about 
what will happen if r1 is nonzero, and it can assume that r1 will always 
be zero without actually loading anything from i.  (If the assumption 
turns out to be wrong, the resulting behavior will be undefined anyway 
so the compiler doesn't care!)  Thus the load from i can be eliminated, 
breaking the address dependency.

The LKMM is unaware that purely syntactic dependencies are different 
from semantic dependencies and therefore mistakenly predicts that the 
accesses in the two examples above will be ordered.  This is another 
example of how the compiler can undermine the memory model.  Be warned.

----------------------------------------

Alan

> +Compilers are aware of syntactic dependencies and are within their
> +rights to remove them as part of optimizations, thereby breaking any
> +guarantees of ordering.
> +
> +Notable cases are dependencies eliminated through constant propagation
> +or those where only one value leads to defined behavior as in the
> +following example:
> +
> +	int a[1];
> +	int i;
> +
> +	r1 = READ_ONCE(i);
> +	r2 = READ_ONCE(a[r1]);
> +
> +The formal LKMM is unaware of syntactic dependencies and therefore
> +predicts ordering.  However, since any other value than 0 for r1 would
> +result in an out-of-bounds access, which is undefined behavior, r2 is
> +not affected by its dependency to r1, making the above a purely
> +syntactic dependency.
> +
>  Another issue arises from the fact that in C, arguments to many
>  operators and function calls can be evaluated in any order.  For
>  example:
> -- 
> 2.33.1
> 
