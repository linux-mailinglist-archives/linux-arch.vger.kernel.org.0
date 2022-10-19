Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1C6053BC
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 01:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiJSXHJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 19:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiJSXHD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 19:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7261D81A6;
        Wed, 19 Oct 2022 16:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF826192A;
        Wed, 19 Oct 2022 23:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A769C433D7;
        Wed, 19 Oct 2022 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220813;
        bh=FO4LBH34dFMItWB2oqwRSLP1nPIuZLdJvb2fC81Bm7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HusP17eYqH7WYMPOasakXP0I7Ax68VtI9CwcmJ5yXSNRXXYqmui/kM9o7PUy8JbG6
         CwS5WZWt0F4FXqR82QIYgkbzoeH2OQkaGHmySno9xXCLRA1ikOFButISKBRvh9sOvs
         nVZKzuxvswXUNoSjdmIkdXKZOvs1oxID5iZ/uJ2DRdDoK+qZAD/qXDONAUKEElAss2
         a/Zyk5Lv1ho1tCo5VxDgHmgzQBekp+2f4frKHvOsr/pD9XUlZtm5rvVogJc8rEiRzS
         blEKOesuzdWF5ia61hBuHZu1iMah9NDyTo6tFf8k8qRMO9Iq6CLVJuzFpO8MHG8SsI
         jasNe7Oi0Fa4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 047985C0920; Wed, 19 Oct 2022 16:06:53 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, SeongJae Park <sj@kernel.org>,
        Yunjae Lee <lyj7694@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 4/5] docs/memory-barriers.txt/kokr: Add memory barrier dma_mb()
Date:   Wed, 19 Oct 2022 16:06:50 -0700
Message-Id: <20221019230651.2502538-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019230640.GA2502305@paulmck-ThinkPad-P17-Gen-1>
References: <20221019230640.GA2502305@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

Translate this commit to Korean:

    ed59dfd9509d ("asm-generic: Add memory barrier dma_mb()")

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../translations/ko_KR/memory-barriers.txt         | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 96b4162989a0d..38656f6680e23 100644
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
2.31.1.189.g2e36527f23

