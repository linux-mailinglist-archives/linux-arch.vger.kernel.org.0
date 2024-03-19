Return-Path: <linux-arch+bounces-3037-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEC08803ED
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30801F22B73
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E537208D4;
	Tue, 19 Mar 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tp5kErN6"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F62B9C1;
	Tue, 19 Mar 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870774; cv=none; b=Kus+hbiNkunADQDYMc0haRcFYiK6YUG+nl2+WXoexxUlbJUL/w8ZwrnAT/hPeokXJcrFZjPCHVs8zu+0QdlHdHdrh1gzZxQdjAK4K+7uLzqg2rvLHQcTqbqVurr7YvJ/ErV7Uig+/G+IOqwoLKqizHC/MHMgpDlk1qM4zyI7Mak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870774; c=relaxed/simple;
	bh=w+dyHbjX7gc0ioAKMxug+Uk+hBJ8l5PehIsqPnA7H6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3Ea70s//2D6Ib7xvdsYosTQdMzRsi4eF1vhQvv484AiTGltfWcquP7FRFt+XOaOhBxnP1LFpI6aLwiZyIx5c9v9nYx0nSeCBjJQXXcbGxK5dAoMV7v+Jxff3vLwcsXM0zSpXUPpcXJP0Z0Hd8hmzzBjeidy+s1IaLLjNhuVksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tp5kErN6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6o4kZXWWhBj7TyRY/j0EqK3kig9yCh9grF6z6ubfGrk=; b=tp5kErN6B90TBrI1Ept7eFLHD6
	PJf4vKxX+PkD0H2UCVyQ6NEmEoWS6nPMIOaMd3ZgenNnqiv36wSfVwyo5zYx3R9ex+nv0+C1kLEs5
	r+6exMjyGjT1gBDvbR6+eFx5nR9rSXVdKN0X1X4C7LdIgvQwO189o7rkklEDNdWqERs8Sc3JfHhdr
	9w6z3NwBJVwm8tCv1xkc96EqxTtgecruv3NYhRmHfeNjdcJZGiKKDX01OytzVrmIlVB/NojtbKdJ2
	PgEopQJ7e1ZhbvamBkKMJcrbaNpuAlzkAgcs+qgf7pAIkmIGU7zwcmkPxAPCZzH0OovmgHNZuVW8q
	1thoFD4w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmddm-00000002RXq-3m49;
	Tue, 19 Mar 2024 17:52:46 +0000
Date: Tue, 19 Mar 2024 17:52:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, ying.huang@intel.com,
	dan.j.williams@intel.com, honggyu.kim@sk.com, corbet@lwn.net,
	arnd@arndb.de, luto@kernel.org, akpm@linux-foundation.org,
	shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC v3 3/3] ktest: sys_move_phys_pages ktest
Message-ID: <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <20240319172609.332900-4-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319172609.332900-4-gregory.price@memverge.com>

On Tue, Mar 19, 2024 at 01:26:09PM -0400, Gregory Price wrote:
> Implement simple ktest that looks up the physical address via
> /proc/self/pagemap and migrates the page based on that information.

What?  LOL.  No.

