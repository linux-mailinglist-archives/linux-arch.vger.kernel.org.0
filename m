Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B0D3168D3
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBJOM7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 09:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhBJOMd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2021 09:12:33 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBFDC061786
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 06:11:46 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id TSBk240074C55Sk01SBkC7; Wed, 10 Feb 2021 15:11:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDX-005Hsy-Lj; Wed, 10 Feb 2021 15:11:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDW-006Jqh-RT; Wed, 10 Feb 2021 15:11:42 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] ARM: unified: Remove check for gcc < 4
Date:   Wed, 10 Feb 2021 15:11:38 +0100
Message-Id: <20210210141140.1506212-3-geert+renesas@glider.be>
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
Hence this condition is never true, and the check can thus be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/include/asm/unified.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index 1e2c3eb043535f7b..ce9689118dbb945b 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -24,10 +24,6 @@ __asm__(".syntax unified");
 
 #ifdef CONFIG_THUMB2_KERNEL
 
-#if __GNUC__ < 4
-#error Thumb-2 kernel requires gcc >= 4
-#endif
-
 /* The CPSR bit describing the instruction set (Thumb) */
 #define PSR_ISETSTATE	PSR_T_BIT
 
-- 
2.25.1

