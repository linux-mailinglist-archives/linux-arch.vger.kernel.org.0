Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7973F241
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjF0DUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjF0DTz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:19:55 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A850730DA;
        Mon, 26 Jun 2023 20:16:23 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57045429f76so40114347b3.0;
        Mon, 26 Jun 2023 20:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835775; x=1690427775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRfRtQSkmDpdaHgWU+x8J8rVDSFtmuGYMRjnXDV0vQY=;
        b=Gr8f3MEz3obvDl9KABhIuO70HTBkoFbuWEeimu9z4yQhoBxpIMzXHt4/zQiD/35FR2
         Rou/oVuLMNuircs5Aw55ugfL83e83sFrRKh4nGjfNUBrs0Ns51CypHUWM+aHwKiIGCB4
         bDbKAJJc6ueglTVv6Zd/8VvPqPuBRwfoUXOaXnwyPF0zCFc73NfT/c9Q8XEzBzPYIVow
         QBI9GU/YA6Md8J3UGn6Xw0CXbMe3aYnpOaLZmcH+kLxI6o4K+ynL8B23lQ0U//mVHlcw
         WbYitL1St1RrPY9jH0d0TpkVmHfz+e14q0Nl7+sag9AUsUOnDCmyHqhFNRZORMjuCsmz
         kdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835775; x=1690427775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRfRtQSkmDpdaHgWU+x8J8rVDSFtmuGYMRjnXDV0vQY=;
        b=DAR/jfLfFAzqjmz1zu34qyBmuDqISmUIQeqMgoqBxN9ZBtNbr2loTBGBwmNes8OAhL
         WpdY7mzQ9mqLdRZk10p7iIfhAPBs7P4A4fbmf/vQgLCO5xOUXx42CFXqiMtsokPK3oTH
         gPi4G9VYVDwkVHN2BrViTQM+wYFHN51WWmkwmpBWCNJ3t7SiMlHuxEkRCRwIgyrmQUSM
         KZSVe+1IRk4fVI5QE4GFztT4jqSM92MVWouiyNKX4w4SzQ/zo6Q4nsdlGajYN0515150
         4+IEuVRXQMhqrDJ82R1qafQfRnXmTClUlxg1EtdrLNEQj53fWdenqQGrYCf4S6S2eiFB
         EzxA==
X-Gm-Message-State: AC+VfDy2FcieoK0II28vzh6zWOffQE/t7x0Ruk6soWjlDZrozE8bet9N
        WkP7zT3WK7RhnSUMmUudcI4=
X-Google-Smtp-Source: ACHHUZ4XU3sOm1xs9Jcr5rbSZbAjZaSOolmfhgi2qcsz6PmREIffAwTevHZjKc/Hdw6V5zHvfavIAw==
X-Received: by 2002:a0d:cd46:0:b0:576:7902:f4dd with SMTP id p67-20020a0dcd46000000b005767902f4ddmr12132465ywd.47.1687835775530;
        Mon, 26 Jun 2023 20:16:15 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:16:15 -0700 (PDT)
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
        kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 32/33] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:30 -0700
Message-Id: <20230627031431.29653-33-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..de5e31c64793 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,19 +25,19 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb,pte, address)		\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb),(pte));			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-#define __pmd_free_tlb(tlb, pmd, address)		\
-do {							\
-	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
-	tlb_remove_page((tlb),virt_to_page(pmd));	\
-} while (0)						\
+#define __pmd_free_tlb(tlb, pmd, address)			\
+do {								\
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.40.1

