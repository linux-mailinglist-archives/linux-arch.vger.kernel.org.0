Return-Path: <linux-arch+bounces-2586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9703085E1BC
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 16:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94521C23D68
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FF5811F7;
	Wed, 21 Feb 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+Cr9eoL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCA80C18;
	Wed, 21 Feb 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530356; cv=none; b=pKVeiy5Uqxmcmcsk8BomGXoc2dTNZRwIqEPxjIp0IB0CVX/6zYTx9+iCYUZJdPSMl8hWbMq+LGZ08uJ8qlGYQOUnJmSlQboR9/wKCmxRu87M83xilABmE6JExbqrCBsqic4SxCExvWfjgx23q9q0Sz7GwWPSkggz7LaMckNjyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530356; c=relaxed/simple;
	bh=P/mpas3J/TkZfCO9L2DgIxqYbys+a0Vsm10ZNtd+lcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l5CquHOroAwPWneqP1i4b2irSV+GzxXlHh9VFJHNoQ3VymDNPZf6rbuLw8Rob2SPrsqBEDWQ2oYeAAFrh/ECjscRpJDmtGscuC8HNQ0fuGLKipx/NZtH2kVsqryJGFO+loMRqyz994ZCvqXtTEXJf/ZYD9YVIFzSWhyuGhX7Muc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+Cr9eoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530DFC433A6;
	Wed, 21 Feb 2024 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708530356;
	bh=P/mpas3J/TkZfCO9L2DgIxqYbys+a0Vsm10ZNtd+lcI=;
	h=From:To:Cc:Subject:Date:From;
	b=H+Cr9eoLl+fXedgpLYqZMW5afOoTadBK1bLxge/KlxopT+WqCKozCkU2qcX1fAjN8
	 Vq1xRPwdybtci4gMRXHIEYUxO+dq6p6L9dWxPs4qhOhk9/b30VB9tvupItkoa31+5l
	 II9E+f2oAvzDWAxpIe/JQbIn2es8Gq+1bwNP59Jb83zlA6c2W84ziLOi93erh5MDuc
	 Yy9BuUDI6qS0fEkxJXaMJmlPwaN2KxoKtKQJ/msnTfkwNWMklyJcIb1xlCri7pmKb4
	 ha9IcknixFdeKHRDb6RgtK4dznORynMDrgf4vcGFMhDQtIPtvYwb/RSfQFg5iYLTvb
	 lnCBhOJN7z2wQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] mm/mmu_gather: change __tlb_remove_tlb_entry() to an inline function
Date: Wed, 21 Feb 2024 16:45:21 +0100
Message-Id: <20240221154549.2026073-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang complains about tlb_remove_tlb_entries() not using the 'ptep' variable
when __tlb_remove_tlb_entry() is an empty macro:

include/asm-generic/tlb.h:627:10: error: parameter 'ptep' set but not used [-Werror,-Wunused-but-set-parameter]

Change it to an equivalent inline function that avoids the warning since
the compiler can see how the variable gets passed into it.

Fixes: 66958b447695 ("mm/mmu_gather: add tlb_remove_tlb_entries()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/tlb.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index bd00dd238b79..709830274b75 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -600,7 +600,9 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 }
 
 #ifndef __tlb_remove_tlb_entry
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
+static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep, unsigned long address)
+{
+}
 #endif
 
 /**
-- 
2.39.2


