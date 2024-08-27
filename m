Return-Path: <linux-arch+bounces-6642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC9996032A
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48570283982
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 07:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB0156C5E;
	Tue, 27 Aug 2024 07:32:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E0156887;
	Tue, 27 Aug 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743945; cv=none; b=DVNtyTK1DapbTmUA4xV94jYb4jo7MkDuBqeDnlabNjPIl4Gg1LeFIVZwYmaSr/gZEpEINSuk5stp0ARNY/fTwylfyR6JOusaMuN84fSZM1neOHUlv373CGHqEuisWe6ZhEzUuaLRSjp5PcC777ZL0xB5G2XM0sOuTgNQKwQSA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743945; c=relaxed/simple;
	bh=EN/UMBGKSnmN3+T0MpJVkTK4QnATFUq0wPjwJbUuUVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZqN/hIpEBizaRRf+m/u7MOXnODfapQC5oohyfvnQdUSDlspKp0eknSZYWXuzsYTULHKgjnF+Jowo64jyDPv6y6iOUT2XDqlkqXP2Lj1Kv+abT1W8qDm1GQtG4KLWq2jcdlhNHkRPLLWxK5fXN919D2c6ybdraqnTX2cSQtYNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtK4S4q7Sz9rvV;
	Tue, 27 Aug 2024 09:32:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LSYoNPXiTAE6; Tue, 27 Aug 2024 09:32:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtK4R1flWz9sRs;
	Tue, 27 Aug 2024 09:32:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 23E088B763;
	Tue, 27 Aug 2024 09:32:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4LCKcOlpJf6Q; Tue, 27 Aug 2024 09:32:07 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO19727.IDSI0.si.c-s.fr [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D5BC8B77B;
	Tue, 27 Aug 2024 09:32:06 +0200 (CEST)
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
Subject: [PATCH 4/4] random: vDSO: don't use 64 bits atomics on 32 bits architectures
Date: Tue, 27 Aug 2024 09:31:50 +0200
Message-ID: <30806cb8d7e0b95dcfb9f81a4583759faa1d8f31.1724743492.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724743492.git.christophe.leroy@csgroup.eu>
References: <cover.1724743492.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724743908; l=4569; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=EN/UMBGKSnmN3+T0MpJVkTK4QnATFUq0wPjwJbUuUVk=; b=Nwn7m7g/QRHzdHMcbW6llmXewvtc/OYYeNu4SAjX+iILbev4KO02GLLjFcAIh7i1/ooUna0MF /yqwYLw77rTDzFYHY/tsKw0DoLFqoAE97mcrlt5Y5ZDxUz3gX4oj3Gb
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Performing SMP atomic operations on u64 fails on powerpc32:

    CC      drivers/char/random.o
  In file included from <command-line>:
  drivers/char/random.c: In function 'crng_reseed':
  ././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_391' declared with attribute error: Need native word sized stores/loads for atomicity.
    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |                                             ^
  ././include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
    491 |                         prefix ## suffix();                             \
        |                         ^~~~~~
  ././include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^~~~~~~~~~~~~~~~~~~
  ././include/linux/compiler_types.h:513:9: note: in expansion of macro 'compiletime_assert'
    513 |         compiletime_assert(__native_word(t),                            \
        |         ^~~~~~~~~~~~~~~~~~
  ./arch/powerpc/include/asm/barrier.h:74:9: note: in expansion of macro 'compiletime_assert_atomic_type'
     74 |         compiletime_assert_atomic_type(*p);                             \
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
    172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
        |                                                       ^~~~~~~~~~~~~~~~~~~
  drivers/char/random.c:286:9: note: in expansion of macro 'smp_store_release'
    286 |         smp_store_release(&__arch_get_k_vdso_rng_data()->generation, next_gen + 1);
        |         ^~~~~~~~~~~~~~~~~

Random driver generation is handled as unsigned long not u64, see for
instance base_cnrg or struct crng.

But on vDSO it needs to be an u64 not just an unsigned long because of
32 bits VDSO being used with 64 bits kernels.

On random side however it is an unsigned long hence a 32 bits value on
32 bits architectures, so just cast it to unsigned long for the
smp_store_release(). A side effect is that on big endian architectures
the store will be performed in the upper 32 bits. It is not an issue
on its own because the vDSO site doesn't mind the value, it only
checks differences. Just make sure that the vDSO side checks the full
64 bits, for that the local current_generation has to be u64 as well.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Cast to unsigned long in random and use u64 in vDSO instead of changing generation field to unsigned long
---
 drivers/char/random.c | 9 ++++++++-
 lib/vdso/getrandom.c  | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 77968309e2c2..dc9bab51e74d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -282,8 +282,15 @@ static void crng_reseed(struct work_struct *work)
 	 * former to arrive at the latter. Use smp_store_release so that this
 	 * is ordered with the write above to base_crng.generation. Pairs with
 	 * the smp_rmb() before the syscall in the vDSO code.
+	 *
+	 * Cast to unsigned long for 32 bits architectures as atomic 64 bits
+	 * operations are not supported on those architectures. Anyway
+	 * base_crng.generation is a 32 bits value so it is ok. On big endian
+	 * architectures it will be stored in the upper 32 bits but that's ok
+	 * because the vDSO side only checks whether the value changed, it
+	 * doesn't use or interpret the value.
 	 */
-	smp_store_release(&__arch_get_k_vdso_rng_data()->generation, next_gen + 1);
+	smp_store_release((unsigned long *)&__arch_get_k_vdso_rng_data()->generation, next_gen + 1);
 #endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 5d79663b026b..8027b2711b69 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -69,7 +69,7 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 	struct vgetrandom_state *state = opaque_state;
 	size_t batch_len, nblocks, orig_len = len;
 	bool in_use, have_retried = false;
-	unsigned long current_generation;
+	u64 current_generation;
 	void *orig_buffer = buffer;
 	u32 counter[2] = { 0 };
 
-- 
2.44.0


