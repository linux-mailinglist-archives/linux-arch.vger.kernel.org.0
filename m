Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5426B0F6
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 00:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgIOWWo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 18:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbgIOQ0Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 12:26:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680002074B;
        Tue, 15 Sep 2020 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600186275;
        bh=UC1yh2hp7xYE271XAEDPNKg+J+sQcRAFlbeySxxF1fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLJBoJyZ2MbAregGNpzO/CAOq3qYqCUVYtw7hO4M7FduU8HInY48wZG+1gWntYelQ
         oLWO9tTjUONmPdC0nJ9es906NbinxDOlYlq9MiTPOxDMzJntQj9N/nuOqfyS1ru3ka
         TrV8du2f8kHA6eUDyUlEROxdTu8m4Jc0gLv8xEr4=
Date:   Tue, 15 Sep 2020 17:11:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [patch 04/13] lockdep: Clenaup PREEMPT_COUNT leftovers
Message-ID: <20200915161104.GB26745@willie-the-truck>
References: <20200914204209.256266093@linutronix.de>
 <20200914204441.375753691@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914204441.375753691@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14, 2020 at 10:42:13PM +0200, Thomas Gleixner wrote:
> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> removed. Cleanup the leftovers before doing so.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  include/linux/lockdep.h |    6 ++----
>  lib/Kconfig.debug       |    1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -585,16 +585,14 @@ do {									\
>  
>  #define lockdep_assert_preemption_enabled()				\
>  do {									\
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> -		     debug_locks			&&		\
> +	WARN_ON_ONCE(debug_locks			&&		\
>  		     (preempt_count() != 0		||		\
>  		      !raw_cpu_read(hardirqs_enabled)));		\
>  } while (0)
>  
>  #define lockdep_assert_preemption_disabled()				\
>  do {									\
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> -		     debug_locks			&&		\
> +	WARN_ON_ONCE(debug_locks			&&		\
>  		     (preempt_count() == 0		&&		\
>  		      raw_cpu_read(hardirqs_enabled)));			\
>  } while (0)
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1161,7 +1161,6 @@ config PROVE_LOCKING
>  	select DEBUG_RWSEMS
>  	select DEBUG_WW_MUTEX_SLOWPATH
>  	select DEBUG_LOCK_ALLOC
> -	select PREEMPT_COUNT
>  	select TRACE_IRQFLAGS
>  	default n
>  	help

Acked-by: Will Deacon <will@kernel.org>

Will
