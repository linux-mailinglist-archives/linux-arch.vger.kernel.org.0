Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB260645065
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 01:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLGAeu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 19:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLGAet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 19:34:49 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022020.outbound.protection.outlook.com [52.101.63.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DDE17A94;
        Tue,  6 Dec 2022 16:34:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVTTjMYagKh1RzHFa84Bw4cTffDrQ6ZNKBHywuU5t1ZuAv9v19Xd0mA7tXGOm5ywWNvnwJPxrmwls/jR8lIkkR5ARdBVZVNS4tz61IMkdqq66pbE0RYV1fEYh6nKhG9c/IKmMz7NirH4t5N12Te8ClQVNR58E8ydUpDfi+IjHTgedy6IfUdS5hhSGTqlxic8fVAkOfevsiAqv7T/BOY8j/1DJbPdM+bvSry+eDoOtyVfpzioPgMhoJLspnK4EAi7L0pV/K5cg25u4QroXu/L7M5oy5UNJe7xXKSAdcovhwCA0virlhvwa1rh50eVqxIdZxyM7dLaMqOOXyKzNyXYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dutSyDN/nvNY8GnZFJOCLpMV6EcuHMlRpqxCTBHhYmk=;
 b=WPdOWvQmUr3aE2TkwlBGucMl/SoWbQNM9kQSOk0sUmmY1UiQjnbhrStq0ae9M+Lla3Iv2vCnkyocCoBJ1GvNYp2GU2O0VbkbQozr5LHTcN+p38I2VX1lDLJTI3NbHXfd185JMQyudZyTLCnjeXPKiE3rag3TS5MUI2tm6swQ6Pv93PHEf3Frx3SM6FUsuNrZrMm9rGkFOKKzhmV+JXceCYDeyC8vcw6vJnEYgugbATGpbsuriJb8mQzPX3yzxE0ctyvbFR4aK1rKcbyxJJhe7x+vHTOZZyAz+F4egZdpXZhmG8VuJKj+mdJV1rudhrl4TXT4FoEnPccGIR/ekshYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dutSyDN/nvNY8GnZFJOCLpMV6EcuHMlRpqxCTBHhYmk=;
 b=jp1LUVL6kPJkuswl3PBSlLRZEAdjQSIm8vF30zg609akfbxC36esa1z9tnKboObhsuh/5iGOIuqIOl/pLEz2MVUWcOKbjsKXJGq+xdDDHbBrYDk7UpJz7JIb+K3n0s6SoKuo3CYXepWMLAMCP+xcUDJ4NMcyhLulhRZyW9/68+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by CY8PR21MB3819.namprd21.prod.outlook.com
 (2603:10b6:930:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Wed, 7 Dec
 2022 00:34:43 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%8]) with mapi id 15.20.5924.004; Wed, 7 Dec 2022
 00:34:43 +0000
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
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Tue,  6 Dec 2022 16:33:20 -0800
Message-Id: <20221207003325.21503-2-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: e31c7b74-1edc-4bb3-3768-08dad7ead556
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /P3hSEXKghlY9QkDOEgTl7o42g3fo0rpxeWU+dP5J/UIsl4KvWkqbHs2V2F8fBXk3QG3JuDXoZj5fZeegoz5O4IOa6rBQwKuHR58KKx9lbpT20juzvyiU50jSezeMlYgAv0cbMxsxCnhEt/r+0ZO5lnOCCkYKeW5nX0U6flTn+1xm0RI9IshcdtZF12J76v3zG6tfSQz0Jjl2XLTWWZDT/nKLgqzKHhorPRsh9LuSoLezW3IkvtFs9CFuMxVldc4iG+ANJ+sD4HD6umN/cY6HxdvHrd1mOPSrYL9JyzdOEDI39Lt6b0/qjeIEAk4hJZb/xupx6fxijyQGpcajdUc8cBLa9D2cVNO1nSpqcaDct48920AvQtOdRDVz28CxzZXIMjEZ2Pg/jQDiooEOIaY/6gMAoD7mLR+bMiZ8m9Idui9+0DMDopVvvAXxHMvKmERKMc2mpUUn7bAPNoDjXRZa//obMQpAisY3N14wiAY02QKLzbqhj7HGomkNJze0EY6Bq5dX/iLswPmFiC2buGax+/9ZCQE5/xV87+lOlUdTtZGrcXWJHjfWXXKIxv76ZXxzHrx+u9Vo4qRbs7bpwh0BXTh5s+D+yQEGkbd5oarZRDJ9maLtjB6eTMp0A06XniADHm4jzeuJLRAhtAC7qG4GShVuhahhYhbKDgUURVjHIKUZECE40t+gEOgw8jx9i64EwH4kdecFNQZ9dXovZsGJw81xf05t2zpP4QIvUaLVno=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(1076003)(83380400001)(6512007)(2616005)(82960400001)(186003)(82950400001)(6506007)(6666004)(107886003)(52116002)(38100700002)(478600001)(6636002)(41300700001)(6486002)(2906002)(316002)(66946007)(66556008)(8676002)(4326008)(8936002)(10290500003)(86362001)(921005)(7416002)(5660300002)(36756003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9aA5K9nSe4VeCC6sN+Jqv3SatPW21uFt+jhNbcpVBHQ3U8Kzh3eXopZrPZTq?=
 =?us-ascii?Q?un7c/Mu7TmsJsmCjV2OY/U69F+dcUSQskRQxyBAq7EqbpfZV/zVkJN/DxSdb?=
 =?us-ascii?Q?+ejYxDI91Q2DRormG8SERXz4qNbryMkHYU8kb6ZbZLYzNRn5lc+UjHPgDbkl?=
 =?us-ascii?Q?CKyRbAZ6GPuu6scXs//Y14gDt6SnzqFAy2NnClxCoRnwdccVMUauU/E6Oui3?=
 =?us-ascii?Q?2d8R5hcuJueVaPmSfWTkOxlMsGBiMDnlKIw2Tej2CjHlV+s6GaC5hLwOlije?=
 =?us-ascii?Q?GBU380OZnns2XxEWweh/ug67vNILEHeKVar6LmC1nWI2aLWG17FRkGoXx3ZI?=
 =?us-ascii?Q?zF8Y/W7U96hYunQwPdf9a4ZiR9hC7GUjrRHElIdop5atRtZ/WaEJFqXh+gpc?=
 =?us-ascii?Q?QqsHHg09xv4TJXVHdvnBPTqEmWtjlYtcnJ6C6GDbEwTb52iRTzK6fdhK0f2M?=
 =?us-ascii?Q?TweoXcgiR01yETzcNJ9MNrvngTkfQEPj4bJ/fhnTqGunQBAR0gUphTSpcZBS?=
 =?us-ascii?Q?Kru6wuzAAiU1OYHd6KtcVhON4DpUoRRd2vvSIgVJPPsuKLn330iHjU6ShfDz?=
 =?us-ascii?Q?ancf5AR/WetY4SpHAAOKSuokYIzLZK61rgffb1BF22axTZnX9d9MzJBantL7?=
 =?us-ascii?Q?G8kF3UVClDvkIy8iyVxINkBXaYrNgsDBEZa5Few+9Extj3wGNuDxNqGhinRw?=
 =?us-ascii?Q?QkE5RwVaLL92Fkh7842xZ0CR+R5KdtsMaTF/6XqJCgyRfSAR0a73vV/JfUXR?=
 =?us-ascii?Q?o4bxjgmYxsKeymzX4ERJt7DjuZ98FEPPYk0xHNU+NP33Rq+ECWQmWmaO8NJT?=
 =?us-ascii?Q?nWAJfPwm0smTHGGqkYLGb4EtTr+6xSMW0vgqZTC0KEPsMOqJc6yBLJNin/jS?=
 =?us-ascii?Q?a3PVgD9k/582yc9SNYv04zgc80sEuNrETAEKwSvWIsgTBXkBoUgSvEV1BCm2?=
 =?us-ascii?Q?BqGd2CEGfzYMGod9IYCcHo6lu2tmawNRBWI70t5NzmxouSBCyeRx+qRpQgb+?=
 =?us-ascii?Q?o8WTNEMlW1CNxiwHPiAG490DgcitZbTef8X9I5FhbdrFtSYD+aCn85dZL9b5?=
 =?us-ascii?Q?rbc8H4hVt9cVhXKUujve8lPlsk6JFSDBcw9lSgnPiy60EEqUdFYfVVDYLO7Y?=
 =?us-ascii?Q?d8d+BTEErLV75BjFR8277ZK6Pvjuv+dKBe2+UKFiPQZEunY8ZzZdgr/u2W0Z?=
 =?us-ascii?Q?d6JoxLfmpiwPLjpTPye+cgVclKKcgeY4ZLsApCI52CpNm9ervestrvMMcpqx?=
 =?us-ascii?Q?oKSy+Gc6fZRTdO6DEkuRxwTjvY63pIZFA4vpyiENb3IWul9QdFsus1wW/e/K?=
 =?us-ascii?Q?WnnYCQI5sit9jXI0B9wgOG8JnA3m5d8zeTUsb0oa9PbdljGzrgQtGbaMU4Ip?=
 =?us-ascii?Q?K9GzSWagZU16EbrDcSuIDZvahjvHXd+haf+MgeOAyydNsj5+e3dKc/GRXy7l?=
 =?us-ascii?Q?mrlBb3NfrPdS9ChomgKZp9brX/BfckROToFfpAEQz414Yc6y3YLZx+EV2dVD?=
 =?us-ascii?Q?a0m6OX5ZDkWrBv8xRzuiP519eOoDG5SY3alZXzAbD5wP/iXcf/PFVzd2VE2s?=
 =?us-ascii?Q?IDYu3bxv2YDj4hACca6Yk6Dj/yUxpeUDLV0N5gMGE1PSQ6x/itldlV0NCeLx?=
 =?us-ascii?Q?eTad8sM0GnVPtgUlYvYdTHkfmvn6NhfLOJqGQnHnVk64?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31c7b74-1edc-4bb3-3768-08dad7ead556
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:34:43.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFObKUWpyitARkV347nzZjVl0VO2iqzPrhaa6DtKdTPCx+vNDwfRK2tJpT1bIx+rbhqcuX6YIeIQ/m9qFjePSA==
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

GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
operation for the pages in the region starting at the GPA specified
in R11.

When a TDX guest runs on Hyper-V, Hyper-V returns the retry error
when hyperv_init() -> swiotlb_update_mem_attributes() ->
set_memory_decrypted() decrypts up to 1GB of swiotlb bounce buffers.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Used __tdx_hypercall() directly in tdx_map_gpa().
  Added a max_retry_cnt of 1000.
  Renamed a few variables, e.g., r11 -> map_fail_paddr.

 arch/x86/coco/tdx/tdx.c | 64 +++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3fee96931ff5..cdeda698d308 100644
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
@@ -692,14 +694,15 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
 }
 
 /*
- * Inform the VMM of the guest's intent for this physical page: shared with
- * the VMM or private to the guest.  The VMM is expected to change its mapping
- * of the page in response.
+ * Notify the VMM about page mapping conversion. More info about ABI
+ * can be found in TDX Guest-Host-Communication Interface (GHCI),
+ * section "TDG.VP.VMCALL<MapGPA>".
  */
-static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	int max_retry_cnt = 1000, retry_cnt = 0;
+	struct tdx_hypercall_args args;
+	u64 map_fail_paddr, ret;
 
 	if (!enc) {
 		/* Set the shared (decrypted) bits: */
@@ -707,12 +710,49 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		end   |= cc_mkdec(0);
 	}
 
-	/*
-	 * Notify the VMM about page mapping conversion. More info about ABI
-	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
-	 * section "TDG.VP.VMCALL<MapGPA>"
-	 */
-	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+	while (1) {
+		memset(&args, 0, sizeof(args));
+		args.r10 = TDX_HYPERCALL_STANDARD;
+		args.r11 = TDVMCALL_MAP_GPA;
+		args.r12 = start;
+		args.r13 = end - start;
+
+		ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+		if (ret != TDVMCALL_STATUS_RETRY)
+			break;
+		/*
+		 * The guest must retry the operation for the pages in the
+		 * region starting at the GPA specified in R11. Make sure R11
+		 * contains a sane value.
+		 */
+		map_fail_paddr = args.r11;
+		if (map_fail_paddr < start || map_fail_paddr >= end)
+			return false;
+
+		if (map_fail_paddr == start) {
+			retry_cnt++;
+			if (retry_cnt > max_retry_cnt)
+				return false;
+		} else {
+			retry_cnt = 0;
+			start = map_fail_paddr;
+		}
+	}
+
+	return !ret;
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest. The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (!tdx_map_gpa(start, end, enc))
 		return false;
 
 	/* private->shared conversion  requires only MapGPA call */
-- 
2.25.1

