Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B9632D5E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 20:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiKUTx1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 14:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiKUTxC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 14:53:02 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022019.outbound.protection.outlook.com [52.101.53.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE97429AC;
        Mon, 21 Nov 2022 11:53:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnmbqObCx0UvuAZAsu32Amp3RFi+0VD8y1RPTPXBgFjPpwNQaK8yLoEfBSvtw8DXXQU4C+eW03UJCduDu8KJbvAeyucRQqEib7EORJQxlCDR8t/gwda7erByJhe/vEkfwPeSiPSgaQ5ewXjX4ChYrKyie4D316XyNKlg9hzLgVvNf5g8s7hHMNMsGegyB25r1Zp9SG4pVpBJ0wb2G61oKXFue9/WCEHplDGAMOlKOn0ljTmtuxzMoAzCKV9q42Rwup7coAPAm0g1E6PBQ2Og7wWQntedHXh3OAO7CqgQeja3ehKodjlSsl/S3hxpfo77MsxGcxU+m8zT8HXiA6s74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA157Zk6ADQ5Q1UdtkapEDIAJPf8V706VHw/r6JPUJc=;
 b=Lz9yXLNt6Kjw1Nr0DG61wIj0KhjTtabFzrrhrAOt9P6j66k9Cnq6DVi24uoK+TyEeurvUHR+FJQyhZfk2s9WijLbYWUr4+R9kTSBXNCTtsYZk5MTNH+vHvnj7VkD4iqPlnDWXi5krGEu3qgjJq40SVdChcep+Uc/axzuBo4bCFIpaUCwiN8jrob+giObWThdUvpFGEC7mST50ulqMGdAhIzqSG7ip7H+2iDC2jgXov/T+WyM0oromJkTYd2kVLjSvqKF/IxAnY83vEsZIed/MXUpbkI31v12fCFxugkDndmPJLXHzvhavJIIvnWNkdFKwxdDvQukoXqHkzdZKHkiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA157Zk6ADQ5Q1UdtkapEDIAJPf8V706VHw/r6JPUJc=;
 b=RBqg2YtzBYCYjVMmUJnZMIB8uwnsGtT5r0d+TN/yGR0ru0kKAJC+PwLEsb5FzbI+TXNUI6SY1tdYQgYaJxQuNecP+E9XXxbYM3zWXKbCK2Gt3uVVSXpmCtuRrHbIdiuAuja85FPpO6W/CwylbLBVrXS0A9TBY4vmXmMY7JfZ7xI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BL1PR21MB3280.namprd21.prod.outlook.com
 (2603:10b6:208:398::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Mon, 21 Nov
 2022 19:52:53 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%7]) with mapi id 15.20.5880.001; Mon, 21 Nov 2022
 19:52:53 +0000
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
Subject: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Mon, 21 Nov 2022 11:51:47 -0800
Message-Id: <20221121195151.21812-3-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e480212-775f-49a1-d707-08dacbf9fa14
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VG7V8qlKtz9xvH4It+AljjSB724Ie+SvG8AWm8+WW+i/VWeLBnbw3i5r/heslVj0D6qBQlnS/o4nzQi7dB0TcR6fN0Grc6Jdb+8vP+6RJWoVDviGYHl1FVJ2g1sgETEzvhB5AB2c+gscf1O1lJ7wyXADE9SGh7igSi0h+euzxuQKMQfNhM4z0afxVPFJUw1RrAgID7D6ivmI4vsqV7IzMm0Zb3AhRH5fbWfmGFb/Oq7X5fiqflGfBMGZuqTjgHVG+SdPTUMMCnbP1cX2JSSMTpn1RftWr1YaNTZLDi+AOl05BDQMqu76R4aUas54MBB3tO6PPSgk7buoK8GXwKq5eo9wAeekMA+cNtRveqIk0GRlSMg31ETtfAWYpzvnxrqYifV0Pp0KoTMg2qPXF1m8yDwjYRdyN70m5XrQsZmZb7GQZeloxUEOpxqmDZW8ytv+eX/PzlsPf68HWoVicu0R7zOxPscoxSWy+IsH1vUALThJn9EdoBHuynsyEamKBhZE9hD8GIbOTt4VgCQNoNdFuQxP8FxD8KXCk2/XOR1+BeLLKCQL8DFm15RhR4BTkEnRYNeK45UPLa/uJgfNDXBfQDHsj3BNdYqWEVE9tjQFYnLa9g5jUP90Y7HyYsp57wJbNY3d2eWB8KN5NmNx0yxwB2qcsboiX2i+tAb7Uh5uNx+0Ha3FfJprpENZn9g8EcLpY6wchKp+rstgGeVJpy6/MVixaNodujmsy9PPJwxiuvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(2906002)(7416002)(5660300002)(8936002)(2616005)(186003)(1076003)(36756003)(86362001)(41300700001)(82950400001)(38100700002)(921005)(82960400001)(6666004)(10290500003)(107886003)(6506007)(52116002)(6512007)(316002)(478600001)(66556008)(8676002)(66946007)(66476007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RRiG/Zm/Z2PbHB3Pv996duy996aUtmvLNEH3D0hKkdPNs4p5l/WuqyXZiM5F?=
 =?us-ascii?Q?LoBdsYTNsrSWzZuTW7xQxVQAwk6SYx11PVH49Ai/ZkcG1ukk+QbghfBqWgSc?=
 =?us-ascii?Q?IKm2Nrq2d38pm1FygcF/EP6knIMXwgyyk74P9fsS9xMKeyFx5nIIf+FyIvdd?=
 =?us-ascii?Q?emVRDh39YLNDIZEK9htUjD/0zamhP5AfQ30wdZFygrp22hLTNWdTHLhHIdMt?=
 =?us-ascii?Q?Ek2EiJXpS/13tuYEZG4uuX377uiUe286p+kd+YRIydhpNWEqPqTZy11pR3s0?=
 =?us-ascii?Q?vNhtLIJq0Ncw1o2eV81+jfZx+E1B5QDTdywssQiGDemrlksAyCDzGLeU6y2K?=
 =?us-ascii?Q?Kce6bbi7AMLapsFWQrF++HfEvVb/gSzNyfI5eDIWPhodosDsqKO5OA8Us8nd?=
 =?us-ascii?Q?r0eQ9DrgJ/njaN4w9S4Zh/Xbjxy2KyRRFKDHeIEK5041Vjw2EDJz7cM0XbUb?=
 =?us-ascii?Q?k0G1WAuvWZ0SJRq6wmO5Q43i1h+9h3DPIW5/vTl460GpGZwo0bCQECBdn98O?=
 =?us-ascii?Q?zKUDHRikGrP9hQOs8Z9BB5nwbWaRy2eh7gebTIPqeQzOqBnIrigTTLIe7tCu?=
 =?us-ascii?Q?13biLJDGKwRIpM3j3tgCHL16gSZeuqQwkR5+WrJUedaAK1UuBtCmPFXuwVeR?=
 =?us-ascii?Q?bAperC7vl9o5ZqHrcxRsT80EdchLrF72vPo++KHtXTbE0WmqbTZquZI3Xuon?=
 =?us-ascii?Q?ed6twaboikXbGDkEjZAFStTLfiaw4p1YKDPtL85sAOu5YP1rx7fwSEZrV266?=
 =?us-ascii?Q?4RwFbQ8H2+X1GPMivqMMtxalE2Z/pJNNP9syDDquiz/y+bFMJ4YVvM6nbNNe?=
 =?us-ascii?Q?IEUA4WYkMaZpCVTJgL0oHDbLwEW+uDcx/l+PDx2SeD2/bXvDJjZ4VP1FO12R?=
 =?us-ascii?Q?bPlE6hjsct004kU/lF8s6DYp5PepmUvJMFNUykNansecOwh79Renm2CitNVe?=
 =?us-ascii?Q?6hIptg1Sg4hRgNRxK5QyPAN+oH9uK60YhxAkAApP0kGtb0neSzyT8oH6//+U?=
 =?us-ascii?Q?fFoWsQVrJIixHuv3CCaVW4c0ousRZvoxMImB9SpwiaFqITN1mMqs8PAXV0Yt?=
 =?us-ascii?Q?9egHME3F5VhCROjE6hGaDgA/PS3ww3F8+2wt6qc2dKNEU5wNrK40zaw1evaZ?=
 =?us-ascii?Q?cJOh1knGW87owrXqQJopAY2GIerc6LCOjSTM9hfnJYN5mXGeOXatKEKW73Vg?=
 =?us-ascii?Q?Q1q7K7nTMpaM919LjOvZ6gg4gk8eIRHpGW98FAb2/UPdtnvR7qasePs1NR+9?=
 =?us-ascii?Q?ixcPtmZgrcLNS6L139wR2ONFBWn/VqjwpTGjTt/NgtvL6JuAMElNm3K2LZwv?=
 =?us-ascii?Q?iUsjPdC1RjEr5acS9RKY3cqN8yA3+bidRhbfutt5ekea7Wstu8SUfuXf+26r?=
 =?us-ascii?Q?lo41/m3t4umyclX+UL8E4h/J52Rj9msSs9fFbgKBLaYiLfcRdXQA+5VBAugw?=
 =?us-ascii?Q?enXmEe05VnT7BdxmRpqLEh90beC8UvjAi/ddeFCYcL0UVMc6KoCge00RVi+y?=
 =?us-ascii?Q?bBCX01ridzjNyheWMIkNV351rDzQkb2KW9VIvfw30hpp7WAl6dMtrtQ6+HQH?=
 =?us-ascii?Q?F8+DOu3228Xg1z0tDRe7zMA9CNsAAwHqks1YeoQ43ee6JIEKDyp/pbj9GRF6?=
 =?us-ascii?Q?K0d8k5RFbdOWeRtQ53RGVwRZ3JIJXpINRAPUEF6vGNpv?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e480212-775f-49a1-d707-08dacbf9fa14
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 19:52:53.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqxzgourQicJx5tudqMkpZXdRrrvVXCGjLQrD5beeMyOc1aPeJVScB8x0enYUswDknJc+flDVqW1Hg3e09qKZw==
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

GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
operation for the pages in the region starting at the GPA specified
in R11.

When a TDX guest runs on Hyper-V, Hyper-V returns the retry error
when hyperv_init() -> swiotlb_update_mem_attributes() ->
set_memory_decrypted() decrypts up to 1GB of swiotlb bounce buffers.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/tdx/tdx.c | 65 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3fee96931ff5..46971cc7d006 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -20,6 +20,8 @@
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 
+#define TDVMCALL_STATUS_RETRY		1
+
 /* MMIO direction */
 #define EPT_READ	0
 #define EPT_WRITE	1
@@ -52,6 +54,25 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 	return __tdx_hypercall(&args, 0);
 }
 
