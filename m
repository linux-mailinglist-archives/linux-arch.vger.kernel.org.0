Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE01B79B77F
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjIKVFt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbjIKNMd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 09:12:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72425EB
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 06:12:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso4124642f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694437947; x=1695042747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YAch9/9+1yvRN3ndGGQdZRoEnDN1q2q/b1WTFSVL2jQ=;
        b=DLB9EleNu2nLF5k+wH113UHOr7GWO+eKdBm2GQIPlTqgJV++UN7c95A8nMZzLWQPT5
         hWfIQMDM9gHvz/e/Y//UIufY8VSSBRCaiQiAuU3gwPlmFn6qgoz0ZdZUKk/YbIX6i8fg
         nloNfmVWhDttwpkm1TAhTre55EnKis3AVyfpq8s4APqwBky6t1yTTFJU9hLU86geV1aS
         7Dl+MeASqmwAVvRs0TUtkEAYS8eOeSaB/1VU0buCqyczZe8laC3YcRywj6/dH6yskZr3
         Wa9AkY+CcRG8IGG3p3QAWn/u2H4zqfv0aaaYRMAfBGg0/vjguf4r3eomyM2WDCn4uN1b
         el0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694437947; x=1695042747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAch9/9+1yvRN3ndGGQdZRoEnDN1q2q/b1WTFSVL2jQ=;
        b=WCKMNh7L/xb6L5CAywmeJeHCgxeqoLN35wsX/gk7esHI9DDGkerBfkIWmkqy9Q8sWq
         sNLuSg8tJDa+ks2bBsX6DJKep9nlZY5WiJa0LvLBhSaW5f1c4I/RMgYBZkeK5t7jz3te
         e5eZoO0AWtmk3ghuW99fRoAcEk5UVSErk0hpOJ0zmqmbRDty1mPI47KJ1IGEorGPrbUf
         xbSjnn3RrzNibhDoiTPqqKNcYm/NoSxBFe+g1MznV4wmQ2VvPz4WETG2kvjZ4YqprOcx
         9gwswiKSE7nRcA2KKt7o8F/mjGDYkMgftoJDESJesV7Fv7roabDw4WYaAyKXzLPPM44l
         Z0ww==
X-Gm-Message-State: AOJu0YxctJFyItliDrWwtdS5wBEqwuB+J7nAsJo9hB/TRGLoolFd7ajM
        l+N8L8zPxroDa3sfD06W64+T4g==
X-Google-Smtp-Source: AGHT+IEo8vfSE/53LIIg4K2AfasH/DaM1jP5FLSKYkUJRorFSpro0cfH84Iowld11wYazbHz32ri/Q==
X-Received: by 2002:a05:6000:1101:b0:317:650e:9030 with SMTP id z1-20020a056000110100b00317650e9030mr7641721wrw.57.1694437946629;
        Mon, 11 Sep 2023 06:12:26 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id r17-20020adfce91000000b003198a9d758dsm10104895wrn.78.2023.09.11.06.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:12:26 -0700 (PDT)
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
Subject: [PATCH v4 0/4] riscv: tlb flush improvements
Date:   Mon, 11 Sep 2023 15:12:20 +0200
Message-Id: <20230911131224.61924-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
  riscv: Improve flush_tlb()
  riscv: Improve flush_tlb_range() for hugetlb pages
  riscv: Make __flush_tlb_range() loop over pte instead of flushing the
    whole tlb
  riscv: Improve flush_tlb_kernel_range()

 arch/riscv/include/asm/sbi.h      |   3 -
 arch/riscv/include/asm/tlb.h      |   8 +-
 arch/riscv/include/asm/tlbflush.h |  15 ++-
 arch/riscv/kernel/sbi.c           |  32 ++---
 arch/riscv/mm/tlbflush.c          | 192 ++++++++++++++++++++----------
 5 files changed, 155 insertions(+), 95 deletions(-)

-- 
2.39.2

