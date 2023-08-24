Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7667869BE
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjHXILH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbjHXIKt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:10:49 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6875019A0;
        Thu, 24 Aug 2023 01:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAy2EOTTDybv66nuw5oFKw90DWupTFzr7FAfmt5I4nD1KbPtTfItqPHygZt+XuqqFeGhY9jCVyQTgGOPuiIMFVwFtmFWMGuSgEWTL8fg6iOoaiV9nYmEr537dCVQuoDEknXfmEFhH4Jb9wjuGaNCMagJt7d/U67BROZIGuSvzDAdxbqVVK4l4axCWCWrck6Q3Ihlt/5eMyvLioycRY3W/hL0K3vy5yyOenAtP/16h8axZDNStqYHu573iJqaIM/O0N1COQxlAF+y+ZOEhs3xgNrzAEGdV4tz4hHp+IyPKenCUwTn0MRDE4JTLENyp6yg5ySwbTb1nlpCjJSe665TyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxoVD7VtqZ1PESoEapVI9djwjmZYO03sBA++PPKSlHg=;
 b=NGU1yxrmPJOfkjLtFa8bdII503d861hlfzjN7Z8HHOO0wCzqp0tCHf5DiVH8q/PB3XXGV/4cst0eFZ82f+Hc2Ytx3Y5V7yJPHDCkUBarnH4ZHOWndPkiUsr3bxzb+A9g4xaaNBR507HaLxA03xoVDenRSs3E2uJS7HhWJHOa2j2ZnNbk0Zw9NU3QMekrUN3PG8LQx/uIS6KxeSxNrm+WuWWz4yCXE1oLjXtFyFNDdbeXxS9weX3xpE+cE2g1A+CU7fknc6WXelZL4pH8LWI2oWHvFFe21eTzVmn7X8gSftRrmKLWakOwxE6OBDKSeSWnoBrSeCiCn0PWHXvIKxMu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxoVD7VtqZ1PESoEapVI9djwjmZYO03sBA++PPKSlHg=;
 b=KP2+i3ApPZk8hZ+rAzXkttIFfI+NISWUoISGf16Z9bVVCbOjncpyi+cY7SSQ6qb0jSfP+hm4PJTLGBBzqJWVQSJZIGPuuS3Tm0K2IkQHoxvz829s7CoJD6RIC4XA/ZZPGa5RdmlY0qmOiTSK0tAyzNUCb6NY3zJYO3Eb7p4Gh10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:08:19 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:08:19 +0000
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
Subject: [PATCH v3 10/10] x86/hyperv: Move the code in ivm.c around to avoid unnecessary ifdef's
Date:   Thu, 24 Aug 2023 01:07:12 -0700
Message-Id: <20230824080712.30327-11-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f854597-4620-4707-8dd3-08dba47946cd
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFhMVq3Hu4nVAvCT5GsNK7betCExKGYkg8vBBaaQzpfA4F5gUqaE7CwpE6dimgaHLj16B4d7hH6Pfo6otpxbOkDk6k3JJqPcE/fPV3oaYBJ5mHlbI6FiO2z4rV2HgWPF1cECUhbdLA30/OvqdiNBX9ZTnypf+3qruIM3vpmmnYj3YZmvMxXDGbyS2ZeddotIfSsWkIetGMi3BSf4egLz/IN48pM0RZXVb/BEBL0gAqhAG1BNye63xMPRpMKPvbDHnBTEkH77l6Fb95tc3pngMYl/fgfs9K7Q/8neJeY/RFt1+NDwicMZwyKd332cS5ppSg4urk5w9+1I2xnonhAAoU+dRPwlOklHHIKs3p0c5e9Q/fXXBSLaOTR2Nj/4bMIsSus9c/tm9/IFyUZz6X3a69WvQYeLMKtSujtcGfLKlxF9ftbCQuWvLsgY4H8FuYy28/EQQQg6l6LeTt2uZ/OLotaaU+zy3QnB7SCORqqz+MDi4IY/ZeAl+72euN5j+R9PVxXPc7JrpoT0S1dAchB/vLGdRXUBy7irD98cg2zg7Y8rJmbFyVMjDVGfGvTlOuEoL0m9v3uVonfU6+xqT1CNNpLkBfRdod3l0/sEs/SUjpFhOSoGA5aY3lhv5ngFU49jwzEqhECZRyD4/E2Da8cMg3auuds3v5o8Ji6jnPYC7raDZwuxjr4iv/69PVf/yzW4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(6666004)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(30864003)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9qncviO4W4NedtKKcuuZqFnk3dJKasD/GEIMteyitDMu67uReC/mZj+J+0/q?=
 =?us-ascii?Q?iT/iVJ94tkGcNhfp3iadQAlm7oynk89rJFpryYWXweXdl5CV6qsn/ko+pDiI?=
 =?us-ascii?Q?cqSBLeyM4VozPdRSFt3qW6UesXswaZUP0KWPg2PFzL6tWN14qpOOqoWIqbzn?=
 =?us-ascii?Q?NXXNXNKAbafRgXAteoNCzKZGg96o5QLzGJT+M4xzHLs+XJrPO/4MuIzsiX/B?=
 =?us-ascii?Q?l+y/pAql36RgLkXeZ7gAo8EgX9eXUUa/ZMe3nHSDAt3PaJkFlQLGl5hqY0bh?=
 =?us-ascii?Q?eRQry+nVNsZJz279fQJt6Q7wwjaHwH7gvF0OeARGz+AcgmDy9JksdoPsLfZd?=
 =?us-ascii?Q?93JWggArEe5wwgVHu/kGN+4SPlwVp08rr5wX96/whGo5w3zGMkoLvLhyensJ?=
 =?us-ascii?Q?eD4672LypncDZiTJ7GVHpxFkBsvc5Dxjxrxxq33HfQSwNLpCpIvxcaOLD6vi?=
 =?us-ascii?Q?rNOW8+EO9LE+0x2C6bKA/lYjShQMLgCOwbdI47LwnUcgZssWgU/HLjTllzFg?=
 =?us-ascii?Q?7FBVwZVpj6fKMHe6ff8C97bAoJ/Eu1vj+84CjtB3u3i+tnfuqnN5s0QZIdx4?=
 =?us-ascii?Q?qrrq2OcqJ2EQMtwneiSsR/vq0nEVfHshTICWeObmwXuknhvFug/ANYSJBiSt?=
 =?us-ascii?Q?3T9iChtOxcqC4b/DHY6pgJqGQ2MAIWF+1oZ97MpLeDR4dG5R8NIAPez7YRt8?=
 =?us-ascii?Q?oxcnqiG/vM70Mm3skeMrzP2/CIBCe97Er2rQ6aZi2avnT9CtGgEYjrxEMfJS?=
 =?us-ascii?Q?DLd/MfcW7mU60yku2WGrXGYOTpHjzVzJzm/yat4QHAhCmHP85D8KOmlbNljI?=
 =?us-ascii?Q?Pri+1XFi1WooGR8uZEVsAzNMfZuoRqExfrXAYanMjvtfnNj1uUpk/zI3kI1d?=
 =?us-ascii?Q?yJ9Cbe9oozWbxV0VdbVENWCIJqSQynThlvjRVMTibVHGYTnuLbGkqltVdz+I?=
 =?us-ascii?Q?K1mNUYXGxaNxIIcbl9DtknqanhqisP2vpV6aar2W9ylvJP8iIo0f5ZF3yUGX?=
 =?us-ascii?Q?KZTdpNBJVh07TI6hkKAOa28H9x85VqdXMJQiEliP0B9KQsF1dwkXh2VXq47S?=
 =?us-ascii?Q?P6XtFsLu5DbU0PvKVgr1G7BL6nQGxylWaXpFubs5P7Ur3DysILQoulaSM4Ij?=
 =?us-ascii?Q?BhEmrtroLsb+yRD1TkdpiKUpOTJ0gR0vE910MddpcY0SUhcvVFxNBBjJDb9E?=
 =?us-ascii?Q?ytbTZxqrEmdHzObx/RS485jTsWTL8UkmeOgEI+7B+SEZhMyM2T6JXJ38Mi4s?=
 =?us-ascii?Q?YldynVkjchIWDMtRqk0pZmE9GwODlAARsQyqiB7pUR0OATyreCX0Hhopx4WE?=
 =?us-ascii?Q?7mPfyJXXAT+DwUv9mUN7XBBq4ko5NpbfrAtFkZqMPt0tyYF9dLRFKdDWnh/C?=
 =?us-ascii?Q?9L9B/9YcNRrs5BGklrbFmxQD5DKkMNtxhMwzKzZEHt/g3xAJC0euwXpyvIxh?=
 =?us-ascii?Q?I+o/7q0bSwq0o/9VuEu5rZnlpDel4K6L4tFOw4ZD+7q6joGiA4izHvB2Wr8O?=
 =?us-ascii?Q?nbhycI3yqxrblsMoyZe3/9QfiFoJmr37o5n9UM4tXoWllJK8ys8j7bqcZBlF?=
 =?us-ascii?Q?kaeqkLGfTKZR1GzM2MY5n+bkG6Jzhrl/GASkjCssQRmmblDmIIE6qjWqtzkW?=
 =?us-ascii?Q?0I8fcdbm8zEbeO7G+UZbDVUqQwgFdmz1SOLPDrnVMB81?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f854597-4620-4707-8dd3-08dba47946cd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:08:19.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cuM4nH6oOCngTk+/IW+WdfPotEw7oE7uEySCl3Bm6ZarcxK264tsg3kRtLCEVdP2TifiAseEBjXRvsihRNTQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3901
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Group the code this way so that we can avoid too many ifdef's:

  Data only used in an SNP VM with the paravisor;
  Functions only used in an SNP VM with the paravisor;

  Data only used in an SNP VM without the paravisor;
  Functions only used in an SNP VM without the paravisor;

  Functions only used in a TDX VM, with and without the paravisor;

  Functions used in an SNP or TDX VM, when the paravisor is present;

  Functions always used, even in a regular non-CoCo VM.

