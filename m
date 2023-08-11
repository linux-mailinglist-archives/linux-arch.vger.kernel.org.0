Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CC3779A9E
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbjHKWUD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbjHKWTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:46 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4EE2D5B;
        Fri, 11 Aug 2023 15:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGeREU6I/o4uRrn35P3iicDIr9FhPSssJIOn2x4VxuAbiWAUdrydw5F2DNsysiwZyQ6RZwxeNWpfqz+XAQxPxFc2Um+tr1uPHHu1H+1/5yob1NIb4nm2x7ToABHQ9+DN2ExGiUHYOtQ7eqPwLX1ut2KOyVoqeP1FhWG8n9KgAy4I4dL1ymZP+FDiLKM0hIIs/KII0f2HNANntm7qw+vWHKSuiHhnbSt4+VfhZ4PrYu2tFCcrrMHgFLO2AbI9qPtlY64jpy8ZWA3tZKzfi298oKnxJuFHrf81xTbhn/wP3V+qPhOfTUJJucEq+maTn2IYsF7ty5SKj2ANBU7v207BOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrDZjoP4EKuRXBH+OwFtD1TXWpVrzRIXgCGY/e0gbeY=;
 b=Gig4COnnS+pOnO+OuCqlRXn2qAkxARV3Jtj2wGgdmLgasqw/llnqZ63BVXf6Hxi5L0Tt6Zd3NdJoXQZ2Z272IFKCupQtTdJTiEuAxwO8G1fwqLQBxzXQnSYCM4YD7jG62DaU670O0iDjV1Kz9VGiAb07aCQ1nuPKgSMuK2G8IzB3dw2MS//Wnx2xr/7pE+E7Ao3GFon5EIFzt+2UTGHFoPTXwCAkcJBcdAtwz8hwUHfjPWEcq9sYMaLMPclIH09iFzUco18j9jXqTiXvxIkJUAS8o/mwAATCx8SnchGQMUYnCRzImUYtIPBEVURkRpagya/kS6T6A3ONoGuP/BtfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrDZjoP4EKuRXBH+OwFtD1TXWpVrzRIXgCGY/e0gbeY=;
 b=grzJ/IJTyTQ7gm7es3XimcHdMmJcsa2t9EMZe/shckUCe2TulmyhiEKVRR31z+CmhfP3bExX0TWFpDwW0F4qmJ6n36DlV+k0tH2m4WQH43fJ5LUmrhAFYUEMBRKyoif5MmR2Cj5Df6xSNpVvyEsMiwTfY7Gun24wwKm0MNCZzdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by DM4PR21MB3417.namprd21.prod.outlook.com (2603:10b6:8:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9; Fri, 11 Aug 2023 22:19:39 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 22:19:39 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 6/9] x86/hyperv: Introduce a global variable hyperv_paravisor_present
