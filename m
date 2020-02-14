Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02BDC15DB6B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 16:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgBNPru (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 10:47:50 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:39804 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728791AbgBNPrt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 10:47:49 -0500
Received: (qmail 3175 invoked by uid 2102); 14 Feb 2020 10:47:48 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Feb 2020 10:47:48 -0500
Date:   Fri, 14 Feb 2020 10:47:48 -0500 (EST)
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
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
In-Reply-To: <20200214040132.91934-3-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2002141028280.1579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 Feb 2020, Boqun Feng wrote:

> We already use a litmus test in atomic_t.txt to describe the behavior of
> an atomic_set() with the an atomic RMW, so add it into the litmus-tests
> directory to make it easily accessible for anyone who cares about the
> semantics of our atomic APIs.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  .../Atomic-set-observable-to-RMW.litmus       | 24 +++++++++++++++++++
>  tools/memory-model/litmus-tests/README        |  3 +++
>  2 files changed, 27 insertions(+)
>  create mode 100644 tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus

I don't like that name, or the corresponding sentence in atomic_t.txt:

	A subtle detail of atomic_set{}() is that it should be
	observable to the RMW ops.

"Observable" doesn't get the point across -- the point being that the
atomic RMW ops have to be _atomic_ with respect to all atomic store
operations, including atomic_set.

Suggestion: Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus, with 
corresponding changes to the comment in the litmus test and the entry 
in README.

Alan

> diff --git a/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
> new file mode 100644
> index 000000000000..4326f56f2c1a
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
> @@ -0,0 +1,24 @@
> +C Atomic-set-observable-to-RMW
> +
> +(*
> + * Result: Never
> + *
> + * Test of the result of atomic_set() must be observable to atomic RMWs.
> + *)
> +
> +{
> +	atomic_t v = ATOMIC_INIT(1);
> +}
> +
> +P0(atomic_t *v)
> +{
> +	(void)atomic_add_unless(v,1,0);
> +}
> +
> +P1(atomic_t *v)
> +{
> +	atomic_set(v, 0);
> +}
> +
> +exists
> +(v=2)
> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> index 681f9067fa9e..81eeacebd160 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -2,6 +2,9 @@
>  LITMUS TESTS
>  ============
>  
> +Atomic-set-observable-to-RMW.litmus
> +	Test of the result of atomic_set() must be observable to atomic RMWs.
> +
>  CoRR+poonceonce+Once.litmus
>  	Test of read-read coherence, that is, whether or not two
>  	successive reads from the same variable are ordered.
> 

