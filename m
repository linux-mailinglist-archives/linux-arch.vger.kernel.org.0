Return-Path: <linux-arch+bounces-10085-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B21CA2FA27
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56867A3C28
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 20:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4518254AE0;
	Mon, 10 Feb 2025 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FfmTTfu3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88842512DD
	for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219219; cv=none; b=iy3pzvCp3js6G6HXArF2i4N+GfzU95InYudZnMf/m/MrJCle5msJmmBiVgItG0tMpIvZ/75yBfmJmLW22Kewp8SWRdTSkqJRBozNuljmN5puQDvVBcjn4MGk7Y4r/8wHlTEctFju+O4UYfSnAnT2YhZ8jZO5YC3MbUOuUmu/9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219219; c=relaxed/simple;
	bh=toOY3g5UWbhyzFvpokgMbtCDrGwGLK+0MjdImo2Zc6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3PDQV+A/RAhNmJ3jf/zcsd1JsL7jEX6Ww82ZSTNLR+9WxNXsl4Odq/sQShjMwxltGXw6rDUi4zkSxEAJSRqPXSQK2jvMIRoVkU386h7oVqTxXza2yKybbi1Ydq4oll7IRDdXnTl45OvtuHGxvAyee9wU59vLRkOtHYnOccntbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FfmTTfu3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f7f03d7c0so39205375ad.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 12:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219217; x=1739824017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1e5RgGuqZS+AKw5oTSgp47pWFJ0GDjWFc7jT6Xd5TJc=;
        b=FfmTTfu3x8QQRajXrmGIjs+GOia8ODJcvsJjPvu3VM51FPSWFBTK6Ih3ohnQgFOvYr
         0HqX4VRro8gtOwzk8caDN+Xosb+tkrsTGW8668+R9NzRzFeqPUe5Wq0ReRUXOZvyaEsD
         Bw61vGfFpLD/IoEPN1DDs/ou5LAAxevZZit18NQ3EdOT+8vOhJtyTRnBwZSgG5+1/CUZ
         OUSYo+JKPU7xwfxV8OepurqhsA4ggDEKBytiM8XDPSzj4WKW1jZUv4MFvBOoMs8TmDs+
         sgMEWb+A+FolyQdn7OKaAJ911QWbzxIHhyXn4Sj7MSsn52d69vlVul1WW4IKegEvCQV2
         nbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219217; x=1739824017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e5RgGuqZS+AKw5oTSgp47pWFJ0GDjWFc7jT6Xd5TJc=;
        b=Da7GRWc9PFkfvKRuxamWdR0EjZGbmdBYouqYqO+zfuVZIOosAKl06bEBhIJ+vDMu4U
         TYfDOjzzBhBfuEwwflaZUwYpZ7aeYZM3Esclsv9pitcGs1t5kavXfHOG/twHNfEU1fss
         Kr7vexTLjoHa/eS+CCVTitjzY8bQdf3zT0CzpC7klj7xVDImQ/a1vbRWJhKSWUcf1zLw
         MhrL0tHAqblUYXsy1WqFKL8QjpkymueirPPgoXa2bRAGZH3sVyy4/th1YhMAE+GqY8YX
         JDZt6rdORNOJvcUXYcTqYhDbIKfY1ElUE9Q3pyuI9t946GYVaw3hD8xo4y6FmijU5FtD
         5LMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVpRZLZ78H7TskuMd/p7stbWOLDD12CboujAXYhA6JYnH+5koVzjjd4xOITICs0m3X9qJBrvikhL79@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHaGnd3b2mY3Wzw7GdmTV4oKDqFPi8pYUWxeEgtAziiqK3wmh
	j/E1gkZRkXnFb/ImKqj7zqfTOqFm46lyQMrbmEiElnFiBRnboabUudoJ9C19/Oc=
X-Gm-Gg: ASbGncuZLfXxBpfp+pql6xg3ZqrF18MpWt9snPHcrNe7OdqHIRJzULfIgL+GKHAbeaR
	1c96eQVzd4K9LXgcHLgFdi/xzVSKYXtAYpS1L4nDq17D1rYD0lXc72gr4zFr/r4wrnVS9ebd0Mo
	WylJq8zl7FY1SYzSDnTi4iOqC0m08FmJxjj6mOkMNEMNglCJ2Cf09hHYIBVrDR0RrsR7zf3/nmr
	4a3SkmfSihHL43btU5qIvapL7fpmyRy6T6VJp26R8SvCQbyXm9f14+KL9V0gV59eUsa6pDt3+aB
	dLXKkYcdLzYViuVTMUhq7a6xEA==
X-Google-Smtp-Source: AGHT+IF0tY5SNTXDToYW1J21Hspvgjxz/6jk5/bs6ru5UkSgBD9Y81K/9+zJgqpvYHP1/U94A96iNA==
X-Received: by 2002:a17:903:234e:b0:21f:1549:a55a with SMTP id d9443c01a7336-21f4e1c8b5dmr268029605ad.1.1739219216953;
        Mon, 10 Feb 2025 12:26:56 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:26:56 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:39 -0800
Subject: [PATCH v10 06/27] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-6-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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

`arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
This is to make sure that any existing apps using PROT_WRITE still work.

Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
encodings for shadow stack. Above changes ensure that existing apps
continue to work because underneath kernel will be picking
`protection_map[VM_WRITE|VM_READ]` PTE encodings.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 25 +++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..392c9c2d2e78
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
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
index 050fdc49b5ad..8c528cd7347a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -178,6 +178,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
 					 _PAGE_EXEC | _PAGE_WRITE)
+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
 #define PAGE_COPY_EXEC		PAGE_READ_EXEC
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index d77afe05578f..43a448bf254b 100644
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
index 15b2eda4c364..9d6661638d0b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -342,7 +342,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,

-- 
2.34.1


