Return-Path: <linux-arch+bounces-6688-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668C1961E7D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 07:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7742858FF
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 05:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEF0156F54;
	Wed, 28 Aug 2024 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oBVGgfaN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840A156F27
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824180; cv=none; b=rJL/AuJcgyBgw95l4O/2fxfiS2hqqbaAcB+qhZCvL2ylZXTt1c8K2WIXQAAcbmXXypHZeayvo3FVFjlbN4zp9HmNzhE9SeYPOdmHmbM1xr1DfJ0ID6Se3G0TmmIzELX0I2tL2XUuAh7kev04eMTY5rj9S1CEQizQl5zRqK/ud5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824180; c=relaxed/simple;
	bh=deEFSUhsRdIX0bdzxWoQYKSiKJBAsZhcTOjbVXT5+ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gmXLiD8HTQh+UN9F2RTZJOVr8FGh9oeHSIu8LjUv54QB4++PQssa0JRBCBRDdtAkGKPnLeNErQ5GcELde59ahTr/N444SQkIIoUe81Zp/LvC6b04o8SAcXR1yZt1HZrpcvHkn9W1s6Gaw/f1xJk1jRjrdSurvGLmZYgp8ojqiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oBVGgfaN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201fba05363so53069365ad.3
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 22:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824177; x=1725428977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGbwsGUaSgh3SYkS7pHaMfmAZns1s9a6v7xPbD2XVAI=;
        b=oBVGgfaNqLlIp++Uer06pzZME0fzEA6A+S3rfZsafzxcYxqMPwYojAou9YkGeUhCrE
         9gEGmx+3i6KveY1t3jbBnnKg5o9iQgErzsNta4t4YhK8rCrAdd7uanFN5y5B0xZInynY
         S/YrYmsJk0ZErKiGXiTxTdM2we/YW4EcTTHoSBFzhhgVV5NiDzmy6BrTHaudiebPFf8I
         uIL2BrHnJymH6v8cXw1UGhJD8M2Ps2Kkxk7hNxjr4yPpzF/SDdeLRFk77uyawWD+6MKE
         JdgbrsOus+IcK3pXb8qwnN2LhaqniyKk5ZGi1vFU6Jic6HDLf+EjkTKBQHavYmq0a4Pd
         YsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824177; x=1725428977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGbwsGUaSgh3SYkS7pHaMfmAZns1s9a6v7xPbD2XVAI=;
        b=U6urDNWheoO0eujOv5S/gnSbkg05vjtMcA+v3YCkcuJiBKGUxdVAfMt1AekqerP73x
         3j/f8eXMx6yB/InDRUavsk5ck4WuIjOZpkbrssCzvhhB1hzTUiGu56PRhcOhp1SF4aD7
         gNlzlF77N1tdkdZl4WeDE9qb+P9nAKjVPkaBSDlFGNYn0ENHO+jzsQm/DtNDAElwDcwU
         HRTF3gw/RCRLQJdjJ89kuvKlZryONzCrwME6EHlzPGKguVcqknhVAFMNqRqrO9uBmE7E
         F8EdoZBr5fTQZqQV+Ot1IJD04jn93SG9VA9+d9SCbAf8t0I4N0Bgu3wvwmPXylFV3+so
         0YXg==
X-Gm-Message-State: AOJu0Yya4rv9RGD7mpQHke4IegFXS0I/NeM98BcHj6wrMT4ggj6exBI/
	eOCgfkEYxuRxXfUfh/u+ao3o2404+yz9D5VVaPkhQ0pV2A3XtpvF6JbM0+jc3D4=
X-Google-Smtp-Source: AGHT+IETeUynSugovs7+A+AN20czg30Ola2aofBrInbwTCbD60I4EWjQ5oF17Pp044tfVMlW9N70GQ==
X-Received: by 2002:a17:902:f946:b0:1fb:6ea1:6a with SMTP id d9443c01a7336-204f9bf6b4fmr8673095ad.42.1724824176426;
        Tue, 27 Aug 2024 22:49:36 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:35 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:09 -0700
