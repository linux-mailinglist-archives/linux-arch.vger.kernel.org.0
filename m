Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8276AB5B
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjHAIyJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 04:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjHAIyJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 04:54:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC51724
        for <linux-arch@vger.kernel.org>; Tue,  1 Aug 2023 01:54:08 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b703a0453fso81107891fa.3
        for <linux-arch@vger.kernel.org>; Tue, 01 Aug 2023 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690880046; x=1691484846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FuFY+PU6PxR5OxRRJWZPtIcTMAd1Hge6WKSDMNvcYEM=;
        b=TGom4Wp+0Jnfkmkgk7rmKJspecEM9eWKO0+p+TFJ5nr6xqU7LBDQ/rZzpgdTd8/n4G
         FGDmh+XTHh9ALXh5fsOpY0bKm5fLn4AExNOwOt/0z2eBJN7Vx4XFBvLOzfe708H7c8Kw
         tUqu7FExHnJLdQALNl/A9cDb+g4wGYflPZSTwD50mcCGFiN2ZGwFrBT9iJAblX/uLc6S
         5lxRW9dFyOtjn0lCjIiBBPmwkd+hnXnThI+Z/VtDP0Zi+Qefnt9kuoGv9CMIpPsfE9KU
         W6mOuGjME8hAqZ4gmxEwlCviZqNHRpr5/uLTWHe9+04HmjRMjUsy4jAbU4J8BA/987EF
         DreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880046; x=1691484846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FuFY+PU6PxR5OxRRJWZPtIcTMAd1Hge6WKSDMNvcYEM=;
        b=V+yeVAMGikmimJzLidx45cZElUB5am/r+2ASkkei/eXxJ3QWGGv/vCjB9z8OBsuuFv
         ZUDNAZfSV0xPA/66bL6Umh14cE5dm+Ol7sBE2T/69MUIG6x7Pj2RyhSAHIO9KYXQjeRz
         8R7bFXvhh8p8j+IFg/gOke7zwKmjb55lG5nEqeFpw/m0Gc9tGXbK3GeQXB6CR3FB43yi
         3LdZOUnqCWCp42JiPxuQMycRY3xQyJG7VM44POU7mP+hXrX5IlubOnp6D/w+3CUjckSG
         jp+jkSVay6Cr5PBCHLsmymtFabw7sLON55NQo13yZNWU5yiDPPDX+v2ypUgXiHDpTYL+
         /P/w==
X-Gm-Message-State: ABy/qLYSuN7xkeONJQXbVGo3vi/qhjQCj34fPkyoFFC0fQj9Kz6P8OpA
        uye6N4MsYVDm0h33Ez8AKdhU6w==
X-Google-Smtp-Source: APBJJlHFJHk7dxJUGfF3nocomaie6wll22GTa1EEA2Nfjcr9TB9jb7ZOAYLSPe0NEAsx7q+L87fvVg==
X-Received: by 2002:a2e:b048:0:b0:2b9:e230:25ce with SMTP id d8-20020a2eb048000000b002b9e23025cemr1743884ljl.12.1690880046138;
        Tue, 01 Aug 2023 01:54:06 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n7-20020a7bcbc7000000b003fe2120ad0bsm4869297wmi.41.2023.08.01.01.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:54:05 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 0/4] riscv: tlb flush improvements
Date:   Tue,  1 Aug 2023 10:53:58 +0200
Message-Id: <20230801085402.1168351-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
  riscv: Improve flush_tlb()
  riscv: Improve flush_tlb_range() for hugetlb pages
  riscv: Make __flush_tlb_range() loop over pte instead of flushing the
    whole tlb
  riscv: Improve flush_tlb_kernel_range()

 arch/riscv/include/asm/tlb.h      |  8 ++-
 arch/riscv/include/asm/tlbflush.h | 12 ++--
 arch/riscv/mm/tlbflush.c          | 98 ++++++++++++++++++++++++++-----
 3 files changed, 99 insertions(+), 19 deletions(-)

-- 
2.39.2

