Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69465781FD7
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjHTUdN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjHTUdJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:33:09 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17C3123;
        Sun, 20 Aug 2023 13:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLhNRwW0R8C7dx2odOQ4YwO0Hl1Cv4jV2XPw4E4FKqw5VvAiA0sN72elHvmxGBwg1o4OMMvK8tdfJj2tiDwf7YkSF/A0A0tsyRTCOnLhAbeUs0oInrnH9FiZTZjMycn4N35iqkJ1429r68WYL8+WHVB6LHoDmDkd0ooqcw6/FSfeNx+bOAsraCwz5RST5y9tHE2PPYNNew09LE8+sQWdIL22juijDQjPUf83d94scdKQkIOXtIEzKnXZknGzRpc+bIKccJkcPqsAI4+7Vs7X1FEpeUC48fs/gVDQxQE6HHrbaSHE17329KzmEiiDlSfFvVBkC50izf1q74MCxlUXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wAs87Y7Yp9g/1U6NdM1e1yymuwHjJFzerBECHGcGfI=;
 b=aeFlpBmSzeteeLsWLzt1MGHX/EeUVqL1I1W6cJiRTTSE+/W9iHukYUCoBWqUJR9BfHpiPk9CPR40BaZVROmnzKl8/00qhuVn0iH4/C/PRmkgnAxW5BfSbgCEYqatM2Q/73VZstZysYOOo6TN2hxGZxrLSTKnckII1hIBhRNFEg7JZk/5eJG9IUlf/VxG7aQOGnECLGvkXrEe1G25NLffFYWLGrYfbQBIfpt1NdXKUwQbFzDvUh7HdNXa7yfn0T4pNI5x2shNnIiRCmou2p+26iNVSlj9eX8yjRaiDxika+KPvHD3ZUgTNlqLYx6qQMtawjyFhgCguSjzVAFcL1s5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wAs87Y7Yp9g/1U6NdM1e1yymuwHjJFzerBECHGcGfI=;
 b=gyXHPIh4Tt87cv3DTgnryFi+/Jz66xZ0BoFcj/HlhNjjXEC25NZXVFXViPJKnybFlYSb/h5phXzolLmOHnVC6bhKobsIkpNL0JbApDOoGvulZhAtx51I1SsfXq1lDi9xYHQpXdfBt09gAXn1zCk5H/mmvaft4Zsmrkl2lRo7HIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:28:10 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:28:10 +0000
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
Subject: [PATCH v2 7/9] Drivers: hv: vmbus: Bring the post_msg_page back for TDX VMs with the paravisor
Date:   Sun, 20 Aug 2023 13:27:13 -0700
Message-Id: <20230820202715.29006-8-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb2fc2ad-5a9f-4333-fa48-08dba1bbf867
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkwDhRmkhV0tEFjCac3i7YjDXsr+UdPiEeak42DTKOpTToiJ6Vqjuys4QYAWvew8JomHkQdItGOGW7Kxum1V5jWtXpTueIrDbpQ67pbrKek+cwyd+7JMczPah72urlVrpvI/IzLvtwFJIa3EdvDt1yDbSgoqf4BsK9/Ev1FRkIDUEjWCUiNxL1g5m/MYPrz84rqEDWLwX6kJEpMGgPUXjJsjdxjKoHZNSdFmGk1t82WsGsyBALfVOsMRKy5WkXSYyqHz9ZvCmeQ/G8CJH8rrLPjQGKxw7mj1odLN+vBSqntAmcDfVfRMGhbcbTzcZbV4vSYGbY9XMSVgFX50uShqvhbjjscIgS9ZxRJkwmx5dOcBGdOid0Ld4Z7cCqhXvpxt6AoQJPfijcoR+CRIwpNByxMQJFl61ddLnN1rDDbMMIcOu0S3W9Fw5UWdiNDn/bb756cQPProWk2xJFq6mxcHeiQQlJW87obt8z4sasbqMA+Gxz95zceh1AvYRfJWCifB/YMJH8aT+rvm0PqghzslOFgJEoFk7VhZKUfnjPdvILG5rVTOtsPUrE54pmdKmym7vTKClTCaWNZabFX52seks5KNkjL11JCqdkW2E6HGUAT1B7aSMqa7GNYtbUtFqPEpREuMHj++QacqNGgwyBY9Oa+DYWnney3iNDUTxOIw6jieHt2r2Q+v5eXxB6KGMhOF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RUTvAdV07zdGFLVucQNsxPtkvte5iYPQ5HK/CBus+VnU89k0tOh+FXTBNW82?=
 =?us-ascii?Q?eaJwLCMoCPiO17ELfl7NddX2auUh/dNqoWYIKnLzlk8rzozsTVBASJ8lowhx?=
 =?us-ascii?Q?s+6ll7tQ38kJi88tn7RoP6c/IBzqkFTQ+siORQBVX93gKN+Iz5MrwWAdYCX4?=
 =?us-ascii?Q?OlYkGfvZwTsNySBXEoTns9TnTpwAJ/85lsIY8fkB3X7jzSlqv+qEV3T5cizo?=
 =?us-ascii?Q?HH7R24q0mIwkWmuZnGxxvkNW3ZWFAO/MI1YQZ4/BQukYBD77H/UogQKyUZR3?=
 =?us-ascii?Q?PTOEpqcPkPTfb8kCBrOjoVSWkI4WGf5yVBKqqNTe8ysoCWYfzbS0W+1p9/7C?=
 =?us-ascii?Q?2/8hCGahD3Ns5A0JH/KReTUy2zNnI4WUCtN23r64LlZjTEcNJZ9G8smemh9j?=
 =?us-ascii?Q?RpVjvapCB7feIUvYQtjB2OReOQcUtYkk9TTos6eXyUir7wf/3SGotud1TPiO?=
 =?us-ascii?Q?12N8aAyhhegB5nQSa6YtAibs2F3CX1CqP6iTSHfyuAGh0OG7OScXAMKLG6SS?=
 =?us-ascii?Q?cn4aVTIrPd2aMxtAYAXYbzMOeldz4xvZFoHp/iZ/iTz42IhQhtINmdHp7Kp7?=
 =?us-ascii?Q?NFYQ+Y/CGpkBAYbMlFEO219m/vd5O0/h8wb/VnNxKK5vZUX+QgLnfECmmGI0?=
 =?us-ascii?Q?/hDUaYuEwLbRq6jAwvrRtPfLFStaxEl2v37Jfc+nwdmCUCaMoiS2B1m10V0X?=
 =?us-ascii?Q?JdpOb1iKrUmXYvHZ4OmjL7ef91cnohRnfomJCp1ckH33cmYTBHgCYkLiA2MN?=
 =?us-ascii?Q?gD37lqEUjP90m4LJ8jphbPfKbRiKkLxKF7Ib7Ld8+/fFVc7XNxsQJ5cfm3m0?=
 =?us-ascii?Q?bfI5e5K/0sFQGXUZc18fRF1WlN4gmvDBjYMXRnFlDUNIak4DZs9CHSdZdrMU?=
 =?us-ascii?Q?jzCeDjW++UqP94LTCrdX8VReWjd9HmmTKJwO1FBOelBWzz7ukQWlJsohcyop?=
 =?us-ascii?Q?MbXPr0qLyNZOJCW84i+47+hP9rRiXsWLVbCIwiRs2nU7l6L0P+mhobyiXhk/?=
 =?us-ascii?Q?tjYyl2avpd0W/vUGP0U+fZz1UbzB9ci9nDZ7wH5HnuKDZEcbJA8eCywvmpX8?=
 =?us-ascii?Q?WCUWM/lZm7a4CJf8O3YV9jSNxsTuRPhO4LqHtucKl9NffZsqbIaTpEYTcjy/?=
 =?us-ascii?Q?bYrrWWHRFzdfP9/yeNmg6O/Y6eQSaRg/idknYQJpxjeiG4hE0v4UsTtJ/HJD?=
 =?us-ascii?Q?Ap2yxLa1gyxjSunMOPsuyLUDQqdezQU6vf92iYqCkRSg16VOJWf3uhbSsaB0?=
 =?us-ascii?Q?lqbwLG+PHagjt44dNBlrfKu+SuR4FpofMaA3D3kSp7AwXL9Xv2zzb9gXrCBr?=
 =?us-ascii?Q?NKLfoqedtFMKZzMLdmzhsXMc/5ngMoxD1qdMZEg6eRXp0+QhvaBOSXloF9f3?=
 =?us-ascii?Q?UzOLGp2pe0l/hPwbZacWxHc9574jVD1nsPNSitJ/bp3cPYPwqDQea4V+s7tF?=
 =?us-ascii?Q?v8ZPwIjdPdyF9NFZgeiSemeZU6YKQlwrm7SxRejyMrR5sA+M8blEhMqj+5Tj?=
 =?us-ascii?Q?+BTV3iIF/5AlsDskfmT0ehyvu3GmjkrktnYaBGDIGx/7Q80BUQ6G+BTrcGv9?=
 =?us-ascii?Q?sK2gtcJykrSUcdy5s2xyftiZA6GuxLFpkINF7OZJS1EtKLkmo7RGYZVForsi?=
 =?us-ascii?Q?ZtdU0nj3czD0jL63B1trEd+HBs2rjkwbqxPn+kQLAxE7?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2fc2ad-5a9f-4333-fa48-08dba1bbf867
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:28:10.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+4G0yMhPHMz+YDJ6M6+LGkSOXeOZQ1jjjoshPLzixgvMvmOFmUHvyu0paNy44lsJ99cVg22FWU1uGmdqwJkSw==
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