No functional change.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

   This patch appears the first time in v3.

 arch/x86/hyperv/ivm.c | 309 ++++++++++++++++++++----------------------
 1 file changed, 150 insertions(+), 159 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 3d48f823582c..8fb3b28670e9 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -30,9 +30,6 @@
 
 #define GHCB_USAGE_HYPERV_CALL	1
 
-static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
-static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
-
 union hv_ghcb {
 	struct ghcb ghcb;
 	struct {
@@ -66,10 +63,10 @@ union hv_ghcb {
 	} hypercall;
 } __packed __aligned(HV_HYP_PAGE_SIZE);
 
-static DEFINE_PER_CPU(struct sev_es_save_area *, hv_sev_vmsa);
-
+/* Only used in an SNP VM with the paravisor */
 static u16 hv_ghcb_version __ro_after_init;
 
+/* Functions only used in an SNP VM with the paravisor go here. */
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 {
 	union hv_ghcb *hv_ghcb;
@@ -247,6 +244,140 @@ static void hv_ghcb_msr_read(u64 msr, u64 *value)
 	local_irq_restore(flags);
 }
 
+/* Only used in a fully enlightened SNP VM, i.e. without the paravisor */
+static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
+static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
+static DEFINE_PER_CPU(struct sev_es_save_area *, hv_sev_vmsa);
+
+/* Functions only used in an SNP VM without the paravisor go here. */
+
+#define hv_populate_vmcb_seg(seg, gdtr_base)			\
+do {								\
+	if (seg.selector) {					\
+		seg.base = 0;					\
+		seg.limit = HV_AP_SEGMENT_LIMIT;		\
+		seg.attrib = *(u16 *)(gdtr_base + seg.selector + 5);	\
+		seg.attrib = (seg.attrib & 0xFF) | ((seg.attrib >> 4) & 0xF00); \
+	}							\
+} while (0)							\
+
+static int snp_set_vmsa(void *va, bool vmsa)
+{
+	u64 attrs;
+
+	/*
+	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
+	 * using the RMPADJUST instruction. However, for the instruction to
+	 * succeed it must target the permissions of a lesser privileged
+	 * (higher numbered) VMPL level, so use VMPL1 (refer to the RMPADJUST
+	 * instruction in the AMD64 APM Volume 3).
+	 */
+	attrs = 1;
+	if (vmsa)
+		attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+}
+
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
+{
+	int err;
+
+	err = snp_set_vmsa(vmsa, false);
+	if (err)
+		pr_err("clear VMSA page failed (%u), leaking page\n", err);
+	else
+		free_page((unsigned long)vmsa);
+}
+
+int hv_snp_boot_ap(int cpu, unsigned long start_ip)
+{
+	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
+		__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	struct sev_es_save_area *cur_vmsa;
+	struct desc_ptr gdtr;
+	u64 ret, retry = 5;
+	struct hv_enable_vp_vtl *start_vp_input;
+	unsigned long flags;
+
+	if (!vmsa)
+		return -ENOMEM;
+
+	native_store_gdt(&gdtr);
+
+	vmsa->gdtr.base = gdtr.address;
+	vmsa->gdtr.limit = gdtr.size;
+
+	asm volatile("movl %%es, %%eax;" : "=a" (vmsa->es.selector));
+	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
+
+	asm volatile("movl %%cs, %%eax;" : "=a" (vmsa->cs.selector));
+	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
+
+	asm volatile("movl %%ss, %%eax;" : "=a" (vmsa->ss.selector));
+	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
+
+	asm volatile("movl %%ds, %%eax;" : "=a" (vmsa->ds.selector));
+	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
+
+	vmsa->efer = native_read_msr(MSR_EFER);
+
+	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
+	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
+	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
+
+	vmsa->xcr0 = 1;
+	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
+	vmsa->rip = (u64)secondary_startup_64_no_verify;
+	vmsa->rsp = (u64)&ap_start_stack[PAGE_SIZE];
+
+	/*
+	 * Set the SNP-specific fields for this VMSA:
+	 *   VMPL level
+	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
+	 */
+	vmsa->vmpl = 0;
+	vmsa->sev_features = sev_status >> 2;
+
+	ret = snp_set_vmsa(vmsa, true);
+	if (!ret) {
+		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
+		free_page((u64)vmsa);
+		return ret;
+	}
+
+	local_irq_save(flags);
+	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
+	memset(start_vp_input, 0, sizeof(*start_vp_input));
+	start_vp_input->partition_id = -1;
+	start_vp_input->vp_index = cpu;
+	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
+	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
+
+	do {
+		ret = hv_do_hypercall(HVCALL_START_VP,
+				      start_vp_input, NULL);
+	} while (hv_result(ret) == HV_STATUS_TIME_OUT && retry--);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(ret)) {
+		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
+		snp_cleanup_vmsa(vmsa);
+		vmsa = NULL;
+	}
+
+	cur_vmsa = per_cpu(hv_sev_vmsa, cpu);
+	/* Free up any previous VMSA page */
+	if (cur_vmsa)
+		snp_cleanup_vmsa(cur_vmsa);
+
+	/* Record the current VMSA page */
+	per_cpu(hv_sev_vmsa, cpu) = vmsa;
+
+	return ret;
+}
+
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
@@ -282,6 +413,20 @@ static void hv_tdx_msr_read(u64 msr, u64 *val)
 	else
 		*val = args.r11;
 }
