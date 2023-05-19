Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA40709CA8
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjESQqX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 12:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjESQqX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 12:46:23 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1AEC;
        Fri, 19 May 2023 09:46:19 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id B29AE7C0;
        Fri, 19 May 2023 16:46:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B29AE7C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684514779; bh=gXx7pOnD9OUD8RWsF9eaOSYpxOimmKIKwKPnLChvwKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYrfhw3Jh1ZyIV8Baptm6SPUqx8spt74/KECLo0ykZBDhdebw7cY6t7jgb2t1bHie
         D5Nq+yO813T7AOXPWVd5gmPAmlSW23Qji9nO1sehMkhF0gQwPdIgLNKXMIA67Lj8Fv
         vWaFPIUa1chWhEl9HTk8QAIO/vfULcgxaKP/SDUNy5MNvNKR6ogSQ1B02YoLlrsu8R
         S7WnFuPYm2fLQqrSTZltxcl5wM/Ah7Mwvxsh53w+JbTVejPXQ2HdgjEAdqD4uQoqIc
         D+dmIsqcZ22qMN5547RxfCupzUGaTi74cLmUYlg5HYemoBIliFr08jHdC7WPsmJpxn
         v918hRhf08bKw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 2/7] arm: update in-source documentation references
Date:   Fri, 19 May 2023 10:46:02 -0600
Message-Id: <20230519164607.38845-3-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519164607.38845-1-corbet@lwn.net>
References: <20230519164607.38845-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Arm documentation has moved to Documentation/arch/arm; update
references within arch/arm to match.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 arch/arm/Kconfig                  | 2 +-
 arch/arm/common/mcpm_entry.c      | 2 +-
 arch/arm/common/mcpm_head.S       | 2 +-
 arch/arm/common/vlock.S           | 2 +-
 arch/arm/include/asm/setup.h      | 2 +-
 arch/arm/include/uapi/asm/setup.h | 2 +-
 arch/arm/kernel/entry-armv.S      | 2 +-
 arch/arm/mach-exynos/common.h     | 2 +-
 arch/arm/mach-sti/Kconfig         | 2 +-
 arch/arm/mm/Kconfig               | 4 ++--
 arch/arm/tools/mach-types         | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b218f665..b6ec0b655739 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1780,7 +1780,7 @@ config VFP
 	  Say Y to include VFP support code in the kernel. This is needed
 	  if your hardware includes a VFP unit.
 
-	  Please see <file:Documentation/arm/vfp/release-notes.rst> for
+	  Please see <file:Documentation/arch/arm/vfp/release-notes.rst> for
 	  release notes and additional status information.
 
 	  Say N if your target does not have VFP hardware.
diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 8a9aeeb504dd..e013ff1168d3 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -21,7 +21,7 @@
 /*
  * The public API for this code is documented in arch/arm/include/asm/mcpm.h.
  * For a comprehensive description of the main algorithm used here, please
- * see Documentation/arm/cluster-pm-race-avoidance.rst.
+ * see Documentation/arch/arm/cluster-pm-race-avoidance.rst.
  */
 
 struct sync_struct mcpm_sync;
diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index 299495c43dfd..f590e803ca11 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -5,7 +5,7 @@
  * Created by:  Nicolas Pitre, March 2012
  * Copyright:   (C) 2012-2013  Linaro Limited
  *
- * Refer to Documentation/arm/cluster-pm-race-avoidance.rst
+ * Refer to Documentation/arch/arm/cluster-pm-race-avoidance.rst
  * for details of the synchronisation algorithms used here.
  */
 
diff --git a/arch/arm/common/vlock.S b/arch/arm/common/vlock.S
index 1fa09c4697ed..c5eaed5a76f0 100644
--- a/arch/arm/common/vlock.S
+++ b/arch/arm/common/vlock.S
@@ -6,7 +6,7 @@
  * Copyright:	(C) 2012-2013  Linaro Limited
  *
  * This algorithm is described in more detail in
