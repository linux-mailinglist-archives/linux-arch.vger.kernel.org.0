Return-Path: <linux-arch+bounces-10162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E5A38C1F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 20:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7013B54DD
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2FE236A8E;
	Mon, 17 Feb 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jz34MUBk"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3A2376E1;
	Mon, 17 Feb 2025 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819327; cv=none; b=rsogVB3izDyyXOy+ub75ckh+5qNDanr8HL3LK/jlAJTi8QED4O8BjxYK8UJPES0TF8XA1+U56V0lQiXEt9dprG4s4/ybKn4yPxytyqcX+qLoIXqHljWfyYuJfPH6eS5isGGtWUFUa/b+pY1z+DZNHgRpoKjbA0vhhdLu0BUqJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819327; c=relaxed/simple;
	bh=mkVi65pda2R6WvNDvWvDbwDD/REKhNIKZ0M6+x/ENQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIaRy81d3htS6XsSeDEV1FHs5RJRKIYINqcQJ5rYcNk6Ap+0IIyucnLzCXYMO8U+TffjM+9KJZPBiFSrPbHmMSKmJJFB7erNnT07bRavv4dNOELV9p901m6s7apou3F/ERx62rMcrEbgR1I8y2KSGmJRKCSj1VhDZLiQIv/QulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jz34MUBk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=xPK3eVt9+7xzyAPyUDSt55ICTTIrX4D95c1avul6TRk=; b=Jz34MUBk12WoNx3nG8DYnhoKOG
	5TdzeRiHmtpKkxk3YXdh4WT9xz/u9O9dg4xXajm73CZ4nwIf4hXUUIxmUVzFDLLEyA49LyHVhFg/9
	jU6cGlj48Pp3AWlNkp0kOGJcYR/oBWOnJAzuGrKSBapUz5885RV7u33SS6rGZosC/WoLJ7AznBLb/
	EZvh5DXpj7mTNzZeCv/ZM98Mo2dpj/YL54x3ceiSxdjzRgT8zbBhqErxpxXc0wRy2tCqrBVz6bvp+
	cPfmrAjIb2VvaLUmvPF5AYOczpX9oO0vXS9N0GfX3WQ14h4ExIX+z2eRJHTarDPAnImAruOehyCzZ
	6W7zMzMw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tu-00000001pBB-2EX9;
	Mon, 17 Feb 2025 19:08:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 0/7] Add folio_mk_pte() and simplify mk_pte()
Date: Mon, 17 Feb 2025 19:08:27 +0000
Message-ID: <20250217190836.435039-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent is to add folio_mk_pte() to remove the conversion from folio
to page necessary to call mk_pte().  Eventually we might end up removing
mk_pte(), but that's not what's being proposed today.

I didn't want to add folio_mk_pte() to each architecture, and I didn't
want to lose any optimisations that architectures have from their own
implementation of mk_pte().  Fortunately, most architectures have by
now turned their mk_pte() into a fairly bland variant of pfn_pte(),
but s390 is different.

So patch 1 hoists the optimisation of calling pte_mkdirty() from s390
to generic code.  I'd appreciate some eyes on this from mm people who
understand this better than I do.  I originally had

-	if (write)
+	if (write || folio_test_dirty(folio))
		entry = maybe_mkwrite(pte_mkdirty(entry), vma);

and I think that broke COW under some circumstances that 01.org could
reproduce and I couldn't.

The various architecture maintainers might care to make sure that what
I've done is an equivalent transformation.  x86 was particularly tricky.
The build bots say it works ... at least now I've dealt with the pesky
!MMU problem.

The last patch to actually use folio_mk_pte() ought to be the least likely
to have a problem  since it's equivalent to calling mk_pte(&folio->page).

Matthew Wilcox (Oracle) (7):
  mm: Set the pte dirty if the folio is already dirty
  mm: Introduce a common definition of mk_pte()
  sparc32: Remove custom definition of mk_pte()
  x86: Remove custom definition of mk_pte()
  um: Remove custom definition of mk_pte()
  mm: Make mk_pte() definition unconditional
  mm: Add folio_mk_pte()

 arch/alpha/include/asm/pgtable.h         |  7 -------
 arch/arc/include/asm/pgtable-levels.h    |  1 -
 arch/arm/include/asm/pgtable.h           |  1 -
 arch/arm64/include/asm/pgtable.h         |  6 ------
 arch/csky/include/asm/pgtable.h          |  5 -----
 arch/hexagon/include/asm/pgtable.h       |  3 ---
 arch/loongarch/include/asm/pgtable.h     |  6 ------
 arch/m68k/include/asm/mcf_pgtable.h      |  6 ------
 arch/m68k/include/asm/motorola_pgtable.h |  6 ------
 arch/m68k/include/asm/sun3_pgtable.h     |  6 ------
 arch/microblaze/include/asm/pgtable.h    |  8 --------
 arch/mips/include/asm/pgtable.h          |  6 ------
 arch/nios2/include/asm/pgtable.h         |  6 ------
 arch/openrisc/include/asm/pgtable.h      |  2 --
 arch/parisc/include/asm/pgtable.h        |  6 ------
 arch/powerpc/include/asm/pgtable.h       |  3 +--
 arch/riscv/include/asm/pgtable.h         |  2 --
 arch/s390/include/asm/pgtable.h          | 10 ----------
 arch/sh/include/asm/pgtable_32.h         |  8 --------
 arch/sparc/include/asm/pgtable_32.h      | 15 +++++----------
 arch/sparc/include/asm/pgtable_64.h      |  1 -
 arch/um/include/asm/pgtable-2level.h     |  1 -
 arch/um/include/asm/pgtable-4level.h     |  9 ---------
 arch/um/include/asm/pgtable.h            | 18 ++++++++----------
 arch/x86/include/asm/pgtable.h           | 19 +++----------------
 arch/xtensa/include/asm/pgtable.h        |  6 ------
 include/linux/mm.h                       | 22 ++++++++++++++++++++++
 mm/memory.c                              |  8 +++++---
 mm/userfaultfd.c                         |  2 +-
 29 files changed, 45 insertions(+), 154 deletions(-)

-- 
2.47.2


