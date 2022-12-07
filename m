Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81864506D
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 01:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLGAfW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 19:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLGAe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 19:34:59 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022016.outbound.protection.outlook.com [52.101.63.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CC6A479;
        Tue,  6 Dec 2022 16:34:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjPN3rRT6nZEksaxqAM9MOuHTu4L/qXCdNKEdyBposTBCynRrxhIH4+zwvSfsvl5wqYTDwVmk4yiszY6ThPtJMznlRKB82Cuz1HSKw3fQVbANdt5ZdEKxmM72XqvjIz0pvtmsjkoUfUAErSnowRkAaOfXK0iTUG58Dc9bPczFyQ0UjtgEIBdiACEmhC+yJr/jRxCva2KAW6HVk3JotPAH2MruVwsS7yKr59XqiG3RXyASy5xptAisVnhSWzGk0xmbyzg/4EYrqIrjmkFIi+mhbd0EsTfKicHoo5w+bRVKCOmS3CnAIUIqkmcl8tm04y/5d8vD4xoCJmaG7ji2dj+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV9U12A7INP+IcfdGmMYALaYnazyZzxUi77JVmeXapA=;
 b=N2Q2tqbrSN5lwjd26Jg7pb74XBl6naJ28XaNfQG7JNSbMAwv7+pRNnZoGxAPE02U0w6cyICP6hHLDbuqMjtsh0LYyz0KwHA7ixN9/PpLOtEj8+WGTnIXpkXNLBsIVHpd691NPUC+fsoVHlUMHfcjOjzp97cv9DWkVTZN2Gyi3E4Z8I0N/BvBFkMaGYkJ6s1eM6l9n/UB7qaIPYufNeqrsT8c4yK8H+FhN6gkvsktnxxXUn9F3eBztM72P5TKTeEp1Do5d3qzjCFlxKY/iQV/rrIuVOR5MUku0Y7mZBrYIgfFcPcE9qpt9TLvjkbAr6CFgOynpoQmVCYqy2UST1jJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV9U12A7INP+IcfdGmMYALaYnazyZzxUi77JVmeXapA=;
 b=XBSQijTABLOfgL/Qyjqj5zKvZTLZeJK364mBBwU2eoegiZfTLdpqzaXRRKWg0KMv2FN4ZbUwL202dWnKUpFrRt0c7qSysetVeePZ0gXVtpk+mOsdkqUIf7mT/DagFx+FqnAtXmTRcsABslqspdWglQLK0HL+9an9XW/lsEmcV44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by CY8PR21MB3819.namprd21.prod.outlook.com
 (2603:10b6:930:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Wed, 7 Dec
 2022 00:34:50 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%8]) with mapi id 15.20.5924.004; Wed, 7 Dec 2022
 00:34:50 +0000
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
        x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] x86/tdx: Expand __tdx_hypercall() to handle more arguments
