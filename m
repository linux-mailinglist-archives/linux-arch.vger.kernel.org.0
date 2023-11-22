Return-Path: <linux-arch+bounces-406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD87F5332
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 23:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9FF1F20CAC
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365D1F947;
	Wed, 22 Nov 2023 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2h70Ph0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301C19BDE;
	Wed, 22 Nov 2023 22:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08242C433CA;
	Wed, 22 Nov 2023 22:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700691500;
	bh=xbM7UwIkiSdSjSS3CBuDr633BLrw+vGBgZ7TQFhbsLY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m2h70Ph0oAZb/KX4nmAIJIgAmgEZEAHewd+1aGGUOhZc0ygMNSOWeUiEp1Yg2WYgy
	 vN3jz96ggTWzf1Bzay6hfnIGbpcm6KWoXWDKgTCPKRFBnwnJo53wEurBHbmta/5y+F
	 MtE0afBV1dJSy4Js5ujpLxMDxY+lmy3oDFmunIGryqALbZSCSERfm4NW6NBKDd/cZY
	 Vrb7l60r4giYrU3WZ2eflFchwcLkYBTML9vieiuIqzr3zvsWKZRmMvmalsDisaSBhM
	 S79EOfk01xMSaLSuK1QPOMEwM4smNWNix8Jo/Kdp4fF7Ulk7r0ZUUllRLeCLj4URPW
	 hAYOhMY02eQkA==
From: deller@kernel.org
To: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/4] linux/export: Fix alignment for 64-bit ksymtab entries
Date: Wed, 22 Nov 2023 23:18:11 +0100
Message-ID: <20231122221814.139916-2-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122221814.139916-1-deller@kernel.org>
References: <20231122221814.139916-1-deller@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

An alignment of 4 bytes is wrong for 64-bit platforms which don't define
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS (which then store 64-bit pointers).
Fix their alignment to 8 bytes.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 include/linux/export-internal.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 69501e0ec239..cd253eb51d6c 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -16,10 +16,13 @@
  * and eliminates the need for absolute relocations that require runtime
  * processing on relocatable kernels.
  */
+#define __KSYM_ALIGN		".balign 4"
 #define __KSYM_REF(sym)		".long " #sym "- ."
 #elif defined(CONFIG_64BIT)
+#define __KSYM_ALIGN		".balign 8"
 #define __KSYM_REF(sym)		".quad " #sym
 #else
+#define __KSYM_ALIGN		".balign 4"
 #define __KSYM_REF(sym)		".long " #sym
 #endif
 
@@ -42,7 +45,7 @@
 	    "	.asciz \"" ns "\""					"\n"	\
 	    "	.previous"						"\n"	\
 	    "	.section \"___ksymtab" sec "+" #name "\", \"a\""	"\n"	\
-	    "	.balign	4"						"\n"	\
+		__KSYM_ALIGN						"\n"	\
 	    "__ksymtab_" #name ":"					"\n"	\
 		__KSYM_REF(sym)						"\n"	\
 		__KSYM_REF(__kstrtab_ ##name)				"\n"	\
-- 
2.41.0


