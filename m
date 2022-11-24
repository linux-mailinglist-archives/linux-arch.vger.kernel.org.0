Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEDC637234
	for <lists+linux-arch@lfdr.de>; Thu, 24 Nov 2022 07:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiKXGDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Nov 2022 01:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKXGCy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2022 01:02:54 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E2D229349;
        Wed, 23 Nov 2022 22:02:36 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 24FE820B83CB;
        Wed, 23 Nov 2022 22:02:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24FE820B83CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669269756;
        bh=D+EHMsRYcjPgM7FAsk56dOdUsC5Gb8WTyjClcLwda7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gqf7xSFvvF1jzxNgz0Oyhb7um6bccURJNog28tTcUijek4n2OPgLxLdVvGQwcA/X5
         hD8CAPOfnTd1t0jhxoAoTmY7vHF8rH8qX1GutO6UK9DbgdXZrgIMjndrDe+Qve8PbP
         ge/Y166XjYLFgTQfyG9Bodxzt5M9zj9bL1/nEN8c=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: [PATCH v6 4/5] Drivers: hv: Enable vmbus driver for nested root partition
Date:   Thu, 24 Nov 2022 06:02:09 +0000
Message-Id: <f583da987b2ba48e1313b4dc5d20fb6056e93201.1669269377.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669269377.git.jinankjain@linux.microsoft.com>
References: <cover.1669269377.git.jinankjain@linux.microsoft.com>
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
to enable the VMBus driver for nested root partition. This is required,
so that L2 root can use the VMBus devices.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index db00d20c726d..0937877eade9 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2744,7 +2744,7 @@ static int __init hv_acpi_init(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
-	if (hv_root_partition)
+	if (hv_root_partition && !hv_nested)
 		return 0;
 
 	/*
-- 
2.25.1

