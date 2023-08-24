Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C917869B9
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjHXILD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjHXIKa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:10:30 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AE51727;
        Thu, 24 Aug 2023 01:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCNX+ommUUGX5WwV0CaB0wK5L7Rr29/1wTCdnIjIEjxkir25hwI6ZvF/5aMW/ggQiSuuwZwcRLV4uZ9VSKgFV3CtUWoNom21n+W6ut0tEBDwEt4VujjzCeBJoBxM7FDwOtxmapCte3tNL0qofISKXwv3RcZPyVwhuiyDMGyOlEYhfhh1pvPYaAVc5KB5vQX/BPHYP8OjQ0Zajz2bBUJ22I+KE69ivnBYtc6mAwVMuQAOAZRKFf9g1V6H/CMrGedUubj947mVUhlkfI2YK5TW/xIH+8S3/WVuFrgni//l6dWM3CfMjHZ9xHMDju+j3hPWRS7pVw4tQ4Y7ai2PaDv1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7a2HVOOmebTGDDQKx6O8R/NiZ/wXH72SpwoOHafJtQ=;
 b=GWBht9oMOurJsSnbCMRSIR0PlEcPuoDSbh6OT7pHDcnLvyIXsNuaU4lYW9splZPRCoQneciXKUIMgGUBR5nDooksn5vnEDKUgXWih5SPt8mHj5AWVyvUGeUKLmXiD9S7XXy/1BTGjLRJ5laHU1oiK3vUyZWsy8qucK6p6QcVXoaD77yGlyirMGUFPDMz/zy15RlUomGMtYImF3+iE9L9aBwW1KqMTTnzJkAujhY1RLsWUSXC4CxSkYug0F9jQpVZlnGK4jQABDYNIdWQqz7q+bn5Dk4y4qabPDZh4yz/utcYFvAby5q/TQr/E/8i6Jo6le4Ghn3XQOOSW+r2a75a2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7a2HVOOmebTGDDQKx6O8R/NiZ/wXH72SpwoOHafJtQ=;
 b=JXVDT5aET0FKXMpYPjYYB3tA/RkDjSjjvV/yACV+TTely1ZYqToOJnA1BtycXp+D8I60NjB0YZzxqPh8cWU+43n5noZIBIppqSmDcaAiqr8OJLlKUXU/aALRn/e1lBAV5n7PUCnQXPFm5t8NuHnssV5CWOg86HtWB2Bkp2rwWQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:08:03 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:08:03 +0000
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
Subject: [PATCH v3 04/10] x86/hyperv: Fix serial console interrupts for fully enlightened TDX guests
Date:   Thu, 24 Aug 2023 01:07:06 -0700
Message-Id: <20230824080712.30327-5-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824080712.30327-1-decui@microsoft.com>
References: <20230824080712.30327-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0175.namprd15.prod.outlook.com
 (2603:10b6:930:81::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|PH8PR21MB3901:EE_
X-MS-Office365-Filtering-Correlation-Id: 102884b6-2aa4-4319-0a49-08dba4793d17
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gi07ykZblRW+rj78rdS5d/h+X93nGPNuDqgtksUjUDGw97S6lF0c49FcLbNril6MPM/WpqbohAXOEvIT0FvIfHwVAsOwf/PUA6Rw7kQuuDseQVQILxz+2IDXqupryLWuw8EVeO9UC3f3yGK1jXcHdVjNhSfaF6IK0tGOpXjOXfGjweziiGMoKqS8UEeIy+OlVrjp8tovT/1KdIr2KeY8IyhfqMX2sFl7zgNt27mK6QJWRekrk+EpsjnzMoZP+D/ONzVtO9lksa5MXxvvqq9HktJyOIc2f4FNEfFt1DReMW3VfcRQ8q/cl7CeCtMmDNxTchNIGG7q5TkWGkfU0Sd15qyvuSZAW/92k6FvnaBZDWbay0tVGgfmuRGWVaZE+TDGSao+ZpAwFmBf6yr11Sg0LqvpwyTB6J/29BJxILnRWQQNGr8v79UjOcgHUoZOUcvvuxeEcPTVwtTcMq2qcTbLYkDqEo6tIoUSb9djNRqOSK0k7bz2G69gYrsFm+rSi3LNEPMUkSm1PU3y64LCFGevfc7sQcALVzl5Ib6oiH1fXQWj+2cHwZPnqM0TKbRA+xxf+y2dtihWls/Q+PeSrLWcX8Bs5e0Fyx5D9vfje/yAsLnkNPTrtc2L6KZSkWFhZKlnj1ZdEj5qkToftXasZ8eEnsub6litYYYR3hmoq0XTSyDWVO4TPazy9qqj7tbCELre
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRNlRwYk7T/+vA3jP/wG2HIO5UkCQwcbN0wpohs24WR0rZLQnt30CASW9qjU?=
 =?us-ascii?Q?vQxwl1p/bpO56Q7n0caRSLbKt7IMLyc2CyQf1tlIiPPk8tNEKIYKV4t9iUyK?=
 =?us-ascii?Q?VfiAp77ozsTfSRguZX+vYbVQZ4P2tn1nyS2Vdn9Zt3xc+7KEivHBHUtbbmCy?=
 =?us-ascii?Q?vojgzAAsqnttFivlwD6YBCVVsJvaVne7Ujh/uhPLsm0F2fMfpYCoqLw4ccXa?=
 =?us-ascii?Q?LxCboc3umDekzmqKS/STU5OMKAntdlfazVVaovFMiqc2I35vyyItQ6xcCnSJ?=
 =?us-ascii?Q?okAzsb4k1eKPEM3zWpcNlL/Crext7kvwCzWEKftY+Q3DQLDxTjcT3mHNa5A2?=
 =?us-ascii?Q?SXcM+b6pNfzNp2ncmk95sLlcJk4zln3VdY3iGLBxXdraNQ/oCWMgrYIn9hYH?=
 =?us-ascii?Q?U42E/NbDbtAhBxxxmFWGkYmg9+aWSUzyH+9Cbnxbo/Tf4sPgUsdPoynPk5JJ?=
 =?us-ascii?Q?I0cOILIw0CCDC/U9KRLSphO5lk2uQRCPM39Z4vXJQIEQR7oDHAv1VxfPn2C4?=
 =?us-ascii?Q?ZQfTiZA/FRLwuzEN6kt0gt46/E3+TE/AK1u+Fe/8KngH/b7r8sLk08j6wp1q?=
 =?us-ascii?Q?m3BEfD4obVbAxm8ZZ164y39RdBmZt/tgBSDrXEfOu/MXqXRHKeJXWjWb/S5r?=
 =?us-ascii?Q?UYz+6hmDaMazX7FYYGiMOpeB47lUIDnsCB18ON554T4FnAPue+d+YA3Qb8XP?=
 =?us-ascii?Q?7kA9BLHlHKwQMK18E5kUDA9VTmIqqSCBUE3RP+uFC1GXfiHireGfsr3KMpAe?=
 =?us-ascii?Q?nNxcla8X9TBc/ovq6iATYBcHLOhyJDifWGET6v/JKv/RpJomfLPd1RgPMLcs?=
 =?us-ascii?Q?EotJ49lRcF1tDu09SRwRPYwqv4A7aCvGndK18hA8CZ1jwZbHpz1DaQtOzV7b?=
 =?us-ascii?Q?Bbsuti81zzHgJPTTRxPcVTLZK0k4P3dqoUUqXpGjxTQgOIDYsIk3Oa9vC9GW?=
 =?us-ascii?Q?izwM7XQDLWKybgxjcOhVOgcxxBGKzYB0yc7Uc5emaNjwUKidhHPvD5LTgZv+?=
 =?us-ascii?Q?bWDYJNngvrIPSMqGBYKBTjPXLZrpOw932I1qPIgnurJFIXh7q45heeAg3qVs?=
 =?us-ascii?Q?ZN2ZNocJcpmp9KtxA6Rouht7hLZaoCsbOPfIXMbblk56ZLvGgyxFpzWkg0qU?=
 =?us-ascii?Q?iJSS/H+B683ONuJC5bB3/rC6Byg4SD2uE+OmqDZSClINjkODhDnKD47OZuCg?=
 =?us-ascii?Q?GwTQ0Jc+SY795AoUUsRxJ+zsyLkP2iIK4tP3Wa7TpfLcm65DTJyHyhQA2sFF?=
 =?us-ascii?Q?pzeHVGG3TUPLJQ4bAwRVU2+Rz8QrBWnFKTB1QPOANuGLu3OzqFPehKaZ/VYK?=
 =?us-ascii?Q?5p5ZGU8D2REK34s+s+zrAKrLs+r0eTQ676qiHvM0H27Vb6lGNS+FdPCwhQ/H?=
 =?us-ascii?Q?KMychYB+5+DU318/GOJG9pfnqR3sjvo7aqD0cJTKnAjIKpDgksF9JJtXrVKp?=
 =?us-ascii?Q?94tl+1pWR1PrZkR/rfz/aB06NZGTeEfkZlG6fQX+efWUl3J6x1NmIAelUi6P?=
 =?us-ascii?Q?jJqh1UqyQuC1R7tZtZoV71VTkOHSjdN5+tSD0VQOZTeXJwvhrhvc4YSbb2J5?=
 =?us-ascii?Q?AJpSUjYjlisnMyiHjs+SIWqZ3u1J/HsuO3qH/pcac4dtmAr3V3DOnM0PrApF?=
 =?us-ascii?Q?DoiHZHdfoWiPHC3Ucbq5TucssXIMe48D6ROm/Ctf33O2?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102884b6-2aa4-4319-0a49-08dba4793d17
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:08:02.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmVMwdMuljfuPYbi/uQqMpPRQFc8AAeIcnurkEQQQ31G7nF1lEhi+EH72sMlshKGS8nweTNvaLjXU+O3EJDk/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a fully enlightened TDX guest runs on Hyper-V, the UEFI firmware sets
the HW_REDUCED flag and consequently ttyS0 interrupts can't work. Fix the
issue by overriding x86_init.acpi.reduced_hw_early_init().

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2: None

Changes in v3:
  Added Tianyu's Reviewed-by.

 arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ff3d9c5de19c..fe5393d759d3 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -323,6 +323,26 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 }
 #endif
 
