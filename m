Return-Path: <linux-arch+bounces-6793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A21963C83
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 09:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151661C240A8
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 07:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A48184549;
	Thu, 29 Aug 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BW1/59WG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E081891B5
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915783; cv=none; b=QxeXzRGi6t0Esr8xgufIoD5ZDffEbnSK5etmXgA6KDS3Bns06nELVyqv+Ic/S4vWBvvkYq3Bhx1fIxas1AyjIZCOtZxu4egd3yMLFNaF2O9JF+S9V36I8dgEf3BDTZD24gDfmvLh289Yb97/Zl+fJom6gM4zLDmlzwCmpqwOCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915783; c=relaxed/simple;
	bh=cJo+DjHYKAKtcF7uVNq5Hkp7bg1tB/ALtneNIYjVApc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/LGObRjKc35RSA9iRWPPC1zrTDrRsTWQjySErYvTnsEErk34ECcIBOvPy4a/KbU9/cGGIH5fvizlPboZpN461QUHkLKisrbb4/K7KIjPM6KRagQz1V63XnA7fS5c1GRxZ4Njle/bUSBjgBigvZToZSOKbu43d2q9qWd+jcakrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BW1/59WG; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82a20593e53so1477539f.2
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 00:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724915780; x=1725520580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sbwm6yYi8fii0SQTFAzAiKdXxaRuHZnv4HbMCIc+vRk=;
        b=BW1/59WGtSuvvaslzZhdx6iU1VKPRZ448RYwEEhpWVuRcTystxqRcF5PPt1m306PvB
         vheCOd6Fq4BC5JJsCWILNS4O4uFQoX7NGhFCC+Pbtf4lJedPwXZycbyHlir1/l6/epi/
         Uc4noy1wvNxHM5BwrmOnCb0U8zdrr9P5ljnU4ojVHnsZgvkdX8RAvf+IV8nY+HfE098d
         MaHqTQaKScPrhJNy65QJ9tA3RqfNxJ2yi1c7TzMZOEye7kG15Ml9HlxoHAM0i2tehoCh
         ftLo+gwaRUAfH7V+398aVDvbe8mNt2L51KX0tvC5mbB9+nseJZMgddlEFAAEePbp1Jbz
         snZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915780; x=1725520580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sbwm6yYi8fii0SQTFAzAiKdXxaRuHZnv4HbMCIc+vRk=;
        b=JcMqTpWGoa1t1VvQgpA/4LkyIpmhNwQFvANIysWxmWZROW9Ay6eoQbrDjauLn5DaGr
         CZxxha9NMi7/79pe8uXMO6QJYBTH1yk/vCyIC9pLsyPd0bSpdBRxEAimsCMKPBiAjH78
         YLGLkG/Iszrb/4Aa2rDHpREyM3+pyXt1PjxVMC1Ty4hn2Hs0VeYHas4JEpWpVyZg5/nC
         rt81HTUpxClZtUsmOxA5zS8aXUxdookklbwBYXUXLRv8N2VnX0WdgFjdT6S1TeKFC6i/
         OyrN+8gngxq0hdNP1Lw/k5cMBZYzQsBy2fIVfzDKp+JRhTetMVklPZFfwq3xzXDV4HS0
         wQZw==
X-Gm-Message-State: AOJu0YygRBpkQ0i1nfXMOJvoi8C2eL/mDLRVzUSPLP215lT784IJpBHX
	iHWbIRzBl2qVzAyZCmnl1EtLhKiYeu2QHKRn95wNpA1APDgsrTQQUgo1Er+zkkw=
X-Google-Smtp-Source: AGHT+IGgPVGnJtoSfqPS27dHBhsP9wE8tGpecq2SA+TpeFejfd/21/ZqZVX0hSOoHcWSmw9m6xWNXw==
X-Received: by 2002:a05:6602:150e:b0:803:c955:eda8 with SMTP id ca18e2360f4ac-82a11010e13mr213412239f.6.1724915779989;
        Thu, 29 Aug 2024 00:16:19 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9bef08sm581976a12.58.2024.08.29.00.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:16:19 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 29 Aug 2024 00:15:59 -0700
