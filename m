Return-Path: <linux-arch+bounces-4295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA18C1C4A
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 04:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5347D1F2207D
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 02:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1FB13B79F;
	Fri, 10 May 2024 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsaMpkKi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960F29CE1;
	Fri, 10 May 2024 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715306679; cv=none; b=J20L6H2jbbnGsiLLPOm5rrfATLTkRKM9SMjhFwKQIO0FiWhe3gYfjKbytVYqTsKzKsMVhWNTzdfJQ/tQ37KAPbE5LSpkBOeRV101F2yY3130+6web+8HM7aMH70dmunbzrqOpO6AKDf43qOOISjfVY5CengAoNimc+gpsl0Mz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715306679; c=relaxed/simple;
	bh=Wt5NjcQsRy6vXuKFt+dzg0rWl480IGdBGm0rPEQXqIE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ApPKcjsg4nXbuCNLjMwv1SUri0cY9sQQ8OTRwy0HWk7MVLgl5UpcyZ1ev4ao5sV8ylLLk5ZHrqfKLFd0GWPRQtGH2QU8Dtu9SMhoALp7aOtSvuBp6WwoUMFWgPlUC98MkFX4tErDwME8eGVIL21qbZec8+mEJL7g8Vsr1eewXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsaMpkKi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59c0a6415fso422903266b.1;
        Thu, 09 May 2024 19:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715306676; x=1715911476; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI5tyqymmN9gGbJ6fagCaRykBg1tbmyzeV+T0zeBy6M=;
        b=LsaMpkKiUrke9UHG/PL+f9HgcQRSqapYJVK2RCIu3Vx3V00gxiMJS9hC4rzxf8dlYC
         x6oIcXrZ2B9Lx/x8wWUllD0xgUPnN1IdJA9xlVbSHDPEThP7w7O9B4xcs4hTM3yct0+W
         I8s4GWrI/WviZKmSt82Y0TFF1DFiyQoDd66ScauXv3XWv2p5fCICTHvwzSWXTIr2lVu5
         aIT9t/9yqUCHnUxWtzeixIpZOPn1xpwJLREi14E1rpZA+Q5ntomvm93WQW5J2BceiD6u
         +Fl2qbcjukrvl+5XAC6MRnwL1C1tZh3no5RAr8C4nWejxmSIZpjJ4WMP4fsqC/BXg3hZ
         RPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715306676; x=1715911476;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI5tyqymmN9gGbJ6fagCaRykBg1tbmyzeV+T0zeBy6M=;
        b=umcFnLoT3HlyY7XWxZnUUywWlAnDC5d6ze+6PUNT3ziTir2yMevF+QXvhRotZrJFSY
         UHwaDpvtP+01ELpvVZm80J+21oszRIQL8ujiYV2oJDsc47L0Vaa0b3ssfld1FkcHIwdJ
         qOtw+n1wUZwrePvLl3+fujFnHksvQP3BQZ8CecQtLfwjk82E5YCHVnyHUYIgIPveq3Xv
         5EYFao8TL8y4pY43hdh+qfNkX7eKgRIRoNNKCjeSHK0R42f8fli4+QTDI8mcM7Q7izrZ
         uHtWedwarpb65dCL3JqMBZgo+6kGz69YB8Uiyx+5ZQHOzyNsFNYxjbmGHjsYCxQkCUC1
         SCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaZbS3JV3F9sHS5iIK2JnYUmUBJPfWHzrjFh40EWJjdxQAOCIUuiowyyXuw7gvpRf8xjnZpXf8LGBMB5jgk0tr2xJl1FFkjfgAAtyzH4i7W02Z34u10kAfdYaFE+4dFMBqDqQ/YNI4Kg==
X-Gm-Message-State: AOJu0YxChRBg23aDeDqQNGtaKnKbVwBVkjuMdPEuHz9+R/3LUUADEQum
	w90KF67gwAtXooFmGooKqzXN/HjSe5ulO15buJ1PEi8Lsrone0zQ3WQH0z9D
