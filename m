Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5229A369EE3
	for <lists+linux-arch@lfdr.de>; Sat, 24 Apr 2021 06:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhDXE1m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Apr 2021 00:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhDXE1m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 24 Apr 2021 00:27:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDF1061042;
        Sat, 24 Apr 2021 04:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619238424;
        bh=UNBzx7jGOk4CReRa/FNMvK2E7MWEObhV7+25u+OlWcw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uXa0xkUJojVbZiASIxKAC9TpK4tRigADTtUN97u04+2kkrdc/XvlWYUscHRCU5GES
         XtGemyqqR6fJXQc829c3f4gZ5EOxqWjtY1T7updhyPMN9Ci/ounWpT//WODCk6f9Vt
         /5b8SNAs56W1XG+IoANxiZvP/Q/wJSjDkzY20CzvWTywDojTdIzSAVHoP4RvdZnEHe
         dSqnHkMPHfUyT0/QgtAe/dUhv3wI5rL7vpzXC085OXDHtnelcBpLsFSVtbZJAE+DjN
         3nT25me2mAO7mnx8cEgHHA+dDXbD4VYEUtze7TvK7FfifGDU/OPuqPl8Nn6g/9o7K6
         HrTxvRIuZDmWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A18995C0698; Fri, 23 Apr 2021 21:27:04 -0700 (PDT)
Date:   Fri, 23 Apr 2021 21:27:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        Daniel Lustig <dlustig@nvidia.com>, joel@joelfernandes.org,
        elver@google.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] tools/memory-model: Correct the name of
 smp_mb__after_spinlock()
Message-ID: <20210424042704.GR975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210424002509.797308-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210424002509.797308-1-palmer@dabbelt.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 23, 2021 at 05:25:09PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> This was missing one of the double _s.  I only found it because I
> mis-typed the name myself.
> 
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Good catch, and thank you, but Björn Töpel beat you to it.

dce310f2e546 ("tools/memory-model: Fix smp_mb__after_spinlock() spelling")

This one is queued in the -rcu tree for the v5.14 merge window.

But please keep the fixes coming!

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
> -- 
> 2.31.1.498.g6c1eba8ee3d-goog
> 
