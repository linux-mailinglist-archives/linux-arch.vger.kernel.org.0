Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C299F6492BD
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiLKGRy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiLKGRi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:17:38 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1241BF02B
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:36 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jn7so8933307plb.13
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOL/OYhtDy1+Gwo7dBzPN6z4Yt3JTASprXbvM5yOD9Y=;
        b=4SL44KdZtW6MD1HQjiYYx3hVWVYVTFm2LLLO38cNCor1mC9C2NiEOdylwVQ+ED69fe
         cXVZR3Cb+R5wPBD6Izoi7J7GNLl/ckpiBDR1SZrJy0LdXksTiqWlsCN6qbsQHM0Daz28
         8VNT9LprZvGEoN07GKXkxmSRUko2rOWqMNLldb51K0O76HMWqI6WJZThwqOkvxiBSkS9
         nXeVqcfoIm890pWQZL3QqkMzTYSyqtOUe2kI0Jk+7QlEKjov1Vhy+Bn3FvMXF6wDlI9j
         wsNyNYO8DosgIWVIOg/ZZ9O3w6TMo2EfnjSLpAzLp12omuB+FI5jEnKZ2xAwSQ3Pg8Wr
         q6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOL/OYhtDy1+Gwo7dBzPN6z4Yt3JTASprXbvM5yOD9Y=;
        b=WOo4poNrLVMw6edNUKcBWWPNMaseJUl1DRIoGvaPMQIh5YVuWT7+teBKZ6SraRyKBF
         pAXQPrEcAH/NrNDMnN23RAOSn23ZSNpSEfY6Bswnt5H7C8UtrX99ekKWlnFQOOChahrT
         uIagrnNbBnWD9xr2mckFyHpRzx1234iU0pT2KluwdpIYTCnaUmAQqoebgnzpeVyelpJR
         EgClK9IKeoyg7nTzIb9iFun9yOO2Ie54FI19luIGs6vSTRB6ArlU8EpL9S8Lwq1yKxfW
         eofWo0FO2x1UMc9bK+5gzhWh0HxNOOGleQbzDs3htH+cel599g/hqWfaaZsAQxCBZl1o
         Jxjg==
X-Gm-Message-State: ANoB5plSmbZESwfnY9LzgS6tXeGojqzBjygJclvLG3gFS3nTZq97RlXX
        YDwAB38ylFwCdXQuxdbayJRcFA==
X-Google-Smtp-Source: AA0mqf5kh+vUoT2CFAz7YyZjn8Fzs9awv8LIr2ocU5Ys4sge59E9VnR+H2A0bm5/A9Hydoq6s2LMAQ==
X-Received: by 2002:a17:90a:9f93:b0:218:d233:15c8 with SMTP id o19-20020a17090a9f9300b00218d23315c8mr11493313pjp.15.1670739455493;
        Sat, 10 Dec 2022 22:17:35 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id nn7-20020a17090b38c700b0021900ba8eeesm3411197pjb.2.2022.12.10.22.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:35 -0800 (PST)
Subject: [PATCH v2 05/24] m68k: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:39 -0800
Message-Id: <20221211061358.28035-6-palmer@rivosinc.com>
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
 arch/m68k/include/asm/setup.h      | 3 +--
 arch/m68k/include/uapi/asm/setup.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/setup.h b/arch/m68k/include/asm/setup.h
index 2c99477aaf89..9a256cc3931d 100644
--- a/arch/m68k/include/asm/setup.h
+++ b/arch/m68k/include/asm/setup.h
@@ -23,9 +23,8 @@
 #define _M68K_SETUP_H
 
 #include <uapi/asm/bootinfo.h>
-#include <uapi/asm/setup.h>
-
 
+#define COMMAND_LINE_SIZE 256
 #define CL_SIZE COMMAND_LINE_SIZE
 
 #ifndef __ASSEMBLY__
diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/asm/setup.h
index 25fe26d5597c..005593acc7d8 100644
--- a/arch/m68k/include/uapi/asm/setup.h
+++ b/arch/m68k/include/uapi/asm/setup.h
@@ -12,6 +12,4 @@
 #ifndef _UAPI_M68K_SETUP_H
 #define _UAPI_M68K_SETUP_H
 
-#define COMMAND_LINE_SIZE 256
-
 #endif /* _UAPI_M68K_SETUP_H */
-- 
2.38.1

