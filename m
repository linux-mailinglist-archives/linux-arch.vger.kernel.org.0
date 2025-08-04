Return-Path: <linux-arch+bounces-13037-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41378B1A740
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D9617E8C6
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607E7286412;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoDkY9It"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF90285CB4;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=WSNq1mC/KDvlcmwHxDw8FCOgDF0aaA15hB5yFvjdPgCO5OlPQcaE6FgH38E9mkf7Fnj0oFngUamQh+ANJX87bjh3aDeFcp2ghnCxxnrHb8/OeeHgmbNi/7hpjs8Avf7sosUZDn5kWVz+Yf5vaDdZcBcX81FElnXmRBCy9KoWRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=r2v62d4bVt9owj808SKHRzdSx9oLY8KjiUCy34x/12Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WQVQ2nnyYT+7/wID2RgApF7nwkD5Xigec+azBHEQl736z6Vt3hMFF9209D7lTbsTFRUfaYWm1zfOS4dg9zsUY3xw1ayJC+9RqBqNRXrCq84Y81twEFa8DwdetY2cNfZ5GtqdfBbE+CLLrpL19nuppZKHHMjawe1+lOJZbjBWAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoDkY9It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE13C4CEE7;
	Mon,  4 Aug 2025 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325857;
	bh=r2v62d4bVt9owj808SKHRzdSx9oLY8KjiUCy34x/12Y=;
	h=From:To:Cc:Subject:Date:From;
	b=qoDkY9It5/lqR9fbX6g8iGg/nmmtCv14BOgAwhkb5uNiClyFaMkiukY7Oc+J1MaKh
	 dZnz4X/S3ajFCt76duYJHDx0quVZH6oSu/c0vStSRzaSzbCcMKFV4L18ye0ZTJoXPN
	 i3oURUhH5BvGFLUiBhUMaVt9LAqwPNrH4pyC8RyKbvz3yMn0pqcXcQS+g91j40QHjM
	 lNQCmlS8pNR7LcsmFHjuc2AbEWdFGnRvWbhlC/VB8DAo2fUatOIF7DscYokL7FpXgy
	 l5z39sJCmL4o5lHPcQDJdF9jtn/jsrC9WDmDQnvKWCYKZ26XpAxSx9TjSBv7Ns52lt
	 j7UHemkdNe4Mg==
From: Kees Cook <kees@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 00/17] Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:43:56 -0700
Message-Id: <20250804163910.work.929-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3619; i=kees@kernel.org; h=from:subject:message-id; bh=r2v62d4bVt9owj808SKHRzdSx9oLY8KjiUCy34x/12Y=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHofFXgjp7KzykhVPcF48Q+LLy7qNn3Wc38x5WLbt/ 44z4VPWdZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzERo7hf8kiKe0FSd8l7Cv7 We7uUrdPYDs+m0lg/c5Dkx57tW49XMrwT2vS53lTDZ/v/XEnZcFFsaM9CXKfOL49eCxys3TZx5i tytwA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

While tracking down a problem where constant expressions used by
BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
initializer was convincing the compiler that it couldn't track the state
of the prior statically initialized value. Tracing this down found that
ffs() was used in the initializer macro, but since it wasn't marked with
__attribute_const__, the compiler had to assume the function might
change variable states as a side-effect (which is not true for ffs(),
which provides deterministic math results).

Add KUnit tests for the family of functions and then add __attribute_const__
to all architecture implementations and wrappers.

-Kees

[1] https://github.com/KSPP/linux/issues/364

Kees Cook (17):
  KUnit: Introduce ffs()-family tests
  bitops: Add __attribute_const__ to generic ffs()-family
    implementations
  csky: Add __attribute_const__ to ffs()-family implementations
  x86: Add __attribute_const__ to ffs()-family implementations
  powerpc: Add __attribute_const__ to ffs()-family implementations
  sh: Add __attribute_const__ to ffs()-family implementations
  alpha: Add __attribute_const__ to ffs()-family implementations
  hexagon: Add __attribute_const__ to ffs()-family implementations
  riscv: Add __attribute_const__ to ffs()-family implementations
  openrisc: Add __attribute_const__ to ffs()-family implementations
  m68k: Add __attribute_const__ to ffs()-family implementations
  mips: Add __attribute_const__ to ffs()-family implementations
  parisc: Add __attribute_const__ to ffs()-family implementations
  s390: Add __attribute_const__ to ffs()-family implementations
  xtensa: Add __attribute_const__ to ffs()-family implementations
  sparc: Add __attribute_const__ to ffs()-family implementations
  KUnit: ffs: Validate all the __attribute_const__ annotations

 lib/Kconfig.debug                          |  14 +
 lib/tests/Makefile                         |   1 +
 arch/alpha/include/asm/bitops.h            |  14 +-
 arch/csky/include/asm/bitops.h             |   8 +-
 arch/hexagon/include/asm/bitops.h          |  10 +-
 arch/m68k/include/asm/bitops.h             |  14 +-
 arch/mips/include/asm/bitops.h             |   8 +-
 arch/openrisc/include/asm/bitops/__ffs.h   |   2 +-
 arch/openrisc/include/asm/bitops/__fls.h   |   2 +-
 arch/openrisc/include/asm/bitops/ffs.h     |   2 +-
 arch/openrisc/include/asm/bitops/fls.h     |   2 +-
 arch/parisc/include/asm/bitops.h           |   6 +-
 arch/powerpc/include/asm/bitops.h          |   4 +-
 arch/riscv/include/asm/bitops.h            |   6 +-
 arch/s390/include/asm/bitops.h             |  10 +-
 arch/sh/include/asm/bitops.h               |   4 +-
 arch/sparc/include/asm/bitops_64.h         |   8 +-
 arch/x86/include/asm/bitops.h              |  12 +-
 arch/xtensa/include/asm/bitops.h           |  10 +-
 include/asm-generic/bitops/__ffs.h         |   2 +-
 include/asm-generic/bitops/__fls.h         |   2 +-
 include/asm-generic/bitops/builtin-__ffs.h |   2 +-
 include/asm-generic/bitops/builtin-__fls.h |   2 +-
 include/asm-generic/bitops/builtin-fls.h   |   2 +-
 include/asm-generic/bitops/ffs.h           |   2 +-
 include/asm-generic/bitops/fls.h           |   2 +-
 include/asm-generic/bitops/fls64.h         |   4 +-
 include/linux/bitops.h                     |   2 +-
 lib/clz_ctz.c                              |   8 +-
 lib/tests/ffs_kunit.c                      | 566 +++++++++++++++++++++
 30 files changed, 656 insertions(+), 75 deletions(-)
 create mode 100644 lib/tests/ffs_kunit.c

-- 
2.34.1


