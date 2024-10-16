Return-Path: <linux-arch+bounces-8233-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A49A0BF7
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 15:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142681F2709A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369820C001;
	Wed, 16 Oct 2024 13:53:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E743208218;
	Wed, 16 Oct 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086788; cv=none; b=fDi1Q4sWfwDIvoTSG7GBkR/48j4Iajr2Wn3rYAIOz/qCp49DjgQRxMSQZyXKBr13PAYg68DgwhLt/1TKkROdymnShgY0zc+Jck3K4KtqAhSrOiXhPvrqXwR/BbVDSll7SASGhl5fkAFgFz8axyVluwWAd0ZtJ6i01N4G0wqpPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086788; c=relaxed/simple;
	bh=llRM8LXgQjs7u3YzkvDWIV3qro+G7it7abwfexDEsFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lU9pf+UmAI7C3JwiGEObDchL+awe9u41YcVX8AXkLfGXIirLk9YZSt97HLarg3xyTs3WkqujpaUaGnEEPENGf9vxKYOKc+Ja9mCho6fLiRjJV+jevFcDgIbstPpSUUa1odYIj0zYgZEDcQvwlP+ZTMiEYM1G+UPvuCNyDjRfWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4154C4CEC5;
	Wed, 16 Oct 2024 13:53:04 +0000 (UTC)
Date: Wed, 16 Oct 2024 09:53:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Message-ID: <20241016095325.34176fc9@gandalf.local.home>
In-Reply-To: <172904027515.36809.1961937054923520469.stgit@devnote2>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904027515.36809.1961937054923520469.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 09:57:55 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Pass ftrace_regs to the fgraph_ops::entryfunc(). If ftrace_regs is not
> available, it passes a NULL instead. User callback function can access
> some registers (including return address) via this ftrace_regs.

BTW, you can use "fgraph:" for short. It makes the subject easier to read.
I've been using that instead of "function_graph:" lately.

-- Steve

