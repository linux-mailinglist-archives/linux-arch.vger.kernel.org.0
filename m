Return-Path: <linux-arch+bounces-6262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6F954C74
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 16:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F47A1C21B5E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F131BC9E8;
	Fri, 16 Aug 2024 14:37:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA419D8BA;
	Fri, 16 Aug 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819025; cv=none; b=GQxfr8NdfOtQmjDvTOOwzad9YIDhQKuyQyhYwpOKC+YfMKyRw6752LUO2GYjXv47MJeK9GwJpgCajclkV9IckeZiaMcinB6rxF17Rz8QZkNu0R5+ijYqi8fnNppXNmXoAjwPbnN+sbnYbcFGUHQEWViPyUINYZTX0PKpZTDXAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819025; c=relaxed/simple;
	bh=sKtjeAqi1sSwChW9svSY9e7JUq5+4EaKfUSF5IEL7S0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVXXVsd7bRes7C9OTm3Q0Qfo/KsqB6+/FSReRj4gwH1ma6PT1JcrQaa98xtQmjTb3tGOTpPakoQ26eazIWZ390qqEWBUCP+TMpx1QiwWlYkIQlu1yNKyrZNsiztwUTvf7F20GYL7cYrLU8lqs8d0ryaHxQJ1/4F6qdf/oIg2ucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wll1g5jm1z9sRy;
	Fri, 16 Aug 2024 16:36:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PzKSDkpQnSSq; Fri, 16 Aug 2024 16:36:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wll1g4YZfz9rvV;
	Fri, 16 Aug 2024 16:36:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8307B8B776;
	Fri, 16 Aug 2024 16:36:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id qQzJ0ozjsD1b; Fri, 16 Aug 2024 16:36:55 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B0AC48B764;
	Fri, 16 Aug 2024 16:36:54 +0200 (CEST)
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
Subject: [PATCH 0/9] Wire up getrandom() vDSO implementation on powerpc
Date: Fri, 16 Aug 2024 16:36:47 +0200
Message-ID: <cover.1723817900.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819011; l=3302; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=sKtjeAqi1sSwChW9svSY9e7JUq5+4EaKfUSF5IEL7S0=; b=oAKuQsByZk+DQGDF9eWOZqGWH6N/EL/Waw6a6aPOMy6Zch7RRTcFX4ztdqp3z8v7s8vR5Ypmv aOwXJM29RTzDI3lAhX+BQQSNYlalWsdNYTAzaOaEIxVzlqNy9+vUWRT
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This series wires up getrandom() vDSO implementation on powerpc.

Tested on PPC32.

Performance on powerpc 885 (using kernel selftest):
	~# ./vdso_test_getrandom bench-single
	   vdso: 2500000 times in 7.897495392 seconds
	   libc: 2500000 times in 56.091632232 seconds
	syscall: 2500000 times in 55.704851989 seconds

Performance on powerpc 8321 (using kernel selftest):
	~# ./vdso_test_getrandom bench-single
	   vdso: 2500000 times in 2.017183250 seconds
	   libc: 2500000 times in 13.088533630 seconds
	syscall: 2500000 times in 12.952458068 seconds

Only build tested on PPC64.

It doesn't build with CONFIG_COMPAT. This is because unlike
gettimeofday.c, getrandom.c includes a lot of headers from outside
of include/vdso/ . The same work as done by
commit 8c59ab839f52 ("lib/vdso: Enable common headers") needs to
be done on lib/vdso/getrandom.c

Among the few strange things to be clarified, there is the format
on the key passed to __arch_chacha20_blocks_nostack(). In
struct vgetrandom_state it is declared as a table of u32, but in
reality it seems it is a flat storage that needs to be loaded in
reversed byte order, so it should either be defined as a table of
bytes, or as a table of __le32 but not a table of u32.

Christophe Leroy (9):
  powerpc/vdso: Don't discard rela sections
  powerpc/vdso32: Add crtsavres
  vdso: Add __arch_get_k_vdso_rng_data()
  vdso: Add missing c-getrandom-y in Makefile
  vdso: Avoid call to memset() by getrandom
  vdso: Only use MAP_DROPPABLE when VM_DROPPABLE exists
  powerpc: Add little endian variants of LHZX_BE and friends
  powerpc/vdso: Wire up getrandom() vDSO implementation
  selftests: [NOT TO BE MERGED] Modifications for testing VDSO getrandom
    implementation on PPC32

 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/asm-compat.h         |  40 ++-
 arch/powerpc/include/asm/vdso/getrandom.h     |  61 ++++
 arch/powerpc/include/asm/vdso/vsyscall.h      |   7 +
 arch/powerpc/include/asm/vdso_datapage.h      |   2 +
 arch/powerpc/kernel/asm-offsets.c             |   1 +
 arch/powerpc/kernel/vdso/Makefile             |  44 ++-
 arch/powerpc/kernel/vdso/getrandom.S          |  62 ++++
 arch/powerpc/kernel/vdso/gettimeofday.S       |  13 -
 arch/powerpc/kernel/vdso/vdso32.lds.S         |   5 +-
 arch/powerpc/kernel/vdso/vdso64.lds.S         |   5 +-
 arch/powerpc/kernel/vdso/vgetrandom-chacha.S  | 297 ++++++++++++++++++
 arch/powerpc/kernel/vdso/vgetrandom.c         |  12 +
 arch/x86/include/asm/vdso/vsyscall.h          |   7 +
 drivers/char/random.c                         |   5 +-
 include/asm-generic/vdso/vsyscall.h           |   7 +
 include/vdso/limits.h                         |   4 +-
 lib/vdso/Makefile                             |   1 +
 lib/vdso/getrandom.c                          |  18 +-
 tools/testing/selftests/vDSO/Makefile         |   2 +-
 .../selftests/vDSO/vdso_test_getrandom.c      |   6 +-
 21 files changed, 553 insertions(+), 47 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/getrandom.h
 create mode 100644 arch/powerpc/kernel/vdso/getrandom.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom.c

-- 
2.44.0


