Return-Path: <linux-arch+bounces-14285-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18024BFE8EF
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 01:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4A7188781A
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 23:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110531329A;
	Wed, 22 Oct 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="XiZefY9Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92BF30C360
	for <linux-arch@vger.kernel.org>; Wed, 22 Oct 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175802; cv=none; b=tvjyeMAP/9Gd3MMXLBlUW2WvyYf/ZDe0I2/c2MG5JKqY6OlJSLF7dQJKeqBzjp9nklZ8C+rN1BCL+VvjX9WwbsloSqqAG0t5SeaCPZYpn8pRKfMRvl+mdAbreNYefnPJo99q0MReyAxYmfTrbGLLsP5egty8TEHHNuALfrQllx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175802; c=relaxed/simple;
	bh=zG1PvbsubgVB7UstpLjRtN915FxsRLFbcnYegAn0YwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYoigiPVDL1UH/o8FXVeLjWzZcu0Y1yBrip9UHDyTNTVkSr+e8LbKMUWEhqjgp5/3WCZqKt9tyDjXKwRKOlEFnYrIbPMqH+OobRbcxDb832dfyHN1gLDBNqWcaMdDSgeR46K0sIIXF8daffM0qb/rslBvFQTpUXO5vXFm9hLneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=XiZefY9Y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f67ba775aso228007b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 22 Oct 2025 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761175797; x=1761780597; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=XiZefY9YC14Z4QiRms+DZWHai9TQsRuAlZteJAJsaA3smRfQwCfGDfq2ebg6mBQVQ9
         EL6l2vpyTJQt7rgwbIh9ZUq9VBG3MmtsMZOnmQuEEwfCSPpqM1gGKdxHrZ+SWdYv9/xp
         2lT5X3otdscMZm18GixahE76/y6ZdF57aCJiHUf8jqR5OF86oeTGcp+ih0hAnnAf0EWo
         VSTc7TMNI0GzW7vwsEiOAqCsKegymgJCDNuRgQcsjWQ3e2zzwHojvTyeYPXLQs3NYANB
         9Mip3poeFObV33JHQTuUVerqflkvQT/Ix1zJej2QLkP1muQVnf3XUpnLdXVqxJ26lDRy
         n+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761175797; x=1761780597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=dd+J3kfbFHv87CH4FaYu2eP4jOzLnq9ULVcG49rQnHdLkUuESPu9F8Ol96Mxh9QnNJ
         gcUNr7DbH9C/taZ4KQFaGIgE8mHCOFxa2ASQyfGqKBbSJrulRw6bBkSpcsWgmFw7nmlV
         6nNG8UiNwyxAUGtHmwgzYrDlamOpIM6Fu7w6Oh+OKtmKfcD1PSXNVZWZf9CEH8un70WH
         lGVUbn0E0s2dXztovB3PibT0Bs5A7VNajOKOYRvXGDWTtmziaq3VxvCkFuedl/f8vspQ
         0GdQUtVyp/6+IfqJKqykKyTPfGtpQVkyvsLdS8scyXS28ZaejfwCnB78VJJPxCNb2wMn
         Ys7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhzhMCbR2R6ooat39ETDbSGzXGB8VBL5sic4rFqruXD8Sd+gtjMaR8rT1Gef0ezwUcNrIYXZKBPyP1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+icu0nTJtQgdVZFyhnkXYY2DX3gJ6GNBFS+W89R7YOUUhbgeU
	Ju++/wXVIL0pnXZjs997FQw1rPG8uhTpb4k4zSUkDtNAuNFdjwvdKcULe7UTpcZ9UUY=
X-Gm-Gg: ASbGncuG1BhKf9gISzunDGV0Ldzd+IT0jvxBeIy60Rj412pyq3BRoOUGwElz/4N3FWw
	XLR4n38cspzW7MdvELv8PaaNxH+Tm6BuPb9z1MU02QrbH4q9gBu7m+LGlcyHKUdN7IicroQ+l6Y
	mv4NbNAbY1oz9a5dQnCC4AVq7gbfQZxSPgEP7SOtjUayH/W8/BVezo1JvDBZcUx25yuAWCFHIgq
	Ne2QnSfi9MDwDztCNLKZz6245os7syfEux+7q8VZU8GAzd2G/jbKXUyf1KhxFF3nLJdDnRuPIxj
	aPyDLrti3u5cP+F/1CJ/jeeT+CWGd+s+USWNnoaA0Fz/sd3q6FBppcAZS4H/OmY36W0jhrLnf9n
	XrgHomJhvYZrWvA/n99HsLKUxnxNgQDbY7gk2IXOX/AApT0495+IbXpfEjVTHfHi88o/jZBZQT1
	HGPsaoLFoV9g==
X-Google-Smtp-Source: AGHT+IGvZf6To3hIDIuPP1h5aY9xKK3vy32PO8rqsycDPXi+APixSYDQ01ElkQxBZ+x0aZsdxcUr1A==
X-Received: by 2002:a05:6a00:6f8c:b0:7a2:6519:f90c with SMTP id d2e1a72fcca58-7a26519fb7fmr4281251b3a.1.1761175797589;
        Wed, 22 Oct 2025 16:29:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12b2sm392646b3a.67.2025.10.22.16.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:29:57 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 22 Oct 2025 16:29:35 -0700
Subject: [PATCH v22 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-v5_user_cfi_series-v22-9-fdaa7e4022aa@rivosinc.com>
References: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
In-Reply-To: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on shadow stack pages, clearing up W bit makes them XWR =
000. This will result in wrong PTE setting which says no perms but V=1 and
PFN field pointing to final page. Instead desired behavior is to turn it
into a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b03e8f85221f..df4a04b64944 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline int pte_special(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -611,7 +611,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	pte_t read_pte = READ_ONCE(*ptep);
+	/*
+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
+	 * but we dont want this wrong configuration to be set in page tables.
+	 */
+	atomic_long_set((atomic_long_t *)ptep,
+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH

-- 
2.43.0


