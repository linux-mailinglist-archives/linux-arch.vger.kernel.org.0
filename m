Return-Path: <linux-arch+bounces-9115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 943CB9D018E
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 01:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15932B2093B
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA6BE46;
	Sun, 17 Nov 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae3xjGCt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF736B67A;
	Sun, 17 Nov 2024 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803035; cv=none; b=jKvacCQ/lETFgtOiwh2vJvn2uGyt5ydkLXHqItA9G4HThGKD8M7saxJfKwARg2//zr5zdFbze05F7grp8Vinixh0kQcJmOjrdnd7fNLRoVMAMffA6bKu/FGfP7ChbZa63XQKDfdC4WOOH5WpRFtbv80EiJoydK/KkqaC15u1is8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803035; c=relaxed/simple;
	bh=SOmKtc1U+Cth3ARmtiU8OIUv0APQu6lfcmWi1oOE0T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsmrXphSxK4JxIwweVrNDTwQ5YsyopEjUPcz2/Se92O5E9Z7Z1HoCVOu9ktep85lZIypC/z5iSfg9/RLq6ifpaw9LC9tp2G6HoK5Zx1uhr7NyajqFw3dOWms/g2jBsQAyeVf/QFJfmywg2PILPsXrKAdeBNjGnWnC2Z2oFrmgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae3xjGCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC2CC4CEDB;
	Sun, 17 Nov 2024 00:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731803034;
	bh=SOmKtc1U+Cth3ARmtiU8OIUv0APQu6lfcmWi1oOE0T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ae3xjGCtOs/y/2IA9+TlSWBoIoshQQNPXgr0SgZ3f/r3v0tK6ppp+TNKKkk5FhMaW
	 fzhPJxnAGNYoXtldO4TD34DmtPZGZJVe6afCKZa77lMI67XEvqDcdJsy/eOf4UQzu+
	 UWMfcIvzW7ZZUSkslybJsRHzXpnJ9NwfZeU9Hl8H24dX7fea6Wx8fkBvKzt0IJevAp
	 +Oa1FxY9qXH1f+iivqzfVTgaHpriJPKUjS8BHISYZq/3g2CZr3mrS7oCMW9kzxxkPJ
	 jiuDIbfYJj5EPXDpkPR8PqnoUcYxPOZMjuZXUqo2eVxc9uVn3W3IGA73Qbdf+fCtM+
	 kIcqazZYknmnw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 02/11] lib/crc-t10dif: add support for arch overrides
Date: Sat, 16 Nov 2024 16:22:35 -0800
Message-ID: <20241117002244.105200-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117002244.105200-1-ebiggers@kernel.org>
References: <20241117002244.105200-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Following what was done for CRC32, add support for architecture-specific
override of the CRC-T10DIF library.  This will allow the CRC-T10DIF
library functions to access architecture-optimized code directly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/crc-t10dif.h | 12 ++++++++++++
 lib/Kconfig                | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/crc-t10dif.h b/include/linux/crc-t10dif.h
index 206ba2305483..16787c1cee21 100644
--- a/include/linux/crc-t10dif.h
+++ b/include/linux/crc-t10dif.h
@@ -5,18 +5,30 @@
 #include <linux/types.h>
 
 #define CRC_T10DIF_DIGEST_SIZE 2
 #define CRC_T10DIF_BLOCK_SIZE 1
 
+u16 crc_t10dif_arch(u16 crc, const u8 *p, size_t len);
 u16 crc_t10dif_generic(u16 crc, const u8 *p, size_t len);
 
 static inline u16 crc_t10dif_update(u16 crc, const u8 *p, size_t len)
 {
+	if (IS_ENABLED(CONFIG_CRC_T10DIF_ARCH))
+		return crc_t10dif_arch(crc, p, len);
 	return crc_t10dif_generic(crc, p, len);
 }
 
 static inline u16 crc_t10dif(const u8 *p, size_t len)
 {
 	return crc_t10dif_update(0, p, len);
 }
 
+#if IS_ENABLED(CONFIG_CRC_T10DIF_ARCH)
+bool crc_t10dif_is_optimized(void);
+#else
+static inline bool crc_t10dif_is_optimized(void)
+{
+	return false;
+}
+#endif
+
 #endif
diff --git a/lib/Kconfig b/lib/Kconfig
index eb6c7a023be9..b84aa06ade30 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -147,10 +147,42 @@ config CRC_T10DIF
 	help
 	  This option is only needed if a module that's not in the
 	  kernel tree needs to calculate CRC checks for use with the
 	  SCSI data integrity subsystem.
 
+config ARCH_HAS_CRC_T10DIF
+	bool
+
+choice
+	prompt "CRC-T10DIF implementation"
+	depends on CRC_T10DIF
+	default CRC_T10DIF_IMPL_ARCH if ARCH_HAS_CRC_T10DIF
+	default CRC_T10DIF_IMPL_GENERIC if !ARCH_HAS_CRC_T10DIF
+	help
+	  This option allows you to override the default choice of CRC-T10DIF
+	  implementation.
+
+config CRC_T10DIF_IMPL_ARCH
+	bool "Architecture-optimized" if ARCH_HAS_CRC_T10DIF
+	help
+	  Use the optimized implementation of CRC-T10DIF for the selected
+	  architecture.  It is recommended to keep this enabled, as it can
+	  greatly improve CRC-T10DIF performance.
+
+config CRC_T10DIF_IMPL_GENERIC
+	bool "Generic implementation"
+	help
+	  Use the generic table-based implementation of CRC-T10DIF.  Selecting
+	  this will reduce code size slightly but can greatly reduce CRC-T10DIF
+	  performance.
+
+endchoice
+
+config CRC_T10DIF_ARCH
+	tristate
+	default CRC_T10DIF if CRC_T10DIF_IMPL_ARCH
+
 config CRC64_ROCKSOFT
 	tristate "CRC calculation for the Rocksoft model CRC64"
 	select CRC64
 	select CRYPTO
 	select CRYPTO_CRC64_ROCKSOFT
-- 
2.47.0


