Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08C463EEC6
	for <lists+linux-arch@lfdr.de>; Thu,  1 Dec 2022 12:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiLALFE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Dec 2022 06:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiLALEM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Dec 2022 06:04:12 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D78CF13D20;
        Thu,  1 Dec 2022 03:04:02 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id B82CD20B83DC;
        Thu,  1 Dec 2022 03:03:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B82CD20B83DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669892642;
        bh=0XXpwjMaWgOBfkprXGejLOu/IxffncbvZikzfYyKED0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AC4W4BPZx8Nia0TS5K7t6HTAeL8KJJyOoQo2ob88pdXSz8ZB8tk1tMe20QNqutma1
         ALAaPF+MUaMhukj0un16TJEzxvEAtnttZT9NbmqOhzvZkAuXL01twIpkFDE2M2StMf
         X08L3FxRR2MlKH9YbKzZdraj71Yjl8QIqu4hs740=
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
Subject: [PATCH v7 3/5] x86/hyperv: Add an interface to do nested hypercalls
Date:   Thu,  1 Dec 2022 11:03:37 +0000
Message-Id: <0714327373829ec0fc372b78ac3f55c23b1417af.1669788587.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669788587.git.jinankjain@linux.microsoft.com>
References: <cover.1669788587.git.jinankjain@linux.microsoft.com>
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

According to TLFS, in order to communicate to L0 hypervisor there needs
to be an additional bit set in the control register. This communication
is required to perform privileged instructions which can only be
performed by L0 hypervisor. An example of that could be setting up the
VMBus infrastructure.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h |  3 ++-
 arch/x86/include/asm/mshyperv.h    | 42 +++++++++++++++++++++++++++---
 include/asm-generic/hyperv-tlfs.h  |  1 +
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index b5019becb618..7758c495541d 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -380,7 +380,8 @@ struct hv_nested_enlightenments_control {
 		__u32 reserved:31;
 	} features;
 	struct {
-		__u32 reserved;
+		__u32 inter_partition_comm:1;
+		__u32 reserved:31;
 	} hypercallControls;
 } __packed;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 3197d49c888c..fbd7a9589b0d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -74,10 +74,16 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	return hv_status;
 }
 
+/* Hypercall to the L0 hypervisor */
+static inline u64 hv_do_nested_hypercall(u64 control, void *input, void *output)
+{
+	return hv_do_hypercall(control | HV_HYPERCALL_NESTED, input, output);
+}
+
 /* Fast hypercall with 8 bytes of input and no output */
-static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
+static inline u64 _hv_do_fast_hypercall8(u64 control, u16 code, u64 input1)
 {
-	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
+	u64 hv_status;
 
 #ifdef CONFIG_X86_64
 	{
@@ -105,10 +111,24 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
 		return hv_status;
 }
 
+static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
+{
+	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT;
+
+	return _hv_do_fast_hypercall8(control, code, input1);
+}
+
+static inline u64 hv_do_fast_nested_hypercall8(u16 code, u64 input1)
+{
+	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED;
+
+	return _hv_do_fast_hypercall8(control, code, input1);
+}
+
 /* Fast hypercall with 16 bytes of input */
-static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
+static inline u64 _hv_do_fast_hypercall16(u64 control, u16 code, u64 input1, u64 input2)
 {
-	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
+	u64 hv_status;
 
 #ifdef CONFIG_X86_64
 	{
@@ -139,6 +159,20 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
 	return hv_status;
 }
 
+static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
+{
+	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT;
+
+	return _hv_do_fast_hypercall16(control, code, input1, input2);
+}
+
+static inline u64 hv_do_fast_nested_hypercall16(u16 code, u64 input1, u64 input2)
+{
+	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED;
+
+	return _hv_do_fast_hypercall16(control, code, input1, input2);
+}
+
 extern struct hv_vp_assist_page **hv_vp_assist_page;
 
 static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index b17c6eeb9afa..e61ee461c4fc 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -194,6 +194,7 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_HYPERCALL_VARHEAD_OFFSET	17
 #define HV_HYPERCALL_VARHEAD_MASK	GENMASK_ULL(26, 17)
 #define HV_HYPERCALL_RSVD0_MASK		GENMASK_ULL(31, 27)
+#define HV_HYPERCALL_NESTED		BIT_ULL(31)
 #define HV_HYPERCALL_REP_COMP_OFFSET	32
 #define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
 #define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
-- 
2.25.1