Subject: [PATCH 03/16] mm: Add flag and len param to arch_get_mmap_base()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-3-46ff2eb9022d@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3681; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=deEFSUhsRdIX0bdzxWoQYKSiKJBAsZhcTOjbVXT5+ls=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XbEKPQVKN+QOfCnd/vQAx7Mm0aicnIfvMk/aT/p2R
 eLJrUMHOkpZGMQ4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZiI/GeGP5ySTrLnNmwQmXLz
 8w+bnE++e2VFjGTvdAadNPbzvHntw1tGhs53DbPX/utm9fCf+JHzi+Xvmwkm0w5eV/OMyrFcaSf
 ykBcA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The flag and len param is required in arch_get_mmap_base() to implement
MAP_BELOW_HINT.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/arm64/include/asm/processor.h      | 2 +-
 arch/powerpc/include/asm/task_size_64.h | 2 +-
 arch/riscv/include/asm/processor.h      | 2 +-
 fs/hugetlbfs/inode.c                    | 2 +-
 include/linux/sched/mm.h                | 2 +-
 mm/mmap.c                               | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f77371232d8c..a67ca119bb91 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -95,7 +95,7 @@
 #define arch_get_mmap_end(addr, len, flags) \
 		(((addr) > DEFAULT_MAP_WINDOW) ? TASK_SIZE : DEFAULT_MAP_WINDOW)
 
-#define arch_get_mmap_base(addr, base) ((addr > DEFAULT_MAP_WINDOW) ? \
+#define arch_get_mmap_base(addr, len, base, flags) ((addr > DEFAULT_MAP_WINDOW) ? \
 					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
 					base)
 #endif /* CONFIG_ARM64_FORCE_52BIT */
diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
index 5a709951c901..239b363841aa 100644
--- a/arch/powerpc/include/asm/task_size_64.h
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -72,7 +72,7 @@
 #define STACK_TOP_MAX TASK_SIZE_USER64
 #define STACK_TOP (is_32bit_task() ? STACK_TOP_USER32 : STACK_TOP_USER64)
 
-#define arch_get_mmap_base(addr, base) \
+#define arch_get_mmap_base(addr, len, base, flags) \
 	(((addr) > DEFAULT_MAP_WINDOW) ? (base) + TASK_SIZE - DEFAULT_MAP_WINDOW : (base))
 
 #define arch_get_mmap_end(addr, len, flags) \
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 1015f2a49917..7ff559bf46f2 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -19,7 +19,7 @@
 	STACK_TOP_MAX;						\
 })
 
-#define arch_get_mmap_base(addr, base, flags)			\
+#define arch_get_mmap_base(addr, len, base, flags)		\
 ({								\
 	base;							\
 })
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9f6cff356796..05a52f85dba9 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -195,7 +195,7 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
-	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
+	info.high_limit = arch_get_mmap_base(addr, len, current->mm->mmap_base, flags);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	addr = vm_unmapped_area(&info);
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 91546493c43d..265b43855d0b 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -174,7 +174,7 @@ static inline void mm_update_next_owner(struct mm_struct *mm)
 #endif
 
 #ifndef arch_get_mmap_base
-#define arch_get_mmap_base(addr, base) (base)
+#define arch_get_mmap_base(addr, len, base, flags) (base)
 #endif
 
 extern void arch_pick_mmap_layout(struct mm_struct *mm,
diff --git a/mm/mmap.c b/mm/mmap.c
index d0dfc85b209b..27a7f2be3f68 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1861,7 +1861,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
-	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
+	info.high_limit = arch_get_mmap_base(addr, len, mm->mmap_base, flags);
 	addr = vm_unmapped_area(&info);
 
 	/*

-- 
2.45.0


