Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38B2747404
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGDOXc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDOXb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 10:23:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2112.outbound.protection.outlook.com [40.107.94.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDBBE47;
        Tue,  4 Jul 2023 07:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7BkQrmGSRLvt8JgRMq+W988symwSWxA8/VH5QwQGPzGmFxeL2iRKB/LF+0268YS6ywJ2YOVw2Pr/T0nGjg5uh15XG+P9N5lGcHbS76UidKI5RdVlAyKBm7BWYTJ/qyBE0HeITrFgJPejf+DZWeuN8nho/eHhR2ukYMZyTQ1MU2NkM1Y3kjzPDyVgMXf3v/xK911a19O0HQKEHmUT1ElCDWWCMhYbXNWqPHmeDcnaxDn/EKXAzMezAhQ1Ugl/wafHXeYADEL+drD2wltK8VBJjMyOb5+Xzg6RMsHaz2dO+maOMnW6niTEogqsQyUptjKZvt+hmzSXuT1hYKHMQVIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE/uhqFNdrDNDGTxm2St/j/Xe98aBN14Ntv1747pz+0=;
 b=L04Fnt9vGO0eOsMiVmhonxuLtYG4eSDcWQzwTur3JXUWBCqiMM+4A3WwU8J+YPBMTwTYe0vCKnU4Ld2FdElVZUO6Z3YBizjjRwoJIHH+hfEWc9V8dscKBV0dpa9ww+4TlZ8rvgew6OO+rqNBwEzNelqruZoUNNcYt8CiyQHqQnKsCrAj6W496ekBhi2wjCOtIK+k3ODrMElfKXywzxtluO3JuKdinyS0btiJalXxz5KVNNiCIoykOuLOa73cLXCqkOOIaagDC5g1xDlooeX+A2rl6dqb4HLOIErw3/hF/X4SR47ymCmOFjoE3hBYD5hboze6+RCESK9y8V4rFq/cTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tE/uhqFNdrDNDGTxm2St/j/Xe98aBN14Ntv1747pz+0=;
 b=h6mumCdX8gf9sK31XpzYxBIXNE3iP/mVblBjAGXIxZUGdms3vzmXdVdURPeeWSbjjMLMiJY4CTjTybhkDk0YV2aqJGMdXwJNR1VapjkggMkvPKZ/iVE7vqgJIoOwUXrkIVHHQ6CYw8DKWJE0q0hzwBlivXjUTzH+o/wc6FtzgNo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3733.namprd21.prod.outlook.com (2603:10b6:930:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.8; Tue, 4 Jul
 2023 14:23:26 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64%5]) with mapi id 15.20.6588.006; Tue, 4 Jul 2023
 14:23:26 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
