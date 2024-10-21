Return-Path: <linux-arch+bounces-8329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB839A5976
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 06:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFA81F221A3
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 04:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7AA1D04BB;
	Mon, 21 Oct 2024 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc/PwCKq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEDD1D0142;
	Mon, 21 Oct 2024 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484552; cv=none; b=cVdwQIN+0jsrSh3lrtR3EdZF6H5NRNt7s+hIOPXYSZereBG5sGVrKB+P+QYXNbumkXH3kbUsGbjvOgrHfU2WH908jC8p5RnSfjqZ85EK7oea57vdjyxk2q8d41c3g3LnkGfiJcVKF8PtBazUmfz+F2+lzZHAO3ALJi1zg5IM9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484552; c=relaxed/simple;
	bh=LB2z4HMXwMmYKC+HwmBhthY2Mn1M9U06se3PysQOCJE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O/8bLRA52ugyNegADGoVxmeFszGRtDqf9iJtg87ePE9VJb4xNiHxuA9jXWueSUWs2NX3S4b0lyq3NJ3jnR9zXTl7sJi5FbkcPnCfKPLYFRU0ukFFVxHnz9dQuHAqJWJwaTatGJxAQ1R+9mNP1UGu3a4S1lm3m+pKy7uRgxTzlf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc/PwCKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01AFC4CEE4;
	Mon, 21 Oct 2024 04:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729484551;
	bh=LB2z4HMXwMmYKC+HwmBhthY2Mn1M9U06se3PysQOCJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nc/PwCKqezna/K1PyI2O98zbl11kb7aY2a2lXE8AD/pSA+hvTBWUf+s3bogyLoopN
	 0k/AOWo7c7qDqd8vCf85RcbpOyxLDA9JEh8JyTGO/K0SZTbLofPMbWcMYu9aM8jx6j
	 XTNbZ446vzzH2o09b9fR4Iqmj/1XPNf9fBUNofOT2NImKrVmCgnjHWWIljgbRRp/W0
	 FqglQuy4NaN+vNdWaOVxsfrOSaHTBV7E2jDODk+XLb26S0a2AdGyIGv+YdmvvZHfrv
	 8HZE9cjWmVjfMMzRRqjYT2IMgDAFPTJqkbbVXK11afEC7h1yZ/CUOghwYNtACEXeUk
	 g/q7yb2LcNeIg==
Date: Mon, 21 Oct 2024 13:22:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v16 04/18] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-Id: <20241021132223.e3841b01cb8b449b66ebbb44@kernel.org>
In-Reply-To: <20241016083323.16801-A-hca@linux.ibm.com>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
	<172895575716.107311.6784997045170009035.stgit@devnote2>
	<20241015183906.19678-B-hca@linux.ibm.com>
	<20241016084720.828fefb791af4bcf386aac91@kernel.org>
	<20241016083323.16801-A-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 10:33:23 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Wed, Oct 16, 2024 at 08:47:20AM +0900, Masami Hiramatsu wrote:
> > On Tue, 15 Oct 2024 20:39:06 +0200
> > Heiko Carstens <hca@linux.ibm.com> wrote:
> > 
> > > That would make things much simpler... e.g. your new patch is also
> > > writing r3 to fregs, why? 
> > 
> > BTW, according to the document [1], r3 is for "return value 1", isn't it
> > used usually?
> > 
> > [1] https://www.kernel.org/doc/Documentation/s390/Debugging390.txt
> 
> That is true for the 32 bit ABI, but not for the 64 bit ABI which we
> care about. Besides other this is also the reason why I removed the
> above file five years ago: f62f7dcbf023 ("Documentation/s390: remove
> outdated debugging390 documentation").
> 
> If you really want to understand the 64 bit s390 ABI then you need to
> look at https://github.com/IBM/s390x-abi .
> 
> A PDF file of the latest release is available at
> https://github.com/IBM/s390x-abi/releases/download/v1.6.1/lzsabi_s390x.pdf
> 
> See section "1.2.5. Return Values" for return value handling.

Ah, these are the info what I searched!

> 
> All of that said, I would appreciate if you would just merge the
> provided patch, unless there is a reason for not doing that. Chances
> are that I missed something with all the recent fregs vs ptregs
> changes.

OK

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

