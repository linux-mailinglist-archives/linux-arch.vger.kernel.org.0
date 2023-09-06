Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8C7934A7
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 07:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjIFFBs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 01:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjIFFBs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 01:01:48 -0400
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 22:01:44 PDT
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B048E;
        Tue,  5 Sep 2023 22:01:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.141.245])
        by APP-03 (Coremail) with SMTP id rQCowAAnLKAuBvhkIAchCw--.41703S2;
        Wed, 06 Sep 2023 12:55:11 +0800 (CST)
From:   sunying@nj.iscas.ac.cn
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        pengpeng@iscas.ac.cn, renyanjie01@gmail.com,
        Ying Sun <sunying@nj.iscas.ac.cn>
Subject: [PATCH] include/asm-generic/topology.h: remove dead code cpumask_of_node macro
Date:   Wed,  6 Sep 2023 12:54:49 +0800
Message-Id: <20230906045449.15110-1-sunying@nj.iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAnLKAuBvhkIAchCw--.41703S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryUAFW8KFW7ZFyDtFW8Zwb_yoW8Gr4xpF
        n5GrWYkws5JFy8Cay0v3yvkryjqFZ5GrZYqa1j9ws3AFy7Jw18Xr1qvrsxZryDWrZ2vrWr
        JF95GF1Sg3W2yFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv214x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
        c2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUUuyIUUUUUU==
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ying Sun <sunying@nj.iscas.ac.cn>

The macro of “cpumask_of_node(node)” in line 49 is a dead code
which will never be implemented，because its conditions of
line 30 "#ifndef CONFIG_NUMA" and line 48 "#ifdef CONFIG_NUMA"
are mutually exclusive. It is recommended to delete redundant code.

Suggested-by: Yanjie Ren <renyanjie01@gmail.com>
Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
---
 include/asm-generic/topology.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index 4dbe715be65b..8fcc95953e70 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -45,11 +45,7 @@
 #endif
 
 #ifndef cpumask_of_node
-  #ifdef CONFIG_NUMA
-    #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
-  #else
-    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
-  #endif
+  #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
 #endif
 #ifndef pcibus_to_node
 #define pcibus_to_node(bus)	((void)(bus), -1)
@@ -61,7 +57,7 @@
 				 cpumask_of_node(pcibus_to_node(bus)))
 #endif
 
-#endif	/* CONFIG_NUMA */
+#endif	/* !CONFIG_NUMA */
 
 #if !defined(CONFIG_NUMA) || !defined(CONFIG_HAVE_MEMORYLESS_NODES)
 
-- 
2.17.1

