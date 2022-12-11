Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28A06492E1
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiLKGUn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiLKGTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:19:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7443313F3E
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:18:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so12357297pjj.2
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+f9WctUGtS0Wn5juoGP/KBKyu4tqsF4zRK1pVCOKmI=;
        b=fP1yZkAYoudxl7GMCJTd+DfrkDqhnmvfpz6pb3pNuvTOJ8Wht7HeVhC6ZdnKJfwPDH
         bLacrFsdCOdLMNwX1yTnOJ/B2Zg4uWeAyyUclC/GfO3JD6UsxszXOloXZTEGJbtWZAIg
         cY34CUY6rBUOSbUS+vnZ8PYwPxP2LdJ0nW9xyyT1PXR0Xo1t5JuO3BtUB/Pi4W9VwAu+
         xhIzCiuaX/1qs+kfqX+C8gTH+tGIf8D+e2Pu5422IXwrcu2ULhTW3Zl4IA6c23/0/MbN
         T7Dv8AjpjhXn+9qKaWAfVcoZ51sGpOcKc4+hdEeJeREkcF76y2fZfZ2/OVcA/NWyqMmf
         /ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+f9WctUGtS0Wn5juoGP/KBKyu4tqsF4zRK1pVCOKmI=;
        b=BCf+HDsf+tBvj0hi1NmETZXMLgIuuPjZtqC78Ut5eNsrWzh6bDolEhh0IKvDydAXg1
         irWz8ywOUTqQQrEOjUXr8/XD1zJdvyvtQrhR8oxwNicoFCe+jAE8uQtt1/Ue2aeq+BO/
         mrNEpRs+sSClxEcD5ZTzXlS8BVWfiXhZh2y+ywS3lDKrNWgKB+CYrYcFJqpPWGkujUJ0
         ZFsoPwex5SSBJre2nKRLBIqpcKZOFHUvL/AHu9DtAY7tEsSy13iXXuoywCWLD1oJ/GuV
         8M3zReJg5e/svuQp7jv13/6hzreF+58mz9PZf/8lWtZGE0mqgAaxPlyA9msUsvBCKBzo
         pAPQ==
X-Gm-Message-State: ANoB5pl6XSgeoJpL5Ovpn4bWJxwZF+sZjbWqJuWTn/egbIu5kltMp/Gy
        xkPm7QffOUJiuM223qOEaCLPgZ3h+p0iHaqR
X-Google-Smtp-Source: AA0mqf4hoFrPdbbFiHEph+/Rj1uV8tkPi5njfd6r42adzJUp4Nc8NrzDYKkM4jVuM8setw+jGEkBBA==
X-Received: by 2002:a17:90b:4b4d:b0:213:393d:e69d with SMTP id mi13-20020a17090b4b4d00b00213393de69dmr11701488pjb.7.1670739477962;
        Sat, 10 Dec 2022 22:17:57 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id t6-20020a655546000000b00478fd9bb6c7sm3107307pgr.75.2022.12.10.22.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:57 -0800 (PST)
Subject: [PATCH v2 24/24] xtensa: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:58 -0800
Message-Id: <20221211061358.28035-25-palmer@rivosinc.com>
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
 arch/xtensa/include/uapi/asm/setup.h | 15 ---------------
 1 file changed, 15 deletions(-)
 delete mode 100644 arch/xtensa/include/uapi/asm/setup.h

diff --git a/arch/xtensa/include/uapi/asm/setup.h b/arch/xtensa/include/uapi/asm/setup.h
deleted file mode 100644
index 6f982394684a..000000000000
--- a/arch/xtensa/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * include/asm-xtensa/setup.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _XTENSA_SETUP_H
-#define _XTENSA_SETUP_H
-
-#endif
-- 
2.38.1

