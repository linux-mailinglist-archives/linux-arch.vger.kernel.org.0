Return-Path: <linux-arch+bounces-12555-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04426AF6021
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 19:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA1117DDEF
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977C2EE961;
	Wed,  2 Jul 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUNrYxCc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E624C060;
	Wed,  2 Jul 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477900; cv=none; b=k+FApQQV6uCBrR6V25hqVTR6XJX8hHauz5xKvMGtOBC7cIZ8VEVq5zD7JEytpJWMx//2rCCrLtVWYobpqFFTtl4yI8fPZFZy/YjpS54teirkEJlpHuZjbwOY9b7Z4Xz0Jt3jsKDMjP3UE8aILN6Uc93TeJcAzrvYrO31BwRNino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477900; c=relaxed/simple;
	bh=9I9NerHyEGC5XpGaf6vyj6koIRuYlKsZkV3w3GMUvpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYFzpRiO1JUBiZBFtnfiFLQ+iHvDX/1YKntHiROpE7j0IHohQRDcV3zDVkDBpvx8NylhjYKaqPPjV5mI2JBHfjYD+50dNnWKVToZoc1j2OP4l4dD/iVw/qAUzN5heC+RgVypgSwhiNsvH4lQCmTNC/jDB0FY9fOPGwmNga+yugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUNrYxCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F28C4CEEF;
	Wed,  2 Jul 2025 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751477900;
	bh=9I9NerHyEGC5XpGaf6vyj6koIRuYlKsZkV3w3GMUvpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUNrYxCcZzuBz13YM2YeZJsZtE4GKg7jHOCCiKgquYherMBWxjxCZ2eKcQSur41ZB
	 N3x2Ca82+HKFiDJlPSZ+2StkpcmfhVlnBeX/MifE0DbrDnmWicVqS2V+G2rNoIfMOY
	 0phWRzE0/GTpFX5SW3Xk/x68IAfmD3SeGg4R1OUPLwOKyIiXqEk3xFg5j4moVHRglQ
	 xZH2d44IzclHTjffSyL+XPIbMrXpgeBnZp1k3pj1QIYg6JhJee1SO9RfJAEYAS77xY
	 MyzxhdE+ZvUeEEomzPH5LCLm8y6MD++SAXjv9kWjkeblGsdx2y2lxZgW67cL/umEiw
	 gQEpVXiLd6Vkg==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <21cnbao@gmail.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [DISCUSSION] proposed mctl() API
Date: Wed,  2 Jul 2025 10:38:16 -0700
Message-Id: <20250702173816.59935-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <6d8832bb-b5a7-4cd9-b92c-c93f2c1fe182@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2 Jul 2025 15:15:01 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

[...]
> In terms of the approach of doing this, IMHO, I dont think the way to do this
> is controversial. After the great feedback from Lorenzo on the prctl series, the
> approach would be for userpsace to make a call that just does for_each_vma of the process,
> madvises the VMAs,

One dirty hack that I can think off the top of my head for doing this without
new kernel changes is, unsurprisingly, using DAMOS.  Using DAMOS, users can do
madvise(MADV_HUGEPAGE) to virtual address ranges of specific access patterns.
It is aimed to be used for hot regions, while using similar one of
MADV_NOHUGEPAGE for cold regions.  An experiment with a prototype[1] showed it
eliminates about 80% of internal fragmentation caused memory overhead while
keeping 46% of performance improvement under a constrained situation.

If you set the access pattern as any pattern, hence, you can do
madvise(MADV_HUGEPAGE) for effectively entire virtual address space of the
process.  DAMON user-space tool supports periodically tracking childs and
applying same DAMOS scheme to those.  So, for example, below hack could be
tried.

    # damo start $(pidof XXX) --damos_action hugepage --include_child_tasks

I'm working with Usama at Meta but not very closely involved in THP works, so
I'm not sure if this works for Usama's case and others.  I even not tried this
at all on any test environment.  So I'm not recommending this but just sharing
a thought for more brainsorming, and that's why I call this a dirty hack.

[1] https://assets.amazon.science/b7/2b/ce53222247739b174f2b54498d1a/daos-data-access-aware-operating-system.pdf


Thanks,
SJ

[...]

