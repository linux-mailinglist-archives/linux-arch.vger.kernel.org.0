Return-Path: <linux-arch+bounces-15233-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D15CA8DBA
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 19:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 873FA30F96BE
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 18:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2C234C81D;
	Fri,  5 Dec 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="DBJSkVBM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A92D5A14
	for <linux-arch@vger.kernel.org>; Fri,  5 Dec 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959828; cv=none; b=gLq98vRNfAq55QD544/hqIi+JoXBLIBt4AUctPTNoAwCf7OqsUBiAePpcQMiKbqnOhXyGlqQ/gbT0ttKA3AjljttqZMu8Vwl5pILNGXjzW17JIDy5y/J4YjJt9GlzEFg1DnMFMVveYUUHxRzXfUkW7C0bbX1rTFYqqx7otw9Mf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959828; c=relaxed/simple;
	bh=7yLe9hWq2WlkWVyw5cBB8KO8waygymuFRUw/WyJutrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nGXJfTObnISrSFFY4+/qc8jBugU/J7OysiBIEiLqt5RbN2sDG5TKGdoMiHzdmjGmY/RmI1oElkiUZYvkTgmEyvjVnBAlx/Nli5ByLmheP+coQdE7xS2fEXGZKGzOruIBUoEmV3Qoc6AroMINFJSLUH21RuueXqVLDaknwyP8wCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=DBJSkVBM; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so1401265a12.2
        for <linux-arch@vger.kernel.org>; Fri, 05 Dec 2025 10:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959822; x=1765564622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qa06X7BN7aAxeMRj1RtrRZw6MLM+PhxlK6i/AnJxckg=;
        b=DBJSkVBMi42qPtEzRXZpY+31ucmN6Q2tMtQYXIHd7zxPDn5VimsDZb9DCsyCxC6Sav
         nOpKFiSO5YFwHISd1t5ObK+xEIShFR8g+sUGvB3Dn6zmOJ1jEgxBXtj8qagY6xZG091U
         AsGeuiSfnjf3eFRiH0QIV8CHRiPS5C+0nbK3Y+9RLX+/6ySuA+NQp14Ex2axYkc5uUKN
         k1wT+jKTDG9U/Rv9tP2B2MSn1rUqgcJPDFJgWC4IEL6xfDr26HI81Vt3XSa7m9mXRgAT
         4KF4eLTB2Gxnuk5ryQ1p5Rtsxy+KJslGBC4gUq4bcrkCjgzDZ7xGjF5gun2tCr8Nqcej
         dbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959822; x=1765564622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qa06X7BN7aAxeMRj1RtrRZw6MLM+PhxlK6i/AnJxckg=;
        b=ArFmMnuh0NiUqpkrgLwbT3t9frVWz6CpPE5Kc7zTeaBzM1LK96jLykJM4DgtLOUoNH
         i/aRgXWqlZvaNtkN/iztetSO2mYiyfPO2u26wTVLgUpGSQi6WFbWjY8/68XQ/MRf7YNc
         0msC8TlgrDvyuqA0rn4CUT+0c5BqG+k90ufopC820zPEy1/l+sM86B/FT9r1oPlkdLqk
         dNAHkKrdGUQDCSn9ee0yB/zSVy7vV/hMAfIToPE3JcnjdxBTujDYuPYYnPW67tFdrdjO
         VXiDV7LBcDmaTTj4+dyHDMEHtHmYkagi4M9zy069kx6XuKBakjhH6BcV/mOCWyDdXM9I
         s4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVroJ85d6U3nvT8Is85wX+0DUH1ToNErTlKinbGEbKyR3M6OxBduHJDmweFrnoOKKYYsXREsqQTUuyl@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxH5v3vt/yC426LrtVAJIxVrxROyH2QYxTDqsgzvln/NVOb0I
	j7KX/VzqoOt/44aBkzcRJ0WyQwm6I3w8fDR4Y+yFLiYGGgvf3d2ICHfSEir6SEeU2WU=
X-Gm-Gg: ASbGncu4tu8MnQSF8UO/RARIoX8usEnmnAYCJ+dfRK/KeWtgV58fvDj2XFaort/7We/
	HnU8x3vHPtIvAURXJXS2oqdyb+CoLsZYjbS6JAjOVVsIv8pI6IRwomxgt5vIC4/EHqB7ysIho3c
	yDXoTtlaXdjWxFB4GFgaFGpVIcVsCzJbJ/B4QySC5gTcDJBPYk7FeaGwj9A+TPV/gsNzabcl9EF
	TGknOx1XGQZLtcChE+sf79xt4ffEaW9Z8oxmuO7vorGgc8aQlJc69+6Sgg+Jnj/ccHN4l07x1Li
	/7gWJ1ZZOYb16Z4ZGFuU2eGYNCTYnaE0vsjtb3uPDk5eS68L+1eWYzPxYkYa/96+cSnKaYL4PuZ
	3OrWhZkUVB8ZiNm2afsUSrvNXoNO95HQ9EdFxUFZrKi9kIzuHaIx28pSrCr3+h/Oyada6IE/b0v
	oqO3cNd26V4pqXlOuegDn7NbiBKSg2+bw=
X-Google-Smtp-Source: AGHT+IFSuIato7By2LD1j5BN0WlXvTN4dkTg3+zsfi//usJ4CscSRgzvoiXp1vgnstjZYR4syaJugA==
X-Received: by 2002:a05:7300:3084:b0:2ab:c151:3534 with SMTP id 5a478bee46e88-2abc71139a9mr127815eec.5.1764959822438;
        Fri, 05 Dec 2025 10:37:02 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:37:01 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:52 -0800
Subject: [PATCH v25 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-6-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, 
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=4345;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=7yLe9hWq2WlkWVyw5cBB8KO8waygymuFRUw/WyJutrk=;
 b=brRg4Sn8vtoSLKpcwx4+loNsIV5h3ZB1DTXP5anyC0qWKOWE2LiMPjioo+IiPxRaUxf/54FOC
 aXStfisB/ojBRwd6CwGucPTtiKuZH9f6XIZV3TLOlrJBIxk+6atHMhk
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

`arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
This is to make sure that any existing apps using PROT_WRITE still work.

Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
encodings for shadow stack. Above changes ensure that existing apps
continue to work because underneath kernel will be picking
`protection_map[VM_WRITE|VM_READ]` PTE encodings.

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 26 ++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..0ad1d19832eb
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <uapi/asm/mman.h>
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+						   unsigned long pkey __always_unused)
+{
+	unsigned long ret = 0;
+
+	/*
+	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
+	 * Only VM_WRITE means shadow stack.
+	 */
+	if (prot & PROT_WRITE)
+		ret = (VM_READ | VM_WRITE);
+	return ret;
+}
+
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 29e994a9afb6..4c4057a2550e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -182,6 +182,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
 					 _PAGE_EXEC | _PAGE_WRITE)
+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
 #define PAGE_COPY_EXEC		PAGE_READ_EXEC
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 795b2e815ac9..22fc9b3268be 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -7,6 +7,7 @@
 
 #include <linux/syscalls.h>
 #include <asm/cacheflush.h>
+#include <asm-generic/mman-common.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
+	/*
+	 * If PROT_WRITE is specified then extend that to PROT_READ
+	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
+	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
+	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
+	 */
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		prot |= PROT_READ;
+
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d85efe74a4b6..62ab2c7de7c8 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -376,7 +376,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,

-- 
2.45.0


