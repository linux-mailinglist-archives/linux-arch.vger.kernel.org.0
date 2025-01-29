Return-Path: <linux-arch+bounces-9950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AD1A215E3
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 01:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240723A6FE4
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 00:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9375717E01B;
	Wed, 29 Jan 2025 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vv21INpm"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3114F132;
	Wed, 29 Jan 2025 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738112374; cv=none; b=IqoDToIm1r+aExMskwPr6bZFbR1qVW9XaLiGSKSBYIFr7EvSgQMXKT/NwEuGwaprDfhcif/zeWRwDu+m4o39y73Exv1xFGNPrweIfVr5vjo8Q+kTzQGrDeijJeRl/2nEqxU9kOE5GYFoZkPLXm+Vn1k0qUk0eKBeOrvEiTpVtCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738112374; c=relaxed/simple;
	bh=ApGe0o1oHXOCFvfbGQ4b3zp50tU4slOS5wNIA74SicY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK5+177fDzN63O4rz/Y2JncuYMzex5L8aEMYrWQhow2OynAf2N0uJGYaPQMAd+JvCIloHNX125N7hk/dU7+qIPTK/H2WX1B0ggT9N08tlAZnK7z3AhcpZbU2lg8VFwbdXumk6EkfAo0rsjhNVf+a5rggqV4CPMC5RCHqvklclOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vv21INpm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Vw4h2SUuYgw1K1+ocrpaQsibGQqRleh9lz8vhZOdAs=; b=Vv21INpmlFaggzcWqUgEUGoJrj
	+tEzvElQOrquw9XaKaS+uhIm833z/P9IOd4LbDUod/S3pRCHwC78VMF4OEZgr/dS6w9b40OcODcEI
	qxUdPiD4cAno6LZ+rnaCMYkhY0yUr9kNDdhiav8BW743nnZjO0KV/7Z90h1BzZZGEzX2igEabfMEv
	WeCXnTm1/+4cxt4RL5qXWr56XVZsMcwQ/LLsSWH+Wr1S2X4vg/frhFIQSdaTOwj/EY4mTBrvyWmau
	auotVNPz0mu9t7JIN10lzGME8D+0cVQ4E+KEjHQYWqqSXnCd5fJ0Ft+hXLDB3agiVohmICQE+9Z9p
	tcHaozxg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcwQB-0000000BM1Y-0Ijx;
	Wed, 29 Jan 2025 00:59:11 +0000
Date: Wed, 29 Jan 2025 00:59:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, markhemm@googlemail.com,
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
	jthoughton@google.com, corbet@lwn.net, dave.hansen@intel.com,
	kirill@shutemov.name, luto@kernel.org, brauner@kernel.org,
	arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
	mingo@redhat.com, peterz@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tglx@linutronix.de,
	cgroups@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
	vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
	neilb@suse.de, maz@kernel.org
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
Message-ID: <Z5l9XpSntxyxMGKj@casper.infradead.org>
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250128161138.066f6c27d0d941609ba1c1c9@linux-foundation.org>
 <92f188ed-4f47-427b-b8fd-2c0f76ef129b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f188ed-4f47-427b-b8fd-2c0f76ef129b@oracle.com>

On Tue, Jan 28, 2025 at 04:25:22PM -0800, Anthony Yznaga wrote:
> 
> On 1/28/25 4:11 PM, Andrew Morton wrote:
> > On Fri, 24 Jan 2025 15:54:34 -0800 Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
> > 
> > > Some of the field deployments commonly see memory pages shared
> > > across 1000s of processes. On x86_64, each page requires a PTE that
> > > is 8 bytes long which is very small compared to the 4K page
> > > size.
> > Dumb question: why aren't these applications using huge pages?
> > 
> They often are using hugetlbfs but would also benefit from having page
> tables shared for other kinds of memory such as shmem, tmpfs or dax.

... and the implementation of PMD sharing in hugetlbfs is horrible.  In
addition to inverting the locking order (see gigantic comment in rmap.c),
the semantics aren't what the Oracle DB wants, and it's inefficient.

So when we were looking at implementing page table sharing for DAX, we
examined _and rejected_ porting the hugetlbfs approach.  We've discussed
this extensively at the last three LSFMM sessions where mshare has been
a topic, and in previous submissions of mshare.  So seeing the question
being asked yet again is disheartening.

