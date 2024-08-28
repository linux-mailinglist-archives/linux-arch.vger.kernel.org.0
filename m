Return-Path: <linux-arch+bounces-6687-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 281E5961E71
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 07:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA841F24FCA
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BDB15696E;
	Wed, 28 Aug 2024 05:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uoSIR4LS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0D15622E
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824175; cv=none; b=bnN/b/VOLS2ctHv2gntGbSMv4XT62nTc5Bxvij+PunhK1/NX/L9/nzQTheMf3kZsz+QYPC/h1MY+E5ee5e1ozsVo67iupmdtriCflgWzBS4EnHG/WgKcTIPze/PmCHAofJSe7wmW30UZdhgwLm1Dt4HV4jd8hJGhPzrbM+gc+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824175; c=relaxed/simple;
	bh=YMF9irkRUC4sRvnkdcE8hTIaJNmeFPHDQEKHg4RlOyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYLan2GJJ2ae2NBkPUtJqxJkVxBcioF6ttKL1eo9tYmPv2zLCvB+nAFAnmvx2ptbFLFP/TD7JxpXs8Fum0pJPf+OYsyNnM/o+k3WBkF0oax4c2UT+/xcjm6iY7UobVzXcRHKVH7yrt1G7cf1yTS3pK6dy+j1BpQNOex4v7IpEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uoSIR4LS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc47abc040so55315455ad.0
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 22:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824173; x=1725428973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moiMY/9kOk6Xzt0Khn1FkF8wyTL4BDNBgOSp+BMugag=;
        b=uoSIR4LSPvDP1tFq/0h5MEJg8dsk16QDWaupGxbVAv8KxdaZBcB4tRsOefHkUmQJ9R
         eZew4rG3oADKQfXiOL+aZYkv8idpXamqSK+OwffdqTOs1Baz9IXtFoSLip8+cWVySTPM
         mshafL8QwUY5adSttSjBXstg7IyhTQeVMZ0+Khx+a45XtKRaAReSWLciRU6bk0AfBRfb
         xLSaH5WQQMLGR4UkLzxXHMW5p16rwmprAsml6oy+XZpTsuquxynPby3THl6kHLubP/6S
         CgRBcuKdeXoM71WaOlP3x4/zdjLkKjycgHEm3nGWrWeyvzENo5Us8deU9FifnwG68pim
         WWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824173; x=1725428973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moiMY/9kOk6Xzt0Khn1FkF8wyTL4BDNBgOSp+BMugag=;
        b=qu0+xqrScVQqZp5g+gO+63mFwYlZ2pX3qmvqNL4cYNBQcQmGzvAEO8OUkjAGKyhBHU
         IaNh0Nfno1SuF7yOXQTo4izEE0FnHwUQizqV7Ak2yN+ikNmgFNtzC+rVVfUZG7FynTDx
         Gh3Ft7E8tFgE/ePA6GulOilXlb5V2HCppfGMQdzshACGL6Lw7jgTSqpaA9G9/RPzwUB6
         mZI89KHwB/f3pRwQwE/kL7/xcL5QI345gqaTgWjTiblBFClGg6CWap3S1T/HjOZxoSVu
         I66Msi2kogbqj2xXjmTqJd79m7ZHsw97ghT5mXHXzQ34xhsFpw2UgNJ/lqhcFW8OZ5hN
         LYRQ==
X-Gm-Message-State: AOJu0YxM3M+3KJz+LqerqEImnH5S/tVwDvITJ+NVnisL4iClXDxuz0CQ
	j0X4uw0coTHs3WylMzLoaY92Vhb7XB91Eo9XVg7A+f+JWY8NkM8vHxQ73fsviX8=
X-Google-Smtp-Source: AGHT+IE+xcDspGauSp7IVmRnQSeJseOyw+wVLX4elXR4/BGbU1fHY0MaCzZG4/pxtEucaF+r97Z9DQ==
X-Received: by 2002:a17:903:124b:b0:202:4079:1c19 with SMTP id d9443c01a7336-2039e47589dmr164242605ad.14.1724824172722;
        Tue, 27 Aug 2024 22:49:32 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:31 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:08 -0700
Subject: [PATCH 02/16] riscv: mm: Do not restrict mmap address based on
 hint
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-2-46ff2eb9022d@rivosinc.com>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2260; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=YMF9irkRUC4sRvnkdcE8hTIaJNmeFPHDQEKHg4RlOyw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XbEGN52ULpq4/39venW688upWgwFDj9spqW3rOd57
 Wdme6Ooo5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgInoxjIyLPq831JpspB17kOr
 jRV1b1+9OjXz6TVOvZStd2IFbrHtWM3wV9buiFXmKu3sWVt1RJfzLlfjNmD+lbK6aQ3rc0+mG/t
 jOAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The hint address should not forcefully restrict the addresses returned
by mmap as this causes mmap to report ENOMEM when there is memory still
available.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: b5b4287accd7 ("riscv: mm: Use hint address in mmap if available")
Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
Closes: https://lore.kernel.org/linux-kernel/ZbxTNjQPFKBatMq+@ghost/T/#mccb1890466bf5a488c9ce7441e57e42271895765

---

This patch is pulled from [1] for ease of review of this series.

Link:
https://lore.kernel.org/lkml/20240826-riscv_mmap-v1-2-cd8962afe47f@rivosinc.com/T/
[1]
---
 arch/riscv/include/asm/processor.h | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 8702b8721a27..1015f2a49917 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -14,36 +14,14 @@
 
 #include <asm/ptrace.h>
 
-/*
- * addr is a hint to the maximum userspace address that mmap should provide, so
- * this macro needs to return the largest address space available so that
- * mmap_end < addr, being mmap_end the top of that address space.
- * See Documentation/arch/riscv/vm-layout.rst for more details.
- */
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
-	unsigned long mmap_end;					\
-	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || is_compat_task() ||			\
-	    ((_addr + len) > BIT(VA_BITS - 1)))			\
-		mmap_end = STACK_TOP_MAX;			\
-	else							\
-		mmap_end = (_addr + len);			\
-	mmap_end;						\
+	STACK_TOP_MAX;						\
 })
 
-#define arch_get_mmap_base(addr, base)				\
+#define arch_get_mmap_base(addr, base, flags)			\
 ({								\
-	unsigned long mmap_base;				\
-	typeof(addr) _addr = (addr);				\
-	typeof(base) _base = (base);				\
-	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
-	if ((_addr) == 0 || is_compat_task() || 		\
-	    ((_addr + len) > BIT(VA_BITS - 1)))			\
-		mmap_base = (_base);				\
-	else							\
-		mmap_base = (_addr + len) - rnd_gap;		\
-	mmap_base;						\
+	base;							\
 })
 
 #ifdef CONFIG_64BIT

-- 
2.45.0


