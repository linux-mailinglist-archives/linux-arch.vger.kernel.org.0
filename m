Return-Path: <linux-arch+bounces-13496-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CAAB5359D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 16:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F0D5A752C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FF34164E;
	Thu, 11 Sep 2025 14:34:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F8340DBB;
	Thu, 11 Sep 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601248; cv=none; b=tTw3mOWYIVEl8BzpNm9YrFxvOQ98pOJ++OgteycD0VvYO68Do/viM+TRNaqzoJifPKSF+Gaiwn3zRLCuEjh4LS29/9pjgHcra+MjYWuDu+rx2xS+CqjopqJ3wORbX0cYCbjNr1IJmVKLF+P0bw6pLPwRk4/hx+KItJePpTZfGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601248; c=relaxed/simple;
	bh=Iqx4Z9f2xaiVClCaUK10eDmxpYv4dfcvc1KxhqbjFnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2FL/IqFXzSpQC+2Eshs1TAEsnA2+CRzRQDsQj/aIJ3RUqFwhC4EHwPZRd8dD8hqZfU/pyvlj5EdCvZ2XErIhWyPVCBNjlJgbqeimqQ+ap3HFb25/gX4e5xdghkJUmSMgb35aZ5HARNk1r0GAa7fpQJBDr/G5Dr9+2Al+ASqAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4524C4CEF0;
	Thu, 11 Sep 2025 14:34:04 +0000 (UTC)
Date: Thu, 11 Sep 2025 15:34:01 +0100
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
Subject: Re: [PATCH v5 0/5] barrier: Add smp_cond_load_*_timeout()
Message-ID: <aMLd2QOFrZnaKcWf@arm.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911034655.3916002-1-ankur.a.arora@oracle.com>

On Wed, Sep 10, 2025 at 08:46:50PM -0700, Ankur Arora wrote:
> This series adds waited variants of the smp_cond_load() primitives:
> smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().
> 
> As the name suggests, the new interfaces are meant for contexts where
> you want to wait on a condition variable for a finite duration. This
> is easy enough to do with a loop around cpu_relax() and a periodic
> timeout check (pretty much what we do in poll_idle(). However, some
> architectures (ex. arm64) also allow waiting on a cacheline. So, 
> 
>   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)
>   smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)
> 
> do a mixture of spin/wait with a smp_cond_load() thrown in.
> 
> The added parameter, time_check_expr, determines the bail out condition.
> 
> There are two current users for these interfaces. poll_idle() with
> the change:
> 
>   poll_idle() {
>       ...
>       time_end = local_clock_noinstr() + cpuidle_poll_time(drv, dev);
>       
>       raw_local_irq_enable();
>       if (!current_set_polling_and_test())
>       	 flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
>       					(VAL & _TIF_NEED_RESCHED),
>       					((local_clock_noinstr() >= time_end)));
>       dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
>       raw_local_irq_disable();
>       ...
>   }

You should have added this as a patch in the series than include the
implementation in the cover letter.

-- 
Catalin

