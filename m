Return-Path: <linux-arch+bounces-12279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CB3AD0F90
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 22:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18C0166A4F
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 20:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82982206BC;
	Sat,  7 Jun 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajEhG5/8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD021FF3D;
	Sat,  7 Jun 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749326854; cv=none; b=oJYwXHAi4CV7uQLUdu8p7PSmILQy96wboUnQBE4umnMByR6F2+a/CG7Yc/Y0giYpuUtT5O2Eq9sICMOSDGb5jFgplksZq1lGg9fmHqSAbxb0ImwKbbECPuVliVBjclKBKLWyX6zmeP5LuHBjlEdsGXLIWBx6ru/ce7icTzJkftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749326854; c=relaxed/simple;
	bh=ZDBXUza5mYKN0G+LEgQAmbkZEIUs7iZW79q0Idl2Apk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8bMCWEHJi3GaHGjHZ91WvkCVuer56u7SvzmFekeRp4gfWBCLYuFycACl2sT//O0uGPr1YJD1nULl74cta1UbZl8z1qZLf/3yY3ZgqCZoBjIJuyZaR1mhzKHwWPWZ98ab1oml2DE6D+RMNMpm6+YjNEK80JMSVdQvz8nhXyOSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajEhG5/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E744C4CEE4;
	Sat,  7 Jun 2025 20:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749326854;
	bh=ZDBXUza5mYKN0G+LEgQAmbkZEIUs7iZW79q0Idl2Apk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajEhG5/8HVrfaad1n+slUIYvzE1FkTzDHcl7TWi7cGlPQnDlA04WdKniPoxYQOMYE
	 NFPprqJK5IW0ur0fiG3+y7GcPTyQuszc7j+8AfGYwPfJ+iPIu+ZTxAE0RYDH2G8FKm
	 BJJAZ7QkJFPdzFyT6dT+BjT8tLQ1siQLlN12X59hwHDp/q3vgGfG3SBu0/JsI+taKk
	 yOMBHSm3WUeEOXPURUAoEtz4nwBTplDDJdpMj/2dInexP90CK4TPNO12gzd+vmDwg1
	 x3S8BGN0sPA3MXigsw27iqzjq/8mJ/jiCprDcU9qVKaUU6hKLM3CwKWLsWamrSVvTN
	 6UALswZ1OpPdQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 12/12] lib/crc: remove ARCH_HAS_* kconfig symbols
Date: Sat,  7 Jun 2025 13:04:54 -0700
Message-ID: <20250607200454.73587-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607200454.73587-1-ebiggers@kernel.org>
References: <20250607200454.73587-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

These symbols are no longer used, so remove them.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/crc/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index de4b2182ae7ff..5858b3acc6630 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -42,13 +42,10 @@ config CRC_T10DIF
 	tristate
 	help
 	  The CRC-T10DIF library functions.  Select this if your module uses
 	  any of the functions from <linux/crc-t10dif.h>.
 
-config ARCH_HAS_CRC_T10DIF
-	bool
-
 config CRC_T10DIF_ARCH
 	bool
 	depends on CRC_T10DIF && CRC_OPTIMIZATIONS
 	default y if ARM && KERNEL_MODE_NEON
 	default y if ARM64 && KERNEL_MODE_NEON
@@ -61,13 +58,10 @@ config CRC32
 	select BITREVERSE
 	help
 	  The CRC32 library functions.  Select this if your module uses any of
 	  the functions from <linux/crc32.h> or <linux/crc32c.h>.
 
-config ARCH_HAS_CRC32
-	bool
-
 config CRC32_ARCH
 	bool
 	depends on CRC32 && CRC_OPTIMIZATIONS
 	default y if ARM && KERNEL_MODE_NEON
 	default y if ARM64
@@ -83,13 +77,10 @@ config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
 	  the functions from <linux/crc64.h>.
 
-config ARCH_HAS_CRC64
-	bool
-
 config CRC64_ARCH
 	bool
 	depends on CRC64 && CRC_OPTIMIZATIONS
 	default y if RISCV && RISCV_ISA_ZBC && 64BIT
 	default y if X86_64
-- 
2.49.0


