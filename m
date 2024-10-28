Return-Path: <linux-arch+bounces-8658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02A9B34BF
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 16:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD61C21FA8
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841AB1DE4C4;
	Mon, 28 Oct 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG6fDDcP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B41DE3D8;
	Mon, 28 Oct 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129173; cv=none; b=IhZYImHYo0Pzo7dlTjVkhj5uypKul0AAgoRO7ju4NGo2PCcAMtMcXnAOP9iM4Hrkjk54X39G08rLRbIFSEuUJ+v1+9yqsDUyo7pN10I+jE1n2WUt29cOg7gmbZ5RODYfsAu1Dk0Ktk72iFc1xKEU3ElmYDKbI09ZtVQU10C+Qbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129173; c=relaxed/simple;
	bh=PqfwNAoOXR5TNcuY52KyNkoc7gIFPoIpWIoJOF9WGzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNIubCGlqFH3cO5tdnNPeFta4FjZ+0JTWGC6o+hRe28TTz8a3w1XNKz3EroO/7O/nIQz9Euj+/9yRf+UUbIYDAqdtLh5jFunwXgurnk7+FhqtfaAukA8/4tilW7Zq15TogWBhKCDO3g+bLO43jNvR1o18I5ZCFdrstOKEYNjOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rG6fDDcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE305C4CEE4;
	Mon, 28 Oct 2024 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730129172;
	bh=PqfwNAoOXR5TNcuY52KyNkoc7gIFPoIpWIoJOF9WGzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rG6fDDcPz9sCIqiZKBmny8m9KnknWJNbHXmQ18lH8lgpCgi3PEhQUpgsQAI0pmUmr
	 YtJFjPm8pOmLIsZWBkwIdX6VhlKJWn6XTzMFAsYwMjUaTec2rmUuoMCRPmGBrk+Gw1
	 O8zISyp0ee+SDUC0mghe4dGJHFQtEq3SQWg/9ucsJLMu8ISyVDGz8BOYOR3D+e8qvc
	 Pjnup68ekm6aoVEFiUAtoX73ZJpbNRg18s4wrv4C5T9MTLO++YjjiFjxppEeYDLj8H
	 mClm4T133YUWWI//uCVnmEWikmsIBfts28CQiTcyCjkZ/lJm+uyT3uNHk6j4KuR1l8
	 xgnCFNlN9Y1jw==
Date: Mon, 28 Oct 2024 15:26:04 +0000
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
	Heiko Carstens <hca@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v18 02/17] fgraph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20241028152603.GC2484@willie-the-truck>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
 <172991734665.443985.6804196466877471135.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172991734665.443985.6804196466877471135.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Oct 26, 2024 at 01:35:46PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use ftrace_regs instead of fgraph_ret_regs for tracing return value
> on function_graph tracer because of simplifying the callback interface.
> 
> The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
> CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> ---
>  Changes in v18:
>   - Use PTREGS_SIZE instead of redefining FRAME_SIZE on i386.
>  Changes in v17:
>   - Fixes s390 return_to_handler according to Heiko's advice.
>  Changes in v16:
>   - According to the recent ftrace_regs.h change, override
>     ftrace_regs_get_frame_pointer() if needed.
>   - s390: keep stack_frame on stack, just replace fgraph_ret_regs
>     with ftrace_regs.
>  Changes in v8:
>   - Newly added.
> ---
>  arch/arm64/Kconfig                  |    1 +
>  arch/arm64/include/asm/ftrace.h     |   23 ++++++-----------------
>  arch/arm64/kernel/asm-offsets.c     |   12 ------------
>  arch/arm64/kernel/entry-ftrace.S    |   32 ++++++++++++++++++--------------

For the arm64 bits:

Acked-by: Will Deacon <will@kernel.org>

Will

