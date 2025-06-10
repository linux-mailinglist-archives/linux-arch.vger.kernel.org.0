Return-Path: <linux-arch+bounces-12316-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D2AD3DE3
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 17:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0E03A6193
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D262327A7;
	Tue, 10 Jun 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OC9KFQXX"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF32110;
	Tue, 10 Jun 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570415; cv=none; b=AaAw1llbi7zYrw6SXeFkayc2FjSwpUi1Tv5WK+T6CmkcRBtgWHOSeT1nJa+vTMF6OJEEK9nVl6a9bLguamyx1oyEx7nis/SmbYGfh8nDAgKTRHfR5oSi0W4UWouK8VAAtR72ZuKu2HWXxLxzeN9AIHprxSKyx2KdgZlLVCmfpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570415; c=relaxed/simple;
	bh=j6dWJdalBSxeMo1IRxMIKeyURK4dTY/ml1b5oscbp9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI+RVp6Rgkygzlu+JXkVF+gxEGj0nj+L/lHLh7ixtfxb8U5Fk2nAev9kLSP2qkckBaAP4uL/ujSbXE3zGQSL+Be7dbS/Gmd3DmjbWUlxYLv2UeStoBlMkk/di/8uzEwusaFDfQyqefmQwtsWd1ivO/Jf6Cz6/z17wqlw9KAFUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OC9KFQXX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+joD00bwCj+l+Oro6kgeolprgnWfx+uVOp6jPA1PH9M=; b=OC9KFQXXhGP3G9vcpHTSWUEnJN
	xvJ9rPmBlTUaX2pv1VBNgqiGAQC/s8olrOeWhhKTniu6hFxrcqiBqwR6/i0r5+99q6dRCcjvssmRb
	E7jwbz1o5cRZ8CmbLGipZ9aSupvXrooUtfnS3Z3/994hU8Au6pjQMM2emjU8nR0u5rh1oNGnzhw4i
	ZyfmWxByYt9/M2dQSim/j+o/zvwvbRY2/xsJeY+t25sJJzDI4hHmP9P9GUzN1NxWZClaO0CqpGOIk
	WORdUjnnw5G10WPJmgo+9LqoGQm6ZphxuYDiOCK8L1eg2c6/d13jSjY57iT49jeifhKer+f4xnFw8
	zsM5PF0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP1BS-00000009ZrU-2Akh;
	Tue, 10 Jun 2025 15:46:42 +0000
Date: Tue, 10 Jun 2025 16:46:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <aEhTYkzsTsaBua40@casper.infradead.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
 <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
 <f8db6b39-f11a-4378-8976-4169f4674e85@gmail.com>
 <fcaa7ce6-3f03-4e3d-aa9f-1b1b53ed88f5@lucifer.local>
 <2fd7f80c-2b13-4478-900a-d65547586db3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd7f80c-2b13-4478-900a-d65547586db3@gmail.com>

On Tue, Jun 10, 2025 at 04:30:43PM +0100, Usama Arif wrote:
> If we have 2 workloads on the same server, For e.g. one is database where THPs 
> just dont do well, but the other one is AI where THPs do really well. How
> will the kernel monitor that the database workload is performing worse
> and the AI one isnt?

It can monitor the allocation/access patterns and see who's getting
the benefit.  The two workloads are in competition for memory, and
we can tell which pages are hot and which cold.

And I don't believe it's a binary anyway.  I bet there are some
allocations where the database benefits from having THPs (I mean, I know
a database which invented the entire hugetlbfs subsystem so it could
use PMD entries and avoid one layer of TLB misses!)

> I added THP shrinker to hopefully try and do this automatically, and it does
> really help. But unfortunately it is not a complete solution.
> There are severely memory bound workloads where even a tiny increase
> in memory will lead to an OOM. And if you colocate the container thats running
> that workload with one in which we will benefit with THPs, we unfortunately
> can't just rely on the system doing the right thing.

Then maybe THP aren't for you.  If your workloads are this sensitive,
perhaps you should be using a mechanism which gives you complete control
like hugetlbfs.

