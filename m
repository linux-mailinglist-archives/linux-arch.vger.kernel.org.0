Return-Path: <linux-arch+bounces-9323-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348D99E926A
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 12:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B205216044D
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201E921E08B;
	Mon,  9 Dec 2024 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U5S9Uv8d"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34A21D5B9;
	Mon,  9 Dec 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743848; cv=none; b=aaYFCYRGHCcfGSnOnSqWiAcHNkrEd/vMMKR1TYXK8xsMCh5phayUte0jUdOK6nUgkymwuiNZSrJGmBK0M8fMrTB087FQ4h2H3M0q3JFWtt5HaZZ22g118wAKxbI8e9/+qcMR0bfMisbBV3Cuhfgb5twT68vMz5bst0TVnEimcTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743848; c=relaxed/simple;
	bh=LfcCjeIwv1Rz/2jvlcT6Rbw3bs7AFo4adyeax54DlSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKsXXIsdghc3h6Mf+V1KG0a6xLB6gCx2o91GoG3ZF9AMXuaezYkIh/DQBeZIUbDa7m2R9UXH12ELu1fQ2GX2QDp5UirZlPQ+mGsFMdie8N+i/1ZfMV/Y53YDHt0lbb+7TZaa07xUqStsEBoerW8MPZMiwc4RtfBJ4gjxj/h6Hus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U5S9Uv8d; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qd1akmmoi31Ki/6nXtItmdXPQIscj5PkLzZDSYQld+U=; b=U5S9Uv8dgarrK9YOLdUsT6nkKn
	a7ku8NIqbNIaINfaEHL88xngO9HFocBZYICcZ8YwvExjocLrI1p/ivxKESGpW2wHLAIQkIF61Jxpy
	nAwCI+BLQKFB66+42Lhit3VyDUwIQrrdU9iNv58yRL0p2xVbhIFgeG9O4O8Y4mWRQcITkwZ53bAb9
	oE0ZokyGiChjgQvpGBBzg9RidYhoJhQ/R6Ta5tBGotjdE5SUTB1upXCxIdcEDMVEqVlUnHerDqI8U
	9hWt4xLEFb4L3hA+8q9475ePfYek+4hErmEifKGBVbyif/ugodaxBoTE/8cvNpi1RofFhk6Rx0CTA
	+X0eH3QQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKbyK-00000001cGR-0mjj;
	Mon, 09 Dec 2024 11:30:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF43F3003FF; Mon,  9 Dec 2024 12:30:39 +0100 (CET)
Date: Mon, 9 Dec 2024 12:30:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 2/6] compiler.h: Introduce TYPEOF_UNQUAL() macro
Message-ID: <20241209113039.GN21636@noisy.programming.kicks-ass.net>
References: <20241208204708.3742696-1-ubizjak@gmail.com>
 <20241208204708.3742696-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208204708.3742696-3-ubizjak@gmail.com>

On Sun, Dec 08, 2024 at 09:45:17PM +0100, Uros Bizjak wrote:
> Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof operator
> when available, to return unqualified type of the expression.
> 
> Current version of sparse doesn't know anything about __typeof_unqual__()
> operator. Avoid the usage of __typeof_unqual__() when sparse checking
> is active to prevent sparse errors with unknowing keyword.

Ooooh, new toys.

I suppose __unqual_scalar_typeof() wants to be using this when
available?

