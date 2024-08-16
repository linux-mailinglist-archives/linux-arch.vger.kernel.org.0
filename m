Return-Path: <linux-arch+bounces-6267-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2ED954C86
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2DE287F57
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DCB1BD01F;
	Fri, 16 Aug 2024 14:37:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112B1BCA14;
	Fri, 16 Aug 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819049; cv=none; b=UHEAvu3kCPX+Vz853fSzQjodWgxa7JyB7Xq4ZLQbQB1CkaVC6/pvo8bTUfXv7eRiPDdBnU50wsKCnABhCRxshyk1UDdbajP1p2tiNa1pvytEf2peYBk39xzInx5a23hwXkTUZrjYTEKJL7/LpfHdG9JXOgUXAn282jkzjmikSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819049; c=relaxed/simple;
	bh=CrwMxKdC9EG6K+skjM2PZ6vc4+LiPcnzB9hzBfW5oy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAqAY70S+EI9gX8+5oFXCzAt9C70UPkd92iv5Pex8Co1SdrDFTV0jROUcVxrW1Rm7dye3z30NXHbSLezFmi+K3BO+D9OPlmUcqTUOHj0OXljSKeuKHwKdrQrK82Qjb10wtw/3N/eO0BDdlbcrHy7ZfL6HOBBHt0KugGZPVbAxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wll1m1P0jz9sSL;
	Fri, 16 Aug 2024 16:37:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UbagSwJXMetO; Fri, 16 Aug 2024 16:37:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wll1l2WbGz9rvV;
	Fri, 16 Aug 2024 16:36:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 428958B775;
	Fri, 16 Aug 2024 16:36:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id UvuuFuuH4N6N; Fri, 16 Aug 2024 16:36:59 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8348A8B776;
	Fri, 16 Aug 2024 16:36:58 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 5/9] vdso: Avoid call to memset() by getrandom
Date: Fri, 16 Aug 2024 16:36:52 +0200
Message-ID: <a6183ad90ec4834a10f8c751018cca7ca41059a1.1723817900.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1723817900.git.christophe.leroy@csgroup.eu>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819011; l=1272; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=CrwMxKdC9EG6K+skjM2PZ6vc4+LiPcnzB9hzBfW5oy8=; b=YeBID6WvEtA5bi7WLD75S6AnFHkqZFicDNiRtcy07EMW8xc9ZMNW3X2gcsmfv0ZiaCv7SWist ZeeMgG4vrMtDV2lg2gaTqySeTWTuM9iBBltf93yBrYA2DS2XN5iPy7i
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

With the current implementation, __cvdso_getrandom_data() calls
memset(), which is unexpected in the VDSO.

Rewrite opaque data initialisation to avoid memset().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/vdso/getrandom.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index b230f0b10832..425a422651de 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -73,11 +73,15 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 	u32 counter[2] = { 0 };
 
 	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
-		*(struct vgetrandom_opaque_params *)opaque_state = (struct vgetrandom_opaque_params) {
-			.size_of_opaque_state = sizeof(*state),
-			.mmap_prot = PROT_READ | PROT_WRITE,
-			.mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS
-		};
+		struct vgetrandom_opaque_params *params = opaque_state;
+		int i;
+
+		params->size_of_opaque_state = sizeof(*state);
+		params->mmap_prot = PROT_READ | PROT_WRITE;
+		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
+		for (i = 0; i < ARRAY_SIZE(params->reserved); i++)
+			params->reserved[i] = 0;
+
 		return 0;
 	}
 
-- 
2.44.0


