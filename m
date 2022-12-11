Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B06492C7
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiLKGSz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiLKGSQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:18:16 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C75A110B
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so2992331plj.3
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH4URxE9NVaJTKcN9EBTlF7LMLUdCbttgGWf5jBmHOA=;
        b=3orbDVcKBSfVDHyPZ2e8HbUMgcHencxMMKa4rIJa/Ef4pi9/g1RPR7X+l3iqJB+ygS
         mzRQEZRtdaINk+4wSrjRB/B/xDklotbWBlsUXg7G2A6B0nP0fLqegAcVktXppEq+GCIM
         UIZC0ip0QVbWMg0REf0hCko0wE/GK6i2qNm4oa03YQwQqKyPkpKSfMe/u8lS/3HDC6Uj
         srB8ceAMm+k0vnesbOKpZ6zrsUTmKA10Dwk351orMLp/spLHYnDuqxpUpweD9BSAG6Wz
         lqB86iNQlj8M1A6QYXNUuYGcfO9foyUHscYfwWYZQYXdKxz1SuHDYR2KCY+np6HA/+Ls
         YYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH4URxE9NVaJTKcN9EBTlF7LMLUdCbttgGWf5jBmHOA=;
        b=LCRD9r6Ye9ep9+3S+lFgXQePBqmxOBQewecjSyEsjor0/xr2so8asd8Avvr6PVdca4
         PvwZHvMhE2bE0d4/q6sxQHekwZEU07HyRmBoZ7HJBC8YStvuS6JaDHsQuOkIfQ69kgEV
         9YnrwUbSEkVadgExwfQkeEPF3hyTtkEcpoK++Nx18tknEitgFAVGpKX+nWq+KSd9xQTK
         XNllcgSGdL7+9l9iIwh/uMlzY4bbmTCOnuDmln3MMkIICzVVvNvbzdhKZB1jrosxTqbQ
         8OtrIyL+xOmUqahx9B8703TtvcLegUZx0+Zr2NY0GU2Y+18NoZXErBdgLJLLW+pyC0iT
         1/qQ==
X-Gm-Message-State: ANoB5pm4hm8VNNb/ULd1JCH88CC33+kDy09LJbv7wqtLVcAHj1pGZTyF
        iiyR3HOEELwPp7eeXmLaZvLbwg==
X-Google-Smtp-Source: AA0mqf4vNeKfYd3BIUU9pS0WakV6tU4/usPHe7L0aB/tJf330rNB1gfmkMvHnFUVTEhJZZPUr1ivJg==
X-Received: by 2002:a17:902:e787:b0:187:1d13:f6d1 with SMTP id cp7-20020a170902e78700b001871d13f6d1mr11968057plb.52.1670739461672;
        Sat, 10 Dec 2022 22:17:41 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902c64300b001869f2120a4sm3821340pls.94.2022.12.10.22.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:41 -0800 (PST)
Subject: [PATCH v2 10/24] sparc: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:44 -0800
Message-Id: <20221211061358.28035-11-palmer@rivosinc.com>
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
 arch/sparc/include/asm/setup.h      | 6 +++++-
 arch/sparc/include/uapi/asm/setup.h | 7 -------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 72205684e51e..d1384ed92547 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -7,7 +7,11 @@
 
 #include <linux/interrupt.h>
 
-#include <uapi/asm/setup.h>
+#if defined(__sparc__) && defined(__arch64__)
+# define COMMAND_LINE_SIZE 2048
+#else
+# define COMMAND_LINE_SIZE 256
+#endif
 
 extern char reboot_command[];
 
diff --git a/arch/sparc/include/uapi/asm/setup.h b/arch/sparc/include/uapi/asm/setup.h
index 3c208a4dd464..c3cf1b0d30b3 100644
--- a/arch/sparc/include/uapi/asm/setup.h
+++ b/arch/sparc/include/uapi/asm/setup.h
@@ -6,11 +6,4 @@
 #ifndef _UAPI_SPARC_SETUP_H
 #define _UAPI_SPARC_SETUP_H
 
-#if defined(__sparc__) && defined(__arch64__)
-# define COMMAND_LINE_SIZE 2048
-#else
-# define COMMAND_LINE_SIZE 256
-#endif
-
-
 #endif /* _UAPI_SPARC_SETUP_H */
-- 
2.38.1

