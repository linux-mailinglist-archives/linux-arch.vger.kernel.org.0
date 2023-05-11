Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329526FEECB
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbjEKJ3W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbjEKJ2y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 05:28:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E45FD8;
        Thu, 11 May 2023 02:28:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab0c697c2bso77815845ad.1;
        Thu, 11 May 2023 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683797324; x=1686389324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AKArW/9N1DM1cw/nq7oO3Ipc/BxTBMz8SQU51oi5QM=;
        b=lSqSpkTeYoe3tO29lldpVHbM32z393QYWP5lHnZIBWCvEarPeFYrVLxfqpKRFeiMH9
         O/4rvObcKOyglqs8faTtrmcVYFQ8XJOPmtyKy2kiWHSt1RBmvearJPkZQEhcKNjXUV44
         zPmk9SGD5swqjEFi8vzVyC7S7hRLhT8oymp0Nn+j0Lqb53GMv6htmJ3pwBf5TwaV1uFR
         bqB49lbtbgVPuSNA3cLK217LA3Bph6pGjOU+UaaDA/QzyAdGYXsakKnwD8no18SkjADS
         VxaC3PcxwjVwmU+nKQWSxICPOzqvM3jml+aMSgjVP8wtczWmTNUNx3u/IsGxy11QAZfk
         GwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797324; x=1686389324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AKArW/9N1DM1cw/nq7oO3Ipc/BxTBMz8SQU51oi5QM=;
        b=OysjBIQnpYcG3jJJYoGM6rJHu6aDTnGL1rTF1xYYL6BQHQKe/w3PZ29gaB9/OoVQa+
         DGS/yVDet+oyNDcLf/DQGCN84dvzYEPSCv86XSCzWqE0WHqQYceaZGQEAcOe+jin9C8y
         F0CXN75MBgR9zJt8GOdHo+rn069hUuoFzCvJ1Aar1q5ZYOc3ts8GpJoWhn7XGQ5t7Epi
         dqwvHBdj8iHRnwR75chTkzfb9lPXYdSscXh1AKsXTeAQz5zf1jjkZY8Wq3mzS4UTsygx
         LwDAHCFeDVRCS1owT8URj3bvEkykXdU+ycI1TKG60tjnLnic08Ya2gAMaC/wFz104dq4
         vwUg==
X-Gm-Message-State: AC+VfDxBu0+kKJ9oo/1552kONkhgkp26F61Ii2Iho3n9SrJdh6Q+d4A0
        ni6gKY0Jj3V/Ma7uKg3sFVNNT2PSAUYkpQ==
X-Google-Smtp-Source: ACHHUZ4kt2fEW6y1LT9sL5KAOXOvB6IxvXmm6lpgkO77jh+uBd0sq2MbCeuvBayswScpQ/VmBXnGwQ==
X-Received: by 2002:a17:902:db0e:b0:1ab:12cf:9e1c with SMTP id m14-20020a170902db0e00b001ab12cf9e1cmr23993360plx.32.1683797324390;
        Thu, 11 May 2023 02:28:44 -0700 (PDT)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001ab0669d84csm5407877plk.26.2023.05.11.02.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:28:44 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-api@vger.kernel.org, kernel-team@meta.com,
        linux-arch@vger.kernel.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: wire up cachestat for arm64
Date:   Thu, 11 May 2023 02:28:43 -0700
Message-Id: <20230511092843.3896327-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510195806.2902878-1-nphamcs@gmail.com>
References: <20230510195806.2902878-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

cachestat is a new syscall that was previously wired in for most
architectures:

https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com/
https://lore.kernel.org/linux-mm/20230510195806.2902878-1-nphamcs@gmail.com/

However, those patches miss arm64, which has its own syscall table in arch/arm64.
This patch wires cachestat in for arm64.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 037feba03a51..64a514f90131 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		451
+#define __NR_compat_syscalls		452
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 604a2053d006..d952a28463e0 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -907,6 +907,8 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
+#define __NR_cachestat 451
+__SYSCALL(__NR_cachestat, sys_cachestat)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.34.1

