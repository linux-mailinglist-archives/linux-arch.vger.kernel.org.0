Return-Path: <linux-arch+bounces-14352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECEBC0CB9D
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 10:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13ECA4E814A
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C972F2619;
	Mon, 27 Oct 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZWe9Ehr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z0MeAO7Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33751A2547;
	Mon, 27 Oct 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558025; cv=none; b=M5Wboe3SLir2lfvEqGNEGMp4ZWQCRPp+WWFi1MPYhjHoiCuWNNllssiCGKocOZTyxDL8oq01WdWbLhSyOoBm4aUS0w3ZFn2PtyHjauA2QkuqGzoH0iBNcaee23QobVBW0PEOKRb3VDmtQ6FMo3Wr/TBE0KyURHeZ/bx8IUsCN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558025; c=relaxed/simple;
	bh=/2xr/VTYXXffOJMMGSVhNyVlfRnEybe/oSAvYrqIhpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Anbg9rPyLBF/bHBYpqI9PAfL9EET8so0QgGxJogMPNLs4YXFTBjEuflJYQp6J1Ay48eHLbIS3fOb+YTn7gFHTia15VsJgOd07MKlHuDXb6tf2mpV3QTPPqZhA40tzsdt/+r0d7p5rbjEC41UHXwEw8dhEPloIoU+iuvAkcO8UoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZWe9Ehr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z0MeAO7Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 10:40:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761558021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=al41PRhuMv92E4hy7sTVqHUK2Lm7i8edcdRrAQO9r/o=;
	b=iZWe9EhrIlTTEWAL59SUfZEol4VyuXx9Bm9SCcbc9q2Q573ri5wCIGwdg/UGoXZRS1dwLF
	CdqK+W8Jj9i3x9/mR3RbtP3TPByAC1RdcjAeWeq0yChjWLpuaHs0YncC0YaepD4Z2PaApZ
	brEVZuPLx5LeWVsy8O8oTzavJo+NxX+Al/CobRK4JivXzQYeOjB9sbZ7+gT3td+TMjsW16
	O7mSRQOHGX3SaKheqGNRsnunUW1/VlRjGhsF0uscXzfVXFFXwa2gllo8fPAtd4oH9NpuVc
	6JwA/xpBaHkuuBVg9Ev9WEVokPxAEtl8aq6SbpCCZajXSzzNSK98jJZKWZRchw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761558021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=al41PRhuMv92E4hy7sTVqHUK2Lm7i8edcdRrAQO9r/o=;
	b=Z0MeAO7YVm+h4NFGJTXOJ3DBi5EqkEWzEkQM0/WzX+G3PIkdB8K91LzH5cntAJUal2VCPI
	nHp24Wo5waTqX+Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: Re: [patch V2 05/12] rseq: Add prctl() to enable time slice
 extensions
Message-ID: <20251027094019.foWBPFO2@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.216861528@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022121427.216861528@linutronix.de>

On 2025-10-22 14:57:34 [+0200], Thomas Gleixner wrote:
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -164,4 +164,13 @@ void rseq_syscall(struct pt_regs *regs);
>  static inline void rseq_syscall(struct pt_regs *regs) { }
>  #endif /* !CONFIG_DEBUG_RSEQ */
>  
> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3);
> +#else /* CONFIG_RSEQ_SLICE_EXTENSION */
> +static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
> +{
> +	return -EINVAL;

This should be -ENOTSUPP as in the !rseq_slice_extension_enabled() case.
After all it is the same condition.

> +}

Sebastian

