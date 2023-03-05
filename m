Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6C66AB24A
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCEU5h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCEU5N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:57:13 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C503199D8;
        Sun,  5 Mar 2023 12:57:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id k10so6900103edk.13;
        Sun, 05 Mar 2023 12:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXoBl7+op9aWSq5Dkg0e/fVhHu4Qq2D4107mPK7NLLs=;
        b=NXbVUoifiR5f9wJbmip3eWTWXYXEwmyaIdEBNnfCyRdyAk7zaaXRY0sYnfJRGWuLAS
         g8x59fLsFLmo5M3Ik3s/tk1KKBZCczl1Fgw42WTZOWS04DzPYnwi4w55o7h+c+eVefjA
         yGaHfjFFSAxNqbiQZpqt3i+u6y2V2BkU7O67/5ecoxTFpwzclUj8SQCgKdL2w7dE53dA
         5xMBuutmSq1NOS9h1Fdt7g9A/4eDJZHogsS6RiAAuXcSEX6dnzhJIQ7F1HTmc/YOQoP6
         jsa1rwU2ODNFy+VyW2rjw0v/ilyUvuIGQPs1yrtAiQeKZDT2jOBr7m4vLNyVajzwbMKC
         dB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXoBl7+op9aWSq5Dkg0e/fVhHu4Qq2D4107mPK7NLLs=;
        b=e8Vnmuuh65IeZbnyspkhyTcb86E3yUXs0DtKVCzWgVQuD/0Oz3L+jRzEo4QGlXVHm2
         USGbtjQEDKDmzTuKeLisIbBdi+J96fa4VRNlbBuugw7Y+D+Efy2q1030j9c/ChD1bQg9
         ziZVsxZ/9jtH+cgbbl86up4suXRw2jLe9iSxKbgnfA+XHPMhNh/Jb4PHObk5AJxeV35w
         2omKFSOXizJJwoIHUjCvfVVLjNsuSIt5aHDXAsKx3jHj9TSemcaB+96tVcwOHmAb3B5q
         FwnvzlTXIHkG2rqMazo1xtk7KE6gNj7DDVgJL+tACbyNvtLHiTZNV6HTW3EZwUbgPTaL
         x5uQ==
X-Gm-Message-State: AO0yUKV5/JjRsklBkChhOsGuVltIhoP0uuJjdIC0dXVrwgMY2vvbZoqJ
        M4/IGSWVIsVMIYY6IFDtESCpc6JX4aQ065Vk
X-Google-Smtp-Source: AK7set82bFu6nQYw7chShTqd/Oc7Lhw2Ixl//LUdtfoQSZu7/ZtYQcw9c6CERUPnPhuuiN2uS3xPww==
X-Received: by 2002:a17:907:8c8a:b0:8ee:babc:d2dd with SMTP id td10-20020a1709078c8a00b008eebabcd2ddmr7854988ejc.18.1678049825779;
        Sun, 05 Mar 2023 12:57:05 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:57:05 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/10] locking/generic: Wire up local{,64}_try_cmpxchg
Date:   Sun,  5 Mar 2023 21:56:26 +0100
Message-Id: <20230305205628.27385-9-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305205628.27385-1-ubizjak@gmail.com>
References: <20230305205628.27385-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement generic support for local{,64}_try_cmpxchg.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 include/asm-generic/local.h   | 1 +
 include/asm-generic/local64.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
index fca7f1d84818..7f97018df66f 100644
--- a/include/asm-generic/local.h
+++ b/include/asm-generic/local.h
@@ -42,6 +42,7 @@ typedef struct
 #define local_inc_return(l) atomic_long_inc_return(&(l)->a)
 
 #define local_cmpxchg(l, o, n) atomic_long_cmpxchg((&(l)->a), (o), (n))
+#define local_try_cmpxchg(l, po, n) atomic_long_try_cmpxchg((&(l)->a), (po), (n))
 #define local_xchg(l, n) atomic_long_xchg((&(l)->a), (n))
 #define local_add_unless(l, _a, u) atomic_long_add_unless((&(l)->a), (_a), (u))
 #define local_inc_not_zero(l) atomic_long_inc_not_zero(&(l)->a)
diff --git a/include/asm-generic/local64.h b/include/asm-generic/local64.h
index 765be0b7d883..54b91e93ae76 100644
--- a/include/asm-generic/local64.h
+++ b/include/asm-generic/local64.h
@@ -43,6 +43,7 @@ typedef struct {
 #define local64_inc_return(l)	local_inc_return(&(l)->a)
 
 #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
+#define local64_try_cmpxchg(l, po, n) local_try_cmpxchg((&(l)->a), (po), (n))
 #define local64_xchg(l, n)	local_xchg((&(l)->a), (n))
 #define local64_add_unless(l, _a, u) local_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	local_inc_not_zero(&(l)->a)
@@ -81,6 +82,7 @@ typedef struct {
 #define local64_inc_return(l)	atomic64_inc_return(&(l)->a)
 
 #define local64_cmpxchg(l, o, n) atomic64_cmpxchg((&(l)->a), (o), (n))
+#define local64_try_cmpxchg(l, po, n) atomic64_try_cmpxchg((&(l)->a), (po), (n))
 #define local64_xchg(l, n)	atomic64_xchg((&(l)->a), (n))
 #define local64_add_unless(l, _a, u) atomic64_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	atomic64_inc_not_zero(&(l)->a)
-- 
2.39.2

