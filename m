Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23B361696D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiKBQmG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 12:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiKBQlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 12:41:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D24082EF47;
        Wed,  2 Nov 2022 09:36:25 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id AD76720C333D;
        Wed,  2 Nov 2022 09:36:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD76720C333D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667406985;
        bh=1B9p6pFN0yHl6pLuVEuKSNR9XxSBhvzkr5T1mlusw7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bEfUmfGAOBS5gITdkhShpUgdIYz8e+w/nnho/XxjusjA2Kkf5dnpHM4P8CHymhhL8
         8HCaxw248anAGvGRKkFoo8Qmn43xKnKtKQfY9wCv17wcfD2JfZKky368V8dGvXvmkG
         ak3Witv1f52bZtBBpaQGXphevowOygPlmqzZFDeg=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 4/5] hv: Enable vmbus driver for nested root partition
Date:   Wed,  2 Nov 2022 16:36:01 +0000
Message-Id: <b5ea40f7e84e17a4338a313ab74292a293b1efa4.1667406350.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667406350.git.jinankjain@linux.microsoft.com>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently VMBus driver is not initialized for root partition but we need
to enable the VMBus driver for nested root partition. This is required
to expose VMBus devices to the L2 guest in the nested setup.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8b2e413bf19c..2f0cf75e811b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2723,7 +2723,7 @@ static int __init hv_acpi_init(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
-	if (hv_root_partition)
+	if (hv_root_partition && !hv_nested)
 		return 0;
 
 	/*
-- 
2.25.1

