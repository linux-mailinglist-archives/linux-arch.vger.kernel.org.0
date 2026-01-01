Return-Path: <linux-arch+bounces-15626-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEE4CECB89
	for <lists+linux-arch@lfdr.de>; Thu, 01 Jan 2026 02:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DCB6300F9FA
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jan 2026 01:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FEB1A316E;
	Thu,  1 Jan 2026 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKQ0IkXP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F5199E94;
	Thu,  1 Jan 2026 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767229511; cv=none; b=r603FF4b0qfpYEpt056CQF/PG6Vepf/OvfG5thGvfaDjdWlMYzC1OIuX4m0JDKnKfju4HQBeS1Lr5HemAVUCWGW+VbeYN7Vb5adzXcrTnC0vtTfO0trDt8MMMu67zOo8gIR9QGvSufm2Sxsss3FgkrWdrarMwhq5wpCSf91TY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767229511; c=relaxed/simple;
	bh=BPnj4T9ezcGeciKpRCEssGdjB2J5IjLkKcXB0gzCt48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRdqLdOCFQCbHOQU3fcuS0l4WKVmDjPM8+fJN6Yse107UTfoaFEgukFCyFP8D8haA2FbA8Vl8TRt1aJ/0rr1LKFD0BGlmuujdok/XPzrpNoPmtTnvthQ2LSUUJaJwprdX4rGHck0nrS9pACL8B5vtrMvyH7ynx0CmOhg5HFiRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKQ0IkXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A57C113D0;
	Thu,  1 Jan 2026 01:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767229511;
	bh=BPnj4T9ezcGeciKpRCEssGdjB2J5IjLkKcXB0gzCt48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKQ0IkXPS1+4xia5qTFMgU/zwNrJL31INeZqMym7gLHyadq/P2k5+JcDZGrsRpZDA
	 3lPq/29xdqE93fTkaSrD5Zw4R3y/0SSl1ThKL386zTmoHKWU0aBllZgfdb0MDJaMXC
	 hGMYDP5SBjTDTdf/BCuGKeHgJkmmV3EcTrClhFQSJqC54qAabcqonL1Y0dZ/ZcQ8Ea
	 KwWh+6QYbHee9wYnQGUR1PXnzFb6HIpx6TsYeothdFciXze49lI3hhecIfmrum3oOk
	 EmnsBMKIm9Pz8AZnZZyqP+u65wWq/N7qjif2vk3YgMiUacqWg6PFpGlVPpq42LM5+j
	 VpCTf9PrmOQvQ==
From: SeongJae Park <sj@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	akpm@linux-foundation.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: [PATCH] mm/mmu_gather: remove @delay_remap of __tlb_remove_page_size()
Date: Wed, 31 Dec 2025 17:05:02 -0800
Message-ID: <20260101010503.87598-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231030026.15938-1-richard.weiyang@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 31 Dec 2025 03:00:26 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> Functioin __tlb_remove_page_size() is only used in
> tlb_remove_page_size() with @delay_remap set to false and it is passed
> directly to __tlb_remove_folio_pages_size().
> 
> Remove @delay_remap of __tlb_remove_page_size() and call
> __tlb_remove_folio_pages_size() with false @delay_remap.

Makes sense to me.

> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

