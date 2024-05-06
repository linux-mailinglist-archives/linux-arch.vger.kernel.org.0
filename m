Return-Path: <linux-arch+bounces-4214-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4F78BC567
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 03:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1851C210B1
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 01:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8C43BBFF;
	Mon,  6 May 2024 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFi4+NjK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF032FB6;
	Mon,  6 May 2024 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958548; cv=none; b=I3S5/LGCh9F1lKm4Ma2qNCFNb4yhnbdirE8ui1Or4RSQGwdQAMgx7SI9ubTVERSkylhvIqn1Z9rRJIC0wCGaKEs/XReEXRJAEtyUGlVrrGkLy5/APG6t6PJzC6/+36Z7g+7PACChUn2hw25nU4G7McPZfEX5s4YD0+6800ZFS7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958548; c=relaxed/simple;
	bh=JJjxgGZxm6C2oeTjFvqBWbAWhXD8o2kgHv5Kc419p6A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=POtKkh1YgeVe3sz+KA8nd594hYuTtGIeWOWmmBUSMn3ar4tq99jUaiYromxpSYnpwwzGPr06RwuJZn3NFy3Du07ZO8qydtEN26TQYcMCDEKyPxRCREbELBTDxEMI1dFfP6m+hzE33rwdyNDU75VcNmjRyAKPg9/JVqnalPsUONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFi4+NjK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso143974666b.2;
        Sun, 05 May 2024 18:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714958545; x=1715563345; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXql6pq6gP6PZPKKZA9sUcOpkbTs5kG7qkItMNhcUBg=;
        b=SFi4+NjKGZ/6DopFdBTtNABksF9E1HjAxsYz8ZG25eqz3nJKl0S+l33ZzTCxGOWf4Q
         5ACsLqGXSodYAW0qVu6/6alw8KTS2JhuXu6S0gM0ULy6A0CQBLZROGAWfTqEZF0hneBd
         7wgHC4cDR3JUFQLWc2PDvgUa83C8FAyqD67f5MF4r/TKXy08WOwVwThsqAvjXHojNNhZ
         rkaaGp6hh7H9yAvj2SfWkS94dhjhaajzA67ZSuBlqyZTlgeqGFNMWtwCOwFK5Fpr6UDE
         4X3AnoQA455WY3kl2mWg8SCTpBizxLwiqpzNiXobfP6A0ibCglxB+5uoFhLT3TS+mvQv
         RuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958545; x=1715563345;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXql6pq6gP6PZPKKZA9sUcOpkbTs5kG7qkItMNhcUBg=;
        b=NywN/J7089A1QHiB4gTA3cLjnWOjXNIAbc/vDb7EnxqniHWgdWV91dROy7nuQtEr3R
         QRHYe2CgTuFBwG690kxMuibd2Hu/IPFHfPeJIKa1yiIhUYIHvJlGHMGRCy+oM0/17rWn
         NO4sv8M3ofZpX7934L+EFNUXU5frr/LBb6N82OcAEV4jEeLisf5NNiVWUqKNG+laGqR3
         Me4QaO4qFkR0KalxNHIOTS3YESytDaireeeX0y/cATkO4VSBBXgkEOgzzYjwWMP6wOHS
         W/1mi7pGe+iFZedmrFZ/7pRfWenWVbuFbUzS72lYj6KXtj8n4jDmWGsr2gGpUroZiN55
         zx8w==
X-Forwarded-Encrypted: i=1; AJvYcCWiONT8mpqiH6DMxrHrfD3cep1oq5Stt3phFICKfvnzuKjETS5Oc+FDzeKRGZx9Os9+5n/vXvC+ogWhdINX8A8c7K5Yu7JewQZLQwoy
X-Gm-Message-State: AOJu0YxqaUPrSd3iJqk3liRm8DGyFQZE8etk3LAadK7xYonUOD0xfj7f
	lZkjlWaojdDY3lniEjYBPF2EPzY3l1s6knLjzOLyM1dGgK5zaDk/
X-Google-Smtp-Source: AGHT+IHX4Q1M1J2QS0feiS/vKJoi8VrwTs5GnXeLGv3vgyeFQks/RZrzr3b3YspBZ68H/t1pBhZMAQ==
X-Received: by 2002:a17:907:728a:b0:a59:bbd6:bb3b with SMTP id dt10-20020a170907728a00b00a59bbd6bb3bmr2228018ejc.55.1714958545444;
        Sun, 05 May 2024 18:22:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709066b8c00b00a59c0ecd559sm1427116ejr.112.2024.05.05.18.22.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2024 18:22:24 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: arnd@arndb.de,
	rppt@kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] mm/memblock: discard .text/.data if CONFIG_ARCH_KEEP_MEMBLOCK not set
Date: Mon,  6 May 2024 01:21:04 +0000
Message-Id: <20240506012104.10864-1-richard.weiyang@gmail.com>
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
data. After this, init size increase from 2420K to 2432K.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 14 +++++++++++++-
 include/linux/memblock.h          |  8 ++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

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