Subject: [PATCH RFC v2 2/4] mm: Add hint and mmap_flags to struct
 vm_unmapped_area_info
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-patches-below_hint_mmap-v2-2-638a28d9eae0@rivosinc.com>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
In-Reply-To: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13798; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=cJo+DjHYKAKtcF7uVNq5Hkp7bg1tB/ALtneNIYjVApc=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9oFBYsZBaJsp/MFz8f+MGk86RnpUeMrsf76l5QvfwVzH
 bi3fE/oKGVhEONgkBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCJhqQx/pZw4Kv/yqWcskTot
 +DC45Z2Xbmt3sqXCfbPzz4uE9X7UMvyPfD0x5fXhZqutguJLblpd/5tsrJGyOK/8zPKTp3N1Txs
 xAQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The hint address and mmap_flags are necessary to determine if
MAP_BELOW_HINT requirements are satisfied.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/alpha/kernel/osf_sys.c      | 2 ++
 arch/arc/mm/mmap.c               | 3 +++
 arch/arm/mm/mmap.c               | 7 +++++++
 arch/csky/abiv1/mmap.c           | 3 +++
 arch/loongarch/mm/mmap.c         | 3 +++
 arch/mips/mm/mmap.c              | 3 +++
 arch/parisc/kernel/sys_parisc.c  | 3 +++
 arch/powerpc/mm/book3s64/slice.c | 7 +++++++
 arch/s390/mm/hugetlbpage.c       | 4 ++++
 arch/s390/mm/mmap.c              | 6 ++++++
 arch/sh/mm/mmap.c                | 6 ++++++
 arch/sparc/kernel/sys_sparc_32.c | 3 +++
 arch/sparc/kernel/sys_sparc_64.c | 6 ++++++
 arch/sparc/mm/hugetlbpage.c      | 4 ++++
 arch/x86/kernel/sys_x86_64.c     | 6 ++++++
 arch/x86/mm/hugetlbpage.c        | 4 ++++
 fs/hugetlbfs/inode.c             | 4 ++++
 include/linux/mm.h               | 2 ++
 mm/mmap.c                        | 6 ++++++
 19 files changed, 82 insertions(+)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index e5f881bc8288..6903700afd12 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1223,6 +1223,8 @@ arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
 	info.length = len;
 	info.low_limit = addr;
 	info.high_limit = limit;
+	info.hint = addr;
+	info.mmap_flags = flags;
 	return vm_unmapped_area(&info);
 }
 
diff --git a/arch/arc/mm/mmap.c b/arch/arc/mm/mmap.c
index 69a915297155..5922cb51e029 100644
--- a/arch/arc/mm/mmap.c
+++ b/arch/arc/mm/mmap.c
@@ -29,6 +29,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/*
 	 * We enforce the MAP_FIXED case.
 	 */
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index d65d0e6ed10a..04d9234f049a 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -36,6 +36,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	int aliasing = cache_is_vipt_aliasing();
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/*
 	 * We only need to do colour alignment if either the I or D
 	 * caches alias.
@@ -56,6 +59,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
+
 	if (addr) {
 		if (do_align)
 			addr = COLOUR_ALIGN(addr, pgoff);
@@ -88,6 +92,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	int aliasing = cache_is_vipt_aliasing();
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/*
 	 * We only need to do colour alignment if either the I or D
 	 * caches alias.
diff --git a/arch/csky/abiv1/mmap.c b/arch/csky/abiv1/mmap.c
index 7f826331d409..0be4913c6cf3 100644
--- a/arch/csky/abiv1/mmap.c
+++ b/arch/csky/abiv1/mmap.c
@@ -35,6 +35,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		.align_offset = pgoff << PAGE_SHIFT
 	};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/*
 	 * We only need to do colour alignment if either the I or D
 	 * caches alias.
diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index 889030985135..7d1e8be20519 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -27,6 +27,9 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	int do_color_align;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
 
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 7e11d7b58761..22e8f9c8eaa0 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -36,6 +36,9 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	int do_color_align;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
 
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index f7722451276e..2ac53f148624 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -108,6 +108,9 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		.length = len
 	};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
 
diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index ef3ce37f1bb3..f0e2550af6d0 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -286,6 +286,10 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 		.length = len,
 		.align_mask = PAGE_MASK & ((1ul << pshift) - 1),
 	};
+
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/*
 	 * Check till the allow max value for this mmap request
 	 */
