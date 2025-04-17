Return-Path: <linux-arch+bounces-11430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A0A92824
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D519719E78E9
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D69264F9A;
	Thu, 17 Apr 2025 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFhVlWou"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D14264A8E;
	Thu, 17 Apr 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914430; cv=none; b=Oka4A6SmQE9Q7Wg7/RUwaf3bK2dup+LXgD65Z1JdW7/RuTkN2ZmilaekuIHzhpddIh9TQoFmmEAiRNte0JiUPjViyawTeL9sd77adLhAHMyHpYPAYBUFkSD1ksyAqi2yDxeKSHojYBrbZV1GYTp7a1IUS/wPUbR4vCNQqWEUOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914430; c=relaxed/simple;
	bh=HKEB5CqVerYhbkmnvqnNR7Xh56F9rN2hh/iDbljsXuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsBbTPK3HSfNglnzCzJ+bdkOcHO4D0qkXz/6Jbz8Jq+RbBewHEF3qYr40Z1WKqP0hqGC3/JRokm6GWrxG2GPxpZwQLa2X6NAajPYhiDdlKh7WspMbVHb6iPbvcFPHoTjfRoeVS5qkKMWOayC/hfc+mFe45zcl3tze4XXPNL4Xas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFhVlWou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4896C4CEEA;
	Thu, 17 Apr 2025 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914429;
	bh=HKEB5CqVerYhbkmnvqnNR7Xh56F9rN2hh/iDbljsXuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFhVlWouUAmT3oifbDC+56pvMoGbq3FY6auILxK/3y+GGXU9nFHxZj0X5SEwDgEEk
	 T+ccHR5spJaee/HwVRv1dOo83XOvLhiSwFu/ZyfvGtx9Cav2juDd7HX7GikHSe/ccP
	 hWmKDT8BcVhVOxFN4YDpxwXLQcPC7eScDGK+7l9ukCTpZCMlK2y2KGjIEHXUe0X9VR
	 jrxGnVNXY2YNjK/wyvvl8J0QkBQ+pmwDf1g5Zy9dHi61wXTC62p1hrLvCW9e1L7kid
	 OjBfoPqlDrgy0LarysHtGUVrGcRRgnaapoSgW3grxNYCCNKc7CS83yehP469AttXlm
	 O/mSVmlUaBuFQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 04/15] crypto: loongarch - source arch/loongarch/crypto/Kconfig without CRYPTO
Date: Thu, 17 Apr 2025 11:26:12 -0700
Message-ID: <20250417182623.67808-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417182623.67808-1-ebiggers@kernel.org>
References: <20250417182623.67808-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Source arch/loongarch/crypto/Kconfig regardless of CRYPTO, so that if
library functions are ever added to there they can be built without
pulling in the generic crypto infrastructure.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/loongarch/Kconfig | 1 +
 crypto/Kconfig         | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 067c0b994648..8ad6cbd8676f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -737,6 +737,7 @@ source "kernel/power/Kconfig"
 source "drivers/acpi/Kconfig"
 source "drivers/cpufreq/Kconfig"
 
 endmenu
 
+source "arch/loongarch/crypto/Kconfig"
 source "arch/loongarch/kvm/Kconfig"
diff --git a/crypto/Kconfig b/crypto/Kconfig
index a5225c6d0488..de71e9c9f2ad 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1424,13 +1424,10 @@ endmenu
 
 config CRYPTO_HASH_INFO
 	bool
 
 if !KMSAN # avoid false positives from assembly
-if LOONGARCH
-source "arch/loongarch/crypto/Kconfig"
-endif
 if MIPS
 source "arch/mips/crypto/Kconfig"
 endif
 if PPC
 source "arch/powerpc/crypto/Kconfig"
-- 
2.49.0


