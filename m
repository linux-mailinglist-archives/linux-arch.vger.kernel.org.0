Return-Path: <linux-arch+bounces-9445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983C19F818D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 18:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2627A1139
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934319EEB4;
	Thu, 19 Dec 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jMA8lMwS"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725E2155757;
	Thu, 19 Dec 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628769; cv=none; b=X/uiR87Q6heJS7DuV/hn3mYgWqXMz+Zx/9rTr8WdubBIH2OhqJqZTnvynW3+UvslcwY/UDvHcTVhgZEzxGrMyr+jPpLA26mboLapJVB8fuqlaS5MGH6DBj+4XX1pQsVq2Flk+XcC7GDjrX1iEbAEyNL+D/ihKIsqmYfr1oMiIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628769; c=relaxed/simple;
	bh=FiaWtTZMT6EBgr6mSaSJNXidWoMiFzrTlU10rNSdw/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyF5wEg090khXg5ZWfVZGChbQ4TNrWz4UclAJ96f6cWnV5ZeMzLrcpnsgeyaNtedhExKL6aKETRRU4We9NDszjA613su+bTgYZ6mQDHEOg6uicSowdngcrx1PsfN28NWS3F85DoQhiqgf7N5sOgMqHNhTZhc8oKAdoP/MJ3T4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jMA8lMwS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hD4px1JE4Hs8C37Ywe2qi4X3aSr37zS1Mt6jQs2kxto=; b=jMA8lMwSy3+bHUFP+4fZVh7IPx
	FyB8T3nnJ+VnT7ZEnXN4F5h9lorBeRxAcY4z9Maf9ZBSgXjPacaS/BsCuz4mxMNgmCy3EixkzWxA8
	9nBGzEYRwL6XhZtK8PGvIXWpbtgGjKa8UuZdrgNUr1gstWSzlDEZ4zghJ4X+5rUW+ExR2CzI8b/1g
	YgjbYJKE2JG9e/5b3h6i12Q8gw4+bdp4OGw8Yz1qz6fCcq72C9V4mGlNHIwG/Qn1QQ04br8S23m9g
	PMS2zOscxtTixVnQcYQzt7oYvJcMlPkATcO7LstZ0mhOYVVLul4cf4Ep3YiuOjwMWaSE7gfJig0Rg
	0p7Jj9wg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKBE-00000004Vjs-3SFX;
	Thu, 19 Dec 2024 17:19:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A1A23004DE; Thu, 19 Dec 2024 18:19:21 +0100 (CET)
Date: Thu, 19 Dec 2024 18:19:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org, loongarch@lists.linux.dev,
	x86@kernel.org
Subject: Re: [PATCH 01/10] mm: Move common parts of pagetable_*_[cd]tor to
 helpers
Message-ID: <20241219171920.GB26279@noisy.programming.kicks-ass.net>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-2-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219164425.2277022-2-kevin.brodsky@arm.com>

On Thu, Dec 19, 2024 at 04:44:16PM +0000, Kevin Brodsky wrote:
> Besides the ptlock management at PTE/PMD level, all the
> pagetable_*_[cd]tor have the same implementation. Introduce common
> helpers for all levels to reduce the duplication.

Uff, I forgot to Cc you on the discussion here, sorry!:

  https://lkml.kernel.org/r/cover.1734526570.git.zhengqi.arch@bytedance.com

we now have two series doing more or less overlapping things :/

You can in fact trivially merge the all the implementations -- the
apparent non-common bit (ptlock_free) is a no-op for all those other
levels because they'll be having ptdesc->lock == NULL.

