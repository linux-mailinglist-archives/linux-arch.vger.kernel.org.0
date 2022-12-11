Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E816492B8
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiLKGRj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLKGRe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:17:34 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6313CC6
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:33 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 17so1515894pll.0
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR//y9PZ1dntNQ5jP8JSgcJW+jEOWFZxxe2Fy8nYAA0=;
        b=snrBPyBlGY/kCleEd1Ck1RD95PHIuiY8cFm0R72xEkCr4+6olsksPCtxrNKE5+tFyV
         2pqLh1r7KDQPWsRj8+YGYd9AepBWR30XnW093nHxZUyMSwxTkSE0faJCisRX91+XyZb8
         kzU3ThS1J2yuXPH0iKFzMO6quAY+Tr+aF0ERMjBgCH377d1Rs119yPy+8nBJXR/DitcE
         y4vgPsbJKIzHGRvrBR+beiRZiFrMgB4unlaVn/RM8NVZ4rNsEiqvAbWClZ8vAkMQEc0q
         KTRJ1sKSsa5T2gVhmstQT7WiBI1eKW8vhRB1dRpVJ2dfJUpeGzdqaBF3zZ4lubB1ycOg
         3BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR//y9PZ1dntNQ5jP8JSgcJW+jEOWFZxxe2Fy8nYAA0=;
        b=ZQnsR61WDub2khPFXpf9a8/y4zNs5SajKKI+dR5J8fI3S9lG4MJdWP4Jk9viEC5Rdj
         xDxa0xZUSC+rSCjksxpASvoWX5n59/QBItwGjfoKXMyNW1wsSkcSDETiAXUqVIPnHBwe
         Nl+R+vO2BxeHqdKagIY7dQ6O1fCAicNubnokT/LrsX3VIsqv45D5wW1ch8knLH+tdrSK
         w8p+rkxKjn/hjeyTMB/qGZz2Sypo50RdLYEAWd7LNelzkLjzOwhdl9LSFmsacYxAaZaP
         4aqadJaRUsR9MkLEH1cD95LDOqanrZCHBT3UGQ/F1NU2X2RhalWm2OLvhjzjic5Y4cRs
         eZ/Q==
X-Gm-Message-State: ANoB5pn6FFNgXEvixz9D25rJ6NKLuZOObFsLuTnjluTkyxibN+E8f8sN
        dhICqlssCt9St2Ej5hdgAhLpBvZllzSy4TUU
X-Google-Smtp-Source: AA0mqf7WhMefvDP0t+eexqV7L7Cdprsa0v+iAFpVLd06mXseEtAFFdcermtmvNtqfm/gxwpPfuXBAg==
X-Received: by 2002:a05:6a20:9f87:b0:9d:efbf:787d with SMTP id mm7-20020a056a209f8700b0009defbf787dmr13973336pzb.50.1670739453091;
        Sat, 10 Dec 2022 22:17:33 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id s3-20020a656443000000b00478b2d5d148sm3135453pgv.5.2022.12.10.22.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:32 -0800 (PST)
Subject: [PATCH v2 03/24] arm64: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:37 -0800
Message-Id: <20221211061358.28035-4-palmer@rivosinc.com>
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

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
This leaves an empty <uapi/asm/setup.h>, which will soon be cleaned up.
---
 arch/arm64/include/asm/setup.h      | 3 ++-
 arch/arm64/include/uapi/asm/setup.h | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index f4af547ef54c..7ca70f883cee 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -4,8 +4,9 @@
 #define __ARM64_ASM_SETUP_H
 
 #include <linux/string.h>
+#include <linux/types.h>
 
-#include <uapi/asm/setup.h>
+#define COMMAND_LINE_SIZE	2048
 
 void *get_early_fdt_ptr(void);
 void early_fdt_map(u64 dt_phys);
diff --git a/arch/arm64/include/uapi/asm/setup.h b/arch/arm64/include/uapi/asm/setup.h
index 5d703888f351..f9f51e5925aa 100644
--- a/arch/arm64/include/uapi/asm/setup.h
+++ b/arch/arm64/include/uapi/asm/setup.h
@@ -22,6 +22,4 @@
 
 #include <linux/types.h>
 
-#define COMMAND_LINE_SIZE	2048
-
 #endif
-- 
2.38.1

