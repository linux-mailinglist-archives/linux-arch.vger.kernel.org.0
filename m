Return-Path: <linux-arch+bounces-7121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D275970718
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 13:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA61281EC3
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 11:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E61514BFB4;
	Sun,  8 Sep 2024 11:50:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E518C22;
	Sun,  8 Sep 2024 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796241; cv=none; b=EHRXCiOMJnkDPWhMApBgO22A6kwNyWVhKJPQHCp3p4SSm50i1+x/Cmg/I5h6YEe6cgSvOAwnW5V9sgO3mJvHKWufSxUOFwc4MFA0j6ANQIrf1wBT4GMeMX8I4RBieOcaTWzkuKecPLvS85fZQB6aDCh7QHhgWXBtwz0fhCBzjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796241; c=relaxed/simple;
	bh=f4b3EWGgDvYEBxJXLd9EJXkZFmAy/z1D3M4a+/Gf9BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZulf1N1B+HeaGHPEnquEPGlBNdRVmYM0lRYjyfqYdTRbsDarcQJe7VCUlN+zzQyzmYgQ2Sw/nwhU405dBw2M/XJloKKPXV0e1dYFM5S47naNtza9JhREDUrrRJLePXCkFcHoG+juLY0EmoAUJ84jtr42pFAistE10xSS3G42kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X1pF965xzz9rvV;
	Sun,  8 Sep 2024 13:50:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CAwNtBLKD90C; Sun,  8 Sep 2024 13:50:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X1pF32Rqbz9sSK;
	Sun,  8 Sep 2024 13:50:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D802D8CC3A;
	Sat,  7 Sep 2024 17:40:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WICCX_2l4Sbn; Sat,  7 Sep 2024 17:40:49 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.96])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 73A788CC38;
	Sat,  7 Sep 2024 17:40:49 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	arnd@arndb.de
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-hardening@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH] set_memory: Add __must_check to generic stubs
Date: Sat,  7 Sep 2024 17:40:42 +0200
Message-ID: <6a89ffc69666de84721216947c6b6c7dcca39d7d.1725723347.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <775dae48064a661554802ed24ed5bdffe1784724.1725723351.git.christophe.leroy@csgroup.eu>
References: <775dae48064a661554802ed24ed5bdffe1784724.1725723351.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725723642; l=1883; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=f4b3EWGgDvYEBxJXLd9EJXkZFmAy/z1D3M4a+/Gf9BE=; b=GO8Jmv0feXJjWdAIlGrWtN3vOIY+RcbII4YzFBMOV4qn10O93VQTky4E/rglcXaFOX/2T25C5 TUaw+OtAjkkBvWcjTprrjV966nDWaRdnZM26nPa74kRTTib6k4Guy2w
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Following query shows that architectures that don't provide
asm/set_memory.h don't use set_memory_...() functions.

  $ git grep set_memory_ alpha arc csky hexagon loongarch m68k microblaze mips nios2 openrisc parisc sh sparc um xtensa

Following query shows that all core users of set_memory_...()
functions always take returned value into account:

  $ git grep -w -e set_memory_ro -e set_memory_rw -e set_memory_x -e set_memory_nx -e set_memory_rox `find . -maxdepth 1 -type d | grep -v arch | grep /`

set_memory_...() functions can fail, leaving the memory attributes
unchanged. Make sure all callers check the returned code.

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/set_memory.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 95ac8398ee72..e7aec20fb44f 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -8,10 +8,10 @@
 #ifdef CONFIG_ARCH_HAS_SET_MEMORY
 #include <asm/set_memory.h>
 #else
-static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
-static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
-static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
-static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
+static inline int __must_check set_memory_ro(unsigned long addr, int numpages) { return 0; }
+static inline int __must_check set_memory_rw(unsigned long addr, int numpages) { return 0; }
+static inline int __must_check set_memory_x(unsigned long addr,  int numpages) { return 0; }
+static inline int __must_check set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
 #ifndef set_memory_rox
-- 
2.44.0


