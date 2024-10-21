Return-Path: <linux-arch+bounces-8369-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41219A6FF8
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 18:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4CC1F21461
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBE31CCB48;
	Mon, 21 Oct 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKNOhmDx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59547A73;
	Mon, 21 Oct 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529186; cv=none; b=d6e5bLSM7wJlZwdQNFgeJEIyRexNHtDeDRCzXmiKyfSJ0bZQTCRz5tb7BzGSiQ0Mu9OErQtRCeYjzq6SPGe7tZuSz/MQAK/dBANDikLUL3FjkvyDmnxePFkCZKUh3ZuTgeEyCS33JsHZ9kYiBaZkrYp+0gyxYx7TjLY8t4D4xD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529186; c=relaxed/simple;
	bh=1IvwFyJO5G6uPFyqk4eFCgXupz6ovtKZgtus88TpOUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn6iO/rIH33DgfhpRscTml01wq7GmaxtiFBeFBfYk7p0L3nmmsqBYRwbKAfps2954b3YnACiVsFMpdrN58wsGOIuFRG8eax7ePX36PkkIFJwiiFmd/lNd0Wg7VteOS+xQDymd5+V+wOIVu6E16A8Uwe2LAdIU6GbJoDyFs3cd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKNOhmDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330AFC4CEE8;
	Mon, 21 Oct 2024 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729529186;
	bh=1IvwFyJO5G6uPFyqk4eFCgXupz6ovtKZgtus88TpOUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKNOhmDxSGiQOSU4y0DFhd4/wlkafd5+oThw33psGOoR9EBLup1HK/73JoSjw+XoZ
	 /9RgeDRS4ONoJDIsgpq9MK08IBM3pYl6Meoh8xfeMs/7yDNzRWbOZXRXStOrXPF3M8
	 kKGhdH+f7wh4m4UQLFjgk6AuX0rd1QafsE/dJH6PNPP/QBSrr6mwXIz7G+SBDjV7X1
	 ux85+XGQgOgc9HIlzBxfDPK7WO/l8UQD0b/jgo1/AG0QAdvizrxgeAuqBURLHlsVpw
	 zxUNKYXN+MAL2de2/Xq+MrfYJvfVHcglKoka5jSS/HBRfSZSOnYwqdyg5xMxbFw/tF
	 n3qdSZb4U/k7g==
Date: Mon, 21 Oct 2024 17:46:19 +0100
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
Subject: Re: [PATCH v17 06/16] tracing: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-ID: <20241021164619.GA26073@willie-the-truck>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
 <172904034052.36809.10990962223606196850.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172904034052.36809.10990962223606196850.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 16, 2024 at 09:59:00AM +0900, Masami Hiramatsu (Google) wrote:
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
>  Changes in v14:
>   - Add riscv change.
>  Changes in v8:
>   - Add the reason why this required in changelog.
>  Changes from previous series: NOTHING, just forward ported.
> ---
>  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
>  arch/riscv/include/asm/ftrace.h |   14 ++++++++++++++
>  include/linux/ftrace.h          |   17 +++++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index b5fa57b61378..d344c69eb01e 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -135,6 +135,17 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
>  	return arch_ftrace_regs(fregs)->fp;
>  }
>  
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	memcpy(regs->regs, arch_ftrace_regs(fregs)->regs, sizeof(u64) * 9);

Since ftrace_regs::regs is an 'unsigned long regs[9]' can we just use
sizeof() on that instead of hard-coding the length of the array here?

Will