Date:   Tue,  6 Dec 2022 16:33:23 -0800
Message-Id: <20221207003325.21503-5-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207003325.21503-1-decui@microsoft.com>
References: <20221207003325.21503-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|CY8PR21MB3819:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f308d0-8566-4b97-e68c-08dad7ead9a8
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36uiYtoFfq5T5zZi3003IUXuNtDP+2cpMYda5ApTeJ4NX9SkArRf8nJ73bZnWQxIoa/i6rancJ5HqJqASe8ZjiaFVlPzOHRaXRzidCKLRef6WZ5AAtIXyodcTGdpY7Gq3JOURsB2vvJcJLUehOm0OySI+xbxVs61ugTgwaHufjUl4F8uWMvRQlVZFOE1UahwUsIirJtfMlHVEA/Y3iJ1zAt/TSBQT23xlRJg7gartHckKcG/Kzk48NUSP9toRYLWtP4kODqrOV9MhttYneEveNsNsdbS/4PZ5GEW4nbsUcyTJsI8LYjTmFQuD760RbISLf5b0R6fqBO+4bES444uIcjAHLdElolAJDIRQO+bLtVXc4nWj1up/eSbk1Y2fL1Vk/W7qOuNpbjwPVcD+f7V70kQlfgdWL56Qtj8n1H6cYEVyW82O84UqE5kzN9saEEhe6L3myBNFHVtBw9cA+iJmsYNxgiPj4FWg/dNS9xqMkOctnszfMm1bnX7B1D/Me0RWgfDzbsli59enCmPQJrtXrmkvU69MWxD72EhWStmjB6QPFsB22SaMoaPJLtSdHC+T6KgS9aqKXWhlMPm9EuyvyjTiHD+V8rkSwg4WW36a/xcqeyXFjkWhleHiNa+FJDoyXklYPrcXnpsbCpZgoSLLpK4DJ0pYm0QkAH/G3e3Kd0HisFEuoM/ztKpEmrdqJ6cA9m0Ap8oX92SVtYDdeXOGMPijePziY1rvTP80BPsSGybdg/O9Shl61QNBw/AwChq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(1076003)(83380400001)(6512007)(2616005)(82960400001)(186003)(82950400001)(6506007)(6666004)(52116002)(38100700002)(478600001)(6636002)(41300700001)(6486002)(2906002)(316002)(66946007)(66556008)(8676002)(4326008)(8936002)(10290500003)(86362001)(921005)(7416002)(5660300002)(36756003)(966005)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGc76A86gxbQy6BfNndJunbgq+lAkbEF/NtnSJb6GAOHwykIxxmMpILLvqG/?=
 =?us-ascii?Q?LOcoHUXSNrz3mCD1V0sjItvuwH1LaDzKCifB5+Vrg/g/gYI/WEqd5/yNWtwD?=
 =?us-ascii?Q?EdonbsI8BXAM8rXK20nCwVvpLPAGAMcrZl59OjBg295i8/ei3c9CRYNb/Mns?=
 =?us-ascii?Q?NHoHfuXIiWpiobUTyuGInyxf1iKMzbXSUwSmuG6dd7rtoDkHL7zDfyHn7E8G?=
 =?us-ascii?Q?FY9je1LDiAUhf6FfZaDK/ubNID9pQp+l/KlCcKG4AHmFHhaO5bdUhDkrqjS2?=
 =?us-ascii?Q?y5L0Q3I51jiQmuYm0v+bijB5fc6Jdr2F3NJDIKHV1in5p+5sQJmTpdURIFGn?=
 =?us-ascii?Q?irDswvF8K58scBR4OUN0eEn3O+Pbb/vHXJC6+0O+HFFXRD0TJB3DoXMAF0TQ?=
 =?us-ascii?Q?bGX+xqBmuPA6ntV9QdCeIYAiFwHwA2+3BTNe/lagdOZuoMGw338LvZtIgD2q?=
 =?us-ascii?Q?h7bCKdGnFIQZL5vNIXSfdi/ZzD+XWWjQoV4Q0FcnivJq1wlBJoUsID58zjf8?=
 =?us-ascii?Q?WEUU7GFX7tc5+LvADEvAvjH3FtTTnrYDJIrsLT9mKPbWUW9beDZSGqzKw1/z?=
 =?us-ascii?Q?XJXcexR+6rV13E63zDJFY5XDBDDmqu1wd2k5uwRT/f7sWOUscK7eesdRa1Uq?=
 =?us-ascii?Q?114pvtYoOrwuwfId1CDIMcSZjrrsHYgnW3UU3F+/WAq1uJ1Q9yEKQu9wN6BK?=
 =?us-ascii?Q?yCMj9nJFxN3BqHTMBco7dHOyQ3XtC1ofAUqZ6Z2Cxf8OE3a+hKK+7/8c96c1?=
 =?us-ascii?Q?hWmWL/zJ5vVKCHlCWi55WX7HhJ4RlDUdjwvGUwDs52wi6UHP20wHwHbwXeeM?=
 =?us-ascii?Q?+nMm4+D+poAm9sG0VHr6KEkbhx5a8UYD+YEryzaoVH8x0fk8WQ03BqAggVP9?=
 =?us-ascii?Q?aRBWkc0uBDgEzcYBdK0LyT+60zUXXlIjByylIGbbObFwJKi7gO9gHc31FOCZ?=
 =?us-ascii?Q?weadcEfgZHpn2rKQ4djO/0Oo05OxIatIo7t6Gjghk3MBMRVvjgx/WyCj3iYg?=
 =?us-ascii?Q?V2gHzSv0oRkS6kHlvV0ahCTneqvOGpu3pVdUfSJ0O5tuSGVyrL1+Mq9Gog+Z?=
 =?us-ascii?Q?jkzPhdj1mA5BiKbCtl/F+4t3m52mU9ltWlUIoRQ5SAoUJdy+om1OUcyUCcor?=
 =?us-ascii?Q?xbe90ovkxoYoe5Fq0xATIFzdQ6Ggry3ezdV3hlzJkV0tMm+FHqLwTRq9j8Uk?=
 =?us-ascii?Q?AI1YX3EWDhWRpzVnb895iLxSeTdh9jGh8CJHQwY2D+JkkiH9c0+sN1o44xcN?=
 =?us-ascii?Q?V1sdDGYFKQGpEho4K6r/d5o1/xDQ1gyt404YlbjchvCflInIEOCV6G5A73T6?=
 =?us-ascii?Q?lP5dLHgafSYyZPcRjAvRV5YkVWs3WbOC2l2Cm+dWibjbr5oSVjQlLiNdtror?=
 =?us-ascii?Q?yRcrr/2qQCzi2mmvGSrTev2dQ3zZnV27/hEXZPkaA4lfC1+tGpQwJlX146L5?=
 =?us-ascii?Q?kPkRje4mD8jlUPgycsw70rK9OUYLK+dIXh4pvX/f4lHnHbwKTUF4AUSwdk1b?=
 =?us-ascii?Q?zMvDCEds6xzGXQIU8A9WnOzZRpSX6AMoA+8LaeaV9EhtvloxmTYI4MlfUP2P?=
 =?us-ascii?Q?nnoHfP+X477wZ4D0VESHV+zAvinPcI80atxIIYUSYymgGoEY2C8xGSHxDB0f?=
 =?us-ascii?Q?0gTyaYQ8/UcWesv9aT7qUx5UJF9P9f/64XZAQz3Q5Yuk?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f308d0-8566-4b97-e68c-08dad7ead9a8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:34:50.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81ZvtxXot1ofi6TfojBqRKG8KK7ZyKeyMhSYbTCC6Qc05reQTrm0HcoQ0YoEAQWW44oUlZBo7706mXvJN7I1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB3819
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

