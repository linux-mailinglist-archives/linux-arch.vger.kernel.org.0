Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286EB632D64
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 20:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKUTxb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 14:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiKUTxF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 14:53:05 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022019.outbound.protection.outlook.com [52.101.53.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D561929C;
        Mon, 21 Nov 2022 11:53:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRxRn+rOd4UqwNn9MVnJBQqTWPKrHT2YJzhK05F/qTQm2PHeWHw60uwSzgAooAadM7lbrktdjmkVKMhRFGHJ+xkk+ct+Q/0BBYli3YNkJt4j0OXmUhXM4kQ9uX4uo1ZdR/TL9xYUXaT+ZRWIwSB8baMN/UHI6LbirD2v1Ma7S28Ehuqqus/NQZXqVy1wpmNiooG4VwMxJVZJkxKdH2Q7e+OyF1gDnuBtaynu1uI7fy8TfygFUcapm+zZGB580unELBaoQDbE5JWArVNUSAtYBPWW8f5+3SfFwGtyXPXjzevCJvUYcojy/vzZsGnu9qZL395MINKpu5gJjeqfNer0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9DNDJsrttehAaDab5LVic1ti+liukgIoMo1UJ7xFYI=;
 b=AeEPpvFtjkfzwtNH3kI6hdIpNtpylvuohPs3wo+6SDLs6vRv7orcH8p4JKZ+kzBjwHd//IUEVGzyk4bC7WMb4dnIE3Ggu39PpWeS+LVRAMgbOBO7EHY88O2Kbb6Ah4xxmEwUkzHqxiqRbIo1314giLdb8aA2u+bXkRjT6xM/TSaofKYfaODReOWdnNE70LHwN9ipjRyBXtsLsddN+Vp05b1//i1IiadnsI6igRunumdYusszG5O+xjLRPAW/E5lVmb0fHNT3ytigRPW55GvFo/D+3sJY04UO+vuIatFD5alvmaQ6/p3wJ62EroIE56ERGBxggYITrWApWL40DvXgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9DNDJsrttehAaDab5LVic1ti+liukgIoMo1UJ7xFYI=;
 b=gcWzYidoZfELndoID4GW1Z2j75wnEfRSKCjgZWZCGPF3BcjNWbm/8xf9oBA9VRNOAkmBrCAK17ov4S8zoYM7vrZd0na7U7XgzpSxMkdqvQMJQfnA0xr7AH9u6QnTmWpIgeXIvTpDKes/y1TPlZ8h1gSrXT5qu0yUw2hsA+sTmtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BL1PR21MB3280.namprd21.prod.outlook.com
 (2603:10b6:208:398::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Mon, 21 Nov
 2022 19:52:58 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%7]) with mapi id 15.20.5880.001; Mon, 21 Nov 2022
 19:52:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 4/6] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
