Return-Path: <linux-arch+bounces-8090-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB4B99D170
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 17:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C681F244D0
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9F1AD3E1;
	Mon, 14 Oct 2024 15:13:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2476D1AC8A6;
	Mon, 14 Oct 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918829; cv=none; b=QIo1A8VyXkRmjPPu+IqKkhsYx3ID360zhHM6RxAKb1gkBbkqWC3wKFebzl+80W98l9S1a+yJt1eomWN5wfTkwDgzFfV+PITEv5NFAWDajuK27Edo1V63cx/12ArsIOyl/6x0mbhoFOALj3scyRmsFKB+GGojdJpOYYxaLdenLk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918829; c=relaxed/simple;
	bh=OvZk82LA6CB05B05R4XyE/T2XEgdPmG31eU4hosSKjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RcutNTsu1xCRPcNXS6A+7dFJ3SY0KPnusOMmQfkokKyxgtgFHHR1iTlvQ3QVoZDTwowebOyNAlkRxRStwUmffcFVnQDOVLeGSuM34RVfIzfDr73t4Q5diNFhvM4df51qbA87+vfF0ENie428YtE2Fq4igJ9//iASweNMk+mmQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81DB21007;
	Mon, 14 Oct 2024 08:14:15 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A2B83F51B;
	Mon, 14 Oct 2024 08:13:45 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 0/3] vdso: Use only headers from the vdso/ namespace
Date: Mon, 14 Oct 2024 16:13:37 +0100
Message-Id: <20241014151340.1639555-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The recent implementation of getrandom in the generic vdso library,
includes headers from outside of the vdso/ namespace.

The purpose of this series is to refactor the code to make sure
that the library uses only the allowed namespace.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Changes:
--------
v5:
  - Fix an issue on s390 reported by kernel test robot.
v4:
  - Address review comments.
v3:
  - Discard vdso/mman.h changes in favor of [1].
  - Refactor vdso/page.h.
  - Add a fix to drm/intel_gt.
v2:
  - Added common PAGE_SIZE and PAGE_MASK definitions.
  - Added opencoded macros where not defined.
  - Dropped VDSO_PAGE_* redefinitions.

[1] https://lore.kernel.org/lkml/20240925210615.2572360-1-arnd@kernel.org

Vincenzo Frascino (3):
  drm: i915: Change fault type to unsigned long
  vdso: Introduce vdso/page.h
  s390: Remove remaining _PAGE_* macros

 arch/alpha/include/asm/page.h      |  6 +-----
 arch/arc/include/uapi/asm/page.h   |  7 +++----
 arch/arm/include/asm/page.h        |  5 +----
 arch/arm64/include/asm/page-def.h  |  5 +----
 arch/csky/include/asm/page.h       |  8 ++------
 arch/hexagon/include/asm/page.h    |  4 +---
 arch/loongarch/include/asm/page.h  |  7 +------
 arch/m68k/include/asm/page.h       |  6 ++----
 arch/microblaze/include/asm/page.h |  5 +----
 arch/mips/include/asm/page.h       |  7 +------
 arch/nios2/include/asm/page.h      |  7 +------
 arch/openrisc/include/asm/page.h   | 11 +----------
 arch/parisc/include/asm/page.h     |  4 +---
 arch/powerpc/include/asm/page.h    | 10 +---------
 arch/riscv/include/asm/page.h      |  4 +---
 arch/s390/include/asm/page.h       | 10 ++--------
 arch/s390/include/asm/pgtable.h    |  2 +-
 arch/s390/mm/fault.c               |  2 +-
 arch/s390/mm/gmap.c                |  6 +++---
 arch/s390/mm/pgalloc.c             |  4 ++--
 arch/sh/include/asm/page.h         |  6 ++----
 arch/sparc/include/asm/page_32.h   |  4 +---
 arch/sparc/include/asm/page_64.h   |  4 +---
 arch/um/include/asm/page.h         |  5 +----
 arch/x86/include/asm/page_types.h  |  5 +----
 arch/xtensa/include/asm/page.h     |  8 +-------
 drivers/gpu/drm/i915/gt/intel_gt.c |  6 +++---
 include/vdso/page.h                | 30 ++++++++++++++++++++++++++++++
 28 files changed, 68 insertions(+), 120 deletions(-)
 create mode 100644 include/vdso/page.h

-- 
2.34.1


