Return-Path: <linux-arch+bounces-8373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FF19A7064
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FD0281A8F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4AE1E0E0E;
	Mon, 21 Oct 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc5T0c5o"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4F1C330C;
	Mon, 21 Oct 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530090; cv=none; b=U0CJgLAsgoEDABlZqhvpkrCq+Kj301vFQLiXuGdcFiQXs3eEfxuCRN8Om8oWd/EMJNAqJYv6S7kld2ayzga4T5DLwHqNWWGe0JSBoIHgEG7B33pW7e88CMGgKP8m2SOoWCfMpzcH/G6h6D2misaDlViGx24py65SBqavlboFBTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530090; c=relaxed/simple;
	bh=ykBAlA5lF/Xip95YGx6pvzf/iefPqGDL1Qm98SfmVio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pfk9t8GKcdFyJpxHHzmxE/jaCDNFA6Izspzmf61YEKtUnNVJiBt3pWFwBWU/ZuCth/oaRyVJT9K1aDhuBhSnVSX9NWTnVFll6m8yCcKndunZaKwhx0jmy5OV59HVd0eHxIpoakqXVXOzUfQrHOC0y9q9tdWjKwH0K8wCuBthJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc5T0c5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF69C4CEC3;
	Mon, 21 Oct 2024 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729530090;
	bh=ykBAlA5lF/Xip95YGx6pvzf/iefPqGDL1Qm98SfmVio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uc5T0c5oIDl+NEZXEJV+MK8MYSXdzj965ZqjZbtRyjuOzq/QXX5tN0UDajUsCH5tx
	 5+PL13v0aHtQC1cJ/zpC4pTYZIg8kdti50Uv1XUSC5G5Ubt+cKUeVB9i/xVzO6IX90
	 8zBNoYPovc4LbFTKzsEZNk+S0DIkaPqGAe62SS7pS5dlhPHoh6lGWLM78/RsYNsSh0
	 nTsnAbjMZAPIbgzd7fY/Tfi/jlfdFbc+pggQFVra+ZFWiTsn+95KNUkGeILuh7GoP0
	 p4sd3gxB0Y4AidJUzGmzVXNwOxUYSXtdLly3TTWO3fFyhrDPVngYBPTe5hbIAApTo3
	 SnEOZkeZ3/DHg==
Date: Mon, 21 Oct 2024 18:01:21 +0100
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v17 07/16] tracing: Add ftrace_fill_perf_regs() for perf
 event
Message-ID: <20241021170121.GA26122@willie-the-truck>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
 <172904035199.36809.9900108557809424653.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172904035199.36809.9900108557809424653.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 16, 2024 at 09:59:12AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add ftrace_fill_perf_regs() which should be compatible with the
> perf_fetch_caller_regs(). In other words, the pt_regs returned from the
> ftrace_fill_perf_regs() must satisfy 'user_mode(regs) == false' and can be
> used for stack tracing.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> 
> ---
>   Changes in v16:
>    - Fix s390 to clear psw.mask according to Heiko's suggestion.
> ---
>  arch/arm64/include/asm/ftrace.h   |    7 +++++++
>  arch/powerpc/include/asm/ftrace.h |    7 +++++++
>  arch/s390/include/asm/ftrace.h    |    6 ++++++
>  arch/x86/include/asm/ftrace.h     |    7 +++++++
>  include/linux/ftrace.h            |   31 +++++++++++++++++++++++++++++++
>  5 files changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index d344c69eb01e..6493a575664f 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -146,6 +146,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return regs;
>  }
>  
> +#define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
> +		(_regs)->pc = arch_ftrace_regs(fregs)->pc;			\
> +		(_regs)->regs[29] = arch_ftrace_regs(fregs)->fp;		\
> +		(_regs)->sp = arch_ftrace_regs(fregs)->sp;			\
> +		(_regs)->pstate = PSR_MODE_EL1h;		\
> +	} while (0)

arm64 bit looks correct to me:

Acked-by: Will Deacon <will@kernel.org>

Will

