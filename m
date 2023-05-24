Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4458B70FB00
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbjEXP66 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbjEXP62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 11:58:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8CBE7B;
        Wed, 24 May 2023 08:57:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRG5l41STz4x46;
        Thu, 25 May 2023 01:56:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684943819;
        bh=SibCu5hbkCNZrPVw6RETBvRPo+OI/DYG2D1OFC/b1dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzIdXKHwxxd3j0FduASPcesMjZeYkfSk/g00GGwANuRi+5VTyrdO766gIAOTULPzN
         /98f2t9c+kfBcgveEWZZodfvf2KGTl++qMB1HYBn2XoiF5Yz9CsM1T65V4zhn45qIZ
         IaUB9NswoROgPrF1J1CEI2MTgF+wR3xMTq6A2OgWZiozYhTBFsqes4zEcCIn+DCCt5
         UpWHTXj4ezY5TPaHp1yOnKA0Iq05FnDc9uvz84pMJpLAFQOG/Z1ppaeSnyzOifTRQB
         MDDy+PLYnzxP/mmqtf2dsWpOtRxpAI1BUzRFctT7VQBQoCye8l58BZCuaMLMVEj0W3
         j3cIoZ6bsOzwQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linux-kernel@vger.kernel.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-arch@vger.kernel.org>,
        <ldufour@linux.ibm.com>, <tglx@linutronix.de>, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, x86@kernel.org
Subject: [PATCH 2/9] cpu/SMT: Move smt/control simple exit cases earlier
Date:   Thu, 25 May 2023 01:56:23 +1000
Message-Id: <20230524155630.794584-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524155630.794584-1-mpe@ellerman.id.au>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move the simple exit cases, ie. which don't depend on the value written,
earlier in the function. That makes it clearer that regardless of the
input those states can not be transitioned out of.

That does have a user-visible effect, in that the error returned will
now always be EPERM/ENODEV for those states, regardless of the value
written. Previously writing an invalid value would return EINVAL even
when in those states.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f4a2c5845bcb..01398ce3e131 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2481,6 +2481,12 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
 {
 	int ctrlval, ret;
 
+	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
+		return -EPERM;
+
+	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		return -ENODEV;
+
 	if (sysfs_streq(buf, "on"))
 		ctrlval = CPU_SMT_ENABLED;
 	else if (sysfs_streq(buf, "off"))
@@ -2490,12 +2496,6 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
 	else
 		return -EINVAL;
 
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
-		return -EPERM;
-
-	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		return -ENODEV;
-
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
 		return ret;
-- 
2.40.1

