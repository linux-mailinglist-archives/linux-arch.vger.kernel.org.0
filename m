Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB74B680173
	for <lists+linux-arch@lfdr.de>; Sun, 29 Jan 2023 22:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjA2VSa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 Jan 2023 16:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2VS3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 29 Jan 2023 16:18:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0B27DB4
        for <linux-arch@vger.kernel.org>; Sun, 29 Jan 2023 13:18:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x7so6008846edr.0
        for <linux-arch@vger.kernel.org>; Sun, 29 Jan 2023 13:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+h+DwgC8kZ0XHiwjlH5j80VONawqLGbgf1k0XhI3HtA=;
        b=d2zBLtX4Ok999XFthxBlaBoWXcErjB9PFTYs/5wEai3i5t/qDPilG6Ump2Du/KJQcr
         kKmzsz8JnCNNIw8cqAOXaeFIpbPQRZ6E4hWW/PyvuVsPgDY+OWiyZcnT+Eb9DOtSrzTf
         2f9IoYnmGEHI9N3bqYGa226swI/EeoaZ/BQHblLSGcVtVTfj2sfj4jNdUMN+8C1ofHHe
         jtQ6tKS4/adIGV7VFCyq/0HN6cWpL4D5gDL9Lhhs2KOF023MEkGNNGyo7xawD+SPo5IF
         +AHbPIFSnI3PvvoY8YOsCZkzR9Sso4Hc/Til/qwDqa/TzKb084c+nG35SuLxE6xwP1C7
         AHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+h+DwgC8kZ0XHiwjlH5j80VONawqLGbgf1k0XhI3HtA=;
        b=YFQ0XSnnNY0KJaPLYhZQ7iUNaF0PapHKjyyINU+qJ+5tju3dYgVuKxa7nacZ1/r5WR
         /VyVvyJJD+LuT2ulkWds96+y7YWNaItLn+sK26rO9ovxqEIlZ3qrbmPzisi4u6JxTZym
         GMKH21xulX/4KqV0a2e+u74+Be+TSz6ruWP4tg2anR7uuCKiwxN8hS8BOYmimV0ex0bZ
         7bxMPQeOtWwGLDYuqmjql4ljEqIfqXIyyQPA3+vxA6iiBowfg33NXruB+IROW5vf6VUk
         GdsB8F+WsCXLisyjsYRtRxrE0ZEQQOLOBbFTdnmKMnc+iDp5jcITops0UAVQXEtFRNiz
         nWXg==
X-Gm-Message-State: AO0yUKVpPoCr8pXnELq9PQeHyyYDyw8/nTuv3tYvLZ4lRmAlA2pFkgEI
        oQIPo9ppc0MTKUPWQvcYv4o=
X-Google-Smtp-Source: AK7set/fjghCd6aQ47dcrbqhpVv6288Z8r+fI4E2Ox6BW/liWZcys3t01wTHRsqhbilvWAcyyCxJ9w==
X-Received: by 2002:a05:6402:24a0:b0:4a0:8f4e:52dd with SMTP id q32-20020a05640224a000b004a08f4e52ddmr24043009eda.17.1675027106821;
        Sun, 29 Jan 2023 13:18:26 -0800 (PST)
Received: from localhost.localdomain ([80.211.22.60])
        by smtp.googlemail.com with ESMTPSA id g12-20020a056402114c00b004a216fa259esm3754491edw.60.2023.01.29.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 13:18:25 -0800 (PST)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Guo Ren <guoren@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: [PATCH] riscv: mm: fix regression due to update_mmu_cache change
Date:   Mon, 30 Jan 2023 00:18:18 +0300
Message-Id: <20230129211818.686557-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

This is a partial revert of the commit 4bd1d80efb5a ("riscv: mm: notify
remote harts about mmu cache updates"). Original commit included two
loosely related changes serving the same purpose of fixing stale TLB
entries causing user-space application crash:
- introduce deferred per-ASID TLB flush for CPUs not running the task
- switch to per-ASID TLB flush on all CPUs running the task in update_mmu_cache

According to report and discussion in [1], the second part caused a
regression on Renesas RZ/Five SoC. For now restore the old behavior
of the update_mmu_cache.

[1] https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/

Fixes: 4bd1d80efb5a ("riscv: mm: notify remote harts about mmu cache updates")
Reported-by: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
---
 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4eba9a98d0e3..4c3c130ee328 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
 	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
 	 */
-	flush_tlb_page(vma, address);
+	local_flush_tlb_page(address);
 }
 
 #define __HAVE_ARCH_UPDATE_MMU_TLB
-- 
2.39.0

