Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D157194131
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 15:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgCZOXW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Mar 2020 10:23:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52687 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727982AbgCZOXW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Mar 2020 10:23:22 -0400
Received: (qmail 6696 invoked by uid 500); 26 Mar 2020 10:23:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Mar 2020 10:23:21 -0400
Date:   Thu, 26 Mar 2020 10:23:21 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
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
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-arch@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] Documentation/litmus-tests/atomic: Add a test
 for atomic_set()
In-Reply-To: <20200326024022.7566-4-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2003261023010.5714-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 26 Mar 2020, Boqun Feng wrote:

> We already use a litmus test in atomic_t.txt to describe the behavior of
> an atomic_set() with the an atomic RMW, so add it into atomic-tests
> directory to make it easily accessible for anyone who cares about the
> semantics of our atomic APIs.
> 
> Besides currently the litmus test "atomic-set" in atomic_t.txt has a few
> things to be improved:
> 
> 1)	The CPU/Processor numbers "P1,P2" are not only inconsistent with
> 	the rest of the document, which uses "CPU0" and "CPU1", but also
> 	unacceptable by the herd tool, which requires processors start
> 	at "P0".
> 
> 2)	The initialization block uses a "atomic_set()", which is OK, but
> 	it's better to use ATOMIC_INIT() to make clear this is an
> 	initialization.
> 
> 3)	The return value of atomic_add_unless() is discarded
> 	inexplicitly, which is OK for C language, but it will be helpful
> 	to the herd tool if we use a void cast to make the discard
> 	explicit.
> 
> 4)	The name and the paragraph describing the test need to be more
> 	accurate and aligned with our wording in LKMM.
> 
> Therefore fix these in both atomic_t.txt and the new added litmus test.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: Andrea Parri <parri.andrea@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  Documentation/atomic_t.txt                    | 14 +++++------
>  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 +++++++++++++++++++
>  Documentation/litmus-tests/atomic/README      |  7 ++++++
>  3 files changed, 38 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index 0ab747e0d5ac..67d1d99f8589 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -85,21 +85,21 @@ smp_store_release() respectively. Therefore, if you find yourself only using
>  the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
>  and are doing it wrong.
>  
> -A subtle detail of atomic_set{}() is that it should be observable to the RMW
> -ops. That is:
> +A note for the implementation of atomic_set{}() is that it must not break the
> +atomicity of the RMW ops. That is:
>  
> -  C atomic-set
> +  C Atomic-RMW-ops-are-atomic-WRT-atomic_set
>  
>    {
> -    atomic_set(v, 1);
> +    atomic_t v = ATOMIC_INIT(1);
>    }
>  
> -  P1(atomic_t *v)
> +  P0(atomic_t *v)
>    {
> -    atomic_add_unless(v, 1, 0);
> +    (void)atomic_add_unless(v, 1, 0);
>    }
>  
> -  P2(atomic_t *v)
> +  P1(atomic_t *v)
>    {
>      atomic_set(v, 0);
>    }
> diff --git a/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> new file mode 100644
> index 000000000000..49385314d911
> --- /dev/null
> +++ b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> @@ -0,0 +1,24 @@
> +C Atomic-RMW-ops-are-atomic-WRT-atomic_set
> +
> +(*
> + * Result: Never
> + *
> + * Test that atomic_set() cannot break the atomicity of atomic RMWs.
> + *)
> +
> +{
> +	atomic_t v = ATOMIC_INIT(1);
> +}
> +
> +P0(atomic_t *v)
> +{
> +	(void)atomic_add_unless(v, 1, 0);
> +}
> +
> +P1(atomic_t *v)
> +{
> +	atomic_set(v, 0);
> +}
> +
> +exists
> +(v=2)
> diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
> index ae61201a4271..a1b72410b539 100644
> --- a/Documentation/litmus-tests/atomic/README
> +++ b/Documentation/litmus-tests/atomic/README
> @@ -2,3 +2,10 @@ This directory contains litmus tests that are typical to describe the semantics
>  of our atomic APIs. For more information about how to "run" a litmus test or
>  how to generate a kernel test module based on a litmus test, please see
>  tools/memory-model/README.
> +
> +============
> +LITMUS TESTS
> +============
> +
> +Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> +	Test that atomic_set() cannot break the atomicity of atomic RMWs.
> 

