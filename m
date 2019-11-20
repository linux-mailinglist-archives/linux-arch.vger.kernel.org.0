Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D871034EF
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 08:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfKTHQl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 02:16:41 -0500
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:20640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfKTHQk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 02:16:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgTP5prfF1m5iiEGHljZEENW4qgunSG6vX+BxWXHNWLXuqde6IWZ5ZsjlFT4lHnupJj2TjMakyGsgs8z7CKy6Kf1Y6BKWJqoicAKsOLMfhUQicbGYvEAyzMW0C8EYuKxSVmoxxKr825I5Ruxw5GZpt2O60FXPaEUSSa7dMJCoJ+Dv/cYPrtTAU9IpYHZ1+D+FyJ3DMOCFajaf9AdYNYoHLpNyuJx7MlCoHU/MjzDFLgCcHH9kuK8KPwKVLn/hu9x6Zcwk+DClruoC13FBfn5Ot2aRfEYtBrt+f4RRxqGmFpVU9ZHPVmUHyTQy2g6O/MU6oWU26ASXMp5Rf8FelGq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1oSpsYNl2G0lkTls6l1PyuqgjDKKIHMm5G7Bdnvsu8=;
 b=lTs7Qir7C4U+18sFZ35q/leuP9JxvTjrloZk0jfhnbdQhhEDXm3rqJDPBl9BAYSoeWKkfzXY0RlgUi6+TjrgzYq4D9lk2XX2CdZUEyhusvbgiptG0EbKzYj73g2v6M2xj8rCVEUgcx/3N8k8w258+v6J/wggBzy2sPoWWp/1PjObRqWCF97VIiJSXC3WkHL3r5JYZbpBWxsLJyzqCpi2D0rJ5rfkonKks4ZlDJb8Ia+Evwf5kKjisFu8P7IJvviI+IIAFT/S6cj7a2G1H/sFxKib5pgEfqUDGidcCRVjUR1+btzc9vZS9T2qdTEdO2EXy5dz+/+7NtwFm5luzyNIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1oSpsYNl2G0lkTls6l1PyuqgjDKKIHMm5G7Bdnvsu8=;
 b=e2Js2Vam+w7XmpRLDcqO4j/tIybn8erK23BouzsQn1Xo6esYQELZlO8xvOlFbNj55IlwgFBNm7IyRCBejRlVmb1wr0y4Mn23tXjqrOdNA6ls+6nFeLbte6LYSe8o7Px4aYhOslmol/1QRSfARXRKbsS+zqCIHp9c6DK5eOLXm4k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:16:36 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:16:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        david@redhat.com, arnd@arndb.de, bp@alien8.de,
        daniel.lezcano@linaro.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, Alexander.Levin@microsoft.com,
        vkuznets@redhat.com