@@ -331,6 +335,9 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	};
 	unsigned long min_addr = max(PAGE_SIZE, mmap_min_addr);
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/*
 	 * If we are trying to allocate above DEFAULT_MAP_WINDOW
 	 * Add the different to the mmap_base.
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index ded0eff58a19..dc38f7022037 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -254,6 +254,8 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 	info.low_limit = current->mm->mmap_base;
 	info.high_limit = TASK_SIZE;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.hint = addr;
+	info.mmap_flags = flags;
 	return vm_unmapped_area(&info);
 }
 
@@ -270,6 +272,8 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = current->mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.hint = addr;
+	info.mmap_flags = flags;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 206756946589..001345df61b6 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -88,6 +88,9 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (len > TASK_SIZE - mmap_min_addr)
 		return -ENOMEM;
 
@@ -123,6 +126,9 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 	struct mm_struct *mm = current->mm;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE - mmap_min_addr)
 		return -ENOMEM;
diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index bee329d4149a..ab1f5613b5e2 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -59,6 +59,9 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	int do_colour_align;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -107,6 +110,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	int do_colour_align;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 08a19727795c..bcc3242e003d 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -43,6 +43,9 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 {
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index d9c3b34ca744..05de444d66f6 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -95,6 +95,9 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	int do_color_align;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -155,6 +158,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	int do_color_align;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
 
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index cc91ca7a1e18..148064142628 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -40,6 +40,8 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *filp,
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = min(task_size, VA_EXCLUDE_START);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.hint = addr;
+	info.mmap_flags = flags;
 	addr = vm_unmapped_area(&info);
 
 	if ((addr & ~PAGE_MASK) && task_size > VA_EXCLUDE_END) {
@@ -71,6 +73,8 @@ hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.hint = addr;
+	info.mmap_flags = flags;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 01d7cd85ef97..248a210c2b0b 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -129,6 +129,9 @@ arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned l
 	struct vm_unmapped_area_info info = {};
 	unsigned long begin, end;
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (flags & MAP_FIXED)
 		return addr;
 
@@ -167,6 +170,9 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info = {};
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE)
 		return -ENOMEM;
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 807a5859a3c4..d3f8cec4895d 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -29,6 +29,8 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 
 	info.length = len;
 	info.low_limit = get_mmap_base(1);
+	info.hint = addr;
+	info.mmap_flags = flags;
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
@@ -52,6 +54,8 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = get_mmap_base(0);
+	info.hint = addr;
+	info.mmap_flags = flags;
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9f6cff356796..4b35eadd2ad8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -182,6 +182,8 @@ hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
 	info.low_limit = current->mm->mmap_base;
 	info.high_limit = arch_get_mmap_end(addr, len, flags);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.hint = addr;
+	info.mmap_flags = flags;
 	return vm_unmapped_area(&info);
 }
 
@@ -197,6 +199,8 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.hint = addr;
+	info.mmap_flags = flags;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6549d0979b28..b5fcb9dfb942 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3445,6 +3445,8 @@ struct vm_unmapped_area_info {
 	unsigned long align_mask;
 	unsigned long align_offset;
 	unsigned long start_gap;
+	unsigned long hint;
+	unsigned long mmap_flags;
 };
 
 extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
diff --git a/mm/mmap.c b/mm/mmap.c
index d0dfc85b209b..34ba0db23678 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1796,6 +1796,9 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	if (len > mmap_end - mmap_min_addr)
 		return -ENOMEM;
 
@@ -1841,6 +1844,9 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
+	info.hint = addr;
+	info.mmap_flags = flags;
+
 	/* requested length too big for entire address space */
 	if (len > mmap_end - mmap_min_addr)
 		return -ENOMEM;

-- 
2.45.0


