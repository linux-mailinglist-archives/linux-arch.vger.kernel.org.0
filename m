Return-Path: <linux-arch+bounces-6641-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2715E960328
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 09:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF17B1F22C8B
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AEB156676;
	Tue, 27 Aug 2024 07:32:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B64156257;
	Tue, 27 Aug 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743940; cv=none; b=EKmve1bA8k4EPAjVtm14jiv5kr6ssxHcwQSO92TaCAYlmJonqXoAzWQ/bTb1QOkgUfzoaHkkW6g4/scSpSoREaAwNp9Xi7fA0NhYQpCC/zYX/H4Y8COXoc3To8+Eb62OhsQq7JBiyfpUyBf08z+wTXhkvTznsyGst2sQYVhqKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743940; c=relaxed/simple;
	bh=SyzZtI1+NQ+PNQRnqfr3VckHD6Z85j1Q1O6oyqTDKHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gecxXBn7+B8Uc9PvDzJtyo3HH7dnmi92kkk8fFS4YFWEW12QOFFJqQN31GlWd+Je3Yae49K2/d8CDH1Q3xGsO89FD3ktb+YsBmoJhe3yox9QZ4lESbjD1KCHHXU/JIM9bVNj9W6JYTguxa9Lh3nR46TbCczY9eq7ThGOakkiguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtK4R2g5Jz9sRy;
	Tue, 27 Aug 2024 09:32:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7bo799OOrQp; Tue, 27 Aug 2024 09:32:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtK4Q3lVyz9rvV;
	Tue, 27 Aug 2024 09:32:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 69D9D8B763;
	Tue, 27 Aug 2024 09:32:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Iq2bPXf9vqy9; Tue, 27 Aug 2024 09:32:06 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO19727.IDSI0.si.c-s.fr [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C22318B77C;
	Tue, 27 Aug 2024 09:32:05 +0200 (CEST)
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
Subject: [PATCH 3/4] random: vDSO: Clean header inclusion in getrandom
Date: Tue, 27 Aug 2024 09:31:49 +0200
Message-ID: <8a025e72484467cd34412b20e8638a5982c1867e.1724743492.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724743492.git.christophe.leroy@csgroup.eu>
References: <cover.1724743492.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724743908; l=2330; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=SyzZtI1+NQ+PNQRnqfr3VckHD6Z85j1Q1O6oyqTDKHY=; b=fSIKr6vEkPCdi8p5zjOImaiMT45fp/h6J0kyMRtTL2z1rmbefSRzhSk4X/1AAHcjDaSyMezbM dK4az5CEdO+CxwxlaFX6vEeo1nTBA2z6W7DA3ar177N5fbvEiNhjFzS
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Building a VDSO32 on a 64 bits kernel is problematic when some
system headers are included. See commit 8c59ab839f52 ("lib/vdso:
Enable common headers") for more details.

Minimise the amount of headers by moving needed items into
dedicated common headers.

Removing linux/time64.h leads to missing 'struct timespec64' in
x86's asm/pvclock.h. Add a forward declaration of that struct in
that file.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Split PAGE_SIZE/PAGE_MASK subject in another patch and explained the forward declaration of 'struct timespec64' in commit message.
---
 arch/x86/include/asm/pvclock.h | 1 +
 include/vdso/helpers.h         | 1 +
 lib/vdso/getrandom.c           | 8 +++-----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index 0c92db84469d..6e4f8fae3ce9 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -5,6 +5,7 @@
 #include <asm/clocksource.h>
 #include <asm/pvclock-abi.h>
 
+struct timespec64;
 /* some helper functions for xen and kvm pv clock sources */
 u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
 u64 pvclock_clocksource_read_nowd(struct pvclock_vcpu_time_info *src);
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 73501149439d..3ddb03bb05cb 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -4,6 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/barrier.h>
 #include <vdso/datapage.h>
 
 static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 5874e3072bfe..5d79663b026b 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -4,15 +4,13 @@
  */
 
 #include <linux/array_size.h>
-#include <linux/cache.h>
-#include <linux/kernel.h>
-#include <linux/time64.h>
+#include <linux/minmax.h>
 #include <vdso/datapage.h>
 #include <vdso/getrandom.h>
+#include <vdso/unaligned.h>
 #include <asm/vdso/getrandom.h>
-#include <asm/vdso/vsyscall.h>
-#include <asm/unaligned.h>
 #include <uapi/linux/mman.h>
+#include <uapi/linux/random.h>
 
 #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
 	while (len >= sizeof(type)) {						\
-- 
2.44.0


