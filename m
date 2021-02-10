Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ECF3168D1
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 15:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhBJOMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 09:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhBJOMc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2021 09:12:32 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C0AC06174A
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 06:11:45 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id TSBj2400Y4C55Sk01SBjrX; Wed, 10 Feb 2021 15:11:43 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDX-005Hsx-5S; Wed, 10 Feb 2021 15:11:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDW-006Jqe-Qh; Wed, 10 Feb 2021 15:11:42 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] ARM: div64: Remove always-true __div64_const32_is_OK() duplicate
Date:   Wed, 10 Feb 2021 15:11:37 +0100
Message-Id: <20210210141140.1506212-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210141140.1506212-1-geert+renesas@glider.be>
References: <20210210141140.1506212-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since commit cafa0010cd51fb71 ("Raise the minimum required gcc version
to 4.6"), the kernel can no longer be compiled using gcc-3.
Hence __div64_const32_is_OK() is always true.

Moreover, __div64_const32_is_OK() is defined in the same way in
include/asm-generic/div64.h, so the ARM-specific definition can be
removed regardless.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/include/asm/div64.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 595e538f5bfb5055..4b69cf850451b076 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -52,17 +52,6 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
 
 #else
 
-/*
- * gcc versions earlier than 4.0 are simply too problematic for the
- * __div64_const32() code in asm-generic/div64.h. First there is
- * gcc PR 15089 that tend to trig on more complex constructs, spurious
- * .global __udivsi3 are inserted even if none of those symbols are
- * referenced in the generated code, and those gcc versions are not able
- * to do constant propagation on long long values anyway.
- */
-
-#define __div64_const32_is_OK (__GNUC__ >= 4)
-
 static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
 {
 	unsigned long long res;
-- 
2.25.1

