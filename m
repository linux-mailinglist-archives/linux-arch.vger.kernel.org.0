Return-Path: <linux-arch+bounces-6639-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F38496031F
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9282D1C20C17
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535015B54C;
	Tue, 27 Aug 2024 07:32:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185BA4CB4E;
	Tue, 27 Aug 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743932; cv=none; b=s1PWd5FsV/Z3TDKqdw+20J+1cx+C0iHqjqg2HLfG7SUbt2JDTsJ4rvWKdK52HEWkeq7h/fQ6DPdyhRIUcpYuqAI8SOI4di2D/aPWE8xBzD/DNU2eQLvVn9AwfsOujID5NDtUfSPV5lk+Ew9Rrb+DG+oCdx65+P0KBCYHIsIrK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743932; c=relaxed/simple;
	bh=PMuEkb4wUUODc8BHWuAMDd3O1VO5F7l6ew490+ETezs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loaaeDK7t72zJv6zhUz2gPTSxLLuKlHdOJmOGTLA7aUPGQo9EZw+kDs8cDk0tUYhMHd46F2/SaoGtaaavX4qt29BHwCMoE9vtXwxXA4J7bZDJJgAJlN0VYo3ZOA32+p/Dc8OCkk1Ai1hBy8J8HuZ7cws8IuXEFsqjds8ScyRMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtK4P2W7bz9sRk;
	Tue, 27 Aug 2024 09:32:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RiFew2TziKmP; Tue, 27 Aug 2024 09:32:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtK4P1YDbz9rvV;
	Tue, 27 Aug 2024 09:32:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1FACA8B763;
	Tue, 27 Aug 2024 09:32:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6YCOSSZW0mJI; Tue, 27 Aug 2024 09:32:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO19727.IDSI0.si.c-s.fr [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 762398B77C;
	Tue, 27 Aug 2024 09:32:04 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 1/4] asm-generic/unaligned.h: Extract common header for vDSO
Date: Tue, 27 Aug 2024 09:31:47 +0200
Message-ID: <5b72ae99e07ca3360fccfcec603afac2410e05b6.1724743492.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724743492.git.christophe.leroy@csgroup.eu>
References: <cover.1724743492.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724743908; l=2154; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=PMuEkb4wUUODc8BHWuAMDd3O1VO5F7l6ew490+ETezs=; b=ALhlsQl4VRbLc40pb9oImNXUKFq4TqKvoMldqBrkUAl0/m4uIVX4FpBcwGoswPuFUuYHOXd+c o/BH9fC/9j7CTPaDabFIdEbw+1RKWRm2jRJCtiF0ajM9gs5WwqG5KQy
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

getrandom vDSO implementation requires __put_unaligned_t() and
__put_unaligned_t() but including asm-generic/unaligned.h pulls
too many other headers.

Follow the same approach as for most things in include/vdso/,
see for instance commit 8165b57bca21 ("linux/const.h: Extract
common header for vDSO"): Move __get_unaligned_t and __put_unaligned_t
into a new unaligned.h living in the vdso/ include directory.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/asm-generic/unaligned.h | 11 +----------
 include/vdso/unaligned.h        | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)
 create mode 100644 include/vdso/unaligned.h

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index a84c64e5f11e..95acdd70b3b2 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -8,16 +8,7 @@
  */
 #include <linux/unaligned/packed_struct.h>
 #include <asm/byteorder.h>
-
-#define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-	__pptr->x;								\
-})
-
-#define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
-	__pptr->x = (val);							\
-} while (0)
+#include <vdso/unaligned.h>
 
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
 #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
new file mode 100644
index 000000000000..eee3d2a4dbe4
--- /dev/null
+++ b/include/vdso/unaligned.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_UNALIGNED_H
+#define __VDSO_UNALIGNED_H
+
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x;								\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {					\
+	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	__pptr->x = (val);							\
+} while (0)
+
+#endif /* __VDSO_UNALIGNED_H */
-- 
2.44.0


