Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF339779AA0
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbjHKWUD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjHKWT7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:59 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6FC30D2;
        Fri, 11 Aug 2023 15:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0X7Wor/VFgdxwKL8sW27ECB43AxXx/b2uTBjOtoBt6WKlcpDNWhqId4ZWd6Q2XKpUp528pV+hAsAxm2j4h464Rzt6u3CeSnlfJ4LP4AAy2goRYha1tbn+aFn3+xGE3OJ/8TeF+E8t6Gsg0V9xYiTeYgIhRsPDubj+xymtFRKLv903HoYpHpl5F+gTMxF03rKjSJMC7lNxkBOtPw8cKC2+mc6aCwNzxZwK4s5TDdznSBLhkhjJtI6yndSXXHJkOBZqAufLPMPeOmGVSy7BGhPqgzKx/URPm4S0GZFBLmObuqTCeaefsb3gYUVKChj3wroan0+RlkxWY1+Iie4En4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VP+DsTE5fkHYtBcueWlakZ3AYSU1LGxtAACLwV2iAA4=;
 b=SrJCFhYtnNvquC5GhQ0FIL0FscxNkDAFaaBLUnHOnUMsLMI3XSLoz5sT7EunJtNR18JimPcHTo+o9AqiwgzO5ZuujQnMVsv7WZd6vfIo5l6G6IVR9NjKQFG1AaDCVjzythB9a2cTIx2dcZlqk1Y/cayQsyKjlAZujRpahdZjil0D+/iouCyj/c5nKj87hbQqYr7LexsjbpVbtK/BBDPqkjMmV/11Xx0wFBWj7JsNAHjpXUJjtWeBkdXsIToTjsKtA3s3YzJ3thB4PunEuxAuA0pwx78gl5iIptXPCKPM+aoxuO8Ye/wrFC3nmKI8MZaC9+mjHy6mqkt3dPIAbWj/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP+DsTE5fkHYtBcueWlakZ3AYSU1LGxtAACLwV2iAA4=;
 b=TJ6r2b8WnC1YC61okFBY/6I+DeNOffsv8/qYLJOZ8/h/dAyQ/p/2jbiAhtt6GMUWDC6D7qaw+IRh3mIQOmHEvgIO2Zs7Zxc3imumm4QG/E5bIFdJeZXMqPPHeB/ALzYY/8fliCkV7OodyuXTb0vAdXpDTj1zlPGGPIzCwEd9Z88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by DM4PR21MB3417.namprd21.prod.outlook.com (2603:10b6:8:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9; Fri, 11 Aug 2023 22:19:40 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 22:19:40 +0000
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
Subject: [PATCH 7/9] Drivers: hv: vmbus: Bring the post_msg_page back for TDX VMs with the paravisor
Date:   Fri, 11 Aug 2023 15:18:49 -0700
Message-Id: <20230811221851.10244-8-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0561afa3-18e0-473f-400b-08db9ab90dbf
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gd5Ld+TvLNew94e7j4Ak7YQTdLUuv+Rmac2gYHzSut3YXc1RJlqFGKCGYNFKN5kzsuIxOUMfUgSgIwEVD5IH8AQsHuXqnqjClgj6Zmf2PPddZWjYASRKc0YEYK6votchLjWC2fGQAYpAXBi9hH+sVFZ7B+vVBUxy5/Lay6rDoCWJ2IMCV/3RT7b7cD7IzqsHi5hOaBdxqpZ246VP7CdRZe3YCDs1Qrw5GLK17q/TLSwO/3ptNubsUjCg1Ns56mwIGc133SXDCjfHQqawAgTpK1VjlzxqiErKYItGEfPIkswcEP5FxywEl9qEfqpwQZ1KIxTsXsS2aGE+hsyMBNSJb8yxAbs9z+nWjyQZNc5nJHxsVBGiVFUx1gkNB5fqHwStjwxTDWfLL2XJE03+rzEgSy6Z9GvOPFQerQApf5J2rKzb5P8c+8VHP3xJv++TzREdPvA0+f8l4w4LK4Mwlyalo7cx7aZNbpkSrfiMPGJ8Qjs8DWigJsj517A6DDFYXEg1zV6gYFnIUedRxj0j/knE2/Nm9pZ7QMZlpwINKWKD+1T3JS2JLrIn0T8p/bjqhrehZ/QqRlRXoGK4ekJe9TWnBdns25shiquWZr3Ww+rCvcnM7YQvbGaWShMXeLMcIXExyV3fiPlMght8ATAnN+vdMr734Fras/Llr7JwEvLhXEbtbcJe00qoPxf+HgDl+r8Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S3XlOE+2vu9SJXGwFsoTGVLPURLnlYwmgBoY7IcICA0SyxZGLexRRR2BX1iC?=
 =?us-ascii?Q?ZXCin26JQAiO4EqsUbUaGc1bpNpFazDUCGtEiKxcqgA+lY/2wQkANhAHlBRY?=
 =?us-ascii?Q?SVBSjr6NVRn5wDXdmaOp3zTsD+xUzU5na0L6dlxXzlgCYNhPqwjcoXZ3r8v3?=
 =?us-ascii?Q?xqp6EpCpqxRt/YJfgYf/UfQ57oAR5oqcfMVwYf+6tyBAKV+WJYsZwAfL38Dy?=
 =?us-ascii?Q?6HVUY+zaJaPrePXy1ctyRNznJhwtWOBJJBde0R+P+A2K8822/i3T3mUkvMPw?=
 =?us-ascii?Q?iZxI3SXDT6ibpR2U7S06hjOLfa5VSjA/7Lr4DGSTXb5gzvAEpStDmhQvGTsV?=
 =?us-ascii?Q?MpeowKDxqX7NgPn3pqH9AgiTsURiJHFJtVW1ZJiL8kfNvRLeTQINOIQdNnjs?=
 =?us-ascii?Q?jmIY/ocQv4zL+13DDoJ8TtMvkmZwJCtVbCscM0rj5NhD8T574/mDqs1Q/hwX?=
 =?us-ascii?Q?ScDU3AiThf1UehaQX1af+VEoy/injG8ODwhEQD08kOVllt6ZJ3YvFlV57RQh?=
 =?us-ascii?Q?ZSrtNyLmkEd3I/oTMFod6maKBaRCtwrak9fgRYCc3iwb1zC76af8vY0SfRjY?=
 =?us-ascii?Q?ie65p6/uuSIh98UOjjP9Fa5fLDvCKvamOgdf/GupXROsSeLOwUBU+Bd6GGbK?=
 =?us-ascii?Q?kA3Ze/InFXqF3wrYr6KNW/Pl0tWbIm+OFj1sMgl1mKAnMLjDXvdBBh2ngEJI?=
 =?us-ascii?Q?PZJSLqmL5bTHlCWiWsytTOgT3vwqxcP7kNtyb6emNotqnY/FQ3Oy1RYGVUSJ?=
 =?us-ascii?Q?GDMFdeCbUyQbs3fjgx5+grVJtvuv15q7s53aPAALGK9kQJEpD6unvaMC25mD?=
 =?us-ascii?Q?U6bJBYbKER7X8ms5jOvrOjCPzaROsnrXVuQaYG51ljBPyhRndQRsa1XXGNj2?=
 =?us-ascii?Q?6p1oYzLN/kpXMpXSCEwly+AeX6xiyv5mEAYoE40a6SLoXwDgdM58gOZcfSZo?=
 =?us-ascii?Q?756KH4P+cVbX0JcOwyrIDTxL2Ii+51KH0L+d6xN/0JRe06y02/YPKwW6z1an?=
 =?us-ascii?Q?va3dlsC9CsRC4MSJ9dIrPKqoqZEMUy/fEz4jYGy1V4SDeC91bXeJdfNX1cyM?=
 =?us-ascii?Q?e4zKN2682oUXe8HYm259rkFcVpYePftO5UHTFhZ5FDhYO1xFlgYlp64PnddE?=
 =?us-ascii?Q?CAt0SWIQj46GBGqLZ4+vsELumFLX7+QbTxjgTqpAaRewWxFiGMqeF2m1QInV?=
 =?us-ascii?Q?5lSeW/O+dkhW/ha8ovwl/pyZTl6JQQLuFBmFzVw7EOQRUDkKLH2KK+qG5Onh?=
 =?us-ascii?Q?2F6YLPdSymFxXAwMaHxAHHpdsIamZghxfh2rAIT2v2K6E2QoN2Ripf43dqyu?=
 =?us-ascii?Q?47fwRhdCKx9j60F/l0Spg5At/7CEA/WssnxJOZiaEfloQf362F3StVfgThGa?=
 =?us-ascii?Q?lXXcRLyVp15oUJ2zkPB84r9QNdrtELDsIhyiBVqhynKfAmzRmkiCC4htVsY7?=
 =?us-ascii?Q?PlyGn/bxY64sG+bPGrxz5g1FOoUbJfXViEKn8UMBix7rYCQ5lJqujwIhdANq?=
 =?us-ascii?Q?RoyO3QgsV9/HNG5BDcBiTEAHbDxhnS2LeJpWD2u3Yn/F+R36dlhjEe3Yaizc?=
 =?us-ascii?Q?Damvyd5fsa17Uv7VQhF+VWln3vCD+8UcEedtK3qhT5mmHh2/1vn1HeYbCQ1v?=
 =?us-ascii?Q?1++xgOagd8yr2n6+nW82voH4TTI6pZy9cIJowqTluAkL?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0561afa3-18e0-473f-400b-08db9ab90dbf
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:39.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4u36eWYdnu/onqsPgllp76DQg/xKOZge7go1jFZcPz5DzBOxWZBJ9xpXNlJ9OZuravFr/50cgC59tRJklnmJhQ==
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
 arch/x86/hyperv/hv_init.c | 20 +++++++++++--
 drivers/hv/hv.c           | 63 ++++++++++++++++++++++++++++++++++-----
 drivers/hv/hyperv_vmbus.h | 11 +++++++
 3 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e67e2430fba35..9c12a199ea62c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -485,6 +485,22 @@ void __init hyperv_init(void)
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
@@ -492,8 +508,8 @@ void __init hyperv_init(void)
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

