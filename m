Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED991779A9D
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjHKWUB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbjHKWTp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:45 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D22D57;
        Fri, 11 Aug 2023 15:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEs30HtORHNSxeMXCdjV1J2B0SXQkQn+xU1CxdkQqeR/axSkYaUVU7PiF5WdeQl/JWvLkGcn/VcnNgHcoWYy8o8a/G6lcwf/E+yTtA3CifoyRIna5/N8M0nHKuG1tjJ26kPGgcfbfGe62HO+1stugb7E660ojvdxo4Qvon2EhtGSjwSXi1PeiOjgsJ0o+ckPnJlH+3ptwWcPTyhEB+6dEudmaoGU/J4oKFkG/SSAqNMOaM4ltSRttHfzd9sublLjAvbtPxNvIKOWD1v8QrHAXaos+Dk05VPth+x21prGIjNjbam8ImH/cquHwvKzGrsRFdWJu5zn3eQCZMNrB/it4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDm3zWLM6/sq1ToH6J3xOAqticgaoaF7xmZMV/tzYeA=;
 b=ZWZODz//pxMw4H8llF2JJ0CHOSpL7EBQUBWUbBYg6C7CA+DLlpudiGCfSA/A9Poni7RZyDKU8YuciheHO3wswwNXF6v+q+PF7Fh8CASQPIyfx5mfKOt0Ymj3YF3Yv0VSS3cYLF1Ic7GBWlZSt9uQETyV+lHrkHalUnPLbrDSRlHV5MpbihEKQuhNCYfaXub1vWxGq7zOmrsJma9sVIWv3uvwMo8kj+4RmyVhdYYu3WL2vnjqdiiFZMPZ/HACyhD39yO5q966cXoCLwmsnnfsLN0woG5KapaN+9MZYQXG319TyZaCVgO3orjH0P21d7dXDb0IqXmw+JFXL43/pLnT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDm3zWLM6/sq1ToH6J3xOAqticgaoaF7xmZMV/tzYeA=;
 b=dUrCpC3E3JUNyyGXCvKY+yb/vYXTHl4SfHVXEuGvVvAIjEhRfEAWTxRlN4yc70xmUXtO8hlI+kglIn9a3POZpNx3j1g7ElbBTk7G5R9G6GNTbIYVmZki+8P9ErW8LimMyYuGIACQOuqXWd5D09if7PcF7b6Yq9wJfNtEFVucX4c=
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
Subject: [PATCH 5/9] Drivers: hv: vmbus: Support >64 VPs for a fully enlightened TDX/SNP VM
Date:   Fri, 11 Aug 2023 15:18:47 -0700
Message-Id: <20230811221851.10244-6-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe0f7843-ce9c-4d3e-3504-08db9ab90d30
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hia2ktRijHbm4deTCf+9sPgTPb11H787AvOvd/BvtuljyROe5fycNyMlYz81rS2jVkr3/29fQkLbxLl0BYrX8kWGg8q3QrnPxwBeSdPh2NdkDNKlfX+5+kYhfAo5yuOmQFdk4TRAbdoFOuza4gJKsyhjUuqkw0xF2MLheFLSIAHGQKmQFY/Mj0gOb7HCCjYOl6IGGFK+zjnpI5AbayicOGjvZ6iewwZQug7Q0pw5p44k6sMURQt1kiH29p13YRhg6mlDLLB176MVMLSo9eBQsb1AczmHwJ77so3yi8KuApcZmDifBcK87QYDx3w1xbDqCk+dWZ4+496HK/wJsuWG1VcQ0hMyKMMamXDutaXWGKaBcJmPeFBYGKzWQKoCb+p4z50QlRBrZzvo77+zAmaLPJXXyPZHnp/9kHmHqpGVNlWN+E+2mPOzoQrnhe3NDntj5oMvlN62tGSzBqlmoClBOUO0aJQJqZG+dalpBssJ8Bmo6oE9HkKM2J/wVW0hQ4w5YI4PLgyukZbctmofeQs1IbH1q264rmVcz0ZyrXs1JmT1PKgrEuDHqSuYcQbO0h59NVYm3x+WteR7VCJzymvxRJe67o76zSxvG4US07y7jBg/Fyzd7Bn25UMG3+mv7X6X7uHAeA0lKgv+TEseBsht1Thw7EeDUe1jNojuitkgV76jiUYbGwk7UYICWD+O/M1/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(6666004)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A/D6PlSH+l8Ew+D20LmRNMamxVbZltkqWCSgp67l8rgFN2s6m2Y5q4A4DOXa?=
 =?us-ascii?Q?TfkGQcS5lw0ISXNoo2FfoE8mAzXAY0PlbgQOH0Ne6g5uEe1uN1nsTyj7vz0d?=
 =?us-ascii?Q?WUbeNq6w/x6xVc3+SyRTCvQqYJdnaW9zPUD0DlMkZCHUYnep3Ds23Yif5893?=
 =?us-ascii?Q?r06BFUGMq18bcQcK+DtqBdNmVUT28NI9z3iId0qSkLh2yS1W6hAJgDvsFFTn?=
 =?us-ascii?Q?d9IKyg2Mb9QLkNeHZzuXrO/HBXwVpr0rNrGd6tM6jVJHfH2mYfl39nUkNi2M?=
 =?us-ascii?Q?tLFNcZFv6jcE2Pn82LEJCkwDFG3/S5xoKLkLgrQWzH/U4nT8QuHnYNjoVP++?=
 =?us-ascii?Q?G6qgEx+PrvZAIesJORJ4lLAhhcuw5RNLZq0YomiVvI/Lh7fkGXdyNRCjKhUW?=
 =?us-ascii?Q?rMDBsPJNDjEVWvGGIbO1IY589/BgRanCeD286pbLlb5c2W0u1/k7taZ1GabF?=
 =?us-ascii?Q?oeglYZJeKcyCJTKjPay9R04FhL7MyfQ6vQLy+CtMtrDwaCbIG3Htov1t2Ub9?=
 =?us-ascii?Q?26yxQtjEwGzxsgCNEL5d7qz8XmcK/026oUnNxNxJUpBw9D+6BxeX9jwuRkPj?=
 =?us-ascii?Q?mJP4X+/7O2CzGga6uiRT3QcaaOSUZEtZOcgwsSGCCAEtuWxZTctmpXKsr0JI?=
 =?us-ascii?Q?24GAZIMe2VZU/aPTAhxckH6v0LqfiDLXYiy0uXXTXZvgL4O1eAvbiHfgYeEQ?=
 =?us-ascii?Q?JLb7q4gGnmbpMlPoV+dzxykCKGHQa8OWgwZIADTyI7ItSv7IFUP+rjMsp0+l?=
 =?us-ascii?Q?fva8kvvE85e/V5f9lmXVsWyc2xbzptyhJjOqkrgqnOBFh5lVnf2m5H/QgrO/?=
 =?us-ascii?Q?eMCIwXQtRiGoPoFvOG/IuYYwEHgbFqmf57ElIGOYeCAfyzQTkyLIVUxIsef8?=
 =?us-ascii?Q?sf0CzFF6M/vjY2XXY9sCqQbJI+8Tl54cRU8iuz7MAKAQg2frGuJ+vHlmPqdg?=
 =?us-ascii?Q?Wck8eeEWJcJAxlJzjEV9LKk0tEwlxt+WOk+1P8VgTAWgID46TEHdqZeVg7Kb?=
 =?us-ascii?Q?zfWqcnGmAEjh4f7cu4tZZ7/5v3XZoAyzsPtaPe2Tt0BThjVELpXuatXmxRgp?=
 =?us-ascii?Q?Lk8mAzrb5pwGqYuSOOYkz3RXcgx3KKBrhLmkOalGnRX4RfxeHDRrSf1uTUxQ?=
 =?us-ascii?Q?9WFAeUQKVMhNSJKzJaVjIPJ93We1QcDBTNZH2DcmbgkFnFnFT6Epc9Nus4Zh?=
 =?us-ascii?Q?DReSNVB4aiAPonCTQ2F7p0jayN50Yq4MJVslyCqykuA1+3unmXl1NXVZSdFF?=
 =?us-ascii?Q?PnncFboxhdhjDeCiHqPvIpuEWiTTvJOE/uKLbRM/sMQvQQnH5x+dKHkVU44d?=
 =?us-ascii?Q?R4QX66tJ+Y9c9LJFqmiOk2bqpm7Pi/U/LUzSWdUUBoz/v0UskfcCfLR4fZVd?=
 =?us-ascii?Q?fJEfDfUlIDgcrPHiuyifF09so5IK0AJK/HVk6oMFOT9T9o6u+7NBM1ToAV9x?=
 =?us-ascii?Q?DpmIF+SSICSu3WcZ4WUwxRqmoRyhVS5459xPzN3SNZhlPTKnomRsl+wQuRSZ?=
 =?us-ascii?Q?BJxIwuCFIJ6SQYb3YxwRKOxA+0Hsy3KV1L4NBZ14QtMYqXeQ4oMyJeU37i/T?=
 =?us-ascii?Q?6xUVGFD5fezH/10YlMRp+mwsDwLG3DL7epule/t1SBFYzzqcyO+i+7+qGxcw?=
 =?us-ascii?Q?OPMFyKhYgniiSR0D0YUyKg82bQatHgaoCaL3qH6DZi1W?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0f7843-ce9c-4d3e-3504-08db9ab90d30
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:38.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eqd6G8PdgeP8yT+mmVTkjcfbqSXxZhykXBVU1xOBZ18IZWp6GJnYbAH3ucPcac1LS57xli79eIcn008buBWGhQ==
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

