Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA26E533E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjDQUzt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjDQUxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4096140FD;
        Mon, 17 Apr 2023 13:53:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w1so4515600plg.6;
        Mon, 17 Apr 2023 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764806; x=1684356806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1imWRfaXT28Tln454VWhUpR4BzNKR6UHESFdZqWEUY0=;
        b=bMzg27GqJpInZYbq5g7DlCbGyMQLVTO8/WaIXUjb9+Y1sP2Yg8U4pzTwcvHRDHiFNW
         xnksAVwNdJxrKURy2fgxnULAI227N9ToKvbiocqPRvOKs7RzP8ExmOpSZqrcqZUrdfu0
         Ly3bYv1kY3GNKQVg3ZctvJCnyIezYAOXblSfIzPoK3U4x0lQOFf2Xm+WIvk4tnnJrN+1
         YHPfjXznGMNehBha6m//o8BZSI/Chio1eErrXl3QeUgRmQPwnQk3cvQT2roiB3zkJZil
         tzHED45+1PigKvsFpmle9q7jl79yHSt/NZKlZjrviShfr3b19IL3cewZ6zZfWBjcahF9
         kN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764806; x=1684356806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1imWRfaXT28Tln454VWhUpR4BzNKR6UHESFdZqWEUY0=;
        b=LCAj2fHp/ZNZlbd0XBPcDcoH8pqghclANhern1hzggJO6zplL3xtT/fxbK0xmdin/1
         AUzHK1zy4kkOjW4NMTKqNxtLR0FzVG5PiqF+YYn5d2VNCawbmjn2tNU47BwM2Sm1p8yq
         H43tEFtaDEMHD0YQEK0w08uhtm0ElPa6Tq9qPny+pDOqcZ6EVX6bSwUCoTM6xbaI8BkR
         8PJkNC9HeYbbdSthiC8tflTm6lAliuF/tVqR0AoET+4p34VZFW35rCAhg3Z32mPY+1KA
         6JnPVqh9RHT4FFRPvsqigyaFFqvg3to0H/e3DoOpjnQdyrIglDgC3vXE8a2E1MrFaIgI
         DzSw==
X-Gm-Message-State: AAQBX9feLgC1kXpJ1J641N0+AVaYgufLNphC8nt+caCf/32FyJcwPFiE
        o+ctAgVlC+OzA91iYqR5EBE=
X-Google-Smtp-Source: AKy350Z5+qBQNd0Z/JNfcMKaitdnDjfxbnOB0qE080qoviMZywL0T3VtP+5OcGBInDjHaerFJSFHYg==
X-Received: by 2002:a17:90a:d142:b0:246:5fbb:43bf with SMTP id t2-20020a17090ad14200b002465fbb43bfmr15902207pjw.4.1681764805699;
        Mon, 17 Apr 2023 13:53:25 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:25 -0700 (PDT)
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
Subject: [PATCH 29/33] sh: Convert pte_free_tlb() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:44 -0700
Message-Id: <20230417205048.15870-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
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
---
 arch/sh/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..30e1823d2347 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -31,10 +31,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
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

