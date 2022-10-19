Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAF6053BD
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 01:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiJSXHK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiJSXHD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 19:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD31D79A4;
        Wed, 19 Oct 2022 16:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0199D619E8;
        Wed, 19 Oct 2022 23:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D67C433D6;
        Wed, 19 Oct 2022 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220813;
        bh=nhWd5t1o5IYPMyRDspKfa8k81cG6AqyRMnxC35RByvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTNpHs0Kg89gp+DdaWbqIhMe6f+kqN2itBUWt/vxK1bmJLo0PHxG6RNvRK7zgDRDg
         iv9jweLMM77bQDKPOxd/z35JK8AyJMK1+An+SeGVWhrEZ/3yxMU+9Lzj7BK+CGDReP
         h8T4236dujOUvBiPUHEPWIQ0S9Y1WAcgd8XNfnoAEOz69C1MQTTS7pE184xyY1Z8JT
         HT2e/rXya5jMDMFJNSaagJBkeubUGYeGtqsm17ykLhlAzbwYJQoQAh2kEt1pE9OZuB
         IF8yOC9obDZc+rFgO7DNESbRVyszsLsT7h8/dkJGZA0tj2JIP02i/29o47H0nNoOdK
         8LlCm9PYq4b0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01C055C0890; Wed, 19 Oct 2022 16:06:53 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, SeongJae Park <sj@kernel.org>,
        Yunjae Lee <lyj7694@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 3/5] docs/memory-barriers.txt/kokr: introduce io_stop_wc() and add implementation for ARM64
Date:   Wed, 19 Oct 2022 16:06:49 -0700
Message-Id: <20221019230651.2502538-3-paulmck@kernel.org>
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

    d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 75aa5531cc7d0..96b4162989a0d 100644
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
2.31.1.189.g2e36527f23

