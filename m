Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726BD780089
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 00:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355491AbjHQWCU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 18:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355498AbjHQWCC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 18:02:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E486F30F5;
        Thu, 17 Aug 2023 15:02:00 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 445A9211F7CE;
        Thu, 17 Aug 2023 15:01:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 445A9211F7CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692309719;
        bh=BtQtuAbqXG3JYKbK55ISw9TbDSZuGasp0TD/+YmJshY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bdx3iRrjMkQwrnSP/e3r4MDPxsRvs5Tb9n5S8yRK2ls53hm/cVh4Cbdr81d8MQA7P
         b2b4jho4RZPop7fbk0Stj85L7vFl9r1OUHHfrHNf15V1SX6mnxY7vFOC3Stvs6uO6y
         06TuYE2DgM2jw5fQEUotcHf7+Rc0NJ5Z69dPb8UU=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v2 05/15] hyperv: Move hv_connection_id to hyperv-tlfs
Date:   Thu, 17 Aug 2023 15:01:41 -0700
Message-Id: <1692309711-5573-6-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The definition conflicts with one added in hvgdk.h as part of the mshv
driver so must be moved to hyperv-tlfs.h.

This structure should be in hyperv-tlfs.h anyway, since it is part of
the TLFS document.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 include/asm-generic/hyperv-tlfs.h | 9 +++++++++
 include/linux/hyperv.h            | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 373f26efa18a..8fc5e5a9d7cb 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -845,4 +845,13 @@ struct hv_mmio_write_input {
 	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
 } __packed;
 
+/* Define connection identifier type. */
+union hv_connection_id {
+	u32 asu32;
+	struct {
+		u32 id:24;
+		u32 reserved:8;
+	} u;
+};
+
 #endif
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index bfbc37ce223b..f90de5abcd50 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -748,15 +748,6 @@ struct vmbus_close_msg {
 	struct vmbus_channel_close_channel msg;
 };
 
-/* Define connection identifier type. */
-union hv_connection_id {
-	u32 asu32;
-	struct {
-		u32 id:24;
-		u32 reserved:8;
-	} u;
-};
-
 enum vmbus_device_type {
 	HV_IDE = 0,
 	HV_SCSI,
-- 
2.25.1