+
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
+{
+	struct tdx_hypercall_args args = { };
+
+	args.r10 = control;
+	args.rdx = param1;
+	args.r8  = param2;
+
+	(void)__tdx_hypercall_ret(&args);
+
+	return args.r11;
+}
+
 #else
 static inline void hv_tdx_msr_write(u64 msr, u64 value) {}
 static inline void hv_tdx_msr_read(u64 msr, u64 *value) {}
@@ -309,9 +454,7 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
 	else if (hv_isolation_type_snp())
 		hv_ghcb_msr_read(msr, value);
 }
-#endif
 
-#if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
  *
@@ -432,141 +575,6 @@ static bool hv_is_private_mmio(u64 addr)
 	return false;
 }
 
-#endif /* defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST) */
-
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-
-#define hv_populate_vmcb_seg(seg, gdtr_base)			\
-do {								\
-	if (seg.selector) {					\
-		seg.base = 0;					\
-		seg.limit = HV_AP_SEGMENT_LIMIT;		\
-		seg.attrib = *(u16 *)(gdtr_base + seg.selector + 5);	\
-		seg.attrib = (seg.attrib & 0xFF) | ((seg.attrib >> 4) & 0xF00); \
-	}							\
-} while (0)							\
-
-static int snp_set_vmsa(void *va, bool vmsa)
-{
-	u64 attrs;
-
-	/*
-	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
-	 * using the RMPADJUST instruction. However, for the instruction to
-	 * succeed it must target the permissions of a lesser privileged
-	 * (higher numbered) VMPL level, so use VMPL1 (refer to the RMPADJUST
-	 * instruction in the AMD64 APM Volume 3).
-	 */
-	attrs = 1;
-	if (vmsa)
-		attrs |= RMPADJUST_VMSA_PAGE_BIT;
-
-	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
-}
-
-static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
-{
-	int err;
-
-	err = snp_set_vmsa(vmsa, false);
-	if (err)
-		pr_err("clear VMSA page failed (%u), leaking page\n", err);
-	else
-		free_page((unsigned long)vmsa);
-}
-
-int hv_snp_boot_ap(int cpu, unsigned long start_ip)
-{
-	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
-		__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	struct sev_es_save_area *cur_vmsa;
-	struct desc_ptr gdtr;
-	u64 ret, retry = 5;
-	struct hv_enable_vp_vtl *start_vp_input;
-	unsigned long flags;
-
-	if (!vmsa)
-		return -ENOMEM;
-
-	native_store_gdt(&gdtr);
-
-	vmsa->gdtr.base = gdtr.address;
-	vmsa->gdtr.limit = gdtr.size;
-
-	asm volatile("movl %%es, %%eax;" : "=a" (vmsa->es.selector));
-	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
-
-	asm volatile("movl %%cs, %%eax;" : "=a" (vmsa->cs.selector));
-	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
-
-	asm volatile("movl %%ss, %%eax;" : "=a" (vmsa->ss.selector));
-	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
-
-	asm volatile("movl %%ds, %%eax;" : "=a" (vmsa->ds.selector));
-	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
-
-	vmsa->efer = native_read_msr(MSR_EFER);
-
-	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
-	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
-	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
-
-	vmsa->xcr0 = 1;
-	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
-	vmsa->rip = (u64)secondary_startup_64_no_verify;
-	vmsa->rsp = (u64)&ap_start_stack[PAGE_SIZE];
-
-	/*
-	 * Set the SNP-specific fields for this VMSA:
-	 *   VMPL level
-	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
-	 */
-	vmsa->vmpl = 0;
-	vmsa->sev_features = sev_status >> 2;
-
-	ret = snp_set_vmsa(vmsa, true);
-	if (!ret) {
-		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
-		free_page((u64)vmsa);
-		return ret;
-	}
-
-	local_irq_save(flags);
-	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
-	memset(start_vp_input, 0, sizeof(*start_vp_input));
-	start_vp_input->partition_id = -1;
-	start_vp_input->vp_index = cpu;
-	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
-	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
-
-	do {
-		ret = hv_do_hypercall(HVCALL_START_VP,
-				      start_vp_input, NULL);
-	} while (hv_result(ret) == HV_STATUS_TIME_OUT && retry--);
-
-	local_irq_restore(flags);
-
-	if (!hv_result_success(ret)) {
-		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
-		snp_cleanup_vmsa(vmsa);
-		vmsa = NULL;
-	}
-
-	cur_vmsa = per_cpu(hv_sev_vmsa, cpu);
-	/* Free up any previous VMSA page */
-	if (cur_vmsa)
-		snp_cleanup_vmsa(cur_vmsa);
-
-	/* Record the current VMSA page */
-	per_cpu(hv_sev_vmsa, cpu) = vmsa;
-
-	return ret;
-}
-
-#endif /* CONFIG_AMD_MEM_ENCRYPT */
-
-#if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
-
 void __init hv_vtom_init(void)
 {
 	enum hv_isolation_type type = hv_get_isolation_type();
@@ -654,20 +662,3 @@ bool hv_isolation_type_tdx(void)
 {
 	return static_branch_unlikely(&isolation_type_tdx);
 }
-
-#ifdef CONFIG_INTEL_TDX_GUEST
-
-u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
-{
-	struct tdx_hypercall_args args = { };
-
-	args.r10 = control;
-	args.rdx = param1;
-	args.r8  = param2;
-
-	(void)__tdx_hypercall_ret(&args);
-
-	return args.r11;
-}
-
-#endif
-- 
2.25.1

