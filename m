Return-Path: <linux-arch+bounces-11063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF397A6F786
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 12:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457B53B036D
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87D41F7586;
	Tue, 25 Mar 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ4YoKGP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF51E7C28;
	Tue, 25 Mar 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903377; cv=none; b=X44nFHXY9BiELzWSN+EwClTIb3LHsLQGCRfzgbeI8yOjYgZ18QpVQ1MtZ+gHjAr0ylbv3qmZyu0ej8EmB6vucCvNJg/Z8PhBQJxgA8ZnH7Mb4vbmlPXlJyeUMd0KE6NHXfFJlep24GwuLUDWXkbmeot56Ac4Bl21OX6Oq1bUEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903377; c=relaxed/simple;
	bh=knOrW92YSJKBR3+ISRxDcXWEHNuwct3ut9Xv0PBHP3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vi8dVils2ihOCvRnFMpdzh4jl6MorHHGRv9e3o77MueZPFXRQMsAOkvPqD/81yA2NUF0M4k9NfBVySV1lK4EuUJNzf/kTsz+apZmHXGfOUAcYVbkkUaotmnUlY22GpRJ3wisIJVfMFXQBbvO9LBJOUnJE6cw2cyoVb3pFyT4+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ4YoKGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAED7C4CEE4;
	Tue, 25 Mar 2025 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903377;
	bh=knOrW92YSJKBR3+ISRxDcXWEHNuwct3ut9Xv0PBHP3s=;
	h=From:To:Cc:Subject:Date:From;
	b=QQ4YoKGPgj7gv+uuv8VGcqc1vpp/FINqJcxu1/I0G3w1tQkC/+T9oN9OvsW4Eg2u+
	 A/LWC8c1aQitiXVTq/hsR0PR90yVapRJjy2ffwGTMB+9wgD4oY47O/aNKMn0E6MxH6
	 hjAZGrker309RvCTl3dS/hyyA8NgTlxOGVqcR8qU/XLQkzuyB8KKIvNVBZW+ABvpFd
	 J8BppAz5lYfmaNxxQn52VMn5i18kTsvOGG6dbj6Jaa2lfQKbthmCwFQMDI3yoBPB+D
	 j7GFkZnwaSVeC+TmKK9k87j7dAJXwEkbnSSxkLdP5yE127uqrp0E5GMzt/+oR+XdOY
	 N2dvVf6C+XFlg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	kernel test robot <oliver.sang@intel.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 0/2] mm: fixes for fallouts from mem_init() cleanup
Date: Tue, 25 Mar 2025 13:49:26 +0200
Message-ID: <20250325114928.1791109-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These are the fixes for fallouts from mem_init() cleanup reported by Nathan
Chancellor and kbuild.
The details are in the commit messages.

Mike Rapoport (Microsoft) (2):
  mm/mm_init: init holes in the end of the memory map for FLATMEM
  memblock: don't release high memory to page allocator when HIGHMEM is off

 mm/memblock.c |  3 +++
 mm/mm_init.c  | 12 ++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)


base-commit: 0a1e082b64ccce165e7307a7b49d22b2504f9d1f
-- 
2.47.2


