Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA15E6492D1
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiLKGTs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiLKGS5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:18:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AC612AB6
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so9069666pjd.0
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evugQiRispLf16VkYPAqnei/2K7knVLqFrhAqq/IOXw=;
        b=EMGipoYTR7UYcizis4dgMknwj9E2ULscbLpm/NnpTiMvALK649R4gbUoDIUuBFJ2zh
         NVpLXGeweTFuOXteArGGMmDbGWDYnK8C/NgByEhD0k76s/t+S4kMUUbPNDKBsCMV0q80
         16aw4iTWZZdh5s9dHHmARyF9tR+JPmE2tiYQnKoivVvoHrfKJLpab9UNrHTBLluQqehX
         bAd1+U9Aa9NswMef1sM0GrUi8yB1mFu9lAtbWp48Gm1Sr9QVT2+kbBoD12hWYLZesQcS
         gvPFMChjihlbAd/ErdcuJ0kSqTbyt/wR3BmD/0IHyn/NITuOKdCPzFbeJqFMKCUzmjJX
         tB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evugQiRispLf16VkYPAqnei/2K7knVLqFrhAqq/IOXw=;
        b=yE5gUGb8SZcwGWL7PezS4Mo93J5tZRAkcKebv6V+p9uxHiZqY/cU0pvjNP06Zeu4UY
         /NGnHOKLcBGirgH767CcUL/Ghp13ZUXomPxU8GIyvlpaZD1T5PEY/5pHfPnak/wvzJ8+
         XkwEAlLrZ7cTf+dZ6qx+j4JFPgvYaNtIWkl4HxwAlWDuQmAIkhLlMiybvZtu4BHVvZ2O
         kVMaVXfVFguEM79WxIS/9DZYQpzO8WJSJqMAVkmZuUXeK5aMKoOL3IaAUTKFzrtr+ciJ
         R8BHxg3pGWrZCZy8tcYQLiHduFZmum9FQexkLEgJ0+sLTEWfbv8HrA0fXYocCfwYyovO
         hpyA==
X-Gm-Message-State: ANoB5pmQr6HPFTALk644nagI87T4Dm6FY4RpEp+eooR7OPUGTQKup5Iy
        Ck1Lmt8pYTqSz+hHNWygoT94gg==
X-Google-Smtp-Source: AA0mqf7BU4VduoIUcW6NS1AHsOeBKupR6Ivt8o0C8HQAosZ81xC7q9zLf5iRwrOiaKuLdfQfthjFEA==
X-Received: by 2002:a05:6a21:c08a:b0:a7:ce31:95f7 with SMTP id bn10-20020a056a21c08a00b000a7ce3195f7mr14161392pzc.27.1670739468891;
        Sat, 10 Dec 2022 22:17:48 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id bt28-20020a63291c000000b0043b565cb57csm3088631pgb.73.2022.12.10.22.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:48 -0800 (PST)
Subject: [PATCH v2 16/24] m68k: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:50 -0800
Message-Id: <20221211061358.28035-17-palmer@rivosinc.com>
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

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/m68k/include/uapi/asm/setup.h | 15 ---------------
 1 file changed, 15 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/setup.h

diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/asm/setup.h
deleted file mode 100644
index 005593acc7d8..000000000000
--- a/arch/m68k/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
-** asm/setup.h -- Definition of the Linux/m68k setup information
-**
-** Copyright 1992 by Greg Harp
-**
-** This file is subject to the terms and conditions of the GNU General Public
-** License.  See the file COPYING in the main directory of this archive
-** for more details.
-*/
-
-#ifndef _UAPI_M68K_SETUP_H
-#define _UAPI_M68K_SETUP_H
-
-#endif /* _UAPI_M68K_SETUP_H */
-- 
2.38.1

