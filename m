Return-Path: <linux-arch+bounces-15853-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9344DD3A455
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E287D3002B9C
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB83570DB;
	Mon, 19 Jan 2026 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bM9EfGh/"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB22367B5;
	Mon, 19 Jan 2026 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817462; cv=none; b=Cfl4/7CyxdIjXEJXEEfTmZVwZubuC1AewABVGYl80hvIwF3ETXIef0dr82ziTNQXGEUyfXl+2CZGIFYHdnoIpLvQuayoFm73NZaSP+01BzXZQV4Noob53wud7VebWFELfBoG5mUt2/CqwW4/0OvADYHcFLYUbYqpHwVDM0EM9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817462; c=relaxed/simple;
	bh=7/rjI3BqezGEblDHncwNAPRY+Mdy9UCt90hOoiUpYpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm7kvKqczp4H94fDkrxtwKV/LMDW9xj5oYcUil56iP1+J9dX3cvK+c81VB6JP+vZWhWWxnOFs/Fnu0U8TW+bq/yMTjjZNITf4hkmH5gMHQ1+/r79a9yBkCIf6tZXnrtjhQbnDNZmuGJ17jCoQDP0qnLN41SezlGI1lieh0DiLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bM9EfGh/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9r3pDTy4yX1O1Xw7OozlQYhYhtl43RfNm4gQST3C1JM=; b=bM9EfGh/dqUOgOlacDon4frk9I
	D4FKrZuP4GMKnhgy2Fhi+SERmbA37OjV/0Cwn/zkU+2sAe50vHKUYFtavYxrESW9DHzLe22F32ECk
	4dfHG2YKgVmZl1XPdMeMpz2Z6C2S3NEQEInI/h0OHLDJHt0BZNIfoJuEBGistfh0uysSOc+E1+/K4
	of45YrMbOL0pBAFqa9mDXVJ1Jk0AB0eDBmi807xlmsFRo/foQ/7broqqDfoHz5yKZJ4ib+bvX0nPe
	Iq4NE3Hb4FIGtemlNTFS3Lgyp8L1Zk2X0fn97oJcouyLFGu5yPkx6fEbfbtDUrJMfwQLo+Gov86ov
	WkI1WA9A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhmDa-0000000Bp76-2h3I;
	Mon, 19 Jan 2026 10:10:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7B35C302FA1; Mon, 19 Jan 2026 11:10:41 +0100 (CET)
Date: Mon, 19 Jan 2026 11:10:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
Message-ID: <20260119101041.GP830755@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215155708.669472597@linutronix.de>

On Mon, Dec 15, 2025 at 05:52:04PM +0100, Thomas Gleixner wrote:

> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -23,9 +23,15 @@ enum rseq_flags {
>  };
>  
>  enum rseq_cs_flags_bit {
> +	/* Historical and unsupported bits */
>  	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
>  	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
>  	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
> +	/* (3) Intentional gap to put new bits into a separate byte */
> +
> +	/* User read only feature flags */
> +	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT	= 4,
> +	RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT	= 5,
>  };

Either 's/byte/nibble/' or 's/= [45]/= [78]/' I suppose.

