Return-Path: <linux-arch+bounces-3042-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B78804A5
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E259A1F23734
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E142D052;
	Tue, 19 Mar 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gU1jAc1F"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9FD2C6A9;
	Tue, 19 Mar 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872439; cv=none; b=CO/Nqn89WxbjBpVduuNVPPkARQZTQJEX6isI1C1TVnQd9D4bdevGPT8MN+58TIjreIatRriRAoCxyp07HBvgTBPo1SLRUjkpEaxF1rf8kB+LSvlhpoWf+aY989D2knJIDYEbdb7tQch67GuMFAwyltPNEHMB5mmcIOGdOSh7+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872439; c=relaxed/simple;
	bh=y+s7ig2yhnQ8ndCtl/1HoqIQCHT03mXcZ6EyR7W5Mwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4qJOSrghvM2tBaS2mjNvy6W2QWjW62wsRCDz0n2eX1tln0arOaVF/s83mnIEcOF+YlUIon+bZSTPY3DGHBC9qlHCxhD16FuU+ZhTrESGEk8epr4i/zPiQ1HgIdSNTjhLEwR0dcotrTrv9enORPHINvAXx6FMmt4+Sqr9ONxfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gU1jAc1F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dsegeZP0v2buC7Ra1kGyqd65Xn7lq1i4qwqz8fULl8Y=; b=gU1jAc1FfbnX/vZ9kGGAj0dDYG
	qk84UIUqq4u1VtJoF+3NrVS6LlYt7tg3YZC3z4AGWj1uVbv8td+cWtW/CDWWazz/0mNQUiJIlxit+
	hkW4qRaNRwewSAnsgqezl9PNJN7aZZnCivc+SNTtK3DitPqdL420HnMU5MdIvzNmduTP1YvEUix/L
	N9qLIzApv8x/buQARB5UVRoe46neCK2UkXvRE3Wob7kDkQxtfLajM9L/7asaMx6KjcDi2ypF6ke9P
	VzUsfexrOlGLeZVw5adr7c1up/4a2NwuWtT2alKPsPtz9HDqtcobwX3zxLf6h0UAG0yXhdua9v8mt
	EcR55gRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rme4f-00000002U30-1V6O;
	Tue, 19 Mar 2024 18:20:33 +0000
Date: Tue, 19 Mar 2024 18:20:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ying.huang@intel.com, dan.j.williams@intel.com, honggyu.kim@sk.com,
	corbet@lwn.net, arnd@arndb.de, luto@kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [RFC v3 3/3] ktest: sys_move_phys_pages ktest
Message-ID: <ZfnXcbd3h3Rj4IIS@casper.infradead.org>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <20240319172609.332900-4-gregory.price@memverge.com>
 <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
 <ZfnWCRwcZJ4KBmSH@memverge.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfnWCRwcZJ4KBmSH@memverge.com>

On Tue, Mar 19, 2024 at 02:14:33PM -0400, Gregory Price wrote:
> On Tue, Mar 19, 2024 at 05:52:46PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 19, 2024 at 01:26:09PM -0400, Gregory Price wrote:
> > > Implement simple ktest that looks up the physical address via
> > > /proc/self/pagemap and migrates the page based on that information.
> > 
> > What?  LOL.  No.
> > 
> 
> Certainly the test is stupid and requires admin, but I could not
> come up an easier test to demonstrate the concept - and the docs
> say to include a test with all syscall proposals.
> 
> Am I missing something else important?
> (stupid question: of course I am, but alas I must ask it)

It's not that the test is stupid.  It's the concept that's stupid.

