Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D6D632D5B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 20:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiKUTxK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 14:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiKUTxA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 14:53:00 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022019.outbound.protection.outlook.com [52.101.53.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A323EAC;
        Mon, 21 Nov 2022 11:52:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE3Ao5ZNjyaGCiLV0uMIDZZSGVLf42nu4LDOtGJZyOdp9F5h6e2NtZ1aKMSi3/3ll11DVHA3lPFpAiX9zyGMUU/ZFhZzkRcRVv5/mEp35yrzq3udKtP4j+paZEBRkjtkkTtH5FH37KSWxZ2MB9cvMQy1/ENqaSQkucasvIAd9Py2lyaezXCmMeCRfPaHIcb0vY8ShWaVdBte/K7pCZwH+dN6R8NUA/QDRSDPnGs3DOzlBUB7DXtIrcR5vwMvqEcDGkz+5iejSgwdG7jFYwwGV7Tck9PZT2Dj+38Fr2bPkyij6R1XZg14MQuWHXN8r25C4AUqDfTcsJbVL3nSABY5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ5cCBCdmXSDGpxujQ4rE647Xt26Pt7EGMqw+j0HTOk=;
 b=Ma7hj/S6oBktG+5vINq+rMDaES4069aQpkzOHliA7NXVp9dMGNvr4aPJDoo0R8mAYFl3F5psdtB9J8AWKrFFUExtz+ClVZ7Nni84Km4EiBTLxHrvvmL74IrQpdUXTaSneEEjP12rvKY6erHZzVCDDRS56A0fn0MuvVYfNOAApIVyibSVSd9UmFTVg1Ts6DRnRKX7QOWS9LXNqmf57xzMgDlsFc616BLtmxNMFpEfedb6iL01eKgrCdUFDQK15L8L5Mvzc/3yX0No4066pl4O50jenJ6A7mQrefonHYAA3SVRSxFhs11wLmNA7jC0YAk4VlgR7PgJpspYTIl1tk+VqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ5cCBCdmXSDGpxujQ4rE647Xt26Pt7EGMqw+j0HTOk=;
 b=X02ybRpdPPYInfPGf2fzTYP121P1LsSSDuAjFD1LSLQbcc48f/gStlQcBIKyGRflbrzKfKmtMgCLU53cNPm7xQreRbYRPnhZiagu/uT3BkQoc/BwbqYfsXJc3d5/mBZCIzdJOpFS7U+ctayICjh6l8V4lXY8KSrkGxq3eWZlHro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BL1PR21MB3280.namprd21.prod.outlook.com
 (2603:10b6:208:398::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Mon, 21 Nov
 2022 19:52:50 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%7]) with mapi id 15.20.5880.001; Mon, 21 Nov 2022
 19:52:50 +0000
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
Subject: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Date:   Mon, 21 Nov 2022 11:51:46 -0800
Message-Id: <20221121195151.21812-2-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5ec224f-0622-4ad8-4be5-08dacbf9f88b
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UE4lUQCW+7X/AnYNMvIgeQLHLzJs3fEMg1avC14vyGDfE1ioGF01VaF6y5e/LDdNcsx8xBZbLD0ALyUJAMwL8P0jdFw3VueCgEgGKStK4ss90WAyShZ6MChy3VsNw1X9wVKSy8dIx+jwNVqgeKezWm2QhBiHLBpVbdSxV7Yy7ZdD9N0kG4VUVKxy8zU49AXY1Kubi6d9TMQQN4zIWNXNBps4/Bv4wYIiVP5pvvIXdfok4H7Ie4IDYbJSKGGTIgIChbZkVqhNymp79/otuHa9msYe7CZomPc4uy5vGgTwyxQQyR16K3sSD7mNEfkSLQM71WDqnOQlfsHIzpOjSfIiM1ciqybA0CiwfTozNSTc1AFNoCUjuKpsglq9LbjOHxfGyp2wDhNBHycOEa67CTJb5G9myKNNMzejCR6vZ5S4qaOpuUQHnsVVFEuGbbPrhBf8fjb1QTAwi5l9q/WAraejhP/1naabz2XzsJxSWi71DoJXWYDAphp+EigJKuxy7o6+1goC3pc5ajjrYvxOczUt8XdSYplbShGIAXMabk1z0GKv7jx4T1V1O9nfxIEmmxKE3LSNAe8OLAPDlOiQQKST7TRCpPX2U2yRkUo6iyawuuZQtfBClzJNK0KCJ9gF81ZRIrV1rp46Zh9RSX9G74dliQLBAWThQzqNgZGfkWmL3pL9LitRfr9ZX+V7KfYdgwZRl9x9AKJhtwECpMdtSH3dERcOc8uilsrQcxYPrsNL4dU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(2906002)(7416002)(5660300002)(8936002)(2616005)(186003)(1076003)(36756003)(86362001)(41300700001)(82950400001)(38100700002)(921005)(82960400001)(6666004)(10290500003)(107886003)(6506007)(52116002)(6512007)(316002)(478600001)(66556008)(8676002)(66946007)(66476007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GXS3KDBBxm5RrpxH2mBzI09aEVDEUVEW0AYLlLxkwpUI2SEijYGQDvEVORUP?=
 =?us-ascii?Q?bTxf4fFOsyqZI1IYDSTM7PjkWl7NQgGBhfoSp8DLTnW4RtIiqSZvtA5emrVt?=
 =?us-ascii?Q?XvnrilwDWc6x3LoBr/p4A1PPb7rm4OhhBpOYpxHBWVycwQNIVFNy7amNN/Tm?=
 =?us-ascii?Q?zMm2ss8fmmVYyh+2XIKSd7yULJ3w8AfELmqG335CEPCqBE81vsGlieRwpxzh?=
 =?us-ascii?Q?Zv/PET5tMZ6fa2M0d3cPld0sdbAwq0weNyoJrMMGeuq0nbe+x5QU5beTBQqv?=
 =?us-ascii?Q?AkdUKcI64Krk42pvL1BqgmfWuXK14yi53bOnx6wLPjEo0zO7MRxOdVt1RQKz?=
 =?us-ascii?Q?zMnd9Vw0Qyum1gqn8bqAPkYmukR1LWsRPiNVI/zE60SOkNdwf5ZDhWL+f/4N?=
 =?us-ascii?Q?6Lr9J9FVd06EoUbrWTEb2dUMlcJm1aBfhSIgYwMOIjQFxYd0f05544IOjAxo?=
 =?us-ascii?Q?327D++ySCtcX9+Za0td1/DYc8FHr+DpQovUiqSHxdxewAKINPcX9bvmxwut6?=
 =?us-ascii?Q?3kBrIPCnNESeoJe+GEhyiE8+tOkk4kB8b/s5mAVy1oA1OTBqDsrilvv1DAp6?=
 =?us-ascii?Q?UGO0b4lGzSFZOLtmzCGbsFlYhIH1xzn7TbVE3jR6JpoPXndIxIotVWZpr/qb?=
 =?us-ascii?Q?DG2o8zfOsBzsdAKu45HrXLls10r5m7uUfd8Am87lC2sfUSW9MHCgaLjQ9p4Y?=
 =?us-ascii?Q?KDaU0/d4+5oZWqaejocJgS9mh321ylTb7zgiOTC+6MF/U8oPlTjxmdLyPoW7?=
 =?us-ascii?Q?cFEvFM133YFndFN76BuXi5yD8ONC3Jqf5HQ7uwG4URrK9CzGe8v6TpH3YEUL?=
 =?us-ascii?Q?t9EGfCRcYiyUaovkm+8gXJIGQdd9BVjorerxhnf0Oh7w+192zWYYhbO8Fyn7?=
 =?us-ascii?Q?bqvHbzaGP6qauacxLV1l3g80g14VNyhaV8EsTXr8usxL83EFHiDA2LxnMfg3?=
 =?us-ascii?Q?z/xzQRzRJMsVcZqV/ohNoAjO/vldagrZoMNIS6JkKpkE3dTEGyHYMiRu4lFc?=
 =?us-ascii?Q?oU2DDr5F/DPnMVI7z0z5Yzp/yLceFvJUjH3avbYRRmZz/60ieAwX8eSgSIN1?=
 =?us-ascii?Q?hgLRuQgEyezp8vucOZHb2xQw5olsZpJVwuUcj2s1aQzBKiTeMMsCYhvErrrf?=
 =?us-ascii?Q?BzC9bb4P1Z3z9fKMbDhjpu4iqok7BuV7kjhrkkXqqhR0fwomHYfYLQbDjeKm?=
 =?us-ascii?Q?agt87N5VzSF183Tdq57/Cxcj0UMhjRcbJVUKU1axpF1tV5Rh0r5mnUjb6rYW?=
 =?us-ascii?Q?NPVDA+tE2vkfrzaCyTKJeLimNADiS/USWn2oqajsDhamFz7hkAxFtEpxzbI6?=
 =?us-ascii?Q?BfTVzhtfe4v324sLhkVFK7oA1nxEGqJStSuV27I1d+LIFYx9NgyZDv/aMFN8?=
 =?us-ascii?Q?gqnZHIEAtlHagcJlJOmwiYbzE61TM4lhMngXSg1io+IGUxVEgEeQh9zyrXut?=
 =?us-ascii?Q?wV2txvdylTl9gZX/zS61Zo0tttKBQb6N/26bo0O6tWG0BvXKntfa2BXvALyU?=
 =?us-ascii?Q?wWSp/NkWf9aXtexjJiI3PVN7jFmGccUXwXngQYzukBuglJDlrW5KvHGJ4kRr?=
 =?us-ascii?Q?YXQ9isRjB3prTxcZDIkvqbDugTwpCYhQOhkuRg8Xylk3KcMj7ORHFHaaUa3w?=
 =?us-ascii?Q?X8Q1B+YmuOwyYtaZDgEhnDVI5yJ7LAy9grcJMz5DRHl9?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ec224f-0622-4ad8-4be5-08dacbf9f88b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 19:52:50.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSBjbq8M1+6wqoVG1zFvUIz6hTXhNnH6dKwoPd72A+7S32dqhdGSsIv7sR6+jD+vzvrYi09pTXkJd5tPNsU58g==
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

__tdx_hypercall() doesn't work for a TDX guest running on Hyper-V,
because Hyper-V uses a different calling convention, so add the
new function __tdx_ms_hv_hypercall().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/tdx/tdcall.S      | 87 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h |  2 +
 2 files changed, 89 insertions(+)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index f9eb1134f22d..468b71738485 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -13,6 +13,8 @@
 /*
  * Bitmasks of exposed registers (with VMM).
  */
+#define TDX_RDX		BIT(2)
+#define TDX_R8		BIT(8)
 #define TDX_R10		BIT(10)
 #define TDX_R11		BIT(11)
 #define TDX_R12		BIT(12)
@@ -203,3 +205,88 @@ SYM_FUNC_START(__tdx_hypercall)
 	REACHABLE
 	jmp .Lpanic
 SYM_FUNC_END(__tdx_hypercall)
+
+/*
+ * __tdx_ms_hv_hypercall() - Make hypercalls to Hype-V using TDVMCALL leaf
+ * of TDCALL instruction
+ *
+ * Transforms values in function call arguments "input control, output_addr,
+ * and input_addr" into the TDCALL register ABI. After TDCALL operation,
+ * Hyper-V has changed the memory pointed by output_addr, and R11 is the
+ * output control code. Note: before the TDCALL operation, the guest must
+ * share the memory pointed by input_addr and output_addr with Hyper-V.
+ *-------------------------------------------------------------------------
+ * TD VMCALL ABI on Hyper-V:
+ *-------------------------------------------------------------------------
+ *
+ * Input Registers:
+ *
+ * RAX                 - TDCALL instruction leaf number (0 - TDG.VP.VMCALL)
+ * RCX                 - BITMAP which controls which part of TD Guest GPR
+ *                         is passed as-is to the VMM and back.
+ * R10                 - Set to Hyper-V hypercall input control code.
+ *                         Note: legal Hyper-V hypercall input control codes
+ *                         are always non-zero, i.e. they don't conflict with
+ *                         TDX_HYPERCALL_STANDARD.
+ * R8                  - Output physical addr.
+ * RDX                 - Input physical addr.
+ *
+ * Output Registers:
+ *
+ * RAX                 - TDCALL instruction status (Not related to hypercall
+ *                         output).
+ * R11                 - Output control code.
+ *
+ *-------------------------------------------------------------------------
+ *
+ * __tdx_ms_hv_hypercall() function ABI:
+ *
+ * @arg   (RDI)        - Input control code, moved to R10
+ * @arg   (RSI)        - Output address, moved to R8
+ * @arg   (RDX)        - Input address. RDX is passed to Hyper-V as-is.
+ *
+ * On successful completion, return the hypercall output control code.
+ */
+SYM_FUNC_START(__tdx_ms_hv_hypercall)
+	FRAME_BEGIN
+
+	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
+	xor %eax, %eax
+
+	/* Do not leak the value of the output-only register to Hyper-V */
+	xor %r11, %r11
+
+	/* Load input control code */
+	mov %rdi, %r10
+
+	/* Load output addr. NB: input addr is already in RDX. */
+	mov %rsi, %r8
+
+	/* Expose these registers to Hyper-V as-is */
+	mov $(TDX_RDX | TDX_R8 | TDX_R10 |TDX_R11), %ecx
+
+	tdcall
+
+	/*
+	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
+	 * something has gone horribly wrong with the TDX module.
+	 *
+	 * The return status of the hypercall operation is in a separate
+	 * register (in R11). Hypercall errors are a part of normal operation
+	 * and are handled by callers.
+	 */
+	testq %rax, %rax
+	jne .Lpanic_ms_hv
+
+	/* Copy output control code as the function's return value */
+	movq %r11, %rax
+
+	FRAME_END
+
+	RET
+.Lpanic_ms_hv:
+	call __tdx_hypercall_failed
+	/* __tdx_hypercall_failed never returns */
+	REACHABLE
+	jmp .Lpanic_ms_hv
+SYM_FUNC_END(__tdx_ms_hv_hypercall)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 61f0c206bff0..fc09b6739922 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -36,6 +36,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
+u64 __tdx_ms_hv_hypercall(u64 control, u64 output_addr, u64 input_addr);
+
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address = input ? virt_to_phys(input) : 0;
-- 
2.25.1

