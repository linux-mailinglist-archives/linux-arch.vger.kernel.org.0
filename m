Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA232ED7A
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 15:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCEOvD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 09:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhCEOuw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 09:50:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9F4364FC5;
        Fri,  5 Mar 2021 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614955852;
        bh=TnDiNaCMrY4rnw7gklOL6BQ8NqCBOKKxfZI4bYQ5cz4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=COTMscXr5U0OFtfpir7PTEZx6b+9HIjXwpYn1KVGeCRnNkv0G6oa8/Gqn9dlRDYnn
         64SqjadMtCNT+NfXOHaVz5IZGQzpt4LZtsnZfysk+kdHGHxxM7xZ7p9xhL5Vpixggg
         F7+/tW/OPVfCTOFT34IZtRzKnPB+cPxaLqe94ogfR5POxoWm/HgamK5kwycZgm1FMA
         EMbm4Hvb5WgQyA1W4igEoPgaYBj20GjtVVj2n/bj2a4O2yNlnyb95+D9zAh6nWmIGI
         NkcQAUYHsiPvVGrtqi0Osaf+NpE8n3R3ryvDdYirWqunZcJi2ks7EMwHNk29n5P//z
         hJZGQDRVNK5wA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B684D3522621; Fri,  5 Mar 2021 06:50:51 -0800 (PST)
Date:   Fri, 5 Mar 2021 06:50:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] tools/memory-model: Fix smp_mb__after_spinlock() spelling
Message-ID: <20210305145051.GZ2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210305102823.415900-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305102823.415900-1-bjorn.topel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 11:28:23AM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> A misspelled invokation of git-grep, revealed that
> smp_mb__after_spinlock() was misspelled in explaination.txt.
> 
> Add missing "_" to smp_mb__after_spinlock().
> 
> Fixes: 1c27b644c0fd ("Automate memory-barriers.txt; provide Linux-kernel memory model")
> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>

Good catch!  Applied, thank you!

						Thanx, Paul

> ---
>  tools/memory-model/Documentation/explanation.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index f9d610d5a1a4..5d72f3112e56 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -2510,7 +2510,7 @@ they behave as follows:
>  	smp_mb__after_atomic() orders po-earlier atomic updates and
>  	the events preceding them against all po-later events;
>  
> -	smp_mb_after_spinlock() orders po-earlier lock acquisition
> +	smp_mb__after_spinlock() orders po-earlier lock acquisition
>  	events and the events preceding them against all po-later
>  	events.
>  
> 
> base-commit: 7f58c0fb9238abaa3997185ceec319201b6f5a94
> -- 
> 2.27.0
> 