The post_msg_page was removed in
commit 9a6b1a170ca8 ("Drivers: hv: vmbus: Remove the per-CPU post_msg_page")

However, it turns out that we need to bring it back, but only for a TDX VM
with the paravisor: in such a VM, the hyperv_pcpu_input_arg is not decrypted,
but the HVCALL_POST_MESSAGE in such a VM needs a decrypted page as the
hypercall input page: see the comments in hyperv_init() for a detailed
explanation.

Except for HVCALL_POST_MESSAGE and HVCALL_SIGNAL_EVENT, the other hypercalls
in a TDX VM with the paravisor still use hv_hypercall_pg and must use the
hyperv_pcpu_input_arg (which is encrypted in such a VM), when a hypercall
input page is used.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2: None

 arch/x86/hyperv/hv_init.c | 20 +++++++++++--
 drivers/hv/hv.c           | 63 ++++++++++++++++++++++++++++++++++-----
 drivers/hv/hyperv_vmbus.h | 11 +++++++
 3 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 933a53ef81197..892e52afa37cd 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -480,6 +480,22 @@ void __init hyperv_init(void)
 	 * Setup the hypercall page and enable hypercalls.
 	 * 1. Register the guest ID
 	 * 2. Enable the hypercall and register the hypercall page
+	 *
+	 * A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg:
+	 * when the hypercall input is a page, such a VM must pass a decrypted
+	 * page to Hyper-V, e.g. hv_post_message() uses the per-CPU page
+	 * hyperv_pcpu_input_arg, which is decrypted if no paravisor is present.
+	 *
+	 * A TDX VM with the paravisor uses hv_hypercall_pg for most hypercalls,
+	 * which are handled by the paravisor and the VM must use an encrypted
+	 * input page: in such a VM, the hyperv_pcpu_input_arg is encrypted and
+	 * used in the hypercalls, e.g. see hv_mark_gpa_visibility() and
+	 * hv_arch_irq_unmask(). Such a VM uses TDX GHCI for two hypercalls:
+	 * 1. HVCALL_SIGNAL_EVENT: see vmbus_set_event() and _hv_do_fast_hypercall8().
+	 * 2. HVCALL_POST_MESSAGE: the input page must be a decrypted page, i.e.
+	 * hv_post_message() in such a VM can't use the encrypted hyperv_pcpu_input_arg;
+	 * instead, hv_post_message() uses the post_msg_page, which is decrypted
+	 * in such a VM and is only used in such a VM.
 	 */
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
@@ -487,8 +503,8 @@ void __init hyperv_init(void)
 	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
 	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