So far __tdx_hypercall() only handles six arguments for VMCALL.
Expanding it to six more register would allow to cover more use-cases.

Using RDI and RSI as VMCALL arguments requires more register shuffling.
RAX is used to hold tdx_hypercall_args pointer and RBP stores flags.

While there, fix typo in the comment on panic branch.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Dexuan Cui <decui@microsoft.com>
---

This patch is from Kirill. I'm posting the patch on behalf him:
https://lwn.net/ml/linux-kernel/20221202214741.7vfmqgvgubxqffen@box.shutemov.name/

This is actually v1, but let's use v2 in the Subject to be consistent
with the Subjects of the other patches.

 arch/x86/coco/tdx/tdcall.S        | 82 ++++++++++++++++++++++---------
 arch/x86/include/asm/shared/tdx.h |  6 +++
 arch/x86/kernel/asm-offsets.c     |  6 +++
 3 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index f9eb1134f22d..64e57739dc9d 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -13,6 +13,12 @@
 /*
  * Bitmasks of exposed registers (with VMM).
  */
+#define TDX_RDX		BIT(2)
+#define TDX_RBX		BIT(3)
+#define TDX_RSI		BIT(6)
+#define TDX_RDI		BIT(7)
+#define TDX_R8		BIT(8)
+#define TDX_R9		BIT(9)
 #define TDX_R10		BIT(10)
 #define TDX_R11		BIT(11)
 #define TDX_R12		BIT(12)
@@ -27,9 +33,9 @@
  * details can be found in TDX GHCI specification, section
  * titled "TDCALL [TDG.VP.VMCALL] leaf".
  */
-#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
-					  TDX_R12 | TDX_R13 | \
-					  TDX_R14 | TDX_R15 )
+#define TDVMCALL_EXPOSE_REGS_MASK	\
+	( TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
+	  TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15 )
 
 /*
  * __tdx_module_call()  - Used by TDX guests to request services from
@@ -124,19 +130,32 @@ SYM_FUNC_START(__tdx_hypercall)
 	push %r14
 	push %r13
 	push %r12
+	push %rbx
+	push %rbp
+
+	movq %rdi, %rax
+	movq %rsi, %rbp
+
+	/* Copy hypercall registers from arg struct: */
+	movq TDX_HYPERCALL_r8(%rax),  %r8
+	movq TDX_HYPERCALL_r9(%rax),  %r9
+	movq TDX_HYPERCALL_r10(%rax), %r10
+	movq TDX_HYPERCALL_r11(%rax), %r11
+	movq TDX_HYPERCALL_r12(%rax), %r12
+	movq TDX_HYPERCALL_r13(%rax), %r13
+	movq TDX_HYPERCALL_r14(%rax), %r14
+	movq TDX_HYPERCALL_r15(%rax), %r15
+	movq TDX_HYPERCALL_rdi(%rax), %rdi
+	movq TDX_HYPERCALL_rsi(%rax), %rsi
+	movq TDX_HYPERCALL_rbx(%rax), %rbx
+	movq TDX_HYPERCALL_rdx(%rax), %rdx
+
+	push %rax
 
 	/* Mangle function call ABI into TDCALL ABI: */
 	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
 	xor %eax, %eax
 
-	/* Copy hypercall registers from arg struct: */
-	movq TDX_HYPERCALL_r10(%rdi), %r10
-	movq TDX_HYPERCALL_r11(%rdi), %r11
-	movq TDX_HYPERCALL_r12(%rdi), %r12
-	movq TDX_HYPERCALL_r13(%rdi), %r13
-	movq TDX_HYPERCALL_r14(%rdi), %r14
-	movq TDX_HYPERCALL_r15(%rdi), %r15
-
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
 	/*
@@ -148,14 +167,14 @@ SYM_FUNC_START(__tdx_hypercall)
 	 * HLT operation indefinitely. Since this is the not the desired
 	 * result, conditionally call STI before TDCALL.
 	 */
