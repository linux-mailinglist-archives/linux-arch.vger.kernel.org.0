Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB224781FD2
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjHTUdP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjHTUdN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:33:13 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEC110D8;
        Sun, 20 Aug 2023 13:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUReQikF4/nd6P9dmQ3GPkHwp8rWAZO+GsiX8S5qCJTPOtU9/PQCFQSvEOs6o+r9N6U478s5ocOeHeWH1ivPdnDVteQklMKtN5k0PALg1vlvyF3V2Dy6Cp5W5GXvEzJtr55kxO5Hr3hWJnFE+wDfounrcDRMga30Zjl1pxwj/Why+SRriMaOF/C5ZDdWDN2v6NjF0/lbbSnIzclmJ0qmGR1Z0r3hJpK+aLGtjg3A3Cy1COHrlOwU0B9INgVUplvKdt6qOkhEBXiC78v5uP5Z7haiLGZej5cSIk0WUVnKlYDioV8UWnwXXU5UhUlWa19ztaXa99dJS2ZtKUgW70KDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkMFMYnNaiD1ybzqSA+pUHkRd7VwRg/biH7WaDJybFc=;
 b=hMSyvrmuAUQeG9Eex7Elo2HzvrHtvxfRXz/3c8n6UayLcvP/zjBzVWtgGn+gJxy6nX00xrgZG4LmR80qDDyAe3rdabknx8Af0lKPAg8OcT45eY0+zZ8og8Zm1NfHOumBIR5Hs7VhePu+39vgT0ZafSIkoY0PDbQZkOCVqSAUvU73BuIJTuUE+YZkTE1jEqOF0jZ3+Kwj75SP1m6zgWwqSJcuETFqbSn4d8WgawwoBhxe82TdvyAZA4jRsgIkbpY9wHXGS+kE726HH+TWviF0DqhYGMy0yaPVr5/EW9peOBHbeUARwm8wo/z3S8iwAFCp9ZgY+EWS+rZDH6L7Dl07ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkMFMYnNaiD1ybzqSA+pUHkRd7VwRg/biH7WaDJybFc=;
 b=dTZ8vxPyr1yT7ZbKQeHr+vegaM1IdrXyEUrbEry0EFFn96VCsn2RVYmhpI7DKADYRrT74oc+H8tSwxKPEcKVfXrynnWvL4HWVM/IH1hag9XrUh99QV1KOLXbrBPlsPnGEu5di9SvcF8QwUnIOJxDuDlUs3WHabYMIJT4NHI27zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:28:13 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:28:13 +0000
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
Subject: [PATCH v2 8/9] x86/hyperv: Use TDX GHCI to access some MSRs in a TDX VM with the paravisor
Date:   Sun, 20 Aug 2023 13:27:14 -0700
Message-Id: <20230820202715.29006-9-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 07b330a8-a613-4b85-2ba5-08dba1bbfa28
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raexETEgthOMDxD7W+gdz8rDpa+O+GZXCfQYARmCqHBsWsEPp7E53AzkrH/h6+80FOHR0SPwKfknWGJKtpTwmoab1a3d6V6PmLkYCHM49dB+STGVLQ/YGJbxZoT/KIgdo0EaQCtLgVusZOsZuJKiwtzYMNopnkIJYqvHOwu0g+8Yxa0k1J2PgS1ExwboGOcTkGuvAxPOkwg8zhLO3UBMeS0QYZ46ma8nijqgWCpEonQjsAUuEerlszkiJ0ooCSC9YbeO6VLNJ6TE+z0dKZ0DA0MjUM1f55c6ZrdHsoaXG8ETvji0HOdqGqjfj1/ALuKS+xtBEh2kD/wOVQU3T2s5kcyf5fAofy+IVhpICgazo/dKWOdXo1iF466HMIqNMcdmQG+JzNeMQKie7TbpweohsuiX4BAVMZ2wN++7UAtcQmgyd/md1jUkpkHuLDPaEQlBfmI3qFfm2goHAuD1RmvPILlwXwsrsbDLukN9nIiasXLJUZd6yDjNSyAahhBazK1LcPVW1pTLalb1y1NCxh5nT9kJCXT7fgQiGgcEa11R0bScWL+davRxzwLeJAMybslZRyv2iU+9ABGqUlWGIgYRkCNqGWcXZVhUHotQucsLgZduSUaGMfgST+B/xlWUfqTze0Toz3cZchlmsysN9bGXaIEeNdv4Km2/yMvFnG0ACiJMEXuu94LcFSDME6hbBI8k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UgZ03GIHYV2xptUVUhkOnoRQ0oP/qr/ZxqILMG4NCggMgWE/GvALOh6sNDuc?=
 =?us-ascii?Q?OC6Y133erqLHsyJktObiPzEk9BIgbhQRa1ADLiUpCwqtfwYWXhM6+ShiZRYg?=
 =?us-ascii?Q?7ShwJgatt1uA57/nkL86ek9HIkoWLU96cmJij7v5OERVKhKykXaudeQOyuTP?=
 =?us-ascii?Q?N4y7frSXmOKxGLy0pn3RW7bIy3UwM4+V40SlsGf2WmO8y7z55sZ94JCUyUMd?=
 =?us-ascii?Q?rRF1YqSdNvKHaxDlMBAD4opLcl1ZGCOw7Bl7wqyFxKZlCt7FTbmgeYOwXrY+?=
 =?us-ascii?Q?5L5JDeQ/AZrzJCTuja90nTNAgcgyIRQ+B2Rj7yMpD0/SekEwzxuHYsE6+pFF?=
 =?us-ascii?Q?pQoYgLKZustugL+8kk7WG0rskr1ce4nkTr/aiaQ3lIvjiSE1al5+iC82IcJC?=
 =?us-ascii?Q?AH9nrE8hky2ziaT/tp3ADpzHcfEH+ACUqaCIn7bBXvFPL1XJ2wxKJ5+gX/7J?=
 =?us-ascii?Q?6AQBtwEjJ8v+EZcDJoYATLpJ+kVYuUW1IPnJJ5IN/sXBwvyauZoNVrAd9jAT?=
 =?us-ascii?Q?5fxy5IRxiAPsWcXiIEeuZ1QBtdp6ed8PLAAU0/FRlZSx0GizybmkskOwF1yo?=
 =?us-ascii?Q?pWWYS3IMtrQHJe68uG3o1xt5wsozvb9TXvF/7Rvl+HKMEF+Y1lu7cCX8C5ld?=
 =?us-ascii?Q?AvsakoT4bEfykSzEQSH0e3maJ2Df7odoZPb+koyvYuczi34XERNrT711W/1p?=
 =?us-ascii?Q?Ii0Xhys1HLHtU7/1FYkP+1xpcN5pyMjwmoVvhBvJhdYLOhORQtrEZCY8EFRK?=
 =?us-ascii?Q?gs/Rxd6TwSD2ZiMTtJvevkcS3OreIeHMoOUJRWfrXx8FVC432i9NdwqL6VJF?=
 =?us-ascii?Q?L1RFULDeIsJL7DSci2RgHp9hGx+F6u+yme+mExsVcnQJkdtObg9pOB9IeReM?=
 =?us-ascii?Q?FzGaCtYRGYk6CWzdp4Ejgeft5iLr7ipXKv0avYXnLALXzy13ubAvYde6q1qE?=
 =?us-ascii?Q?ymvGugYJR/57M5YFH/JXaHaKqZ8Y6jimeq11vIJ4rMONDG+MJm4lti881NJ4?=
 =?us-ascii?Q?DmP7igV1O4Jh11P1ss3y/xNyBnJ9G56EkQNlYNen4IdswbKlYkWsDO/kiHaJ?=
 =?us-ascii?Q?sHLRgRs94zUBk7nGj0VhuysAmVNqh5zcOnobhyL4eUYBbjCluRBfDrobAVR+?=
 =?us-ascii?Q?yUd23RyG1QWyVDxu5ZWPxVfD1JTN9YciGLeacGsntSNfMh/QxfXR9wEpFpD5?=
 =?us-ascii?Q?zpgc9SqXSEOj7BG6EvpMyPN5BHKmdv7fpLpBrzFJWMb4aBjkHVoIbfGt38wJ?=
 =?us-ascii?Q?aUEB+V3AwsGSMsWQAsdwusMSCvej3zc3yJya9K74o3czliUUwMmiWEJ8nbZz?=
 =?us-ascii?Q?sb27rER41KAkt/WbWKOKJiooccKA1kjO127mTPVEWtp1CWs+TbJ7g68A0LF4?=
 =?us-ascii?Q?rsHSP19pr0NihH0+WMxN6W+pXhfop/eeb+4bhPuxmDHWzaiikEdMsUIzN5rx?=
 =?us-ascii?Q?4xDB+3vZNYfcGoGJA3HrGv3tnNA7/3M0bUGmi3z/QhRQe62deXs0UWQCMJ8r?=
 =?us-ascii?Q?1zToqM8ka6Vvz6pAzvZmUBcS0PfnyYcWj2amqrTf4GkXxAcidIsypIak+Sdz?=
 =?us-ascii?Q?k/FxF7Q0ZdiMm9dQHPLyI/LIhI4Clef7CHfWq4PSblpETME/rJGnWjSlKp2H?=
 =?us-ascii?Q?dycsQ4lJh1WrCYjbzRZrzOsb6EZ0qeSkIkWnnTocs8E7?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b330a8-a613-4b85-2ba5-08dba1bbfa28
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:28:13.3700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftF620b+s67ntgT5JptL8BagiW8y3B6zP/8/fhhU2sf8WtIRJnXZV6GU6O79jdSegOgeK9NGQ7w99N1BgldU+A==
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

