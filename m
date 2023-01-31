Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1766D683512
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjAaSU5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 31 Jan 2023 13:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjAaSU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 13:20:56 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020026.outbound.protection.outlook.com [52.101.61.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586C04672E;
        Tue, 31 Jan 2023 10:20:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0KBXiE8Ycl3hnlu3V77qvwqK4jw16odEpi8sWCXVJjF7mR5nW+3zbk9FdyS7LP3YtcSORX0QOSbW2ousX8/9E6miL1IVilQhmpsxqhL4F/h2uX0tgujVe5eP2ueZP5oPezwfaJND/IGUUd3qKbkxYdk18wZS/300tfuC/igAfYeoCkGiBpHOAUg7Acx7PJlRp72RLZ1Rq/rXfuQK2kZ6AxSBZxSXo9S+AGT/jFzpvcWwNaLxTjrOs6bwFSs15LnKlyShmCZTufyvoB90MRl+dodgBD4URwgSRK7EszB7e+emHhrf6Xp1MPXCIxtMfoG8D3T4EtNpWEYsynnVqvWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BYcrhOyFe47NMBR4hUzi1J8i51RV+i8yRKVwWcMOuY=;
 b=aWXP0/QRSR0sOc8HInxiVb/M+nZVlv74oWA5nxmXkNlLZtq+JqY5kaL1StHmzNXRU2lIx23pZwxaz1MDGH9ydiEsmaKQVYg8dkePMLye9DMmtzM23i34IiOkcUoooPzZfu+qIXMWo0glqcClFv8uzQKNKMyGm5ImXo6bBzAKCIuYGx0shvzdZoGzm6BvmzzbNLECLNIHIJ3WE7XdwmR5WD1a3ebyG3qhEOUSrgXKY3uzTlqsZmzC+UbpMwbs5Mz8mgt57gvp/mtYmbp5wnp5UGHdFG/Owe7NkrknLaTm0Qf8VWjzEAjQYJA4FZHaBtl2uHmHa2MBx1eEmxKq9kmvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CB1PPFCE3ECD1DA.namprd21.prod.outlook.com (2603:10b6:341::3:0:12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.1; Tue, 31 Jan
 2023 18:20:39 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6086.005; Tue, 31 Jan 2023
 18:20:39 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V3 08/16] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
Thread-Topic: [RFC PATCH V3 08/16] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
Thread-Index: AQHZLgvGK5vjJ86Ohk+4bIYWsKUOuq644GAw
Date:   Tue, 31 Jan 2023 18:20:39 +0000
Message-ID: <BYAPR21MB168803F19A65E356758A6046D7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-9-ltykernel@gmail.com>
In-Reply-To: <20230122024607.788454-9-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7a777f1a-b4de-44a0-885d-2145563404bf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-31T18:02:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CB1PPFCE3ECD1DA:EE_
x-ms-office365-filtering-correlation-id: c3413368-941f-4b02-d0fb-08db03b7db18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5h0IkbyuZ4EKWjo8LX7WpQ9Uj43amdcklosHfljCchR6e3PLnl9Kl+rliwwpCJhj1GjqwtJGaNEu3lOUznOSJo8hY+bt23BnBlaUFaXUauYUZAgvk6tNAf76I92pxAdVQcmkaAbTFytvf6mUoMVP0B3C4a0+bEL1lGv1+2Hd9NrAQZvq4wBBFuJYCg/ZwBVEGDH7Ddn+4xsZE+N+p1hSgzstzQEFWtxTPK64uIVYMuRT6aSQ27t44oD3D7o8gbED2gLaIAIu4jgXOJIObUwl13QKmOr0cxudCjESjMbYeyZ9SeerStXjqjRTUJKBpP4v0DDu4LWp83WJSXqB1Ppyu72jHmzAgTi92+a2Ki1S7LEuxKPTSbUyjIB6cJZDLji+wfYNSqzgcH5bu4LKbZzBk05xoXB3GGAiXYykYiXvvcBOcgF90KfKZVhV4whs9n/uDr3+Ry/zylCdoMlyM5zmEETafdO5Y4/4X0qVrQN9Jq0J3NVZe4cEWhQqNUXwH5iT2vKF20nv/OTZLk0gAdF2cG2sBsBGqVK1CQzU5lY6PLfsJDf4JVWJ03086RfsNcwtDPzy8CxGByNwec27AagVyHS6VltyqAoMxdhVqmSLtNbWdVdcsB7MZHFXPcCy5zyEQiCHkSpN4w5cRaWch3lpFEqYGnZZCoushVJw/QO+iR4cyeKlDsz9uz9AoFWO3Gvj4Dib5aJemuAT1umze2gcZXQjTN82BhY2aLlzSAHfLOGiOECZ+umkH5ubMWQhpMyhhLL3WUV2hXp/xFI/07L0cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199018)(66556008)(55016003)(316002)(86362001)(66946007)(7416002)(8676002)(5660300002)(83380400001)(66446008)(2906002)(921005)(76116006)(64756008)(54906003)(9686003)(10290500003)(8936002)(26005)(82950400001)(6506007)(52536014)(4326008)(478600001)(41300700001)(110136005)(38070700005)(71200400001)(82960400001)(7406005)(38100700002)(7696005)(66476007)(186003)(33656002)(8990500004)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?feeQtHAiIKhEOjQi91CyxLZAHVa0J6xCciRqu9033+sdIgbGTM+Lul5UjAcl?=
 =?us-ascii?Q?Mh+YXlOD5OMGSUEo7qXqw8GcE0zlq5jqxFF9o7KYmdvCxzEk2mqRLNmWu24z?=
 =?us-ascii?Q?nBWMs6MZrxPqx+PVY1b97+PWUOLM8VHWAaKMBKfWZ+yHUQWlQQoSoZzxPjGm?=
 =?us-ascii?Q?JTP8zXIn5QSRx+OZejHCUTbyMdNFNG/AHbFj8S4ABv6++3bUkAwXysjPfDy4?=
 =?us-ascii?Q?s2nymU7jkDSwDF/F8xnfcZsKU+0HCU9zEAnidezU1hTuHuQBb9gJFY1lslXB?=
 =?us-ascii?Q?fpBx/l4Va4uGTdYYDo13j6ffrw77mRa0SjanWF4vo6Wjkau4+GJyeXKkX/NM?=
 =?us-ascii?Q?fwzNkHOcFxP09XHKgOtw7gxvoGfg0SjfyG/iUlVTuveScQ70SIpFQqQUQR9r?=
 =?us-ascii?Q?HG7CELvCBTUw4X6KgxlrEmXCzRM5poopURMzntgot6nPd+9IMVF3O5l9yFdH?=
 =?us-ascii?Q?PobeJlwlRqqeFDtS6GVHecXaf27J+9oXxFnzB0j7NsKzDDk/QHYLJAE5AGzV?=
 =?us-ascii?Q?ZlHbg2Q9nXLlA8n0e87OJyKH3Y6i2Mggj3aj6YaCXVDpfAOPuTjIhJjJa0NW?=
 =?us-ascii?Q?xER16HJCL4CtX0HwSG2mcFAavh501p1MuKDPr65bgJeuKZ2/zFPd81AbX24O?=
 =?us-ascii?Q?FGMswXidepLCL1JHC6g5zkUaOuvqLrFCI54A59gP4IGxnShTIFJ3MjFwrqJr?=
 =?us-ascii?Q?7HKwXYfh7esj254ZmdIMC3MyauWmVDCNnIW/2tRXfdov8PDxutWEnv1UtqCQ?=
 =?us-ascii?Q?h+xGHuhIEsO7k8A1umWnBZTQE+BE7Cvi/Zg8qWeBF3SPmj4+21fkSpUmYo4c?=
 =?us-ascii?Q?tLEWrtM4PwergX8tbZugYne/kiOVzwo/2MLygjBa1IUnr7f3wxYbymzMWQpv?=
 =?us-ascii?Q?S/0bhCEeQfDHxiKxdPDFNp1l9blNMZ52jCIqU9ceeNUiDgldchZlij41I0N4?=
 =?us-ascii?Q?8vBImKqJwmKBYdWEHzhUFlxvgTg18OoLTq3sC21CCIE7/mkNomxowD7ahc2S?=
 =?us-ascii?Q?1zSlsv6q7lqZjIjPScogj7RGIQcHTUp81oF6Ujhcho+i+15CdR+2R9PVTIpF?=
 =?us-ascii?Q?S6i46Xc3OUeaVq0Q8Tui3g97w555eYOXZuNDitKXzV7B0VVR3zMdK0JlusJT?=
 =?us-ascii?Q?tXMOwq6xwXUaGGYiJ1vxzWAKhg+WXOnkluYW6BcR8HgLAMc6bvoiN7//Ay/P?=
 =?us-ascii?Q?7S8RT3A8F+rbARKuCSSlj+P5+ZcQGElxz0jP4NGclF6lNe3qQDztXlAkXoE0?=
 =?us-ascii?Q?YobFn3bCgrZnJ6p2L9LdYENXdllhYX3dnt133+bRgoMQKvnKMT4+B9+0dBAB?=
 =?us-ascii?Q?5W4dqyqgkKXLEWk2vlrRSJRKjeLsJ/9zKQzDECeqlyZAsz+V9DFqx3473Fq1?=
 =?us-ascii?Q?pm8e6W7c6fiu7Vvsok6Ace/CEd3cE3Ls9gmBQj4zHdu0aknwDRuI1lINh55d?=
 =?us-ascii?Q?kTme/DL/6SOkuXuin1BF6XcGkewCtD5AtNL9/5sid3TrqN8vV27xDSizS/ej?=
 =?us-ascii?Q?F02unOZ6NJeaLqEPMgS+7lkHikYxH/yIzFI2SO+d3ifs42K2jDAxk8wXS7KQ?=
 =?us-ascii?Q?YGCMGO37kmd8r0Unu2Tc+hTyFUN37/dypeMWxIPT1XpK3Q2NoxcAcEhRIa1U?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3413368-941f-4b02-d0fb-08db03b7db18
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 18:20:39.2636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HffIs0h9WlPe34i9/8vj3c4ZoFuGd+vaTsdfj76k+F04d5w++c9ixVJEIkK3lqTYmkcyExHIP3IOeNLRDLPdMkeSAlkdSpQ8ww0/U+cpwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CB1PPFCE3ECD1DA
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Saturday, January 21, 2023 6:46 PM
> 
> Read processor amd memory info from specific address which are
> populated by Hyper-V. Initialize smp cpu related ops, pvalidate
> system memory and add it into e820 table.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 85 ++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index ace5901ba0fc..b1871a7bb4c9 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -32,6 +32,12 @@
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/numa.h>
> +#include <asm/coco.h>
> +#include <asm/io_apic.h>
> +#include <asm/svm.h>
> +#include <asm/sev.h>
> +#include <asm/realmode.h>
> +#include <asm/e820/api.h>
> 
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -251,6 +257,30 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  }
>  #endif
> 
> +static u32 processor_count;
> +
> +static __init void hv_snp_get_smp_config(unsigned int early)
> +{
> +	if (!early) {
> +		while (num_processors < processor_count) {
> +			early_per_cpu(x86_cpu_to_apicid, num_processors) = num_processors;
> +			early_per_cpu(x86_bios_cpu_apicid, num_processors) = num_processors;
> +			physid_set(num_processors, phys_cpu_present_map);
> +			set_cpu_possible(num_processors, true);
> +			set_cpu_present(num_processors, true);
> +			num_processors++;
> +		}
> +	}
> +}
> +
> +struct memory_map_entry {
> +	u64 starting_gpn;
> +	u64 numpages;
> +	u16 type;
> +	u16 flags;
> +	u32 reserved;
> +};

