Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE13D778496
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 02:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHKAkA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 20:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjHKAkA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 20:40:00 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499ED2D52;
        Thu, 10 Aug 2023 17:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9QZe8FU/V64xyz05Eh6doxbJ3vGvLfIG5YprmaxV0e8uDxR+iAemkfAS2GejYOPKA1p1+nHbDbkOZTTYv4ccZx4RAsXMQXn6WusKQVnI6u0fnhWMppLdxtWWyR/nPCIm41bV/yA9pCnJG7Bc2Jps7IUYQDB3KRrHDjvkurWKmn3jfr680yA4DHq8EM+R2Pb5O0mXr5L5lcuDTS+VQJ41Ep/hYgNRMcMcTt94EQL0rullLtHT8YIUkJ2Ue/w0DBU+ZFh/ZO5ulX5LkfrLEv4SovQISg+UI9ZFwfJQDlkhAlvLi0fjp/rd1dj0rJbDs4segYugIHGsYXW61oHwDrcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6VxMN9of1A50ukB1uH4jBuPHuaZ4iiuviW/aYKsopA=;
 b=k/Mwze6IVmFXYy+sPlAOF0w/FClUG8lA+coGdbr6AaaSxB3E3nJtB0EIQvFfCdPUc9AOMMxn+6s2yfrpBu/1R5FWzlS/JcRVYAS1l6E+JA0ML80SSIWNAC4oX/cMPBupSmXpaglTXWXAXI0CkZS9M06nTT0Gd/FZTFHtAEtYyqNVPNNDp0VEe8FyYjNO1hvumQRt2v8a8CmjpPS5kcVtITFoxiVGfMh1HVcgG7W+9fwTKNEV/z+XdfS0bYLnEOCNEutSLIMo3EKhBefQ9+rAUpqjVo17EGvJzTvg8ulLbQFQg/Lpr3EbbDn5TjciYET1Xj9T7XMXArNI82tqpteF4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6VxMN9of1A50ukB1uH4jBuPHuaZ4iiuviW/aYKsopA=;
 b=Id6lADuvZ6l60ArnnNakE2c3OP72nAZ5m9JvbYU8PvCO56rvAUNd/IZlm6xoGXA7J/Izx6uvXMyN19GnvcB/fceXJtqqisttS2RJi30z0Zsf98I6gDHO1LCx7BVP/L2Elo02hrOSufR0RwZ7S+fFrNfDOYDJQLHvQRAX1x/6+qI=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ0PR21MB1933.namprd21.prod.outlook.com (2603:10b6:a03:291::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Fri, 11 Aug
 2023 00:39:34 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.004; Fri, 11 Aug 2023
 00:39:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH V5 7/8] x86/hyperv: Add smp support for SEV-SNP guest