Don't set *this_cpu_ptr(hyperv_pcpu_input_arg) before the function
set_memory_decrypted() returns, otherwise we run into this ticky issue:

For a fully enlightened TDX/SNP VM, in hv_common_cpu_init(),
*this_cpu_ptr(hyperv_pcpu_input_arg) is an encrypted page before
the set_memory_decrypted() returns.

When such a VM has more than 64 VPs, if the hyperv_pcpu_input_arg is not
NULL, hv_common_cpu_init() -> set_memory_decrypted() -> ... ->
cpa_flush() -> on_each_cpu() -> ... -> hv_send_ipi_mask() -> ... ->
__send_ipi_mask_ex() tries to call hv_do_fast_hypercall16() with the
hyperv_pcpu_input_arg as the hypercall input page, which must be a
decrypted page in such a VM, but the page is still encrypted at this
point, and a fatal fault is triggered.

Fix the issue by setting *this_cpu_ptr(hyperv_pcpu_input_arg) after
set_memory_decrypted(): if the hyperv_pcpu_input_arg is NULL,
__send_ipi_mask_ex() returns HV_STATUS_INVALID_PARAMETER immediately,
and hv_send_ipi_mask() falls back to orig_apic.send_IPI_mask(),
which can use x2apic_send_IPI_all(), which may be slightly slower than
the hypercall but still works correctly in such a VM.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv_common.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 897bbb96f4118..4c858e1636da7 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -360,6 +360,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
+	void *mem;
 	int ret;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
