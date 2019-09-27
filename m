Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 063E5BFD74
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2019 05:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfI0DDQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 23:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfI0DDP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Sep 2019 23:03:15 -0400
Received: from guoren-Inspiron-7460.lan (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34447207FF;
        Fri, 27 Sep 2019 03:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569553395;
        bh=1xp6jXQw6QmaMFMbYAUaFcPgQ6zsmGdlTLA/DF77qmE=;
        h=From:To:Cc:Subject:Date:From;
        b=0xunrN9hh2ukZUHvWT5t+tXHyS3+GAgeBCeL+3BZqrrlvxgJcdtrFf5By1GhhvQUw
         k+fL0GAO3xkl0dGDWVZMPVbCbCkWj+5q8vg4r6NLRS7cXHIF0ZALIMhtAioKhEmSey
         T3P/e6+DvxdNKsTaxqpqCiHRsh2WKo7gnw3Hx7T4=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, Mao Han <han_mao@c-sky.com>,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: Fixup csky_pmu.max_period assignment
Date:   Fri, 27 Sep 2019 11:02:59 +0800
Message-Id: <1569553379-11327-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mao Han <han_mao@c-sky.com>

The csky_pmu.max_period has type u64, and BIT() can only return
32 bits unsigned long on C-SKY. The initialization for max_period
will be incorrect when count_width is bigger than 32.

Use BIG_ULL()

Signed-off-by: Mao Han <han_mao@c-sky.com>
Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 4c1a193..7570109 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1306,7 +1306,7 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 				 &csky_pmu.count_width)) {
 		csky_pmu.count_width = DEFAULT_COUNT_WIDTH;
 	}
-	csky_pmu.max_period = BIT(csky_pmu.count_width) - 1;
+	csky_pmu.max_period = BIT_ULL(csky_pmu.count_width) - 1;
 
 	csky_pmu.plat_device = pdev;
 
-- 
2.7.4

