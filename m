Return-Path: <linux-arch+bounces-6640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03459960326
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 09:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F68B22C46
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 07:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70B18BC02;
	Tue, 27 Aug 2024 07:32:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C6186E3E;
	Tue, 27 Aug 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743936; cv=none; b=h1ANbUKhrDk7yAxWAY4ufqV1NuqBiNYYbdkGvF+yb153G/8gC7KlRT8aMRciquXvOK48RunjxPUXlGYV5n8cO1SXBPyecU+Bj6XzNeDHC/J+SlzoP6harA6gXFbnskKrPLR/MAdPF/9aLchjCOF/Q84aaoVgMc/G09AoO9LRwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743936; c=relaxed/simple;
	bh=o9YWHrFdPzZGidRnEzU0vKK3U5uhwWoxkBlG7VaI1nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oV9OKjRPJuEjbs8XC7CtUeXykTvqwD4vlFqP5gIPkU/zgO0jjaKaHDU6mgyvu5BOL0yT31xF6B07b3Oi0AnPY4SQGVxxNOAAhQwrtuNz23sbxTaNEQcsxU17HXqNjMGFTdUEDef4Pl8CyffUWKeOzqE+xEHzrVY8FhWiAgEnKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtK4Q27v3z9sRr;
	Tue, 27 Aug 2024 09:32:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PPCY-APdZu3N; Tue, 27 Aug 2024 09:32:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtK4P6G7Dz9rvV;
	Tue, 27 Aug 2024 09:32:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C04A08B763;
	Tue, 27 Aug 2024 09:32:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hMVUKRzp0jMh; Tue, 27 Aug 2024 09:32:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO19727.IDSI0.si.c-s.fr [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 21CE18B77B;
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
Subject: [PATCH 2/4] random: vDSO: Don't use PAGE_SIZE and PAGE_MASK
Date: Tue, 27 Aug 2024 09:31:48 +0200
Message-ID: <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724743492.git.christophe.leroy@csgroup.eu>
References: <cover.1724743492.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724743908; l=2168; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=o9YWHrFdPzZGidRnEzU0vKK3U5uhwWoxkBlG7VaI1nw=; b=Jzdk8bA+JLpbtdo4RXJTRUl8shLVBGDmieb0laeJWctzJnZLzRtRPVKLcEx9a6LzVWBohY/cA vXk1XywBvIjAOGdicr0AwQftC4aMQ2oC7T59qsxhVCJj1BnMW3L0h2/
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Using PAGE_SIZE and PAGE_MASK in VDSO requires inclusion of
page.h and it creates several problems, see
commit 8b3843ae3634 ("vdso/datapage: Quick fix - use asm/page-def.h
for ARM64") and commit cffaefd15a8f ("vdso: Use CONFIG_PAGE_SHIFT in
vdso/datapage.h").

An easy solution would be to define PAGE_SIZE and PAGE_MASK in vDSO
when they do not exist already, but this can be misleading.

So follow the same approach as commit cffaefd15a8f ("vdso: Use
CONFIG_PAGE_SHIFT in vdso/datapage.h") and exclusively use
CONFIG_PAGE_SHIFT. To avoid too much ugliness, define local consts
that constains the calculated page size and page mask.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Use local consts instead of _PAGE_SIZE and _PAGE_MASK macros that are already defined by some architectures.
---
 lib/vdso/getrandom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index f1643656d0b0..5874e3072bfe 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -65,7 +65,9 @@ static __always_inline ssize_t
 __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
 		       unsigned int flags, void *opaque_state, size_t opaque_len)
 {
-	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
+	const unsigned long page_size = 1UL << CONFIG_PAGE_SHIFT;
+	const unsigned long page_mask = ~(page_size - 1);
+	ssize_t ret = min_t(size_t, INT_MAX & page_mask /* = MAX_RW_COUNT */, len);
 	struct vgetrandom_state *state = opaque_state;
 	size_t batch_len, nblocks, orig_len = len;
 	bool in_use, have_retried = false;
@@ -84,7 +86,7 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 	}
 
 	/* The state must not straddle a page, since pages can be zeroed at any time. */
-	if (unlikely(((unsigned long)opaque_state & ~PAGE_MASK) + sizeof(*state) > PAGE_SIZE))
+	if (unlikely(((unsigned long)opaque_state & ~page_mask) + sizeof(*state) > page_size))
 		return -EFAULT;
 
 	/* Handle unexpected flags by falling back to the kernel. */
-- 
2.44.0


