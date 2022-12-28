Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6D658518
	for <lists+linux-arch@lfdr.de>; Wed, 28 Dec 2022 18:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiL1RJF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Dec 2022 12:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiL1RIm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Dec 2022 12:08:42 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11022023.outbound.protection.outlook.com [40.93.200.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1027ADDE;
        Wed, 28 Dec 2022 09:07:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgwrHrSgU8ttWlUqAcfZy4wdx+d08Lenej+Dzon0E29n5raIKGbH7OJP35g1YLMuGOmfqrwysFievJgYQ14SztNLo/AX/ec7ZtJcAvAOzbF8zjrvT5VdfAUbNsS1IGUzVvyhMIEd3mVs9U06+tHikz6GoPudSN3OocVelfj1TdxbhJ0IRpbPPswqywT0T1afDOxa+xdp/wOc4JcxeLkLSE5qntJWGBLZgRRNWgUd3uOGgdtj9y58cAPbYkkEyEo9OcfT9WdEedH2gqjxTcRuzg4kzhr4oaqtARHSeKaUmTnm0oOhymXznw91kmRWPLo37JK8a083vJ1fRAnxU3QLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azhso2aaHy5shM/YK5f6s/YgFUa0cE7Xb6NU8XWfb3Q=;
 b=U3/JHkk233QaPYXT+ZKNjYKzw6SatnlAHvIyK2ZO+m5oh6vioZvge9LNL3KaO3GuwJ3O4WLSHKQv/NqMNSN+hgTNaqLtqK7ZjYox2bVkzJMHlZaHnPVlBqesIXUWOvLfeTrVLJtwiHTFfFiibLBzybLyHoOaosjQyoWBI4jay6RygNSsioHZEeFq+LlRl7n8qf3z/MxqknW8jRG9KtkQFLn2RCuwRGKfQd/rmnCvWbsiRkHofI53ckvy1q0jy6qmz9MRd72pBVbF68rkoYWm+D1BH4uIudi+SkxwvSlMiO/bqFtWBOVDYpcW2Hz+AmLgh3XQ15VjqlZHV0NHeWrpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azhso2aaHy5shM/YK5f6s/YgFUa0cE7Xb6NU8XWfb3Q=;
 b=Hq4QRDnx5od1JemNps62M1KqJE2sBfwvzIR9VW4HTvO72ToZsNJz2plCbVgoGtXpsap3ipmUlpWxAc0oqoImOvL2vgxpZBf4+vz5SNelCy+NwFxWaQeRadgjszavr8Qd3B8w1wPansVe3v7MucK0q6WHTnqpBOEIviNpjYZpkpg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3048.namprd21.prod.outlook.com (2603:10b6:208:370::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.17; Wed, 28 Dec
 2022 17:07:46 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%7]) with mapi id 15.20.5986.007; Wed, 28 Dec 2022
 17:07:46 +0000
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
Subject: RE: [RFC PATCH V2 12/18] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
Thread-Topic: [RFC PATCH V2 12/18] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
Thread-Index: AQHY+8niZ1Wgu656XEGB8vTldI/t8K6DuUnw
Date:   Wed, 28 Dec 2022 17:07:45 +0000
Message-ID: <BYAPR21MB1688F90B70C95A08DD019FB5D7F29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-13-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-13-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=af6a1684-61d8-4b18-b0a1-6b6ae15c49a6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-28T16:21:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3048:EE_
x-ms-office365-filtering-correlation-id: 857c18dc-7210-4f2a-0f46-08dae8f60a61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkJgfEJSYV07O8SP6eMEDJLpaUnSIfVM/OM9QBaHsSjLOhpttf8eUFpQkYBNVWhtHparDEcDT5hpsRJ0ACArLlHFiqdRcrA+UwvkMDZu/3Sjhnmgcqsn7Ir+ytY+kS74ZXtvyv2uJTgq78KTyro4C+vM4yoAXVYcfp8w/bfAOjovShK5yITKpKQIe59jc3iOALVUCj2Xlq5IatDHzg/gVy8LFnXiQ0JW8J7E1SV6HOWPkiCyRv0I8LKqnIjttI1pxkJGDq45aDpLk2AsCrl3MC39t4sa4tOmCFgPfpb0Hwa4JQQSeKjpcVri5OSOOFgwmx6JVQt6xzUqPGLY9r0Jbls8mnNEEJb8mG2Iq4V33VOxo42luHsY405HuuF1U/QvzhZ9td0dblkeKU1zi3/CuKBl1JgKHkBLoE7CzcxMGUw9cHAryf/X1+fhXGTOA34wLcv4lfWEBxk3D/El2P8zZsd/amcZJ/rr52BMrPayHXLrFoXn5osyTdKdp10GPyzk+a7jmBMql5n1noMe1NYI/psq5wePy5J7UT2nhTI/7KqNhnPeZ+YS1DkKhszZWOUf2jaOiWU9/UUAIIPO2X3yGNq1LPoWtmX35gXtDeGGLGWistEt7LU9Dettz7cKZmkMFUNiy23DxOvIEA8CuCOAqcx6fnOnJ3JBzPZW6LJRK5QK7T0VGOjanipHZdZJ80VFW1cEdBsvmeiuAWCbcHEPxPv1y0dNlVYrazLjoxIYrxWJ6466Fj0NEoBbUqQMWURFtnEjO047gZj+flia9GQDQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(921005)(6506007)(9686003)(478600001)(71200400001)(110136005)(55016003)(33656002)(26005)(186003)(54906003)(316002)(86362001)(38070700005)(41300700001)(10290500003)(8936002)(2906002)(7696005)(52536014)(5660300002)(83380400001)(122000001)(7406005)(82950400001)(66476007)(4326008)(64756008)(66446008)(76116006)(66946007)(8676002)(82960400001)(66556008)(7416002)(38100700002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E043tI2qIzzjuw+wfYNU7i6NjLEiT1br3wuhKoB3mnJ0oO3TLFIRcnXz8ZHU?=
 =?us-ascii?Q?NsEMnA/eGpVKwvyEa30L5azGDVE7pnMwl1P/6rX4Aib6zX70K//GBr/n6eZZ?=
 =?us-ascii?Q?c7udOFfn7IliKz3JPYUBalji4Ng1fBXHIekjB1gMcyLBnhjKmPrjm8kK3zGG?=
 =?us-ascii?Q?qjHgM94O8sg+kO11RvNGymSfiWOvz9Sk9goP7FHqbQ+uB5iHKo3rlGeEXaZM?=
 =?us-ascii?Q?FI6dsCbQYOqQx9Zf/r4Vpmo/X3ksiWrhgcPCmKQ3V2E41uGUKq3eW8is3CIK?=
 =?us-ascii?Q?4u0e/1jQJmyI2lJ99Bjd2nKaYPRIBH8SX+dPz6gwCEXQ2CTB9/Z9be0A3j1Z?=
 =?us-ascii?Q?RkrcyN7dj6owlhnfuXKqZPulU8ROJR2KSh2XvsD3Qf3BT9MRLwm/lL34o4YN?=
 =?us-ascii?Q?uf9OFCvfh4UJgAJQPxPTwS6wjbAfMXniDwk9Ush1kBeBLE2dw+BF3F+hhj+M?=
 =?us-ascii?Q?A7aU0It9IENsS468i1p7Uu9lF09HNeBJUyYOFIAHEE1r4wrLxHiT+J7IXoqd?=
 =?us-ascii?Q?71Kxe3FvoXsK2jgNYeOh/vnu4doVhawoMgr06ooj0+B7sh7IhcsMwqxE2sud?=
 =?us-ascii?Q?V/7SVSpvDZsUqKjSxFyayemsHpmwNeEMYtegeweYCFRJwXj4K+OuQOW5F7hh?=
 =?us-ascii?Q?AKHVODhwhFUN/C8tDWpirqG1TbTRyU3+gTf+ZHZvk0/XwykxRR5+dc1j+iab?=
 =?us-ascii?Q?vuqIB6aCX6/X7OrdyWLOB0dhdYutVUi4ocmcWQ86sLakrgS3hypSktuaoaP2?=
 =?us-ascii?Q?7K3AS4ePQr/ZH74yjY9TTKn+rNvXy9lTb7ex9QK63gZPh0r27LwCXw3L3TQ9?=
 =?us-ascii?Q?sl7SrZqUSBkkGAJ8gfhC6lyGpHUXX1xO5ikJSYlS9TGLv/70EJn0rJzDWvdF?=
 =?us-ascii?Q?c7BqlOvvOeZ5rkCsoCBlMJ1uBa/ghoFKl9EKUxlbT1RcWq7o5KBkbFPQRehT?=
 =?us-ascii?Q?19eR/Xpbxa3/jxKtZsRPgkyGlpr+Wk3+l9uP9M+5OmuJ1+JbFrL5oZE+KVBZ?=
 =?us-ascii?Q?Whr/SWuBgkyixNMzNac9l1ike0G93s/+wSmAhNC6zGqciO6rZn8IiCDVXVbz?=
 =?us-ascii?Q?/xTeWuWmZjcuTNE1U3ODXC3cQDvgFarnyDTS3tzES3Sy8U3WMXACOAFZhXTJ?=
 =?us-ascii?Q?JEbn7yzZWlqDsyyuRIPWqQDrP7vcchAAzX2hmKhlW/5ZGAAzekTJghaliVwH?=
 =?us-ascii?Q?9BwmpRrHxIDuKycFRP3rlJFruOZB3gzv7Yt3IqY5D6rl4rDjX0ywtvwzDyCm?=
 =?us-ascii?Q?3PrgEal30AgImgmtiNDmBhwxekM53Pkg6rsf7p/V74PthpR9SiOa5eo8qGF5?=
 =?us-ascii?Q?+Z60M8XLYaTSvtKTadJUlAQxwlKn42KcgT5ddivDMDqkQTMWQ0aiPPMpWd2t?=
 =?us-ascii?Q?PE6DDi6h/bjZNfwY32fhwFj9OOMniZ2ORgVwkqDo9wtv90dwc2mwgrGp5cZ0?=
 =?us-ascii?Q?IgTCyNAE1QuxQxEEJwRYif7h8wK8TEvaiRQ8dAcHQTiMKGZqftk5/yKpa05X?=
 =?us-ascii?Q?1YL2u6utF07vk4YO+tIoJhHKQKl6ZmnlX/TfZb4wU+GsFC0z56e3Tk9sNQLG?=
 =?us-ascii?Q?bcRCTzKXqsVwSoS9liyI6e0eLeeSSb1o43Xu64KZf7hYbsKGDKwwh4+QrpY+?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857c18dc-7210-4f2a-0f46-08dae8f60a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 17:07:45.9765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIgOZ20dtPhijK6Bg11jpU7RllGVVF+Xn4FPvGjEx5Aw7J4rQVTO+XXydactMuzLqGWFCdMmEEAOar17pC3ma7CYTZYPU92o6iLSGcXaorw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3048
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, November 18, 2022 7:46=
 PM
>=20
> Read processor amd memory info from specific address which are
> populated by Hyper-V. Initialize smp cpu related ops, pvalidate
> system memory and add it into e820 table.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 75 ++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 2ea4f21c6172..f0c97210c64a 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -34,6 +34,12 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/numa.h>
>  #include <asm/coco.h>
> +#include <asm/io_apic.h>
> +#include <asm/svm.h>
> +#include <asm/sev.h>
> +#include <asm/sev-snp.h>
> +#include <asm/realmode.h>
> +#include <asm/e820/api.h>
>=20
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -253,6 +259,33 @@ static void __init hv_smp_prepare_cpus(unsigned int =
max_cpus)
>  }
>  #endif
>=20
> +static __init int hv_snp_set_rtc_noop(const struct timespec64 *now) { re=
turn -EINVAL; }
> +static __init void hv_snp_get_rtc_noop(struct timespec64 *now) { }

