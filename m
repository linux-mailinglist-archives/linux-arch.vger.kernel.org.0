Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F68174740B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGDOYg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDOYf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 10:24:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2102.outbound.protection.outlook.com [40.107.223.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2FE49;
        Tue,  4 Jul 2023 07:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdY8IM2uY8dk3rq9elOtvnVhbmjzRMiyyL6Z0b5+C1jxmaYa91HKZ+9JuKQsIqu/hYi3eu9k8gYeoptgP54pIGT2rfr+1H2FDQmXE8VI1S/c2INGqqPYUjzmaf0fBzcoQ5MvXo+6dD4MxzyR5YRzmQEPA+fQ76QJG4Yrz2GOZiNjS3hYkZiM2NOS9LeJTZHd0ioEDEeiptz9VAqK8UcSbeBd/LjUh4P9GtQH2Xy4VASLhqsqeHJToiCRn0VyVZrMKLHch25Tt/J/DAs8h1/xdrMaJ4/I9gPfKq4Hq09BxxQQXjhIvE9wyo/9JUB2uWOz1hrsFr+iN1ihlRECQ+KjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFB12vv05fgY7tiFzZdVL1RQJ8q7qg7TSfyG6wIDf18=;
 b=F2AaQzEOjIOp7Jj1P2Db87aR+5KqDiozVS8CEoitT3CYDi3Gd2s/Urrg4G3qnKNPe+zstsczIgSrx8z9uw2IoDgoIC+VDRtzk0cgvO0Z8TYwpQxmW1aU2bOgobGjG96ZGtIsMHRs2c5C9ynUDYdxRTzQONH4nV6AxID6QM6HqNUqMJWSrJ55t5R7nlq6AUlb/M/yEiaI9ubsAi5Bf80YYdikSgD5NvcdBLQRz6cRpztWA/xq+c+myQJE3Tvxz/khwKHR4f69nSg6XYlomTohMpsAGYfljNGoYP0w2/NixbrCMHMk6ayYdq9g8/5BW5/oenlkBf6qqyevM1ozyLnspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFB12vv05fgY7tiFzZdVL1RQJ8q7qg7TSfyG6wIDf18=;
 b=f1Uug823dMQc9/I/xjDulF5NOdLKxLj7O6Qlr10CSN9PW9FNtzPVpomC2YvxGNaW2GRBRXHCtz0+QXnp93qgPCCpQWLTwaJ3MlZzXEBN1QaKr56kKD/6GOX43Aq4zzovpyb6Q9ls30kIJS43VLWxSoTAxuKgJzke/3VrnNMQy4I=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3733.namprd21.prod.outlook.com (2603:10b6:930:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.8; Tue, 4 Jul
 2023 14:24:30 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64%5]) with mapi id 15.20.6588.006; Tue, 4 Jul 2023
 14:24:30 +0000
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
Subject: RE: [PATCH V2 8/9] x86/hyperv: Add smp support for SEV-SNP guest
Thread-Topic: [PATCH V2 8/9] x86/hyperv: Add smp support for SEV-SNP guest
Thread-Index: AQHZqKayw1XHps/pTUKY1t7TE+1yya+ptO+g
Date:   Tue, 4 Jul 2023 14:24:30 +0000
Message-ID: <BYAPR21MB1688722CB197F35FC588636AD72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-9-ltykernel@gmail.com>
In-Reply-To: <20230627032248.2170007-9-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f3a4a0b9-95ee-41ae-922c-e72cf74e73c0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T14:23:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3733:EE_
x-ms-office365-filtering-correlation-id: cb4e6830-aaa9-4498-0405-08db7c9a6181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /YYJ0PFlmLB5DVYzPJRdEVEoOeM57l/onKU2PUsXBTnggE/tT6TFR2pk2be/kSKicGDBvmOymO1eeOuN7hxTE3u/ofY1yxMN8dZ4UVtEnjtIV1GiqMt/QmF1frWy9TccV2dmks1mgCRwLhUIT80iFhwgnBt17Ee7uPqEmj65/DAYIbU9S0DcM0PpoEk2KVF+dCtOuFVkwlqDOBzu7bHqoPzsVtPVCX00GHKQlFhcmFwEO2M5RYqbpV2W5Ua8k1VoF0wxuVDKEI6BzMLyP5GR98DUw6kcxhFyUJ217tNDbFtsqPtBHngs8yMtEpbIjgApLJJHKbB4ZiWPg6WmSw28TjfR3elWlCtuxKXJW5PNwKX8kuXDnOaL8Ym7FhHThH8+8QRuv0x5o3ujkMwuHpe6a1twzkI1N+Qt3mPeKF6O6afIp67KV9PSA4bJnaDATX0fCbLChjAZ4sizkRPoK1Dvi3CyO/fwdBK1wVilDzzEuMBThHIWJKS2G6vaAEYrH8HPNDILFDD/sQ+ljNZXzXMqk2UdPVcrRifAUVv3d75NJw55kaVORn9HEJfH6vC9VqieEMSEc1euv4W2Zhss1ffXHQ8emburavcufu2ckdMJ01hXSZSmptAS7gaqsqIs3OfnzilyrIJ6iGIh+AJm67ztHWIJD/roCIZMkmBBBIe8qRqalXR41MuysgYu63Xigv8p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(8676002)(8936002)(54906003)(110136005)(478600001)(26005)(9686003)(41300700001)(52536014)(33656002)(71200400001)(7416002)(2906002)(5660300002)(86362001)(7696005)(64756008)(316002)(66476007)(122000001)(55016003)(66556008)(76116006)(38100700002)(4326008)(66446008)(66946007)(38070700005)(921005)(8990500004)(82960400001)(82950400001)(6506007)(10290500003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CVsZ67qUJvoUDH3ByzcWWMnSbKxxggImsire3R84wMbYfCnLHDIiwt/MVP8T?=
 =?us-ascii?Q?Ae2C0rG5DIhtHhAbzNERzFqUnOcnrBNHkmEsQSmIn/3DNj+kBTjOKT4nazrt?=
 =?us-ascii?Q?M2L6doiiVe7mpzuU7vz0HoPx530JWcx5vQNuy79ZlLAnbtnwXoSgNfE74Rgd?=
 =?us-ascii?Q?QqFtoPXopfM7/alzRNgqMgk/uASe2P8Xjl0bWcoF89TcH8qyWDlRVlNSvJEU?=
 =?us-ascii?Q?dRvTeMpjMP61AOr+CzMSAZWfyJTanaph1rvG3y/Zm1yBsxJYDnnXTvMXjqI8?=
 =?us-ascii?Q?hcOFAWosG6WP1sBCy7J6l3BDfF7RpNqYyI3wXvoCCUAOzCxk9Tzxx7kaS7VK?=
 =?us-ascii?Q?ZNMc9QEjtpf/nPvAeLgM4YbdQVlNjiFwB3ASSVL4/gzbEcG34AJFsIdPpT52?=
 =?us-ascii?Q?9d25PhyQxt9lA6gqnu4wsM8tSUpEguWzIGWb8O+58E8iPHVvEnEQsYuhUuiK?=
 =?us-ascii?Q?Yp6P9clHKdACj/hUiBFv0I1nLcsTgJ96RkQUnZhEq1T9MMwhT9lepqgIZSRP?=
 =?us-ascii?Q?Bq43MuEAS59EUSyWLWts3dAF/7veUO7l9EGDpose5qeqRa0WTzT3y0u2fi1P?=
 =?us-ascii?Q?ZmF34Rcs1i174fQssDD1w64Hkstcj75o8phHwI6U3u8eejM57fGAPKlW3myW?=
 =?us-ascii?Q?SrX50z2iBj7jyqNje2OaOVEm/0M55OYuahrF3fpnU3mwd0EEdxqt6GZvg2xy?=
 =?us-ascii?Q?c9F3FqV5kd5ldp13b8NcGtH24G86EAmG6ZRUKS2gxWEQ8HRs9Z7a+pV6+JJO?=
 =?us-ascii?Q?bU8ELdYUBcQDmSLsntP2roUxUJOB0Cy/TUhobOOYQ2Es2YNnqBJdPtFaUdUt?=
 =?us-ascii?Q?l3P08BovoKaBQrS6TMhmqUtzsXP34pEf/RfpQlnkYP+p1WYGOQOw94TCdV1m?=
 =?us-ascii?Q?Z3veOp7FCoFEXId29Gr/UarleIqVZIq3rb7GzsdRBwC6IAMcpn5lo+N5svM+?=
 =?us-ascii?Q?lb3joL6500VkjFPUT3Cs+DbRRFUKknOjsz3HdgPid+5apvkb5Hnl55Fuxkny?=
 =?us-ascii?Q?6SwtyEEw6lpPjoJqMSLf9aOpDV4xHALP0TD+Bu2B8EQUz48P95brPSnuZ1AY?=
 =?us-ascii?Q?R/R5fhsLho+dJ1plGcFFsUXfFtfa3cL0qrO3eF31nsuvyA9aXQzC3pi85PEX?=
 =?us-ascii?Q?5aZFz7naYD5goHrlqfF/VpUnAdmd8dEVUh7Ei9yvF0CDtLsKBou39CWfHuJv?=
 =?us-ascii?Q?0zDQb9p1qjRPL/JN+w8fvcH9odhz8aTVh/yasK6oQqV3RkeC7Y5NkM/l9Nfm?=
 =?us-ascii?Q?1ccIBomHk+q46IbutILFO18bFUjUT3hoh0u18dLo3K4URSMgT05GomQHhvyV?=
 =?us-ascii?Q?ePsFkI04DJjpA9At10HBTKpsetiJ3BFpleEsUjTUEvKZXmDrR6rP6Wtx2duI?=
 =?us-ascii?Q?SBG8zZf3vjWQLVjzBEzOrxrBtyNQEwiQ8HqZyKFr2RBQHpfSkaHgOY33uIgg?=
 =?us-ascii?Q?FJ0vtUT+kxuL7BIfsnxsMxIOSTvYVwWW9WZiV+VqV5ezlc8wBXUDCCUKdfLP?=
 =?us-ascii?Q?dqZHDxKZll+MmYgOxnsZPghjidHAiNfVCpOM893mggI8FDIZVcIRixt5tNPF?=
 =?us-ascii?Q?9l2M59czg/wQzuhXGNtf2pP+aOg7hUFP6FZRztCADr+TfWgo200HgmMpOWeu?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4e6830-aaa9-4498-0405-08db7c9a6181
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 14:24:30.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8cLZ0VYkCi45AZ9CfAUSqOrLABggol1Zk10191dCMT9ZDiZnnRD7StDr5IDpu6PSPCIUnNRXZwniQCrzbAz8+rKqJP40TNJETjUoXO89HaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, June 26, 2023 8:23 PM
>=20
> In the AMD SEV-SNP guest, AP needs to be started up via sev es
> save area and Hyper-V requires to call HVCALL_START_VP hypercall
> to pass the gpa of sev es save area with AP's vp index and VTL(Virtual
> trust level) parameters. Override wakeup_secondary_cpu_64 callback
> with hv_snp_boot_ap.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c             | 95 +++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |  9 +++
>  arch/x86/kernel/cpu/mshyperv.c    | 13 ++++-
>  include/asm-generic/hyperv-tlfs.h |  1 +
>  4 files changed, 116 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index b1639ec07155..9b307f99b540 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -22,11 +22,15 @@
>  #include <asm/sev.h>
>  #include <asm/realmode.h>
>  #include <asm/e820/api.h>
> +#include <asm/desc.h>
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>=20
>  #define GHCB_USAGE_HYPERV_CALL	1
>=20
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_S=
IZE);
> +static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
>  union hv_ghcb {
>  	struct ghcb ghcb;
>  	struct {
> @@ -449,6 +453,97 @@ __init void hv_sev_init_mem_and_cpu(void)
>  	}
>  }
>=20
> +#define hv_populate_vmcb_seg(seg, gdtr_base)			\
> +do {								\
> +	if (seg.selector) {					\
> +		seg.base =3D 0;					\
> +		seg.limit =3D HV_AP_SEGMENT_LIMIT;		\
> +		seg.attrib =3D *(u16 *)(gdtr_base + seg.selector + 5);	\
> +		seg.attrib =3D (seg.attrib & 0xFF) | ((seg.attrib >> 4) & 0xF00); \
> +	}							\
> +} while (0)							\
> +
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip)
> +{
> +	struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
> +		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	struct desc_ptr gdtr;
> +	u64 ret, rmp_adjust, retry =3D 5;
> +	struct hv_enable_vp_vtl *start_vp_input;
> +	unsigned long flags;
> +
> +	native_store_gdt(&gdtr);
> +
> +	vmsa->gdtr.base =3D gdtr.address;
> +	vmsa->gdtr.limit =3D gdtr.size;
> +
> +	asm volatile("movl %%es, %%eax;" : "=3Da" (vmsa->es.selector));
> +	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%cs, %%eax;" : "=3Da" (vmsa->cs.selector));
> +	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ss, %%eax;" : "=3Da" (vmsa->ss.selector));
> +	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ds, %%eax;" : "=3Da" (vmsa->ds.selector));
> +	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
> +
> +	vmsa->efer =3D native_read_msr(MSR_EFER);
> +
> +	asm volatile("movq %%cr4, %%rax;" : "=3Da" (vmsa->cr4));
> +	asm volatile("movq %%cr3, %%rax;" : "=3Da" (vmsa->cr3));
> +	asm volatile("movq %%cr0, %%rax;" : "=3Da" (vmsa->cr0));
> +
> +	vmsa->xcr0 =3D 1;
> +	vmsa->g_pat =3D HV_AP_INIT_GPAT_DEFAULT;
> +	vmsa->rip =3D (u64)secondary_startup_64_no_verify;
> +	vmsa->rsp =3D (u64)&ap_start_stack[PAGE_SIZE];
> +
> +	/*
> +	 * Set the SNP-specific fields for this VMSA:
> +	 *   VMPL level
> +	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
> +	 */
> +	vmsa->vmpl =3D 0;
> +	vmsa->sev_features =3D sev_status >> 2;
> +
> +	/*
> +	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
> +	 * using the RMPADJUST instruction. However, for the instruction to
> +	 * succeed it must target the permissions of a lesser privileged
> +	 * (higher numbered) VMPL level, so use VMPL1 (refer to the RMPADJUST
> +	 * instruction in the AMD64 APM Volume 3).
> +	 */
> +	rmp_adjust =3D RMPADJUST_VMSA_PAGE_BIT | 1;
> +	ret =3D rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
> +			rmp_adjust);
> +	if (ret !=3D 0) {
> +		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +	start_vp_input =3D
> +		(struct hv_enable_vp_vtl *)ap_start_input_arg;
> +	memset(start_vp_input, 0, sizeof(*start_vp_input));
> +	start_vp_input->partition_id =3D -1;
> +	start_vp_input->vp_index =3D cpu;
> +	start_vp_input->target_vtl.target_vtl =3D ms_hyperv.vtl;
> +	*(u64 *)&start_vp_input->vp_context =3D __pa(vmsa) | 1;
> +
> +	do {
> +		ret =3D hv_do_hypercall(HVCALL_START_VP,
> +				      start_vp_input, NULL);
> +	} while (hv_result(ret) =3D=3D HV_STATUS_TIME_OUT && retry--);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(ret))
> +		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
> +	return ret;
> +}
> +
>  void __init hv_vtom_init(void)
>  {
>  	/*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 7a9a6cdc2ae9..804c67475054 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -65,6 +65,13 @@ struct memory_map_entry {
>  	u32 reserved;
>  };
>=20
> +/*
> + * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
> + * to start AP in enlightened SEV guest.
> + */
> +#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
> +#define HV_AP_SEGMENT_LIMIT		0xffffffff
> +
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> @@ -271,6 +278,7 @@ bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
>  void hv_vtom_init(void);
>  void hv_sev_init_mem_and_cpu(void);
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip);
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
> @@ -278,6 +286,7 @@ static inline bool hv_ghcb_negotiate_protocol(void) {=
 return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
>  static inline void hv_vtom_init(void) {}
>  static inline void hv_sev_init_mem_and_cpu(void) {}
> +static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
>  #endif
>=20
>  extern bool hv_isolation_type_snp(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index d3bb921ee7fe..8e1d9ed6a1e0 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -295,6 +295,16 @@ static void __init hv_smp_prepare_cpus(unsigned int
> max_cpus)
>=20
>  	native_smp_prepare_cpus(max_cpus);
>=20
> +	/*
> +	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
> +	 *  enlightened guest.
> +	 */
> +	if (hv_isolation_type_en_snp())
> +		apic->wakeup_secondary_cpu_64 =3D hv_snp_boot_ap;
> +
> +	if (!hv_root_partition)
> +		return;
> +
>  #ifdef CONFIG_X86_64
>  	for_each_present_cpu(i) {
>  		if (i =3D=3D 0)
> @@ -502,8 +512,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition)
> -		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
> +	smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
>  # endif
>=20
>  	/*
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index f4e4cc4f965f..fdac4a1714ec 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -223,6 +223,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_STATUS_INVALID_PORT_ID		17
>  #define HV_STATUS_INVALID_CONNECTION_ID		18
>  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_TIME_OUT                      120
>  #define HV_STATUS_VTL_ALREADY_ENABLED		134
>=20
>  /*
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

