Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE71BB396
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 03:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD1BtD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 21:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgD1BtD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Apr 2020 21:49:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2499CC03C1A8;
        Mon, 27 Apr 2020 18:49:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a31so426893pje.1;
        Mon, 27 Apr 2020 18:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VjlmInaD+CunQni2gwfodUVCdw5wBkcVV++SAKGDNm8=;
        b=TMYpTRpZpgzQQDLuoRXsivuHFnJ3XWrpG2C4ZITMWd/5oh0i2Znf5NqQ7fqOkDgDpF
         yN2ifB8qy33yYemkK1J0Obs96WwYHPwRXwCGRReufe6J67kiKKQIiqjYvzPw5YyPIgg7
         j9RmdRt39k3xuue47Pm2I8drGtaFUblkQF4ukd9PS+36BU3hZxxKBIxt1hlFpm3Cf8xA
         38QpgdLaGab8FnQVjsUc9I7ShA731CpqWUnzD/9W7FivUdiKRV6pA96Hl5DRWOm/SffF
         EeK4hIUOFv2IOIUxZdn1RyJjYTFEn/aK7i95uwKD2BNMweQKRf1CGLBjavDulW9HzbWu
         gQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VjlmInaD+CunQni2gwfodUVCdw5wBkcVV++SAKGDNm8=;
        b=lZQJHBOsPnQdB9wdMwxQplzgY0f/wXBg0g/2z8wAtWxG4DtDWUEeO5FaedEAqMbKBU
         7UaLQxZ8O5B9c/gxe/4fyQPsbxc8zthsrKe4t3cgI0eeAV6WL4N4vkBU2spjz5SmT1pw
         ddV8eP9WGt5ZQ1JeWYzbuRQSD0hrzvhn9FfjBSKc3HXlX/yR7r6r6YJeH7WJbcNG+wCo
         XOT7ijlM+N//lWSIQoNF9Oyta+hVHEAjog2+N/aLsH3HG4TeoeXZA2Opzej8YQSi1s3h
         aVwZa5Tld8MAnObJXUSc5Y/pWk41ZI6FBq76oPzxZjoVsb7qCa3k9/MWzW2WTtqlDl2f
         tgwA==
X-Gm-Message-State: AGi0PuaL1xiS2IEig/kDx9mkJ25a/HED8fz/BCFlyDzwDM1FdR0cvyUY
        flrhHzSFL+sAFFweOan2R5E=
X-Google-Smtp-Source: APiQypKW1jBhkcPIj1dIcDXG+vS4AuDRosNuBrsHzNoEKEhSnJE2syPk/CzYimYRQy8CXCNfjwstvg==
X-Received: by 2002:a17:90a:690b:: with SMTP id r11mr1983059pjj.119.1588038542547;
        Mon, 27 Apr 2020 18:49:02 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (c-69-181-90-243.hsd1.ca.comcast.net. [69.181.90.243])
        by smtp.gmail.com with ESMTPSA id 4sm14173285pff.18.2020.04.27.18.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 18:49:01 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (localhost [IPv6:::1])
        by gnu-cfl-2.localdomain (Postfix) with ESMTP id 9054BC02BB;
        Mon, 27 Apr 2020 18:49:00 -0700 (PDT)
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
Subject: [PATCH 1/2] powerpc: Discard .rela* sections if CONFIG_RELOCATABLE is undefined
Date:   Mon, 27 Apr 2020 18:48:59 -0700
Message-Id: <20200428014900.407098-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

arch/powerpc/kernel/vmlinux.lds.S has

        DISCARDS
        /DISCARD/ : {
                *(*.EMB.apuinfo)
                *(.glink .iplt .plt .rela* .comment)
                *(.gnu.version*)
                *(.gnu.attributes)
                *(.eh_frame)
        }

Since .rela* sections are needed when CONFIG_RELOCATABLE is defined,
change to discard .rela* sections if CONFIG_RELOCATABLE is undefined.

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

