Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B45718D0A
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjEaVfC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjEaVeS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:34:18 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250E2E5E;
        Wed, 31 May 2023 14:32:53 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-568ba7abc11so714497b3.3;
        Wed, 31 May 2023 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568732; x=1688160732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxwTfn+1WulDyktO0TSvPUm3DeZmyyKIR9rdY3Tk+MA=;
        b=L4jsN9kH5t72hj91BgcxrEjxGpFvV+qs5I3bkyZBlk1og0Opgec9qEsIK7FrraEHx2
         1n1HXytspMZRcqAu6IErIg00HRKEQlSU5ge+vaCFc1Gqlt4Qy7JKfOaB6sQJmWGwoAk1
         ee2W8IRVTtbl/idUF0z1LRlcPjUT7a6tY+VOsk0Iu1C+hZh22D5V07hzjpJteBVx3v1W
         ZI/MBAiirrh/1wAfUDPooe/ZARW8FaFD8bCYxc4nZtEdbMeu9sESBKz6utwpFa1EL+di
         5AtPWE2kRx/FV4woLekgALaQYhp02WG5GHPy9VCjhu9orzHIF3v5vTBp+/fCu2h+nW96
         ROmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568732; x=1688160732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxwTfn+1WulDyktO0TSvPUm3DeZmyyKIR9rdY3Tk+MA=;
        b=iTFz/R58iZ9KdHxDDfUqMkfGVxEY78ttQyeDX8XqViJsD/e/5d/fzMWXHf9Cp1wLPO
         Qok6zdmQLeHT6Zlzbvo0kV5uMSAgLQOXuOvBTHKgDbU9Rg6TNecwyQyYHNfE8iAkOsPw
         JNzAcurJIsTrAY/Sam++8EN9oZGDcMmGhpNF2ZO200jb7GAR8FUiifsB3s7RLensc1DB
         j8teRUrrLSzlsNi52dCe/DpJQCN+W06zkptp246FqXLaIy52aA+YHCN8XB7+OveYtCvb
         KpcCi6IwMpyKzFb2MEBom9qrTwrr3Ze67RkFYlia+j4xQTujV3nRRWdimCDjrK9Dgi8b
         ESBg==
X-Gm-Message-State: AC+VfDyOX97En4zn9ksCk4rCFMx6jkIfYgWphiVVZr/TUiEezIVu3Urx
        IvGH/fpk7ZTiicDYM5wn/G4=
X-Google-Smtp-Source: ACHHUZ7+/nVY5dy5ww7MvRpp2ZVq2XpqSkLFoFJGuLgsQ62NeKnra3AVED33Ph7R+tcYIq7VRl7QLw==
X-Received: by 2002:a0d:eb83:0:b0:561:3fb7:1333 with SMTP id u125-20020a0deb83000000b005613fb71333mr7209246ywe.43.1685568732564;
        Wed, 31 May 2023 14:32:12 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:12 -0700 (PDT)
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
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 32/34] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date:   Wed, 31 May 2023 14:30:30 -0700
Message-Id: <20230531213032.25338-33-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
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

