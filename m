Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72985FAADD
	for <lists+linux-arch@lfdr.de>; Tue, 11 Oct 2022 04:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKC6i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 22:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJKC6h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 22:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E1A5F9B7;
        Mon, 10 Oct 2022 19:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E6EE6108D;
        Tue, 11 Oct 2022 02:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5392AC433D7;
        Tue, 11 Oct 2022 02:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665457115;
        bh=aVcrvy3o9Fi5GQp2mJLQFTz455k5JRw2I8ApU+G0WYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiHYR+EeC9KxjObqw1vuvNPclsCTCh6KcNNpQ3CMsRcTEVD0vBVlDiCP08SwFP28C
         WNFvD1YqoyT3FQVlmu4DbV2P2jNIsqImdDEev/9Ty5Ng0WAclmeQ1rXveUGs+olRrt
         6LsvhcW0fYa9ByAsA6qVMaJlXF6bPAI7uhWpME18MDZ4g1OQwKaqdkps++61lF1c3L
         VYnUbgt7iEEyFsUARTTFGdQEFKgV0hTU6OGkPESNvDuk39QFiAN9dfiAm0/pHZ8XWX
         m+krQ1NRAwRLWUj4LVeHQVQoidTq50Zzl2hY6jaPx0GGW6qDGzt/2FaSyTQzBoXLeO
         eEIA1/SRKWSIQ==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     lyj7694@gmail.com, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 2/3] docs/memory-barriers.txt/kokr: Add memory barrier dma_mb()
Date:   Mon, 10 Oct 2022 19:58:08 -0700
Message-Id: <20221011025809.25821-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011025809.25821-1-sj@kernel.org>
References: <20221011025809.25821-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Translate this commit to Korean:

    ed59dfd9509d ("asm-generic: Add memory barrier dma_mb()")

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../translations/ko_KR/memory-barriers.txt         | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 96b4162989a0..38656f6680e2 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1863,6 +1863,7 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
 
  (*) dma_wmb();
  (*) dma_rmb();
+ (*) dma_mb();
 
      이것들은 CPU 와 DMA 가능한 디바이스에서 모두 액세스 가능한 공유 메모리의
      읽기, 쓰기 작업들의 순서를 보장하기 위해 consistent memory 에서 사용하기
@@ -1893,12 +1894,13 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
 
      dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
      내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
-     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  참고로,
-     writel() 을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory)
-     쓰기가 MMIO 영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에
-     wmb() 를 실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이
-     저렴한 writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지
-     않아야 합니다.
+     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  dma_mb()
+     는 dma_rmb() 와 dma_wmb() 를 모두 내포합니다.  참고로, writel() 을
+     사용하면 캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 MMIO
+     영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에 wmb() 를
+     실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이 저렴한
+     writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지 않아야
+     합니다.
 
      writel_relaxed() 와 같은 완화된 I/O 접근자들에 대한 자세한 내용을 위해서는
      "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
-- 
2.17.1

