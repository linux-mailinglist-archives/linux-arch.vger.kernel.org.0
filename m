Return-Path: <linux-arch+bounces-6268-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B9A954C89
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5BC1F25B4D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A01BD038;
	Fri, 16 Aug 2024 14:37:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44881BD015;
	Fri, 16 Aug 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819054; cv=none; b=ON15Y1AnWffWFu2b9UAf2/rj26piioE8u6Q0Pgh8RaebIa642dEfuQqZIviURrjH11ZsR1SF5y+FZYOYfkKPRXf/iXLoWjDqHVBG/5pZOO4xHNoalpAXYNjl+L8PCbnLhNXoIJIMfbpTNDrKgb+Kn8roHyvylUsTh01hlrBHepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819054; c=relaxed/simple;
	bh=a4FUUwepBwN5mNCP2XZj9T9GcESiUNu7cFEKFwi5oe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eowZ3yAE76SkiWUKu9AWTN/98tvzbBJgkhgQWPJfpv06QJ+5/UDhRFQiHV8IsqKmLE2+nmZGK4VpZMdtAXe9jwDHHNjRomN+8BP4gUaARoIOPtpp9HdXDXu0LivBacrlGPqwpkHjQFf/1GoYDKrAGUX4AyJfjjm4HeufloA2OXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wll1n29jtz9sSN;
	Fri, 16 Aug 2024 16:37:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g9vYESeDoJdb; Fri, 16 Aug 2024 16:37:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wll1m0gSmz9sSK;
	Fri, 16 Aug 2024 16:37:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 066E18B775;
	Fri, 16 Aug 2024 16:37:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id PPQ3DFzlm0IO; Fri, 16 Aug 2024 16:36:59 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4246D8B764;
	Fri, 16 Aug 2024 16:36:59 +0200 (CEST)
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
Subject: [PATCH 6/9] vdso: Only use MAP_DROPPABLE when VM_DROPPABLE exists
Date: Fri, 16 Aug 2024 16:36:53 +0200
Message-ID: <712424314ffe0bd65b603925ca1283e7d2a3745f.1723817900.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1723817900.git.christophe.leroy@csgroup.eu>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819011; l=1039; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=a4FUUwepBwN5mNCP2XZj9T9GcESiUNu7cFEKFwi5oe0=; b=JTJKpvHJwPkKX/A+Rhg4IQmN4zJeE5RYjU1IFBVGLChXuZCKHQwfcskeTnmjMTTUiAcBGCgFY jGuGavvt1atDe6zhW0cyeXNinoFDn4NBjXUUgrTBNg11X7Rj03nTfEk
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always
lazily freeable mappings") only adds MAP_DROPPABLE for 64 bits
architectures, so don't use it on 32 bits as it leads to ENOTSUPP
on mmap().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/vdso/getrandom.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 425a422651de..11ba6dbf3b5e 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -78,7 +78,11 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 
 		params->size_of_opaque_state = sizeof(*state);
 		params->mmap_prot = PROT_READ | PROT_WRITE;
-		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
+		if (IS_ENABLED(CONFIG_64BIT))
+			params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
+		else
+			params->mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS;
+
 		for (i = 0; i < ARRAY_SIZE(params->reserved); i++)
 			params->reserved[i] = 0;
 
-- 
2.44.0


