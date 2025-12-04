Return-Path: <linux-arch+bounces-15157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F3CA53E7
	for <lists+linux-arch@lfdr.de>; Thu, 04 Dec 2025 21:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92D63184018
	for <lists+linux-arch@lfdr.de>; Thu,  4 Dec 2025 20:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647234D4CB;
	Thu,  4 Dec 2025 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="AGOMmmJk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754034CFC1
	for <linux-arch@vger.kernel.org>; Thu,  4 Dec 2025 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878656; cv=none; b=bCv2D5TLjZRyjskkqa4KrOq/IfQix8X1Ut1i0V+nDU6gES2iBDK99n8OBSMatvHHpwSPJHBNGk3cPappaN+/hv50jRSmLTL8Jpk+p0NGjk0lpWWOB1mEd9gtEwxfgP+nqFhVJvuE8VLzem1SWWGuWVzSB3MDPRPU94aVVq5qGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878656; c=relaxed/simple;
	bh=7yLe9hWq2WlkWVyw5cBB8KO8waygymuFRUw/WyJutrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phx5MeemdLfwB41L5JLq9KGstfrvu8pGvTUw9dMubw+anc8C8PPb0obIUroK5nhhGyjPLP6zC7ijC2krkXQPSuKvZRIz7B4SoDxX4DSmP4eWljKCuJ7UqPTBNaA4U+MVEwIRyuPBw3oDPH4QlApxYFE6x+c123aU9PlqY/URry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=AGOMmmJk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2980d9b7df5so16219165ad.3
        for <linux-arch@vger.kernel.org>; Thu, 04 Dec 2025 12:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878651; x=1765483451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qa06X7BN7aAxeMRj1RtrRZw6MLM+PhxlK6i/AnJxckg=;
        b=AGOMmmJkkSozy02IWQDisUB7aFcK//nbr5V8evuBFUyJWsQgy5aoJLuODy7A1M0yIU
         US8/vTevMK1OzeSxXYF567UFOH/GAuRQ6REoTxQZU8EVyoL+/5yvFL4BQRQRU/wa2x26
         viVBKvd6z6Ls5x/NEcNaAwKVQ+ueg5VE7gFzejXir7LujWrgDqS5Dz+aIaj8QmqQRBZF
         BzgXALKrX7GqxI2oi6f3VWOkSURCL+ir61Uc6KcDwr0LZ/SSJE+T48RMj0f4H+eS6EyW
         V+T82YHSA+mKNLmTlmx+agwjpEq4FTRXTV9p6rRO+PYH/axjvdrgbjgSDXeJWNCRxz73
         7Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878651; x=1765483451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qa06X7BN7aAxeMRj1RtrRZw6MLM+PhxlK6i/AnJxckg=;
        b=msVqlVC73H1Kehxe8VTMW1YkiLlfgYyOLnMEji3Hp8RE2Jz0j0o7+BnxIBfbh9Pobx
         rHNnkAL0kJJOvf42d8gNe7aBnyt67V5RTaflZdWkkVC26fNXTGBYlpL8HqojQ+Dxso7r
         8KIme5tiOyz15LS+yMpCw2w9m5g4Zi1anfPVmoeZxsuzoKB/1vUdYJl2xXmOLEohMbsi
         XJATCBVEEVQWq0QvE8bkQmffufLwemaddNTAcEp2M82VuQdrHOBt6pHBHrKiseno/PVF
         Ab2JzFsk7H/pf6GkAo9BY5V7vj+9QoKOdCUZAMQkHA86JIKU+L5S6EevRATvax45uuzI
         KVqw==
X-Forwarded-Encrypted: i=1; AJvYcCVX2pSuo+YA/Nid/7OKThxcQ6NbqPgCPJ2ivEETZMX2U/v87Yn40p4NozSdYpXUJ4AtY5btZ1ycI/xW@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyftS7xPN6ksuW/tN+MbVaWV3ajFQgFP+K67R0j8+X8VP43XY
	9cmPpDkltx6Bf6Q4hk1Tzx/WvUA0AhYxQSgkqGCsgl6XgJIYZOHyz1VMZyjBHUPdKbY=
X-Gm-Gg: ASbGncuW2ByR9xXDGGZous6zgjOx/JSr14TkMBj2MxDN2k3dWitxnkiDNxr8ctqCOxL
	/un96gP1O4LXw3JmaZUBFO/h7aDR6Qts3Tt4tuZtunJmv9yleVZ2Fjk4u97RzCeHqp9GjhxFsaV
	Mnz3Pli+BwRX2z/13oobf29Bsnme+xc4BSMir7TljZqXxDlBDpDyR5DfiK2jRGhjqvV7sb7JC/k
	RZFmwZMMxfes+ykUg8z789MiougPC3zjfuZXfQV5pdrJQxi8kgRE2IyBvVCH0wTospGKZCCV4xE
	L/x4eSKFpiyL2B0DIAml6/KlzpJdKU2TPOKKPdjDKUwe6zeVRweQVq0hHO0gC8E/hfw+6+8Ig2X
	tblTdFsfKyKhiRBfRVC+aOUyc34mmWlOF1hdphZXm3fbQnnky9wkfh+t0zeyVJY0FTvTf2CfU0h
	yq02SfTPlRd0EOx6p7BLaEb81wFshCh54=
X-Google-Smtp-Source: AGHT+IGQ93TqFVL+sx8jsqiI8XZ+MJnFlOmBjVkc1eOo+ShzyvN/Bpvd/OzCquioUD3nqZACMQrvyw==
X-Received: by 2002:a05:7022:aa3:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-11df0cc5e15mr5352198c88.28.1764878650785;
        Thu, 04 Dec 2025 12:04:10 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:10 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:03:55 -0800
Subject: [PATCH v24 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-6-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878635; l=4345;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=7yLe9hWq2WlkWVyw5cBB8KO8waygymuFRUw/WyJutrk=;
 b=4OgDyO5tFJc8wg90W1KsiGKi047tWI8HtvaRrWwmNmenU8ADgWOP8b1W62zFmhDNTHv/KW36L
 xv14zidE25aBEmYL3yAmlNekT+HnSHKI91F7Dppn3WkodGabRQAR+R0
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


