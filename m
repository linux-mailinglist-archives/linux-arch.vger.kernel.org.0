Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7916A779AA5
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjHKWUF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbjHKWT7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:59 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004A30EE;
        Fri, 11 Aug 2023 15:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQcJJSD86O505Bz9l+rYU2UihxJFwe/hb9XOBG8HFZGefu0DVXoPsLe4z/HiGiJtAO0RVouo43qeYb3wgtf595Z4cZ+JZJmK7pfSDUlrOMyfzI7uxcyATGwMi2KesPz2PP3Ru35QQZVW2iKtMxSABsIgikFIiw1mMCv+3KNIWSKrKa97SmENARJMe7+rWYGoscNqeasNnU0Tq5DCN0SU7Gl91XcAAHV5G2JqPmZpLqTKJ0tD2PsuAek6smjmk7seqmxfLzxVloXtBQQ7sGWpm9eF7h3mvE9SvUCzmjwe86iqYmJZt/zBXBKlB4Djt9kIMUhUQU5jBs64pN96bId6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqtBgYF2h5GHK+rW8z0uE5xp9vLLBjDPZow42mIYH5s=;
 b=Wzb77JaiY0jZ9i1kFnWtmCGkhWBbDlP+V4hDmmQq7IbY1eMe+fq8BE4uardwXK5EoqCuzwFD3MQMz3B2Kb4Uz9ohpqZU7pWvYnTR5PxwVlws8iv7GNkPyk+nv8RZ2MulDpfmPEkTKy50N1uEWvGCVhIg1b5f0K6V11Uf6bQHbgTZp4r81ngSdIio7qEEbEWCklEj5zgQuAp+XdITznFta2FWhVbHr5oaqa4uyHQ9VSo8VhLrLYWNx1dgRkbyhZsbtkRzQNT1kTzt/yGkV608Cakuj/fHh6IsDiHTgFPDPtIdkjghV+nKHqhgF1dl93vnzDYzBuYYjMFqcDGXqPD9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqtBgYF2h5GHK+rW8z0uE5xp9vLLBjDPZow42mIYH5s=;
 b=hidA2/DmVtb3RVtXItDqii/jLk8mP6X5mSQmAmcMUkQJqj0P9qALX/tC0GtCSglgdyjjw30tbdNViWvgQZq9y3fqCd14jclPQV6t5ZWbBnmdSZDsn5hnNl7Lw4VmduXxeA/oPjzQKzLc5JMl0F+Fjdq0fWhkTPci2P+aCdAgvcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by DM4PR21MB3417.namprd21.prod.outlook.com (2603:10b6:8:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9; Fri, 11 Aug 2023 22:19:41 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 22:19:41 +0000
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
Subject: [PATCH 9/9] x86/hyperv: Remove hv_isolation_type_en_snp
Date:   Fri, 11 Aug 2023 15:18:51 -0700
Message-Id: <20230811221851.10244-10-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29641c8c-ed06-4662-864c-08db9ab90e49
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1C6z+vgysD6bUHtsc8VisjjZU8sN/mpv+itCyy5UwsOfsSNMZwfWwqwZUvf5oGxFoa0mrTjM/KLERTchSvxfIH0aMR7vTBcIRjjVuy8FN26c0UGVOBJspy5r+Ql52+Go249f+GC4t6NhKNeor7tnBdHmYp00wIt9TcKEDYQ11EAhD2xEc6Iuz7TNzG0Xz04nshHGVK9UtJq4j39GDdxXsQJkmgJbrQVa1uREJhmizgAj+x1rAFgllRhUCX/paQ2n/5cz3KjMaZuPeXN5UizZbKyXRMQGCaHqPztHLFkX2bNuB6B7RBas0s2+m6gzBCMso309xxxJVBVXteGz1fVvQXJpll10dSPAoC0/fpLrEJoX9cuCzQyYjYuIuTM3cU8TxWzN/CGgU0AV2SnMvz/Qq59Ezkx5Tj/1aADxMhfl4gQADpVjVOdAjJ1Kju/MiI5dvSpGJqenfWUPMbdCrSoFp5C8JO9QcZ+ZcbWmeNgn0XnJXpejdV0Jv8q8jH+6pV8MbOFct2D+OBv1fS7JMmBd9fM3dWmpNYOakLabLjreohD8GaZZauMzAcA4aevXDyUyp4EBToZeIkOfDxFO9VervR0pWltaBdHoUFPuuHJHqavM1+p2TxIoLMIliWVR7O36uYMwxBqkgJIjzBk6l7q8kaEntiY5S8UIVGPk6zwmmC56XwWLP+MCc2/cuxrXXZw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(6666004)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y7hJNZXKe0xs4wzu3qGVjzkAKnrEkIg28bEX3DAVs5cE26JxZZZ/fjUEOKPL?=
 =?us-ascii?Q?TrRPtQ+bvYFHSNzGc2qAkEJJ8K1cg/+mdVhoD8W8H7O5jatm6Z8oNk6/GpOj?=
 =?us-ascii?Q?XAbUzCX4zOi/kt+wldE+i5SXUax5yrm5VfrVNKa5g2fCFdlV2ELUpNWxsvcP?=
 =?us-ascii?Q?msSoUmx83FVQx7UQtm21rH8n5jzaLNsNEhQwoJaqcZo+cPQ7x5HZ3vQGMBF4?=
 =?us-ascii?Q?oNxd92l+0Ss5QGxl7LURE0uIGJcUpDh5Pk1FsGbi4ydZqiln+s+Wjnd/ZANk?=
 =?us-ascii?Q?9v7R+5RQgQefC17LzyveCvFqEYi06qa/jBt4kcBr7ppobFh5Wle5HNAJ4LvC?=
 =?us-ascii?Q?VOr0Zkc/buLIU5G6rJp9JsyXQRchnvxsSDsZT+gYUMd18I8nY6jemeypbLlq?=
 =?us-ascii?Q?MY2o2z+VLdyyLWra82gUNEgWmTXwVsetDeMOVaQibkJSls0L1tRiJ3TaraUE?=
 =?us-ascii?Q?y47BInXkyEHUBnm3V18KWuFpwDfDkDnCGw2QzAm1p3O0ewV6mpYE3D+IhOyo?=
 =?us-ascii?Q?qUISG8XVqOyv/fMZp+3RrxckZ4Y96qPksRIax+9OUZ/iJ6HwfIV94Zz1Y82p?=
 =?us-ascii?Q?LimFeT02TBqIoEH0X4Wf4kIa3UckIp2kaLQcn+/yzm3/T15v0ppwikoksSES?=
 =?us-ascii?Q?jqcwfDeEIVmoJEmO7iTz39N3kSuPvuTZa/MeR1QeSoH9i+cTiQKl0SEbmlfE?=
 =?us-ascii?Q?vWlvcF1iL4A2xScYK+eMuY6Xse8xf6t6kNT4LLa1m8K0/PEgTAWGFepedInD?=
 =?us-ascii?Q?7yGQtE2KtOVFBZSzLC+d7JKInAJSdfyIVVkFKisIzKeEFX51bl60lg+CerQe?=
 =?us-ascii?Q?vz4jgSbV12jNyA63u9oerX3pI5+IN2hTy5gNB8QIT+Uti1j+cildkVtytQCW?=
 =?us-ascii?Q?ySCh6XRRTFTgPDOjEUkJEp016gkYDxNkGl1JgqKhLHKyEJ2utltyFE48pbHP?=
 =?us-ascii?Q?R1zUeX+XNBtqbAQvUjE0L8HY2vf+Xo5qeF8LyEbWlMz4dQkf7eXC/eiPIYBU?=
 =?us-ascii?Q?EAKxm+f+oTir+TcuqyT3BbUe3Gl8NtGgcrjVl8RrSdtR1pvoZVfNtE/CegUR?=
 =?us-ascii?Q?NpHy/pVKL0z1vDtHR+dmtW25cRay64cfHZBqg5cNYEylTT7XAXjaMIcijruw?=
 =?us-ascii?Q?PJJKk9QyypUlvArRbl5mzpu0KEPOfMJTdS7Xnu5a5eXHay7TbFwVLovnTbMn?=
 =?us-ascii?Q?lzv9+KSqtevStBlV1CS84geOaQS4LmoidWPFaRWZWb2hKHkYaR1/5LSqxm7W?=
 =?us-ascii?Q?pNtCOU/W+iqg0NVXOVVRy9FwsibRTnK2ua0D6L9JdmWyWcNiAr9rT9i13Uem?=
 =?us-ascii?Q?Y5nInR12Uicd6VfwASwnz4GPGisBegcHwfCBrna5A7bIDk+Nl5c2T5+5ubWp?=
 =?us-ascii?Q?pZIIdPcbdCSjBblD8n0Y1MFmAzq1s2cIPG64eAHRxOVaRjdL8TC9umEFUaOZ?=
 =?us-ascii?Q?stmnm7IsRyQCkFkFf1pKfdqfGg5QlUof8xZIcEkrZny4Skw1Av7HV4TKgIUH?=
 =?us-ascii?Q?23wIcKRlPIxysC+fLkFtIH1UZl/qu+laRS40uVdLFVuXqiwRuKwE0KJGXp72?=
 =?us-ascii?Q?A1XEIjoycQGscSiTOiYP82A0GE/zy8I2PoPLYgnkcy0+Win4Fq36wwiW+BCf?=
 =?us-ascii?Q?mFnBEL+2XCos5mwCIvIaa7spMtrVvuw5WFSPZrH4TeM1?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29641c8c-ed06-4662-864c-08db9ab90e49
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:40.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8UrWOkNUAHgWGY4lporF2GIakxs0VYR9g6ymJGn8HpsVzlDig7WvRxW2h5OPOd1Ps2zFSdKHpbhv8FKB5MmDA==
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

In ms_hyperv_init_platform(), do not distinguish between a SNP VM with
the paravisor and a SNP VM without the paravisor.

Replace hv_isolation_type_en_snp() with
!hyperv_paravisor_present && hv_isolation_type_snp().

The hv_isolation_type_en_snp() in drivers/hv/hv.c and
drivers/hv/hv_common.c can be changed to hv_isolation_type_snp() since
we know !hyperv_paravisor_present is true there.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      |  2 +-
 arch/x86/hyperv/ivm.c          | 12 +-----------
 arch/x86/kernel/cpu/mshyperv.c |  6 ++----
 drivers/hv/hv.c                |  4 ++--
 drivers/hv/hv_common.c         |  8 +-------
 5 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index abd0a8bd3f15e..b23466c1cd574 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -117,7 +117,7 @@ static int hv_cpu_init(unsigned int cpu)
 			 * is blocked to run in Confidential VM. So only decrypt assist
 			 * page in non-root partition here.
 			 */
-			if (*hvp && hv_isolation_type_en_snp()) {
+			if (*hvp && !hyperv_paravisor_present && hv_isolation_type_snp()) {
 				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
 				memset(*hvp, 0, PAGE_SIZE);
 			}
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b8fb1557c1986..068f05574067c 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -586,7 +586,7 @@ bool hv_is_isolation_supported(void)
 DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
 
 /*
- * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
+ * hv_isolation_type_snp - Check if the system runs in an AMD SEV-SNP based
  * isolation VM.
  */
 bool hv_isolation_type_snp(void)
@@ -594,16 +594,6 @@ bool hv_isolation_type_snp(void)
 	return static_branch_unlikely(&isolation_type_snp);
 }
 
-DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
-/*
- * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
- * isolation enlightened VM.
- */
-bool hv_isolation_type_en_snp(void)
-{
-	return static_branch_unlikely(&isolation_type_en_snp);
-}
-
 DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
 /*
  * hv_isolation_type_tdx - Check if the system runs in an Intel TDX based
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index fb585d3b080b1..6b464ed3cf546 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -306,7 +306,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
 	 *  enlightened guest.
 	 */
-	if (hv_isolation_type_en_snp())
+	if (!hyperv_paravisor_present && hv_isolation_type_snp())
 		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
 
 	if (!hv_root_partition)
@@ -442,9 +442,7 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
 
-		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
-			static_branch_enable(&isolation_type_en_snp);
-		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
+		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 6b5f1805d4749..932b8bc239acb 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -166,7 +166,7 @@ int hv_synic_alloc(void)
 		}
 
 		if (!hyperv_paravisor_present &&
-		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)
 				hv_cpu->synic_message_page, 1);
 			if (ret) {
@@ -227,7 +227,7 @@ void hv_synic_free(void)
 		}
 
 		if (!hyperv_paravisor_present &&
-		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			if (hv_cpu->synic_message_page) {
 				ret = set_memory_encrypted((unsigned long)
 					hv_cpu->synic_message_page, 1);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index c0b0ac44ffa3c..d3f95a1be1e99 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -386,7 +386,7 @@ int hv_common_cpu_init(unsigned int cpu)
 		}
 
 		if (!hyperv_paravisor_present &&
-		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
 				/* It may be unsafe to free 'mem' */
@@ -535,12 +535,6 @@ bool __weak hv_isolation_type_snp(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
 
-bool __weak hv_isolation_type_en_snp(void)
-{
-	return false;
-}
-EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
-
 bool __weak hv_isolation_type_tdx(void)
 {
 	return false;
-- 
2.25.1

