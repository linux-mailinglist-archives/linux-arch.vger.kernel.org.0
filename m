Return-Path: <linux-arch+bounces-13346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6299CB3E18E
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EB916D742
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF18731AF0A;
	Mon,  1 Sep 2025 11:30:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72931A07F;
	Mon,  1 Sep 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726205; cv=none; b=sSvp+Cgv3zQmFYDO8GcbhHP7etmt6YvltLwB59Ysoi3xFl+4o8MMraPTUQCEm2KzOmmdoBbM3BbsQTshuWiNvLw21+k13sKkz9ue2cPOvfKK2ozX+g+c70nJ+lgHCp5GL0fhVT2o+9f478iuV+GeyGztiwFiaIT6qx05+5mowLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726205; c=relaxed/simple;
	bh=QaH7ld6cnJMyrbfR+vt6d6FlkH48cKYHQBNDkSgN+5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDTjQkjC2OuTlPkT6DKHx7abkjkHCBa78xBt65K3ZHxDqY3E3OxD4GUmnn+v/ZgqJxeTlj/pBVrD/xyqg3XD0/CnV3thz2GC5bFm6XhezXpXcr9fDYRx5W1tOWlHkVMcd9xQa8fByF6hTd/ju1K9QBaTUs4ikny8rhkZTWiFGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9EEC4CEF0;
	Mon,  1 Sep 2025 11:30:02 +0000 (UTC)
Date: Mon, 1 Sep 2025 12:29:59 +0100
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
Subject: Re: [PATCH v4 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
Message-ID: <aLWDt9NpfYO_Utky@arm.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829080735.3598416-2-ankur.a.arora@oracle.com>

On Fri, Aug 29, 2025 at 01:07:31AM -0700, Ankur Arora wrote:
> Add smp_cond_load_relaxed_timewait(), which extends
> smp_cond_load_relaxed() to allow waiting for a finite duration.
> 
> The additional parameter allows for the timeout check.
> 
> The waiting is done via the usual cpu_relax() spin-wait around the
> condition variable with periodic evaluation of the time-check.
> 
> The number of times we spin is defined by SMP_TIMEWAIT_SPIN_COUNT
> (chosen to be 200 by default) which, assuming each cpu_relax()
> iteration takes around 20-30 cycles (measured on a variety of x86
> platforms), amounts to around 4000-6000 cycles.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Apart from the name, this looks fine (I'd have preferred the "timeout"
suffix).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

