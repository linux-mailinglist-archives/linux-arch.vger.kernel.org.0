Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8041E294A
	for <lists+linux-arch@lfdr.de>; Tue, 26 May 2020 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgEZRow (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 13:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZRov (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 May 2020 13:44:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BD7C03E96D;
        Tue, 26 May 2020 10:44:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z15so179969pjb.0;
        Tue, 26 May 2020 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=cljdO69PpR9Yn85c4H83HHV+v26sg/S1OrVInDsaoVw=;
        b=FWh9bm1YuXT403RedcK+86VXJvsCb0P2MBptBQXYBk1gdGqh5ZRtzLZdBD0RB2QuLX
         sj5mkppX/ez+KTGqfQS7sW3Canfg+kY6kZQackLhQH7PmdRuZ5lj+lD8QYuXeWGxD/7a
         DWtr4gNMlD9cG7wwf+FbyhAPHtIIj42I7GK2PVEivppuYX3TsC/j/8YW2y6aob8huntI
         n6EHBAv7GGXP9gOqQ2k+FeKWKjwiwLHI/oZIih3U8qNWrXKMaOZbIubB5A+uvPqYEYz5
         7O1p7JQOwYeUx8dVdyQjACUt4G5xDeBOKUxgmaJpdTH45KnX1aBAqyJJjfWKXrDzE5k0
         T1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=cljdO69PpR9Yn85c4H83HHV+v26sg/S1OrVInDsaoVw=;
        b=BdjjlOswayEH3zCHskibiWQRrgpBAy/6obZS1zOl1N7hF5GE0J8U4i0OOALSKd+o5H
         2xIqslfO30/KJQpVluxpL3yHOPs7F1rYLG2rtVxL6caMLaoWyO3TfQ1X0ao+MTaDdXEQ
         cS01gEmHOu4s7uOgB8OQwrG2YJ11PJsge45+egG1ng+I/rhGRwxIOF1cKQ3L+qTI8QUx
         hCLi4FOE2wY56cTnu5XKUd3RrID8qwTArdXZWTpfjTBvd67/R9k7vtQ1IU/NmtFL0TVu
         TeYx16kHB4ALpsc8WvZPbGV8Y4JKBWftFAS/akPfXmogr0aUJQu+JefVyI4bt4vNwQi9
         jZjw==
X-Gm-Message-State: AOAM532IatWUg6jV4rE2InDQGJlWZCSQv5jQp9EFmDhs3wThLkFbJqO6
        5MiSf1uJJm3mCCK7MQgitio=
X-Google-Smtp-Source: ABdhPJzuTTSGsv729fFf+ylgFAAzqsB1xWHNricjinAGfuWDAkNrPQbkkEcHeCct8y19F+yZbBYg+A==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr2151756pll.320.1590515091291;
        Tue, 26 May 2020 10:44:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u45sm124194pjb.7.2020.05.26.10.44.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 10:44:50 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] topology: Fix cpumask_of_node macro for CONFIG_NEED_MULTIPLE_NODES=n
Date:   Tue, 26 May 2020 10:44:43 -0700
Message-Id: <20200526174443.207610-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following compile error is seen in linux-next if
NUMA=n and CONFIG_NEED_MULTIPLE_NODES=n.

  CC      drivers/hwmon/amd_energy.o
In file included from ../arch/x86/include/asm/cpumask.h:5:0,
                 from ../arch/x86/include/asm/msr.h:11,
                 from ../arch/x86/include/asm/processor.h:22,
                 from ../arch/x86/include/asm/cpu_device_id.h:16,
                 from ../drivers/hwmon/amd_energy.c:6:
../drivers/hwmon/amd_energy.c: In function 'amd_energy_read':
../include/asm-generic/topology.h:51:36: error:
			void value not ignored as it ought to be
     #define cpumask_of_node(node) ((void)node, cpu_online_mask)
../include/linux/cpumask.h:618:72: note:
			in definition of macro 'cpumask_first_and'
 #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
                                                                        ^~~~~
../drivers/hwmon/amd_energy.c:194:6: note: in expansion of macro 'cpumask_of_node'

cpumask_of_node() is missing () around the 'node' parameter.

Fixes: b339752d054f ("cpumask: fix spurious cpumask_of_node() on non-NUMA multi-node configs")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/asm-generic/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index 238873739550..5aa8705df87e 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -48,7 +48,7 @@
   #ifdef CONFIG_NEED_MULTIPLE_NODES
     #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
   #else
-    #define cpumask_of_node(node)	((void)node, cpu_online_mask)
+    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
   #endif
 #endif
 #ifndef pcibus_to_node
-- 
2.17.1

