Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E852773422
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjHGXIc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjHGXHL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:07:11 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC931FEB;
        Mon,  7 Aug 2023 16:06:17 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso5116784276.0;
        Mon, 07 Aug 2023 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449557; x=1692054357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/qh+9u1BcCIl2V5thva5G2rletbRXaxfcBgzJGGgXU=;
        b=pCbA+UxrLZ96Iu/LappjpSZmLEozYOYmdO5RTxaM7BlCH20e3MEhp3Bn4lGiK7HrnF
         zI5vTymTyexPs2fEWKMf3YOixGPBtUiqT1+gX7fLWBa+Q9gs2M2cYtqmojJG+cqpxy8a
         yiuXYP2euWfRpeTnK/Ph7t69G3h70UOk68zLodvepBaU3Ub4ZFK2KFzJhB7TlCbjRGdX
         ie8hnx40ZzCuPRz3xDX8QGC9rAdvd3I0ubBMPCct9yJ64tgNkqrnZ4vxqqMZLVPIiaaP
         rYqmFrrQlxG0A3en5YH5Vcd7HyjhL8swCun/14090vxoeSz0eujRX7UW9eNuwqOQts53
         n0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449557; x=1692054357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/qh+9u1BcCIl2V5thva5G2rletbRXaxfcBgzJGGgXU=;
        b=iNcXzuxp1fznxU1DohhOUAMN0DmqpzyPzEKA8je5gZajgOpZEwKk981dxXf3GBeqZR
         ZthPpAyUk4SHH2A63X+hbBAccchWDcEmqwKa9L7hv/FzkhEkLNWdemsMJ50DVs5xqP7x
         VZKTpJzLFvlQTv1geKOtHDSgpwfdJDNjQsKffF5kBwbM0tJfH391AfXjmkUlZTPNn3Pe
         EXgN0Xfg9OU7EFQOQxhvLbkjbKw/ZVlS97o6NRyEORrIGI7usP9BSztULU1DLHBPfxE/
         t6nCkNF4SScgPjufEvbI+8niHbxOGY9wHsruq6B+2MCAZMcTah/cTDmaJAvCsc6cadq1
         VGLA==
X-Gm-Message-State: AOJu0YwiDWbfGcVp41LI7Wed0Aie9SIU6tdl4gh7mYxEfaz19x6Zh1i0
        DK6NlK8eKc6JGQb/vIzcOf4=
X-Google-Smtp-Source: AGHT+IGb7qTBQz9qcaNa56xxCbdxPZmnKDiha96eaUPQlL4XzY5YUB1UJSqCKxKHPrzOS/VVDboJfg==
X-Received: by 2002:a05:6902:4c4:b0:d0f:65db:dc0e with SMTP id v4-20020a05690204c400b00d0f65dbdc0emr10052463ybs.39.1691449556886;
        Mon, 07 Aug 2023 16:05:56 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:56 -0700 (PDT)
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
        Guo Ren <guoren@kernel.org>, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 19/31] csky: Convert __pte_free_tlb() to use ptdescs
Date:   Mon,  7 Aug 2023 16:05:01 -0700
Message-Id: <20230807230513.102486-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/csky/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5da0914..9c84c9012e53 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page(tlb, pte);			\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
-- 
2.40.1

