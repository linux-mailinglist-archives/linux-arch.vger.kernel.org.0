Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A38765BB6
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 20:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjG0S4F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 14:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjG0S4E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 14:56:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31E9E47
        for <linux-arch@vger.kernel.org>; Thu, 27 Jul 2023 11:56:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso14452365e9.2
        for <linux-arch@vger.kernel.org>; Thu, 27 Jul 2023 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690484161; x=1691088961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FhI2SLAGzFPgM0XDlLYh3qjUrSBQmA+KXnizzmLufc=;
        b=UEbP1zqhCFEiTaUL5idLu7vKPg1UFl76YwNFzxk+gTjDjuwDufCyOxWIareE7LpI7M
         hQcy4WocH73NHpscnoUE2uao5LPwfT3On28WKOhhuLLnmQgK8lo4dVzqOTGjTi33ALg6
         c0/7py79DrKXQQpO35r81d4LEai/ijN+47oqcZVg/oTep4drF+adrfWVrIMhYBBmOwwW
         qxvwQ4vQ6q+8AyNVn3Mh2geRJmizY2Xeum0eYyg0CTL4wZVWTEVTg/SJ7yek42Ifpb1Q
         vGQsJgw6HlMmZSxtyxv3qNun490/7QiQpcxjaTP1yWWjQtpMhCI8ZcM2CMV4nQfYfzYr
         FQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484161; x=1691088961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FhI2SLAGzFPgM0XDlLYh3qjUrSBQmA+KXnizzmLufc=;
        b=M95xrzgO2nDG2phLRqCZBn2z+4hiGX4ofnkjIxqpBowUXS2aXfQTTFEaIpb2oudp02
         0hMoUW0NZtqCuRhzLfbd3pPTQc0lOoTw0CB2ve5hJpoPYCOTk5JPMz3Vv2N6l8VKAmiF
         iWROS4TcD/gl3vBKIlk+amiwEROX7I/CGXdPRZ+VhaR+AN05UgkBuCn1eiTe/Yp264K9
         kGay6a46j6aqMcayr2UifQVG6OKsjoqHOfla96Vfm0UDqTRu7epm1mQmbgt19qj9EGf1
         8wv7ObDC5Pn2vCl6a+rw/Ss9IQjhIxfbVePTMp8WjKAB4BICYB67y6F8Hgdqbibl4xh6
         CYNQ==
X-Gm-Message-State: ABy/qLYACkQukrrjyhAHWD9oAy/40Zkmp3q+8qZGf8TPEdNrMSWM5weU
        8YK0OGzSQBXBkxofHzZHDJK/Yw==
X-Google-Smtp-Source: APBJJlEReV5Op3Esz4H3z1WgrD5RqflHv8MjR+KBErCwj/H8fcva/UlqbpkT+CFwmLCi+oxSnh262A==
X-Received: by 2002:a05:6000:11cc:b0:317:7af4:5297 with SMTP id i12-20020a05600011cc00b003177af45297mr4780wrx.62.1690484161377;
        Thu, 27 Jul 2023 11:56:01 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b003172510d19dsm2754302wrt.73.2023.07.27.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:56:00 -0700 (PDT)
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
Subject: [PATCH v2 0/4] riscv: tlb flush improvements
Date:   Thu, 27 Jul 2023 20:55:49 +0200
Message-Id: <20230727185553.980262-1-alexghiti@rivosinc.com>
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
 arch/riscv/mm/tlbflush.c          | 93 +++++++++++++++++++++++++++----
 3 files changed, 96 insertions(+), 17 deletions(-)

-- 
2.39.2