When the paravisor is present, a SNP VM must use GHCB to access some
special MSRs, including HV_X64_MSR_GUEST_OS_ID and some SynIC MSRs.

Similarly, when the paravisor is present, a TDX VM must use TDX GHCI
to access the same MSRs.

Implement hv_tdx_read_msr() and hv_tdx_write_msr(), and use the helper
functions hv_ivm_msr_read() and hv_ivm_msr_write() to access the MSRs
in a unified way for SNP/TDX VMs with the paravisor.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2: None

 arch/x86/hyperv/hv_init.c       |  8 ++--
 arch/x86/hyperv/ivm.c           | 72 +++++++++++++++++++++++++++++++--
 arch/x86/include/asm/mshyperv.h |  8 ++--
 arch/x86/kernel/cpu/mshyperv.c  |  8 ++--
 4 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 892e52afa37cd..18afbb10edc64 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -500,8 +500,8 @@ void __init hyperv_init(void)
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
-	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
+	/* With the paravisor, the VM must also write the ID via GHCB/GHCI */
+	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
 	/* A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg */
 	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
@@ -590,7 +590,7 @@ void __init hyperv_init(void)
 
 clean_guest_os_id:
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
+	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 	cpuhp_remove_state(cpuhp);
 free_ghcb_page:
 	free_percpu(hv_ghcb_pg);
