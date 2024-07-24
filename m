Return-Path: <linux-arch+bounces-5605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F292993AFDF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D0B1F21A37
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E014EC7F;
	Wed, 24 Jul 2024 10:31:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8B374BED;
	Wed, 24 Jul 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817118; cv=none; b=N0GGOsHwkNZGRSGzMWj3NCcYBwQQ7YMntbIQ/laOtVac6fYfGseSW5e28PXLKY7VnGcWGPSDdSig8ogTSj9N+n8w/RcAxVGrVNHgaNnYCgT5Exb/Ydx81SMynViWIV/SHx4ltJ8b6x8tqPAKOWPEyacjC7EWVp3Q/jxq6+KKiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817118; c=relaxed/simple;
	bh=ThPcj9DGGnFiVkLwRiIavD8rNo/H7ZqAEwx44QmzkxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7vohIbAA2gSewKHwpZ4p+Bs3TSXIIRf3FmNIXP9PJTD+O4W+tZH6LanNMUpRk9RcIdCxmFDcuXnDh7+UDjeL51CK8THOxW3slcLQcZoWF6qH7PxD8tkX4KWvpzR3npITbw7MFVNBmgzdrh8/w/NDA0AmBqiQMsJ6WptBDuIvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35C80106F;
	Wed, 24 Jul 2024 03:32:20 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.54.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE8DC3F5A1;
	Wed, 24 Jul 2024 03:31:51 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH 0/2] uapi: Add support for GENMASK_U128()
Date: Wed, 24 Jul 2024 16:01:40 +0530
Message-Id: <20240724103142.165693-1-anshuman.khandual@arm.com>
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

Question:

Proposed GENMASK_U128() depends on __int128 data type being supported in
the compiler. Just wondering if that requires some compiler version #ifdefs
or something similar ?

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org

Anshuman Khandual (2):
  uapi: Define GENMASK_U128
  lib/test_bits.c: Add tests for GENMASK_U128()

 include/linux/bits.h                   |  2 ++
 include/uapi/asm-generic/bitsperlong.h |  4 ++++
 include/uapi/linux/bits.h              |  4 ++++
 include/uapi/linux/const.h             |  3 +++
 lib/test_bits.c                        | 21 +++++++++++++++++++++
 5 files changed, 34 insertions(+)

-- 
2.30.2


