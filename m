Return-Path: <linux-arch+bounces-6649-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A8E960461
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9BBB24039
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2718859A;
	Tue, 27 Aug 2024 08:26:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820D54656;
	Tue, 27 Aug 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747204; cv=none; b=OL0DuQwaXwfWjixAmP8gwNtyRWGhh8EXLY7xNgAULRzZX+pqDsm4cFQsggggEstvJzQmqQFuaw8LGNMwhfsV22aMtdLnaHeLF83Ytpfavc/2ndm2il/+2Jd5BacySQruvipbO8xdBqUhA+mputzkmpYQElw7/6eyOfQT3fI0blA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747204; c=relaxed/simple;
	bh=VrUjwEsvjnm9x92ftet3dAaDiU/lOPFlBddTh4Jimzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBaw6fxk9whWgTXogHp4aEYYM/Y8phxeHVHDJzYNix5otXYWgDiY9YDNJmXbDJKY5A4CqrcBdUYfUqlnEjQIwFTWGQdNQ+e4BA8nAqZavztxFF/0BL9RpAsxpFZ1T1qXovhZAAohiHtmj0HAkUy80h4Sbm98IZeeIOSTdILwv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtLHN1ly9z9sRs;
	Tue, 27 Aug 2024 10:26:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mhh1S0ena9Vk; Tue, 27 Aug 2024 10:26:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtLHN10Zcz9sRk;
	Tue, 27 Aug 2024 10:26:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 118488B77B;
	Tue, 27 Aug 2024 10:26:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ZKjKsRV7tgiQ; Tue, 27 Aug 2024 10:26:40 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO19727.IDSI0.si.c-s.fr [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 67AAD8B763;
	Tue, 27 Aug 2024 10:26:39 +0200 (CEST)
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
Subject: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
Date: Tue, 27 Aug 2024 10:26:28 +0200
Message-ID: <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724747190; l=1185; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=VrUjwEsvjnm9x92ftet3dAaDiU/lOPFlBddTh4Jimzg=; b=kXAukdoV22AMsdQQpQEpkGpxMPMlzm7uRM0sQw9po6PRu9HvBgS2oHyJjKNPLjhmEOZYsqrhO N3vOjjEuqsWD8DT3YN2IIqXDZod7JASfOWe/U5my37En5+alm+LgojT
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Using PAGE_SIZE and PAGE_MASK in VDSO requires inclusion of
page.h and it creates several problems, see
commit 8b3843ae3634 ("vdso/datapage: Quick fix - use asm/page-def.h
for ARM64") and commit cffaefd15a8f ("vdso: Use CONFIG_PAGE_SHIFT in
vdso/datapage.h").

Redefine PAGE_SIZE and PAGE_MASK based on CONFIG_PAGE_SHIFT.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Use local consts instead of _PAGE_SIZE and _PAGE_MASK macros that are already defined by some architectures.

v4: undefine and redefine PAGE_SIZE and PAGE_MASK
---
 lib/vdso/getrandom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index f1643656d0b0..e5968ed141cb 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -14,6 +14,11 @@
 #include <asm/unaligned.h>
 #include <uapi/linux/mman.h>
 
+#undef PAGE_SIZE
+#undef PAGE_MASK
+#define PAGE_SIZE	(1UL << CONFIG_PAGE_SHIFT)
+#define PAGE_MASK	(~(PAGE_SIZE - 1))
+
 #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
 	while (len >= sizeof(type)) {						\
 		__put_unaligned_t(type, __get_unaligned_t(type, src), dst);	\
-- 
2.44.0


