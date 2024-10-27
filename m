Return-Path: <linux-arch+bounces-8630-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF89B1F53
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 18:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DC91F20F94
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66EF13CFA8;
	Sun, 27 Oct 2024 17:10:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B376FB6
	for <linux-arch@vger.kernel.org>; Sun, 27 Oct 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730049019; cv=none; b=RqBT4J/fyhaqoAbyhpmYUM5iMWXRQ2BrheERJFPeJ/T1FYqaKbQLcf7ZtbPZUwGqOQGvN3M9b9ZsgJ1vmFJv3YgrOGd6Sn007tM6M9VRZkBDD29Tyr+Y0ek1ayjoO5bXcL+WGqvu0tIesASiSPZngOb0UMPRF3Nw9BmHiMkeIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730049019; c=relaxed/simple;
	bh=5m8BWF2CD6xAaO4UDj+pOZ2Y1qZrz1sVoiupiF+E5hA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BvkPgDKWVlJ5Z7Nt7ydiqpOY7YLDgbBwAVMjDH7A4UBsAVjfofu1Vx3BDWv6yA5YRZOzhEg9jL954TXGbYgm4j6ZfKrREwxuIdnl4mTwv1EEb5kaxHOWZ4zFlE1WHWlQltygK0KxiRvOKMHs6+D7oXMHiyo4AJcy8aEPgvZ3EIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45D36339;
	Sun, 27 Oct 2024 10:01:10 -0700 (PDT)
Received: from udebian.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EEC43F66E;
	Sun, 27 Oct 2024 10:00:39 -0700 (PDT)
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	nd@arm.com,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: [PATCH v2 0/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Date: Sun, 27 Oct 2024 17:00:03 +0000
Message-Id: <20241027170006.464252-1-yury.khrustalev@arm.com>
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

Applies to 42f7652d3eb5 (tag: v6.12-rc4).

Note that I couldn't build ppc tests so I would appreciate if someone
could check the 3rd patch. Thank you!

[1] https://inbox.sourceware.org/libc-alpha/20241022073837.151355-1-yury.khrustalev@arm.com/
[2] https://inbox.sourceware.org/libc-alpha/20241011153614.3189334-1-yury.khrustalev@arm.com/

Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>

---
Chages in v2:
 - Update tools/include/uapi/asm-generic/mman-common.h as well
 - Add usages of the new macro to selftests.

Link to v1: https://lore.kernel.org/linux-arch/20241022120128.359652-1-yury.khrustalev@arm.com/

---
Yury Khrustalev (3):
  mm/pkey: Add PKEY_UNRESTRICTED macro
  selftests/mm: Use PKEY_UNRESTRICTED macro
  selftests/powerpc/mm: Use PKEY_UNRESTRICTED macro

 include/uapi/asm-generic/mman-common.h              | 1 +
 tools/include/uapi/asm-generic/mman-common.h        | 1 +
 tools/testing/selftests/mm/mseal_test.c             | 4 ++--
 tools/testing/selftests/mm/pkey-helpers.h           | 3 ++-
 tools/testing/selftests/mm/pkey_sighandler_tests.c  | 4 ++--
 tools/testing/selftests/mm/protection_keys.c        | 2 +-
 tools/testing/selftests/powerpc/mm/pkey_exec_prot.c | 2 +-
 tools/testing/selftests/powerpc/mm/pkey_siginfo.c   | 2 +-
 8 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.39.5