- * Documentation/arm/vlocks.rst.
+ * Documentation/arch/arm/vlocks.rst.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index ba0872a8dcda..31672ce21eaa 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -5,7 +5,7 @@
  *  Copyright (C) 1997-1999 Russell King
  *
  *  Structure passed to kernel to tell it about the
- *  hardware it's running on.  See Documentation/arm/setup.rst
+ *  hardware it's running on.  See Documentation/arch/arm/setup.rst
  *  for more info.
  */
 #ifndef __ASMARM_SETUP_H
diff --git a/arch/arm/include/uapi/asm/setup.h b/arch/arm/include/uapi/asm/setup.h
index 25ceda63b284..8e50e034fec7 100644
--- a/arch/arm/include/uapi/asm/setup.h
+++ b/arch/arm/include/uapi/asm/setup.h
@@ -9,7 +9,7 @@
  * published by the Free Software Foundation.
  *
  *  Structure passed to kernel to tell it about the
- *  hardware it's running on.  See Documentation/arm/setup.rst
+ *  hardware it's running on.  See Documentation/arch/arm/setup.rst
  *  for more info.
  */
 #ifndef _UAPI__ASMARM_SETUP_H
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c39303e5c234..291dc48d6bed 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -875,7 +875,7 @@ ENDPROC(__bad_stack)
  * existing ones.  This mechanism should be used only for things that are
  * really small and justified, and not be abused freely.
  *
- * See Documentation/arm/kernel_user_helpers.rst for formal definitions.
+ * See Documentation/arch/arm/kernel_user_helpers.rst for formal definitions.
  */
  THUMB(	.arm	)
 
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 29eb075b24a4..b5287ff1c542 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -106,7 +106,7 @@ void exynos_firmware_init(void);
 #define C2_STATE	(1 << 3)
 /*
  * Magic values for bootloader indicating chosen low power mode.
- * See also Documentation/arm/samsung/bootloader-interface.rst
+ * See also Documentation/arch/arm/samsung/bootloader-interface.rst
  */
 #define EXYNOS_SLEEP_MAGIC	0x00000bad
 #define EXYNOS_AFTR_MAGIC	0xfcba0d10
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index b2d45cf10a3c..b3842c971d31 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -21,7 +21,7 @@ menuconfig ARCH_STI
 	help
 	  Include support for STMicroelectronics' STiH415/416, STiH407/10 and
 	  STiH418 family SoCs using the Device Tree for discovery.  More
-	  information can be found in Documentation/arm/sti/ and
+	  information can be found in Documentation/arch/arm/sti/ and
 	  Documentation/devicetree.
 
 if ARCH_STI
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index be183ed1232d..c164cde50243 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -712,7 +712,7 @@ config ARM_VIRT_EXT
 	  assistance.
 
 	  A compliant bootloader is required in order to make maximum
-	  use of this feature.  Refer to Documentation/arm/booting.rst for
+	  use of this feature.  Refer to Documentation/arch/arm/booting.rst for
 	  details.
 
 config SWP_EMULATE
@@ -904,7 +904,7 @@ config KUSER_HELPERS
 	  the CPU type fitted to the system.  This permits binaries to be
 	  run on ARMv4 through to ARMv7 without modification.
 
-	  See Documentation/arm/kernel_user_helpers.rst for details.
+	  See Documentation/arch/arm/kernel_user_helpers.rst for details.
 
 	  However, the fixed address nature of these helpers can be used
 	  by ROP (return orientated programming) authors when creating
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 9e74c7ff6b04..97e2bfa01f4b 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -7,7 +7,7 @@
 #   http://www.arm.linux.org.uk/developer/machines/download.php
 #
 # Please do not send patches to this file; it is automatically generated!
-# To add an entry into this database, please see Documentation/arm/arm.rst,
+# To add an entry into this database, please see Documentation/arch/arm/arm.rst,
 # or visit:
 #
 #   http://www.arm.linux.org.uk/developer/machines/?action=new
-- 
2.40.1

