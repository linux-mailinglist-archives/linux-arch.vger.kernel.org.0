Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807CE172384
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 17:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgB0QgH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 11:36:07 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:38922 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730194AbgB0QgH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 11:36:07 -0500
Received: (qmail 3376 invoked by uid 2102); 27 Feb 2020 11:36:06 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2020 11:36:06 -0500
Date:   Thu, 27 Feb 2020 11:36:06 -0500 (EST)
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
Subject: Re: [PATCH v3 3/5] Documentation/locking/atomic: Introduce atomic-tests
 directory
In-Reply-To: <20200227004049.6853-4-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2002271135320.1730-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 27 Feb 2020, Boqun Feng wrote:

> Although we have atomic_t.txt and its friends to describe the semantics
> of atomic APIs and lib/atomic64_test.c for build testing and testing in
> UP mode, the tests for our atomic APIs in real SMP mode are still
> missing. Since now we have the LKMM tool in kernel and litmus tests can
> be used to generate kernel modules for testing purpose with "klitmus" (a
> tool from the LKMM toolset), it makes sense to put a few typical litmus
> tests into kernel so that
> 
> 1)	they are the examples to describe the conceptual mode of the
> 	semantics of atomic APIs, and
> 
> 2)	they can be used to generate kernel test modules for anyone
> 	who is interested to test the atomic APIs implementation (in
> 	most cases, is the one who implements the APIs for a new arch)
> 
> Therefore, introduce the atomic-tests directory for this purpose. The
> directory is maintained by the LKMM group to make sure the litmus tests
> are always aligned with our memory model.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  Documentation/atomic-tests/README | 4 ++++
>  MAINTAINERS                       | 1 +
>  2 files changed, 5 insertions(+)
>  create mode 100644 Documentation/atomic-tests/README
> 
> diff --git a/Documentation/atomic-tests/README b/Documentation/atomic-tests/README
> new file mode 100644
> index 000000000000..ae61201a4271
> --- /dev/null
> +++ b/Documentation/atomic-tests/README
> @@ -0,0 +1,4 @@
> +This directory contains litmus tests that are typical to describe the semantics
> +of our atomic APIs. For more information about how to "run" a litmus test or
> +how to generate a kernel test module based on a litmus test, please see
> +tools/memory-model/README.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffc7d5712735..ebca5f6263bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9718,6 +9718,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
>  F:	tools/memory-model/
>  F:	Documentation/atomic_bitops.txt
>  F:	Documentation/atomic_t.txt
> +F:	Documentation/atomic-tests/
>  F:	Documentation/core-api/atomic_ops.rst
>  F:	Documentation/core-api/refcount-vs-atomic.rst
>  F:	Documentation/memory-barriers.txt
> 

