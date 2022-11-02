Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC3616442
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 15:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiKBOBX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiKBOA6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 10:00:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF533F009;
        Wed,  2 Nov 2022 07:00:44 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id ADDDF20B9F81;
        Wed,  2 Nov 2022 07:00:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ADDDF20B9F81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667397644;
        bh=1B9p6pFN0yHl6pLuVEuKSNR9XxSBhvzkr5T1mlusw7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aA8F1YqBGYt4Jz+EAdsr7+jrQQDPc/t71mULllyKGzjdBTWgc9SMmZgGei6yVD9TS
         rJAyFc2cSqy3/Ua+ubKUGhDoYzW1aIizgRgdo4CyIJ7jTNWmKqRb+V1BkwrjmCNkm5
         XJ5WyYMVmINhplBTP4UBICNLB+eoleSxA+UzUnvs=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 5/6] hv: Enable vmbus driver for nested root partition
Date:   Wed,  2 Nov 2022 14:00:16 +0000
Message-Id: <fbcd560a23ae4d18b8d6a0d2b832303bbe74a382.1667394408.git.jinankjain@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667394408.git.jinankjain@microsoft.com>
References: <cover.1667394408.git.jinankjain@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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

