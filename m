Return-Path: <linux-arch+bounces-13418-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5ACB49B57
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B484E487B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6681A704B;
	Mon,  8 Sep 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z+xd2Nic"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4EB38F80;
	Mon,  8 Sep 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365224; cv=none; b=cy3GuLftpkjisxEdTh+VHkqdYokdxEFE4C4DhmxQGuQS0MGutYkL9W9GlVulzpJ88w4ANbegh1NArKV0Dc8paZ/1q4SXolE4q6Kupnhvp99Wx7cUqFZUwIw99FeWxWcjBlL9UuNAYmDcNqovkkUbFdnb7mAo1hYbrxmI0FDZQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365224; c=relaxed/simple;
	bh=ON8NUitiZVbCBSQ2lSjpU9xOwZIfOyaINwjZ5vrHO9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewKVFj3/Ed+IKltE9Fq/zdywrkionhVkvnAlFtuzicndYRgzfTgNPqbEwu03l1EyZBLG26Wwp05mP2FUprEw+BYCAwwlvAF6t7AXOlvrblUFfjrWkZ3hnOP1LGbey3eBd/hVh2KVVxAn3zD3kn26GeEHWy5bTL7cGzDuG2DjINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z+xd2Nic; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8W7OV22si8PaHmNjeiI92VUYfmd2gxuh+1FV7aVnSGk=; b=Z+xd2NicQ2DByD7bGMjprgGPMX
	SKT2BJDH/LasgqPAOPXPqwPpYDmgPDz0eSB7nN/nKHhP+QH+uH3zWsG3PK4s+RWMFPr2OTUSIRuEm
	zCqEzsWGaYPi5Rm+rKou+Jh5MkQ4Ho3NWZ6xY5e9iDI36U0UmdJy984A/oQXMN4WL9iMkNRNpJPIv
	xAicaKFMDQD9saIZpslJaMtrc6QlDwPyxZmnMzdYJ5+3CwenizlADAySpEff6iW0tId6T+Ow7pJcd
	ltrpwoNZU4Qoqs4i+XtHIkUIqseck3yVgCm6PkV0Kj7/qxFrBVgKHfFekOytv5KytQYDVNIZaRJBh
	VDkcu66g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvixU-0000000Cyxf-2WaL;
	Mon, 08 Sep 2025 20:59:29 +0000
Date: Mon, 8 Sep 2025 21:59:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
	bp@alien8.de, brauner@kernel.org, bsegall@google.com,
	corbet@lwn.net, dave.hansen@linux.intel.com,
	dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com,
	jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com,
	khalid@kernel.org, liam.howlett@oracle.com,
	linyongting@bytedance.com, lorenzo.stoakes@oracle.com,
	luto@kernel.org, markhemm@googlemail.com, maz@kernel.org,
	mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
	mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
	osalvador@suse.de, pcc@google.com, peterz@infradead.org,
	pfalcato@suse.de, rostedt@goodmis.org, rppt@kernel.org,
	shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
	vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
	viro@zeniv.linux.org.uk, vschneid@redhat.com, x86@kernel.org,
	xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
Message-ID: <aL9DsGR8KimEQ44H@casper.infradead.org>
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <5b7e71e8-4e31-4699-b656-c35dce678a80@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7e71e8-4e31-4699-b656-c35dce678a80@redhat.com>

On Mon, Sep 08, 2025 at 10:32:22PM +0200, David Hildenbrand wrote:
> In the context of this series, how do we handle VMA-modifying functions like
> mprotect/some madvise/mlock/mempolicy/...? Are they currently blocked when
> applied to a mshare VMA?

I haven't been following this series recently, so I'm not sure what
Anthony will say.  My expectation is that the shared VMA is somewhat
transparent to these operations; that is they are faulty if they span
the boundary of the mshare VMA, but otherwise they pass through and
affect the shared VMAs.

That does raise the interesting question of how mlockall() affects
an mshare VMA.  I'm tempted to say that it should affect the shared
VMA, but reasonable people might well disagree with me and have
excellent arguments.

> And how are we handling other page table walkers that don't modify VMAs like
> MADV_DONTNEED, smaps, migrate_pages, ... etc?

I'd expect those to walk into the shared region too.

