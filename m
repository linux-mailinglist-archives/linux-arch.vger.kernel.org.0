Return-Path: <linux-arch+bounces-8923-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDC59C187C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 09:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3339C2870D8
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602611DFE0D;
	Fri,  8 Nov 2024 08:54:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899D61494D4
	for <linux-arch@vger.kernel.org>; Fri,  8 Nov 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056063; cv=none; b=YXWS2bUU9iSmEP2/hq3l/aiAaFe+ygE++lw8PT6B6JKd0BnfnlcdfJWLKzjzfdC4hAYTI6pHZESVp3AvuVawVvTRlDY0rv1zJkn7VqcZZRcSJCkx2e4pOzZMMLGtnOdI0u5pRPbbzjwubwqfq/A2ceFEqHqwMa6IIz06btitc0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056063; c=relaxed/simple;
	bh=ofL10Z8c6G8p/Xg9LR3wW9p2ZQlsG3/jbSpyWXergNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kUBhHVdh6i3QjSaED2//tKiT43BSri5YZfeNXnrlFSLXtIwsIjX2MnIuSflHzCHOAZu4xTlDmDmsk0wJNxlp0xwKH2lr4Oj9/4PcDDgU2Tum705MR11D2ATynOsvf4jMhEzGaq1fSSHZJXWSP485UTFcnNtm+H8TiPdHjqKEb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AF4F497;
	Fri,  8 Nov 2024 00:54:48 -0800 (PST)
Received: from udebian.localdomain (unknown [10.57.26.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671733F66E;
	Fri,  8 Nov 2024 00:54:16 -0800 (PST)
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	nd@arm.com,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: [PATCH v4 0/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Date: Fri,  8 Nov 2024 08:53:55 +0000
Message-Id: <20241108085358.777687-1-yury.khrustalev@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PKEY_UNRESTRICTED macro to mman.h and use it in selftests.

For context, this change will also allow for more consistent update of the
Glibc manual [1] which in turn will help with introducing memory protection
keys on AArch64 targets [2].

Applies to 819837584309 (tag: v6.12-rc5).

Note that I couldn't build ppc tests so I would appreciate if someone
could check the 3rd patch. Thank you!

[1] https://inbox.sourceware.org/libc-alpha/20241022073837.151355-1-yury.khrustalev@arm.com/
[2] https://inbox.sourceware.org/libc-alpha/20241011153614.3189334-1-yury.khrustalev@arm.com/

Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>

---
Changes in v4:
 - Removed change to tools/include/uapi/asm-generic/mman-common.h as it is not
   necessary.

Link to v3: https://lore.kernel.org/all/20241028090715.509527-1-yury.khrustalev@arm.com/

Changes in v3:
 - Replaced previously missed 0-s tools/testing/selftests/mm/mseal_test.c
 - Replaced previously missed 0-s in tools/testing/selftests/mm/mseal_test.c

Link to v2: https://lore.kernel.org/linux-arch/20241027170006.464252-2-yury.khrustalev@arm.com/

Changes in v2:
 - Update tools/include/uapi/asm-generic/mman-common.h as well
 - Add usages of the new macro to selftests.

Link to v1: https://lore.kernel.org/linux-arch/20241022120128.359652-1-yury.khrustalev@arm.com/

---

Yury Khrustalev (3):
  mm/pkey: Add PKEY_UNRESTRICTED macro
  selftests/mm: Use PKEY_UNRESTRICTED macro
  selftests/powerpc: Use PKEY_UNRESTRICTED macro

 include/uapi/asm-generic/mman-common.h               | 1 +
 tools/testing/selftests/mm/mseal_test.c              | 6 +++---
 tools/testing/selftests/mm/pkey-helpers.h            | 3 ++-
 tools/testing/selftests/mm/pkey_sighandler_tests.c   | 4 ++--
 tools/testing/selftests/mm/protection_keys.c         | 2 +-
 tools/testing/selftests/powerpc/include/pkeys.h      | 2 +-
 tools/testing/selftests/powerpc/mm/pkey_exec_prot.c  | 2 +-
 tools/testing/selftests/powerpc/mm/pkey_siginfo.c    | 2 +-
 tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 6 +++---
 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 6 +++---
 10 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.39.5


