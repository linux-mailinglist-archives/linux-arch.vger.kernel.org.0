Return-Path: <linux-arch+bounces-8703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D09B5785
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 00:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3572284982
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 23:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193B212636;
	Tue, 29 Oct 2024 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hsw5eUa8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC3212178
	for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245492; cv=none; b=c+GKzoRbXXYuLyRa108SIOAyFqdX4lB85z0UXhdrq0OS8fWa94HxdWwOUchsbakJQu6m7txKugdkY75DOdQmjqEX1v+iYh6bB8DrKLwiqw7+yQNPvtl+l/EygDLs0oRaNGZN7ITw3JAKIMWHvVouq2NRpQc0EMHSCx2MRTzH50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245492; c=relaxed/simple;
	bh=ujGS68hMw9jXkFTLeBvM9lsLbHtFVRp8uvURcQO/JQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yh6+DjVm92vHZmwkMYIJvifipK1oKczMGRlpbPpNKnWDU6lxOy05dSYU1A8hi1Tu8IjUBHrCZq1uaPQ0NASKe8iNU0sIpbxCFqHG0k1zEDw+g3U3wXN4wFZ0D7fz0OrHDB4sTa6GUxcKbZXlwIruktUFRl92GBtbibwTSLG3OP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hsw5eUa8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so3602061b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2024 16:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245490; x=1730850290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0B+zv7jbCWDse6UooVJF1UXIWGMB9DKJ0N/6xrNRow=;
        b=hsw5eUa8GGE4vlFsEzRciZuKJMGIQc/fxhsvgSM9IbJ0HDXfGbrxTZQbgKVyrETj0B
         zj/lVmmQp6QkOKLuhJhRBo8XowHE6pVV5HUcs+Com/HOQID05rCOVgB0vzyGMk4IeQY0
         YuLUpCneC6lW/0uB9LnZYgUxSvHeD2XU47cumVYTN4G43PS+BANu41kuc7aNy2xrzDXl
         wp5IIGcSgsG/gacOOTItVTADkTwCgZ5tKWDdMY8j/HTmD8GpbWyQP6LH+IcknZQnax4n
         RggxckUyVguuiO7yoynKQXZiMKF4YufFDQq5+g70pVWbApMGMj7GWns8HnG9CMkVqAhd
         Clew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245490; x=1730850290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0B+zv7jbCWDse6UooVJF1UXIWGMB9DKJ0N/6xrNRow=;
        b=Hp5dBUXoQ0QsPb7v71zXUr3i505AA7JXpWFD0iWpqJBz3UmPFXNUPYGKt5Be41NOag
         yozmcK9NYvOgsy2Hl/59ktvxn1EdsPAODQEwywsHyc3LvaHHgx6q2yxMhgy7QRHCtTuL
         /+feBqNd1dm1g+5pJOOW+iQEDo4iYRDWts4vBjRV0p6W7qbpSTv+yj8g/V8g7Wi8xMa4
         au1KKqLnqOne1XcnP8Q66/TX5/rVnJdz7UnfBviu4ZGvhEHiTUqDK7A4yvrcysbxz2hU
         zsqqp+KixoNnSz/Tpja/rBcPOcFxv+PvUMYnd2gvbOgER4k8TDCV0dj1P4G8i6NzRG5s
         tuPg==
X-Forwarded-Encrypted: i=1; AJvYcCVx3LdVRp1CBArxfpDtxVs+Vhm+BMRr59GO0YaOicGbZRm5tO6GrUYjjIqbw0sT/4HaUYc99AQ0xBSR@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqY2+Fcg52dYeCPznf7B5DZ+rKMejKxQsBirTXgFnPCFYk5Pc
	D8qzxoV0+IpqOSEmkqusT1S/BhVApHnM/KN/eZRP99RBfYV574RBAfEHcM5c0Yg=
X-Google-Smtp-Source: AGHT+IHBXcg721hFEfeXndFELLRbZaKej/qAWRXm0LpVc3pKofZsRnhCap8fGfOK1cqNWExKjLYj9A==
X-Received: by 2002:a05:6a00:3d4d:b0:71e:a3:935b with SMTP id d2e1a72fcca58-7206306ebbfmr19631100b3a.25.1730245489674;
        Tue, 29 Oct 2024 16:44:49 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:44:49 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:13 -0700
Subject: [PATCH v7 13/32] riscv mmu: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-13-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7963ab11d924..fdab7d74437d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -411,7 +411,7 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -612,7 +612,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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
2.34.1


