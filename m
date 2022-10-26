Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE8060E284
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiJZNsk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiJZNsJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 09:48:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 002C08BBB2;
        Wed, 26 Oct 2022 06:48:08 -0700 (PDT)
Received: from anrayabh-desk.corp.microsoft.com (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id 33CBC2109450;
        Wed, 26 Oct 2022 06:48:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33CBC2109450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666792088;
        bh=jLGstakCq9S33uzmp4509MKhTHZdg717E6kd8XaghHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V28NrchLL0/cxXjeEmrw1fkhrdeYTX4oxTaG2cE374/NzbC24nlsfT3KaJOYQM8nv
         B6b68znl+SiM2xtyzozf+XG/8as8x2ye9Ufip1Ad2VW9q143QRSW5a+svIi/0IQPkQ
         /1i0PumPEX2nzhhPewBK52PKrQmb2eF+TB1Byl24=
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, daniel.lezcano@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, mail@anirudhrb.com
Subject: [PATCH 1/2] x86/hyperv: fix invalid writes to MSRs during root partition kexec
Date:   Wed, 26 Oct 2022 19:17:14 +0530
Message-Id: <20221026134715.1438789-2-anrayabh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
References: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
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

hv_cleanup resets the hypercall page by setting the MSR to 0. However,
the root partition is not allowed to write to the GPA bits of the MSR.
Instead, it uses the hypercall page provided by the MSR. Similar is the
case with the reference TSC MSR.

Clear only the enable bit instead of zeroing the entire MSR to make
the code valid for root partition too.

Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 29774126e931..76ff63d69461 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -537,6 +537,7 @@ void __init hyperv_init(void)
 void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
+	u64 tsc_msr;
 
 	unregister_syscore_ops(&hv_syscore_ops);
 
@@ -552,12 +553,14 @@ void hyperv_cleanup(void)
 	hv_hypercall_pg = NULL;
 
 	/* Reset the hypercall page */
-	hypercall_msr.as_uint64 = 0;
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable = 0;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 	/* Reset the TSC page */
-	hypercall_msr.as_uint64 = 0;
-	wrmsrl(HV_X64_MSR_REFERENCE_TSC, hypercall_msr.as_uint64);
+	rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr);
+	tsc_msr &= ~BIT_ULL(0);
+	wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr);
 }
 
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
-- 
2.34.1

