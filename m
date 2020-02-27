Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9CB17234F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 17:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgB0Q0N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 11:26:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbgB0Q0N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 11:26:13 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3675224697;
        Thu, 27 Feb 2020 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582820772;
        bh=WmU71Lj4UDtNZ82BoefiR89GTcfxg2tFZvzAqtQOSZQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0AEWJ49a5eR1VGeCnDgdj2Al1+fI8AncWZnozP9Pw/ByyAzg4mN4U7T/6tCHtGyRo
         hOJ0nIE+WpGzBn9d9+6TJBGsRm7JjRKybwS29KzVKMBEPogHM83ACoGc1X7gESbAyu
         //tE3ILHCkISn6TJLDEn5zyANd+BCU5ceoUmMCRY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6225335226D2; Thu, 27 Feb 2020 07:47:55 -0800 (PST)
Date:   Thu, 27 Feb 2020 07:47:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Documentation/locking/atomic: Add litmus tests
 for atomic APIs
Message-ID: <20200227154755.GJ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200227004049.6853-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227004049.6853-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 27, 2020 at 08:40:44AM +0800, Boqun Feng wrote:
> A recent discussion raises up the requirement for having test cases for
> atomic APIs:
> 
> 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> 
> , and since we already have a way to generate a test module from a
> litmus test with klitmus[1]. It makes sense that we add more litmus
> tests for atomic APIs. And based on the previous discussion, I create a
> new directory Documentation/atomic-tests and put these litmus tests
> here.
> 
> This patchset starts the work by adding the litmus tests which are
> already used in atomic_t.txt, and also improve the atomic_t.txt to make
> it consistent with the litmus tests.
> 
> Previous version:
> v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> 
> Changes since v2:
> 
> *	Change from "RFC" to "PATCH".
> 
> *	Wording improvement in atomic_t.txt as per Alan's suggestion.
> 
> *	Add a new patch describing the usage of atomic_add_unless() is
> 	not limited anymore for LKMM litmus tests.
> 
> My PR on supporting "(void) expr;" statement has been merged by Luc
> (Thank you, Luc). So all the litmus tests in this patchset can be
> handled by the herdtools compiled from latest master branch of the
> source code.
> 
> Comments and suggestions are welcome!
> 
> Regards,
> Boqun

Queued for further review, thank you, Boqun!

							Thanx, Paul

> [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> 
> Boqun Feng (5):
>   tools/memory-model: Add an exception for limitations on _unless()
>     family
>   Documentation/locking/atomic: Fix atomic-set litmus test
>   Documentation/locking/atomic: Introduce atomic-tests directory
>   Documentation/locking/atomic: Add a litmus test for atomic_set()
>   Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()
> 
>  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
>  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
>  Documentation/atomic-tests/README             | 16 ++++++++++
>  Documentation/atomic_t.txt                    | 24 +++++++-------
>  MAINTAINERS                                   |  1 +
>  tools/memory-model/README                     | 10 ++++--
>  6 files changed, 92 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>  create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  create mode 100644 Documentation/atomic-tests/README
> 
> -- 
> 2.25.0
> 
