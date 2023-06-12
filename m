Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB772D2E3
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbjFLVJQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbjFLVIY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:08:24 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1624A4217;
        Mon, 12 Jun 2023 14:05:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565aa2cc428so40619947b3.1;
        Mon, 12 Jun 2023 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603949; x=1689195949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6EpXhLB/ZnHGYzIKEyphwqiyS9zUDTms38NuP0TFmY=;
        b=HZjqN37hCOK48cvGmZP3MyXHPsSWerODKITkESa+8okEvm66QeHMRWeJrMA+h9zAy/
         b08e3G4t5lsUUKbLUtaHE2GPHfm2Y6f2xgW3YiErhjVlP8jaPnDQQDBBPDgWToXRn7mW
         PpzBiVyA5JSxI70xxYGR2PwmojuW4ejIHH6298KzStJQkqMFOYKQH99Y1J/uWKo9ZDSM
         eRMw42CLQFJ3ndhOIFwgLE2rhtWcbpTrYEwDV/LXUoaY8xrQBL0kpr9KnDHMQo57XMNA
         dJaliHJT5dELYDcW6j8kH/iUc98Tn/GD3Nr/eiXjSdRocwfmdaU0ArfMHM4wLvGwtdMu
         leiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603949; x=1689195949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6EpXhLB/ZnHGYzIKEyphwqiyS9zUDTms38NuP0TFmY=;
        b=HRdKoGB0MUxv/q3bhwN76zoBJvmZPMqQ0k4KfCPibQ/+6Tltx0Ji7xuPez7SWaubx2
         pzogsjUBXQzi9jI01PY4w0j/4M/7H/8cBcZcyn+4tiP+ScjIf29DfxOshopalFhjqZnr
         fPOuhS4jIn6eYOdKEbGrlOv7zQo/91m21nxdaOAO52/JdvMBW8aT5ctMBFpQ0XOlc534
         4gi5e/sYBpgLfXQrPFypFjtz+d0J4rE1fKEaQ+dkNRMiCGAZ9G0c6nBe3F/kK5EMi42s
         9eoZD+CaamUI+wqd9cpYucfI2UomRQnw2LnICZ/rGh9//FqVzq7lOZC1312Au8KgDRiE
         d/Rw==
X-Gm-Message-State: AC+VfDyMvrbzGYS1UH+Kk2jg/7ZrRUlCh7v0KbDUJH5K1JlHmxaeEEjz
        P5sqIl1G2hbkjalyle9Zak4=
X-Google-Smtp-Source: ACHHUZ45RyLy6yl6Drr+w1zJryROJeWNSP67xpIchmrzxG/I82VOblMbJJSkZ2edvv8Qj+2hZ+73Vw==
X-Received: by 2002:a81:7bd6:0:b0:565:d517:e714 with SMTP id w205-20020a817bd6000000b00565d517e714mr7606123ywc.25.1686603949233;
        Mon, 12 Jun 2023 14:05:49 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:48 -0700 (PDT)
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
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 31/34] sparc64: Convert various functions to use ptdescs
Date:   Mon, 12 Jun 2023 14:04:20 -0700
Message-Id: <20230612210423.18611-32-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
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

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..105915cd2eee 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	return (pte_t *) page_address(page);
+	return ptdesc_address(ptdesc);
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static void __pte_free(pgtable_t pte)
 {
-	struct page *page = virt_to_page(pte);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.40.1

