Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D259E6093A7
	for <lists+linux-arch@lfdr.de>; Sun, 23 Oct 2022 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJWNdx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 23 Oct 2022 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiJWNdv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 23 Oct 2022 09:33:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CAC3AE49;
        Sun, 23 Oct 2022 06:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBFB0B80BFF;
        Sun, 23 Oct 2022 13:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11926C4314B;
        Sun, 23 Oct 2022 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666532028;
        bh=QJ7fR+gHywsczUhCwjPOdR2Nl2xq5s+MM7Zax4w8w9w=;
        h=From:To:Cc:Subject:Date:From;
        b=Y22/Nw6qhMXCSnZbqhtnLDFteTfssdSmaPHl1PMAiT1VRJoveIq/uCM0ERbB8h131
         4sDIRXSjSdnNyY8heVMn78H9JBlSjFGUBEzNBN0WfG6fy5paB+J07Rmt/gbax7UpP7
         BbBXon3Yfgn6RQTnKs/LY0SBUtZaGb+YS3fJAAYU0w7GLuiECDx+TjqyQHzDi9a7HE
         cSFn0brFJiP6dK7IAvjvUmrSjQV1XTkxHkBJRYCdzJc0TNOSPuTwin8/la2vRy0naR
         kdb++uEG6YhGrvaVccMsffZPkSKfmY7zRYlHt0hU//YhzCGPtZYTfmnJHnLme2VcPq
         V3M5NIC2fja9Q==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, palmer@rivosinc.com,
        heiko@sntech.de, arnd@arndb.de, songmuchun@bytedance.com,
        catalin.marinas@arm.com, chenhuacai@loongson.cn,
        Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/2] Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP & fixup race condition on PG_dcache_clean
Date:   Sun, 23 Oct 2022 09:32:03 -0400
Message-Id: <20221023133205.3493564-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The first patch fixup race condition on PG_dcache_clean which found in
arm64. Then enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP and tested
with simple hugetlbfs test case.

# cat /proc/sys/vm/hugetlb_optimize_vmemmap
1
# echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
# mount -t hugetlbfs none test/ -o pagesize=2048k
# ./myhugemap_test
# umount test/
# echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

No problem found.

Guo Ren (2):
  riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte
  riscv: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP

 arch/riscv/Kconfig                  | 1 +
 arch/riscv/include/asm/cacheflush.h | 3 +++
 arch/riscv/mm/cacheflush.c          | 7 ++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.36.1

