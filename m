Return-Path: <linux-arch+bounces-8659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A299B34C3
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 16:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DDD1F22AB8
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9841DE3C7;
	Mon, 28 Oct 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+FPVnAD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9E1D9324;
	Mon, 28 Oct 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129230; cv=none; b=iAXaVOEFTTWgtHgPDoByL8WP0WkZDbigxHAOnLBuY3CVwhpggYfgloy4IPocAlhmQA3JAR+o4Ot9BOwz/sdVS1OOqn15ZYlJseivf+sxwShoxzyrNaa8Rtie+rkDZRDTPgZR6ExuMSPuIMnvNk131of3IQKwN74rDN5/ZXn8GE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129230; c=relaxed/simple;
	bh=+32x8F2klkIYlYnnknN/8nNQ3cVmUi1lWcYeG5QzytQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCRLXNWqb+lFEBfxIO5ZCu/jxyvaQLbpAMz12akW6m/LrVG9RAO4LrqcMdRlqLbNi1XN64OOmxytk0nO4Bgj2tahxf9XbnoVvKJWojhyr3w5fi00V6wYcHij2nWrSKkhP6442Y3NTz1IzWJryWbGAyqxRkRyZtOVbMyfbPgHFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+FPVnAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAECC4CEC3;
	Mon, 28 Oct 2024 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730129229;
	bh=+32x8F2klkIYlYnnknN/8nNQ3cVmUi1lWcYeG5QzytQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+FPVnADYc/xiutKjw+8Oq3Cj3FCAvTOr7SZYidMPuzpzj80Z5cVVyGbQ9Wsd85TL
	 SXYRsrD6JDEi/TD3AEngsNP9fjGsXhl+KetEnOeZ72+4vsNWe6uCCNDp3gsxQ7QCVl
	 HvzeCHytXh+UNx0+fviH6+N2xTzz5DoEbTy8L0OQw3AxGuXNLvU63ymtg4GuZsK0pg
	 hYE/B9lG/BVw3KxRkhSyOGka8HtAXfZ3KqT4lF24gHpbhKkCgjeep0JxfFfVoYzLLm
	 5Met1n23ErS6MnjfUxmzV22hNxRb3RDdcSOv71W7W3fg3zSVm0fy0zV/lhwIpIyQNV
	 aKHRWjOzmpxvg==
Date: Mon, 28 Oct 2024 15:27:03 +0000
From: Will Deacon <will@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v18 06/17] tracing: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-ID: <20241028152702.GD2484@willie-the-truck>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
 <172991739940.443985.12363344022031875406.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172991739940.443985.12363344022031875406.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Oct 26, 2024 at 01:36:39PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> This is for the eBPF which needs this to keep the same pt_regs interface
> to access registers.
> Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
> used by kprobe_multi eBPF event), this will be used.
> 
> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Florent Revest <revest@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> 
> ---
>  Changes in v18:
>   - Fix to use sizeof() for calculating array size.
>  Changes in v14:
>   - Add riscv change.
>  Changes in v8:
>   - Add the reason why this required in changelog.
>  Changes from previous series: NOTHING, just forward ported.
> ---
>  arch/arm64/include/asm/ftrace.h |   13 +++++++++++++

For the arm64 bits:

Acked-by: Will Deacon <will@kernel.org>

Will

