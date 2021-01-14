Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD882F6414
	for <lists+linux-arch@lfdr.de>; Thu, 14 Jan 2021 16:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbhANPQg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Jan 2021 10:16:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbhANPQg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Jan 2021 10:16:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95B6923A5F;
        Thu, 14 Jan 2021 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610637355;
        bh=gLLPfUlONDQS1aydZtW+IGDKTZFvNgwsCEdoTD72IQw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sZU21nyC4NBdj1AEj57D3V0spmSCTc2E/oaHXNUMcM6JnI5+hmweUpjA6yAxPCBrd
         YNUVPzSBtuJ0X4IEBcRBhLANz5V0ryERU6hW0b0EznTRPW3fZfxK62anFWsiSr5pwC
         bHG5WsJbWpTzh96KibHLYR9lWs7Z0DrEbqMUoUPghX4I7FN+CTw7Jy8MLyBYs31G3H
         5Ki8VWdAXiN3g//7bl7DRuztJHWec1fQpwki+ehO4MmURhYf8MP2XceVtLxiyNbbFD
         3zdz9Kq7fB3NP7qw7a95QAM9M9niENeE68w5ahFPNQvuncy9toCXC6JzKayPovtB7C
         q/kxbWdzCaCcw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6498B35225DC; Thu, 14 Jan 2021 07:15:55 -0800 (PST)
Date:   Thu, 14 Jan 2021 07:15:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH -rcu] tools/memory-model: Remove reference to
 atomic_ops.rst
Message-ID: <20210114151555.GG2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <28849fc0-1d1e-6e1b-380c-672da2622aec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28849fc0-1d1e-6e1b-380c-672da2622aec@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 14, 2021 at 11:40:26PM +0900, Akira Yokosawa wrote:
> >From 1d7642add7f74ca307f1bf70569e23edf8b1a023 Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Thu, 14 Jan 2021 23:09:07 +0900
> Subject: [PATCH -rcu] tools/memory-model: Remove reference to atomic_ops.rst
> 
> atomic_ops.rst was removed by commit f0400a77ebdc ("atomic: Delete
> obsolete documentation").
> Remove the broken link in tools/memory-model/Documentation/simple.txt.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Good catch, thank you!  Queued for v5.12.

							Thanx, Paul

> ---
> Hi Paul,
> 
> This is relative to dev of -rcu.
> 
>         Thanks, Akira
> --
>  tools/memory-model/Documentation/simple.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/memory-model/Documentation/simple.txt b/tools/memory-model/Documentation/simple.txt
> index 81e1a0ec5342..4c789ec8334f 100644
> --- a/tools/memory-model/Documentation/simple.txt
> +++ b/tools/memory-model/Documentation/simple.txt
> @@ -189,7 +189,6 @@ Additional information may be found in these files:
>  
>  Documentation/atomic_t.txt
>  Documentation/atomic_bitops.txt
> -Documentation/core-api/atomic_ops.rst
>  Documentation/core-api/refcount-vs-atomic.rst
>  
>  Reading code using these primitives is often also quite helpful.
> -- 
> 2.17.1
> 
