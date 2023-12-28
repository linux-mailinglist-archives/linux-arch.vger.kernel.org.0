Return-Path: <linux-arch+bounces-1201-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA43981F626
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 09:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2D41F224A1
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70263AD;
	Thu, 28 Dec 2023 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX3ZXIVu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59763A8;
	Thu, 28 Dec 2023 08:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CAFC433C8;
	Thu, 28 Dec 2023 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703753962;
	bh=qac361aQfUYlqbOE3Dx+WRTyiGe1M4tfZJDFMVM+Hlg=;
	h=From:To:Cc:Subject:Date:From;
	b=qX3ZXIVuIgqjmnWmLCGIeKFAzN5+ULWtyxoREOb6AT0bMQ9Fv9tUR0fPxd8bAQHoU
	 pyRvZh1oPfse8PUJCM7z9M/EPig3JCXg5znojjv37eq8A99ej39yt2FqtXM73KRciy
	 avt6nUxBjQe9F0Fy2qvg/ZyG+AJ4OGJRBIEnwlsS2/+tQpM+f9yXIkxHmtqC4nQIqP
	 vpwoUfR6TqZYM7Gk+VnYRKZBB475H5QW685Li+FYw3NEwltzrVrIbEr2FBzR4qCMyf
	 A5tkjpJLm3yxEUSP4SUB76u3vF72cxxZocQLLoKcdZ3I8w+KuzZlATfEj535SChZ4I
	 O9W6YEYkQ7hDw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] riscv: tlb: avoid tlb flushing on exit & execve
Date: Thu, 28 Dec 2023 16:46:40 +0800
Message-Id: <20231228084642.1765-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmu_gather code sets fullmm=1 when tearing down the entire address
space for an mm_struct on exit or execve. So if the underlying platform
supports ASID, the tlb flushing can be avoided because the ASID
allocator will never re-allocate a dirty ASID.

But currently, the tlb_finish_mmu() sets fullmm, when in fact it wants
to say that the TLB should be fully flushed.

So patch1 takes one of Nadav's patch from [1] to fix fullmm semantics.
Compared with original patch from[1], the differences are:
a. fixes the fullmm semantics in arm64 too
b. bring back the fullmm optimization back on arm64.

patch2 does the optimization on riscv.

Use the performance of Process creation in unixbench on T-HEAD TH1520
platform is improved by about 4%.

Link: https://lore.kernel.org/linux-mm/20210131001132.3368247-2-namit@vmware.com/ [1]

Jisheng Zhang (1):
  riscv: tlb: avoid tlb flushing if fullmm == 1

Nadav Amit (1):
  mm/tlb: fix fullmm semantics

 arch/arm64/include/asm/tlb.h | 5 ++++-
 arch/riscv/include/asm/tlb.h | 9 +++++++++
 include/asm-generic/tlb.h    | 2 +-
 mm/mmu_gather.c              | 2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.40.0


