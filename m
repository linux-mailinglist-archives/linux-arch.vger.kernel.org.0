Return-Path: <linux-arch+bounces-12226-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41FACE31C
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 19:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101493A7833
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B2235072;
	Wed,  4 Jun 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Exqxvysc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BA1F428C
	for <linux-arch@vger.kernel.org>; Wed,  4 Jun 2025 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057406; cv=none; b=q7+BmRXBGe9KEw8RPp1vsw5xwMviRMar0AE1og+smRqTP8RegihCpQfJaxKxhu9n5InVdK3wG8gjtoPN10EI1X6YzT1OdO4fYkF20qkt/xq7lDTyPMKPHLVawX8PItnueMPClVfOVvsjrgeBv2jKDHDGNTYF8NZiBl0XjPfH4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057406; c=relaxed/simple;
	bh=6epe1IklbdE30nYdZrV0ZHwki5ITawyBnbVBknH019E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5RNiWyWWZi/aTH10VdnZ45F8uLqH8YY6e8QWhM7rhYC4tMVkPt6msAnEZWR0Z7d2GOM6Pw2St2JheS/LIpmPUNIGndXFa0slcQdIMvgpIVe3LNjI58bIfOY4M2cXVdmuXx4NmGLoy0do077vowDuOCPZDHqpSahYyLMGdbyWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Exqxvysc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b271f3ae786so8945a12.3
        for <linux-arch@vger.kernel.org>; Wed, 04 Jun 2025 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057401; x=1749662201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsODLDfRcPuDSErfbs+tzfaJx/MFrIF5cCrvvQql1Yk=;
        b=Exqxvysc44tA2QiFIap193qfdDCgBb3YA2VzSlyrOYBdrEFcEXEvwPymYkVWnk7UZY
         QKJx55iwFyhJXmci5k1eaUAp9tmM19Q5SiDz7HPzZIvKQwIyh9joiyYff+T/QayQG0Jx
         FyLd7+v/trbJS13Yw7KNdfRZYU/CRY2MuRQCvcIVn7tlEOeHVfmOHd1iYDZcOMQ9dXRb
         CcVVMSDCmPk3CSWUZZTBt/pZYfl8dyJNUPh36GCK9TTZc+hH9ju8PVrHcLjLDZDgCubO
         A9/JvbUERqh9wozzxon7X+JbglRMKftxud8SfbkSx6/vZNGR1m1s88fObK6HAzhcMHr1
         ka/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057401; x=1749662201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsODLDfRcPuDSErfbs+tzfaJx/MFrIF5cCrvvQql1Yk=;
        b=u2z0xDLXjipXAwwyl4NpBd6czcKhNDb3rBwk0NAUyDdlUuGo1+N60LEf1U/TiIC1Ts
         /s5sCVrGpwfSJLFmSjO9C1UOi4RhYK8nZu+6OvJKd3mFlzCQLxGnkhIs8LsejJBd70qw
         Afaf/ILDfB4z1ezA4wneFjGxZqZIkcPxmU8/ZfXosl9eZ4GdY5lAAp92G+d+VgxCWMFM
         3L8KlRU06JImHDPxNicxVukd14mE2Hz0+DlmsXMIOrclvYBQbCxpC3RAoSawWvUq5CyK
         sulR5e6lSCpnwosyG6MNKrwOIx6n3P8siXP98oUwWNni6dbx6PaKsQ7XCLeFtV1wc3KA
         zfNg==
X-Forwarded-Encrypted: i=1; AJvYcCUlln377t/LO6r1baf48g1oceaKL7XfbryIArm+O0wTPTY47GKR6YY9iLvIR+BF5dxNBoLY6MeWgsAH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47YLYZ1OQ812B01tKH61W3Odoob5VY8sSKg83xo0ZMIgaf38T
	TNq9eSgCox/XDAQKb+WDfAlsjvAAqUc7gRy7aaBZqZAKFVerSpGWM3kFwxPR4o6+lIQ=
X-Gm-Gg: ASbGncs9P1Ea9YtoSiQFvmiXAUQmDeG1c4Tu7es6DRkqzi5u2yKV8xxgEygHibVyMVA
	CJGCboG4j8KNaGRv1eSeokk5uM8vk23md8NQez31mIzaJrvj8Mm9L3uSetgIcAsgQz0oLms3k+c
	G8JitPR6CvL9fucZ+4RVGnuONt2vk80vsVLpcFpEkM1u30eqQf4zgcOaw88fAJFQcY2UkF0cXLX
	FGOacGkD9FYu/g5DLb2mLGj/IlMe1lVwJgFaRuDdKDxnytaqr0uhUouqewPj5fJTPjaflzX3wiM
	0o0okTISgUC6sB61YLIiNb1opnIY600ibzxFUT70Wq5Iyx0UrXgJfLzfcTV+zBzTF/B/albX
X-Google-Smtp-Source: AGHT+IF6+7HWMrKywJhrl4jitMY9SAQNbrLC1TZh5PiZA/JMuNouzuXYRzL70WULkmw+C8CMgKh2Qg==
X-Received: by 2002:a17:90b:4a04:b0:312:f263:954a with SMTP id 98e67ed59e1d1-31310fc5071mr4462982a91.5.1749057401215;
        Wed, 04 Jun 2025 10:16:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:40 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:33 -0700
Subject: [PATCH v17 09/27] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-9-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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


