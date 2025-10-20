Return-Path: <linux-arch+bounces-14208-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D56FCBF36B8
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BEF0342877
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713D336EED;
	Mon, 20 Oct 2025 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="XxfPOI9M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E5334C30
	for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991781; cv=none; b=lMMkqmH1DK5GpAYpZnLBdg7kZEHpoKt57gi5WyPFxqK9cd7oIJqd/aXhS2rVPnts3C5byB6dFAOCLLmy50J4TDFI5v/f36ye9y1XzXE6Mec85u/4ayU1r4kiM9XZXpwNAsHyDyHK670DbjkA0Uss+zhmn0w6R2lmdz6ByoeHJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991781; c=relaxed/simple;
	bh=vcSFEpMi188ecJ1a+8U/vzSq8fWrIzbce5udSf1uoe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5lu6Ado7t5RJZPnMJDC/H83UcNokhtaKpbw28Sq0+tPe2CDE2dzEJ4KWZm4qn+TvJI9c4tWk2uTqBwyI7Whtqrcx+k3I+ve/osqST3GECVbMx0gT7nxu9VNkH6NQ8Sp87vcvLxa7Kyi56hit6Gm2JKSipgStLq/++UCWqxDYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=XxfPOI9M; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27ee41e0798so76139095ad.1
        for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760991778; x=1761596578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kF1sb2xLtNJ95mXf4y9UUDJse6Qaa7/WyS6RZ/Me9sw=;
        b=XxfPOI9MJN9UY5fGh9Plxv9DBnD9x2MFUTfZdD99FqYhOvM4c6YwKrC50tnyoiiQnF
         uu3BYqEnGp+8VZrD8pAgZ7/odUIiExkeqc+4d77bQCsGh3A1pp5tGGgpihjqmIEaA6wt
         T4DPcWEaURvmzXQzw4bDq3nr4NiFR7txr/Bjp3exjCxlc7Hbv6GUrQCo7rBdsb/89m+6
         hcrxSGXwklbqzNg4mMjHoz86RLvVPvJ/3jzS+yMNJ2uMqsJRKhPOnVRHkArpdoFY5Sz2
         8UzziOQlkg1lK+kT4V+gbxVzv2h0G5rQBo7fp3Yl3lksoaw4MAyvrrCxJEiJ7suj7DLT
         DxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991778; x=1761596578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF1sb2xLtNJ95mXf4y9UUDJse6Qaa7/WyS6RZ/Me9sw=;
        b=VKZdgVwox77Iur5rbYQJH2omRWYpdZw/z22xBzPYt6dJRBZFQ5xOXaE5nOZ3Lr0ZB2
         4a/sTxbasoRKqvC6LCoFh7pKS/uACmMBZk8o5CRBH6Qqf/uhmJGNfDr8NmPkoJ7aW90V
         c+Tk/6gHjpLPYAvxyRqD0AlRYiw9zhy8NCpAuM1pf6qz11Ktn1ituPzsrHJR81YzKNFj
         BYlhgglibWs5gPFo0wvzBy7CW6lssJCWNegcFcdERSh4/T+evwDcbREvOjcvJPq+OXxb
         unZCObAVIrWzyjMEsb9espNrvYU1RnUFVoSUJIOKvpgNSOnPf6M4hWDTLJ3kIrTXQ174
         9B2A==
X-Forwarded-Encrypted: i=1; AJvYcCU768bJ+kWC8PNcO7Mx0Q6URI1l31c1XpvHKcyjJaP/tL30uIpteBT3MwAL5E4OvubFGHr9N+OCLOj0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6q7efIZ8J3i9lQUstLhdsUNbQj2R27eV/lx3//8F3GBHZAohr
	LebOlIHRjd40LdS/Kvo30809/Qe99kq08XsFeQZm0K8QaF9jcGV9YugOuXKSFNWM/oM=
X-Gm-Gg: ASbGncuv7dEhQ9txCeLzFU5QscwVdh2TGLXftF8Z3ztQxvLgKWhgQxRZmBexlDH2Jo9
	XfONhq34uTGGZnOgPE8kx+GdYbqoLUeOG988+S9swGRoFREKtM9RXiyaJqqTWgWxmQqlKCeBiBc
	scVv9dBb4e6WHe/Q2STSrrk+pCJV5ySF9UtC2Mf8Wuoy97pVOiMz714XWHa8vL4PWzjypv4N2zG
	tLXYCaF9/M1GsWn7SJQmc9Duyp1EtIbJ9JUYxgKciu21BR8trI56PuEzs/+bs8wDEO5Kia0tz6O
	xZD806BtDUlj2rqubv4WiPzOdY17YwRsWcXuzCYPwyNGO+2Z5CWi4PYV+/RiapiWF9QnOX7goId
	BjbhbCRKsJhb/I8xvb+/qXnnGgNxvuQqhZgya3KFYZ4csQg65usDLyd5zUZow5BvZLddFwW6MEj
	qY544ujrm4gg==
X-Google-Smtp-Source: AGHT+IFjI+Eo/gAZahP1YhdcXcRCsIf19VRdgdLmzm3oNcVwOeVwlLY6tG5kcvmHgKRdDvnCUjEyIA==
X-Received: by 2002:a17:903:98f:b0:277:3488:787e with SMTP id d9443c01a7336-290c9cf8e7fmr180686115ad.12.1760991777715;
        Mon, 20 Oct 2025 13:22:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm8443240a12.14.2025.10.20.13.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:22:57 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:22:38 -0700
Subject: [PATCH v22 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-9-66732256ad8f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
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
2.45.0


