Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB93C7778
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jul 2021 21:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhGMTuP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jul 2021 15:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhGMTuO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jul 2021 15:50:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD596C06178A;
        Tue, 13 Jul 2021 12:47:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hd33so14928792ejc.9;
        Tue, 13 Jul 2021 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DTzlHpqU1xWPgcCMr1ESW3zCE8WiwwCSMY6IY5+7EKk=;
        b=qyrvvIt8yq5OmMoKnzW1brn8GLZClHONEZn4/BoFRs7+kD9dUVskXHSi1KK9kqJRD8
         DmZFjcYmSaL4Dn+ysObXfMy3fADiql4GIVUbU1hEolaaK0jGJLbdqejI3COLNI78bfz/
         aOF3D1WCCyAIHZNfCEGMcBaXpDSiUxlZlGjIAT3+0Iv3WFFLXM1NcL7lksj1kQ4SyVWj
         vt8xUThuSrU8wfCVZvHEGBXyWGKgSyIh3RyIaDi8tntiXy5v3LXYRKz15CciS/980PaZ
         CqvOBb15QgEOv5U2qmkFqPJjLwYVlUiy0wR5HbZI4imAW7paumy7cmLMeZ3fZpnQCPmf
         6yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DTzlHpqU1xWPgcCMr1ESW3zCE8WiwwCSMY6IY5+7EKk=;
        b=bOhndb/748rhLgD7nuc765C14fZo7BcDC2vYxHj1rQ2dmD1QZmhQ+UoTgav97ve8YX
         g8iEzYzgjjwV0sc4lhFz+GYWJE1RGHXQMXAuaZrLkDnQvHh5v8RsSPNTIMsjq4c8EVaJ
         Sabg9imIdJ8cNoY3C9jjZy+8n9YA9bNvuLtD0YHbWmpquu/cuzW8punv0kMV2gzk83WU
         08P5Sgy6R4itepT+quYw/sPibyRNA9R3krwNI/B1lja7dhVm9RpNG2syiThFZQOBH8JX
         ntM3vXw53lqPLJaSw13oqyA8qsRetOOdedy7bK2UguzxNWBcjfwnIta2dMo/GMFY9sw/
         KtPA==
X-Gm-Message-State: AOAM532Uc6zEG4VS286ggq8/soJbyuHeflluqqO9KJy0fO0ZB2+8LgRl
        6Cx1W4AFgM1QqiloMA0nZ+vSQh0twg==
X-Google-Smtp-Source: ABdhPJwqmFURteOsUkKq9Kq02nY9tJa97rjAS6oUskn73cnlUEp8s9ENvSmYqpkfJ4qmilY9C4pwfw==
X-Received: by 2002:a17:907:97c5:: with SMTP id js5mr7640957ejc.321.1626205640798;
        Tue, 13 Jul 2021 12:47:20 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.110])
        by smtp.gmail.com with ESMTPSA id q11sm8390992eds.60.2021.07.13.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:47:20 -0700 (PDT)
Date:   Tue, 13 Jul 2021 22:47:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de
Subject: [PATCH] Decouple build from userspace headers
Message-ID: <YO3txvw87MjKfdpq@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In theory, userspace headers can be under incompatible license.

Linux by virtue of being OS kernel is fully independent piece of code
and should not require anything from userspace.

For this:

* ship minimal <stdarg.h>
	2 types, 4 macros

* delete "-isystem"
	This is what enables leakage.

* fixup compilation where necessary.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Makefile                                                               |    2 +-
 arch/um/include/shared/irq_user.h                                      |    1 -
 arch/um/os-Linux/signal.c                                              |    2 +-
 crypto/aegis128-neon-inner.c                                           |    2 --
 drivers/net/wwan/iosm/iosm_ipc_imem.h                                  |    1 -
 drivers/pinctrl/aspeed/pinmux-aspeed.h                                 |    1 -
 drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h |    2 --
 include/stdarg.h                                                       |    9 +++++++++
 sound/aoa/codecs/onyx.h                                                |    1 -
 sound/aoa/codecs/tas.c                                                 |    1 -
 10 files changed, 11 insertions(+), 11 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -978,7 +978,7 @@ KBUILD_CFLAGS += -falign-functions=64
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
-NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
+NOSTDINC_FLAGS += -nostdinc
 
 # warn about C99 declaration after statement
 KBUILD_CFLAGS += -Wdeclaration-after-statement
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -7,7 +7,6 @@
 #define __IRQ_USER_H__
 
 #include <sysdep/ptrace.h>
-#include <stdbool.h>
 
 enum um_irq_type {
 	IRQ_READ,
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -67,7 +67,7 @@ int signals_enabled;
 #ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
 static int signals_blocked;
 #else
-#define signals_blocked false
+#define signals_blocked 0
 #endif
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
--- a/crypto/aegis128-neon-inner.c
+++ b/crypto/aegis128-neon-inner.c
@@ -15,8 +15,6 @@
 
 #define AEGIS_BLOCK_SIZE	16
 
-#include <stddef.h>
-
 extern int aegis128_have_aes_insn;
 
 void *memcpy(void *dest, const void *src, size_t n);
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.h
@@ -7,7 +7,6 @@
 #define IOSM_IPC_IMEM_H
 
 #include <linux/skbuff.h>
-#include <stdbool.h>
 
 #include "iosm_ipc_mmio.h"
 #include "iosm_ipc_pcie.h"
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -5,7 +5,6 @@
 #define ASPEED_PINMUX_H
 
 #include <linux/regmap.h>
-#include <stdbool.h>
 
 /*
  * The ASPEED SoCs provide typically more than 200 pins for GPIO and other
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h
@@ -16,8 +16,6 @@
 #ifndef __ISP_LOCAL_H_INCLUDED__
 #define __ISP_LOCAL_H_INCLUDED__
 
-#include <stdbool.h>
-
 #include "isp_global.h"
 
 #include <isp2400_support.h>
new file mode 100644
--- /dev/null
+++ b/include/stdarg.h
@@ -0,0 +1,9 @@
+#ifndef _LINUX_STDARG_H
+#define _LINUX_STDARG_H
+typedef __builtin_va_list __gnuc_va_list;
+typedef __builtin_va_list va_list;
+#define va_start(v, l)	__builtin_va_start(v, l)
+#define va_end(v)	__builtin_va_end(v)
+#define va_arg(v, T)	__builtin_va_arg(v, T)
+#define va_copy(d, s)	__builtin_va_copy(d, s)
+#endif
--- a/sound/aoa/codecs/onyx.h
+++ b/sound/aoa/codecs/onyx.h
@@ -6,7 +6,6 @@
  */
 #ifndef __SND_AOA_CODEC_ONYX_H
 #define __SND_AOA_CODEC_ONYX_H
-#include <stddef.h>
 #include <linux/i2c.h>
 #include <asm/pmac_low_i2c.h>
 #include <asm/prom.h>
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -58,7 +58,6 @@
  *    and up to the hardware designer to not wire
  *    them up in some weird unusable way.
  */
-#include <stddef.h>
 #include <linux/i2c.h>
 #include <asm/pmac_low_i2c.h>
 #include <asm/prom.h>