-	if (hv_isolation_type_tdx())
+	/* A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg */
+	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		goto skip_hypercall_pg_init;
 
 	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 20bc44923e4f0..6b5f1805d4749 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -57,20 +57,39 @@ int hv_post_message(union hv_connection_id connection_id,
 
 	local_irq_save(flags);
 
-	aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	/*
+	 * A TDX VM with the paravisor must use the decrypted post_msg_page: see
+	 * the comment in struct hv_per_cpu_context. A SNP VM with the paravisor
+	 * can use the encrypted hyperv_pcpu_input_arg because it copies the
+	 * input into the GHCB page, which has been decrypted by the paravisor.
+	 */
+	if (hv_isolation_type_tdx() && hyperv_paravisor_present)
+		aligned_msg = this_cpu_ptr(hv_context.cpu_context)->post_msg_page;
+	else
+		aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
 	aligned_msg->connectionid = connection_id;
 	aligned_msg->reserved = 0;
 	aligned_msg->message_type = message_type;
 	aligned_msg->payload_size = payload_size;
 	memcpy((void *)aligned_msg->payload, payload, payload_size);
 
-	if (hv_isolation_type_snp())
-		status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
-				(void *)aligned_msg, NULL,
-				sizeof(*aligned_msg));
-	else
+	if (hyperv_paravisor_present) {
+		if (hv_isolation_type_tdx()) {
+			u64 gpa_boundary = ms_hyperv.shared_gpa_boundary;
+			u64 in = virt_to_phys(aligned_msg) | gpa_boundary;
+
+			status = hv_tdx_hypercall(HVCALL_POST_MESSAGE, in, 0);
+		} else if (hv_isolation_type_snp())
+			status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
+						   aligned_msg, NULL,
+						   sizeof(*aligned_msg));
+		else
+			status = HV_STATUS_INVALID_PARAMETER;
+	} else {
 		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
 				aligned_msg, NULL);