Am I correct that this structure is defined by Hyper-V?  If so, it seems
like it should go in hyperv-tlfs.h, along with the definition of
EN_SEV_SNP_PROCESSOR_INFO_ADDR (which is also defined by
Hyper-V?)

> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax;
> @@ -258,6 +288,11 @@ static void __init ms_hyperv_init_platform(void)
>  	int hv_host_info_ebx;
>  	int hv_host_info_ecx;
>  	int hv_host_info_edx;
> +	struct memory_map_entry *entry;
> +	struct e820_entry *e820_entry;
> +	u64 e820_end;
> +	u64 ram_end;
> +	u64 page;
> 
>  #ifdef CONFIG_PARAVIRT
>  	pv_info.name = "Hyper-V";
> @@ -466,6 +501,56 @@ static void __init ms_hyperv_init_platform(void)
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
> 
> +	if (isolation_type_en_snp()) {

The above doesn't compile.  The function name is hv_isolation_type_en_snp().

> +		/*
> +		 * Hyper-V enlightened snp guest boots kernel
> +		 * directly without bootloader and so roms,
> +		 * bios regions and reserve resources are not
> +		 * available. Set these callback to NULL.
> +		 */
> +		x86_platform.legacy.reserve_bios_regions = x86_init_noop;
> +		x86_init.resources.probe_roms = x86_init_noop;
> +		x86_init.resources.reserve_resources = x86_init_noop;
> +		x86_init.mpparse.find_smp_config = x86_init_noop;
> +		x86_init.mpparse.get_smp_config = hv_snp_get_smp_config;
> +
> +		/*
> +		 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
> +		 * and legacy APIC page read/write. Switch to hv apic here.
> +		 */
> +		disable_ioapic_support();
> +
> +		/* Read processor number and memory layout. */
> +		processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
> +		entry = (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR)
> +				+ sizeof(struct memory_map_entry));
> +
> +		/*
> +		 * E820 table in the memory just describes memory for
> +		 * kernel, ACPI table, cmdline, boot params and ramdisk.
> +		 * Hyper-V popoulates the rest memory layout in the EN_SEV_
> +		 * SNP_PROCESSOR_INFO_ADDR.
> +		 */
> +		for (; entry->numpages != 0; entry++) {
> +			e820_entry = &e820_table->entries[
> +					e820_table->nr_entries - 1];
> +			e820_end = e820_entry->addr + e820_entry->size;
> +			ram_end = (entry->starting_gpn +
> +				   entry->numpages) * PAGE_SIZE;
> +
> +			if (e820_end < entry->starting_gpn * PAGE_SIZE)
> +				e820_end = entry->starting_gpn * PAGE_SIZE;
> +
> +			if (e820_end < ram_end) {
> +				pr_info("Hyper-V: add e820 entry [mem %#018Lx-%#018Lx]\n", e820_end, ram_end - 1);
> +				e820__range_add(e820_end, ram_end - e820_end,
> +						E820_TYPE_RAM);
> +				for (page = e820_end; page < ram_end; page += PAGE_SIZE)
> +					pvalidate((unsigned long)__va(page), RMP_PG_SIZE_4K, true);
> +			}
> +		}
> +	}
> +

For SNP vTOM mode, most of the supporting code is placed in
arch/x86/hyperv/ivm.c, which is built only if CONFIG_HYPERV
is defined.  arch/x86/kernel/cpu/mshyperv.c is built for *any*
flavor of guest (i.e., CONFIG_HYPERVISOR_GUEST).  I'm thinking
all this code should go as a supporting function in ivm.c, to
avoid overloading mshyperv.c.  Take a look at how hv_vtom_init()
is handled in my patch set.

Breaking it out as a separate supporting function might also
help reduce the deep indentation problem a bit. :-)

>  	hardlockup_detector_disable();
>  }
> 
> --
> 2.25.1