@@ -372,25 +373,40 @@ int hv_common_cpu_init(unsigned int cpu)
 	 * allocated if this CPU was previously online and then taken offline
 	 */
 	if (!*inputarg) {
-		*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
-		if (!(*inputarg))
+		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
+		if (!mem)
 			return -ENOMEM;
 
 		if (hv_root_partition) {
 			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 		}
 
 		if (hv_isolation_type_en_snp() || hv_isolation_type_tdx()) {
-			ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
+			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
-				/* It may be unsafe to free *inputarg */
-				*inputarg = NULL;
+				/* It may be unsafe to free 'mem' */
 				return ret;
 			}
 
-			memset(*inputarg, 0x00, pgcount * PAGE_SIZE);
+			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
 		}
+
+		/*
+		 * In a fully enlightened TDX/SNP VM with more than 64 VPs, if
+		 * hyperv_pcpu_input_arg is not NULL, set_memory_decrypted() ->
+		 * ... -> cpa_flush()-> ... -> __send_ipi_mask_ex() tries to
+		 * use hyperv_pcpu_input_arg as the hypercall input page, which
+		 * must be a decrypted page in such a VM, but the page is still
+		 * encrypted before set_memory_decrypted() returns. Fix this by
+		 * setting *inputarg after the above set_memory_decrypted(): if
+		 * hyperv_pcpu_input_arg is NULL, __send_ipi_mask_ex() returns
+		 * HV_STATUS_INVALID_PARAMETER immediately, and the function
+		 * hv_send_ipi_mask() falls back to orig_apic.send_IPI_mask(),
+		 * which may be slightly slower than the hypercall, but still
+		 * works correctly in such a VM.
+		 */
+		*inputarg = mem;
 	}
 
 	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
-- 
2.25.1

