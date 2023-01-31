Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0619A6833FE
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 18:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjAaRfZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 31 Jan 2023 12:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAaRfG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 12:35:06 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020026.outbound.protection.outlook.com [52.101.61.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5713945F43;
        Tue, 31 Jan 2023 09:35:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdmNt5g8U2I5/rJ0NU2zTGcCspTUbfPQfhKtWsnY8XV9+KU/gLnWNO5xNJa0dxIbs6JmklQPxrZWQKt4YAuwiJfUA0H9LX/z3IDLOCHn1eQ7bcG876Rli4IqaUYQ1s/y8AAnoiJ1+p51NCthIH7K4RsCn+Ef6JhoHyNOwdU4i7BN7G4nnmKAfX84rSLOy4mmX+88uWpG3t6l9sdbIVQN5zIX5hkLqrqCRFGHMVrSjOFAwppn2USAPzO8PvBx+vf5e750byOgrgvw3lULcAblJRk/KJeB/nNlE+9LQrHvZ4w7s+8h7ZEvHy2WJKVdmp5c3T3dpTAurrnahmr+v6f74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIU3FuCJmVpzAytxQmkh9z6+HlBN09yBDnXSsGO4V3Y=;
 b=kvCTTNYJkrvf8isJ+FA05Ga6SxdJPSmp+Y1ZwTiFpqcjdmzcU6hGlNoSw3gyb0BOgi7MYA6Cb9G0T0o8JlzIlrri621SJ6u30zeqyv5hIQYgunJL8F5B4RcNq/gBZi35xQQ1Mz18caZw+mhr7x1cUsIQbdJtBWv96IVJ46LSVpJargyo08qDEgjjKcTE6L+4P7iTyrTLiDGzbjDbiF3DDs/XU3rEwoAc2JQURdUDfi9h85PqTN6XnkQGQXK632ERk1gZOjEi2hfL3YCVtFk2BbC25h2JSut5fd/Kj0GTc9suFq4Gls4PKHPKkN2fiW4Yhwn8LJEz187hm3M+AkJrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MWH0PFEED04C944.namprd21.prod.outlook.com (2603:10b6:30f:fff1:0:3:0:15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.1; Tue, 31 Jan
 2023 17:34:55 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6086.005; Tue, 31 Jan 2023
 17:34:55 +0000
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
Subject: RE: [RFC PATCH V3 01/16] x86/hyperv: Add sev-snp enlightened guest
 specific config
Thread-Topic: [RFC PATCH V3 01/16] x86/hyperv: Add sev-snp enlightened guest
 specific config
Thread-Index: AQHZLgu1xuRybjP1Nk+ayf+k7xVXiq641Yyg
Date:   Tue, 31 Jan 2023 17:34:55 +0000
Message-ID: <BYAPR21MB1688C47E9B4BD0D1293E7D4DD7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-2-ltykernel@gmail.com>
In-Reply-To: <20230122024607.788454-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2c1ff116-ed1a-4609-81c6-bd7f9511e81c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-31T17:24:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MWH0PFEED04C944:EE_
x-ms-office365-filtering-correlation-id: d23d4d56-d0cc-4b60-1498-08db03b177e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 402isAz4GMRftF+nC0dHxjY7HW7g2sf7229URYvofs416Cx9EL0AlS6eRVMXaIlBSSKjFJCE1zjkVf+AOrYhyyvKxvauLWsPdwUgYmyN/hUR2Sf+7+LZ2LeQ6/fmAfiduYeY19zP2hehjc7SAFTXLuCP9TGRPbIXQVB6beWmIydVOBtl7Kccwzh+SWeHl3M8M2WCML1h/hHrg2SzAhKsSV/gPsbMs5CaI/QPnTAFTxan2ShBHYl7GkgiYS3zmA8c3Of1k2q2rZIOSXItzGD2ccvv/ScqK0M8opUlb39F8LvK1QC0IBF7+e8xfVKHm+WNwnFuKjUQgeRCcs6Hy10v1LV/ec3Sb0c4k5urIA/UWUv+ppMB0p8vSFl4k4+BB8WQpT86/Pni7NgGVyIiUIZlZr7ricQl5Tb+0DnydcAnPkNdGyEFosOLRFlhEMzM1yzL/HEujlOrVe8idWllCrPL4AI1oooTKZ7QcV6P6NO/1gmCF28M+oYaqoUW+dKaNzkeB7cPZlUKPfOoXzFf4xO21S6WRcsensGT9dzvrngSwUh89xPpm9U5bIkP9M1i4swITOsci9IuHylUxvSL6A2X2veEmKQTga75bcxaHx1tSlb/n5JmemX8pYEsboXM/MG7aG1k9+EtMcCkDS4btZr9L3QJ1lFMZZBYS3DkQqSFgz0k0Q+r2qX7jfqXXgkGRXxSFz2b5aBgW8nkoklDbt8AK0NyqRRt2YSCPmcU8psZOIRkkHUFmbaViM9wwFwIvOlOTkUcTczCwtyiojQmpTBjzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199018)(38100700002)(5660300002)(33656002)(66476007)(52536014)(186003)(8990500004)(6506007)(26005)(66446008)(82960400001)(7696005)(4326008)(316002)(66946007)(83380400001)(82950400001)(7406005)(71200400001)(478600001)(122000001)(2906002)(9686003)(8936002)(921005)(110136005)(41300700001)(66556008)(7416002)(55016003)(10290500003)(54906003)(38070700005)(8676002)(64756008)(86362001)(76116006)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+tx7pd+A4RZ3IaRX7V8yfILwryqKPk7me4DODGmp6k5GkrfB9ib42+9zeZv4?=
 =?us-ascii?Q?oETakQyEkRbnbUeupdyKIupPNgwY9qh3xMSdoM9BlEOjeosAWqW7LH8Q+tr7?=
 =?us-ascii?Q?4JGopPMBWDmAcfrlsESB941CN6HcmO23G8xDdFqV9Tc5LnfV7R3MIyLQiZ9s?=
 =?us-ascii?Q?Qupu1ecNXzKW3NhQdGogMLNuT2giwb5bUftDlL0fKil7AXG9emboDuHhG5La?=
 =?us-ascii?Q?9TTnluiNZEkZLo1+BSb6PGwNcsgb8EYatN9cDwlZD/IRSdPntCgLrEfNeTPz?=
 =?us-ascii?Q?svvtFuLmhodN/DkbsSKeEWD9dad3jXSUu0CzN8Q4Au4T3P+NT5yG/q9sfQW6?=
 =?us-ascii?Q?JG/xpKGgjHmfbUPFI23gHVwoeXwegmmp+kzhDE0mtHqlaehxxBSHWsiEzlAL?=
 =?us-ascii?Q?RBYeZKC695LLLlPezPcA5aXNFa7iJj+TeelTKel0mdIyDUKsCDY0gpOeovVW?=
 =?us-ascii?Q?fdMDfeg8aK4Azu3GPbITDOSqMRRqR6Jd579q1qj8mclUB33qg7kwuVUKTNIV?=
 =?us-ascii?Q?oY2SARB0jRfUY/igmHDVGP3xmEwaNAaeeDJo28qw2qBSNWpBLK2YT5VjHoSb?=
 =?us-ascii?Q?JohWvlKp7/kKbINNe2kOatEF2bfPgqcWDN1nA2v17E5obiLX7RLnUzYBFLy3?=
 =?us-ascii?Q?J1gMcU5LoWg8m9AHyWMkf/VsSuTrWtANj9sQHqCqvGiDoK4bF6OWrfTFCMdR?=
 =?us-ascii?Q?nlm/tAoYkXIaiUbkaDanD19yoQF7VPbbKvczHMWrd9jpPBHs62KuAQIXJ6gd?=
 =?us-ascii?Q?2CJCkeVYFsSLTc4sNeo06lkFsnWeg/1iZ3uczWT+EHc3D5QhIDjtEpOslgVv?=
 =?us-ascii?Q?z42Vhgz8mkbaPzxd5UHQX73XblQnEsWiD8Bz72egQRKgnx8OaKyhQn97zIrK?=
 =?us-ascii?Q?zxidtlrdAnDXt/uRkf/m+VTkxEMdeUMIXGnyUckhyeKvkXfRWToiQ42JIswq?=
 =?us-ascii?Q?3HGomJ6HKWm30s4AIpd1pvJJpQQgQCQCpI7B6HknJW/r1TJUBVwcDt4nRBP2?=
 =?us-ascii?Q?c9km1MJ9l96k3ZYHayMFKnyEDvonRB2WhCMGkVT2kD924Sm0G50elOAJhcbG?=
 =?us-ascii?Q?/ppq1DzGbjqljKh71ac8dZZjn/q31IpBan9O/NT89WSjgpyyiDYOkGyOv6Yl?=
 =?us-ascii?Q?8ZuoZRd7xsDmYsDsm1yEV0o/fgFwujymYOZ1v5zu3imGFKpag2iGmLeg5uhC?=
 =?us-ascii?Q?hadg5KucbZ1uWNvqETrSJQ21NJ3M/mb6MOScRcUHlkcjnewyWaAD7qroLvxF?=
 =?us-ascii?Q?r4SF/vaIXTQYZeALOQBUzYNLchCRHcHPolXNZBRaJ9xDmUF7AXKgWB6j153n?=
 =?us-ascii?Q?yzYHv3hUoECsKVvPXL/wsIwKPcCrkj9G3QWlkQ/jZZuLvW+aKIGVFIPz9pXK?=
 =?us-ascii?Q?bjqNGCpeVuxqkm5eResdN6IDHqG/1Cgh+UoqAeLyzO5UJjn8k8akFOnYFVtt?=
 =?us-ascii?Q?Zb6AgA93C7TBJ9yC6AEvbGQXwOPuXr7q+tIMKxO5QLQskQqmM/JCS73Mxtoh?=
 =?us-ascii?Q?Lb9ncVYE+bOY+Igrz+YsbB01zsBC/ES7RuqSQdtFSITN/Dj7V35EaFcxW1+7?=
 =?us-ascii?Q?E6WEuGvmRJmzTs1WAFbLzCTdrLucnQSkES/iNjH+8YXx4dScJrhXDbDCT4IK?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23d4d56-d0cc-4b60-1498-08db03b177e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 17:34:55.8366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLtoNmUaY3Mw06OkOkGJQsHKDsvdNLHf5HUlhR+vqmL8PXuQn2E39P+6aSMIwgZeu4umVhAr15Thl6emiMbcrCuz1ES3JwmP0tuCOpcXAEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFEED04C944
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
> Introduce static key isolation_type_en_snp for enlightened
> guest check and add some specific options in ms_hyperv_init_
> platform().
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 10 ++++++++++
>  arch/x86/include/asm/mshyperv.h |  3 +++
>  arch/x86/kernel/cpu/mshyperv.c  | 16 +++++++++++++++-
>  drivers/hv/hv_common.c          |  6 ++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index abca9431d068..8c5dd8e4eb1e 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -386,6 +386,16 @@ bool hv_is_isolation_supported(void)
>  }
> 
>  DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
> +DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +
> +/*
> + * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
> + * isolation enlightened VM.
> + */
> +bool hv_isolation_type_en_snp(void)
> +{
> +	return static_branch_unlikely(&isolation_type_en_snp);
> +}
> 
>  /*
>   * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 010768d40155..285df71150e4 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -14,6 +14,7 @@
>  union hv_ghcb;
> 
>  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> +DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
> 
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> @@ -28,6 +29,8 @@ extern void *hv_hypercall_pg;
> 
>  extern u64 hv_current_partition_id;
> 
> +extern bool hv_isolation_type_en_snp(void);
> +
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
> 
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 8f83ceec45dc..ace5901ba0fc 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -273,6 +273,18 @@ static void __init ms_hyperv_init_platform(void)
> 
>  	hv_max_functions_eax = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
> 
> +	/*
> +	 * Add custom configuration for SEV-SNP Enlightened guest
> +	 */
> +	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +		ms_hyperv.features |= HV_ACCESS_FREQUENCY_MSRS;
> +		ms_hyperv.misc_features |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
> +		ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
> +		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
> +		ms_hyperv.hints |= HV_X64_APIC_ACCESS_RECOMMENDED;
> +		ms_hyperv.hints |= HV_X64_CLUSTER_IPI_RECOMMENDED;

Two different things are happening in changing the above flags:

1)  Disabling certain feature that Hyper-V might offer to a guest, such
as the crash MSRs and Auto EOI.  (In some cases disabling the feature
means removing the flag.  In other cases in means adding the flag.  But
the net result is same -- other Hyper-V specific code will not use the
feature.)  This category is OK.

2)  Forcing certain features to be treated as enabled.  This category
is somewhat concerning.  Assuming that Hyper-V is accurately indicating
which features are available, it seems better to check that the flags
required by SNP are present, and refuse to boot in SNP mode if not.
Or is this code handling a different problem, where Hyper-V is not
indicating that the feature is available, even though it really is?

> +	}
> +
>  	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
>  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>  		ms_hyperv.misc_features);
> @@ -331,7 +343,9 @@ static void __init ms_hyperv_init_platform(void)
>  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
> 
> -		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +			static_branch_enable(&isolation_type_en_snp);
> +		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
>  			static_branch_enable(&isolation_type_snp);
>  	}
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 566735f35c28..f788c64de0bd 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -268,6 +268,12 @@ bool __weak hv_isolation_type_snp(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
> 
> +bool __weak hv_isolation_type_en_snp(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
> +
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }
> --
> 2.25.1

