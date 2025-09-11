Return-Path: <linux-arch+bounces-13495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD08B5356A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 16:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B99517D155
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6D533CE9C;
	Thu, 11 Sep 2025 14:32:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DDF33CE83;
	Thu, 11 Sep 2025 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601134; cv=none; b=GTSAkdFgGq5n/3gti2GYTrJ5TRZ0LPXBQDsIBN7ISAOGsPSxH2pC8baOEwdVd3zit/DwdjysC+4tZqZ+nuCrZRXmTaEmLMJCh9tl+JzShS5k6/e1AK7EB+U76RlqkfDxjkr0H0YPGwPjG3e5/DzrM/hIFl9pVm81DHeiAT76XPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601134; c=relaxed/simple;
	bh=N6oAQEhwS29xS1NKilY66MXV721mDaejR8ixr/rn7Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6d3S57V/M1s7CAMhi7Ar9Jm5zV7cPhOA63IJXKjXablp4HOHeqgjOkvBmc4UDaDRN+0/a21pv7MForAAC76eST3NeRq3G1NxNeqOD6q3NuvGN2/rOPFsmQfmve+gTWqy4vTqOLJ5XLS8iiqyvr75/ZE3gGfMuQBAfwqwkhl4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9786C4CEF0;
	Thu, 11 Sep 2025 14:32:10 +0000 (UTC)
Date: Thu, 11 Sep 2025 15:32:07 +0100
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
Subject: Re: [PATCH v5 5/5] rqspinlock: Use smp_cond_load_acquire_timeout()
Message-ID: <aMLdZyjYqFY1xxFD@arm.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911034655.3916002-6-ankur.a.arora@oracle.com>

On Wed, Sep 10, 2025 at 08:46:55PM -0700, Ankur Arora wrote:
> Switch out the conditional load inerfaces used by rqspinlock
> to smp_cond_read_acquire_timeout().
> This interface handles the timeout check explicitly and does any
> necessary amortization, so use check_timeout() directly.

It's worth mentioning that the default smp_cond_load_acquire_timeout()
implementation (without hardware support) only spins 200 times instead
of 16K times in the rqspinlock code. That's probably fine but it would
be good to have confirmation from Kumar or Alexei.

> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 5ab354d55d82..4d2c12d131ae 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
[...]
> @@ -313,11 +307,8 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
>   */
>  static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
>  
> -#ifndef res_smp_cond_load_acquire
> -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
> -#endif
> -
> -#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
> +#define res_atomic_cond_read_acquire_timeout(v, c, t)		\
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))

BTW, we have atomic_cond_read_acquire() which accesses the 'counter' of
an atomic_t. You might as well add an atomic_cond_read_acquire_timeout()
in atomic.h than open-code the atomic_t internals here.

Otherwise the patch looks fine to me, much simpler than the previous
attempt.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

