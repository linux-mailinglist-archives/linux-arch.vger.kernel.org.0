Return-Path: <linux-arch+bounces-5831-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A979944543
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 09:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84C7B20BFA
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1B113D636;
	Thu,  1 Aug 2024 07:17:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12645979;
	Thu,  1 Aug 2024 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496623; cv=none; b=QIaxnvw1z86cPr63XZc9Irli+lZUMb9mT94FR8OfjkFmAQPKPM/IAqyRbPXNQF5INMzlqw/sQGWQUGOlg2EXxJSn88GarEEl3ZjzGtqKINsergiXcJcQZhk+l3vbCWs2Q+ODDP7dPo0hVymRZAYITH9xq6K8i4apgAVh75+G4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496623; c=relaxed/simple;
	bh=urhc24ubONmpcgywMoaMfELl3/bBn5wGOc80Jx8rmfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FWayE/hMM/8uDeRKNnFR7XSbEFb0HlsSwdgmGVQnCKzELY2FGyS/6j00outj5Lz77gUF45FCIqOYSbjHkPXoWoeJ00mu43FOaB4vnSovUFdhijwIBF2yFwtnMeYTGv1jX1ewlehrkVVUTPYdD1sQAWmAgJAhT7qw8nJzLGS31Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE1E41007;
	Thu,  1 Aug 2024 00:17:24 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.56.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 504E13F766;
	Thu,  1 Aug 2024 00:16:56 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	ardb@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH V3 0/2] uapi: Add support for GENMASK_U128()
Date: Thu,  1 Aug 2024 12:46:44 +0530
Message-Id: <20240801071646.682731-1-anshuman.khandual@arm.com>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org

Changes in V3:

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

 include/linux/bits.h       | 13 +++++++++++++
 include/uapi/linux/bits.h  |  3 +++
 include/uapi/linux/const.h | 15 +++++++++++++++
 lib/test_bits.c            | 23 +++++++++++++++++++++++
 4 files changed, 54 insertions(+)

-- 
2.30.2


