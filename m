Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440CF7DBAC4
	for <lists+linux-arch@lfdr.de>; Mon, 30 Oct 2023 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjJ3NbL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Oct 2023 09:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjJ3NbJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Oct 2023 09:31:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E68A2
        for <linux-arch@vger.kernel.org>; Mon, 30 Oct 2023 06:31:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c4fe37f166so61820271fa.1
        for <linux-arch@vger.kernel.org>; Mon, 30 Oct 2023 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698672662; x=1699277462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFAyygTf1wEzmKUuixPjgxrlB1EH/ZEG0d5M9D9G9l4=;
        b=bj6OJfEvoOiVZSPCRL+ZtsLck7sx0k4WqXSjA2LAlOmPleXECuhooyWN6SKRsZML6H
         fetwby11m4f9rNDijQP2rYLmceuWxtkaZBXGAlDfR91MjjYHU/1nCQ3Zr6Su1Vqu7606
         zibNunm9X9cvuFVUEr9lmsc7S0UIoDEYApLO+r5yxV5OqpdOZn1j5USs+Pi1OrBWQphb
         ycXm2ZAAZmyk0gu0JAtaKV0781MzrsDqqGmfWpO1LczmQPVzl0VmJclCIsBpmeCthXeq
         yy6iel+Yn9Uf/twQcq0deYWdeHmC5DwfNV2/J+YQc44hpFLnnTJDbrB+0GdQ0Gwqot1R
         NBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698672662; x=1699277462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFAyygTf1wEzmKUuixPjgxrlB1EH/ZEG0d5M9D9G9l4=;
        b=wGNzFqCRZmsDLNO/HXkgz+9bbAlJHG6piT90Ix/vi8u9rww0FVfmQfWzf/la6TyTwH
         i76JO54wueECtqvTBIbRRdlZnjGmLOml0Fb0hE7yTEDxqx1bossMv32PoRJVaMTmeX+G
         Ws7OhBg0atNkB/Skume8dHFHdGxlGgdT3QPljmvYK6XBE0Ace4vVAOuYRCWEdK9Gs0ky
         LWkqqv8RLGeAduhTteo8IDIOKHBquYediqmdfJil6NOl+KR5uGlH2bdJpaySxGDSSElP
         Os7qIQeKgO/2t+e+2gDGUiAOBOInStYq3h8ymsBtQoyMUELkLiXf9b0xQO7EHlrtOnQG
         uGQw==
X-Gm-Message-State: AOJu0YwjScp3sCC03cykc7tYyp+d4gl2yfdlSbQpOVQg93y01SCTpATE
        VmcZvjlKKAaRBJ1yJIRMe7x4Hw==
X-Google-Smtp-Source: AGHT+IGp3Flp6e8u4wQXKFFe94N4J3LW0CdDXYSPeu5D/05PAkg9EMs3NFgFQ+aCgOk5cp4xvQIWmA==
X-Received: by 2002:a2e:a48d:0:b0:2c5:2357:c659 with SMTP id h13-20020a2ea48d000000b002c52357c659mr7665145lji.38.1698672661824;
        Mon, 30 Oct 2023 06:31:01 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id iv8-20020a05600c548800b003fefaf299b6sm9383887wmb.38.2023.10.30.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:31:01 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v6 0/4] riscv: tlb flush improvements
Date:   Mon, 30 Oct 2023 14:30:24 +0100
Message-Id: <20231030133027.19542-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series optimizes the tlb flushes on riscv which used to simply
flush the whole tlb whatever the size of the range to flush or the size
of the stride.

Patch 3 introduces a threshold that is microarchitecture specific and
will very likely be modified by vendors, not sure though which mechanism
we'll use to do that (dt? alternatives? vendor initialization code?).

Next steps would be to implement:
- svinval extension as Mayuresh did here [1]
- BATCHED_UNMAP_TLB_FLUSH (I'll wait for arm64 patchset to land)
- MMU_GATHER_RCU_TABLE_FREE
- MMU_GATHER_MERGE_VMAS

Any other idea welcome.

[1] https://lore.kernel.org/linux-riscv/20230623123849.1425805-1-mchitale@ventanamicro.com/

Changes in v6:
- Remove ifdef SVNAPOT, as suggested by Samuel
- Fix usage of u16 which could overflow, as noted by Samuel
- Use cpu_online_mask, as suggested by Samuel
- Move static_branch_unlikely(&use_asid_allocator) test, as suggested by Samuel
- Add TB/RB from Prabhakar and Samuel, thanks guys!

Changes in v5:
- Fix commit message s/flush_tlb/tlb_flush thanks to Samuel
- Simplify NAPOT mapping stride size handling, as suggested by Samuel
- Add TB from Prabhakar
- Add RB from Samuel
- Remove TB/RB from patch 2 as it changed enough

Changes in v4:
- Correctly handle the stride size for a NAPOT hugepage, thanks to Aaron Durbin!
- Fix flush_tlb_kernel_range() which passed a wrong argument to __flush_tlb_range()
- Factorize code to handle asid/no asid flushes
- Fix kernel flush bug where I used to pass 0 instead of x0, big thanks to Samuel for finding that!

Changes in v3:
- Add RB from Andrew, thanks!
- Unwrap a few lines, as suggested by Andrew
- Introduce defines for -1 constants used in tlbflush.c, as suggested by Andrew and Conor
- Use huge_page_size() directly instead of using the shift, as suggested by Andrew
- Remove misleading comments as suggested by Conor

Changes in v2:
- Make static tlb_flush_all_threshold, we'll figure out later how to
  override this value on a vendor basis, as suggested by Conor and Palmer
- Fix nommu build, as reported by Conor

Alexandre Ghiti (4):
  riscv: Improve tlb_flush()
  riscv: Improve flush_tlb_range() for hugetlb pages
  riscv: Make __flush_tlb_range() loop over pte instead of flushing the
    whole tlb
  riscv: Improve flush_tlb_kernel_range()

 arch/riscv/include/asm/sbi.h      |   3 -
 arch/riscv/include/asm/tlb.h      |   8 +-
 arch/riscv/include/asm/tlbflush.h |  15 ++-
 arch/riscv/kernel/sbi.c           |  32 ++----
 arch/riscv/mm/tlbflush.c          | 181 +++++++++++++++++++-----------
 5 files changed, 144 insertions(+), 95 deletions(-)

-- 
2.39.2

