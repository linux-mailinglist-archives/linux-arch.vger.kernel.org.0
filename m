Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F21BBF18
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 15:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgD1NVJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 09:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgD1NVI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 09:21:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E8C03C1A9;
        Tue, 28 Apr 2020 06:21:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so10669026pfx.6;
        Tue, 28 Apr 2020 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSEugyT8Lo+1ZhrlvgQjxW4x141gV7dlNRE0LVKLu4g=;
        b=TK6t9DDhO7O5M8Wkv5d/JVPmoc86hlNKkMZflDwy1HMUs7qkqJloY5awfna3htZE9W
         FrNXue6aRyf9fIgeJoKbEztwoj9XjpjTcndnwtk3dYDNblnGIbiT9BdlqVzM233YH7TU
         wIVXo/gwIiYgst4VoWyQRblZ6DQRM2bj3JNiHI1zdzbJK+ykaYA4HSV3Ms5EM1bmwewp
         WCckB7DM+LYKDgeZPpNxTkIK8TAm1aqhbC9K52YMpua9jHspcbdtv8XIYhtU7tMWSqfV
         RBWf0cdfZEXQyQxXL8bJFRHI3BuUEz27vcAQI03rhEeUWZYlpdMaLqeXJ9TgblUUa8iH
         FPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSEugyT8Lo+1ZhrlvgQjxW4x141gV7dlNRE0LVKLu4g=;
        b=WCHuKWHjWdw9awEimywN2dYDvU7mNQ45IHGamq7CZRGNFHTc/JNvsrt38T/2kJPWsS
         zaTtFN3QF2nYwXX5VnISl51QQVGNFfL8rWiiUjxHFpiv6X7ck+LIKJgh+HSBD7m7rYWH
         bvGQeD9wsCRW2Ofkl894sIuVpjaOXfj8O7E0dGbCYLmkvi7euA82t6VoRDK9/SSHO0F1
         ZdSu57fxe0m5qVLpLj7nHnLxmg+Yi6zU/xQKhyzE1hrIRmEg++rZuuBbvd/rQJ2ZRtdz
         rqsjeAv41a9RI5hy/4iuOTURP1kyoF9g/rGu966Og0YCMUjh5zz0+NKY0we5i5uK/Dpd
         xZYg==
X-Gm-Message-State: AGi0PuauWGENYUWauiv3CPYb4rsAVbegpUyZgcOs8QepTidbzmisqs4E
        fM5NL8cUVuzuYGiPAF/jTXY=
X-Google-Smtp-Source: APiQypL+ws/Dz3L/EhqNygye/RUl8b5l213WFumblEyR9F4+FV4dhOzjSRUH8xgJH1SS2n/3TsqjVA==
X-Received: by 2002:a63:48a:: with SMTP id 132mr18429238pge.380.1588080067621;
        Tue, 28 Apr 2020 06:21:07 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (c-69-181-90-243.hsd1.ca.comcast.net. [69.181.90.243])
        by smtp.gmail.com with ESMTPSA id j5sm3587925pgi.5.2020.04.28.06.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 06:21:07 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (localhost [IPv6:::1])
        by gnu-cfl-2.localdomain (Postfix) with ESMTP id 43EA4C0326;
        Tue, 28 Apr 2020 06:21:06 -0700 (PDT)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Keep .rela* sections when CONFIG_RELOCATABLE is defined
Date:   Tue, 28 Apr 2020 06:21:04 -0700
Message-Id: <20200428132105.170886-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

arch/powerpc/kernel/vmlinux.lds.S has

 #ifdef CONFIG_RELOCATABLE
 ...
        .rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
        {
                __rela_dyn_start = .;
                *(.rela*)
        }
 #endif
 ...
        DISCARDS
        /DISCARD/ : {
                *(*.EMB.apuinfo)
                *(.glink .iplt .plt .rela* .comment)
                *(.gnu.version*)
                *(.gnu.attributes)
                *(.eh_frame)
        }

Since .rela* sections are needed when CONFIG_RELOCATABLE is defined,
don't discard .rela* sections if CONFIG_RELOCATABLE is defined.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
---
 arch/powerpc/kernel/vmlinux.lds.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 31a0f201fb6f..4ba07734a210 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -366,9 +366,12 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		*(*.EMB.apuinfo)
-		*(.glink .iplt .plt .rela* .comment)
+		*(.glink .iplt .plt .comment)
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+#ifndef CONFIG_RELOCATABLE
+		*(.rela*)
+#endif
 	}
 }
-- 
2.25.4

