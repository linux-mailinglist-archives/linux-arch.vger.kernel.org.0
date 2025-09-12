Return-Path: <linux-arch+bounces-13512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9762B54945
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649E448170A
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47982E62B5;
	Fri, 12 Sep 2025 10:14:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87842E612F;
	Fri, 12 Sep 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672078; cv=none; b=fTSIyN3iIGLe6YbEavJ0YstCTQ3Qvago+iZC0ZO2kCUCIuy2Dv0NPGibfwaumfdNiDKdrGENiYf7nzLfgwbMUUERQJn68eTEAY0v8Oob5IdZIWOGZjYaXoLQtigJdr6sjxNUv52JkSJuCGwiwEG2VFJXxrkNDGVOphZ9qXt9Tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672078; c=relaxed/simple;
	bh=FONjhalyy0nYuO9epq0nCJLGN+e67uZZPQI4FPVQhWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5e5/ggFugDjuqlMmrFfPugxO2ZBM2AqhL8ZhlSPdcfRzWTLoark8SjUV1jMb1aqENmZmrYxOWhQH+6WJ83STFZCOI9WBtYc/HYUyQuuusxr/KAVJaJEIbMB9dYdoColOGUUl6i7sIyo6d4fgJVRAUDphmrqseIMIga6RWkcREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1AFC4CEF1;
	Fri, 12 Sep 2025 10:14:35 +0000 (UTC)
Date: Fri, 12 Sep 2025 11:14:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v5 5/5] rqspinlock: Use smp_cond_load_acquire_timeout()
Message-ID: <aMPyiKuzGh4L4gD8@arm.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-6-ankur.a.arora@oracle.com>
 <aMLdZyjYqFY1xxFD@arm.com>
 <CAP01T74XjRJGzT7BV3PYQOQOwZVud3nL7HfcW3kzU_fPFekNHg@mail.gmail.com>
 <87o6rgk5xd.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6rgk5xd.fsf@oracle.com>

On Thu, Sep 11, 2025 at 02:58:22PM -0700, Ankur Arora wrote:
> 
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> 
> > On Thu, 11 Sept 2025 at 16:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>
> >> On Wed, Sep 10, 2025 at 08:46:55PM -0700, Ankur Arora wrote:
> >> > Switch out the conditional load inerfaces used by rqspinlock
> >> > to smp_cond_read_acquire_timeout().
> >> > This interface handles the timeout check explicitly and does any
> >> > necessary amortization, so use check_timeout() directly.
> >>
> >> It's worth mentioning that the default smp_cond_load_acquire_timeout()
> >> implementation (without hardware support) only spins 200 times instead
> >> of 16K times in the rqspinlock code. That's probably fine but it would
> >> be good to have confirmation from Kumar or Alexei.
> >>
> >
> > This looks good, but I would still redefine the spin count from 200 to
> > 16k for rqspinlock.c, especially because we need to keep
> > RES_CHECK_TIMEOUT around which still uses 16k spins to amortize
> > check_timeout.
> 
> By my count that amounts to ~100us per check_timeout() on x86
> systems I've tested with cpu_relax(). Which seems quite reasonable.
> 
> 16k also seems safer on CPUs where cpu_relax() is basically a NOP.

Does this spin count work for poll_idle()? I don't remember where the
200 value came from.

-- 
Catalin

