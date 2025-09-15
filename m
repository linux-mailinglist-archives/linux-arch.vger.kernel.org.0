Return-Path: <linux-arch+bounces-13617-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2298B577BF
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 13:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F16A1A2048F
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED472FB978;
	Mon, 15 Sep 2025 11:12:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AA2F4A1B;
	Mon, 15 Sep 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934776; cv=none; b=cPCzSUF+PPHlbf8AqZXzmYMZ1Ck2zxoTk54rEnSGnGZxAR0p45ZhnBmPN3zOAcyMADY54xXbXtWld5ceDtCJf2MPCjenLpRhA9yR6nmSC+1izgDwNd2eIDGdxMWuzfFX+10AOVIQbHxHBSbb+f1lzfiX2aO5YblpvAfP8lmCQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934776; c=relaxed/simple;
	bh=eVy68csJY7b9yoCQmJI6i2Tv+f5t46MzAEsuXx4+f4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4u1qqsoC9XOcHCfyyH9JyhoAMvQdUkmle1pjVyW0zI0eoVUdx34gy1+laZ5aN+f99pr9sCErI2cx92QT7NdrTYBEQRBgUmO/QSgkBk6DpHjAGmWZ9elZ+ZZAL/NvKKKOI0oxSfC4oVFJaIQaJ3h+dVmE06B/8CoxQwTqgRDQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26BBC4CEF1;
	Mon, 15 Sep 2025 11:12:52 +0000 (UTC)
Date: Mon, 15 Sep 2025 12:12:50 +0100
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
Message-ID: <aMf0sjveqxZXulEi@arm.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <aMLd2QOFrZnaKcWf@arm.com>
 <87tt18k5y7.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt18k5y7.fsf@oracle.com>

On Thu, Sep 11, 2025 at 02:57:52PM -0700, Ankur Arora wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Wed, Sep 10, 2025 at 08:46:50PM -0700, Ankur Arora wrote:
> >> This series adds waited variants of the smp_cond_load() primitives:
> >> smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().
> >>
> >> As the name suggests, the new interfaces are meant for contexts where
> >> you want to wait on a condition variable for a finite duration. This
> >> is easy enough to do with a loop around cpu_relax() and a periodic
> >> timeout check (pretty much what we do in poll_idle(). However, some
> >> architectures (ex. arm64) also allow waiting on a cacheline. So,
> >>
> >>   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)
> >>   smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)
> >>
> >> do a mixture of spin/wait with a smp_cond_load() thrown in.
> >>
> >> The added parameter, time_check_expr, determines the bail out condition.
> >>
> >> There are two current users for these interfaces. poll_idle() with
> >> the change:
> >>
> >>   poll_idle() {
> >>       ...
> >>       time_end = local_clock_noinstr() + cpuidle_poll_time(drv, dev);
> >>
> >>       raw_local_irq_enable();
> >>       if (!current_set_polling_and_test())
> >>       	 flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
> >>       					(VAL & _TIF_NEED_RESCHED),
> >>       					((local_clock_noinstr() >= time_end)));
> >>       dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
> >>       raw_local_irq_disable();
> >>       ...
> >>   }
> >
> > You should have added this as a patch in the series than include the
> > implementation in the cover letter.
> 
> This was probably an overkill but I wanted to not add another subsystem
> to this series.

If you include it, it's easier to poke the cpuidle maintainers and ask
if they are ok with the proposed API as I want to avoid changing it
afterwards. It doesn't mean they'll have to be merged together, they can
go upstream via separate routes.

> Will take care of the cpuidle changes in the arm64 polling in idle series.

Thanks. We also need Will, Peter Z and Arnd to ack the API and the
generic changes (probably once you added the linux/atomic.h changes).

-- 
Catalin

