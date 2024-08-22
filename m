Return-Path: <linux-arch+bounces-6487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD895ACA8
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38B2283304
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 04:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9171750285;
	Thu, 22 Aug 2024 04:49:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A7364CD;
	Thu, 22 Aug 2024 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302149; cv=none; b=PzHnjbQ2qkEfFtj4IjMmFuzeprzTDaGPmr+WpLolXtD+pvD3iTWORTyzZlTMGsFUK7qZOTAJFWxqFWhV1mEbl5Dz+tmo4pIYs8shsTDnM3FuCcN4HUAOZ/wVAUGKIMnWZ+ZyIPDjJYeaLD136gyzIdLMp8+QyCXYp6AozESRyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302149; c=relaxed/simple;
	bh=XIqY+SgIHpcP4gp2NuKQWlNd35iGqc40AXkBCZxuSMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R4dF7gjyRrrCZW3jfwttY9+uR6SOxK5rZAo69VaZBGQoqipXE3Drlowa24lQW1IqcqX+dxNRMFAMiQDXyQJvIWJcgMJ0kXR5fLlG9LpdyIzP/EW0Wjf/+qVoIGAfw4miAUBBAePNtFFyGA8tmrwvGAt8KECR+XaHDsxh4V6kEpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59D3FDA7;
	Wed, 21 Aug 2024 21:49:31 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.59.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 763C33F73B;
	Wed, 21 Aug 2024 21:49:02 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org,
	yury.norov@gmail.com,
	arnd@arndb.de
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-arch@vger.kernel.org
Subject: [PATCH V4 0/2] uapi: Add support for GENMASK_U128()
Date: Thu, 22 Aug 2024 10:18:51 +0530
Message-Id: <20240822044853.567386-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for GENMASK_U128() and some corresponding tests as well.
GENMASK_U128() generated 128 bit masks will be required later on the arm64
platform for enabling FEAT_SYSREG128 and FEAT_D128 features.

Because GENMAKS_U128() depends on __int128 data type being supported in the
compiler, its usage needs to be protected with CONFIG_ARCH_SUPPORTS_INT128.

This series is being used for an work in progress on arm64 platform.

https://lore.kernel.org/all/20240801054436.612024-1-anshuman.khandual@arm.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org

Changes in V4:

- Folded in the below patch which guards against assembly code
- Fixed __GENMASK_U128() for the corner case (128 bit left shift)
- Improved genmask_u128_test() and genmask_input_check_test()

https://lore.kernel.org/lkml/20240803133753.1598137-1-yury.norov@gmail.com/

Changes in V3:

https://lore.kernel.org/lkml/20240801071646.682731-1-anshuman.khandual@arm.com/

- Dropped unused __BITS_PER_U128
- Moved #ifdef CONFIG_ARCH_SUPPORTS_INT128 inside genmask_u128_test()
- Added asm unsupported comments for GENMASK_U128() and __BIT128()
- Added reviewed tag from Arnd

Changes in V2:

https://lore.kernel.org/all/20240725054808.286708-1-anshuman.khandual@arm.com/

- Wrapped genmask_u128_test() with CONFIG_ARCH_SUPPORTS_INT128
- Defined __BITS_PER_U128 unconditionally as 128
- Defined __GENMASK_U128() via new _BIT128()
- Dropped _U128() and _AC128()

Changes in V1:

https://lore.kernel.org/lkml/20240724103142.165693-1-anshuman.khandual@arm.com/

Anshuman Khandual (2):
  uapi: Define GENMASK_U128
  lib/test_bits.c: Add tests for GENMASK_U128()

 include/linux/bits.h       | 15 +++++++++++++++
 include/uapi/linux/bits.h  |  3 +++
 include/uapi/linux/const.h | 17 +++++++++++++++++
 lib/test_bits.c            | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

-- 
2.30.2


