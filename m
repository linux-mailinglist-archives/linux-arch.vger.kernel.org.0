Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7988A781FD0
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjHTUdM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjHTUdJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:33:09 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7281C3;
        Sun, 20 Aug 2023 13:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbMpnXp2DkxpkAmCGGr4QGcNT/E3vPxuGnrsitoDnj4OKaTD62ijXsT6KBKzHU7K8IhCYEKcnsBwEsW+13JZuqOak7bYEyoJ0z8ODHMTh6rPfbJCI9WFVW4X8P8iVF14ezTqmTs0WOtCCO+fxi17wF1kLqcYqXRRPzTqTfeQ6D4p4Utcp8K9sojpQwvcYQ7hKS2lmf0dTym5RIYMu1FizyC0imz1UF0zVnZD/pqfrvkKJzdtxBC4nTJvfRsbLKEREBxICpi0ikKFAe4aNhjLqIyxF9Mp0mCKrw5G/VogY4FuXDwxPiIy5v8fU9yYpFhaBQ+5WDml7L/lRFqppAdP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFQpMaisCpLq69CvX3Gsbo+ckSPEU2a0DFzSLK75Q3c=;
 b=VHaHE9DLIzLyPfgt5G4p31bD6I3ur6jmCF82L20OlrtPyh2CsDQabTsuG1Hb0lUo42MWjuzRnejF1cHXa/PmsFoa+9cyjdOST1WdE0MIg2twS7YXVzRdkItIZUzHKUvh2HxRdNI/VU6nV/pnacDsuJ7FBJr/H2vGkd2xCTqm63WhmS+xhFlL6uKyX2MkcX3VtwQ9S+9fB9kgWpksObpEt/0ke0fUkRmBV6FROoZx58e2jvCe+EBzCnDbuMbmzsHnabEOhbEAuNyDQHAOuXao+77pALY0y/QVH7B5j8EjnaLWSfPs7EyrojWpXHu2RzwjiFKQY6YW4jllw1UmdakyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFQpMaisCpLq69CvX3Gsbo+ckSPEU2a0DFzSLK75Q3c=;
 b=U+IF2o2bnY01qFykikzV1I6i8ltUf7KghIeYSzyKUU95Ne06SyoyEQqb5EHUMoo+/IPfN2LjkmNpDqeOOLgL3a0iJlGhAe5g6HxvPd/DARu/QA++hYDZOkBju0T7XKT75VzJgc25OoNz1thOo6Ct2UKZZjJnWRsLzOYTO6+Z4Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:28:04 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:28:04 +0000
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
Subject: [PATCH v2 5/9] Drivers: hv: vmbus: Support >64 VPs for a fully enlightened TDX/SNP VM
Date:   Sun, 20 Aug 2023 13:27:11 -0700
Message-Id: <20230820202715.29006-6-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18485514-e6e1-45ad-aa14-08dba1bbf4fa
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cx693UHBn9D/qTrJgT/Hdj5c8L7U18QXiyMZO7QUBJGOUiJKaZeBNHwL6h6acttgpMBssYVNR5j2730MEzJBgadrnnrBlvO/wqnkcF+MOyzld1pip1mknAoUbgRaZiY2n2J1BjRNoW/+CW7O44o4Mw/8CmNMjdLDPrxMWG56gP1kIKQRUDSIsWGqlp0Ix52ub6XAja/RbO6Cubp0LAmR1icFMAsrc6uq3HbGEftcqoHVKAfMfyK9ldoSgQBeXAgoXaNWQ7JAGTjV59r/QQEzI1x39iPZCBftcyeymzvMqZ3+uPIc7mEYdBJFmcB7O0wwNA38iltL9NaFa+gefvQUy9diDGw5Oa6CZz5QsQMd5ELbTPL2Er4iESxdkL3SCjHCh2bTwL7J9ACrKPaxFVAQOlN+UTAU9Jv55Fntl3T4zoRSgXgZCLWmVTxFbz6dnQkJSMAcTC+WPGT6tpXPlr/FL9Z9qsF3qNGmUkTBWk0m1ofdnUawI2v4q09vrN6ASIh1NdmuVK6pnkIq253v3GPb+uICQgbnEMAoji2JSLdgBfhKvoQE64ghVizy7ZbzVQtuJVCKGU99r7/GDCKpnrmGp9OP2vMWjuK+XjAuaBtWIyF7YpjDxh0GFD+hTE2Tfh1jdL1BxE45S+2l7BUeMMyk3mZ0hYfHWT4YvNz2rOYmE8h87vd+TffVXu6J3NoeUlFF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(6666004)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GQShKX3iXH4bJpPfN+Jo7HLHlrrqkvMoiIN6/Rm+iwhaef9vGZGV0n6/TKY8?=
 =?us-ascii?Q?bq+vCM9ZflgRLtMX/loUgR4NG0pFSsjtUgOArsR/jI+PbLiOYP+fNs/o4Xso?=
 =?us-ascii?Q?Bl62aVvsL7Qm7VHh6cTptA4/saculoQgLZTI1HIFeak9J+GwtCMBIGiNmtN6?=
 =?us-ascii?Q?M2Hp4rS5Bd5kaeVJ6h39dPpU5izcd2rflTqlhDVyenby0JZaQE/ps0PsmEEf?=
 =?us-ascii?Q?qvQFRfDvwHisH4WCOddwZI2OOSZwOB85ETeUhXsQ5tnVO9Os7+rzspCaKJ8M?=
 =?us-ascii?Q?STf0iSIG1MSgjNj8atzaZp/sRZsGgIsV2F2nLXt0Mp1yGLGO+YsycT0RTBpw?=
 =?us-ascii?Q?UcbhzM2dMC8uG+hVwOVB6L5v0uR9msml3wvMw7U5etv/xuwuztANHehHc6XO?=
 =?us-ascii?Q?a6kR21z9s6tnNqTMXuGT/0xlzNN4jYCN/RLrSi3K283wE8+zodRhIl7KMFOE?=
 =?us-ascii?Q?/xgTIwmXjYVHs6yMgOId6Yymmje9/VOzBj88OlC/uI5quKuj8AlZUQeCcYQP?=
 =?us-ascii?Q?v8lNBQ3jzLEyaQuZlBjiZeOxQtb808MlZmyPup/yLRrPnN2Ca207/ogDUkiA?=
 =?us-ascii?Q?1gIElPyoyfam8DQrkSfFhtExUNo5KpEEHOaHMyNmz2IDaCOWYwiHUNUE/VG0?=
 =?us-ascii?Q?7QDGnyHrxtNbO/jyBzSKBReXk9Ah8agd7P6hoibb756EL/0R+bidKba42/vY?=
 =?us-ascii?Q?NkEHE++eqesT3bjAXA67JAi0507qtU/Um3Nk+KihoetZJeZya1NlO9Sa6W+n?=
 =?us-ascii?Q?G4Nykz5cPx/G63jI/yrO7GjKw+s42um3VNMxdlPzea5QWC335/dEbrwNwask?=
 =?us-ascii?Q?rdthvbu4IzJRtGI4Gr9vn7t+Fb0+L5MQLFfy6B5ZAmpfELMivShZYNFvoxJ+?=
 =?us-ascii?Q?TduUQZpyZXFtRwINJuXD3NBeRmtQA8xRuquqkcLe+5QkmZRZsIp16b0Fq8NB?=
 =?us-ascii?Q?7hLp7QD2cN54UJFqWt1/F3q1kM17Bxc2lUukIe+hqB/UXV4Zb2KDqZuQXyN5?=
 =?us-ascii?Q?hoV8QlvR3suFFp18flSY5Jp/sllc2wkxL7aaQnW9c2ICOeOnggUsF2rI4tbs?=
 =?us-ascii?Q?6xmLmihU0Upz9QEjJ3GPFi88IX4vVkM/ZsWFQcsAXF+jgsDFbuNkkypSNpwH?=
 =?us-ascii?Q?MDFYWatIwCT3GZqfTCpp9RWxaKBuspjGZvLbtv5QdkLYM25st4D6jFRHrjL1?=
 =?us-ascii?Q?Zs+qKXJjAjdDvNGcsIGknciIdSBnq6E/ghZH6TuTLJQkNtzKWtJaM09Nze6d?=
 =?us-ascii?Q?Ygebwx4t3wNCAmw89uUYzZOaF4hKAS+BvIEF1rRX5lFlg31MA0tG3MqHMD+R?=
 =?us-ascii?Q?AF3IRdlAef8HeZZIJEu6t3DuZFZZRaLkPo/8DD4OVKEWAcAbgbetpsEI1ZTf?=
 =?us-ascii?Q?cLWDa9RNMiPS/X0lSCiT76/I0gqiPGKCT3HiKK3o+RsDGDSarMlHy29wdw5n?=
 =?us-ascii?Q?yu7KPslEUaC/SMoxa5XT2ovzjjEHNlzd1DFpf12cqfOOWtszepQ+/1VsARZa?=
 =?us-ascii?Q?Yxokh/rmTYPO0PIeTzb6/c7KJ82YsLX15tMHslvXwCb0U4sSx7VPidRXL1Cw?=
 =?us-ascii?Q?eNSFwpkfBmzWZrEd9LtgRgZaldpLanB/I2ejU+iM/uVBBAiSKSL4giR/eP/J?=
 =?us-ascii?Q?WQNtcqmhW6HY/l99x2m9j+NqD7Ri2QczgwxJimKn4lQG?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18485514-e6e1-45ad-aa14-08dba1bbf4fa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:28:04.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCv3xJeI7b9ITgfQ00lG8jBbyE6NRoOeAJUyCeDlbL7k7j5oCZLgc1aN9YnMssLhK/HEpnb0BjMxXhLfTZ0iNQ==
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

Changes in v2: None

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

