Return-Path: <linux-arch+bounces-3413-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74775897C4A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 01:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20791F230F4
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9915886A;
	Wed,  3 Apr 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S7ognDjN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80A158843
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187719; cv=none; b=aPGarqDy23pAekxvB+vs7glxLkl2Rp3K1OtMFX9dRsLiBF6KnHdR66tTCyUAFqTI5qV/NevMDGN5dBiGgGEaV2JnX5xZS+OR6uVnJ53iFAf8OYZ88obl4+b6cPHSIjQE/cWC6OT6zHoQTGPH2q/YMrBps6um7oUMKSV9Tb07oHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187719; c=relaxed/simple;
	bh=6VGNDTy28deWBBLZj+Se/ZgPbompO0iK4xDtjnyQ1mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkGKTkjQpLzOTEk7XUFlBGLla42vS3NBuJYV1gcqJWtRDFqf+s6pKNYndIIj+oZNMQ0YIgLAmAMLnZuUOLrt4CzdYTrBzxlMTmH98M587mCo3ZxbnC/mEm4QDExMWgrdeeqPHiPCmSbjhcw1lcFHhXqj3f5z0rPD+lGSl1Qlzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S7ognDjN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1def89f0cfdso11753865ad.0
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2024 16:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187716; x=1712792516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lX+9+cMysL2s2bh0/j36OWWXHnHHgmfQfoaQ0p+lk8=;
        b=S7ognDjNirjLnqJzpHb2VYYdDJpYDVSMk315+66cvJFsNP8obQC5og8fVUR0N+xHoG
         +hdVXsWsLyKRdMARUdVHnJmIYDNhIDbuoz4jjx7s7aCrCvAngOdymIfyUT9OZWI1vIR6
         xrYz9NVbSXzcdAcYRXJAQ9/BwHEi/eNgz9e5RwFfBTIJxT21e3mVXZfjYBD9Ja1ToSPN
         3e4xun9mbGGkrv0NwyAvX1e8vyDzF6vUrpQrAKtlJYFRa/zRz+qabSEeTxyj2aM6MHZL
         Ck+atdQY8PfE+I1KoHFB+QhbnKCka9+s33F0ygcBvWIahbEZ+UTLAuS1WmE9xu9ETK45
         Iqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187716; x=1712792516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lX+9+cMysL2s2bh0/j36OWWXHnHHgmfQfoaQ0p+lk8=;
        b=gyK8cq4sgMVMrcbEMzO4lxhF0KV1hivqPhyG7fJotHQzKGtERdhC27GJbTSl/mpnHt
         8y8ES2uRWSyR/FIc2nb9c69t1+j1J6Tn7Xf5QHD7CCyT++TChU+R49DmxX8ZB1zv7lbO
         TGNWdnvawPuvuTuHRw9Ta8iZso+o1qYs9hkPs7GzEVKFr1uJ7r0Lp5xdaQlWsAFQltrP
         0yeSCrnrJjPNTjfBrcxq/BqoYdny9DMwBkaJNjFfWmHpwvJTMLcTyJLAlLQ9YNN+cRB6
         XaZEhQAcdjKC3qcdzDzLdAhh9Rx6daqFpSJ0+ppGnnVrE4lvTLPs3l0oRgoGUqZBykk8
         jACQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGgISTDnKLK1NAHTVXnr7i3gaxQofnRpFpxsvt/yICDyNWCZLE7QEZaJ9c7o0gkHaCjoGsjA/w/lWxRTKm+mT0lrgq6dYaQeQcpg==
X-Gm-Message-State: AOJu0YzrWwKOsfA2aBKQefxm0/zgccuCnzxb1LnO0OU4j9n6Skvy2kl5
	uS/BJh6D/9fftR3P++JAbJKBLUG77mZkuHb5hY8t9uGLHklZKt2Cd+fVerXwxPk=
X-Google-Smtp-Source: AGHT+IHn70WZbF+jlCONe2EcRRr6ZCh1IRqHu+QHyp4yjMBW+7E5Ek9bYAqg4ymMIf0JA4HyBbr9VA==
X-Received: by 2002:a17:902:e80e:b0:1e0:b677:293b with SMTP id u14-20020a170902e80e00b001e0b677293bmr5847942plg.29.1712187716595;
        Wed, 03 Apr 2024 16:41:56 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:41:56 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 10/29] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
Date: Wed,  3 Apr 2024 16:34:58 -0700
Message-ID: <20240403234054.2020347-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 arch/riscv/include/asm/mman.h    | 24 ++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 11 +++++++++++
 arch/riscv/mm/init.c             |  2 +-
 mm/mmap.c                        |  1 +
 5 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/mman.h

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..ef9fedf32546
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <uapi/asm/mman.h>
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+	unsigned long pkey __always_unused)
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
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 6066822e7396..4d5983bc6766 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -184,6 +184,7 @@ extern struct pt_alloc_ops pt_ops __initdata;
 #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
 					 _PAGE_EXEC | _PAGE_WRITE)
+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
 #define PAGE_COPY_EXEC		PAGE_READ_EXEC
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index f1c1416a9f1e..846c36b1b3d5 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -8,6 +8,8 @@
 #include <linux/syscalls.h>
 #include <asm/cacheflush.h>
 #include <asm-generic/mman-common.h>
+#include <vdso/vsyscall.h>
+#include <asm/mman.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -17,6 +19,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
+	/*
+	 * If only PROT_WRITE is specified then extend that to PROT_READ
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
index fa34cf55037b..98e5ece4052a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -299,7 +299,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
diff --git a/mm/mmap.c b/mm/mmap.c
index d89770eaab6b..57a974f49b00 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
+#include <linux/processor.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
-- 
2.43.2


