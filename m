Return-Path: <linux-arch+bounces-6161-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D134394EB4F
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 12:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7285E1F222AD
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00AF16F909;
	Mon, 12 Aug 2024 10:39:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF116F0F0;
	Mon, 12 Aug 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459198; cv=none; b=L1wXPyRQLOC7qMgYwqbrI6VU35Y4yhyffiefZaEWbavf2NDiAJyaUMI6GgukOJKBEpb4yl4Z2/xYk5+NWmSayLYjozCK4fwErPg+jCi4YhomDJooIlNpwP20faH+p9/gG0Hh4poH3mEDO6LkLlvzmI7CfLifaPGJoAiV+u2heXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459198; c=relaxed/simple;
	bh=7yshrb7EAQvkzk5Q9ETU2xj918YJqk3szZ2wdaNW8S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcWINXp1HJM3up8stBzbAJ7vE/A4AOr3QW4leznZDAWVACvI2OEZE7REQwIKlgl57LFU3t396z6i80KJiCaNu1UcZa8SrFG3upbRLgUtrKRHS9E+E5mPE7/uLJyCuK/lJmF/+dwZ6vq/r25G+EtKeg7UdiytZlltlsBXLIIbNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A66C32782;
	Mon, 12 Aug 2024 10:39:54 +0000 (UTC)
Date: Mon, 12 Aug 2024 11:39:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH -next v2] crash: Fix riscv64 crash memory reserve dead
 loop
Message-ID: <ZrnmeKCgHc1XgUdU@arm.com>
References: <20240812062017.2674441-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812062017.2674441-1-ruanjinjie@huawei.com>

On Mon, Aug 12, 2024 at 02:20:17PM +0800, Jinjie Ruan wrote:
> On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
> will cause system stall as below:
> 
> 	 Zone ranges:
> 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
> 	   Normal   empty
> 	 Movable zone start for each node
> 	 Early memory node ranges
> 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
> 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
> 	(stall here)
> 
> commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
> bug") fix this on 32-bit architecture. However, the problem is not
> completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> architecture, for example, when system memory is equal to
> CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:
> 
> 	-> reserve_crashkernel_generic() and high is true
> 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
> 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
> 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> 
> As Catalin suggested, do not remove the ",high" reservation fallback to
> ",low" logic which will change arm64's kdump behavior, but fix it by
> skipping the above situation similar to commit d2f32f23190b ("crash: fix
> x86_32 crash memory reserve dead loop").
> 
> After this patch, it print:
> 	cannot allocate crashkernel (size:0x1f400000)
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