+/*
+ * When a fully enlightened TDX VM runs on Hyper-V, the firmware sets the
+ * HW_REDUCED flag: refer to acpi_tb_create_local_fadt(). Consequently ttyS0
+ * interrupts can't work because request_irq() -> ... -> irq_to_desc() returns
+ * NULL for ttyS0. This happens because mp_config_acpi_legacy_irqs() sees a
+ * nr_legacy_irqs() of 0, so it doesn't initialize the array 'mp_irqs[]', and
+ * later setup_IO_APIC_irqs() -> find_irq_entry() fails to find the legacy irqs
+ * from the array and hence doesn't create the necessary irq description info.
+ *
+ * Clone arch/x86/kernel/acpi/boot.c: acpi_generic_reduced_hw_init() here,
+ * except don't change 'legacy_pic', which keeps its default value
+ * 'default_legacy_pic'. This way, mp_config_acpi_legacy_irqs() sees a non-zero
+ * nr_legacy_irqs() and eventually serial console interrupts works properly.
+ */
+static void __init reduced_hw_init(void)
+{
+	x86_init.timers.timer_init	= x86_init_noop;
+	x86_init.irqs.pre_vector_init	= x86_init_noop;
+}
+
 static void __init ms_hyperv_init_platform(void)
 {
 	int hv_max_functions_eax;
@@ -433,6 +453,8 @@ static void __init ms_hyperv_init_platform(void)
 
 				/* Don't trust Hyper-V's TLB-flushing hypercalls. */
 				ms_hyperv.hints &= ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
+
+				x86_init.acpi.reduced_hw_early_init = reduced_hw_init;
 			}
 		}
 	}
-- 
2.25.1

