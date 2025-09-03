Return-Path: <linux-arch+bounces-13365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EE5B419EC
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFC634E2CCD
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3562F0C6A;
	Wed,  3 Sep 2025 09:27:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71C2F0C67;
	Wed,  3 Sep 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891644; cv=none; b=bWY/jRRkg/YSJtfqPgLApXNrV2GsHmnNv3nZ/ZofbmgKgdCJaPhW3v5QoVe2u3+gLpMQ1JNp7+k5dhtrbWYyDhG+hZvf+w96zVHypMSu8DH5w5nqroBJlMbo/M3ueB/Ua0f7oQGZj96kwh0MPIo7lsU9ML3/PdwHsbnyeW//+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891644; c=relaxed/simple;
	bh=TTBvdDWN0SRxo51afac9to5kGEx6F2cJ42lwCTuMAjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvVoGIGd2ENl/HKjLlwPNFxqS7CIgtp/FYJ5ggib55wx9dBIMIwgKQpDM7fGZBKb9jx+o+3+IDeSOSJKIyLAZL+8IgJuxp1JJ70FzMfHWO55z136qHtUU6uLzpb7GN4A6M+kJBxHZFQucEMg47ApYcIJwjdoBhMtrTy/aevcIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E21C4CEF0;
	Wed,  3 Sep 2025 09:27:21 +0000 (UTC)
Date: Wed, 3 Sep 2025 10:27:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
Message-ID: <aLgJ9iqQhq-LT9S0@arm.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <aLWITwwDg06F1eXu@arm.com>
 <87tt1kpj4z.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt1kpj4z.fsf@oracle.com>

On Tue, Sep 02, 2025 at 03:46:52PM -0700, Ankur Arora wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > Can you have a go at poll_idle() to see how it would look like using
> > this API? It doesn't necessarily mean we have to merge them all at once
> > but it gives us a better idea of the suitability of the interface.
> 
> So, I've been testing with some version of the following:
> 
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 9b6d90a72601..361879396d0c 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -8,35 +8,25 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/idle.h>
> 
> -#define POLL_IDLE_RELAX_COUNT	200
> -
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  			       struct cpuidle_driver *drv, int index)
>  {
> -	u64 time_start;
> -
> -	time_start = local_clock_noinstr();
> +	unsigned long flags;
> 
>  	dev->poll_time_limit = false;
> 
>  	raw_local_irq_enable();
>  	if (!current_set_polling_and_test()) {
> -		unsigned int loop_count = 0;
> -		u64 limit;
> +		u64 limit, time_end;
> 
>  		limit = cpuidle_poll_time(drv, dev);
> +		time_end = local_clock_noinstr() + limit;
> 
> -		while (!need_resched()) {
> -			cpu_relax();
> -			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> -				continue;
> +		flags = smp_cond_load_relaxed_timewait(&current_thread_info()->flags,
> +						       VAL & _TIF_NEED_RESCHED,
> +						       (local_clock_noinstr() >= time_end));

It makes sense to have the non-strict comparison, though it changes the
original behaviour slightly. Just mention it in the commit log.

> 
> -			loop_count = 0;
> -			if (local_clock_noinstr() - time_start > limit) {
> -				dev->poll_time_limit = true;
> -				break;
> -			}
> -		}
> +		dev->poll_time_limit = (local_clock_noinstr() >= time_end);

Could we do this instead and avoid another clock read:

		dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);

In the original code, it made sense since it had to check the clock
anyway and break the loop.

When you repost, please include the rqspinlock and poll_idle changes as
well to show how the interface is used.

-- 
Catalin

