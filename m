Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C61F70DEAB
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 16:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbjEWOIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 10:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjEWOHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 10:07:25 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD6E5E
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2023 07:06:59 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so907804e87.0
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2023 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850757; x=1687442757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXvb5TDUzvESWFR9QC/PoBRtJqf1+F8aU7D/u9pREy0=;
        b=jUf/xLDRQeFWkvJxlE7DG8k/g9Kaq7kmU356lCnEcTPt7HRH9mF3yYSSKYy3AjdmMb
         PNJoXmxSr7xwdkekuAGpi31DkWD2cnBbwWlnwniyL4NTEq8RWhSGAm7lNJ56nBi7lYUz
         E0oj4UfEebq9LsjfphS/f/Zp9PIP/3JLeguL6Pe8UJJWKt8dQFmYwMpDNb6cjxHzVKmh
         7fNHGbzoBbZ9dqlk8I/Mn0uG+EBCCvXw2LyD39z4Mh8nQI8yIzYFz+e/GOxUL2Yxfk6e
         uOTevK/Gu1QvFq1s1cju6TkuunqswAEzPfBN+ZKrRoq9EFkn/phqnUa5oOger2h3AlhE
         3yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850757; x=1687442757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXvb5TDUzvESWFR9QC/PoBRtJqf1+F8aU7D/u9pREy0=;
        b=VHdogpigFL/FI+AIuuz1OLwEUCVEeNmA8aeKomUd6oqSNOGeB81RCrwZP9iNUBlM1N
         T2SWVEsb43MaW0kWmita13Q88mIiTiXer+TNtmD3s1uOEJ/zdG2arUukuYXeGxV+aZVx
         AJn/nEt6DDiy1ZZmNVq7H3HJvdrguDsmuutY10hizk6qGdCZVtNRhGmsL6b8c9Lea9ho
         UQVPp/6mS1d47m0jgDx7/cvn5z2Vc7Me2VpY/i3qTlOTBMPJheamqMMiXtwyXU5kQBOG
         0A+KkjiTZ5kDpZw+Df8tSkTKRvNZtSM15INU+B92iiYMPO4G79coeJTQZkCigTQRMMog
         /6vA==
X-Gm-Message-State: AC+VfDywAdOLYXOYiCq52V9doICFoDl95vY8QEap/UB8EiLPVFO25WYE
        mNU6gLbGzz9frqIVmqnCxvbEqQ==
X-Google-Smtp-Source: ACHHUZ4aZ/AZ/8gxQE/YnF0VxlckPQW0Tv4gMGhkdHXNXCrF6Daph5XoYtZlIIicwXM9NPHyzPIGpA==
X-Received: by 2002:ac2:43ba:0:b0:4f4:aea9:2a2d with SMTP id t26-20020ac243ba000000b004f4aea92a2dmr2010283lfl.43.1684850757405;
        Tue, 23 May 2023 07:05:57 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:57 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:36 +0200
Subject: [PATCH v3 12/12] m68k/mm: Make pfn accessors static inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-12-a16c19c03583@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry, do the same with pfn_to_virt().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/m68k/include/asm/page_mm.h | 11 +++++++++--
 arch/m68k/include/asm/page_no.h | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index 3903db2e8da7..363aa0f9ba8a 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -121,8 +121,15 @@ static inline void *__va(unsigned long x)
  * TODO: implement (fast) pfn<->pgdat_idx conversion functions, this makes lots
  * of the shifts unnecessary.
  */
-#define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline void *pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn << PAGE_SHIFT);
+}
 
 extern int m68k_virt_to_node_shift;
 
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index 060e4c0e7605..af3a10973233 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -19,8 +19,15 @@ extern unsigned long memory_end;
 #define __pa(vaddr)		((unsigned long)(vaddr))
 #define __va(paddr)		((void *)((unsigned long)(paddr)))
 
-#define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline void *pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn << PAGE_SHIFT);
+}
 
 #define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
 #define page_to_virt(page)	__va(((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET))

-- 
2.34.1

