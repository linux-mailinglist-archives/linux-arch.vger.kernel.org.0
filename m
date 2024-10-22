Return-Path: <linux-arch+bounces-8415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CB69A9DC2
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 11:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3ECFB233E0
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8F1547E9;
	Tue, 22 Oct 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmc7OXB6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285D22083;
	Tue, 22 Oct 2024 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587655; cv=none; b=brpUUhUpShsfmn0xAkVpO72EHZNkgQ86OnBApUokXpqdyqNji9hXAhGz2aClwquI0Wy/hZIMGr1Os1ZGkEfT25KNp/6S7zBQLZSFvF+BAkwdzT8+vHNzacC2bQksqRPv33StpA8b3uALa+Ucu4HmU20GvJvA3dsD0/oZW9Q5d1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587655; c=relaxed/simple;
	bh=o2gQumhbj6TkS5MexAl/H7osNUxHltKph93k317WY0E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LQaAZyJrkW6A3hTt6S7eg7T5zbbafF7rrPaejgaAoVNssEdQg2arwYQAe+MebfXJDWn/srbAKCZRjwfX1O8lwH4g+UwNNbzlTwUfuq83VUJda1O13/U6bzdaW6fmXcadSJx90avPwZduktLZe4ZuYGS6sq93fGl/ZjWoshxpELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmc7OXB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72ADC4CEC3;
	Tue, 22 Oct 2024 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729587654;
	bh=o2gQumhbj6TkS5MexAl/H7osNUxHltKph93k317WY0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmc7OXB6Rjh0AoWjy/yY8nCzBsfAGKwJDKN44cc2mEv4XMleapb3V2vG0/x5UlgDH
	 cACO0vjU5DoaVsQfHijEyV+AaCk6OOaDIIa6Lak5AMVzwscJgqxri7skeNMGbipgZK
	 NfY/fn6OPlK7H7RUBCnlsGvhB0Ps+ps+dAY5LZizpjCq5jp9Mh6f9UTJ2/ggJKq4qS
	 QHQzcIg/bQJinymcnO0uD8dOvZ6XM+X8l745BL9J0GzXtgWLerVIia2GfUFSdT86Zv
	 VINSmPwqFA2dXifsqPdTGzp1EPbNhCQxpH1CI+eLRoDnriC0eTs382KxghonoZszGJ
	 ehwpfosZG8/TA==
Date: Tue, 22 Oct 2024 18:00:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen
 N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v17 11/16] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20241022180048.989a3470b23ed34d048b246a@kernel.org>
In-Reply-To: <20241021163139.6950-F-hca@linux.ibm.com>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904040206.36809.2263909331707439743.stgit@devnote2>
	<yt9ded4gfdz0.fsf@linux.ibm.com>
	<20241016101022.185f741b@gandalf.local.home>
	<20241018124952.17670-E-hca@linux.ibm.com>
	<20241022001534.96c0d1813d8f4a26563d4663@kernel.org>
	<20241021163139.6950-F-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 18:31:39 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> > > Please note that this only works for addresses in the kernel address
> > > space. For user space the full 64 bit address range (minus the top
> > > page) can be used for user space applications.
> > 
> > I wonder what is the unsigned long size (stack entry size) of the
> > s390? is it 64bit?
> 
> The s390 kernel is 64 bit only. So unsigned long is 64 bit as well.
> 

Ah, got it.

> > > I'm just writing this
> > > here, just in case something like this comes up for uprobes or
> > > something similar as well.
> > 
> > I'm considering another solution if it doesn't work. Of course if
> > above works, it is the best compression ratio.
> 
> I'm think we are not talking about uprobes here, and everything ftrace
> related would just work (tm) with the first four MSBs assumed to be
> zero.

yeah, but we still have other 32bit architectures support (e.g. i386, arm).

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