Thread-Topic: [PATCH V5 7/8] x86/hyperv: Add smp support for SEV-SNP guest
Thread-Index: AQHZy6RghaBCfzd82UWmK9ybffj1X6/kOvnQ
Date:   Fri, 11 Aug 2023 00:39:34 +0000
Message-ID: <SA1PR21MB133502A09535F8A32073AADCBF10A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-8-ltykernel@gmail.com>
In-Reply-To: <20230810160412.820246-8-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fdad048d-8639-4dd5-810a-54f7102d8147;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-11T00:16:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ0PR21MB1933:EE_
x-ms-office365-filtering-correlation-id: b9fe2255-e10a-429c-09ea-08db9a036f47
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWl1HVtTgvJ/912jsrUxISwzzReU9E/t3oUvPjnI4ON0IaLRpfRKA4m2DYyhU+hNN469nUjnrSPm1mJKte6pubTadFrsvdNsl8LfbNoc3DWUBtiZgoBlNAirwFi4FsqPQb6ULK3gNDR4nQVmZYAKuJBGhO6uQ749pKTFRWoSbF5dQnoybDFKQEP0h4TuHNXPjm58XtEjlIfHt2WYneO7MBL3+PRLvjzP6fTzfiNxOUnVIQr4nL326SfqaX0C1a1K6baj1wkeCC3KcI/5+MFYbmXsP0yHtAzmdVrMibo7oWZRD7ZGA3NIF4tnrnbVxmVXXv/orWKG/GNF/rNvBEMD1TWrujVXPUCwSFdgy6XHo3YDSNBmuq3D4jp8/InJ+JPI96cwjMfyMiJMlg+6ha5Iy7UO/1sUZSB+6Y/uJW5vF0jHDAmVKHThWi8DEzYyscrBxW5azu0AXjcaHNWV0hQXS2B4XImlIjzx3L3PmOQdzwPuikbmRsn7dRRfpSlvV1ujXfhJnrhdLZEoV0HyXDeNDZNv3wXKOtzMVohAvnIvMFN4Fk84iCWRxkGDPAYdU8IVm1fpkBoIT9E6Y5f36o8mW3zVD8ZMeeemJxlxkTmXzbbiJKJ87QC7rWCQ6b8QBQQ4tQ+Lk6ioLHz3SV/q0rF0qthgBDw1A/Na01pDW69IIbGApRbkHA6xYm5LVGAzZt4socAyS1uMj2AHTk3axa+DWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(136003)(366004)(1800799006)(451199021)(186006)(921005)(41300700001)(6506007)(5660300002)(8936002)(7416002)(107886003)(52536014)(26005)(122000001)(33656002)(12101799016)(8676002)(86362001)(38070700005)(38100700002)(10290500003)(55016003)(82950400001)(82960400001)(8990500004)(478600001)(54906003)(66446008)(66476007)(83380400001)(110136005)(66556008)(9686003)(7696005)(66946007)(4326008)(6636002)(316002)(64756008)(76116006)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fEdGH+yAqdPApaE1uBH4PSJKLw4YY5mo4rvFE+nLnessAcFQk3PPLDm2RSZd?=
 =?us-ascii?Q?eiHsKz7XFnraMTzSUG5TU6xqrpQZMZTZEg8/DFUD8xfraS3h9e/d1GMOeIyo?=
 =?us-ascii?Q?gXuna9+lEdYuyuA7eJDlgDJRDcNbo3MS1sQEBX6TPjBuSdfEeRiFg4hHB6MK?=
 =?us-ascii?Q?KRMS3AOETteXuUT96kYNE4J05byviCtyKPJ5kgnZfcImaJw1q1J5NZdpbVQM?=
 =?us-ascii?Q?mCYtyGA+rGRVhVngxN1PeQVQW69SCX0Oaq82MMw4c2dAy0WIINVLUzni/qq8?=
 =?us-ascii?Q?kXIoCozYaB4sBcWe2y05NqTwlUlAKRbBNSL4mtfPLkaGMH7X+P5928Y0NXit?=
 =?us-ascii?Q?VwkJeinom9l+QQFVf5uP51/dqCz0BQCVb66Vn68AP0rHtKJccUgT0QtveEJ9?=
 =?us-ascii?Q?b7gOMOefOweNQzYwNn2m9GBx3l/vyAyHBRrfqkACsAXQzAWvRP4k80peLQ3Y?=
 =?us-ascii?Q?lhGxqrhGoDKM498044lb2eNSwL/x1yINByTRZ88FS10XU6sInl7uyHp4Qd5O?=
 =?us-ascii?Q?eScq86YgVUOHP4t1MRkl2fbMieISzSVT9s5n2y9/Ab9NqaP1DX5b3OsVjaG8?=
 =?us-ascii?Q?3yJnTT3edbDfQrVgOqRzdcVIb9FzMvMe6e7KPqYqoeZ8iHobnEcjc3wAIrzh?=
 =?us-ascii?Q?z9CgSAmEGRn5ToR2872ysWqKHmPuyIlC8VEPGrJd1Hv4MwsI3Udb0aCsec9M?=
 =?us-ascii?Q?ljCiB1H7UgjSO9K+teZuvSAwv1pkFWDpsJewhWcpMscJG0o5E4DvhnpmVWzU?=
 =?us-ascii?Q?mqdnwYc0UaUlTJG6IATpCCopsWmjsYcnzsIA7UUkteT+gCVWyeI2mbUPMPb7?=
 =?us-ascii?Q?ygo738bqGNLRGGK87tGgQVFcphbHsiAP2HyrSZgVsDME+9dkx6jPl8SAnBTx?=
 =?us-ascii?Q?3bYXu2jrXLtclQqT1i06DAd96zFdeusIyh5LnKsjb55Bh63Qf4FwG2WWt0ig?=
 =?us-ascii?Q?moKcfVx5tt34R5LIhZ12WkxgfSOUS86XKRbEZzvQnzzyHBtgUpgr6TZhDy4c?=
 =?us-ascii?Q?TNm5h0SAGz7J1xUrADbOfHroUSuwoUan3QBGqPNFJIZeneJXFBN94SxoerFT?=
 =?us-ascii?Q?FFuv9VeWpQ8vUMsnKRiZ5RwaEousy+toUB25zYQmX9yrsXpCGSiVR0Ak5j49?=
 =?us-ascii?Q?w90UxLa0jhUSJhaHPzv63/Fd8m0AOfgUtlEOsgvHGnLxMlPZozIs89VGJKY7?=
 =?us-ascii?Q?LOA3VxTcm3qI7zBAoDvP768YlXz4O/Mc6jnWXM1UQg+u1K6M9Z+wNpYTq/fI?=
 =?us-ascii?Q?Sj1jx/yETZtr8W+7JUDDFoo6a4qMDQA1dyEuBY/fMh1vRPlS7mAodsZqnkMk?=
 =?us-ascii?Q?ORbCqfJYwJa6rfdqmOVpIVdc2/aW/zp/HjprUi5qOKqYL2UwX2GKPLT2IA3p?=
 =?us-ascii?Q?LAailhDGFetSnWtp3Ul5NNHroCIoh9DhgEGYU2hP8Ko0Hus+w/8+c1qk71Bj?=
 =?us-ascii?Q?xV78UuiyaYfRe507oCH37BF88v28+j3RMqoaEISKU9SQZDWlU4MNjEgzfe7s?=
 =?us-ascii?Q?FP54+hZe5USvaIAOiwAmYdvWImyfyEMsb4CmoVIdAdnyAz5kFP/kJ0oyJ88w?=
 =?us-ascii?Q?wHUoO0FvPbkCvVJ5SfgIZGTlL+Bg69CXiUCI0xKv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fe2255-e10a-429c-09ea-08db9a036f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 00:39:34.5286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5elvM39fKPOTwieknDz/V9Jup2L/aPzxBIL0QCc1/dRMEgbSFfEJnCwqI61HqjTbh1d8UzWY3W1eD6qrF1+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Thursday, August 10, 2023 9:04 AM
