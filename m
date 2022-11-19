Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09260630B56
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiKSDra (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiKSDrA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:47:00 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA32BF830;
        Fri, 18 Nov 2022 19:46:51 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so996231pjk.1;
        Fri, 18 Nov 2022 19:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN6eB0wxJRf6zzRxY6T7pa65W2+E1oedx78oWdQ5Oug=;
        b=NBt4Xls1RZOBtmtBilmybh/XvJM5mSsTG2HAd6utN6D5Mu9JgAYK1Az3jDz+NYOUmf
         4YyOzRgIifgQxbVi8a3V1ZLzsJr06l37H6yxvSDAXYuMsNNFqighPMYkMgq0dgHn2kJU
         OgBeCVSscvZ8ZJHXAQ4JOxi9n/Aqm8cNgstROCJtG7OFxP0f32WsSMW76UDYZxTAMS8+
         1RRhWDB22k3c5cOsw7iJko8FYwxpoLFc1P6kznPmTcVWHu+pqUqvX816WtU4+frGBEq7
         GXPI/SGzZmV73ZhFlsV/IBtG/InWq+hDEEy6mgIKE4Pz2CXDme4mvwdTC1hlcUhD1xvp
         CTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wN6eB0wxJRf6zzRxY6T7pa65W2+E1oedx78oWdQ5Oug=;
        b=NmJGObYoNeMjrVmnwC+yWe/TjlsuuqI2TV4JaXyoVNzHRlnb0PUZRBpRyZjEnyM0Ih
         Jpi0N/7qFF15N5/eGl7tV4ttsWOzyJDTO4ADNa7cWm8114ID3uIO1uhykHmuPPcCpXqD
         cOUC/5Useu1KY6jwAT4ml4xATZXtzwq7LeoUKlSW2xdHawhvDb6QmM1ukmZjrhSddJ/N
         rRxEGsqY8Hcrn+03u9io0w3jZtzGXXB60ireqDMiiE5MlDWCviE5QpuwcpdiDDXTEllH
         NuQVBZOK+UqR35nsO4KtTQswboqdKx+eSO4/WsU/7K0tqaeCGjwL/t7x9FxgkoMqw7Ug
         rKEg==
X-Gm-Message-State: ANoB5pl1mQYI4jXtDRUql0QA/oYIy3hXGGw71Wv5vBFI/CzxtPlZ9ipq
        nz9FY7vJrasLtgBXlV0S8+Y=
X-Google-Smtp-Source: AA0mqf5zIYZtw6iVkCd7uQV2a6WMjWTxhRQw0MJkAjBeqXqboLVNOYh8+nY30Xi18DY1G3MYt/fMIg==
X-Received: by 2002:a17:902:6847:b0:183:6555:38ef with SMTP id f7-20020a170902684700b00183655538efmr2340783pln.157.1668829611039;
        Fri, 18 Nov 2022 19:46:51 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:50 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V2 09/18] x86/hyperv: set target vtl in the vmbus init message
Date:   Fri, 18 Nov 2022 22:46:23 -0500
Message-Id: <20221119034633.1728632-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119034633.1728632-1-ltykernel@gmail.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Set target vtl (Virtual Trust Level) in the vmbus init message.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/connection.c | 1 +
 include/linux/hyperv.h  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 43141225ea15..09a1253b539a 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -98,6 +98,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 	 */
 	if (version >= VERSION_WIN10_V5) {
 		msg->msg_sint = VMBUS_MESSAGE_SINT;
+		msg->msg_vtl = ms_hyperv.vtl;
 		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
 	} else {
 		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3b42264333ef..2be0b5efd1ea 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -665,8 +665,8 @@ struct vmbus_channel_initiate_contact {
 		u64 interrupt_page;
 		struct {
 			u8	msg_sint;
-			u8	padding1[3];
-			u32	padding2;
+			u8	msg_vtl;
+			u8	reserved[6];
 		};
 	};
 	u64 monitor_page1;
-- 
2.25.1

