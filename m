Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E86F37F1
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjEATb3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjEAT3r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8B230E5;
        Mon,  1 May 2023 12:29:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115e652eeso29041938b3a.0;
        Mon, 01 May 2023 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969358; x=1685561358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aCjEZJk/he0B507v8WHbAo+ayyw9u0whNe5hSh1Qc0=;
        b=AK+jJQIndwyipvZ3j74RRrDCnGWb55RfRTFZCAj1QjfEP6JtcEnkxab8VHfUxlnJqD
         nzyDIYAX6jvOrQqc9g/TswPCkcqNA0B0b+SVKLMEmNApHkelPozzZarkoTrP2UobldQU
         E6NqDV1CfueV3wQaPICMNftiMflroUHircwtbGv3hyeRwqO/KqZCxi3BNAP0dk8lYID7
         5OwqBACQpi+nvrf0goZMdOfhVuRwRiXsUHvkFH+vRl0eIOaoeix6IqEc2ZJsYZWlONhr
         qoO4S8rXijotpMJHxa1FWYbjKdY7R5WGEGDzLNmBq3rOIwjAHcvHuIBKVpOdfgv+tSJ1
         RDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969358; x=1685561358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aCjEZJk/he0B507v8WHbAo+ayyw9u0whNe5hSh1Qc0=;
        b=EXUAmg1UurFSbrAAxlS59qpcWItlSKdsLR9Vl7yH8i43DsvHk3/HDUnx171kJv4qIU
         3RakRg/gIYbaJnMxeWrP7erXBYGVNzUnmksa70kNJ/Mxy+HSA9QD8svd2W0WSnG403I/
         kUUMiEriFnJLdEejhU5kvyKPu3K8s3/dMUV+GxB6BFu1rcI+awMqYOG7STrJQzGmt6/k
         FpBw2eNOTNtKKDSpo65f8uwkShPnBa140pIitIbZEGbiYS3STYeou26Bwi0AEbReTsia
         uHaK6N4LEz8AKwXtd56Zr+lEzBO8Z/twroeXoiBdpqmtr+K5GZ0QZrsdAZdHiULjwVC5
         rgJQ==
X-Gm-Message-State: AC+VfDyvTISEAODf35e1tt4nLqLM1EWgU/ZCoqeLD5+kker4ld0DSNq6
        445o1+jeKK7cQAGs1A0r0Ws=
X-Google-Smtp-Source: ACHHUZ6t8R71ld5pjw9YJiJ63m1PjvmCLBjw2ONvK02V0vikRtqecj56I+goZm4GypngOeaNmv5J/w==
X-Received: by 2002:a17:903:2307:b0:19a:96ea:3850 with SMTP id d7-20020a170903230700b0019a96ea3850mr18111173plh.17.1682969358236;
        Mon, 01 May 2023 12:29:18 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:17 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date:   Mon,  1 May 2023 12:28:25 -0700
Message-Id: <20230501192829.17086-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sh/include/asm/pgalloc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..ce2ba99dbd84 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_PGALLOC_H
 #define __ASM_SH_PGALLOC_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
@@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.39.2

