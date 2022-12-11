Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3190B6492C6
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiLKGSi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiLKGSO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:18:14 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CAAF2D
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a9so8947743pld.7
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPBm/ly9RBblZf7v4uTZvkbr2yaBuLRE19pxufz2+Qo=;
        b=F0XaqPv5r27ASFNBC8Kjl1AIj8tX1o+JwZGTjClrmmsW0vWdoqo9TZ2/HEtXgCGiI1
         TJK69S6h1coA2iAXKBQus6kq1X3jNAY5GuuhbkxUf7UUrQQjtqrVgCbDBbPhv4NubNrh
         w9hC6+KWWIHADOVxYLrO+nR0ObrwTlO/7030E4D8jrlYJkAl2LmNagzYCuW1RjFkbT/v
         lQNBn8qrh4n/0xKtPerhoEXY5q/GNl4QoeTxpU/NTtFg2UXklQgGj8cT9ly7gz9afL/7
         L9SU9NUMSnMG5vPjHM//6So6SbCkx2AMsafAXQw32kAHwS3kYcUtyac26GY5AZ2EXinu
         dCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPBm/ly9RBblZf7v4uTZvkbr2yaBuLRE19pxufz2+Qo=;
        b=FM4In32l69OY4fsrTkbOVYRDJl0QVV8BmOJWoreLIKHMmUZhYnCUrTcUeaFDtPD1Zl
         5Ij1IhKD+rewUUsFo9g7aoXsI3Y6cGr69B1pljKWyrLnJHqMAPG9shra2lLU2pQ9OWue
         eoViMV8AoNVgNrRfe6z+7LCUQwXdiG6mBSN9OL20Snw6oK4xll4Hz6nzw54cajyNgT49
         aK8lu1anhCqUqYGaKKYVk8yVELsKqWJBZBITDQ1TPpALycVyyFiM3BaPqfQUXlHNbFJO
         iOSq7LBeceyc6UA/J2ZipytrzKoQkU62+X6WI3y1hN1r83jLLZkgyD2TUwzqujdp6hYO
         uW4w==
X-Gm-Message-State: ANoB5pmvFPioOSnzNNnsPCoPLVc8Yqli91MqSAm/FZlxLLMhmwVYYw97
        hBQOdG7g/sZbtN679tdzw2PHrA==
X-Google-Smtp-Source: AA0mqf5RiBom9LXJyHsPRAI906ymLoJ4EJNLMvTgsmm9Sv2iWlFqAnP6+oKBM8BWsTlJlF8UTnppsw==
X-Received: by 2002:a17:902:744b:b0:189:9cfd:be72 with SMTP id e11-20020a170902744b00b001899cfdbe72mr11663209plt.8.1670739460650;
        Sat, 10 Dec 2022 22:17:40 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b00186881e1feasm3831421plh.112.2022.12.10.22.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:40 -0800 (PST)
Subject: [PATCH v2 09/24] powerpc: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:43 -0800
Message-Id: <20221211061358.28035-10-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211061358.28035-1-palmer@rivosinc.com>
References: <20221211061358.28035-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
This leaves an empty <uapi/asm/setup.h>, which will soon be cleaned up.
---
 arch/powerpc/include/asm/setup.h      | 2 +-
 arch/powerpc/include/uapi/asm/setup.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index e29e83f8a89c..31786d1db2ef 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_SETUP_H
 #define _ASM_POWERPC_SETUP_H
 
-#include <uapi/asm/setup.h>
+#define COMMAND_LINE_SIZE	2048
 
 #ifndef __ASSEMBLY__
 extern void ppc_printk_progress(char *s, unsigned short hex);
diff --git a/arch/powerpc/include/uapi/asm/setup.h b/arch/powerpc/include/uapi/asm/setup.h
index c54940b09d06..f2ca747aa45b 100644
--- a/arch/powerpc/include/uapi/asm/setup.h
+++ b/arch/powerpc/include/uapi/asm/setup.h
@@ -2,6 +2,4 @@
 #ifndef _UAPI_ASM_POWERPC_SETUP_H
 #define _UAPI_ASM_POWERPC_SETUP_H
 
-#define COMMAND_LINE_SIZE	2048
-
 #endif /* _UAPI_ASM_POWERPC_SETUP_H */
-- 
2.38.1

