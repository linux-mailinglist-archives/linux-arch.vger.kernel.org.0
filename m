Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70B781FD6
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjHTUdO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjHTUdJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:33:09 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A78DE;
        Sun, 20 Aug 2023 13:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv53rt2/ktUQQpu9dDbifoFzvtUIADu8050nH/kIwc/fKLQq6OuQTY78i8zFIW2LXPTAS/3Q6DCtC0tAGrm44x/bH608r2o+5cAykTF6HinV5ccX8k+Vz+Sg+vunMXr+i5zPbicnfJr5aV6v1ATY0SGAc51ng5p1lAeRk6WSGlizQ+btemnu+RLZRT2oFX/tX44Wgd5SgRJcxYb1DcKvP9Mif/RF1lDy03FQ5/Tm8ioS410h2mY5zSCWWfY1tIQPMFLp0a3tAGG2g2hoJiReKVR9iaYmpvkrQCPa44r8vfzJKOICSivv4PieIrh/5rCKuuMZbICn8u+lbVWK93N/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wlxRdVgZ1iH+dInJnSagMbLtv2zY5l8VRL+DfO1Ucs=;
 b=ZAZvsgMTu+pJxx2nUnUnAc97puPuP3zCml6iRmHAfC61a07ppD63erGzFbyjgTQssiu6cYp965M8fDlo0Q/+ACRaqcFTQQ61YOdSxkWtWFl1dFx+iGSLJoY4bxT6e+tjDz9Su4jG2FKtDpVbJccWeshH0uUZfWQXA1mkW2ptVaYCxtFcYOlylor4c82uFCG4AqFpAcPRA5S2yVpAvwSX/GOhpHpqJsrddZaCAlMbsnx8+m460st38H+DgLZcUPHkTfsjrqpiSo2VRgoCs3FOz10/kKizQd1IiIzRGdyt9wRTVXl8cCxcBpN+I01KUezUFnzfwO+pT9DndSysGx7ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wlxRdVgZ1iH+dInJnSagMbLtv2zY5l8VRL+DfO1Ucs=;
 b=S7CRXyII5uK5Z+zEG5uLuvQ4Voak4OiiMfbnnz1mAN4YPpG69mEGUSfMAbxDdzwakhFECUkjFifk6T6x85oui57uMFGq1TLXvtcdIbdgE8JlxuxICW2qIIDOZ9OIBArckwiv2xOCWgWJrt1rqTn5LMKBKjwrL67pQou/uKX70kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:28:07 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:28:07 +0000
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
Subject: [PATCH v2 6/9] x86/hyperv: Introduce a global variable hyperv_paravisor_present
Date:   Sun, 20 Aug 2023 13:27:12 -0700
Message-Id: <20230820202715.29006-7-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230820202715.29006-1-decui@microsoft.com>
References: <20230820202715.29006-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MW4PR21MB2075:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ef082e-b610-4fe3-523d-08dba1bbf6b1
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWG9hTQ1aLReGVa/zuVDXYPaqBxYue+OEwesv7Yon0/pTbcLoan7m6WVJZ0oNDH8LrnGQeOGjGD6b+db3NhmBZz4jh6IUuWk4Gar6F9AgZ3XJhCbwjhp7k4vukV04u0Qw7Ht5CjzbUrRR7LSqxbgvqJDrVih7amMR4LjGx9sIXD4srI60Hl9Quf35nLtKHUODPj68XFcT0TIxf6kzom1DRz5jJARZSHx4Oyl/Amq1sobhk5jXumG2iHK9WMa+CpKgInAl6EkFbieutqUWtHX8z6Oxm//zX8VZHRRVovk2SSvjCSIL1oZGDvQm88BEYtAOO3kqttc68vcT9PFFHmivsfe5xkhqas8Mfu67aUIcJM/EdeGvFcxegkfcqN2Xj0ht2MG6DxP1eXM7S+Xv6eRboDdKRv7TiIi9ulrpYEv8TGNuJeOn5LEegtEhEhYouxrZ8oZwOs/1bFP3QMd8kKICQYb9WlR1WLTwEM3GyilMHbg8HPKfQs8ZThwOFHHx4iZRnVWYXglzfnbtzHzwum5S0B+2ISrTjIiRycoDTNZLJYEyWv2Rw8z8NKAPu2PQTcjNUFrYDtbPpo7UjVg3jjHHQLCT01gddbx+mnxDMlTPPNrnTYcQ/Lv+SfKsuKmktnZJrpL12s7BxkYd2z7sV6oFmiyvFRd0gDuYlmDwYvYNgPYhODfYWnpTUeIgw9J0Q4hWsuuyZkmlCOPOK596DLzZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(6666004)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(30864003)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4h7lQ8fxJPeo/OWrq6WEDDUT2hffKsdFKakdPszCzWD8ybmqiImUI9xidOCV?=
 =?us-ascii?Q?ERZHloX3GLSmsjzKnBDGz1yesNK2Fk+I/2Vvt/oCwZtA5TS54Ayp4pzZY4kz?=
 =?us-ascii?Q?ANbA47flFsXzO538ESx4bXls2WRSk60zdcapQXeCXxC5QyVZCOMhJkpWxlvG?=
 =?us-ascii?Q?V5UWsWzvR0uXHjMuKIzSf4r2Miss8bKSI5RnxFt3vGsMnpEzRyjb3VdTenR6?=
 =?us-ascii?Q?RcdzZAm8EtUqGFdmxWn/axJTQRtFJIh0ETRkXIHG1/EarBw57fFNsXr4L1/k?=
 =?us-ascii?Q?p3KvfSmkGEbHJsr1tGYHpLJ3cfQag+gh/ONifPS2n+NYUXS/Ak8yNJPsz0bD?=
 =?us-ascii?Q?jdHg21sY0bWnYKP74+DcVidslXlb4yfSEUGONPIqSMi/6wV9z+5NuAOsHkVG?=
 =?us-ascii?Q?UiTOCRcwQH0mA1s8T6QRCPXF52R89LM4sO+X88SMqPwaK93HwAPDUYciIIWS?=
 =?us-ascii?Q?R4De6hWiG+/e7x6yGPnLLEAedXHj0lfUWKkICMCCAPZyF60oakvFFlVt3wuD?=
 =?us-ascii?Q?E/aWmoE70pgbwJX8MIGmI6qBQj+4WeBo9voSRnsxOtGpUrgr8a/E3oxJnwFK?=
 =?us-ascii?Q?f1+njaDh39ofus0RK9ErvZd6EQLz00yEEurkxAl4MM6iVKQGj/oQBe8tNcFO?=
 =?us-ascii?Q?YY0LMNDowy7NGLtiZwsacHqHT5WUBQvVLvoH6bkwuALgaDAistw4nA4vRD6c?=
 =?us-ascii?Q?2k88/KWfOHnv2sn3IdwqSTxwYQI/RUUuDIIdQbFmZDAfa+hFcPzysWjrvQWE?=
 =?us-ascii?Q?ncxMlTGbKXEyYRQzGh1EOXXqT1jcuDAHyX5gDTrjbxQ3hlcV0IBkf6xrQB25?=
 =?us-ascii?Q?CTY84d/SIRivIHABtr5dHAOXpGFgB+F77kYNOUh6Iw3VJduIx1PoTtWKFSGb?=
 =?us-ascii?Q?5PLrP6KCJp9Fto9rsluehqxC9XtKic6Dh94kv8DcM9D5fKxj6+zUvHUG995R?=
 =?us-ascii?Q?W28+sIUwFlfBseGop5ATVD0wJbGVPC3b3vnfr22Hyxy71g1zjZEK80F4zI99?=
 =?us-ascii?Q?YvIaVYyUXMYZgr5dIVIl2kEshIsfTQwggla4hciOiS48byy10QisSvrx/ALR?=
 =?us-ascii?Q?g9XwU6eENj5IwB1l16oErDO8aN3wrzBfgfLF1gUp57D3b9iJ1Gq6F9ucEK+s?=
 =?us-ascii?Q?lysAPcmOdSq4hEkhFYCIRzVek27FPqRaXz7ZWK8AZf8u7rKtHji+Zu4agc61?=
 =?us-ascii?Q?wzYfzOJ3dRnQz21Vd0xf0EJ7UHp3ADI1lFVTjZUQcdA9PccjYuHKT+xZuYHJ?=
 =?us-ascii?Q?ixd1uYaf5/tYO+2lSeYqiq1OMnq8gFNlFWuqYuGEE4QOpfTXPenQ70MIv54i?=
 =?us-ascii?Q?fJuGEjF8LGXRq7Xs2+vu7FY99Ip/YDX3IWUoEOmc+5g2wAllzMGB0pgJZ2gc?=
 =?us-ascii?Q?eLAsGJUwkLMnGSFdpcHPx8POpK9Pt30tDPP4M8lzaJnh426VVRwYJovmMEXd?=
 =?us-ascii?Q?PvJqJtmynL7HuxNn/W7Hk0evu8CqKN4jA+yxZI3L1JfCkUDsreNDAUE/MJ5g?=
 =?us-ascii?Q?A7JnQMuPoR5slTNSxsWnDqPzaDLbvi34MDOZgbiHh1cE88DijoQfK0DektxI?=
 =?us-ascii?Q?ch8FXrdXseO/sLfnucc4GJquvrxUWullHgCx2Atby6QAGyWxczjvqamr/0yP?=
 =?us-ascii?Q?4LE+VwSBX9bPLbwib7uPAR9kjfItghzKwEwHxtCyAfCR?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ef082e-b610-4fe3-523d-08dba1bbf6b1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:28:07.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amiFF3G39n/sMHE896jiUSTNDAxLY/F5ljuFBop0FLE3bgobs0rHu6TzJtyCSFdvraHjXrQjgbX5TH6Ou82qPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v2: None

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
index c1c1b4e1502f0..933a53ef81197 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -658,8 +658,8 @@ bool hv_is_hyperv_initialized(void)
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
index 6c7598d9e68a3..920ecb85802b8 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -497,13 +497,29 @@ int hv_snp_boot_ap(int cpu, unsigned long start_ip)
 
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
index 24d7f662a8beb..2a4c7dcf64038 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -43,6 +43,7 @@ static inline unsigned char hv_get_nmi_reason(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 extern int hyperv_init_cpuhp;
+extern bool hyperv_paravisor_present;
 
 extern void *hv_hypercall_pg;
 
@@ -76,7 +77,7 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control,
 					cc_mkdec(input_address),
 					cc_mkdec(output_address));
@@ -134,7 +135,9 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx() &&
+		(!hyperv_paravisor_present ||
+		 control == (HVCALL_SIGNAL_EVENT | HV_HYPERCALL_FAST_BIT)))
 		return hv_tdx_hypercall(control, input1, 0);
 
 	if (hv_isolation_type_en_snp()) {
@@ -188,7 +191,7 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control, input1, input2);
 
 	if (hv_isolation_type_en_snp()) {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 14baa288b1935..3dff2ef43bc73 100644
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
@@ -429,6 +435,8 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.shared_gpa_boundary =
 				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
 
+		hyperv_paravisor_present = !!ms_hyperv.paravisor_present;
+
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
@@ -443,7 +451,7 @@ static void __init ms_hyperv_init_platform(void)
 			/* A TDX VM must use x2APIC and doesn't use lazy EOI. */
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
-			if (!ms_hyperv.paravisor_present) {
+			if (!hyperv_paravisor_present) {
 				/*
 				 * The ms_hyperv.shared_gpa_boundary_active in
 				 * a fully enlightened TDX VM is 0, but the GPAs
@@ -534,8 +542,7 @@ static void __init ms_hyperv_init_platform(void)
 
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
index f577eff58ea0b..94f87a0344590 100644
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

