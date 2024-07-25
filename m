Return-Path: <linux-arch+bounces-5624-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA693BC23
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 07:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FB6B212B9
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 05:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E21CD2C;
	Thu, 25 Jul 2024 05:48:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4F1CA9E;
	Thu, 25 Jul 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886501; cv=none; b=HDHLjafqnBigm5fpakdB/kSa7ZRneaVlK1MD/SktiEttmTf46S5njb0U6oHzUAXFe6xtw+X420SKLYvCKP3Odlt3++tNir2olaxlwaN0yco+OYUlNwUjXTBF21eDqaBXe1TcLCpZU56Mn3ZrXIHfJnl4rTDbz+2pwVMdCsOhFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886501; c=relaxed/simple;
	bh=V7rXnsnkMkuw8VtkMj4v9JEb2ecE6hAjrhKWABClWGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cXaPcu5wN34sJjrX6KcfpzNDHXFyv06ApLQ8vnL+QVRJN7dMbYNIUY8UXopvrHk9fAX5CxRrGkqj/Y7L8IdkbaZ7eqaS1AgcAo/pHvbXdY6ghpr7nuqSee12YnI4w8ngckYDpyy4PSwxiCBhEGALasORt4dhzGkDzi/bEjAQvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70DB81007;
	Wed, 24 Jul 2024 22:48:42 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 331E33F5A1;
	Wed, 24 Jul 2024 22:48:13 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH V2 0/2] uapi: Add support for GENMASK_U128()
Date: Thu, 25 Jul 2024 11:18:06 +0530
Message-Id: <20240725054808.286708-1-anshuman.khandual@arm.com>
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

Changes in V2:

- Wrapped genmask_u128_test() with CONFIG_ARCH_SUPPORTS_INT128
- Defined __BITS_PER_U128 unconditionally as 128
- Defined __GENMASK_U128() via new _BIT128()
- Dropped _U128() and _AC128()

Changes in V1:

https://lore.kernel.org/lkml/20240724103142.165693-1-anshuman.khandual@arm.com/

Anshuman Khandual (2):
  uapi: Define GENMASK_U128
  lib/test_bits.c: Add tests for GENMASK_U128()

 include/linux/bits.h                   |  2 ++
 include/uapi/asm-generic/bitsperlong.h |  2 ++
 include/uapi/linux/bits.h              |  3 +++
 include/uapi/linux/const.h             |  1 +
 lib/test_bits.c                        | 25 +++++++++++++++++++++++++
 5 files changed, 33 insertions(+)

-- 
2.30.2


