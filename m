Return-Path: <linux-arch+bounces-9113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC119D0187
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 01:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF052863AE
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CBB23AD;
	Sun, 17 Nov 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdBB+C8w"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E651392;
	Sun, 17 Nov 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803033; cv=none; b=dkvbCHyqG2vKcY+XSQMXDlhTonEL5tzYiVHBxPx3S+2tWqaEu8/C7+BGRjW/6r49oHMcz/9ekbo/RnVr3iNGb3nnWF2a4W+M+RFEqNTXpCKn2xa70PR/5VSJQERSWl0esXzSZ+YNYfuq4+pPwbRAjAhK3AoMyAhHZPwZbQOQSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803033; c=relaxed/simple;
	bh=CnepUwceJ5j9G5NUVs6UktH+oiMT+FJpiIqYKC1mGcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8Acgn3bJBzRM3qFImllAaT/1rGNEXjKm+i9XU1uSusd96cYpwjkBhouY9DxJ8UNAqW740nROByXc9CfAyYocoq9KrkgTt7YFpYx6eUDmkj/eosgq4Uo+WZhLN5siWaiJAJmYoJYX6gA6FWNayV6B7CpGGeEMNe6rr9e5kTU83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdBB+C8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AC4C4CEC3;
	Sun, 17 Nov 2024 00:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731803033;
	bh=CnepUwceJ5j9G5NUVs6UktH+oiMT+FJpiIqYKC1mGcA=;
	h=From:To:Cc:Subject:Date:From;
	b=QdBB+C8wOvDetydffbpqtgfNNLWzIrqbXMWelcLY8DuPmy5RGF5zfG+A0FsY+HaNG
	 O5PCgWFRW5GIMrGbfXgQ6Hbr4YtcyZFG8IX5XfaCSbHMkjiym1yO4Kr1vWmJjTz2fZ
	 sm8sHc6x2aDG3jtzdyegeDIKNBOQi7ERfR9RL9g136J9NuF533+AkCvwC9xhixjbJK
	 u1l2xA91Oc3DJfkMqNMcmT3wcn905syEAe0IL49XL3ZtPbOEUqsh2M59r6C7RbJfDQ
	 QdCEl8TCXEqTxxKPYmzGsTFdNGINwDhOyLJK07Ss4YFDkwMup0R7ZLkN14z7Cabzgs
	 4a3bW9/6PvKqQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 00/11] Wire up CRC-T10DIF library functions to arch-optimized code
Date: Sat, 16 Nov 2024 16:22:33 -0800
Message-ID: <20241117002244.105200-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is also available in git via:

    git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc-t10dif-lib-v1

This patchset updates the kernel's CRC-T10DIF library functions to be
directly optimized for x86, arm, arm64, and powerpc without taking an
unnecessary and inefficient detour through the crypto API.  It follows
the same approach that I'm taking for CRC32 in the patchset
https://lore.kernel.org/linux-crypto/20241103223154.136127-1-ebiggers@kernel.org

This patchset also adds a CRC KUnit test suite that covers multiple CRC
variants, and deletes some older ad-hoc tests that are obsoleted by it.

This patchset has several dependencies including my CRC32 patchset and
patches queued in several trees for 6.13.  It can be retrieved from git
using the command given above.  This is targeting 6.14.

