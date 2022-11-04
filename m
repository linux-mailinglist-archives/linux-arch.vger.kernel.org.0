Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD89E618F15
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 04:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKDDcH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 23:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKDDbh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 23:31:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B72982E;
        Thu,  3 Nov 2022 20:28:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j12so3760439plj.5;
        Thu, 03 Nov 2022 20:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JMT1dZLwWjsj6ZRC5FLwoga4p9ykHLZjt9uAKMBniJ4=;
        b=HzBPQ2voFqnO5CukHYYnrMjmSv2/hvUTLVACr1o2Y6AJOiBYvFodfXbvddb/Is3fXg
         s1yjLSTUOvFT6fkYCrVdlPKepF90j63TqaCQfHjCVdngZGqszDqvZ03+m02hnzUsU7bx
         degYpPwlVagJKCwgJ63pnkEEzOi7EnhmBSQfXuyVNcV4oRS7WFmRtxS1a9FoMGIyB0EL
         hm3AWJ6MnMlNkzep7J2Z4eiSb4B823BxyU+SGQ7GDCxZ+CjN8UmONJohyxUM7i3pOU3r
         v0uyyVTowLpI9d3oxCpcMPxJ82CSNQ8tu7JubSA/TZM0h+14LJeFA4ZmIBiIcJu5vWPQ
         qBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMT1dZLwWjsj6ZRC5FLwoga4p9ykHLZjt9uAKMBniJ4=;
        b=156wYmkCwGLfpcV+Y7J6O6plro+7DPdTtLlkLupKE1GqP5idZTKxPuX8MbFb1dMoIW
         Z1gUVPzNDn/vGv1PAS13f1XYZ/ZMQ7C7FFLXqvPkhNyuLtSGfrn4fBG5NAb0y0EmjfKH
         mHR9qcYP2KWYYtNyxY/3d5dQUdblJ3SXvoaM3tLE5zz2sdK7vLudU5y2DFInDpDd23qN
         W4te4g1YfxmBs+tXzxKE4xMvk9cBTCGRVjrPHcafha5OhhJSpSLdMYwG0C3b7tU2wgxi
         U/AD90xz7EJAQev1uFSkqVRAwgKn9oYUVGiNkQTqfJaFS4L+kF3MLAJtiJnedkfyF8wO
         sBqw==
X-Gm-Message-State: ACrzQf1ByFu+9Mr6ecFKdNDbghtmsRRsOtDqwfbCvpFR5grv/EuvAC4p
        okMnly/cSc7xoKpAt+9uYz4=
X-Google-Smtp-Source: AMsMyM7cAPaIawmjjZVKGzqFvCvu8sr3Gap0Z63OtHMzsH4OcXDBb8WreTvlAnK+TCZdP5X8mu9grA==
X-Received: by 2002:a17:902:d2cf:b0:187:1327:58af with SMTP id n15-20020a170902d2cf00b00187132758afmr28394255plc.88.1667532536439;
        Thu, 03 Nov 2022 20:28:56 -0700 (PDT)
Received: from localhost ([223.65.173.138])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b00176dd41320dsm1435426pln.119.2022.11.03.20.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:28:55 -0700 (PDT)
From:   "zhijun.han" <hanzj.it@gmail.com>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        "zhijun.han" <hanzj.it@gmail.com>
Subject: [PATCH] mm: swap the definition of CONFIG_SPARSEMEM_VMEMMAP and CONFIG_SPARSEMEM
Date:   Fri,  4 Nov 2022 11:28:08 +0800
Message-Id: <20221104032808.24565-1-hanzj.it@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

CONFIG_SPARSEMEM_VMEMMAP depends on CONFIG_SPARSEMEM
When CONFIG_SPARSEMEM_VMEMMAP is enabled,
CONFIG_SPARSEMEM will be enabled too.
Causes __pfn_to_page and __page_to_pfn to be overwritten

Signed-off-by: zhijun.han <hanzj.it@gmail.com>
---
 include/asm-generic/memory_model.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index a2c8ed60233a..e06851e0b39e 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -19,12 +19,6 @@
 #define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
 				 ARCH_PFN_OFFSET)
 
-#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
-
-/* memmap is virtually contiguous.  */
-#define __pfn_to_page(pfn)	(vmemmap + (pfn))
-#define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)
-
 #elif defined(CONFIG_SPARSEMEM)
 /*
  * Note: section's mem_map is encoded to reflect its start_pfn.
@@ -41,6 +35,12 @@
 	struct mem_section *__sec = __pfn_to_section(__pfn);	\
 	__section_mem_map_addr(__sec) + __pfn;		\
 })
+
+#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
+
+/* memmap is virtually contiguous.  */
+#define __pfn_to_page(pfn)	(vmemmap + (pfn))
+#define __page_to_pfn(page)	((unsigned long)((page) - vmemmap))
 #endif /* CONFIG_FLATMEM/SPARSEMEM */
 
 /*
-- 
2.37.0 (Apple Git-136)

