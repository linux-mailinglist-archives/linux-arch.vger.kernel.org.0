Return-Path: <linux-arch+bounces-8237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C4A9A0D25
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EE01C24B90
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C43E209F41;
	Wed, 16 Oct 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIdv5kx5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C809107A0;
	Wed, 16 Oct 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089998; cv=none; b=sLNmRzZ1Fs643vT33+rXWbmWP97aL6Ox+/7/JZ3NpqwbTqqtB+DSwtTayt4giuMHIlyxLw0aQw7GAxjDDP1JfkTjrj0VCq36V8+P2OVXm6rM9BYZhuG9+0HapGxeWINVg8EQUSpUB/m5rCyJUQb8n4c2PVAWA26zUV6pubBLvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089998; c=relaxed/simple;
	bh=mljYCOrfn5VQtElax+itf5albGe4NataoyAA9ei5XS0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oUTZRCOJ2IVtylNk2rEGMScadddQxgx09X8eWVEIA5nD1Tf6Z3bVpqOWUY3ZIk8Komcaah3iDAkQHMhs4xu/5FqwDaYguCqLB6kN/lZvhpv45eX10ffrlVhkhlhnMbDLqr7joulDAOjBu/pA2mdCGpcncfhWrgQvsy0YF+Y9qdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIdv5kx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEA2C4CEC5;
	Wed, 16 Oct 2024 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729089997;
	bh=mljYCOrfn5VQtElax+itf5albGe4NataoyAA9ei5XS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qIdv5kx5nL1uiUMFTWI4/g1kr2RmcIUz2PWR2nPj5ad9+BcYPT7FFYjgrplSiTegr
	 uDlQmEFKE4fB0/2dM1exBAkFhNxEFqJuefV5ak9q9//SjvXC71Ftc47f255bdLeaFI
	 /FDhrTCCXPJNtt6sWam8Ub0lknZDrpWmt9inpfqypdT4kcQZvdmmdtqhO7Qs/n/2Sl
	 3c0OvvYyTp8VFqN6PdbwWzjgIuNkRLaxD+RlpVULp+uCtmWU6o0eO6pFe6OEoXATtz
	 vhc2500888Fsi//9NZI/NyNGDrlyfZjtIhFS9jm6xdruRLUqXTTWuzX6EEjfg7jpNl
	 9gx958sT8Jqig==
Date: Wed, 16 Oct 2024 23:46:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen
 N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v17 11/16] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20241016234628.b7eba1db0db39d2197a2ea4f@kernel.org>
In-Reply-To: <yt9ded4gfdz0.fsf@linux.ibm.com>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904040206.36809.2263909331707439743.stgit@devnote2>
	<yt9ded4gfdz0.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 14:07:31 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> writes:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Rewrite fprobe implementation on function-graph tracer.
> > Major API changes are:
> >  -  'nr_maxactive' field is deprecated.
> >  -  This depends on CONFIG_DYNAMIC_FTRACE_WITH_ARGS or
> >     !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS, and
> >     CONFIG_HAVE_FUNCTION_GRAPH_FREGS. So currently works only
> >     on x86_64.
> >  -  Currently the entry size is limited in 15 * sizeof(long).
> >  -  If there is too many fprobe exit handler set on the same
> >     function, it will fail to probe.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: WANG Xuerui <kernel@xen0n.name>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: Naveen N Rao <naveen@kernel.org>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> >
> [..]
> 
> > diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> > index ef609bcca0f9..2d06bbd99601 100644
> > --- a/include/linux/fprobe.h
> > +++ b/include/linux/fprobe.h
> > @@ -5,10 +5,11 @@
> [..]
> > +static inline unsigned long encode_fprobe_header(struct fprobe *fp, int size_words)
> > +{
> > +	if (WARN_ON_ONCE(size_words > MAX_FPROBE_DATA_SIZE_WORD ||
> > +	    ((unsigned long)fp & ~FPROBE_HEADER_PTR_MASK) !=
> > +	    ~FPROBE_HEADER_PTR_MASK)) {
> > +		return 0;
> >  	}
> > +	return ((unsigned long)size_words << FPROBE_HEADER_PTR_BITS) |
> > +		((unsigned long)fp & FPROBE_HEADER_PTR_MASK);
> > +}
> > +
> > +/* Return reserved data size in words */
> > +static inline int decode_fprobe_header(unsigned long val, struct fprobe **fp)
> > +{
> > +	unsigned long ptr;
> > +
> > +	ptr = (val & FPROBE_HEADER_PTR_MASK) | ~FPROBE_HEADER_PTR_MASK;
> > +	if (fp)
> > +		*fp = (struct fprobe *)ptr;
> > +	return val >> FPROBE_HEADER_PTR_BITS;
> > +}
> 
> I think that still has the issue that the size is encoded in the
> leftmost fields of the pointer, which doesn't work on all
> architectures. I reported this already in v15
> (https://lore.kernel.org/all/yt9dmsjyx067.fsf@linux.ibm.com/)

Oops, thanks for reporting. I should missed that.

> I haven't yet fully understood why this logic is needed, but the
> WARN_ON_ONCE triggers on s390. I'm assuming this fails because fp always
> has the upper bits of the address set on x86 (and likely others). As an
> example, in my test setup, fp is 0x8feec218 on s390, while it is
> 0xffff888100add118 in x86-kvm.

Ah, so s390 kernel/user memory layout is something like 4G/4G?
Hmm, this encode expects the leftmost 4bit is filled. For the
architecture which has 32bit address space, we may be possible to
use "unsigned long long" for 'val' on shadow stack (and use the
first 32bit for fp and another 32bit for size).

Anyway, I need to redesign it depending on architecture.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

