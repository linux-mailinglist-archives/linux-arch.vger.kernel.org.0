Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97F61643A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 15:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiKBOA6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKBOAk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 10:00:40 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4480AE0E4;
        Wed,  2 Nov 2022 07:00:36 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3D5B7205DA28;
        Wed,  2 Nov 2022 07:00:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D5B7205DA28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667397636;
        bh=hQvX71dZTg8r443N5HSX0bVXJGKvJGEvfRFm+V5S45M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqxtouOnwBJK6y0fNOpFoGhMMib9T0KbPoQoSpWN/kmqKzXvLn+x46Kn/2awV72JX
         F757r/NgZB6b+hsdx86YFXZhWEKVfE68ZHnJlawg93QoLIW6os4snaenNDjeWgtsWE
         Ee5vb6XNOXqBSKqEDQNs8BBHT6Nab/oD2zCBko7Q=
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
Subject: [PATCH 3/6] hv: Set the correct EOM register in case of nested hypervisor
Date:   Wed,  2 Nov 2022 14:00:14 +0000
Message-Id: <96b72c2ce5434414acff11548ce4776959a7d3b7.1667394408.git.jinankjain@microsoft.com>
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

Currently we are using the default EOM register value. But this needs to
changes when running under nested MSHV setup.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
---
 include/asm-generic/mshyperv.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 49d2e9274379..7256e2cb7b67 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -117,6 +117,8 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
 
 extern bool hv_nested;
 
+#define REG_EOM (hv_nested ? HV_REGISTER_NESTED_EOM : HV_REGISTER_EOM)
+
 /* Free the message slot and signal end-of-message if required */
 static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 {
@@ -148,7 +150,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 		 * possibly deliver another msg from the
 		 * hypervisor
 		 */
-		hv_set_register(HV_REGISTER_EOM, 0);
+		hv_set_register(REG_EOM, 0);
 	}
 }
 
-- 
2.25.1

