Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9344217237D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 17:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgB0Qe6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 11:34:58 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:38866 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730203AbgB0Qe4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 11:34:56 -0500
Received: (qmail 3344 invoked by uid 2102); 27 Feb 2020 11:34:55 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2020 11:34:55 -0500
Date:   Thu, 27 Feb 2020 11:34:55 -0500 (EST)
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
Subject: Re: [PATCH v3 2/5] Documentation/locking/atomic: Fix atomic-set
 litmus test
In-Reply-To: <20200227004049.6853-3-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2002271133300.1730-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 27 Feb 2020, Boqun Feng wrote:

> Currently the litmus test "atomic-set" in atomic_t.txt has a few things
> to be improved:
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
> Therefore fix these and this is the preparation for adding the litmus
> test into memory-model litmus-tests directory so that people can
> understand better about our requirements of atomic APIs and klitmus tool
> can be used to generate tests.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Patch 5/5 in this series does basically the same thing for 
Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.  How come you 
used one patch for that, but this is split into two patches (2/5 and 
4/5)?

Alan

> ---
>  Documentation/atomic_t.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index 0ab747e0d5ac..ceb85ada378e 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -91,15 +91,15 @@ ops. That is:
>    C atomic-set
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
> 