@@ -611,7 +611,7 @@ void hyperv_cleanup(void)
 
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
+	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 
 	/*
 	 * Reset hypercall page reference before reset the page,
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 920ecb85802b8..93d54d8ef12e1 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -186,7 +186,49 @@ bool hv_ghcb_negotiate_protocol(void)
 	return true;
 }
 
-void hv_ghcb_msr_write(u64 msr, u64 value)
+#define EXIT_REASON_MSR_READ		31
+#define EXIT_REASON_MSR_WRITE		32
+
+static void hv_tdx_read_msr(u64 msr, u64 *val)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_READ,
+		.r12 = msr,
+	};
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+	u64 ret = __tdx_hypercall_ret(&args);
+#else
+	u64 ret = HV_STATUS_INVALID_PARAMETER;
+#endif
+
+	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
+		*val = 0;
+	else
+		*val = args.r11;
+}
+
+static void hv_tdx_write_msr(u64 msr, u64 val)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_WRITE,
+		.r12 = msr,
+		.r13 = val,
+	};
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+	u64 ret = __tdx_hypercall(&args);
+#else
+	u64 ret = HV_STATUS_INVALID_PARAMETER;
+	(void)args;
+#endif
+
+	WARN_ONCE(ret, "Failed to emulate MSR write: %lld\n", ret);
+}
+
+static void hv_ghcb_msr_write(u64 msr, u64 value)
 {
 	union hv_ghcb *hv_ghcb;
 	void **ghcb_base;
@@ -214,9 +256,20 @@ void hv_ghcb_msr_write(u64 msr, u64 value)
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(hv_ghcb_msr_write);
 
-void hv_ghcb_msr_read(u64 msr, u64 *value)
+void hv_ivm_msr_write(u64 msr, u64 value)
+{
+	if (!hyperv_paravisor_present)
+		return;
+
+	if (hv_isolation_type_tdx())
+		hv_tdx_write_msr(msr, value);
+	else if (hv_isolation_type_snp())
+		hv_ghcb_msr_write(msr, value);
+}
+EXPORT_SYMBOL_GPL(hv_ivm_msr_write);
+
+static void hv_ghcb_msr_read(u64 msr, u64 *value)
 {
 	union hv_ghcb *hv_ghcb;
 	void **ghcb_base;
@@ -246,7 +299,18 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 			| ((u64)lower_32_bits(hv_ghcb->ghcb.save.rdx) << 32);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
+
+void hv_ivm_msr_read(u64 msr, u64 *value)
+{
+	if (!hyperv_paravisor_present)
+		return;
+
+	if (hv_isolation_type_tdx())
+		hv_tdx_read_msr(msr, value);
+	else if (hv_isolation_type_snp())
+		hv_ghcb_msr_read(msr, value);
+}
+EXPORT_SYMBOL_GPL(hv_ivm_msr_read);
 
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 2a4c7dcf64038..18f569c44c39d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -280,15 +280,15 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-void hv_ghcb_msr_write(u64 msr, u64 value);
-void hv_ghcb_msr_read(u64 msr, u64 *value);
+void hv_ivm_msr_write(u64 msr, u64 value);
+void hv_ivm_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 void hv_vtom_init(void);
 int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 #else
-static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
-static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
+static inline void hv_ivm_msr_write(u64 msr, u64 value) {}
+static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline void hv_vtom_init(void) {}
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3dff2ef43bc73..a196760afa7a1 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -72,8 +72,8 @@ u64 hv_get_non_nested_register(unsigned int reg)
 {
 	u64 value;
 
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
-		hv_ghcb_msr_read(reg, &value);
+	if (hv_is_synic_reg(reg) && hyperv_paravisor_present)
+		hv_ivm_msr_read(reg, &value);
 	else
 		rdmsrl(reg, value);
 	return value;
@@ -82,8 +82,8 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
 
 void hv_set_non_nested_register(unsigned int reg, u64 value)
 {
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
-		hv_ghcb_msr_write(reg, value);
+	if (hv_is_synic_reg(reg) && hyperv_paravisor_present) {
+		hv_ivm_msr_write(reg, value);
 
 		/* Write proxy bit via wrmsl instruction */
 		if (hv_is_sint_reg(reg))
-- 
2.25.1

