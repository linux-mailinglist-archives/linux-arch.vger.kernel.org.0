Return-Path: <linux-arch+bounces-9456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD1E9F9510
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 16:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196AE16A80D
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73879218ABC;
	Fri, 20 Dec 2024 15:08:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4373B791;
	Fri, 20 Dec 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707298; cv=none; b=FFhIvivfD8x9Q9c4YU6YrBKTl5ToLCXEeHeswcLhL+xKe/IIzsBUixnqd5rsthaqIvmIhichULO75MYCVb9Z19AXakp1zx4VAuQa41g6rpBMy0VdVJoMkgwEfcjLQhOFP/8PLnAw28+US0k1x0NnqwlNlExYBN26xShoH/TvDk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707298; c=relaxed/simple;
	bh=tELedgPU/p+PB7SMxOQXyZszI7vj7VOGC/D7C6tBVYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eovNAGWc8T/sRDRmQbGOCoFxLJcTwutgcIy7n5EbsAMD7h9yU2a2aAfRR8ayrLHsUQ1O7ILzGrEISkObsC1MRguHrD7uTah41clQsreKPsODNAEI70KsEUgSt4O6WSmjScnTqhrX0bJoM93zBp8jzt9OZehuNFsKjXFnd4XSiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7278BC4CECD;
	Fri, 20 Dec 2024 15:08:13 +0000 (UTC)
Date: Fri, 20 Dec 2024 10:08:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v21 03/20] fgraph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20241220100856.1a436ad3@gandalf.local.home>
In-Reply-To: <20241220145156.12646-B-hca@linux.ibm.com>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
	<173379656618.973433.13429645373226409113.stgit@devnote2>
	<20241219163448.7fe08f79@gandalf.local.home>
	<20241220145156.12646-B-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 15:51:56 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Thu, Dec 19, 2024 at 04:34:48PM -0500, Steven Rostedt wrote:
> > On Tue, 10 Dec 2024 11:09:26 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >   
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Use ftrace_regs instead of fgraph_ret_regs for tracing return value
> > > on function_graph tracer because of simplifying the callback interface.
> > > 
> > > The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
> > > CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> > > 
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Acked-by: Heiko Carstens <hca@linux.ibm.com>  
> > 
> > Did Heiko ack this? I don't see it in my inbox.  
> 
> Yes, I did:
> https://lore.kernel.org/lkml/20240916121656.20933-B-hca@linux.ibm.com/

Oh OK. I didn't go back that far as it appeared you questioned this patch
in v16:

  https://lore.kernel.org/all/20241016083323.16801-A-hca@linux.ibm.com/


> 
> > Heiko,
> > 
> > Does the above look OK to you?  
> 
> Looks still good to me.

Thanks, I'll likely pull in the series after rc4 and get it ready for
linux-next.

-- Steve