Date:   Mon, 21 Nov 2022 11:51:49 -0800
Message-Id: <20221121195151.21812-5-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121195151.21812-1-decui@microsoft.com>
References: <20221121195151.21812-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BL1PR21MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f5f61a-4123-4103-bba4-08dacbf9fd25
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsbOOR2STjbK8HyO4Dn688iwDu5DY6+KsjHrdS6I9u1a/NWnmm2QdgfB0OcgLJj4jOSVWUdOIJHT1LzC2QNt4Wc1C6djPjYTTdlKnMfIBSy2DoE0Nr0O39pHWJnDAQAR5VV9/s+g/SHnrQpbnn9CBU3bhqzUJ6OcsdIYfS57KJxdfjE9CCMzSWDR0WV+QByacWd6sgzsEBnaIeDZL/LDdXCtO1R9dJsPvRzsF4zJJjaslN5LAOwmuPLCpcRn09FAbc64iYgyKAWqOPw6gHOmeRNNz/VlxgDj+288M7tWUXcXhLax5PSUBpFq7dkvvE7rJlMFdVGRTOCj2oBQSktxl96gZ0TNtCwTq0KEZLN7qQqXz+uW53bIee2fwRorOo8oYoC7xaRqr9JGExaLsupGhISz2BzSETLLl6B5EltNesqnSh4ZuO0e0XEDo2Tz5Lst7bVAxq+OEbZsJbD0GvQaHvH1xd5/Wij5Uur91Q5gH4lNxa5cxIrq5pdEVnS7wEzJrOKP4FMuQhxAhUPavXOoyhcD0pqY10pezAlCbj1s8KM/aO0RsV6URAo3zKkHk5cKd4HS4rBx7+YKNDNhYtkKF6OT5peOZF6scfmRyGdo+uSXdrD8UEBD0FZP2UnIwI2uCvejqd735UgIfS+ogzcSEU/ctvicMNXm8MMu3RHJO9epWUW4XpCTZLTUSRFhLTrn7gs0MbLspmJPHtlFyDCgAC7AoaUikKuHnLzffhnM+EM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(2906002)(7416002)(5660300002)(8936002)(2616005)(186003)(1076003)(36756003)(86362001)(41300700001)(82950400001)(38100700002)(921005)(82960400001)(6666004)(10290500003)(107886003)(6506007)(52116002)(6512007)(316002)(478600001)(66556008)(8676002)(66946007)(66476007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8KhCxYIhc6dznErSNzpapVe9HxSjzOdN94HtTM+2lvwaKX+mlGMXRxA1yPo?=
 =?us-ascii?Q?Pyp70nz9nn+ZL5E7AupxPpdQFkMXP1BXJROJ4TA3MAGuaQLp1j2ZfChPh/Dh?=
 =?us-ascii?Q?FpPhEHd+PvdAzjN3FzElyfhHAkD7V/H/9ukIDC5JhbTCZ9YchinqeHRa2P3k?=
 =?us-ascii?Q?/PGlaWcM063oA47o05l6fkDOxLGriXy6N04+2rrx6mHfHY1FgCTOn2K5Gj14?=
 =?us-ascii?Q?GgiNybMnGKRyZyIpE44zM5X0e9OavI7UN7ba+9ztT78qTYXRLEdooaApLZx/?=
 =?us-ascii?Q?EfHM368wsOYAgbo/Aef9yg41Cj/YdTLBB3D9PEuTCgx70Wg+hNHGl5slcSN6?=
 =?us-ascii?Q?MwAnQFFa9Fx+oQY1yi+Tuoj2FPSpSoY/Cvi+F7nYobJ/imlhOAa1xrkl7rTk?=
 =?us-ascii?Q?PxMobE+jDkPh58z6tA0P5Hab55HXiyibUXBc67EXDyUF1Xg11z0PraNSnMWl?=
 =?us-ascii?Q?aKjXuU9asVBxh8msXcqXNBy1WwtiybbkSPsZp5m50awzqGyenE/jpXRBs/VW?=
 =?us-ascii?Q?glOZS/4ub5vSJuG285uA1VtH0ZFsP8e/oh577KhP5gJFfpkffwczXIY7qAo+?=
 =?us-ascii?Q?qotDvHdS5olzw2E3yZ/Egtgd4cxvJA3X5S/CeG4RZ/QagmDdsTx9ueHkxXu7?=
 =?us-ascii?Q?ySr5sr/00U9eXXfZyuNLySm5wMKX8dMp8GWFHrJWzVyMh4a/ceQ2e/YRSXfi?=
 =?us-ascii?Q?Rlz8ehrq+McDpcnI7yqhsEWO5r2p/UhOA1l6AP3ZldPp++LdxN/sX50/Htsp?=
 =?us-ascii?Q?uE/DcF5KCJqj8L4rHjjBp2yzBf7prScPI/ltjiPIoiZ/uLMMLogSYNohSTfP?=
 =?us-ascii?Q?oBbbwFRiUYbwk589AiCPFlLKaCX73DRn450UK8wsR9eKu3JwUYbS+44OAySW?=
 =?us-ascii?Q?N+7u7Q7qJZsmWzIRvN+mgUjVb3VC1uRwMomniJlFXIBHCRkOjGi+GfPlzqi0?=
 =?us-ascii?Q?v7cl9Ze3SGH3hLo4pTKsyZgfa2aMajxpHqucSfXQ3qIP9qHwqXGRjooxwEBh?=
 =?us-ascii?Q?XwO3r6fUpwRnElQDICvFJzRQN3IN9uhdtOi0AwPnDC4kTzyr7OP6YJUvQyFW?=
 =?us-ascii?Q?W3Hx/P4AJ4L1ZB6dvkQ5XAmNZUX119n4tEm0z0trpIoMbCQMnInD6hqg6Pj+?=
 =?us-ascii?Q?fA5wJNbkghRjWx84x0Q29s356u9p8/zLdSOv01r5wm8agqgI9XUVhr+wnFXa?=
 =?us-ascii?Q?Cn9josgeN0/JAIsbn9xnfOYN3sHbRm+POMmraiE+DIp3N2kUf3xZ0gKKtH4E?=
 =?us-ascii?Q?A+iNGey+Y1CtbIBlssSiYb70h2SeITsaR+WZmUD36cTxqvuwNq9TfU5vlOVv?=
 =?us-ascii?Q?RMuSnMbVLDn6GBACmLbG6IOXiDACvysf2uApCAxj/6tvydIMnqe+hJJEn4pw?=
 =?us-ascii?Q?cecF6cHbV/X1XpduRJWQQsq6uC+ly2NsfjttcotIINiZfqmufcNabgNC+4+P?=
 =?us-ascii?Q?3ZQQD/GMTIjcc6MQOOvcHY6me1xw/HmUUQoSDDBl9COuDUDQSYVvhgVrPfEF?=
 =?us-ascii?Q?Ukqv9b9HkQHUNJkCyxggha89dgFauew7SBncDeDbSC4tHWyjyW0g9sSHIspd?=
 =?us-ascii?Q?rkJfvsHumTbINBPYEuAYAVu4p/S1U6O2A/L9Np9lBa9sjcGC1M/jeYKgD9t0?=
 =?us-ascii?Q?sFFOOM/dj83s/6rhyn0gKxfbFU/YuZYyYAewY+YXxm74?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f5f61a-4123-4103-bba4-08dacbf9fd25
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 19:52:58.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3KAExd2rppxm3+R5G1Rq3QjBvQnYfuTWDGV1jiv+fZv8P8T1Dy43Y5dQSgny6YajwJlGXdAbxuU/mRKWNVL3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No logic change to SNP/VBS guests.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/ivm.c              |  7 +++++++
 arch/x86/include/asm/hyperv-tlfs.h |  3 ++-
 arch/x86/include/asm/mshyperv.h    |  3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 18 ++++++++++++++++--
 drivers/hv/hv_common.c             |  6 ++++++
 5 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 1dbcbd9da74d..0c219f163f71 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -269,6 +269,13 @@ bool hv_isolation_type_snp(void)
 	return static_branch_unlikely(&isolation_type_snp);
 }
 
+DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
+
+bool hv_isolation_type_tdx(void)
+{
+	return static_branch_unlikely(&isolation_type_tdx);
+}
+
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
  *
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 6d9368ea3701..6c0a04d078f5 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -161,7 +161,8 @@
 enum hv_isolation_type {
 	HV_ISOLATION_TYPE_NONE	= 0,
 	HV_ISOLATION_TYPE_VBS	= 1,
-	HV_ISOLATION_TYPE_SNP	= 2
+	HV_ISOLATION_TYPE_SNP	= 2,
+	HV_ISOLATION_TYPE_TDX	= 3
 };
 
 /* Hyper-V specific model specific registers (MSRs) */
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index fc09b6739922..9d593ab2be26 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -14,6 +14,7 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -32,6 +33,8 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+extern bool hv_isolation_type_tdx(void);
+
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 831613959a92..9ad0b0abf0e0 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -338,9 +338,23 @@ static void __init ms_hyperv_init_platform(void)
 #endif
 		}
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
-		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) ||
+		    IS_ENABLED(CONFIG_INTEL_TDX_GUEST)) {
+
+			switch (hv_get_isolation_type()) {
+			case HV_ISOLATION_TYPE_VBS:
+			case HV_ISOLATION_TYPE_SNP:
 				cc_set_vendor(CC_VENDOR_HYPERV);
+				break;
+
+			case HV_ISOLATION_TYPE_TDX:
+				static_branch_enable(&isolation_type_tdx);
+				break;
+
+			default:
+				WARN_ON(1);
+				break;
+			}
 		}
 	}
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ae68298c0dca..a9a03ab04b97 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -268,6 +268,12 @@ bool __weak hv_isolation_type_snp(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
 
+bool __weak hv_isolation_type_tdx(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
-- 
2.25.1

