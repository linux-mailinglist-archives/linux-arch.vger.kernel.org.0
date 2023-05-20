Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0244B70A4A0
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 04:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjETCaz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 22:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjETCaz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 22:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3461B0;
        Fri, 19 May 2023 19:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 672D365B1A;
        Sat, 20 May 2023 02:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF210C433EF;
        Sat, 20 May 2023 02:30:49 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org,
        Jun Yi <yijun@loongson.cn>
Subject: [PATCH] LoongArch: Fix perf event id calculation
Date:   Sat, 20 May 2023 10:30:00 +0800
Message-Id: <20230520023001.3491257-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LoongArch PMCFG has 10bit event id rather than 8 bit, so fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Jun Yi <yijun@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/perf_event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index ff28f99b47d7..0491bf453cd4 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -271,7 +271,7 @@ static void loongarch_pmu_enable_event(struct hw_perf_event *evt, int idx)
 	WARN_ON(idx < 0 || idx >= loongarch_pmu.num_counters);
 
 	/* Make sure interrupt enabled. */
-	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base & 0xff) |
+	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base) |
 		(evt->config_base & M_PERFCTL_CONFIG_MASK) | CSR_PERFCTRL_IE;
 
 	cpu = (event->cpu >= 0) ? event->cpu : smp_processor_id();
@@ -594,7 +594,7 @@ static struct pmu pmu = {
 
 static unsigned int loongarch_pmu_perf_event_encode(const struct loongarch_perf_event *pev)
 {
-	return (pev->event_id & 0xff);
+	return M_PERFCTL_EVENT(pev->event_id);
 }
 
 static const struct loongarch_perf_event *loongarch_pmu_map_general_event(int idx)
@@ -849,7 +849,7 @@ static void resume_local_counters(void)
 
 static const struct loongarch_perf_event *loongarch_pmu_map_raw_event(u64 config)
 {
-	raw_event.event_id = config & 0xff;
+	raw_event.event_id = M_PERFCTL_EVENT(config);
 
 	return &raw_event;
 }
-- 
2.39.1

