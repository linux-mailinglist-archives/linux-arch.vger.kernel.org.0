Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A637063A0
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjEQJKQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 05:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjEQJKN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 05:10:13 -0400
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 02:10:11 PDT
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44540E5;
        Wed, 17 May 2023 02:10:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.141.245])
        by APP-01 (Coremail) with SMTP id qwCowACXnjKjmGRkEPxcFw--.24827S2;
        Wed, 17 May 2023 17:04:35 +0800 (CST)
From:   sunying@nj.iscas.ac.cn
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ying Sun <sunying@nj.iscas.ac.cn>
Subject: [PATCH] include/asm-generic/topology.h: remove dead code cpumask_of_node macro
Date:   Wed, 17 May 2023 17:04:32 +0800
Message-Id: <20230517090432.19755-1-sunying@nj.iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXnjKjmGRkEPxcFw--.24827S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWDXry7Cw48KryUCr4fGrg_yoWkAFg_Aa
        ykWrZ7K3y8ZF4I9rs0gws2qrn8W348WayrKrn3Kay293WUtr45AwnxGFy3Xw48WanxWry7
        Z348JFsYyFnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY
        02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UY9a9UUUUU=
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 include/asm-generic/topology.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index 4dbe715be65b..34f6d487d31a 100644
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
-- 
2.17.1