Thread-Topic: [PATCH V2 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
Thread-Index: AQHZqKa7kJ6dI9YnWEutLblUKP0odq+ps/TA
Date:   Tue, 4 Jul 2023 14:23:26 +0000
Message-ID: <BYAPR21MB16886A505024D6D0209AA68DD72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-8-ltykernel@gmail.com>
In-Reply-To: <20230627032248.2170007-8-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1b7fcf60-752a-4bb0-b919-a01b449d91d3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T14:20:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3733:EE_
x-ms-office365-filtering-correlation-id: f43e8b09-8524-4cc9-ae6f-08db7c9a3b27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LfB1HXBXN7CvUjQD0kt76aUwFvqnQ0G9ivD+d955rqDLjB+2vjgH/b3o/Uvl2BBpvcm0JruRJX5igKsu687hO01vX1Mb1202hh68yJd9eVv/KcBJwyLdPp5iq50O/kLsWK/QUF7tf77fb1ELF2Q2mhGAKBsou3ujzr14NCXe0WyFml9GlZ9IWIcf6tRgyDJAwfLi62Q8Vqpnqj00RqNuGWt469DASOKeEwE4U2gx2coHXwmxt5qu5uhHxUDenwx/7W+4JesO9ZOUmmsz4zKwHOSpceLJCwfDjGpF80HvZEzg1RwHJjWKrN0bWryAHgZcMJAvsNbalp0rXNE9DFtmzjuhmLoF7Tc7mhZ9Kdq23SvYuAabaPXDPpid9j7lZ+e/H+uT1IKVdX7Sq51mCF/8b1xV6zuxDTfsycM+VDWrxouNb0uu5u2+Vza/DMdM+ivnuS7mDYlH2eahvDycH0yo2Qu1lqKkMpsF/QsHHw4pfezaosb/0GoIRZHa9mwUFOQv8nwBhNvbFXC88h4HIfxwVRzlEgdqaAIl5xLZFPQn00pk+s+P96BRblPsfKlflnGMsQt+rQcmrMw3oWrzA4Qr0lu/SZFicUtZ9Q7LsXbX7fXAXIp/qOtd1NCh/RwNWhVPL0Cvt/uu+4135EZsTab4F7XyBtKHWBSpHYwSHUvBe2I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(8676002)(8936002)(54906003)(110136005)(478600001)(26005)(9686003)(41300700001)(52536014)(33656002)(71200400001)(966005)(7416002)(2906002)(5660300002)(86362001)(7696005)(64756008)(316002)(66476007)(122000001)(55016003)(66556008)(76116006)(38100700002)(4326008)(66446008)(66946007)(38070700005)(921005)(8990500004)(82960400001)(82950400001)(6506007)(10290500003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GDXM+Vra2awjOSBFxd0LmerCX3R1HBewYh3J3+JQnwiYdn2rLAVgsMzLU7Eh?=
 =?us-ascii?Q?l2mkQYlzDmHX76LPslfAQR+Aux5O8dUDP84EAdBPl1GxzlzRTA9goNX/m+xf?=
 =?us-ascii?Q?DembGh9yGO7XDOTPkGkIiTdEGbEppYFvOyudHxaW7chtoqVCH7XobQTjKWM7?=
 =?us-ascii?Q?PARdvA4eRocInyEDOTGLKEUeAfLnnuAirSBd/vEolbz/sE8yKTr3Bs8zlMcx?=
 =?us-ascii?Q?Jb8F+kigPT7bQ1dXMb4vn3kFB6mGYyc0tQen8uSP8Muyz6LCctE3MJsDK3y3?=
 =?us-ascii?Q?GCcxoQWNVQfjies65t/NyJKaBLxY/5yOFTwsQrjlcW252GKZJHzPHOM1RU7S?=
 =?us-ascii?Q?xetIY7WJ06JM5sMT+K0wssMPXGMvfxp0u+Awu85LPjbmKCLGV7eOobVtKKaF?=
 =?us-ascii?Q?+V76RAYQfCiqDEHPKQlCWAsmLj/gcACEiQAcqbTi19zeaWR2CQaTalft4YLd?=
 =?us-ascii?Q?SRxX043ZreIwhWE8PIgJDQiU1rABlu8kKVg5gRxFFjCuxH67WXF7Wa/vNT3M?=
 =?us-ascii?Q?P9hbCxeyXVZ3PFw0XVTbVR7EgOTWlOIc+zVGSykMMSNb6wl+yC4d1xS/R8jY?=
 =?us-ascii?Q?XDcVkLhq2KASk/Yi9y6DWi6QejOXBankQpJyEgVLo/FIxMJiOyij6cL9/qBx?=
 =?us-ascii?Q?LNUhhAxfWWSg4GzpWtuJ/oFAYN3fz9012t5oMXwtmjGWiN9kkdiSaKodikte?=
 =?us-ascii?Q?8j8Bb1OT1SDxnZiDC3+10Ov46AawJsAdwWMYFbA3vhyGZF4NjdHzlprpmQnW?=
 =?us-ascii?Q?eXLeFuLhR3xH6M0R4p+peBVTnDhMugEaye5bBwap1TU+dBU5bwRK+9iomY+X?=
 =?us-ascii?Q?mTmMMYWMJmN3NP4VKKMUcC70pIst0cB5qOFKYi/NUsFCGmxZEFPFTpRpbeaG?=
 =?us-ascii?Q?5vOkIq88e8ZAMe5AKTdMFLuTox/veqZ0X9p1V5UTaoyw8fjOnJpN+/qsHDiH?=
 =?us-ascii?Q?8CgDusRTGXyvXmEQrYQLsAihvWqqkGytXHig4k5D13DrP2PHb4bq0DbcqMrQ?=
 =?us-ascii?Q?+hn4A8zDlfH+3DRT9fPBfl2MSJHvXT/YRFleR5YkRjRvwDns4fAjUf23px5L?=
 =?us-ascii?Q?ZXScgTsWFOlt0YUUcB/B/LtxAFAenYR7KarsRQBB8BZaIU0xqxtZK2+QLVHf?=
 =?us-ascii?Q?iwzZaQ0h393JEyyfOx6wk03IRSuUv1K7np39q0aCBzfdsZ8nzFQ9YY1aFaZW?=
 =?us-ascii?Q?vqqFe+MMWAihobSWpvBZq/hJn7JqceUyX3KtR7EftbXh9za8xe6Kli+4s/m+?=
 =?us-ascii?Q?Ksch1IYz/86wDOADm2Qx13u7jvrWdZgVl42Patd+Q7rYmomsJgcUxmzsq80z?=
 =?us-ascii?Q?no3LtP2OVyVtmJIwiDeLabIfuRXwsiZBOpb7FZuN3ayfn8zKhdI3mGSTZ7+9?=
 =?us-ascii?Q?vwy6O2yN/xudfPF/24FIjq9RyGPykz6yXNWn+GQ0VABPFwwH7yAuHJI+vsC3?=
 =?us-ascii?Q?NRaF/0B+Z6DG/xVlDwlwEMGjW6Hx/ffwdJBkEq8y3VAj4i+/VLenWeClVN37?=
 =?us-ascii?Q?gwL6juRvDGr+8/o+KzEXefeYT9xsX2um7wktbTC/umGa3y/9fnR59T8BUC/y?=
 =?us-ascii?Q?FaYi73CACLf5eBQ2/TlSzcSovMyHDta3h7MsgAcFYOLxYTmXdBo2LN4CEBhr?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43e8b09-8524-4cc9-ae6f-08db7c9a3b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 14:23:26.1874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRwZ6+P/V/rO4Sj6knarAu6fyOH9B6MBnh17CPTNSRXKuISLiHj9FK/dBZ9glTPiCian34vH/FcbSRk4bbGLhmG/kSwuEcA/ffoDUo0Axes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, June 26, 2023 8:23 PM
>=20
> Hyper-V enlightened guest doesn't have boot loader support.
> Boot Linux kernel directly from hypervisor with data (kernel
> image, initrd and parameter page) and memory for boot up that
> is initialized via AMD SEV PSP protocol (Please reference
> Section 4.5 Launching a Guest of [1]).
>=20
> Kernel needs to read processor and memory info from EN_SEV_
> SNP_PROCESSOR/MEM_INFO_ADDR address which are populated by
> Hyper-V. The these data is prepared by hypervisor via SNP_

s/The these data/The data/

> LAUNCH_UPDATE with page type SNP_PAGE_TYPE_UNMEASURED and
> Initialize smp cpu related ops, validate system memory and
> add them into e820 table.
>=20
> [1]: https://www.amd.com/system/files/TechDocs/56860.pdf
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 93 +++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h | 17 ++++++
>  arch/x86/kernel/cpu/mshyperv.c  |  3 ++
>  3 files changed, 113 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 5d3ee3124e00..b1639ec07155 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -17,6 +17,11 @@
>  #include <asm/mem_encrypt.h>
>  #include <asm/mshyperv.h>
>  #include <asm/hypervisor.h>
> +#include <asm/coco.h>
> +#include <asm/io_apic.h>
> +#include <asm/sev.h>
> +#include <asm/realmode.h>
> +#include <asm/e820/api.h>
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>=20
> @@ -57,6 +62,8 @@ union hv_ghcb {
>=20
>  static u16 hv_ghcb_version __ro_after_init;
>=20
> +static u32 processor_count;
> +
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size)
>  {
>  	union hv_ghcb *hv_ghcb;
> @@ -356,6 +363,92 @@ static bool hv_is_private_mmio(u64 addr)
>  	return false;
>  }
>=20
> +static __init void hv_snp_get_smp_config(unsigned int early)
> +{
> +	/*
> +	 * The "early" parameter can be true only if old-style AMD
> +	 * Opteron NUMA detection is enabled, which should never be
> +	 * the case for an SEV-SNP guest.  See CONFIG_AMD_NUMA.
> +	 * For safety, just do nothing if "early" is true.
> +	 */
> +	if (early)
> +		return;
> +
> +	/*
> +	 * There is no firmware and ACPI MADT table support in
> +	 * in the Hyper-V SEV-SNP enlightened guest. Set smp
> +	 * related config variable here.
> +	 */
> +	while (num_processors < processor_count) {
> +		early_per_cpu(x86_cpu_to_apicid, num_processors) =3D num_processors;
> +		early_per_cpu(x86_bios_cpu_apicid, num_processors) =3D num_processors;
> +		physid_set(num_processors, phys_cpu_present_map);
> +		set_cpu_possible(num_processors, true);
> +		set_cpu_present(num_processors, true);
> +		num_processors++;
> +	}
> +}
> +
> +__init void hv_sev_init_mem_and_cpu(void)
> +{
> +	struct memory_map_entry *entry;
> +	struct e820_entry *e820_entry;
> +	u64 e820_end;
> +	u64 ram_end;
> +	u64 page;
> +
> +	/*
> +	 * Hyper-V enlightened snp guest boots kernel
> +	 * directly without bootloader. So roms, bios
> +	 * regions and reserve resources are not available.
> +	 * Set these callback to NULL.
> +	 */
> +	x86_platform.legacy.rtc			=3D 0;
> +	x86_platform.legacy.reserve_bios_regions =3D 0;
> +	x86_platform.set_wallclock		=3D set_rtc_noop;
> +	x86_platform.get_wallclock		=3D get_rtc_noop;
> +	x86_init.resources.probe_roms		=3D x86_init_noop;
> +	x86_init.resources.reserve_resources	=3D x86_init_noop;
> +	x86_init.mpparse.find_smp_config	=3D x86_init_noop;
> +	x86_init.mpparse.get_smp_config		=3D hv_snp_get_smp_config;
> +
> +	/*
> +	 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
> +	 * and legacy APIC page read/write. Switch to hv apic here.
> +	 */
> +	disable_ioapic_support();
> +
> +	/* Get processor and mem info. */
> +	processor_count =3D *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
> +	entry =3D (struct memory_map_entry *)__va(EN_SEV_SNP_MEM_INFO_ADDR);
> +
> +	/*
> +	 * There is no bootloader/EFI firmware in the SEV SNP guest.
> +	 * E820 table in the memory just describes memory for kernel,
> +	 * ACPI table, cmdline, boot params and ramdisk. The dynamic
> +	 * data(e.g, vcpu number and the rest memory layout) needs to
> +	 * be read from EN_SEV_SNP_PROCESSOR_INFO_ADDR.
> +	 */
> +	for (; entry->numpages !=3D 0; entry++) {
> +		e820_entry =3D &e820_table->entries[
> +				e820_table->nr_entries - 1];
> +		e820_end =3D e820_entry->addr + e820_entry->size;
> +		ram_end =3D (entry->starting_gpn +
> +			   entry->numpages) * PAGE_SIZE;
> +
> +		if (e820_end < entry->starting_gpn * PAGE_SIZE)
> +			e820_end =3D entry->starting_gpn * PAGE_SIZE;
> +
> +		if (e820_end < ram_end) {
> +			pr_info("Hyper-V: add e820 entry [mem %#018Lx-%#018Lx]\n", e820_end, =
ram_end - 1);
> +			e820__range_add(e820_end, ram_end - e820_end,
> +					E820_TYPE_RAM);
> +			for (page =3D e820_end; page < ram_end; page +=3D PAGE_SIZE)
> +				pvalidate((unsigned long)__va(page), RMP_PG_SIZE_4K, true);
> +		}
> +	}
> +}
> +
>  void __init hv_vtom_init(void)
>  {
>  	/*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index d859d7c5f5e8..7a9a6cdc2ae9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -50,6 +50,21 @@ extern bool hv_isolation_type_en_snp(void);
>=20
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
> +/*
> + * Hyper-V puts processor and memory layout info
> + * to this address in SEV-SNP enlightened guest.
> + */
> +#define EN_SEV_SNP_PROCESSOR_INFO_ADDR  0x802000
> +#define EN_SEV_SNP_MEM_INFO_ADDR	0x802018
> +
> +struct memory_map_entry {
> +	u64 starting_gpn;
> +	u64 numpages;
> +	u16 type;
> +	u16 flags;
> +	u32 reserved;
> +};
> +
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> @@ -255,12 +270,14 @@ void hv_ghcb_msr_read(u64 msr, u64 *value);
>  bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
>  void hv_vtom_init(void);
> +void hv_sev_init_mem_and_cpu(void);
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
>  static inline void hv_vtom_init(void) {}
> +static inline void hv_sev_init_mem_and_cpu(void) {}
>  #endif
>=20
>  extern bool hv_isolation_type_snp(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 5398fb2f4d39..d3bb921ee7fe 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -529,6 +529,9 @@ static void __init ms_hyperv_init_platform(void)
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
>=20
> +	if (hv_isolation_type_en_snp())
> +		hv_sev_init_mem_and_cpu();
> +
>  	hardlockup_detector_disable();
>  }
>=20
> --
> 2.25.1

Modulo spurious word in the commit message,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

