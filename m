Return-Path: <linux-arch+bounces-6693-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042AC961EA4
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 07:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A0C1F24FE1
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 05:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E3158DC2;
	Wed, 28 Aug 2024 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QmhRUb0u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98980158DDF
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824196; cv=none; b=CVJRYqk3xGxMRCQOS+xAbSgCOHOzd4zEtQHCQYgo7FqpQUIRRlK7Udjfu7RmBqHj+eIEomvp04rO6oinDvHkzEInePKFI7nqgWl+lcgzrKHKl7OTzXvbzX7JqzNIlzhwrMB2q/pRLmSk0XWpjPlxEKWyQgT857lSvDvo5kfm7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824196; c=relaxed/simple;
	bh=/49vITxLNj+RJRh4dWyqxf17jS8h791m43d/wmsbi4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JW7xfP1KkmzMtuvftuysyWYYOBNwLDXO5u8zPAgyGhk1cVA/4qgoG0uYbptOGBl4pRRHjyfPxq5NW2IyJCh/eVFQr4bhzWM0jo/vQE/T2Sk9W6GYCyn2eJ2kPXgEZmEs5794SycouEI3ntIkHtyNVdGubewd572H75RthuCoUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QmhRUb0u; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fbd0d7c2so52362965ad.0
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824194; x=1725428994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPJ0dF9cF6J1lv0FlFvR4vKxUsSQiAia4h2dvI+DMjw=;
        b=QmhRUb0uVIUty2oLegYZmBABWxiWxLB+XkerTLaCrEzxt152fhFOnpYK7IQVHo9bFj
         f+eumwsKYvdN+YYH1lxV0JuC5EL4v+jM+N3TgEhJhQcHmPjdc8ouIZCRxSZZkcTCTvAr
         Sroyrv3JDp8Dj8gAZWvsRQ2Fkv8O8gEjrIXLPU7rM8XImAG/YxLUot/Xhnhq+qdDCO83
         53N66k3AqztfUJj1z3/IaJlN5LCpNL1xMchFrasJeZd/QWCLYiXAfVN+6RqcE4Md/ydx
         TbzZ9i5DNXbqzFzYj7bIYErtY3sNpgJsksLz8CiQRHnlSmxtesBKZr0PkEnYhnjls0Hc
         8yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824194; x=1725428994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPJ0dF9cF6J1lv0FlFvR4vKxUsSQiAia4h2dvI+DMjw=;
        b=TMWvId2m3iHBBCyU2AAgb9JdTPuuw2nFPxy2180Ww+o5UojS7hv3QQVdToCH88CYn6
         naapILmfkuygOBOzuCswnF09EQJFiu3m7FsNVer8paxK9yDKdK8UdYcEtEzfbslk8EYu
         G1S2CzkYUKP/qodgrBlATB40jAWrkFlIdKFyfzshiXHQSFQBEZaPDIC4WGk+g408TndH
         oo9EKNMn0TXVvt75QNh8V98wy9q2ljZl9qnCVKMNelJ+Pc422gJfbHEN2oOPUfMB17EW
         gw6zq7ifBGYmIrm3ZnuTwY8cIY6HMIf6Z+ycN3Tx2Epu4+/jTPaGDVjoQtrDpiZs4aIV
         kICQ==
X-Gm-Message-State: AOJu0YzYOXoCvElQYyjJ/rrH4QQwbQ9aIcq2dDPX2SIEbyk9D99Kx7X4
	g8IZMehUhIccqlJJ3sSZiI+v7LYCz22ry5vWvNtbg9faoUBQjfCJPNuUgaIm62U=
X-Google-Smtp-Source: AGHT+IGIwf3MFbsmI5L/nn36QcLF0tw2dizRywserImseYHkgoEBii3QkvkJxB3CCAhauX+R+NVkZg==
X-Received: by 2002:a17:903:41cb:b0:1fb:90e1:c8c0 with SMTP id d9443c01a7336-204f9c50d18mr13883795ad.63.1724824193604;
        Tue, 27 Aug 2024 22:49:53 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:52 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:14 -0700
Subject: [PATCH 08/16] x86: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-8-46ff2eb9022d@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=/49vITxLNj+RJRh4dWyqxf17jS8h791m43d/wmsbi4g=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XfH5mu/c9Rrzlz8/vq1gj25AnkDItFvB5j/EjQ7d2
 dgpWufVUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwERiehj+Oxm+8In6am8suLjK
 Qbj6ukzK61nfEx9q7X3ecc3HVutSBcP/QCmOFDVPG+uvAsGmtk+sN15sO6WrIvn+0Hvj8ITPYtt
 ZAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add support for MAP_BELOW_HINT to mmap by restricting high_limit to
addr when the flag is enabled.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/x86/kernel/sys_x86_64.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 01d7cd85ef97..fa16b38f3702 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -86,7 +86,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
 
-static void find_start_end(unsigned long addr, unsigned long flags,
+static void find_start_end(unsigned long addr, unsigned long len, unsigned long flags,
 		unsigned long *begin, unsigned long *end)
 {
 	if (!in_32bit_syscall() && (flags & MAP_32BIT)) {
@@ -106,10 +106,14 @@ static void find_start_end(unsigned long addr, unsigned long flags,
 	}
 
 	*begin	= get_mmap_base(1);
+
 	if (in_32bit_syscall())
 		*end = task_size_32bit();
 	else
 		*end = task_size_64bit(addr > DEFAULT_MAP_WINDOW);
+
+	if (flags & MAP_BELOW_HINT)
+		*end = MIN(*end, addr + len);
 }
 
 static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
@@ -132,7 +136,7 @@ arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned l
 	if (flags & MAP_FIXED)
 		return addr;
 
-	find_start_end(addr, flags, &begin, &end);
+	find_start_end(addr, len, flags, &begin, &end);
 
 	if (len > end)
 		return -ENOMEM;
@@ -166,6 +170,7 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info = {};
+	unsigned long task_size, mmap_base;
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE)
@@ -198,7 +203,8 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 	else
 		info.low_limit = PAGE_SIZE;
 
-	info.high_limit = get_mmap_base(0);
+	mmap_base = get_mmap_base(0);
+	info.high_limit = mmap_base;
 	info.start_gap = stack_guard_placement(vm_flags);
 
 	/*
@@ -210,6 +216,19 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 	 */
 	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
+	if (flags & MAP_BELOW_HINT) {
+#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
+		task_size = task_size_32bit();
+#else
+		task_size = task_size_64bit(0);
+#endif
+		/*
+		 * mmap_base is defined by PAGE_ALIGN(task_size - gap - rnd) so
+		 * subtract out the task_size to isolate the gap + rnd.
+		 */
+		info.high_limit = MIN(info.high_limit,
+				      (addr + len) - (task_size - mmap_base));
+	}
 
 	info.align_offset = pgoff << PAGE_SHIFT;
 	if (filp) {

-- 
2.45.0


