Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5417032D40B
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 14:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhCDNVY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 08:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhCDNVJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 08:21:09 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31A2C06175F;
        Thu,  4 Mar 2021 05:20:29 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id jx13so6569208pjb.1;
        Thu, 04 Mar 2021 05:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TuebsGZ7PfFLh+7VtFFI1adnwVCzaRy+r3d2bkdQFc=;
        b=ezgmgckKXwMf1XnQDpICKsBKNtIMTaEjBtWq2osVrPLrJBXdavfge9eoYCtdZCCzSa
         MCH+ayceOvwj0c2+KGgjKphFRufEr1GqkU5H20NTxwuLtZcMQ19p7e8t+y1oL4SyqoFk
         /Werxajx3XgBNvxdAJH+WqIlW5wuRAZ8f8owXo3hBvLGqQ6wnJc5lQeEH1m3yCyvGDAY
         0QnpMK0qOJJivxyCm8QrYhlVrFg3bt5spfQsoEZGavewM5F4hOPsIZa+8ipbGxUsZmq4
         Asfb0undkcPDPe916S51XllzdpWRW9av5aTC/zC/vz2idEcyEdOCZ2T4nTBsWlo30r6c
         4/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TuebsGZ7PfFLh+7VtFFI1adnwVCzaRy+r3d2bkdQFc=;
        b=X12+b5l5ox1mlljXQM1GTP8xD6/r2Yvw9FGWHISnWK6OPel/K7Um+4ulQM+UT7nl0T
         NNDUbRuT+YDMTGMLs3jFCAK0ZDxWKdcFMyFGyOtfs6QT9o7kfmp759YhMEX+238cQlq2
         fFpdIJQsTMP44q7IraoaxDC7dNHbIXUPjKnjFgaeRJUvZK8c4N1TGDkY2DZZVeglTOC0
         /xI2xmOeX+NwE+QIkJXObWnkaH230DUlaU44zSLW9PCChpN1xuKdH3OQyvJpMr4jwPTA
         Q6eSntJgIgDD5rDMUp0ANv4atyiQvl5oB1VRLN6xhEOofH6TVj1NAtk0QieK7xzSDtta
         DhAQ==
X-Gm-Message-State: AOAM53392WLCEjyMORQ3NJYOp7tskhf+ePAN7Jp1txU5XEyAx+ZthulX
        puJ6H4BmZ1fD6AaYCxSdSC8=
X-Google-Smtp-Source: ABdhPJw5mop7Q05iwGPVDPv/TV7muVAYEl+QpfM+dzp7wGwLuxJ9xrmHLzyFf9+5Z90KHfNnJQiWeA==
X-Received: by 2002:a17:902:ea09:b029:e3:a720:b83 with SMTP id s9-20020a170902ea09b02900e3a7200b83mr4023689plg.51.1614864028293;
        Thu, 04 Mar 2021 05:20:28 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id u9sm26809374pgc.59.2021.03.04.05.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 05:20:27 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     aneesh.kumar@linux.ibm.com
Cc:     will@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
        peterz@infradead.org, ysato@users.sourceforge.jp, dalias@libc.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] sh: remove duplicate include in tlb.h
Date:   Thu,  4 Mar 2021 05:20:20 -0800
Message-Id: <20210304132020.196811-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm-generic/tlb.h' included in 'asm/tlb.h' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/sh/include/asm/tlb.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index 360f713d009b..aeb8915e9254 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -4,12 +4,11 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/pagemap.h>
+#include <asm-generic/tlb.h>
 
 #ifdef CONFIG_MMU
 #include <linux/swap.h>
 
-#include <asm-generic/tlb.h>
-
 #if defined(CONFIG_CPU_SH4)
 extern void tlb_wire_entry(struct vm_area_struct *, unsigned long, pte_t);
 extern void tlb_unwire_entry(void);
@@ -24,12 +23,7 @@ static inline void tlb_unwire_entry(void)
 {
 	BUG();
 }
-#endif
-
-#else /* CONFIG_MMU */
-
-#include <asm-generic/tlb.h>
-
+#endif /* CONFIG_CPU_SH4 */
 #endif /* CONFIG_MMU */
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_SH_TLB_H */
-- 
2.25.1

