Return-Path: <linux-arch+bounces-8245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618BD9A15B2
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 00:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6835C1C219B6
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 22:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EE91D2F66;
	Wed, 16 Oct 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ7EFYQG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B845008;
	Wed, 16 Oct 2024 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116926; cv=none; b=u62JrtF+zgUcMOjQBPumMIvKTqEiErFPdDY929Y8c2HLyaXjwGoewnuCeFpXSCATNn5dQ0wgLT+zzfrlDPjkIxq0BfmAgCXeLPpDO/PaZNT4GbZh3tTB15HSO9e839MgoB+xI6rNmOVaO8FRvktN8yYQJMiHgP4cdPSae2O8Bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116926; c=relaxed/simple;
	bh=kTS3L4lI/mgAWvx8mcJRAk114PqILHt4bMeyJslU/4o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SowXgZYRbfHXlERJteAy0gC6+PXRf3V2P+QzNfLAYb4JEfl1vRk931wrBTY8KAwbAj7GjcFNMIa9Y2u2NSF8wxFIjTXhqiExzuWJJ5y7992rmYRXqEHvJPbW7/SDGwVvgipsuFp4btIoIBlJo3E+5ksHepckIehh6y86hT/bXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ7EFYQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FDCC4CEC5;
	Wed, 16 Oct 2024 22:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729116925;
	bh=kTS3L4lI/mgAWvx8mcJRAk114PqILHt4bMeyJslU/4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oZ7EFYQGKJwCD1UnwDRHAzfkYRWKUr6T3xWM4xAxq5UMLPLziit8tzepdK7RQE8le
	 NnDb7RtAIl1Fq/uiX2rvNdb38dfuFsaM1A1C8yVwNBtjyuMbo6QryYta2MzqVe55LK
	 mXtfxAwLZHx+Bp5TUduVGGsgZRYKQVATA4Y1gXNe7eOs+DdWPErXodiMVx09oCG1Ko
	 c4E9yTD0ksPDbY3YY3Cbkklgg7o8edV9+iJ8G0WkDyZuPh3tntPDWfy2P4p98APcVL
	 Nv1447Is9HSU19y04eSTaerhVGN89TlnITW7fmN0yVzYe0innvCvkNywzGodmw9SXC
	 eNCSX7rWRcfTA==
Date: Thu, 17 Oct 2024 07:15:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v17 01/16] function_graph: Pass ftrace_regs to entryfunc
Message-Id: <20241017071516.684c8cf6490f26a42065994d@kernel.org>
In-Reply-To: <20241016095325.34176fc9@gandalf.local.home>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904027515.36809.1961937054923520469.stgit@devnote2>
	<20241016095325.34176fc9@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 09:53:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 16 Oct 2024 09:57:55 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Pass ftrace_regs to the fgraph_ops::entryfunc(). If ftrace_regs is not
> > available, it passes a NULL instead. User callback function can access
> > some registers (including return address) via this ftrace_regs.
> 
> BTW, you can use "fgraph:" for short. It makes the subject easier to read.
> I've been using that instead of "function_graph:" lately.

OK, I'll use it in the next version.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

