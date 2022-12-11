Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE48D6492CF
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiLKGTd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLKGSd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:18:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA34F01D
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:46 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id t2so5966397ply.2
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By5u19nRkP9OUANLnTon8LO9NfnZBcXY11wOiiNFUOY=;
        b=A68p7QsN/MS/dmBPE3jOWZCsBU0BosXHS9cYh+Dq+LWynuQ8Tst6WDc9o5liQmPW7a
         xeYppj/Df8cjh4pwhYI6w2IARSKukSejtgVBLrUQCz43rX41PKGxN9Fsvr20r5y0pbUu
         SuUUctJsy/T+Vviu0tpqDkgQFU3d8H6+cl9MhrnAAlBCcjN5rStsN6in1KRC8MOhimU1
         s4IGuxruqgpVrtC6y4Szqde31lQbDQ6RW5l2TIIGF+NEGI4xEtM8Wa3SgZfigyb9UieE
         gu0tgEUG/qAAGqdeGjuyUzwgakfoxi9dwuD7V9G1S+oQ1k+6aGubltlZhwXCJupVs9qr
         s9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By5u19nRkP9OUANLnTon8LO9NfnZBcXY11wOiiNFUOY=;
        b=qTP8P28whHRgDO8eTUfq75ru/eR9DFM3oMINKr35JhG30jkaa8AK3p5vk5lSWozwoC
         Wc4hPhGBmcDhQQPjLaDysBYq4Cn42gOe+6s6RqduvMmiNRSigx2He0RSmZjwHsvE7+CV
         qIWzWbWgUWzQFJOF5Fl3D3fzh9CNDHH+rb43S7PGy8G0giYJG02IQwPqyzza5vhwOs/H
         HJ7K1D7nvy5/GrdHzZarI/gOyP00YZpJttOc9xr/dhKs2o02yVgsphzVQcY4Svk7qUs7
         7I49qVvoBUcEOfILC5NvOLNHW3TtTqusMwbBw/MueXTqukNw7sS8CFTLP17l41uULBX2
         ackg==
X-Gm-Message-State: ANoB5pkxcV0F9GDLD6BfNmaBdThZBglpTIx98n6Msu8rZPaBzuinchYP
        Kitj4Xw1EIibSIhTnbGWAn9Vqw==
X-Google-Smtp-Source: AA0mqf44Qd+FBcu3AgtjujSHfdeNkPnOffyviLoO7B2/UkGnE9DJOTI8UiQNRY87HOlQKR13mVe3mA==
X-Received: by 2002:a05:6a20:428e:b0:a2:ebb9:e2e5 with SMTP id o14-20020a056a20428e00b000a2ebb9e2e5mr18883561pzj.50.1670739466388;
        Sat, 10 Dec 2022 22:17:46 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b00186985198a4sm3803186pln.169.2022.12.10.22.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:46 -0800 (PST)
Subject: [PATCH v2 14/24] arc: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:48 -0800
Message-Id: <20221211061358.28035-15-palmer@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/arc/include/asm/setup.h      | 1 -
 arch/arc/include/uapi/asm/setup.h | 6 ------
 2 files changed, 7 deletions(-)
 delete mode 100644 arch/arc/include/uapi/asm/setup.h

diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
index 028a8cf76206..fe45ff4681bc 100644
--- a/arch/arc/include/asm/setup.h
+++ b/arch/arc/include/asm/setup.h
@@ -7,7 +7,6 @@
 
 
 #include <linux/types.h>
-#include <uapi/asm/setup.h>
 
 #define COMMAND_LINE_SIZE 256
 
diff --git a/arch/arc/include/uapi/asm/setup.h b/arch/arc/include/uapi/asm/setup.h
deleted file mode 100644
index a6d4e44938be..000000000000
--- a/arch/arc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/*
- * setup.h is part of userspace header ABI so UAPI scripts have to generate it
- * even if there's nothing to export - causing empty <uapi/asm/setup.h>
- * However to prevent "patch" from discarding it we add this placeholder
- * comment
- */
-- 
2.38.1

