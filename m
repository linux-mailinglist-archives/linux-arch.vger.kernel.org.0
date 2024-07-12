Return-Path: <linux-arch+bounces-5374-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE392F532
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 07:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B241C217CE
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 05:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A62118042;
	Fri, 12 Jul 2024 05:52:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54BD182A0;
	Fri, 12 Jul 2024 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763527; cv=none; b=UBR/GcwD8iVhpb+3VW+/u4kkpxtODdXPp4us7iG+5LXG8LTDi9KA/F5mL4u2m4sLS/6rxcuwco6U56kolF4/6FdBBFSO+nz5X4NGT6I/5lnS7wu0alwp8+xVJfIQQ1OuMdGPMSmvw93oOuxB3PNuZcnuz659rxrqf5oLjl3HazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763527; c=relaxed/simple;
	bh=AkR672Oy5z6xePK2gngOndmUfuDA5V9f3rg3lYJIGpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGUK5pHv618lLWisy0V0+dqpj1ZOuhQmNpzkLmSLksypmcZMZ7sU0jITSkUC/esUC3NalyF/DUvQAVQBvwp4jjpewHyQW/s6/ENJiO7lQVFfhSDsLgzLDeRwghOe+Hb8maLqhD5azOJkTK9KKvyD/fdY/Sw++UtTOa7QrpSOTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WL12B4QYTz9sSb;
	Fri, 12 Jul 2024 07:52:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PazSdMF40BfC; Fri, 12 Jul 2024 07:52:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WL12B3Xj0z9sSV;
	Fri, 12 Jul 2024 07:52:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 60D1A8B778;
	Fri, 12 Jul 2024 07:52:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id v6_nuzrMFLuu; Fri, 12 Jul 2024 07:52:02 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO22011.IDSI0.si.c-s.fr [192.168.233.128])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CCC728B764;
	Fri, 12 Jul 2024 07:52:01 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Arnd Bergmann <arnd@arndb.de>,
	Alexander Lobakin <alobakin@pm.me>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] vmlinux.lds.h: catch .bss..L* sections into BSS")
Date: Fri, 12 Jul 2024 07:51:58 +0200
Message-ID: <1f28df2a177cf632ac70162b345dc59711959f48.1720763318.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720763518; l=2118; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=AkR672Oy5z6xePK2gngOndmUfuDA5V9f3rg3lYJIGpM=; b=VnIrALErtmEscWJLYHRlC6VmwQu7OUL9GBd8Ws9re3e+zrQ5BdYpS6uXnr1XZYjbcsddCBaLZ MYJJGMrSW6cCxi0OKn9LlVHWjie4BC3niS1DMW5gYI7flhMkRtWNUqK
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 9a427556fb8e ("vmlinux.lds.h: catch compound literals into
data and BSS") added catches for .data..L* and .rodata..L* but missed
.bss..L*

Since commit 5431fdd2c181 ("ptrace: Convert ptrace_attach() to use
lock guards") the following appears at build:

  LD      .tmp_vmlinux.kallsyms1
powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'
  NM      .tmp_vmlinux.kallsyms2.syms
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'

Lets add .bss..L* to BSS_MAIN macro to catch those sections into BSS.

Fixes: 9a427556fb8e ("vmlinux.lds.h: catch compound literals into data and BSS")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404031349.nmKhyuUG-lkp@intel.com/
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5703526d6ebf..70bf1004076b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -103,7 +103,7 @@
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
-#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
+#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
 #define TEXT_MAIN .text
-- 
2.44.0


