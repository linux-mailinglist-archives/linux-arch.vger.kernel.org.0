Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254D017238F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 17:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgB0Qha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 11:37:30 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:38964 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730194AbgB0Qha (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 11:37:30 -0500
Received: (qmail 3400 invoked by uid 2102); 27 Feb 2020 11:37:29 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2020 11:37:29 -0500
Date:   Thu, 27 Feb 2020 11:37:29 -0500 (EST)
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
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-arch@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] Documentation/locking/atomic: Add a litmus test
 for atomic_set()
In-Reply-To: <20200227004049.6853-5-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2002271136110.1730-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 27 Feb 2020, Boqun Feng wrote:

> We already use a litmus test in atomic_t.txt to describe the behavior of
> an atomic_set() with the an atomic RMW, so add it into atomic-tests
> directory to make it easily accessible for anyone who cares about the
> semantics of our atomic APIs.
> 
> Additionally, change the sentences describing the test in atomic_t.txt
> with better wording.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 +++++++++++++++++++
>  Documentation/atomic-tests/README             |  7 ++++++
>  Documentation/atomic_t.txt                    |  6 ++---
>  3 files changed, 34 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> 
> diff --git a/Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus b/Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> new file mode 100644
> index 000000000000..5dd7f04e504a
> --- /dev/null
> +++ b/Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> @@ -0,0 +1,24 @@
> +C Atomic-set-observable-to-RMW

This line needs to match the filename.  Aside from that,

Acked-by: Alan Stern <stern@rowland.harvard.edu>


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
> diff --git a/Documentation/atomic-tests/README b/Documentation/atomic-tests/README
> index ae61201a4271..a1b72410b539 100644
> --- a/Documentation/atomic-tests/README
> +++ b/Documentation/atomic-tests/README
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
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index ceb85ada378e..67d1d99f8589 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -85,10 +85,10 @@ smp_store_release() respectively. Therefore, if you find yourself only using
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
>      atomic_t v = ATOMIC_INIT(1);
> 

