Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E173718CB5
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjEaVeF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEaVdW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:33:22 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AE2195;
        Wed, 31 May 2023 14:32:22 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565bd368e19so798997b3.1;
        Wed, 31 May 2023 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568715; x=1688160715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=;
        b=HVGvjPguQLfPfWkiro39nbW+VW4H5uAeLDGXOc+QtDych5ss5NctDwcG9I1c/6SDfz
         APKwygjUx+f7skr0RtKISqSCz+AX9pojhDKoYcMCQyYniYHupBRU0wOHCUoFqOcXQqMh
         s5WPVmf9msAVfThs98QJDhYbBO3Us7PGfZ8s6z4W61niHbKtctIY2nt8en5Qr8xNSORH
         CbV2Bk80OmBOMZ+UG2sJggDfKIMsAz+S52UtEmTBG7rQO3TOu+Ov8Sc+TVK0fDYwDx9u
         QGgal0w97o+Ln3oc2qepS23J75YM3y/Dwt4cq4bO+YUzmRNBHe7fo14HmAPdP2J5Q06p
         Rhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568715; x=1688160715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=;
        b=Qg/C1RSGcMFX5uw7YSBVy2jv+Us5LTcnsSU4QGqQhLA7pGEZGE+K7LE2xK+BG2pnj8
         1LbZZzbL/w82rf1NDkD6BlV7wek3QAH1/hVXE3B2DJfrIJaNnWhsrsmW4pc7vCGIvDLl
         PgyaTS0/ws8vvbej9cYZbkZB3K7reOPo1bseT9N6ENFoMWh9KEcQInDoitcy3OVGAgHS
         3JTR9i/VYuqtOwQxewoJL1GqVw5rx5ds04j9JciBo4EDKvRa9XosADNz/X9vPvW52/TW
         u3H1CVjMOPa12a+gLBJ9/J03KVuIEbos2l+jGofyRfnBuXHiHNU6oAuILzwaApgQlyHf
         8EeA==
X-Gm-Message-State: AC+VfDyH5VG//iFKj6S0VjiasWiXwBfyiPyaeHkLhG2PFyFWkFPlUDsA
        GNinUsa+taS5FxG5+s16WjY=
X-Google-Smtp-Source: ACHHUZ7KZYp2khjpsM/eLpOUxorXRdnAb+nMmuGE16o93fcYthDjjOgaXk5MabZ2W/EzUmWY8vgN2A==
X-Received: by 2002:a81:6f06:0:b0:565:cef7:92d2 with SMTP id k6-20020a816f06000000b00565cef792d2mr6456173ywc.21.1685568714840;
        Wed, 31 May 2023 14:31:54 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:54 -0700 (PDT)
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 23/34] hexagon: Convert __pte_free_tlb() to use ptdescs
Date:   Wed, 31 May 2023 14:30:21 -0700
Message-Id: <20230531213032.25338-24-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/hexagon/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index f0c47e6a7427..55988625e6fb 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -87,10 +87,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 		max_kernel_seg = pmdindex;
 }
 
-#define __pte_free_tlb(tlb, pte, addr)		\
-do {						\
-	pgtable_pte_page_dtor((pte));		\
-	tlb_remove_page((tlb), (pte));		\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor((page_ptdesc(pte)));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1

