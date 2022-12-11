Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7E46492DF
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiLKGUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiLKGTn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:19:43 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DED313D72
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:18:01 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id h193so6161297pgc.10
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzjPiOUXUCGjDcLS1SPe25J0gPVaY+ytd1rLYHu4mKw=;
        b=yt8hwRU4SHxTb7HBBdpIjzRBr8nYk40J5db87dPGMQiGbznKP9cRs4RxJnwbn20eDs
         Rtj8WvS9y3iwOIGZd2ZpW92w0stU/Lne0rmD6EY2AxTHxlqipPI7652Ez/foRPgbU68z
         RVE5uy71XAtrWrNMq3JaEq5cCuKI7MM4UXrN0+gefmZAoC4zXqgdWVpygDaYiiGHSyum
         1rXwmNc1dFumygrpU6HEbHt5i6gL6NLMW9AeyzC+nc5ZdndhtGn3QZDD2ealOx7RlYIt
         1vX+XDT8Vv1hMGNHrJ94E5RM4A/U649lXzOJC2If86B3n7Z+QUFkvR4unfIdQROAkrpB
         UNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzjPiOUXUCGjDcLS1SPe25J0gPVaY+ytd1rLYHu4mKw=;
        b=ScAn940wLSTAFMu38qQM6zbd6AydvWPW2CZCCixp3WcwC0qDMCexKvGkFNfP2V4+sb
         Dgbx0l8hPdDdr6D27yN3R1M7J7QCveWVbh8FzGeSao/L+KwDeGwBnWm0TMlccD9hRN5z
         FiJ2ieCK32fwOzNda4XYFQ8QyUEkFd1aoBLlvMoB17IkMP2UHpFPqwgoQNNEaYLI7jgS
         DxZlQf5OBZlp4Wqegt3UPnVwbhgZYuVfTTjZQe2SHeWDGjxjrXECwj8yeQfcb3tenP8G
         XgZSvNURF8bfgPhfOi/PimEOV5d/CQGYBPDF1OtwFrsyoMkeZsnsN+11yXEyPx9fpZic
         QzYw==
X-Gm-Message-State: ANoB5pkzY1+eifUgtVXnIsymPqT+ddCCFW0dxcDL0GKde9pSRDU5+nqn
        pra87zp0s8j0kf7Cp+vKlpF+0g==
X-Google-Smtp-Source: AA0mqf6lkHfORa9RIyU8MAFKRk1wFqysRjn4m3TNLky5UntPRdRG1+j88tWgKw//B+WaQ3zoeGQj6A==
X-Received: by 2002:aa7:8faa:0:b0:577:adb7:20dc with SMTP id t42-20020aa78faa000000b00577adb720dcmr12669094pfs.5.1670739474679;
        Sat, 10 Dec 2022 22:17:54 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id 7-20020a620607000000b0057709fce782sm3504373pfg.54.2022.12.10.22.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:54 -0800 (PST)
Subject: [PATCH v2 21/24] s390: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:55 -0800
Message-Id: <20221211061358.28035-22-palmer@rivosinc.com>
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
 arch/s390/include/asm/setup.h      | 1 -
 arch/s390/include/uapi/asm/setup.h | 1 -
 2 files changed, 2 deletions(-)
 delete mode 100644 arch/s390/include/uapi/asm/setup.h

diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 77e6506898f5..e41611c98825 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -7,7 +7,6 @@
 #define _ASM_S390_SETUP_H
 
 #include <linux/bits.h>
-#include <uapi/asm/setup.h>
 #include <linux/build_bug.h>
 
 #define PARMAREA		0x10400
diff --git a/arch/s390/include/uapi/asm/setup.h b/arch/s390/include/uapi/asm/setup.h
deleted file mode 100644
index 598d769e76df..000000000000
--- a/arch/s390/include/uapi/asm/setup.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-- 
2.38.1

