Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194497281CE
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 15:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjFHNvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjFHNvk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 09:51:40 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF31FD6;
        Thu,  8 Jun 2023 06:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImVreQ5BGrZ362kyfQyRTAjh8YvKDsacgEKp+t+bIyZjotak/3eI8wUHT1m4cBOcpnRWrqAhzslWHxepLoTOHRdTWbQKUMuV35M7E5Oo/knv6KqT9arLTLgunF97w/cOqWetkiEKXn7cR5lvdxW1wc3wsaBKYfLVnMJ2bc8cMNWvEe7atJMIFzgQQsWHQRYHatKi2UDsMnKIBjUTpqysLrDBY0LKlOCYHy0iJmXgezo3SJWJIACD7uUVTDfQjZzef8x65ri5cpgtlbakF5CPtwlgHjTPjHTjvGf5nSpQuRd59eaFV7r3D28a9KHnVh+2VhhOOP4x68agNgjyib7Y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBdhHzAIQtXda+OwKtzW/7AFXVDnaMNnB/44yqFUrR8=;
 b=XtQHLLDYQufNbyyCnNCUDV4syyoQN1DtOMIc5Szd1i648AjblpGkl3PFrLCORM1Vhe4I3s6BcLKh8j9kHjZM5WoQ1Add4i7opqlBbcpLgbD6w0wuCMf1yQvditrWZFFeEZKgB169UcX0qAR2xWf7U5a9P7/7qMff1wnum34QDFFQBhGqyRAV2GhZwhknKwxeEcgWv5ByqENuCpYeteuryfOrhm6ioV/+kdQsuwTrK6OONQEAahC8NqdVqMgmtFizuHLAVAXWlJx7SDi8i4OdE+GbqHEJiup/3fJYldANYDS5LZKCdl6W3yPm1ZPWQ7a6+WGa+X6RaCSY0dt/7Xu6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBdhHzAIQtXda+OwKtzW/7AFXVDnaMNnB/44yqFUrR8=;
 b=Adh8T36F0f+gupOA3JciNwMia3haBRMGcyMGa+IaqtjWPxkziV2HbaHwTGyvExM/dS/alEGwL3zg1o5CjZ3FBiWg7XT50AYpRfarEpyJoqNLpOGZ0doITwj5d+wh76+UvWI6tfgLG2nbqRexQzkqxJiycuFDywuj3b2wE+h2PF0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CH2PR21MB1429.namprd21.prod.outlook.com (2603:10b6:610:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14; Thu, 8 Jun
 2023 13:51:36 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 13:51:35 +0000
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
Subject: RE: [PATCH 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
Thread-Topic: [PATCH 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
Thread-Index: AQHZlJwRTLggXtz6DUO8yFY8YfLVFK+A9KNg
Date:   Thu, 8 Jun 2023 13:51:35 +0000
Message-ID: <BYAPR21MB1688B4F74FF7B670267D32FAD750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-8-ltykernel@gmail.com>
In-Reply-To: <20230601151624.1757616-8-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=75e66be8-af61-4b3a-a0bd-11fc17987449;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T13:41:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CH2PR21MB1429:EE_
x-ms-office365-filtering-correlation-id: 4c911d02-318b-4558-dfd0-08db682779c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZppJNP2Iy4Ym1nvDi4vLyHb8d9RdkyXXxXfwXVwn2E0OgEYSTA8gFUgSd93w+MiG/qMhCTD6NJ8z2WeQEP/SxPiagGu0/9hhcyvcr/td9rn4Qv4gCvhmqEo9f3duAcrcQXVBXri13txTMcKa7e3qnfAB/bZyH8FAkzpKpcH0jj7eCuhOJhEDdLIshu1yGZRpaz97EiXMzxi3IRiohT3e8rzTiTbRVW7nw1iEXCox5sdMatnxYogO/ZSY3+Qx5d3fappCdE48+YFB1cGEvOaU9h2rzyyW9JTFd5gHiWSkk40y4h3wBVOZyWdAkm4Mn/j1O2q0uYTmTka5djvgKQ3nXsX62mOn/u7yyzMtGttATHD0UNETO56WXnp7WoduHFX5C/22M8YNbxH66tsdt2np+TDmos9ymKI1WEgRZa4In2jHLNuTyq60awWamNSqLEe7tPwDAT5A4B9dQVZqgcq3+E3GL7ewfKvjdKBmydVsdwf0CSBQ3uuLzrl0QdqiJvxX7qadUVu6sjvubzd/dwXZEVWDcbTHQxlak6Rnk/flWDOeX3AaC8PZlIfWlkDYCzVpvCjv1nRZQnrlnfeMWb6IAZ5ga5kjoGBz/UbUYRJyGf6heXiVu/4Uu/9fXfaFbfhKZO6Qt47iCISQ1qrBwMa4pFhdE3hvtL4qmToa88KBH6I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(8990500004)(38070700005)(2906002)(86362001)(33656002)(7416002)(5660300002)(52536014)(55016003)(966005)(71200400001)(7696005)(83380400001)(186003)(9686003)(6506007)(26005)(921005)(122000001)(82950400001)(82960400001)(478600001)(110136005)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(4326008)(38100700002)(41300700001)(10290500003)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uWnxqHQSReunx+kr/op60HCyl0e/k5Teoyc4/C6voY6NUT2t19grMw3MgQMZ?=
 =?us-ascii?Q?FJYobzE+v8GwrmyfhfjqXUCJEjUyk1GaTpNAKNUfW3tFeAzUuPSNXsr0A3jM?=
 =?us-ascii?Q?tr99/xpZlF7W8i1zEQxn491mM95aILp13Bu7x2cA/jqJ18JQlsMAsWRMXhZi?=
 =?us-ascii?Q?TOdTSiVejuYGQvWTgd/sHBEg9srukCUEKCxDOnaTGJYCvzjNOQsKbHr4M99N?=
 =?us-ascii?Q?VN1zf6zmbIrNjUpEhPFNFC21otVkyntoMvEyq58WoG4QWAh/2f5+rp7f+RMQ?=
 =?us-ascii?Q?08+9SWhfhn3BEch6MYpWxOp5GpOK9Si5KTJ+CGnEU4BBFWpQhdVQMYonStEP?=
 =?us-ascii?Q?XAVzBec7nzQI3szSk9X1rM77GJhuwUUmpGAjB7iBo2Wx7oCawaMDQ3XBOmp/?=
 =?us-ascii?Q?/FjCYUnKJ9Yb7RIttISu1saQa8pcJPS7FfiAWV8Am38R6luyktYSAy3PExuy?=
 =?us-ascii?Q?2svPy8WS/aWWZFL2bnUSsw1YqkDODW4ZgVchhpFOZSyV1AdacxYSS0VNAn9+?=
 =?us-ascii?Q?hjG5LU84vg0mqFzPUsYnKNIrAv8mfVRAyMQhXGQXgp7HQx5IfYURtbnEw1f3?=
 =?us-ascii?Q?K5NKfWTDL07MW4w3EZDMsZFlnXzOnxGDWOBt9t/t0ad638GctfCh6UCRUJNE?=
 =?us-ascii?Q?B6SlPL5e9XVAVMxIvxOlFXF0KXWCW2k5ZU5imLiJoqk6X5OIZuyX3hkc2bZz?=
 =?us-ascii?Q?pfHcS8GGWNZ6aPsPx5mWogP0wJFtKnQapYTB7rG6GgQ6eXUjO5/PUVEs0rhJ?=
 =?us-ascii?Q?vVH7LRUVEEFgVV5CQXUVd4xyFB7lnDzVXOno0RyoD9KJyumkV6L4/b8RmTjI?=
 =?us-ascii?Q?CNpqpZqff7gEgYUsCCVHqBhcAQaownC76tBPskjs1PmQ85FXFVHfmial8rRA?=
 =?us-ascii?Q?zdqK2vY9s2xzj/SBitXJPj/krbEXvfjjWiYEaeYWJl+7PpGPadWEu1h7h1EM?=
 =?us-ascii?Q?2AElsb2vNeaV00NpQRdqoAFhmidWYBV40w04yLcdMeNqCDKR5ld0L7yBWXhf?=
 =?us-ascii?Q?3yJZM2YiGL5mVYl0Tej4aQNw/OywwqE+DjTbvl8uhw39UnmnKEpacyAqcv2e?=
 =?us-ascii?Q?GSEE6PlqCyrv3ZGNPP+u5jicKhcMpkA0u2KZxfVvWdoqUevScHK+itNIl/p3?=
 =?us-ascii?Q?WsEEM7Fe5XYYM0PSQJXp8YIuxq7ZEuFDTXZUtfB568hF2n/+uSTg2YWoIkdt?=
 =?us-ascii?Q?ClzSkXMIEkppXBdfEYjT5dyLG37HJ9AtI+0LhCUmTmtsQ6B4g88DwIqGTpxW?=
 =?us-ascii?Q?9/7AtOQDzPkF/9ffbyHF1hqVFZhnbTnot28wVB8zLgP0LrAWM/n4OHt4wnDj?=
 =?us-ascii?Q?WxvsJkEwSCMVZdG2cD2oyCEuEGApNFVfoH1jvA4utUlxnBEcyeOTxSQePjjk?=
 =?us-ascii?Q?MQkoDz9ib2EEHmExFuhdhvbRUF9f9TVC3FleLXhOSbgKIfYwyW7HE6yZz9WK?=
 =?us-ascii?Q?uNCVr7PPNJhQA/5dOBMjBRB0KOOLEwGwbbDsM//uAc7+gBvWMjbYuqG0GvL6?=
 =?us-ascii?Q?szkv1JuWPGqaa913xiaWLHMy4TZTIrJ3Y0WGiuE3NeAXNn0mqc+1X7bwEjlC?=
 =?us-ascii?Q?cme6iWVVuHlusv/EA+xxJgueb23OMgu9eECtAR9sPJr2xR3VPShHdLZsqlDP?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c911d02-318b-4558-dfd0-08db682779c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 13:51:35.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3VwBhEnIr8VlYJVHOhHzZdjQ4e/lsJF0BCthqWzjA+QTa898D1lgKRFsmD6sjHPv+OAIbtPBM0q+oCMXJYk2RpXXFH+qRQ4iqkQLEMgg0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, June 1, 2023 8:16 AM
>=20
> Hyper-V enlightened guest doesn't have boot loader support.
> Boot Linux kernel directly from hypervisor with data(kernel

Add a space between "data" and "(kernel"

> image, initrd and parameter page) and memory for boot up that
> is initialized via AMD SEV PSP proctol LAUNCH_UPDATE_DATA

s/proctol/protocol/

> (Please refernce https://www.amd.com/system/files/TechDocs/55766_SEV-KM_A=
PI_Specification.pdf 1.3.1 Launch).

s/refernce/reference/

And the link above didn't work for me -- the "55766_SEV-KM_API_Specificatio=
n.pdf"
part was separated from the rest of the URL, though it's possible the mangl=
ing
was done by Microsoft's email system.  Please double check that the URL is
correctly formatted with no spurious spaces.

Even better, maybe write this as:

Please reference Section 1.3.1 "Launch" of [1].

Then put the full link as [1] at the bottom of the commit message.

>=20
> Kernel needs to read processor and memory info from EN_SEV_
> SNP_PROCESSOR/MEM_INFO_ADDR address which are populated by Hyper-V.
> Initialize smp cpu related ops, validate system memory and add
> it into e820 table.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 93 +++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h | 17 ++++++
>  arch/x86/kernel/cpu/mshyperv.c  |  3 ++
>  3 files changed, 113 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 5d3ee3124e00..e735507d0f54 100644
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
> +	 * The "early" is only to be true when there is AMD
> +	 * numa support. Hyper-V AMD SEV-SNP guest may not
> +	 * have numa support. To make sure smp config is
> +	 * always initialized, do that when early is false.
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
> index 9186453251f7..48b9eab3daf6 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -528,6 +528,9 @@ static void __init ms_hyperv_init_platform(void)
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

