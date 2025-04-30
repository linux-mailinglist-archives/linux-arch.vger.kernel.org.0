Return-Path: <linux-arch+bounces-11731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD46AA3EDD
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 02:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163747A3F86
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 00:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C4C2561D4;
	Wed, 30 Apr 2025 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="L22v4ol8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6502566E8
	for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2025 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972217; cv=none; b=h3iDLvbp4KjOEqABVBktHh/fd+aAdN5jg4uXSz8gZzh6zP5zyTXi6exEpXHhuaaMuYyqAuMQ/G9r5dqnKtioXwuFGNVd7gUFXgI2s09+y6hTqT5nZvf34kCMXTpNIftTFNSXWrjbSKI0vFp9P67XHBmofoISgfh6DHPHEhZ1bB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972217; c=relaxed/simple;
	bh=6epe1IklbdE30nYdZrV0ZHwki5ITawyBnbVBknH019E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXkN5wkVFQ0aiOyJWPQWN+JyhuT6PodotEw2yVWevXV9LiI1G7AV6QP8IawFQa7T634ibLHgTxntpZKm7H6kMDkVtqaecW71X/T2zGZidgMk4ezXQMj3z5HxJxgVZoH3lLYKJrKMxj4ofTvXhngbbk/sLDh2w/MrfTEern3Jz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=L22v4ol8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2243803b776so111468675ad.0
        for <linux-arch@vger.kernel.org>; Tue, 29 Apr 2025 17:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972214; x=1746577014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsODLDfRcPuDSErfbs+tzfaJx/MFrIF5cCrvvQql1Yk=;
        b=L22v4ol8y8KR7CzqC463COkzA8qSb4dl9YBn/Ju48YLVisEsN4Wk8NzMdYkiQH9wHM
         Z3lcFxqN6MUHZPc/cvJgI/a/xAbbJqN6oDl2Nq3FR05E/WbSbczHAFcYRhifIQa2u5ii
         NXtLfSkO5ocEwxI8ZciO+kb6otd++pV/hax+sCmk690uyCTvoUaXj26L2bjp4kuVemCh
         1pdHrSdtblvTVgL2Ij84crtTV3vmuM3Lv0iRiGJfIPBnSNCGzJU4e8B30tf+hUC/+Vbm
         JadZWuirlsBfKoP+wV6bSp0eihzJD0UTCh76ECgDxmD74TUKgz0KFT4JVLccE6TNg3go
         w2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972214; x=1746577014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsODLDfRcPuDSErfbs+tzfaJx/MFrIF5cCrvvQql1Yk=;
        b=CDRm+FSVO6cSbUnxCj0uQILk7ek7naRPuhPtJffSlfo2fpFzodIb1r7Eh1RApEgt89
         EPfP/nNTZ+0Cgv27G49UrbLHBgv5Ed73OrnfiCcgOg7+V/uetbHL3+vOzig85GxS6bEp
         nSjLkoP2FJEFaX2FQ9EXIlh59vNI2anV+J7GbwCOO8N1DWm6b4TmfeWyx6CiEB2vqAtZ
         klmH2Z5nV7D4sLXqDMBT2TUapCML1A8czmNh/SoXhqoz44GhRDaToShYiwO6Lys+cp6i
         4tFW9f9yMO+A5QuZZwDEHb2ZlxyoWO3Sfq1xsgEMbft2W4a3FjXsfxQHD2VovPlgs65/
         e6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGSIOij3WT0FtNe6rtvo4DPYpkT6n/p4jQ7iHVt1nmUN0iXUTynm859Ocz/5yxA5OIxHKKL1G3tKkK@vger.kernel.org
X-Gm-Message-State: AOJu0YxSieFph8KybBEDpXVcNuplISf5REVULtOz0u5wXbi73dI7cZqG
	flD+SdP/SVD1rpA9Y0fBMrvrY3KnYWzOXzjPzMeMHe0kpfXZ40IQpq7dIRIX+ls=
X-Gm-Gg: ASbGnctx4wUGjS/9VMC7RqjU1QEGcWFpE5EnD3zgzwVUhrvLjGs9RA8eClv6VBXwHpC
	8jfecRehxjhyNLIHUWuq3OSWSPXnIVvLnEQAJgM5cuIfDh3DM+gOvmEL9BSTyLy7gEf1hZfavgY
	HbLF960hliIMn1uKnzKZjYGs1srP0Z6vZbDd89i9Nyp5Q8BSgRwpGiUJ4WQxDYsWwFLOMzNRZMQ
	13Zz4VSNksyaniEvXqzK3m/aty3yMjx6AfC6UzXe6mTAnxXvxNgKP0kpVWul8rI1bHGxOLuE9GI
	GxIczdMykcUIYA+i+XVHe3J0dIzF3mONWsZKj2oJBW8N2wQ3ifM=
X-Google-Smtp-Source: AGHT+IFJTmgyX5+R2cHG56gTAhOoSWDR7FtiznejYy+qmKOCH5eDKH+EG+01nS/OcUb7Pgf8hhzsSQ==
X-Received: by 2002:a17:902:fc47:b0:21f:dbb:20a6 with SMTP id d9443c01a7336-22df35a39b4mr20572645ad.33.1745972214477;
        Tue, 29 Apr 2025 17:16:54 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:16:54 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:26 -0700
Subject: [PATCH v14 09/27] riscv mmu: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-9-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
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
index 60d4821627d2..4e3431ccf634 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -423,7 +423,7 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -624,7 +624,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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