+	}
 
 	local_irq_restore(flags);
 
@@ -105,6 +124,24 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
+		if (hyperv_paravisor_present && hv_isolation_type_tdx()) {
+			hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
+			if (hv_cpu->post_msg_page == NULL) {
+				pr_err("Unable to allocate post msg page\n");
+				goto err;
+			}
+
+			ret = set_memory_decrypted((unsigned long)hv_cpu->post_msg_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt post msg page: %d\n", ret);
+				/* Just leak the page, as it's unsafe to free the page. */
+				hv_cpu->post_msg_page = NULL;
+				goto err;
+			}
+
+			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
+		}
+
 		/*
 		 * Synic message and event pages are allocated by paravisor.
 		 * Skip these pages allocation here.
@@ -178,7 +215,18 @@ void hv_synic_free(void)
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		/* It's better to leak the page if the encryption fails. */
-		if (!ms_hyperv.paravisor_present &&
+		if (hyperv_paravisor_present && hv_isolation_type_tdx()) {
+			if (hv_cpu->post_msg_page) {
+				ret = set_memory_encrypted((unsigned long)
+					hv_cpu->post_msg_page, 1);
+				if (ret) {
+					pr_err("Failed to encrypt post msg page: %d\n", ret);
+					hv_cpu->post_msg_page = NULL;
+				}
+			}
+		}
+
+		if (!hyperv_paravisor_present &&
 		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
 			if (hv_cpu->synic_message_page) {
 				ret = set_memory_encrypted((unsigned long)
@@ -199,6 +247,7 @@ void hv_synic_free(void)
 			}
 		}
 
+		free_page((unsigned long)hv_cpu->post_msg_page);
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 	}
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 55f2086841ae4..f6b1e710f8055 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -123,6 +123,17 @@ struct hv_per_cpu_context {
 	void *synic_message_page;
 	void *synic_event_page;
 
+	/*
+	 * The page is only used in hv_post_message() for a TDX VM (with the
+	 * paravisor) to post a messages to Hyper-V: when such a VM calls
+	 * HVCALL_POST_MESSAGE, it can't use the hyperv_pcpu_input_arg (which
+	 * is encrypted in such a VM) as the hypercall input page, because
+	 * the input page for HVCALL_POST_MESSAGE must be decrypted in such a
+	 * VM, so post_msg_page (which is decrypted in hv_synic_alloc()) is
+	 * introduced for this purpose. See hyperv_init() for more comments.
+	 */
+	void *post_msg_page;
+
 	/*
 	 * Starting with win8, we can take channel interrupts on any CPU;
 	 * we will manage the tasklet that handles events messages on a per CPU
-- 
2.25.1