Cc:     linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 1/2] x86/hyperv: Implement hv_is_hibernation_supported()
Date:   Tue, 19 Nov 2019 23:16:04 -0800
Message-Id: <1574234165-49066-2-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574234165-49066-1-git-send-email-decui@microsoft.com>
References: <1574234165-49066-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:300:ed::22) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR20CA0036.namprd20.prod.outlook.com (2603:10b6:300:ed::22) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:16:34 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b845426d-5dbe-437a-bbdb-08d76d899458
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB125109EB214E03570BF10AA6BF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(10090500001)(36756003)(7416002)(8936002)(50226002)(81166006)(81156014)(8676002)(14444005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(966005)(4720700003)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(76176011)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(446003)(11346002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(6306002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Bq8SnqAzOXvaI8tVzbwZWedQoXyC3tZXJ6/sUFoYMQOr3Ok3KyTvXyyJGCd7/Zi4dy6q3lfqT+z8hNV27tsFeXD3eMvOwmHL7m+F0Pem9blSyk9+g/fP3wbnHvvOW7ewRLIE7jR97qXhRJcnASRB3N1MYsx+5gF1lq8rKtDXbFt0Nxi57pbQnR5CDKSvQhbj77Q3MS3JK1CFD7mmjws/EvIgoKebe3amKm6ncHu5Z5texppxQtsencevKUEdtGyBCeG9K+MwOfDi/AqofaPgN/WwrjtoHRMzknE1Bu3NBJNFNjFeeRj8IrPDHlGw/ANS863jnuSU8o+qx6fYY22uiGW3YHov9elJ407HeeUyreSfhX23HAxBL6MNd2ipWd4yZDrj4mSh/a3VdtewZ98vjTWlW1oKBGvMsP8EjONPpqo9aZ6/QAW1BQkk/gubvh7e9eyDo5Z0/zRGX1NLbUhNDQ1ThC6yENT2oeEowh8aPg=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b845426d-5dbe-437a-bbdb-08d76d899458
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:16:36.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULoY+R5yfP72lLVCiKgEsltrZeVRPP1A2N0EKxkXdRkXkGPJyqEmS99JvR15MfIC4nZA2UdmPlQuEo3h6KH1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The API will be used by the hv_balloon and hv_vmbus drivers.

Balloon up/down and hot-add of memory must not be active if the user
wants the Linux VM to support hibernation, because they are incompatible
with hibernation according to Hyper-V team, e.g. upon suspend the
balloon VSP doesn't save any info about the ballooned-out pages (if any);
so, after Linux resumes, Linux balloon VSC expects that the VSP will
return the pages if Linux is under memory pressure, but the VSP will
never do that, since the VSP thinks it never stole the pages from the VM.

So, if the user wants Linux VM to support hibernation, Linux must forbid
balloon up/down and hot-add, and the only functionality of the balloon VSC
driver is reporting the VM's memory pressure to the host.

Ideally, when Linux detects that the user wants it to support hibernation,
the balloon VSC should tell the VSP that it does not support ballooning
and hot-add. However, the current version of the VSP requires the VSC
should support these capabilities, otherwise the capability negotiation
fails and the VSC can not load at all, so with the later changes to the
VSC driver, Linux VM still reports to the VSP that the VSC supports these
capabilities, but the VSC ignores the VSP's requests of balloon up/down
and hot add, and reports an error to the VSP, when applicable. BTW, in
the future the balloon VSP driver will allow the VSC to not support the
capabilities of balloon up/down and hot add.

The ACPI S4 state is not a must for hibernation to work, because Linux is
able to hibernate as long as the system can shut down. However in practice
we decide to artificially use the presence of the virtual ACPI S4 state as
an indicator of the user's intent of using hibernation, because Linux VM
must find a way to know if the user wants to use the hibernation feature
or not.

By default, Hyper-V does not enable the virtual ACPI S4 state; on recent
Hyper-V hosts (e.g. RS5, 19H1), the administrator is able to enable the
state for a VM by WMI commands.

Once all the vmbus and VSC patches for the hibernation feature are
accepted, an extra patch will be submitted to forbid hibernation if the
virtual ACPI S4 state is absent, i.e. hv_is_hibernation_supported() is
false.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---

v2 is actually the same as v1. This is just a resend.

I suggest this patch should go through the Hyper-V tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
because it's needed by
[PATCH v2 2/2] hv_balloon: Add the support of hibernation
and some upcoming patches.

This patch doesn't conflict with any patch in the tip.git tree.

 arch/x86/hyperv/hv_init.c      | 7 +++++++
 include/asm-generic/mshyperv.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index c170653da589..24a62d33067c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -7,6 +7,7 @@
  * Author : K. Y. Srinivasan <kys@microsoft.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/types.h>
 #include <asm/apic.h>
@@ -493,3 +494,9 @@ bool hv_is_hyperv_initialized(void)
 	return hypercall_msr.enable;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_is_hibernation_supported(void)
+{
+	return acpi_sleep_state_supported(ACPI_STATE_S4);
+}
+EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 18d8e2d8210f..b3f1082cc435 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -166,10 +166,12 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 void hyperv_report_panic(struct pt_regs *regs, long err);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
+bool hv_is_hibernation_supported(void);
 void hyperv_cleanup(void);
 void hv_setup_sched_clock(void *sched_clock);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
+static inline bool hv_is_hibernation_supported(void) { return false; }
 static inline void hyperv_cleanup(void) {}
 #endif /* CONFIG_HYPERV */
 
-- 
2.19.1

