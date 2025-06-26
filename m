Return-Path: <linux-arch+bounces-12473-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E19AEA270
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B5318892B2
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E0B2EB5BE;
	Thu, 26 Jun 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bUyxzEho"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3B2EB5A4;
	Thu, 26 Jun 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951040; cv=none; b=qaL313vQy7ThEXtQw59sjn4QlMYvXY4qhtpc2/UcSLgcPdU/SRH/Rl87Z5CnLhBwVa0kstoUDnJX77W+4KfnJ/Jz2Q9b36mT7Yh8m9jb/aBMwBUREkfhInh5oEA39oNRmghUNBzlpO7DKzpb4Dtlf494NIJqMSCABrtaROWRTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951040; c=relaxed/simple;
	bh=/H8MMQsDD8gwCIoOmfc5kCh+IrmGPsSl8LrXtfr7thU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtG0IPJlGCb4tUrnkNhJ1wFr4xw0TzJ3FZnmWNBl6oCLvjxmnA/n/TgmFS1JUPGvP68FcEnTs9YFtITf32mnlc6V8sB980LpNtWFiM2nBOUZIXVeE8A4CD3Fwuv4R7tlK41tVrWzrwjDwa8NAokAea6xhrbjh9gzxfv2ZgBoJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bUyxzEho; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jJl/2zla9+BwzcplCJO6oNzMjTRhWJE5a6dcK6IqAGw=; b=bUyxzEhoitzgs7vO2XSUaYzfiK
	9QAoMnF7ssPqFPPH/pkULQ5OII6GSIGWSi3/5CjcHa2dLGp6+31mCID5Oynw9v3QJFzbGL1Jc1Fxi
	Nyn5a8iMewMYnZXV8eawYYK5qGz5IpnAZx6Pt51XHY4mIK3B77NJW2CKNlfURa7c2AIUhZtaD9Jz/
	KceEaKbcqSc3rUAWxbZ2Dd+J4g7+T0Q12Mz3dZ6uml3klANvHL/Qy0pDHbWvvqN2V0Mi9pF5KtFmD
	sU5uTrKGz/mXdywy/KCWPJR4ul4g2EYu0rRaNUplvyVXUmUv+sO1KK7/bnVIwKDOENhYI2lGryGrA
	6QqwFEAw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoLd-0000000Btis-31mA;
	Thu, 26 Jun 2025 15:17:09 +0000
Date: Thu, 26 Jun 2025 16:17:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/1] docs/memory-barriers.txt: Add wait_event_cmd() and
 wait_event_exclusive_cmd()
Message-ID: <aF1kdYvCQQdIttoC@casper.infradead.org>
References: <20250626143707.1533808-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626143707.1533808-1-haakon.bugge@oracle.com>

On Thu, Jun 26, 2025 at 04:37:05PM +0200, Håkon Bugge wrote:
> Add said functions to the documentation and relate them to userspace's
> pthread_cond_wait(). The latter because when searching for
> functionality comparable to pthread_cond_wait(), it is very hard to
> find wait_event_cmd().

Would it not go better in the kernel-doc for wait_event_cmd() in
include/linux/wait.h?

>  
> +Note that the wait_event_cmd() and wait_event_exclusive_cmd() are the
> +kernel's polymorphic implementation of userspace's
> +pthread_cond_wait().

Pet peeve: "Note that" adds nothing to this sentence.  You can just
write:

The wait_event_cmd() and wait_event_exclusive_cmd() functions are the
kernel's polymorphic implementation of userspace's pthread_cond_wait().

> +Using wait_event_cmd() or wait_event_exclusive_cmd(), cmd1 is
> +typically a lock-release call and cmd2 a lock-acquire call. The
> +locking primitive can be chosen, contrary to pthread_cond_wait(),
> +where the locking type is cast in stone and is a pthread_mutex_t.
> +
>  
>  MISCELLANEOUS FUNCTIONS
>  -----------------------
> -- 
> 2.43.5
> 
> 