> [...]
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> [...]
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted
> __aligned(PAGE_SIZE);
> +static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
>  union hv_ghcb {
>  	struct ghcb ghcb;
>  	struct {
> @@ -357,6 +366,97 @@ static bool hv_is_private_mmio(u64 addr)
>  	return false;
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

Should we check against -ENOMEM?

> +	rmp_adjust =3D RMPADJUST_VMSA_PAGE_BIT | 1;
> +	ret =3D rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
> +			rmp_adjust);
> +	if (ret !=3D 0) {
> +		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);

Need to free the 'vmsa' page before returning?

> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +	start_vp_input =3D
> +		(struct hv_enable_vp_vtl *)ap_start_input_arg;

The above 2 lines can be merged into one line.

> +	memset(start_vp_input, 0, sizeof(*start_vp_input));
> +	start_vp_input->partition_id =3D -1;
> +	start_vp_input->vp_index =3D cpu;
> +	start_vp_input->target_vtl.target_vtl =3D ms_hyperv.vtl;
> +	*(u64 *)&start_vp_input->vp_context =3D __pa(vmsa) | 1;

Is CPU online/offline supported for a fully enlightened SNP VM?
If yes, then it looks like we need to reuse the same "vmsa" page?
Currently hv_snp_boot_ap() always creates a new page and it looks
like the page is never released

> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
>  [...]
> +<<<<<<< ours
> +static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
> +=3D=3D=3D=3D=3D=3D=3D

Remove the 3 lines.

> +static int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
> +static inline void hv_sev_init_mem_and_cpu(void) {}
> +>>>>>>> theirs

Remove the line

>  #endif
>=20
>  extern bool hv_isolation_type_snp(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c
> b/arch/x86/kernel/cpu/mshyperv.c
> index 5398fb2f4d39..c2ccb49b49c2 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -295,6 +295,16 @@ static void __init hv_smp_prepare_cpus(unsigned
> int max_cpus)
>=20
>  	native_smp_prepare_cpus(max_cpus);
>=20
> +	/*
> +	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
> +	 *  enlightened guest.
> +	 */
> +	if (hv_isolation_type_en_snp())
> +		apic->wakeup_secondary_cpu_64 =3D hv_snp_boot_ap;

I suspect the global page "ap_start_stack" in arch/x86/hyperv/ivm.c
can be used simultaneously by different APs? If so, IMO we should
add x86_cpuinit.parallel_bringup =3D false;=20

Thanks,
Dexuan
