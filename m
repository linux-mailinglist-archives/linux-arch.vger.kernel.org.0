Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B8973AB04
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 23:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjFVVDU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 17:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjFVVCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 17:02:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3F72D6B;
        Thu, 22 Jun 2023 13:59:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bb15165ba06so6116030276.2;
        Thu, 22 Jun 2023 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467540; x=1690059540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=oM2eqoarO5mbV/RC9CFfzfiqtalAJnN4v5hz57x8U3YE+/nDsUrmXb6G6NrrfuA0hI
         XHlp77eZ+DzSkin9lWOejdHXde4PpTwM3RiXeCXAduuSgLDQHciXyNj0UWZkZs6yvfTo
         QiJ21UomG7h0wL2TX1WHwgye+s/VKR+Tvt1mxLr3lV1WjwsNROzbcgrXcLO9VnGSpeAH
         7uCU00iH87QJVCo5EKIyfZlW0ogPYyMPi5bY1z7m39x6DegLfFGe3afEY/9WN7xyqGjN
         dkO4NEs5eZtRaUa3RiJYmwztOORKB/ecQ6EJlrLWdOw/VRXBlFmMwGL9APm0v6t4+G2k
         ZQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467540; x=1690059540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=WwHT6LdkF+ijaeKCccisn/1jkP9Qyczfhq43XE2XY2AqfrqV3Z0+riJ53zFexqw5y7
         Ibnw57NTYrK7HtZqgPhrFEQXZ2+HYPTtJH+8u+2+99Kz/rYBdjhj2Kx5k6xiNQKMLQoB
         4wwAXusbvag067XnqL8c+med2GAxBZaVZwo41t1wYQwTVO65nOPJASoBONnzvPY9jlTW
         FyuM4oQyS2enbZFgHS1sSHIW3zWIcPUrZHnA+RXZ8WpZC0i+nZkamthvGRWGe1PE3c2X
         e1eOAoSY54H4RO9kO3J9H5MB0BkGzt7hqWKnzAzQMpcgfby8qdASmcZZY1gsYCsxmaGD
         bNuw==
X-Gm-Message-State: AC+VfDxWZhG3f+wwlx1q/z4D1dTWyfABjdVdi0iiCaCnb1mezAvrsYVF
        9a83TTOHM2OhTUZ81C0L0B8=
X-Google-Smtp-Source: ACHHUZ6Ec2kbAX1UDgGMj9ZCyBvb/VNaStMToJEcOH7SUf7INOW9CMO0HLoZFa/KezNB/PETnccRFQ==
X-Received: by 2002:a25:bc53:0:b0:ba7:db6c:c0eb with SMTP id d19-20020a25bc53000000b00ba7db6cc0ebmr10225049ybk.3.1687467540710;
        Thu, 22 Jun 2023 13:59:00 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:59:00 -0700 (PDT)
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
        "David S. Miller" <davem@davemloft.net>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 31/33] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date:   Thu, 22 Jun 2023 13:57:43 -0700
Message-Id: <20230622205745.79707-32-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable pte constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sparc/mm/srmmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 13f027afc875..8393faa3e596 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+	if (page_ref_inc_return(page) == 2 &&
+			!pagetable_pte_ctor(page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
@@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_dec_return(page) == 1)
-		pgtable_pte_page_dtor(page);
+		pagetable_pte_dtor(page_ptdesc(page));
 	spin_unlock(&mm->page_table_lock);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
-- 
2.40.1

