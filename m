Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA9769EA4
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjGaRHl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjGaRGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:06:48 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF5C35A7;
        Mon, 31 Jul 2023 10:04:42 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a734b8a27fso605226b6e.1;
        Mon, 31 Jul 2023 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823073; x=1691427873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=J5UHMtA0qoYiWw4Ld5R0BKI4Tc5AGDSmTkXJ2I6fYmBwlIVDq2NZ9TijiKx7n7oR9S
         O2+0XndgcZyKpOow8lUaucDbgGPax/K8O+lCXFcyUW1OtbVxoGLUMUxT+xXe1Nbotguq
         wXQV4F4SfOD9dJwiO/iz9SNiN+CqscWBWqXkI0FM0EZ9ZzfP3bhZCq1/PYVKZkiSL88/
         WlbyA+YZDFKl4pgL1EI3/3iabhB8k7YUgWRxCXqfKPLtTRNQuaY8gnPQjbT+Yt9xzJqB
         tpRwv/UorbhC7cKUIm0hPbznR4XxDKlGiKxb+h0cWPY+2avNMZiADFAVxe8ptEu65tNh
         rVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823073; x=1691427873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=aKSk63aNhtSYrxtnYnPI1lcGRl0eJBUPH8Ua+L1EFke/0enXh1XhT/Xv/rqLD8yEIi
         vl5CBUfAW3nUT4uR/HalQkKZkeFpjf3YqbUlFCiszL361k5Jvo7rJhJYjOcqZMiMR6uc
         +6ddWAs8O4huzAEzqGibU7E2hyXCeNzdl3wyPEc7cUXZUXWHOc9QVzRKHRVrn4X9lc6b
         oMbTlqxoS42O2u6o2lPu/O2uuGo8V/hIC//KapGOPcGkc4IVoi2l47vv2ztAZyZnjmf+
         oAbVffFY6HhXeY8dFpGugcHAchuJY2WI2z9cqZD0NZS5sn2cu9Atd9mtJ3Z6gU75slEh
         yOwA==
X-Gm-Message-State: ABy/qLaXYTJCVKbGPyDhpkTzv4x9gwEZS5ZrGMaojIDh9yuYgnXzEgv6
        azugDkRCv7v0kDoLFqqF6zQ=
X-Google-Smtp-Source: APBJJlFtSPsXmTmbaE2JVTTuMieuMfoOw8pkpK4ugTgdmGfxbA+pL1HJ6fgn2J808MNJLpsNTjXtIQ==
X-Received: by 2002:a05:6808:655:b0:396:4bbc:9a36 with SMTP id z21-20020a056808065500b003964bbc9a36mr8685999oih.19.1690823072749;
        Mon, 31 Jul 2023 10:04:32 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:32 -0700 (PDT)
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v8 27/31] sh: Convert pte_free_tlb() to use ptdescs
Date:   Mon, 31 Jul 2023 10:03:28 -0700
Message-Id: <20230731170332.69404-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sh/include/asm/pgalloc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..5d8577ab1591 100644
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
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.40.1

