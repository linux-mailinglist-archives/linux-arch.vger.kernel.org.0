Return-Path: <linux-arch+bounces-6638-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D8960318
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 09:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844E81C220D6
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7814CB4E;
	Tue, 27 Aug 2024 07:32:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEEC747F;
	Tue, 27 Aug 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743928; cv=none; b=PoP9dxwiMWBzIOcREmgeUknN7AFEzEvhe4scNw4qczYmtXQ2whiCJkTi1iTOxxL/7kL7duRSjCk/HFE/p81D1KJMXhADKpLZ46o0bBqmk78ozf5IjNqLO9jg0aGHH9nSmg7cORXa3wtUNB8v1FkEi+Ep0DBD9mhJsFk6kNV9fRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743928; c=relaxed/simple;
	bh=DlsazXpgUZ+Rtf+gb3LjakzOdGFeaxRc9UblP4KWKkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrjJIcHSYTfdW9Bm+1QwxOcYbfgXxgS3eN+aejiRABpw3SLBFgicWBtKD2AidhFQ0CWxFIsC+vwQDRDrcWvyxoS3W63ixr6Nl7wNRzInwSJEFvXaK0vtq0jKYmvG9+mJy1FOwiEHJYu6ADky5Oej+pArGWdaP8/Ua1lt4mMRoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtK4N4xQ2z9sPd;
	Tue, 27 Aug 2024 09:32:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjwE0QcQuI4l; Tue, 27 Aug 2024 09:32:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtK4N469Zz9rvV;
	Tue, 27 Aug 2024 09:32:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 708458B77B;
	Tue, 27 Aug 2024 09:32:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6FfdSprD4Gq4; Tue, 27 Aug 2024 09:32:04 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO19727.IDSI0.si.c-s.fr [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BCBAA8B763;
	Tue, 27 Aug 2024 09:32:03 +0200 (CEST)
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
Subject: [PATCH 0/4] Fixups for random vDSO
Date: Tue, 27 Aug 2024 09:31:46 +0200
Message-ID: <cover.1724743492.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724743907; l=1053; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=DlsazXpgUZ+Rtf+gb3LjakzOdGFeaxRc9UblP4KWKkc=; b=sdhBscEZA9sEt9ACfOkHid5Wfi17/wl5Iazag5dtcitKymflhseYNsbZYejQ9fMxtytfSgFyH pX/OHgL9JrkDr4wlbpnFZqxdwB157PBRrLw0bDx7LlggB506rgXG0pm
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This small series is an extract of fixups for generic part of random vDSO in
preparation of implementing vDSO getrandom for powerpc.

See last version of full series at:
https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1724309198.git.christophe.leroy@csgroup.eu/

This series is based on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master

Christophe Leroy (4):
  asm-generic/unaligned.h: Extract common header for vDSO
  random: vDSO: Don't use PAGE_SIZE and PAGE_MASK
  random: vDSO: Clean header inclusion in getrandom
  random: vDSO: don't use 64 bits atomics on 32 bits architectures

 arch/x86/include/asm/pvclock.h  |  1 +
 drivers/char/random.c           |  9 ++++++++-
 include/asm-generic/unaligned.h | 11 +----------
 include/vdso/helpers.h          |  1 +
 include/vdso/unaligned.h        | 15 +++++++++++++++
 lib/vdso/getrandom.c            | 16 ++++++++--------
 6 files changed, 34 insertions(+), 19 deletions(-)
 create mode 100644 include/vdso/unaligned.h

-- 
2.44.0


