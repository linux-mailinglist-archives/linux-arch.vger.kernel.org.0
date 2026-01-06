Return-Path: <linux-arch+bounces-15675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B78CF9E63
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 18:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D6E32C608D
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BF4283C83;
	Tue,  6 Jan 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUcZ6ByD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC95250BEC;
	Tue,  6 Jan 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721006; cv=none; b=P22BjkxAUdxWjQFC/FgM4sVO/04rvvf0wfJnICJXLjwItDXEIK7RPrXnmwaPAAIoxXPPa8MHcKbBt+9qGy1jRZu84JEUPln8gIm+aKiYCvvmd9sa7ghkeG7mhzb69x6iDY99iVXsb9d6eUPE/C9ZAk2xQCODZaEkxBnb9HXDEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721006; c=relaxed/simple;
	bh=2bhIEBi52pIagS1gzwrT2nGBXwwpZUgIJ8cVRDzNmRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7eINNtiT+qbl+KOXjDJhpOOeIjlaoOLAXZnmVlGUkD2btvrYQ2ZVjKKimlpDZEQR2dTJDgVD9riJxTEyQKvd2btvufdcYM+asHbTm5+CPa30ZZIlgaWIRIw8rbcwBB5ax0BGBHNXV/fMQrigB759on887NLaw9oDckahBvrv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUcZ6ByD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7808AC116C6;
	Tue,  6 Jan 2026 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767721006;
	bh=2bhIEBi52pIagS1gzwrT2nGBXwwpZUgIJ8cVRDzNmRs=;
	h=From:To:Cc:Subject:Date:From;
	b=aUcZ6ByDj/EDc5TqP6NwYwESet8oPR96E8Ha+KbhwG++iJCjHHs5649/YILIN6a5i
	 lGLE59xRuT59pszXonCOTd03/wQSf0UIdugbC2EoY/cRqkdw76MN1otcSzOM2gnGOT
	 R3PoL0dEo6SZnQlqiGRkk39RTykCHpRlIzpVKpvgxbvu/ahnvc66yMAxpYYkllD+cp
	 1Du2G2u+74mLsej9bCPE5w93oZi5AMspAQXn4BsTS9FcpNs4KlBM2fpUz+il6A4rHn
	 5Pp0NFrHCgq77O7kOipx7LrpoMg3jmLN0oCBY4HOcB52TGb5k5NERwZa77xTa0enaf
	 b+9x5XwTQ0b/w==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Arnd Bergmann <arnd@arndb.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RESEND v2] asm-generic: Remove pud_user() from pgtable-nopmd.h
Date: Tue,  6 Jan 2026 18:34:20 +0100
Message-ID: <61ef32ebc3ea2e926de2bebecf3b5c3a10989fca.1767720453.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2913; i=chleroy@kernel.org; h=from:subject:message-id; bh=2bhIEBi52pIagS1gzwrT2nGBXwwpZUgIJ8cVRDzNmRs=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTGus913H6oo5FNQlXgwSqpRTHr7m98sNP9nJm6/78fb WWTt/dN6ShlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATaWNm+B+jI1vqtaJqhUq3 cVqqEX/2FbsHzPnPzv04frwmMPPwXFZGhqkeqflXf2vvPx5Zw80+/62G5qmXl8rF5GvvXmnelLD OlhcA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
issues") added pud_user() in include/asm-generic/pgtable-nopmd.h

But pud_user() only exists on ARM64 and RISCV and is not expected
by any part of MM.

Add the missing definition in arch/riscv/include/asm/pgtable-32.h
and remove it from asm-generic/pgtable-nopmd.h

A stub pud_user() is also required for ARM64 after
commit ed928a3402d8 ("arm64/mm: fix page table check compile
error for CONFIG_PGTABLE_LEVELS=2")

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
Who should take this patch ? I expected it to be merged by Arnd as asm-generic maintainer but this is the second time I resend.

Should the patch go via riscv tree instead as the undue pud_user() was initialy introduced by riscv ?

v2: Change ARM64 pud_user macro to pud_user(pud)
---
 arch/arm64/include/asm/pgtable.h    | 1 +
 arch/riscv/include/asm/pgtable-32.h | 5 +++++
 include/asm-generic/pgtable-nopmd.h | 1 -
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 64d5f1d9cce96..a9af0b441b0f9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -965,6 +965,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 
 #define pud_valid(pud)		false
 #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
+#define pud_user(pud)		false /* Always 0 with folding */
 #define pud_user_exec(pud)	pud_user(pud) /* Always 0 with folding */
 
 /* Match pmd_offset folding in <asm/generic/pgtable-nopmd.h> */
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 00f3369570a83..37878ef374668 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -36,4 +36,9 @@
 static const __maybe_unused int pgtable_l4_enabled;
 static const __maybe_unused int pgtable_l5_enabled;
 
+static inline int pud_user(pud_t pud)
+{
+	return 0;
+}
+
 #endif /* _ASM_RISCV_PGTABLE_32_H */
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24cb..b01349a312fa7 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -30,7 +30,6 @@ typedef struct { pud_t pud; } pmd_t;
 static inline int pud_none(pud_t pud)		{ return 0; }
 static inline int pud_bad(pud_t pud)		{ return 0; }
 static inline int pud_present(pud_t pud)	{ return 1; }
-static inline int pud_user(pud_t pud)		{ return 0; }
 static inline int pud_leaf(pud_t pud)		{ return 0; }
 static inline void pud_clear(pud_t *pud)	{ }
 #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
-- 
2.49.0


