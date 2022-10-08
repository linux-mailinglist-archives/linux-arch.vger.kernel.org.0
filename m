Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3415F865A
	for <lists+linux-arch@lfdr.de>; Sat,  8 Oct 2022 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJHRuD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Oct 2022 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJHRtz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Oct 2022 13:49:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49DC1B9F7;
        Sat,  8 Oct 2022 10:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22F39B80B9D;
        Sat,  8 Oct 2022 17:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F6AC4347C;
        Sat,  8 Oct 2022 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665251391;
        bh=FMeXNJfI0IoqbHMQGj/sXCrRP6kNujAnRvsPJGkuog0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKP8dPbRUUzUHnIbZzcnldygWmOoQrcsorn98a9fZc+gqodYR81BY8ZX9S9SdQ04o
         f+/4Itpj2UMW+vJy4KPDKx063ahiT6dIbG6Atqz80GDHRBdmLfbku4grxydqUo0z/W
         AiSTdeDczlM7b3FJ6DeJ9NsQCFGokqzRfbzjLRtiCWxB25DTZvfnkB3WQ6okYTvcwr
         pVQDd0Ugc4LIY5zkSkvaV1F74XY+bjFp9UZ1dW9+tRL3ot80xzbkBBFJagjzvsYHCK
         FgFh/cCP0+Cl4p0s/xPklAQFo++xVvxgMJ4Q8sbxxWErmcQlolu/o6kXthcWAfg3+e
         jWeqlvGAJW4Vw==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/4] docs/memory-barriers.txt/kokr: introduce io_stop_wc() and add implementation for ARM64
Date:   Sat,  8 Oct 2022 10:49:26 -0700
Message-Id: <20221008174928.13479-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221008174928.13479-1-sj@kernel.org>
References: <20221008174928.13479-1-sj@kernel.org>
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

    d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 75aa5531cc7d..1c811b96e8e0 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1918,6 +1918,14 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
      Persistent memory 에서의 로드를 위해선 현재의 읽기 메모리 배리어로도 읽기
      순서를 보장하는데 충분합니다.
 
+  (*) io_stop_wc();
+
+     쓰기와 결합된 특성을 갖는 메모리 액세스의 경우 (예: ioremap_wc() 에 의해
+     리턴되는 것들), CPU 는 앞의 액세스들이 뒤따르는 것들과 병합되게끔 기다릴
+     수 있습니다.  io_stop_wc() 는 그런 기다림이 성능에 영향을 끼칠 수 있을 때,
+     이 매크로 앞의 쓰기-결합된 메모리 액세스가 그 뒤의 것들과 병합되는 것을
+     방지하기 위해 사용될 수 있습니다.
+
 =========================
 암묵적 커널 메모리 배리어
 =========================
-- 
2.17.1

