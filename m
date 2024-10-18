Return-Path: <linux-arch+bounces-8261-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7959A31C1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 02:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB20B21A7A
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 00:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C72A1D1;
	Fri, 18 Oct 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZgSZEye"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB920E313;
	Fri, 18 Oct 2024 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729212362; cv=none; b=pNillFMMcAtGnlFGir8UxUmKJjF4BoO1bre0BRdfCO3ScM3v+8zyly8kFVNATJiMRJJexpN8neReMrHgVn3iYwDCfN3NVMw1VZgnjCALgFao/QHcrcYpMJj+0DTqOhSE7afyxpqS2sCXtnMXO+wLGfGJXob8z7Mg9xgAR2C+ZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729212362; c=relaxed/simple;
	bh=UuU1D4ZoMYwCo3FaOUKYe9aNpKCvXsi0ygQ+g1tksnw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S8V0ya1z3mb4GKa7lAyI2hUtDIhxvGJW4nEWnsBex7kJnjf4s8P817j+L32KePRZJFf0yyfyDpQf0WGwKm5Uybq266YfMra66DG2/ka6DfamttQu066WRHN6YKygNpIsCAKewO34WepKP1fuAEKVU5yDoRcTLcgf4ocmvq/NxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZgSZEye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB77C4CEC3;
	Fri, 18 Oct 2024 00:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729212361;
	bh=UuU1D4ZoMYwCo3FaOUKYe9aNpKCvXsi0ygQ+g1tksnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SZgSZEyeLeDjdg+a3yDy4ijjwEMTCURbIgWJjUahT1DsKQ6Q5LgHxuo1vt2qEfMRT
	 SmnTjEetvqT/hIDqBPfjHuJNOlvYMtfv13cBsMGouBUGePOoT9E2WdfJJiGJXGWxJ2
	 y1zP01dkxAykdBPGUho2gD7sMLc3fAghEFzegeBtqss7Mpd2+n1W2Rup8slKnESU6L
	 n/AyawZhiA/OZ92Z3Ux6rq8KkgC/PKIHnjeujCP6DJjZK3t7S6xg8++DjwJogSKzca
	 JqQrPbomenBEeM/5PFpA/kQHVR9Y3To5WHMLGLO9HI5v/xjIYvsuYDdE4TdL2WVulj
	 pnirejbBXWrjA==
Date: Fri, 18 Oct 2024 09:45:51 +0900
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
Message-Id: <20241018094551.b7fd8a75964545bf72eb335c@kernel.org>
In-Reply-To: <yt9d5xprgbj5.fsf@linux.ibm.com>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904040206.36809.2263909331707439743.stgit@devnote2>
	<yt9ded4gfdz0.fsf@linux.ibm.com>
	<20241016234628.b7eba1db0db39d2197a2ea4f@kernel.org>
	<yt9d5xprgbj5.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 20:14:54 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> 
> > On Wed, 16 Oct 2024 14:07:31 +0200
> > Sven Schnelle <svens@linux.ibm.com> wrote:
> >> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> writes:
> >> I think that still has the issue that the size is encoded in the
> >> leftmost fields of the pointer, which doesn't work on all
> >> architectures. I reported this already in v15
> >> (https://lore.kernel.org/all/yt9dmsjyx067.fsf@linux.ibm.com/)
> >
> > Oops, thanks for reporting. I should missed that.
> >
> >> I haven't yet fully understood why this logic is needed, but the
> >> WARN_ON_ONCE triggers on s390. I'm assuming this fails because fp always
> >> has the upper bits of the address set on x86 (and likely others). As an
> >> example, in my test setup, fp is 0x8feec218 on s390, while it is
> >> 0xffff888100add118 in x86-kvm.
> >
> > Ah, so s390 kernel/user memory layout is something like 4G/4G?
> > Hmm, this encode expects the leftmost 4bit is filled. For the
> > architecture which has 32bit address space, we may be possible to
> > use "unsigned long long" for 'val' on shadow stack (and use the
> > first 32bit for fp and another 32bit for size).
> >
> > Anyway, I need to redesign it depending on architecture.
> 
> Could you explain a bit more what redesign means? Thanks!

This "encoded" data is for recording the *fp (the address of fprobe)
and its data size into one value and storing it on the shadow stack.

On x86-64, the kernel objects are puts on the highest memory address,
thus the highest bits are always same. So it uses 4bits for recording
the data size. Most of other 64bit architecture are similar memory
layout, so we can use the highest bits. Note that the data size must
be a multiplier of u64 (== 8byte), so 4bits is enough since shadow
stack size is limited.

The s390 and other 32bit address space architectures need special
care for it. Thus I think we can use 2 slots (= 2 * u32) for saving
data in this case.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

