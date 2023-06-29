Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64A774262F
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjF2MUz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 08:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjF2MUC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 08:20:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30951FD8;
        Thu, 29 Jun 2023 05:19:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 066AF2185F;
        Thu, 29 Jun 2023 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688041198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6CE4eotLwXsvlZXrH5NtI0502wDnDOGFZbV7I5gngY=;
        b=MIAi+nRQrg/Ge6eax6lpus2Fe5io5yBV8iHETNEefQw9v5hsTuNhmZJeebMxmsLFAlwBhS
        pO7TNt9tms53aJbJTmVVmamYMonFDjXBqZpUrgsRP2HhwvENuHP3spbLJKhMZmxBxuB6E2
        Ljm6zTP+iYW/JJQTawD+nJfjriRukK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688041198;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6CE4eotLwXsvlZXrH5NtI0502wDnDOGFZbV7I5gngY=;
        b=QtEMlYzXXo8wdFbyP1FH2jzz5MUkEcUCgrio6JnFPAKU6t0ZeGdkmpfMQ0v7TpGMoOM8im
        x7p7/cuMdcwjb5DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C07713905;
        Thu, 29 Jun 2023 12:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cIJ/Fe12nWRlVAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 29 Jun 2023 12:19:57 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 05/12] arch: Remove trailing whitespaces
Date:   Thu, 29 Jun 2023 13:45:44 +0200
Message-ID: <20230629121952.10559-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629121952.10559-1-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/ia64/Kconfig | 4 ++--
 arch/sh/Kconfig   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 21fa63ce5ffc0..e79f15e32a451 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -260,7 +260,7 @@ config PERMIT_BSP_REMOVE
 	default n
 	help
 	Say Y here if your platform SAL will support removal of BSP with HOTPLUG_CPU
-	support. 
+	support.
 
 config FORCE_CPEI_RETARGET
 	bool "Force assumption that CPEI can be re-targeted"
@@ -335,7 +335,7 @@ config IA64_PALINFO
 config IA64_MC_ERR_INJECT
 	tristate "MC error injection support"
 	help
-	  Adds support for MC error injection. If enabled, the kernel 
+	  Adds support for MC error injection. If enabled, the kernel
 	  will provide a sysfs interface for user applications to
 	  call MC error injection PAL procedures to inject various errors.
 	  This is a useful tool for MCA testing.
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9652d367fc377..04b9550cf0070 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -234,7 +234,7 @@ config CPU_SUBTYPE_SH7201
 	select CPU_SH2A
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_SH_MTU2
- 
+
 config CPU_SUBTYPE_SH7203
 	bool "Support SH7203 processor"
 	select CPU_SH2A
@@ -496,7 +496,7 @@ config CPU_SUBTYPE_SH7366
 endchoice
 
 source "arch/sh/mm/Kconfig"
- 
+
 source "arch/sh/Kconfig.cpu"
 
 source "arch/sh/boards/Kconfig"
@@ -647,7 +647,7 @@ config GUSA
 	  This is the default implementation for both UP and non-ll/sc
 	  CPUs, and is used by the libc, amongst others.
 
-	  For additional information, design information can be found 
+	  For additional information, design information can be found
 	  in <http://lc.linux.or.jp/lc2002/papers/niibe0919p.pdf>.
 
 	  This should only be disabled for special cases where alternate
-- 
2.41.0