These two functions duplicate set_rtc_noop() and get_rtc_noop() in x86_init=
.c.  Couldn't
the "static" be removed from these two, and just use them, like with x86_in=
it_noop()?
You'd also need to add extern statements in x86_init.h.   But making them l=
ike the
other *_init_noop() functions seems better than duplicating them.

Also, it looks like these two functions might be called well after Linux is=
 booted, so
having them marked as "__init" seems problematic.  The same is true for set=
_rtc_noop()
and get_rtc_noop().

I'd suggesting breaking out this RTC handling into a separate patch in the =
series.

> +
> +static u32 processor_count;
> +
> +static __init void hv_snp_get_smp_config(unsigned int early)
> +{
> +	if (!early) {
> +		while (num_processors < processor_count) {
> +			early_per_cpu(x86_cpu_to_apicid, num_processors) =3D num_processors;
> +			early_per_cpu(x86_bios_cpu_apicid, num_processors) =3D num_processors=
;
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
> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax;
> @@ -260,6 +293,11 @@ static void __init ms_hyperv_init_platform(void)
>  	int hv_host_info_ebx;
>  	int hv_host_info_ecx;
>  	int hv_host_info_edx;
> +	struct memory_map_entry *entry;
> +	struct e820_entry *e820_entry;
> +	u64 e820_end;
> +	u64 ram_end;
> +	u64 page;
>=20
>  #ifdef CONFIG_PARAVIRT
>  	pv_info.name =3D "Hyper-V";
> @@ -477,6 +515,43 @@ static void __init ms_hyperv_init_platform(void)
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
>=20
> +	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +		x86_platform.legacy.reserve_bios_regions =3D 0;
> +		x86_platform.set_wallclock =3D hv_snp_set_rtc_noop;
> +		x86_platform.get_wallclock =3D hv_snp_get_rtc_noop;

Should x86_platform.legacy.rtc be set to 0 as well so that add_rtc_cmos()
does not try to register the RTC as a platform device?

> +		x86_init.resources.probe_roms =3D x86_init_noop;
> +		x86_init.resources.reserve_resources =3D x86_init_noop;

reserve_bios_regions, probe_roms, and reserve_resources are all being
set to 0 or NULL.  Seems like there should be a comment or text in the
commit message saying why.  I can work with you offline to write a concise
message.

> +		x86_init.mpparse.find_smp_config =3D x86_init_noop;
> +		x86_init.mpparse.get_smp_config =3D hv_snp_get_smp_config;
> +
> +		/*
> +		 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
> +		 * and legacy APIC page read/write. Switch to hv apic here.
> +		 */
> +		disable_ioapic_support();
> +		hv_apic_init();
> +
> +		processor_count =3D *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);

EN_SEV_SNP_PROCESSOR_INFO_ADDR is not defined until Patch 13 of this series=
.

> +
> +		entry =3D (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_A=
DDR)
> +				+ sizeof(struct memory_map_entry));

This calculation isn't what I expected.  A brief summary of the layout of t=
he memory
at this fixed address would be helpful.  Evidently, the first 32 bits is th=
e processor count,
and then there are multiple memory map entries.  But why skip over an entir=
e memory
map entry to account for the 32-bit processor_count?

Maybe the definition of struct memory_map_entry and EN_SEV_SNP_PROCESSOR_IN=
FO_ADDR
should go in arch/x86/include/asm/mshyperv.h, along with some explanatory c=
omments.

> +
> +		for (; entry->numpages !=3D 0; entry++) {
> +			e820_entry =3D &e820_table->entries[e820_table->nr_entries - 1];
> +			e820_end =3D e820_entry->addr + e820_entry->size;
> +			ram_end =3D (entry->starting_gpn + entry->numpages) * PAGE_SIZE;
> +
> +			if (e820_end < entry->starting_gpn * PAGE_SIZE)
> +				e820_end =3D entry->starting_gpn * PAGE_SIZE;
> +			if (e820_end < ram_end) {

I'm curious about any gaps or overlaps with the existing e820 map entries. =
 What
is expected?  Or is this code just trying to be defensive?

> +				pr_info("Hyper-V: add [mem %#018Lx-%#018Lx]\n", e820_end, ram_end - =
1);

Seems like the above message should include "e820" to make clear this is an=
 update
to the e820 map.

> +				e820__range_add(e820_end, ram_end - e820_end, E820_TYPE_RAM);
> +				for (page =3D e820_end; page < ram_end; page +=3D PAGE_SIZE)
> +					pvalidate((unsigned long)__va(page), RMP_PG_SIZE_4K, true);
> +			}
> +		}

Does e820__update_table() need to be called once any range adds are complet=
e?
I don't know, so I'm just asking.

> +	}
> +
>  	hardlockup_detector_disable();
>  }
>=20
> --
> 2.25.1

