Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9274B6DF8C7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 16:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjDLOkI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 10:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjDLOkG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 10:40:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2115.outbound.protection.outlook.com [40.107.93.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B593F4;
        Wed, 12 Apr 2023 07:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoZVhFXzQm90C3OxRcrMOGfL9Vakd8PTFwoAZLSfOoMzzA+3Q8IaTW5gP29TsUxFM1YIOpYxbS/uEltfmrHI33jxAWVjy+d06btcmIO4kmSTQvoO7p/01HCnR5g0H0Z9CAmStDYNlL4N/Ss8Fi12rMSWa4keTEOckh1+UEAYmYqBzobbNHsx9cmI9xubfP3jrYCrn8Q+V0MhsthX5YgCNGIyKpwKEzQ/W0S6b9iMKWPX5we8NbcvaNefUset3bN5OJy1DDhWfFoTWczks3jLGZH2x3m6PrtrQKMiH74BF9IYOPcNfl3JETsIeUvk2PsFgRsxxJDLQgX12jWL7CbOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XTolRr7riR+upUcwosz1sFUJTFJS74kSUFR8ok4LGg=;
 b=F0VkvtPPrjrl3xSLIGScgdYjBPBghCOgvtEaKFQ/wyx31Pwu6fquZ0Y0gAGNkaB6R/z5/rlrLyECs8Gl0elAVtI7z23NiPOxXOiKw38BN6ZkONz1TsJraHT6sq3e22Nsm/gYuE1IwQ48dVBz3AXIvFxr0INbIx6wMRDTp5Gvni2LCQKZFF6VcaRu6JERovRiSK9YJecA7py7Ajly4A8INeFQL28xtfDMPv2YqGUZBZTSWrcl+nkQ4i3nTXipRpQvZXgd8CsSjz2icRFAlySrB6KSCPchEpgYT1/K066UNuL1HNx5mhNJiCxUO4clBBjQA9cylrs5Lsc4rL5FzoF6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XTolRr7riR+upUcwosz1sFUJTFJS74kSUFR8ok4LGg=;
 b=XQcbQ/dhYXLkgiWfCFukfSyl5orQKL2CVH++DSYpobROMCtXermQD5dWqrVQisGclk9rd+6Zn9R0wol/QUayvzl42aIjF6QPnLOX4w1OdYLxGyvl3XWenDpk0i+0Rvzc5G4n0RMk88KnBtrq0ilNfZWMThyRAwxg9QIuE4kVHVQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1418.namprd21.prod.outlook.com (2603:10b6:5:25c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Wed, 12 Apr
 2023 14:39:31 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 14:39:31 +0000
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
CC:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
Thread-Topic: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
Thread-Index: AQHZZlQTt4ihITK/WUKaKaTay6hYrK8ny1KQ
Date:   Wed, 12 Apr 2023 14:39:30 +0000
Message-ID: <BYAPR21MB1688DB1442B486A8DEBEF821D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-9-ltykernel@gmail.com>
In-Reply-To: <20230403174406.4180472-9-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c24e10f2-0992-41b0-b5d3-3bda2cf9e7ee;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T14:35:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1418:EE_
x-ms-office365-filtering-correlation-id: 74dbe708-27a0-4ddf-1e98-08db3b63b9e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /qbUP9Af3WzkR8UjdIQmVe/kBzzOcKU4rk+AJR+ZnALMFdy4gRbXmjhivu8kATRDzB1+e8ADBtjXlHbRScOexw1OeJ3yJYH2zA3BypQWjM+FX/cbHXrQ4LhiJAoTQf+cFMPLo3ls8uotJubraJ8hVIK+U7v2jCaI6ID6I1jXQUQETkfN543iQgLepzEQbGvcu3YPXf+pciBq2GGDXL4SD/aXtQamQ3MCI7HvAxB75iW8H9hLfyxV3naqyF8oMQJHfWgRfnZUM7OhkwKjMbQPJXO1BHDE5sXZECP6yYNjnHXB4xefmLTWnYdqgziM/mmtQe3Gd6//4PsXQOUGISR2398iDjkLoR6So53YxJOqRQEU+Wj0nzYntbrQNusVZnjihTwDKI3pxSfQ9fvwwRN2m5AoHd1vDAPL0w8FU6cN1OR9cT+psdqrGGQxgC8sAbyfEbP8CcegAyqeI1HROtX6ooDhx/8iPLo1R3S2ZEXaCcZjDmW1qaBQBYjg4KwThnxwG0uQtVyZDTHhHSp3N1rNeDZitD3jVUYiISpNtpzXpjIDJL1WWOQ3X/2MvB9u8SUE2+MD1smeyv+PGweRV6imr3D9wXQspaU9ip8NT8dW4uMFZWA308Mk1YW1hHC+ggWkygvRTinYoqka0oupqp1wr68sOix48ZuORY1BY3AWkStqCqkyFr9fq4pUh6S5YLni
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(5660300002)(54906003)(7416002)(7406005)(10290500003)(478600001)(71200400001)(7696005)(786003)(8936002)(52536014)(316002)(41300700001)(26005)(110136005)(66946007)(66446008)(4326008)(64756008)(66556008)(66476007)(8676002)(76116006)(6506007)(9686003)(2906002)(186003)(83380400001)(8990500004)(122000001)(921005)(82960400001)(82950400001)(55016003)(33656002)(86362001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?by31CtZpTSlF89YvidBSsKVwl2bEAdhsRzu5RlhsxRYq37+1ZpOBiQhYN36g?=
 =?us-ascii?Q?JX2mKJJeyz7lWy0Wk6o9j7QQWkhtRJI+Wg/hMBFOzYMgT/TKZiA5Z9urdBio?=
 =?us-ascii?Q?A9jk8a8+1iNCEQgBpNws5vtWb2zUGd/77tnlGEJ7aTIdta2CgIKX8kw3pheY?=
 =?us-ascii?Q?OAmrFK7n7ET/oY5/7GuOKL3pNH2OQKPEebHcT+ne4rzzLBAA+tnn98nVE4DW?=
 =?us-ascii?Q?kdeo7ZEtTALfN8K4ZMD1JgAsUWZ49qOdfgPkfW+G0SSX2WoHBLJcUAuUra7n?=
 =?us-ascii?Q?v9dh2XleEVc0NOSEA9tfDirq+zhKxGfLWt07yu4jTrko1LeHDQAGzPHbSwNC?=
 =?us-ascii?Q?CHb5j0GmyHYw79SrK8+uhG4qeiPC5reOGJ7+ZDiJsEH4xlz/11kjUQCJV4a/?=
 =?us-ascii?Q?XKnuD1JMUbq1GOXqIifFTlcW58yioXNi5NpJd0jdV/s/F7BfLdA8VqOPFWJY?=
 =?us-ascii?Q?g+4jABEof74t0XZYOBLBhHtBlsyC4lzPD44+rYvmQRN89vsf3FV8gIlfn0Yg?=
 =?us-ascii?Q?okcUfHJv+KuRum5LAR1vg+bhhEh8VzaoyGovuClNYiMvDpcp4u6uZpfkZuLZ?=
 =?us-ascii?Q?88bAcIOtJWBlioL+J19zwVUMHlIvQUmZqJB1Dw3n+OQ+YE8w2B0FptQy73kA?=
 =?us-ascii?Q?AkkbXarcWK9urHyyBcL4xNqTdFnsLPfa+DV/FbXkcEh56SJAIbJ/cdvyyk+j?=
 =?us-ascii?Q?e7NsEsWO3ogkQBdLxLB9hql1xA6k2bzwn7MRAbDx07WkAB9MCpucBRd3sXFi?=
 =?us-ascii?Q?B7TdhbfIBEF8U8In62LO8RBLkrSTWIxZ2Kt+pp5b88ZxftP7nm6ywt4vknjq?=
 =?us-ascii?Q?OvNzVFtTMNoiWLSbeDIcZFcqLhD/8y3XOv3A9qhZD2vWHlMStVeq5KuuiwS/?=
 =?us-ascii?Q?L/dKdFQSB9eR4Qa1N64q9PsIYbA2C8wxV7L7DU30Gmg/gDWeWYz2cCbB7imW?=
 =?us-ascii?Q?wHiNu5ffYbfM6lcB+uppJ6I6D8rqi7q/9pCiOXabxMtarfsiLHm0AR5gA3p0?=
 =?us-ascii?Q?Rbfv3nmqnoPjW5v+oYa68OmlvkfFEgLZD4pu4gFNPWftRF0MTymngaw+fjXU?=
 =?us-ascii?Q?Ytg0dIvwsrDdQYZKxZTGE7FH9QjYOde56cbIseaKRJvpLX/U9volLSvs3f2i?=
 =?us-ascii?Q?lc18nUKRM0FqMK+YAQVrB5kLf9M1ZssyOeAeuHePWV0k3ajKQJFwZTx4l9+a?=
 =?us-ascii?Q?gFb0jdoyPLVoh5x799kCnfhFgVCQNPWfqRLVEjpazedkzyimY62xQEdkhl68?=
 =?us-ascii?Q?/oSUAmlWqVl3Eyu8wrcmFQpAvK0muSQromOTnSoE9sF0c7pVTVVGqQB8KmYb?=
 =?us-ascii?Q?+HLvfdGo4+z8sexVTYssc6bKovfnhTJPmCrja86j+Sgdg9GLM9U1SivTVX8E?=
 =?us-ascii?Q?C7V5iBluswMVIwXeoUu7kvU7mNZEvlhU96uZlNMNOjFmDjjUPNhrpvHEVxdy?=
 =?us-ascii?Q?OBoQWbRDQPFTvcvys3tmO5vERb+gIaqqcN072w6t/Al8Ni8NQPb8ZIMe02L+?=
 =?us-ascii?Q?cRdX3mvoW3s515T2Vd1m6dFAu3lYwMwUuAkghiLBgkhUNKo+ZoxJzeYdKCog?=
 =?us-ascii?Q?SYPHvGF3itT6wz6mhzlQd0JAaZtHLRbFQIg8GdzXT8kTS37eD5Ac80RPBqPU?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dbe708-27a0-4ddf-1e98-08db3b63b9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:39:30.9334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkqR7WQ1R3n6XvBGDmpUs7V241visYzbD1MGArxflodYzHzuvq3duOWDBNyLu7gnRcQlwAxS+fk7ObfSqHO45YgQUmh60H7JPdvz5/wRZKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, April 3, 2023 10:44 AM
>=20
> Read processor amd memory info from specific address which are
> populated by Hyper-V. Initialize smp cpu related ops, pvalidate
> system memory and add it into e820 table.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 78 +++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h | 16 +++++++
>  arch/x86/kernel/cpu/mshyperv.c  |  3 ++
>  3 files changed, 97 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 368b2731950e..fa4de2761460 100644
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
> @@ -57,6 +62,22 @@ union hv_ghcb {
>=20
>  static u16 hv_ghcb_version __ro_after_init;
>=20
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
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size)
>  {
>  	union hv_ghcb *hv_ghcb;
> @@ -356,6 +377,63 @@ static bool hv_is_private_mmio(u64 addr)
>  	return false;
>  }
>=20
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
> +	 * directly without bootloader and so roms,
> +	 * bios regions and reserve resources are not
> +	 * available. Set these callback to NULL.
> +	 */
> +	x86_platform.legacy.reserve_bios_regions =3D 0;
> +	x86_init.resources.probe_roms =3D x86_init_noop;
> +	x86_init.resources.reserve_resources =3D x86_init_noop;
> +	x86_init.mpparse.find_smp_config =3D x86_init_noop;
> +	x86_init.mpparse.get_smp_config =3D hv_snp_get_smp_config;
> +
> +	/*
> +	 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
> +	 * and legacy APIC page read/write. Switch to hv apic here.
> +	 */
> +	disable_ioapic_support();
> +
> +	/* Read processor number and memory layout. */
> +	processor_count =3D *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
> +	entry =3D (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_AD=
DR)
> +			+ sizeof(struct memory_map_entry));

Why is the first map entry being skipped?

> +
> +	/*
> +	 * E820 table in the memory just describes memory for
> +	 * kernel, ACPI table, cmdline, boot params and ramdisk.
> +	 * Hyper-V popoulates the rest memory layout in the EN_SEV_
> +	 * SNP_PROCESSOR_INFO_ADDR.
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
> index 3c15e23162e7..a4a59007b5f2 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -41,6 +41,20 @@ extern bool hv_isolation_type_en_snp(void);
>=20
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
> +/*
> + * Hyper-V puts processor and memory layout info
> + * to this address in SEV-SNP enlightened guest.
> + */
> +#define EN_SEV_SNP_PROCESSOR_INFO_ADDR 0x802000
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
> @@ -246,12 +260,14 @@ void hv_ghcb_msr_read(u64 msr, u64 *value);
>  bool hv_ghcb_negotiate_protocol(void);
>  void hv_ghcb_terminate(unsigned int set, unsigned int reason);
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
> index 2f2dcb2370b6..71820bbf9e90 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -529,6 +529,9 @@ static void __init ms_hyperv_init_platform(void)
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
>=20
> +	if (hv_isolation_type_en_snp())
> +		hv_sev_init_mem_and_cpu();

This looks good now.  Moving the code into a separate function in
ivm.c works well.

> +
>  	hardlockup_detector_disable();
>  }
>=20
> --
> 2.25.1

