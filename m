Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AB5FAAE1
	for <lists+linux-arch@lfdr.de>; Tue, 11 Oct 2022 04:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJKC6q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 22:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJKC6i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 22:58:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E15F9B7;
        Mon, 10 Oct 2022 19:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67028B81100;
        Tue, 11 Oct 2022 02:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3EDC433D6;
        Tue, 11 Oct 2022 02:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665457115;
        bh=+q/h7spp083fZsPKEx6K7lDVOv1DXVlmu5JSmvPaSIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhiMFwFELYCpWPSG/+p9rIMh/LRq/4TUOC4FiJrPAQ/SA+9061+02IxoZynf4qfhv
         ig5vf4RFqTXlHjCK4/j+OFC9UYsEwz88o4EmChGemUN3/uBYbf73RbeoFHZ9otLS9O
         MTw+AxRmyWAIqh9lS5tjD8kC6A73mDPB1X9jFqQCt8sK4uzHRIP8CKx89L3v8fW3wO
         cQ3iFnIZqk3hOjwIov9cGKqn2A/7f4p12EOX3pvrg7F5sA1MwriqNlOKAjgx6q/cwT
         w6SZm4Yx48AH5JFHTspUeo1rdOa8aHuRsFXscmqOmPT2VMnSbDK3KX7CQTCEaKZOkS
         Yf3Z7G8gDvqag==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     lyj7694@gmail.com, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 1/3] docs/memory-barriers.txt/kokr: introduce io_stop_wc() and add implementation for ARM64
Date:   Mon, 10 Oct 2022 19:58:07 -0700
Message-Id: <20221011025809.25821-2-sj@kernel.org>
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

    d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 75aa5531cc7d..96b4162989a0 100644
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
+     이 매크로 앞의 쓰기-결합된 메모리 액세스들이 매크로 뒤의 것들과 병합되는
+     것을 방지하기 위해 사용될 수 있습니다.
+
 =========================
 암묵적 커널 메모리 배리어
 =========================
-- 
2.17.1

