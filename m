Return-Path: <linux-arch+bounces-11211-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A97A7848C
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 00:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FA13AF61C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 22:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F50621C198;
	Tue,  1 Apr 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcdYx4PW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447321C167;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545783; cv=none; b=eO+Zh/1XL6EzE7g6C25yR06PCKhX+EiQqamOmyeIWuoJKRYoXp312Xd7i8Qn38SVi/THECv1XgoNhqF8UL8ZvpFrJc1l5UYvj+eF0VbUGbxTAzptNp6ikNKujtO8qOWY1U7N/Zmfrpl2ZwJZyxLU4SPGFckYTZXTGvFk3XOHAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545783; c=relaxed/simple;
	bh=tZ4f4oIS03YFlExpJPn1KRNKl8FMes2FWEzmVkaMISE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0d5gu7vQgVNMoibhcIOhiDweaR7TQC1omoaOElI7a5SQl+xzf6FU7DrPRquUzWsrFweHTnXv7WBOR96GPOYjluU+QQjUCFSgGVR+59GBVEFpFQbT71D8/AQQCVOi9Llc0PM7nT8y3E5B9ARpUisMnCtZyHYGpybW7lst0uptps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcdYx4PW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C85C4CEF7;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743545782;
	bh=tZ4f4oIS03YFlExpJPn1KRNKl8FMes2FWEzmVkaMISE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcdYx4PWMzJrs8ZFUAVWQBRi2YL7hfeUsAIa1GgJL63qh5bg1IhsxKWFLfPQtMeU1
	 vN24/OkRox4Obd11Y/rYpO8pm43bov+6jRDLPBj9QtAjIMpg9Xs3/OB4pKFYZr3h0I
	 eCa3zFUy8WPUOoNj5BHzdxeW2n12hhVbHgb8bE/+AEdGZaFgjPOkQ9PL6zGD+xVHau
	 THfQWepSLurUwd2n0pqRSUocJ3weSeuza7WGhuE4RJb0eULybrDdqaQW2lQJFloJCR
	 1+ySSq6Vwn/EyGKtqpGHXkDozhih/4t35i0mPwSS/5UolDhElKP4z5Aa2qtrDl9Ifu
	 mgwtvIaqKVUlA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 6/7] lib/crc: document all the CRC library kconfig options
Date: Tue,  1 Apr 2025 15:15:59 -0700
Message-ID: <20250401221600.24878-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401221600.24878-1-ebiggers@kernel.org>
References: <20250401221600.24878-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Previous commits removed all the original CRC kconfig help text, since
it was oriented towards people configuring the kernel, and the options
are no longer user-selectable.  However, it's still useful for there to
be help text for kernel developers.  Add this.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/Kconfig | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 89470bb24519..4e796eaea2f4 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -138,63 +138,90 @@ config TRACE_MMIO_ACCESS
 
 source "lib/crypto/Kconfig"
 
 config CRC_CCITT
 	tristate
+	help
+	  The CRC-CCITT library functions.  Select this if your module uses any
+	  of the functions from <linux/crc-ccitt.h>.
 
 config CRC16
 	tristate
+	help
+	  The CRC16 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc16.h>.
 
 config CRC_T10DIF
 	tristate
+	help
+	  The CRC-T10DIF library functions.  Select this if your module uses
+	  any of the functions from <linux/crc-t10dif.h>.
 
 config ARCH_HAS_CRC_T10DIF
 	bool
 
 config CRC_T10DIF_ARCH
 	tristate
 	default CRC_T10DIF if ARCH_HAS_CRC_T10DIF && CRC_OPTIMIZATIONS
 
 config CRC_ITU_T
 	tristate
+	help
+	  The CRC-ITU-T library functions.  Select this if your module uses
+	  any of the functions from <linux/crc-itu-t.h>.
 
 config CRC32
 	tristate
 	select BITREVERSE
+	help
+	  The CRC32 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc32.h> or <linux/crc32c.h>.
 
 config ARCH_HAS_CRC32
 	bool
 
 config CRC32_ARCH
 	tristate
 	default CRC32 if ARCH_HAS_CRC32 && CRC_OPTIMIZATIONS
 
 config CRC64
 	tristate
+	help
+	  The CRC64 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc64.h>.
 
 config ARCH_HAS_CRC64
 	bool
 
 config CRC64_ARCH
 	tristate
 	default CRC64 if ARCH_HAS_CRC64 && CRC_OPTIMIZATIONS
 
 config CRC4
 	tristate
+	help
+	  The CRC4 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc4.h>.
 
 config CRC7
 	tristate
+	help
+	  The CRC7 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc7.h>.
 
 config LIBCRC32C
 	tristate
 	select CRC32
 	help
 	  This option just selects CRC32 and is provided for compatibility
 	  purposes until the users are updated to select CRC32 directly.
 
 config CRC8
 	tristate
+	help
+	  The CRC8 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc8.h>.
 
 config CRC_OPTIMIZATIONS
 	bool "Enable optimized CRC implementations" if EXPERT
 	default y
 	help
-- 
2.49.0


