Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B605A7CFBDE
	for <lists+linux-arch@lfdr.de>; Thu, 19 Oct 2023 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbjJSOCJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Oct 2023 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjJSOCI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2023 10:02:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EBE131
        for <linux-arch@vger.kernel.org>; Thu, 19 Oct 2023 07:02:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32da9ef390fso3877435f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Oct 2023 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697724122; x=1698328922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYapP8IUUxaJFtFuPCmZusI+AtIHAeMa/0OE5NMEm0Y=;
        b=hpIRfi1vLAjLTlBYReNuIW6B6fkPZugPJCqCj9Y4qWrwQJE7dTeu6xpIfEdzsjmzMS
         AwEhEjV2fl2q6KCC9Ho+L/3ChJ83ExkkiDjJVSa0MoZHBuygDI1kJEocyfeQi0bkZ94w
         JBhfSZMwkmvarrng9Bj7ynFLddEE50YTYS/rs+Qv8ajTRs3c1sBPy1ubzFCFsWBe37mT
         hNx/fQsUWY8puxIX6xdkl8QZbzwNkC2atHXTukGvlVg5w6SFykIBWBcby3BKJyY/c7wE
         GwS08n3JDNZPXXzYQrWziVJIXWKOCdwBvEajiw4t7wkqDiz/0RmCLDK/F4kKs+UTS+xC
         1AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697724122; x=1698328922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYapP8IUUxaJFtFuPCmZusI+AtIHAeMa/0OE5NMEm0Y=;
        b=b2vTEeA1hcjYgIb6uUFF9zFJwf9e92qEul9NgXnzQ+dIK7v7EWmrFwIU9OngFtOj/d
         ZeLNcN6T2JPoqIrUIIOG4TLtwjlhIEPeJ5Dzs61/Z1eTsjadTLXfjaDo14lB622MPEa7
         kuUZp2FVjGG9/n8ChL99uVcKzrci4OC4OWQEdb7pG4F2eNEO2vFi50Zq57wlgCXLNDlM
         3VnqXscXf3o26Pab/8uVzw15oQi+DVAVFUHl5TdgR7iwExIGWUrpxVuLDc3bSIUSIwWM
         R4rq7Vm8P1M5tZsyJ6hcXHyqGSnBjPK6Dpq4l2imf+URtLWMVH2LdMhgtQ6f7nf0Ycki
         wqrA==
X-Gm-Message-State: AOJu0YzrOAUnMXdgCZtO73is2otQZfusaK+Ms5Hda8RIsVTibFL1rnmn
        Y7vN7DVaa7/HuMtkUv3zvuemfw==
X-Google-Smtp-Source: AGHT+IHxfbIAtPpTWfqvyIaAWohPN03476Ru2wycW4vXZu6twctXJ/42I8ftrwVedoleNr+FF1TXMA==
X-Received: by 2002:a5d:4561:0:b0:32d:a827:d0fb with SMTP id a1-20020a5d4561000000b0032da827d0fbmr1817267wrc.27.1697724121113;
        Thu, 19 Oct 2023 07:02:01 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b16-20020a056000055000b00326f5d0ce0asm4598711wrf.21.2023.10.19.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:02:00 -0700 (PDT)
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
Subject: [PATCH v5 0/4] riscv: tlb flush improvements
Date:   Thu, 19 Oct 2023 16:01:47 +0200
Message-Id: <20231019140151.21629-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 arch/riscv/mm/tlbflush.c          | 184 +++++++++++++++++++-----------
 5 files changed, 147 insertions(+), 95 deletions(-)

-- 
2.39.2