+static inline u64 _tdx_hypercall_output_r11(u64 fn, u64 r12, u64 r13, u64 r14,
+					    u64 r15, u64 *r11)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = fn,
+		.r12 = r12,
+		.r13 = r13,
+		.r14 = r14,
+		.r15 = r15,
+	};
+
+	u64 ret;
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+	*r11 = args.r11;
+	return ret;
+}
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void)
 {
@@ -691,6 +712,43 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
 	return true;
 }
 
+/*
+ * Notify the VMM about page mapping conversion. More info about ABI
+ * can be found in TDX Guest-Host-Communication Interface (GHCI),
+ * section "TDG.VP.VMCALL<MapGPA>"
+ */
+static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
+{
+	u64 ret, r11;
+
+	while (1) {
+		ret = _tdx_hypercall_output_r11(TDVMCALL_MAP_GPA, start,
+						end - start, 0, 0, &r11);
+		if (!ret)
+			break;
+
+		if (ret != TDVMCALL_STATUS_RETRY)
+			break;
+
+		/*
+		 * The guest must retry the operation for the pages in the
+		 * region starting at the GPA specified in R11. Make sure R11
+		 * contains a sane value.
+		 */
+		if ((r11 & ~cc_mkdec(0)) < (start & ~cc_mkdec(0)) ||
+		    (r11 & ~cc_mkdec(0)) >= (end  & ~cc_mkdec(0)))
+			return false;
+
+		start = r11;
+
+		/* Set the shared (decrypted) bit. */
+		if (!enc)
+			start |= cc_mkdec(0);
+	}
+
+	return !ret;
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
@@ -707,12 +765,7 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		end   |= cc_mkdec(0);
 	}
 
-	/*
-	 * Notify the VMM about page mapping conversion. More info about ABI
-	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
-	 * section "TDG.VP.VMCALL<MapGPA>"
-	 */
-	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+	if (!tdx_map_gpa(start, end, enc))
 		return false;
 
 	/* private->shared conversion  requires only MapGPA call */
-- 
2.25.1

