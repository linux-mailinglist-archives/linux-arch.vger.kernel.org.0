Return-Path: <linux-arch+bounces-10621-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE13AA59877
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E287188FB84
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 14:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0E22D4D1;
	Mon, 10 Mar 2025 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hXdkHlhV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0925230BF3
	for <linux-arch@vger.kernel.org>; Mon, 10 Mar 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618377; cv=none; b=LyhT2PAyAPwDdzLg3LIBCx2dSVa1zgtIP7AZ45DZXyk3k2Ilc9l0qdA5wc1ffZrrWW99roZjS6l+Pvt9tjzMwATFCSOPwtqqHgVJRCf1A3Dcv0o4piUMM3s0AHF3DwmyHZuyX1yUeCLhlcrz1J/mR6V94VbjG9xIS9E3eI7ucys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618377; c=relaxed/simple;
	bh=e2JFB4Jy2B8PEfrSQ43O9FncAUYVFHD+Rwfp/3fLFok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vpht/AOfRhLXKuOD06rm9LnZF4AKI+GwjZ0D2Rb2O1iGurcGD/F1XjILSBEbdG0YtJgp8T/O9ZkFRnuQTkmhM+gIr0K/YYy9qrvKkohasaIDfcI1QI3ffxxIFv03Fd9MTwVv/062sabX1sfmizfYWPCHZMKXu/rm3l6Leuz1dUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hXdkHlhV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239aa5da08so68477485ad.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Mar 2025 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618375; x=1742223175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kL+yIoSlkTX0SokBaTv1DsPGjl4jKUPC0i4GBiCWGFY=;
        b=hXdkHlhVSbaVzNuEvGH5LfrFRTaLguNHfMHcHEyYL5zZeroFeP82FUwM4p/9Croklf
         Wi9MrAHgamGla/nDLJMxpkI6CIObKjn7QCIe67MrK7v6i6z8Vchy+15zyCYTBcQrnxN7
         owiYyKoofIPyyjmvjhG9O3iPZ/xF+FLDyDgC3v9f4gYJtrGmHf/NCW1CuWizH8eF2A3A
         tPysS5Bkrw/M7ssVyIuMfJpd7rbf1zmv+wa9Kh0NoHv76q+Q9cRVFj/r6hEZs9VfMc5h
         Dgm04Hapceq3wpIeLJZyvK5WQzkZ1UePpEWEM+2DAIp+xGGq+r1kZGC4I7UNHSPNVDcy
         WhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618375; x=1742223175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kL+yIoSlkTX0SokBaTv1DsPGjl4jKUPC0i4GBiCWGFY=;
        b=ONVMIfdp7avZJgJw+VswBtKQXsT9mGsjdylNF8xTEP7AKIHZ+61LPlebTVIRTDa7tL
         uNwy1ECzZ0xL0xlSQWbEM1h9TDQmlG3OLzqpIU3EsbAvKGy3bNEnNUpf3YRh0rzvaMwO
         TQOwfn+IjUj4sbHkgdrlvEcqFcQdGH3I/pDp3gjry0UFM0udr2VBbhuIDRmQMcT1P3J+
         BKfakvz1yfHtvvoziEqY/U2V7NC8cDrm47iP8GWTESbzKXEPRuzRE8zG8HWW/s//yqUC
         vpKc8/8zN9yX94EksBaZxUXgR5wQPEYedjXCq+oFSA/soTbySY92vHiP8UReamovaJYq
         6vQw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ALotLyNKeMZ9mUiaZOZYKW5xcl5sDoqs+H5mOVVT9AF328LUd0gKI/vjVg7wXMOyMOZdXZb7QHJE@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTe6W6VzcW4BLmExNcEMu71pelY+4JOwcw52JmzEnBzWz7p2E
	wVehNfU2x0BAz81fGLAFfD0R9QXR9MYoWQ9qXGfJS+KkrYQtq6/obDMb6pNS/+I=
X-Gm-Gg: ASbGncs46Z2kbiQzeYsjKQoKzE3GXsV8c6WS5HzFbqbRnm0L3yRt53GfG5Pm4aMb2Y1
	IEMIJhDE6MMRT5xhrxr73Ux4KkLG0/T05P75agU0Esxr1QosXg3FUwpNoTJ68aX3poJ/ecKIuDh
	ri/+AQ3oz0R1VFVNTX7P6xCns069y3vOB177/EcKmXAPSVtq7rQoShICJwv3BP40YnXwq7WDj85
	VZXZhkP8nQ1hXyCbyQXQ3BX+DiI45ZHOZwxs+d1IARfDHdW2gY2vAW2Nifn2vXQ6N7tlcBg76uU
	yf+jrm5x08plgxnRhu/j3wk1gVopRW/QPKQQ/UFAJQVl45YGM26rv+c=
X-Google-Smtp-Source: AGHT+IFKPuh8cOHYjBgEoM7t8cHgv4gW4YpL9WqheJYopfOZX5sbWBiog25DM4bQ+IO4xPTW/pcKfQ==
X-Received: by 2002:a05:6a00:14d1:b0:736:755b:8311 with SMTP id d2e1a72fcca58-736aaad1daamr15723454b3a.16.1741618374533;
        Mon, 10 Mar 2025 07:52:54 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:52:54 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:31 -0700
Subject: [PATCH v11 09/27] riscv mmu: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-9-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
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
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ccd2fa34afb8..54707686f042 100644
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