Eric Biggers (11):
  lib/crc-t10dif: stop wrapping the crypto API
  lib/crc-t10dif: add support for arch overrides
  crypto: crct10dif - expose arch-optimized lib function
  x86/crc-t10dif: expose CRC-T10DIF function through lib
  arm/crc-t10dif: expose CRC-T10DIF function through lib
  arm64/crc-t10dif: expose CRC-T10DIF function through lib
  powerpc/crc-t10dif: expose CRC-T10DIF function through lib
  lib/crc_kunit.c: add KUnit test suite for CRC library functions
  lib/crc32test: delete obsolete crc32test.c
  powerpc/crc: delete obsolete crc-vpmsum_test.c
  MAINTAINERS: add entry for CRC library

 MAINTAINERS                                   |  11 +
 arch/arm/Kconfig                              |   1 +
 arch/arm/crypto/Kconfig                       |  11 -
 arch/arm/crypto/Makefile                      |   2 -
 arch/arm/crypto/crct10dif-ce-glue.c           | 124 ---
 arch/arm/lib/Makefile                         |   3 +
 .../crc-t10dif-core.S}                        |   0
 arch/arm/lib/crc-t10dif-glue.c                |  77 ++
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/configs/defconfig                  |   1 -
 arch/arm64/crypto/Kconfig                     |  10 -
 arch/arm64/crypto/Makefile                    |   3 -
 arch/arm64/crypto/crct10dif-ce-glue.c         | 132 ---
 arch/arm64/lib/Makefile                       |   3 +
 .../crc-t10dif-core.S}                        |   0
 arch/arm64/lib/crc-t10dif-glue.c              |  78 ++
 arch/m68k/configs/amiga_defconfig             |   1 -
 arch/m68k/configs/apollo_defconfig            |   1 -
 arch/m68k/configs/atari_defconfig             |   1 -
 arch/m68k/configs/bvme6000_defconfig          |   1 -
 arch/m68k/configs/hp300_defconfig             |   1 -
 arch/m68k/configs/mac_defconfig               |   1 -
 arch/m68k/configs/multi_defconfig             |   1 -
 arch/m68k/configs/mvme147_defconfig           |   1 -
 arch/m68k/configs/mvme16x_defconfig           |   1 -
 arch/m68k/configs/q40_defconfig               |   1 -
 arch/m68k/configs/sun3_defconfig              |   1 -
 arch/m68k/configs/sun3x_defconfig             |   1 -
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/configs/powernv_defconfig        |   1 -
 arch/powerpc/configs/ppc64_defconfig          |   2 -
 arch/powerpc/crypto/Kconfig                   |  20 -
 arch/powerpc/crypto/Makefile                  |   3 -
 arch/powerpc/crypto/crc-vpmsum_test.c         | 133 ---
 arch/powerpc/lib/Makefile                     |   3 +
 .../crc-t10dif-glue.c}                        |  69 +-
 .../{crypto => lib}/crct10dif-vpmsum_asm.S    |   2 +-
 arch/s390/configs/debug_defconfig             |   1 -
 arch/x86/Kconfig                              |   1 +
 arch/x86/crypto/Kconfig                       |  10 -
 arch/x86/crypto/Makefile                      |   3 -
 arch/x86/crypto/crct10dif-pclmul_glue.c       | 143 ---
 arch/x86/lib/Makefile                         |   3 +
 arch/x86/lib/crc-t10dif-glue.c                |  51 ++
 .../{crypto => lib}/crct10dif-pcl-asm_64.S    |   0
 crypto/Kconfig                                |   1 +
 crypto/Makefile                               |   3 +-
 crypto/crct10dif_common.c                     |  82 --
 crypto/crct10dif_generic.c                    |  82 +-
 include/linux/crc-t10dif.h                    |  28 +-
 lib/Kconfig                                   |  43 +-
 lib/Kconfig.debug                             |  20 +
 lib/Makefile                                  |   2 +-
 lib/crc-t10dif.c                              | 156 +---
 lib/crc32test.c                               | 852 ------------------
 lib/crc_kunit.c                               | 428 +++++++++
 .../testing/selftests/arm64/fp/kernel-test.c  |   3 +-
 57 files changed, 867 insertions(+), 1748 deletions(-)
 delete mode 100644 arch/arm/crypto/crct10dif-ce-glue.c
 rename arch/arm/{crypto/crct10dif-ce-core.S => lib/crc-t10dif-core.S} (100%)
 create mode 100644 arch/arm/lib/crc-t10dif-glue.c
 delete mode 100644 arch/arm64/crypto/crct10dif-ce-glue.c
 rename arch/arm64/{crypto/crct10dif-ce-core.S => lib/crc-t10dif-core.S} (100%)
 create mode 100644 arch/arm64/lib/crc-t10dif-glue.c
 delete mode 100644 arch/powerpc/crypto/crc-vpmsum_test.c
 rename arch/powerpc/{crypto/crct10dif-vpmsum_glue.c => lib/crc-t10dif-glue.c} (50%)
 rename arch/powerpc/{crypto => lib}/crct10dif-vpmsum_asm.S (99%)
 delete mode 100644 arch/x86/crypto/crct10dif-pclmul_glue.c
 create mode 100644 arch/x86/lib/crc-t10dif-glue.c
 rename arch/x86/{crypto => lib}/crct10dif-pcl-asm_64.S (100%)
 delete mode 100644 crypto/crct10dif_common.c
 delete mode 100644 lib/crc32test.c
 create mode 100644 lib/crc_kunit.c

-- 
2.47.0


