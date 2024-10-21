Return-Path: <linux-arch+bounces-8355-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624259A6DDA
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072F21F223DC
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C478C8B;
	Mon, 21 Oct 2024 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6hB2/iB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224576A8D2;
	Mon, 21 Oct 2024 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523744; cv=none; b=QMgPg1DLETwUtOj7lF7xkqdhCDihBlL81bntJkzLscoKEih1/p44fONu+XTQWEz7XL1k/7qIgMIzmjckCZI1wY792GLxnQCDsVm2g05EZFR+fwtOqgO/Tf21NIayuGPBVuc+ColHzteJECKKM8Sv+PHC/DHPLnefE1j29k/Ogsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523744; c=relaxed/simple;
	bh=3Ie81PJaB3Z2D/AicTp4yUNXRV46tqz0pVjMH/bKZBU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Dunf1B/pOdTRN1DOPbliJ02XjZDBUJ/sNJWYIU7Wbfr69MyHCzvZE3GqPfynXH5ezPLOTnHYnMWUCsSKx3vMhuJNucQCqtz16X8x3lg8ezNZ9w0GvXI2nIwY1tbcg5uTd2iMnjwQvYp63DvLZgFZYtiiNAZICRsTI50h9RWTDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6hB2/iB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93016C4CECD;
	Mon, 21 Oct 2024 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523743;
	bh=3Ie81PJaB3Z2D/AicTp4yUNXRV46tqz0pVjMH/bKZBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O6hB2/iB4wLSkH+h4kqg9A82MI6C6IV/Jv5g90mM8cP4PlUevnewputwtJBeguYBB
	 ltrz1sjQxRpcFOYGuHOL+ughjbvCW5qRRlIMGoY4EPHgHL1Qo8XZZIV1jlQuaY52rb
	 p2NjWr0hYlHUeJinima3br77dEtuQysAuE4hhjcgNJWKraMq83QbOSNYYFcK+Es1D4
	 OuwPPrE5Dp0Y7rba+PMbIYfJRQ+I2XEfIgX8mwI+09jxh7MW62PR3NBhgnoDqRcAaL
	 V1WlHRu/ywpY2YElacTzveP2eCaR6BS0b5dinhgMAnhkpRhkcGdqZei7LtAua/+j9p
	 GZwVnrgH2NZrA==
Date: Tue, 22 Oct 2024 00:15:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle
 <svens@linux.ibm.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
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
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v17 11/16] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20241022001534.96c0d1813d8f4a26563d4663@kernel.org>
In-Reply-To: <20241018124952.17670-E-hca@linux.ibm.com>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904040206.36809.2263909331707439743.stgit@devnote2>
	<yt9ded4gfdz0.fsf@linux.ibm.com>
	<20241016101022.185f741b@gandalf.local.home>
	<20241018124952.17670-E-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 14:49:52 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Wed, Oct 16, 2024 at 10:10:22AM -0400, Steven Rostedt wrote:
> > On Wed, 16 Oct 2024 14:07:31 +0200
> > Sven Schnelle <svens@linux.ibm.com> wrote:
> > > I haven't yet fully understood why this logic is needed, but the
> > > WARN_ON_ONCE triggers on s390. I'm assuming this fails because fp always
> > > has the upper bits of the address set on x86 (and likely others). As an
> > > example, in my test setup, fp is 0x8feec218 on s390, while it is
> > > 0xffff888100add118 in x86-kvm.
> > 
> > Since we only need to save 4 bits for size, we could have what it is
> > replacing always be zero or always be f, depending on the arch. The
> > question then is, is s390's 4 MSBs always zero?
> > 
> > Thus we could make it be:
> > 
> > static inline int decode_fprobe_header(unsigned long val, struct fprobe **fp)
> > {
> > 	unsigned long ptr;
> > 
> > 	ptr = (val & FPROBE_HEADER_PTR_MASK) | FPROBE_HEADER_MSB_MASK;
> > 	if (fp)
> > 		*fp = (struct fprobe *)ptr;
> > 	return val >> FPROBE_HEADER_PTR_BITS;
> > }
> > 
> > And define FPROBE_HEADER_MSB_MASK to be either:
> > 
> > For most archs:
> > 
> > #define FPROBE_HEADER_MSB_MASK	(0xf << FPROBE_HEADER_PTR_BITS)
> > 
> > or on s390:
> > 
> > #define FPROBE_HEADER_MSB_MASK	(0x0)
> > 
> > Would this work?
> 
> This would work for s390. Right now we don't make any use of the four
> MSBs, and they are always zero. If for some reason this would ever
> change, we would need to come up with a different solution.

Ah, so fill with zero works for s390 kernel. Thanks for the info.

> Please note that this only works for addresses in the kernel address
> space. For user space the full 64 bit address range (minus the top
> page) can be used for user space applications.

I wonder what is the unsigned long size (stack entry size) of the
s390? is it 64bit?

> I'm just writing this
> here, just in case something like this comes up for uprobes or
> something similar as well.

I'm considering another solution if it doesn't work. Of course if
above works, it is the best compression ratio.

This is only if it doesn't work, we can consolidate a set of
fprobe header in N + 1 entries as

0: [# of fprobes(4bit)|4bit array of sizes]
1: [fp 1]
2: [fp 1 data]
...

So if we have 3 fprobes on the same entry and has 0, 3, 2 data size, then

0:[3|0|3|2|0...0]
1:[fp1]
2:[fp2]
3:[fp2 data 1]
4:[fp2 data 2]
5:[fp2 data 3]
6:[fp3]
7:[fp3 data 1]
8:[fp3 data 2]

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