-	testq $TDX_HCALL_ISSUE_STI, %rsi
+	testq $TDX_HCALL_ISSUE_STI, %rbp
 	jz .Lskip_sti
 	sti
 .Lskip_sti:
 	tdcall
 
 	/*
-	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
+	 * RAX!=0 indicates a failure of the TDVMCALL mechanism itself and that
 	 * something has gone horribly wrong with the TDX module.
 	 *
 	 * The return status of the hypercall operation is in a separate
@@ -165,30 +184,45 @@ SYM_FUNC_START(__tdx_hypercall)
 	testq %rax, %rax
 	jne .Lpanic
 
-	/* TDVMCALL leaf return code is in R10 */
-	movq %r10, %rax
+	pop %rax
 
 	/* Copy hypercall result registers to arg struct if needed */
-	testq $TDX_HCALL_HAS_OUTPUT, %rsi
+	testq $TDX_HCALL_HAS_OUTPUT, %rbp
 	jz .Lout
 
-	movq %r10, TDX_HYPERCALL_r10(%rdi)
-	movq %r11, TDX_HYPERCALL_r11(%rdi)
-	movq %r12, TDX_HYPERCALL_r12(%rdi)
-	movq %r13, TDX_HYPERCALL_r13(%rdi)
-	movq %r14, TDX_HYPERCALL_r14(%rdi)
-	movq %r15, TDX_HYPERCALL_r15(%rdi)
+	movq %r8,  TDX_HYPERCALL_r8(%rax)
+	movq %r9,  TDX_HYPERCALL_r9(%rax)
+	movq %r10, TDX_HYPERCALL_r10(%rax)
+	movq %r11, TDX_HYPERCALL_r11(%rax)
+	movq %r12, TDX_HYPERCALL_r12(%rax)
+	movq %r13, TDX_HYPERCALL_r13(%rax)
+	movq %r14, TDX_HYPERCALL_r14(%rax)
+	movq %r15, TDX_HYPERCALL_r15(%rax)
+	movq %rdi, TDX_HYPERCALL_rdi(%rax)
+	movq %rsi, TDX_HYPERCALL_rsi(%rax)
+	movq %rbx, TDX_HYPERCALL_rbx(%rax)
+	movq %rdx, TDX_HYPERCALL_rdx(%rax)
 .Lout:
+	/* TDVMCALL leaf return code is in R10 */
+	movq %r10, %rax
+
 	/*
 	 * Zero out registers exposed to the VMM to avoid speculative execution
 	 * with VMM-controlled values. This needs to include all registers
-	 * present in TDVMCALL_EXPOSE_REGS_MASK (except R12-R15). R12-R15
-	 * context will be restored.
+	 * present in TDVMCALL_EXPOSE_REGS_MASK, except RBX, and R12-R15 which
+	 * will be restored.
 	 */
+	xor %r8d,  %r8d
+	xor %r9d,  %r9d
 	xor %r10d, %r10d
 	xor %r11d, %r11d
+	xor %rdi,  %rdi
+	xor %rsi,  %rsi
+	xor %rdx,  %rdx
 
 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	pop %rbp
+	pop %rbx
 	pop %r12
 	pop %r13
 	pop %r14
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index e53f26228fbb..8068faa52de1 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -22,12 +22,18 @@
  * This is a software only structure and not part of the TDX module/VMM ABI.
  */
 struct tdx_hypercall_args {
+	u64 r8;
+	u64 r9;
 	u64 r10;
 	u64 r11;
 	u64 r12;
 	u64 r13;
 	u64 r14;
 	u64 r15;
+	u64 rdi;
+	u64 rsi;
+	u64 rbx;
+	u64 rdx;
 };
 
 /* Used to request services from the VMM */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 437308004ef2..9f09947495e2 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -75,12 +75,18 @@ static void __used common(void)
 	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
 
 	BLANK();
+	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
+	OFFSET(TDX_HYPERCALL_r9,  tdx_hypercall_args, r9);
 	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
 	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
 	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
 	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
 	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
 	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
+	OFFSET(TDX_HYPERCALL_rdi, tdx_hypercall_args, rdi);
+	OFFSET(TDX_HYPERCALL_rsi, tdx_hypercall_args, rsi);
+	OFFSET(TDX_HYPERCALL_rbx, tdx_hypercall_args, rbx);
+	OFFSET(TDX_HYPERCALL_rdx, tdx_hypercall_args, rdx);
 
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
-- 
2.25.1

