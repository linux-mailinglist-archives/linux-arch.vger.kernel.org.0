Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C36492C2
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiLKGSU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiLKGRx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:17:53 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF931D46
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so9069454pjd.0
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oCv9XoaVNYo+jL/v5xfJUE2DYPkG1RC+xndRSMwe0Q=;
        b=cIZ9SqzDNQCPr3UJZFEXATImDHAB7fMNW1VvAH6jmO6ZOC5l1XnWV4sUmFJJkMw6B6
         AB62H7DErl1yzvCeLYz9rerSJoe6GQtfYGIS4+hXTTx8oLxVHJAixBjRnM7bGUmoWjCy
         sfkJZ9IYuJ3VLh1yTwGqtCiFiHFDryoP7/v106V7FWxOAhnAzxJpfd8EmQ/ycX39Oxq7
         59gQyRAbAvUr2QVQYP8gB8/KPfgVHyleDlRw4fWvxF4PbFDrUOncIepihH2ydRsARKzn
         bpn/ybaOUkQS6GxCrP2vMXr3njG1DbXrXqxw7vv4j51hndzAE9fd6E+4RqS+XJwxvN6u
         Vt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oCv9XoaVNYo+jL/v5xfJUE2DYPkG1RC+xndRSMwe0Q=;
        b=0rQX6YURpC5nuLq6JAd3HejTPJnnlcU/oP2x//AenSIg4VDeJucX7+LJ9FbdnF8XZO
         UDtzNukWJW4K3jaNKmZ0Qe9p3EwJHANNTL62xrsCbykjsUhbmO0+Ep5uOzUjA5UJOg54
         V3wjp8necuwdYCgTlaXGWFzgwTgbqRng6ryAITWgkLUZlEuHkYawD9f1uCof7450zwdK
         ORr4/CU1cdjfae0saMOnHyeuNoAclKnGgK8a8mRAKQQXeocgf9syGGRh7ang2bosdImJ
         5yh5gJQEKWRB28a4UdqaP9c1kRvHBTg9sakY25LnU5Z9lWZ66D12lPR1GtQ93ajWZQ2C
         ZT/A==
X-Gm-Message-State: ANoB5pnhPFfWdDjvqWaUQHwzckZxPNAptebSPIEIPvqbJ/uriYKoF5vt
        Fs5kg00lzld76tLxLSel2w8JCA==
X-Google-Smtp-Source: AA0mqf4HTgVHRO7hmDLAGWd3ZyZYpV/4BdjLiF3anPOviNm3GIvwadjdXE4fX6g02HJ+lgegtp8SxQ==
X-Received: by 2002:a17:90a:2ec2:b0:219:a698:8c5e with SMTP id h2-20020a17090a2ec200b00219a6988c5emr11371478pjs.35.1670739457616;
        Sat, 10 Dec 2022 22:17:37 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090a1b8200b00219b04cf66asm3308333pjc.36.2022.12.10.22.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:37 -0800 (PST)
Subject: [PATCH v2 07/24] mips: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:41 -0800
Message-Id: <20221211061358.28035-8-palmer@rivosinc.com>
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
 arch/mips/include/asm/setup.h      | 3 ++-
 arch/mips/include/uapi/asm/setup.h | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index 8c56b862fd9c..a13b9259b476 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -3,7 +3,8 @@
 #define _MIPS_SETUP_H
 
 #include <linux/types.h>
-#include <uapi/asm/setup.h>
+
+#define COMMAND_LINE_SIZE	4096
 
 extern void prom_putchar(char);
 extern void setup_early_printk(void);
diff --git a/arch/mips/include/uapi/asm/setup.h b/arch/mips/include/uapi/asm/setup.h
index 7d48c433b0c2..157c3c392fb4 100644
--- a/arch/mips/include/uapi/asm/setup.h
+++ b/arch/mips/include/uapi/asm/setup.h
@@ -2,7 +2,4 @@
 #ifndef _UAPI_MIPS_SETUP_H
 #define _UAPI_MIPS_SETUP_H
 
-#define COMMAND_LINE_SIZE	4096
-
-
 #endif /* _UAPI_MIPS_SETUP_H */
-- 
2.38.1