Date:   Fri, 11 Aug 2023 15:18:48 -0700
Message-Id: <20230811221851.10244-7-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811221851.10244-1-decui@microsoft.com>
References: <20230811221851.10244-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To MW2PR2101MB1099.namprd21.prod.outlook.com
 (2603:10b6:302:4::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1099:EE_|DM4PR21MB3417:EE_
X-MS-Office365-Filtering-Correlation-Id: ba029454-a03f-4600-ba7f-08db9ab90d77
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQGuM64A0QmnQ9Skl2WQyJPF/Z34jOe9xdVvNUvbhrLksfbHmOm1agXnOD4nZAHF2q4Nco95Otzo+WVxwwhxsF+Go+h41ALLz0lAYiVaHfgVNz09aH6p8T91edj3MSFOzVzZ0bxv5v+Oja3gJakMQpL8YGreFI1q4ZscpdUBPtfM6y/jyGL6Ru6BA1lbE2u/DHqP6KYqiatekuC0TaVzs8/N2/zLrsmoLr2gbnv8WxpiYNOk1KaBs/u7aVRzQlwf5ss763LHOOXri3kJLobF4NYgjabl4kOoH/9W+Dtfmu/2xcztODwZvoizZM9p/KUhi5A5fWgm4bf4varBG0YScCaV7IWzEzY+cyBLHWvCRUBDw+QSD8fwjY2zxujUppZDb/+9L6hB7ypEedkxls15q52w/FLcMmBPHfW1/xEHedeWW4dnffjc/khPBFy/ly5xOtUn0w5X3MowME3wFqELOU/C+C6Teo6WYhyV1/si18Dj8t+YqAx0njo9CllS5xTENOsLUD24RGvsxPt/2C3K2XR2Ud5TDsrNZ/sfXnogN4vYk0/qBrMVXEYNjEydoxjhq6OMchSB+fy0ZYOsFxA7joBQ9P/FvhGlJoHdV2DugVCPYZnIjVBxCT/8MdAaQErfo2+37YwWfU3tl0/G1zXY8DVxXZgumuU65QR4ing05bIH3YJ8rh6zc7reZSLsiS1YMcmjbVM4qzVTpb1P+k6kCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(30864003)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(6666004)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FzeLYFk9IwTo6qmpp+NslGXmVvfgnDblmju7RVtPScD8NDKB/QUT1Ui8GyWv?=
 =?us-ascii?Q?C/ciQrckgVqDv5uG/iClMT4WzfHuIfGb6JyOZWPNpGUSiV7pGGDX2pb+Btsu?=
 =?us-ascii?Q?2f209WSk2Cejf801lnZzIExvuBOgDSmP8W+seQsymIYo8iY6oknEwUwT0O6P?=
 =?us-ascii?Q?mdR1QddyPl9UnfH19t7A6zbxy0NG4Z161j4hXctLN2WTSseTS2DkuGEB0IDG?=
 =?us-ascii?Q?nIO4MM81Gu3UOg2iUDhgkm5//T/u8A0Bj/bSe97g/hEcExZXbFV4lALKtz5B?=
 =?us-ascii?Q?+ZYShkNtbjzDkf7xHaJONdqrjoPliW/Da2D5JGiOA5g4lfnDH9We1oQsFuU1?=
 =?us-ascii?Q?DmGzCithX0ExTPNTsoJRmn52fI/KI8CddyIqkSNBEGhyF+PPFzq24o+1vLmo?=
 =?us-ascii?Q?2ECTowc/vqhwkVdebSwGg9CC5PaLdlol9HVWuZ1x8bGwYLIDfW7KQgHOCP3v?=
 =?us-ascii?Q?ZKG6s0mhSZTONNF9LwH2JfPr+9tvd3zPZPyXpEV0hmVjTAJ56fAr88pWZ7fO?=
 =?us-ascii?Q?ENMbKgl97I6DDbOmqiVl8ulCnl81JZ1zoq4R9nn2STgyVXEzA3kdGiDpBCbR?=
 =?us-ascii?Q?diru+7bBylDEiAIdCVmYKu9+Dh4aFYle+FOAoCQFS+IM83IrFChV5zlecgk3?=
 =?us-ascii?Q?RSctQYoxQKx/yWXEzxo0dZVh1ON6HQX5IqVfc85SuZE5Rd75ZU3e486eQWxz?=
 =?us-ascii?Q?pwP7SprHR8s1y5Dos0ILGffZKhUHy0shm05gvyLXdC1DqtZ0YcgfFn51oJiG?=
 =?us-ascii?Q?6MnOKXPqGmfIWZdmtaYRpIVs8GRbFCB9eTLfAXJt9GZ2qt0Cvc+wN/0x5e2T?=
 =?us-ascii?Q?VsT8R2JM0FFhKpsTt/pHZdJcmtxMIHPGfIi28jITs8OVfiU0GsmfemOPVh0b?=
 =?us-ascii?Q?17ryCXPaMQq6aSCPS8/rVwxY/Ty7nwpciCd82vSiARME2vpiMYsYtlLPYwvx?=
 =?us-ascii?Q?CKokTkajDlOtTH7jnizVwO+6GKPeGg9jR/LCJArFIQZWZGb5L/gG1HZS8sHp?=
 =?us-ascii?Q?WSwCvD99iWiWNBQ6s5eQNHmq3MtIiSzKnxbhK7eB3y8KoX7gkMOdESiIxH/K?=
 =?us-ascii?Q?q34Tg+jn492AfTPU6DO1bRaTG8/Pt1HtFfCh43CC0DplHJ+jYdKKnnAaLdrC?=
 =?us-ascii?Q?ZuVKs+ud3OBw2uAjg6R/0GFPUNxhraRWeOp4Iw68fDcNkCiD0wBn/TnUb9yc?=
 =?us-ascii?Q?IBI9Oe6GaMFEXKABE+9lTBxOyu2bIrvQDhmgbfvDDcNX1UDJJLLZUwMZr8f8?=
 =?us-ascii?Q?R9ItCIb8gM20KcS6eTONCr1tBYYssConMX9qUf4ilur9RcwB3UETfw88UIsP?=
 =?us-ascii?Q?p3yU2vYpwfFAZe42B/BSZNH1rkckqB0Zb73dUy7k0GnmuFf6kNtBZmvMcf26?=
 =?us-ascii?Q?8EbU2M3yRC5CNxwavYOwYJXqTmU1btGMAaFfYVS57XCp8p2W/9y1YblB3sov?=
 =?us-ascii?Q?28px4taoUEc7QfW7oiJq1BYVwxElpN3t9tg9MH//w7WNOUA2BRxBEmvQ6IrY?=
 =?us-ascii?Q?yn/DrhQ5SNH0i8ENeKEq+UGvYXFGIm3hw/HIly1sxS5Dar/gexjhjoSoa1An?=
 =?us-ascii?Q?/ejsK5Qd0Xh2l5iWCYUFgBG/a8XQMpgO2jHgWV0WXYfAdLJihlukvp/oBEOM?=
 =?us-ascii?Q?9ZPggAPeeahbjjn5cbkggObvKjJaYO104DsH5+kR7K3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba029454-a03f-4600-ba7f-08db9ab90d77
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:39.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niyVp3zfRb3D5VsMKm1FCFNxHmW41IzvpIquGXWIDm01k7dxFSNw4L6KCG5toe2mDVRgR2zIK3hhDPD90DqQ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3417
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The new variable hyperv_paravisor_present is set only when the VM
is a SNP/TDX with the paravisor running: see ms_hyperv_init_platform().

In many places, hyperv_paravisor_present can replace
ms_hyperv.paravisor_present, and it's also used to replace
hv_isolation_type_snp() in drivers/hv/hv.c.

Call hv_vtom_init() when it's a VBS VM or when hyperv_paravisor_present
is true (i.e. the VM is a SNP/TDX VM with the paravisor).

Enhance hv_vtom_init() for a TDX VM with the paravisor.

The biggest motive to introduce hyperv_paravisor_present is that we
can not use ms_hyperv.paravisor_present in arch/x86/include/asm/mshyperv.h:
that would introduce a complicated header file dependency issue.

In arch/x86/include/asm/mshyperv.h, _hv_do_fast_hypercall8()
is changed to specially handle HVCALL_SIGNAL_EVENT for a TDX VM with the
paravisor, because such a VM must use TDX GHCI (see hv_tdx_hypercall())
for this hypercall. See vmbus_set_event() -> hv_do_fast_hypercall8() ->
_hv_do_fast_hypercall8() -> hv_tdx_hypercall().

In hv_common_cpu_init(), don't decrypt the hyperv_pcpu_input_arg
for a TDX VM with the paravisor, just like we don't decrypt the page
for a SNP VM with the paravisor.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c       |  4 ++--
 arch/x86/hyperv/hv_init.c       |  4 ++--
 arch/x86/hyperv/ivm.c           | 20 ++++++++++++++++++--
 arch/x86/include/asm/mshyperv.h |  9 ++++++---
 arch/x86/kernel/cpu/mshyperv.c  | 13 ++++++++++---
 drivers/hv/connection.c         |  2 +-
 drivers/hv/hv.c                 | 12 ++++++------
 drivers/hv/hv_common.c          |  6 +++++-
 include/asm-generic/mshyperv.h  |  1 +
 9 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index cb7429046d18d..8958836500d01 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -179,7 +179,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 
 	/* A fully enlightened TDX VM uses GHCI rather than hv_hypercall_pg. */
 	if (!hv_hypercall_pg) {
-		if (ms_hyperv.paravisor_present || !hv_isolation_type_tdx())
+		if (hyperv_paravisor_present || !hv_isolation_type_tdx())
 			return false;
 	}
 
@@ -239,7 +239,7 @@ static bool __send_ipi_one(int cpu, int vector)
 
 	/* A fully enlightened TDX VM uses GHCI rather than hv_hypercall_pg. */
 	if (!hv_hypercall_pg) {
-		if (ms_hyperv.paravisor_present || !hv_isolation_type_tdx())
+		if (hyperv_paravisor_present || !hv_isolation_type_tdx())
 			return false;
 	}
 
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 4bcd0a6f94760..e67e2430fba35 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -663,8 +663,8 @@ bool hv_is_hyperv_initialized(void)
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return false;
 
-	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
-	if (hv_isolation_type_tdx())
+	/* A TDX VM with no paravisor uses TDX GHCI call rather than hv_hypercall_pg */
+	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return true;
 	/*
 	 * Verify that earlier initialization succeeded by checking
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 5792cddea4914..0d54bc8b06b4a 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -459,13 +459,29 @@ int hv_snp_boot_ap(int cpu, unsigned long start_ip)
 
 void __init hv_vtom_init(void)
 {
+	enum hv_isolation_type type = hv_get_isolation_type();
 	/*
 	 * By design, a VM using vTOM doesn't see the SEV setting,
 	 * so SEV initialization is bypassed and sev_status isn't set.
 	 * Set it here to indicate a vTOM VM.
 	 */
-	sev_status = MSR_AMD64_SNP_VTOM;
-	cc_vendor = CC_VENDOR_AMD;
+	switch (type) {
+	case HV_ISOLATION_TYPE_VBS:
+		fallthrough;
+
+	case HV_ISOLATION_TYPE_SNP:
+		sev_status = MSR_AMD64_SNP_VTOM;
+		cc_vendor = CC_VENDOR_AMD;
+		break;
+
+	case HV_ISOLATION_TYPE_TDX:
+		cc_vendor = CC_VENDOR_INTEL;
+		break;
+
+	default:
+		panic("hv_vtom_init: unsupported isolation type %d\n", type);
+	}
+
 	cc_set_mask(ms_hyperv.shared_gpa_boundary);
 	physical_mask &= ms_hyperv.shared_gpa_boundary - 1;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4c68564a165e5..9fa31dce69727 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -42,6 +42,7 @@ static inline unsigned char hv_get_nmi_reason(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 extern int hyperv_init_cpuhp;
+extern bool hyperv_paravisor_present;
 
 extern void *hv_hypercall_pg;
 
@@ -74,7 +75,7 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control,
 					cc_mkdec(input_address),
 					cc_mkdec(output_address));
@@ -121,7 +122,9 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx() &&
+		(!hyperv_paravisor_present ||
+		 control == (HVCALL_SIGNAL_EVENT | HV_HYPERCALL_FAST_BIT)))
 		return hv_tdx_hypercall(control, input1, 0);
 
 	{
@@ -170,7 +173,7 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control, input1, input2);
 
 	{
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b4214e37e9124..ddcc62185e4ae 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -40,6 +40,12 @@ bool hv_root_partition;
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
+/*
+ * Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyperv.h.
+ * Exported in drivers/hv/hv_common.c to not break the ARM64 build.
+ */
+bool hyperv_paravisor_present __ro_after_init;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 static inline unsigned int hv_get_nested_reg(unsigned int reg)
 {
@@ -430,6 +436,8 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.shared_gpa_boundary =
 				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
 
+		hyperv_paravisor_present = !!ms_hyperv.paravisor_present;
+
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
@@ -444,7 +452,7 @@ static void __init ms_hyperv_init_platform(void)
 			/* A TDX VM must use x2APIC and doesn't use lazy EOI. */
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
-			if (!ms_hyperv.paravisor_present) {
+			if (!hyperv_paravisor_present) {
 				/*
 				 * The ms_hyperv.shared_gpa_boundary_active in
 				 * a fully enlightened TDX VM is 0, but the GPAs
@@ -535,8 +543,7 @@ static void __init ms_hyperv_init_platform(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
-	    ((hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) &&
-	    ms_hyperv.paravisor_present))
+	    hyperv_paravisor_present)
 		hv_vtom_init();
 	/*
 	 * Setup the hook to get control post apic initialization.
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 02b54f85dc607..7f64fc942323b 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -484,7 +484,7 @@ void vmbus_set_event(struct vmbus_channel *channel)
 
 	++channel->sig_events;
 
-	if (hv_isolation_type_snp())
+	if (hv_isolation_type_snp() && hyperv_paravisor_present)
 		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
 				NULL, sizeof(channel->sig_event));
 	else
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 28bbb354324d6..20bc44923e4f0 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -109,7 +109,7 @@ int hv_synic_alloc(void)
 		 * Synic message and event pages are allocated by paravisor.
 		 * Skip these pages allocation here.
 		 */
-		if (!hv_isolation_type_snp() && !hv_root_partition) {
+		if (!hyperv_paravisor_present && !hv_root_partition) {
 			hv_cpu->synic_message_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
 			if (hv_cpu->synic_message_page == NULL) {
@@ -128,7 +128,7 @@ int hv_synic_alloc(void)
 			}
 		}
 
-		if (!ms_hyperv.paravisor_present &&
+		if (!hyperv_paravisor_present &&
 		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)
 				hv_cpu->synic_message_page, 1);
@@ -226,7 +226,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
 	simp.simp_enabled = 1;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (hyperv_paravisor_present || hv_root_partition) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -249,7 +249,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 1;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (hyperv_paravisor_present || hv_root_partition) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -336,7 +336,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 * addresses.
 	 */
 	simp.simp_enabled = 0;
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (hyperv_paravisor_present || hv_root_partition) {
 		iounmap(hv_cpu->synic_message_page);
 		hv_cpu->synic_message_page = NULL;
 	} else {
@@ -348,7 +348,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 0;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (hyperv_paravisor_present || hv_root_partition) {
 		iounmap(hv_cpu->synic_event_page);
 		hv_cpu->synic_event_page = NULL;
 	} else {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 4c858e1636da7..c0b0ac44ffa3c 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -40,6 +40,9 @@
 bool __weak hv_root_partition;
 EXPORT_SYMBOL_GPL(hv_root_partition);
 
+bool __weak hyperv_paravisor_present;
+EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
+
 bool __weak hv_nested;
 EXPORT_SYMBOL_GPL(hv_nested);
 
@@ -382,7 +385,8 @@ int hv_common_cpu_init(unsigned int cpu)
 			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 		}
 
-		if (hv_isolation_type_en_snp() || hv_isolation_type_tdx()) {
+		if (!hyperv_paravisor_present &&
+		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
 				/* It may be unsafe to free 'mem' */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 30fa75facd784..a6e4f38222c81 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -176,6 +176,7 @@ extern int vmbus_interrupt;
 extern int vmbus_irq;
 
 extern bool hv_root_partition;
+extern bool hyperv_paravisor_present;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
-- 
2.25.1