X-Google-Smtp-Source: AGHT+IF2QDguCK8rTieenO0F4aGJLfLKKE/VD2hKk7gSUjMQEBdHmWN/fJPbugbyh1hN9Y/Vir1/Ug==
X-Received: by 2002:a17:906:3c57:b0:a59:2e45:f528 with SMTP id a640c23a62f3a-a5a2d5c96b5mr71148666b.38.1715306675648;
        Thu, 09 May 2024 19:04:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d553sm133706966b.43.2024.05.09.19.04.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2024 19:04:34 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	arnd@arndb.de,
	rppt@kernel.org,
	anshuman.khandual@arm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2] mm/memblock: discard .text/.data if CONFIG_ARCH_KEEP_MEMBLOCK not set
Date: Fri, 10 May 2024 02:04:22 +0000
Message-Id: <20240510020422.8038-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

When CONFIG_ARCH_KEEP_MEMBLOCK not set, we expect to discard related
code and data. But it doesn't until CONFIG_MEMORY_HOTPLUG not set
neither.

This patch puts memblock's .text/.data into its own section, so that it
only depends on CONFIG_ARCH_KEEP_MEMBLOCK to discard related code and
data.

After this, from the log message in mem_init_print_info(), init size
increase from 2420K to 2432K on arch x86.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: fix orphan section for powerpc
---
 arch/powerpc/kernel/vmlinux.lds.S |  1 +
 include/asm-generic/vmlinux.lds.h | 14 +++++++++++++-
 include/linux/memblock.h          |  8 ++++----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index f420df7888a7..d6d33bec597a 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -125,6 +125,7 @@ SECTIONS
 		*(.text.asan.* .text.tsan.*)
 		MEM_KEEP(init.text)
 		MEM_KEEP(exit.text)
+		MEMBLOCK_KEEP(init.text)
 	} :text
 
 	. = ALIGN(PAGE_SIZE);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f7749d0f2562..775c5eedb9e6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -147,6 +147,14 @@
 #define MEM_DISCARD(sec) *(.mem##sec)
 #endif
 
+#if defined(CONFIG_ARCH_KEEP_MEMBLOCK)
+#define MEMBLOCK_KEEP(sec)    *(.mb##sec)
+#define MEMBLOCK_DISCARD(sec)
+#else
+#define MEMBLOCK_KEEP(sec)
+#define MEMBLOCK_DISCARD(sec) *(.mb##sec)
+#endif
+
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 #define KEEP_PATCHABLE		KEEP(*(__patchable_function_entries))
 #define PATCHABLE_DISCARDS
@@ -356,6 +364,7 @@
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	MEM_KEEP(init.data*)						\
+	MEMBLOCK_KEEP(init.data*)					\
 	*(.data.unlikely)						\
 	__start_once = .;						\
 	*(.data.once)							\
@@ -573,6 +582,7 @@
 		*(.ref.text)						\
 		*(.text.asan.* .text.tsan.*)				\
 	MEM_KEEP(init.text*)						\
+	MEMBLOCK_KEEP(init.text*)					\
 
 
 /* sched.text is aling to function alignment to secure we have same
@@ -680,6 +690,7 @@
 	KEEP(*(SORT(___kentry+*)))					\
 	*(.init.data .init.data.*)					\
 	MEM_DISCARD(init.data*)						\
+	MEMBLOCK_DISCARD(init.data*)					\
 	KERNEL_CTORS()							\
 	MCOUNT_REC()							\
 	*(.init.rodata .init.rodata.*)					\
@@ -706,7 +717,8 @@
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
 	*(.text.startup)						\
-	MEM_DISCARD(init.text*)
+	MEM_DISCARD(init.text*)						\
+	MEMBLOCK_DISCARD(init.text*)
 
 #define EXIT_DATA							\
 	*(.exit.data .exit.data.*)					\
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e2082240586d..3e1f1d42dde7 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -100,13 +100,13 @@ struct memblock {
 
 extern struct memblock memblock;
 
+#define __init_memblock        __section(".mbinit.text") __cold notrace \
+						  __latent_entropy
+#define __initdata_memblock    __section(".mbinit.data")
+
 #ifndef CONFIG_ARCH_KEEP_MEMBLOCK
-#define __init_memblock __meminit
-#define __initdata_memblock __meminitdata
 void memblock_discard(void);
 #else
-#define __init_memblock
-#define __initdata_memblock
 static inline void memblock_discard(void) {}
 #endif
 
-- 
2.34.1


