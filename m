Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8743F6DF7F4
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDLOFU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLOFS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 10:05:18 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32278A4D;
        Wed, 12 Apr 2023 07:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY7b/+YY7Y65/33A6U7IoFmqLyi9FbOIsKEZEnxX0fwGOpj1FaB/+M0TxzZypwHugciiWlJZap37cjcrZ5SkNYaGu/zwtR0ZtQaRm2tTc0ASP0L8StYwuy0+BN0KBqWILbyQ91QR7K4yQ1PNsZ6P+XwkookGJR/v4viZyBFfY4HqGCQzWWeRao4NllbfEAZbzBImmiFWVxyo3y+Ouwu2VVfmyhvw6I/TaeS/RwUO5njJ6l+zIIo+RLtJ9jujoJKWcF0J5Bl4KFiLNovhPD0+O7Bu9iFzCXXAB7C4WjofD0OYjBLv6qRU3zhYBxwTd0ll6TCGOWN/iEOiKN/QOXoiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wT4dAJCYFIzSu/BQ3lqECepfeTcwv8DrFMMpIT3iNI=;
 b=NwLa8ST3AfucTvyncozyyWiyD1AAlQfMTYbIty/Crli56BiIZkEsXW2ipxdo9ulLW7qZ/gYqtHRx0K4HnzfBWdxFz1kcvHD3y1xIk/dUWocQSeb+RujmbjOOY0QYxxfKgX2SAdQOcddBVXFI3K5C/rYyz6odicaIzO+fAJ5lB3/0UAmm+Nyta5XbmZVWrXQOD/o0mirqwRgnHwMUzfCG5EQ2h2BNChvQ9T/TW0T8y2xLEPSoJK4prx0Ko79FaJI6TUNKjFkVeFA0lD10ZMgqfxJI4kfutkGVt/uvQ4pYHg6ycNFu7aXn0LCe8QBpfIS6gYK4ULd5bvUOlG7tAyKcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wT4dAJCYFIzSu/BQ3lqECepfeTcwv8DrFMMpIT3iNI=;
 b=Ec/5masOQqcdV7fqyepdgcAfiNY3HXB+agDZMuiDY8E9CXjqT9z217Q7mgCMQdB4sKFIXH2ylW8epf1+MaPexlA4fMf/olfkLBx3kDiIbOzmC3pqent4Il5nyQy+v5sBdB+80kPH8bhjdBUPS2/gFLwau4c5QvNVXsDHpGe6uP0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1323.namprd21.prod.outlook.com (2603:10b6:5:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Wed, 12 Apr
 2023 14:05:10 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 14:05:10 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v4 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v4 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZaluiU1mCuu/uekyGswn5O4Hjua8nuTuQ
Date:   Wed, 12 Apr 2023 14:05:10 +0000
Message-ID: <BYAPR21MB168861A32D07E5D2EB0A80B0D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-6-decui@microsoft.com>
In-Reply-To: <20230408204759.14902-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9af51bf1-775f-4d61-9219-26878e137693;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T13:59:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1323:EE_
x-ms-office365-filtering-correlation-id: ba9d42ec-129a-4c63-c121-08db3b5eeda1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXTfOqDBTWy2WBgmf1CLwEJ7FL+oFmx9LWMlaOE0NzgeUUkaAXgOQGRicYKL7k5K4p35vkSZo4DU3iz+bCbEsi4BHiRxfVdUING6wsz0XOT6JVDte+oe1IEEBiquS7DTSxUG9SrkwiXlzTZGmEZLpdLB4wkiVAIJnuprexeV83wBgqyiyg3EdA4VMIzgYnEcya3J6EZ/jJ3yxeEAHoaJsjJkrPVeOtKHFVMj6TGv8eBzQ+JrLW0XZagJLovP0iBJ7kUpqMVTyjgPqVroQymfJ4l0Xtss3aotIib2/sb1lX5US+kTstHAsGwLTT7bGWD3jZAk32ql0kTZUruUzu34kV2GbS13t2HScsajCbdpRx+LePdFHFCcpwBFvomu7vvAKMBBj+ktndP9mTaiTQV8YA3u+dCeHqFRvkD4n7ebhyCEiabz9bGUHMTdibqyc9vIH0Esrz5eX/O15uNljVmEYWlDJ/Dyaj9DruBdhTzwv87ucy2cmwdXoWo2X2W2prExi91jRxY3Pc8xRKdbO/QshyEFoEGPmpeSlpIXbzEJbtutEA5mwZCgeRI+BRW4VDOwF+pp3en5Qbgbo8gegdjlDXR4AlfjUWIcSQFzbZiyvdelFtb5kaYjX1R3Ul1r1N/aT6yNCA4YTVwW3ILKHx+aHv6ITzDBnGAPdPV6hjV9ZTenaVoRmFh3Es2ltHsBCsdx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199021)(316002)(38070700005)(33656002)(7696005)(2906002)(10290500003)(478600001)(71200400001)(110136005)(786003)(55016003)(8936002)(921005)(122000001)(52536014)(64756008)(76116006)(66476007)(66446008)(66556008)(8676002)(66946007)(82950400001)(82960400001)(4326008)(54906003)(186003)(83380400001)(38100700002)(41300700001)(5660300002)(6506007)(26005)(9686003)(86362001)(8990500004)(7416002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CeIPsI8CH7+4AI+8EUbLAhtGCmM0UW9usqYYvaEmiT1FgTWj2uHxILQDIVgN?=
 =?us-ascii?Q?kaKhYEUUiSCUnamOa7UXA57+IN6OiRysSio42wsqpKoA1rbATlDAaKniTunK?=
 =?us-ascii?Q?L+8T7wjLT1LN4bdFDCBS48ASdCv02KX8CYa9RiUGy481Fig798XiKrxPoc/8?=
 =?us-ascii?Q?OYR+eVRY+nsvcYCydzinrYJ3WTBbzrjmvYFYz2BbCRzlcU/77yRL/X8wslSw?=
 =?us-ascii?Q?+rGe7h3hCG9mFuz8p7V4Bb91b5CAmi/qj62ccF0XKq09i1mOY2v/1IWSIWoJ?=
 =?us-ascii?Q?wwAZrI5V9XMRM/gRS+nm65EHGjEyhQW+Zhmhizi/f2yIRuuvld3XO2Lagqna?=
 =?us-ascii?Q?QShjbTYJYTwZ8vXLrbFw7sbqeyYOcMdzZpdJQqclu/bMk6qdWP+TfZHdnYv5?=
 =?us-ascii?Q?RyPO4ENj/JFtwQy6AHWbNGh3kpdLa2xrRxL+igvHaWzNuTK3NnB37gBlBW5/?=
 =?us-ascii?Q?rxGzOqFLPxSktsIHewfL91aKhAjx9K3UTFG7c876o0DpF80wK/M0/5qpRv56?=
 =?us-ascii?Q?vgcfz5lOuBAQ/BB005l6aam6SoVoxXsK1nUYmtRZoK4hsd1NZXirot6mEMaH?=
 =?us-ascii?Q?PJKTjOPg3SKodsYMwHWENCIrDPV7pu3VtnQtgVLUz45yhAwBGXwCI1Z3dUx5?=
 =?us-ascii?Q?ooJik4oqWqM0+jqAIsY2NsLQDKXf3tzz7iKeckWGSsuaIWyOGQ5oSjvPLnVa?=
 =?us-ascii?Q?zqtr6g7PIYip+T8mmS2VeHxtOoJD9pbTcOaM5XlpcNtZ/KrEc/33fUsd+ok7?=
 =?us-ascii?Q?nw/sUGw93N/qRYM0gEvAqHMCuy6W33O+9GMemUM1EcHtT221YfMHd8il3hJg?=
 =?us-ascii?Q?Bk9S7UXywUwUG6TX3Jwlg9An6jK18EVFUNsqW7FOOZHdXthzHISIteZGhDc8?=
 =?us-ascii?Q?EhfbIgy4IeC6WzLLtThQZjEJWwolEyW+j6wCdHPCMoJrTCGMqLus736U/Sut?=
 =?us-ascii?Q?gk33xHham+pNOrw5O8/usydxEx4yQL8xPtQqg+KXB3EVVDYADtp/V46tWXib?=
 =?us-ascii?Q?YtSmzq7ozSViMGgg0Z81szTiid+mZGSdawieLYkNPQwqmgnHyCSWXeIG5HTF?=
 =?us-ascii?Q?DjnZ+cgpR8tZeYEAd1cNueeSIvsYqjE/+y+S0umhfNO1yUbxOTb71Fkd2ti6?=
 =?us-ascii?Q?ev3zN0NrMiFXJU6Aayb1iZZILW2465Pex3N8Qu8nbC8UkbGGD0auz+b6/XRF?=
 =?us-ascii?Q?zA6Fk8R9f8Avoxf+QXHebD4f2xjK008ODxqL2gV1OXu4sjHVvhSAaqL03/8O?=
 =?us-ascii?Q?tg2C8QdyT0gWEEI2b2p+0xCAzzQUa8jPmIQe1zseVmsi54ieJ9nml5aNX2rS?=
 =?us-ascii?Q?ysC3wvrKvI39GUEzsTiG/Jaa6UBSlODRqo4pFrapSpvUTXcSdNMfFiFKXDJf?=
 =?us-ascii?Q?Ddcj+O0aN/ksD/W60D1ibRkkMYszxHZtr+KNmt/UKkZx8sOiAINg7LfYMbyg?=
 =?us-ascii?Q?fL+UkIMZjHrmieC0BzS73CmTPe6ToCFLbeM0EedK/1UEk2WOAduSo8e2lWKx?=
 =?us-ascii?Q?0jgnep+gs+zIzkZ5MgQHvfgnsc9X16dbpxq7GBVEeF2tv+D4gowahDpNrsIj?=
 =?us-ascii?Q?lO2ToLB/TudPDI+SATPy6ES/NKwa9nM6qT0KFa4Pe6m7XMauU0FdQkt06EnJ?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9d42ec-129a-4c63-c121-08db3b5eeda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:05:10.2298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUORJ+6PdWXv4oeCnggU7NV9Gyqjjz3AWnHJupXUUqYIaaie++2o8+zQausx4ZPNMuZ2TGR6kexg91cd3sz3/36399tLXiK2hoNn+4pd61Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 1:48 P=
M
>=20
> Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
>   No need to use hv_vp_assist_page.
>   Don't use the unsafe Hyper-V TSC page.
>   Don't try to use HV_REGISTER_CRASH_CTL.
>   Don't trust Hyper-V's TLB-flushing hypercalls.
>   Don't use lazy EOI.
>   Share SynIC Event/Message pages and VMBus Monitor pages with the host.
>   Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2:
>   Used a new function hv_set_memory_enc_dec_needed() in
>     __set_memory_enc_pgtable().
>   Added the missing set_memory_encrypted() in hv_synic_free().
>=20
> Changes in v3:
>   Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().
>   (Do not use PAGE_KERNEL_NOENC, which doesn't exist for ARM64).
>=20
>   Used cc_mkdec() in hv_synic_enable_regs().
>=20
>   ms_hyperv_init_platform():
>     Explicitly do not use HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED.
>     Explicitly do not use HV_X64_APIC_ACCESS_RECOMMENDED.
>=20
>   Enabled __send_ipi_mask() and __send_ipi_one() for TDX guests.
>=20
> Changes in v4:
>   A minor rebase to Michael's v7 DDA patchset. I'm very happy that
>     I can drop my v3 change to arch/x86/mm/pat/set_memory.c due to
>     Michael's work.
>=20
>  arch/x86/hyperv/hv_apic.c      |  6 ++--
>  arch/x86/hyperv/hv_init.c      | 19 ++++++++---
>  arch/x86/kernel/cpu/mshyperv.c | 21 +++++++++++-
>  drivers/hv/hv.c                | 62 +++++++++++++++++++++++++++++++---
>  4 files changed, 96 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index fb8b2c088681a..16919c7b3196e 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -173,7 +173,8 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int
> vector,
>  	    (exclude_self && weight =3D=3D 1 && cpumask_test_cpu(this_cpu, mask=
)))
>  		return true;
>=20
> -	if (!hv_hypercall_pg)
> +	/* A TDX guest doesn't use hv_hypercall_pg. */
> +	if (!hv_isolation_type_tdx() && !hv_hypercall_pg)
>  		return false;
>=20
>  	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> @@ -227,7 +228,8 @@ static bool __send_ipi_one(int cpu, int vector)
>=20
>  	trace_hyperv_send_ipi_one(cpu, vector);
>=20
> -	if (!hv_hypercall_pg || (vp =3D=3D VP_INVAL))
> +	/* A TDX guest doesn't use hv_hypercall_pg. */
> +	if ((!hv_isolation_type_tdx() && !hv_hypercall_pg) || (vp =3D=3D VP_INV=
AL))
>  		return false;
>=20
>  	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index f175e0de821c3..f28357ecad7d9 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -79,7 +79,7 @@ static int hyperv_init_ghcb(void)
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	union hv_vp_assist_msr_contents msr =3D { 0 };
> -	struct hv_vp_assist_page **hvp =3D &hv_vp_assist_page[cpu];
> +	struct hv_vp_assist_page **hvp;
>  	int ret;
>=20
>  	ret =3D hv_common_cpu_init(cpu);
> @@ -89,6 +89,7 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (!hv_vp_assist_page)
>  		return 0;
>=20
> +	hvp =3D &hv_vp_assist_page[cpu];
>  	if (hv_root_partition) {
>  		/*
>  		 * For root partition we get the hypervisor provided VP assist
> @@ -398,11 +399,21 @@ void __init hyperv_init(void)
>  	if (hv_common_init())
>  		return;
>=20
> -	hv_vp_assist_page =3D kcalloc(num_possible_cpus(),
> -				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
> +	/*
> +	 * The VP assist page is useless to a TDX guest: the only use we
> +	 * would have for it is lazy EOI, which can not be used with TDX.
> +	 */
> +	if (hv_isolation_type_tdx())
> +		hv_vp_assist_page =3D NULL;
> +	else
> +		hv_vp_assist_page =3D kcalloc(num_possible_cpus(),
> +					    sizeof(*hv_vp_assist_page),
> +					    GFP_KERNEL);
>  	if (!hv_vp_assist_page) {
>  		ms_hyperv.hints &=3D ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
> -		goto common_free;
> +
> +		if (!hv_isolation_type_tdx())
> +			goto common_free;
>  	}
>=20
>  	if (hv_isolation_type_snp()) {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index a87fb934cd4b4..e9106c9d92f81 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -405,8 +405,27 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP)
>  			static_branch_enable(&isolation_type_snp);
> -		else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX)
> +		else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX) {
>  			static_branch_enable(&isolation_type_tdx);
> +
> +			/*
> +			 * The GPAs of SynIC Event/Message pages and VMBus
> +			 * Moniter pages need to be added by this offset.
> +			 */
> +			ms_hyperv.shared_gpa_boundary =3D cc_mkdec(0);
> +
> +			/* Don't use the unsafe Hyper-V TSC page */
> +			ms_hyperv.features &=3D ~HV_MSR_REFERENCE_TSC_AVAILABLE;
> +
> +			/* HV_REGISTER_CRASH_CTL is unsupported */
> +			ms_hyperv.misc_features &=3D ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
> +
> +			/* Don't trust Hyper-V's TLB-flushing hypercalls */
> +			ms_hyperv.hints &=3D ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
> +
> +			/* A TDX VM must use x2APIC and doesn't use lazy EOI */
> +			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
> +		}
>  	}
>=20
>  	if (hv_max_functions_eax >=3D HYPERV_CPUID_NESTED_FEATURES) {
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 008234894d287..22ecb79d21efd 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -18,6 +18,7 @@
>  #include <linux/clockchips.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/set_memory.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -119,6 +120,7 @@ int hv_synic_alloc(void)
>  {
>  	int cpu;
>  	struct hv_per_cpu_context *hv_cpu;
> +	int ret =3D -ENOMEM;
>=20
>  	/*
>  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> @@ -168,6 +170,30 @@ int hv_synic_alloc(void)
>  			pr_err("Unable to allocate post msg page\n");
>  			goto err;
>  		}
> +
> +
> +		if (hv_isolation_type_tdx()) {
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC msg page\n");
> +				goto err;
> +			}
> +
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC event page\n");
> +				goto err;
> +			}
> +
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->post_msg_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt post msg page\n");
> +				goto err;
> +			}
> +		}

One other comment:  The memory for the synic_message_page,
synic_event_page, and post_msg_page is obtained using get_zeroed_page().
But after the decryption, the memory contents will be random garbage that
isn't all zeroes.  You'll need to do a memset() after the decryption to get=
 the
contents back to zero.  Compare with Patch 6 in Tianyu's fully enlightened
SNP patch series.

Michael

>  	}
>=20
>  	return 0;
> @@ -176,18 +202,42 @@ int hv_synic_alloc(void)
>  	 * Any memory allocations that succeeded will be freed when
>  	 * the caller cleans up by calling hv_synic_free()
>  	 */
> -	return -ENOMEM;
> +	return ret;
>  }
>=20
>=20
>  void hv_synic_free(void)
>  {
>  	int cpu;
> +	int ret;
>=20
>  	for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> +		if (hv_isolation_type_tdx()) {
> +			ret =3D set_memory_encrypted(
> +				(unsigned long)hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to encrypt SYNIC msg page\n");
> +				continue;
> +			}
> +
> +			ret =3D set_memory_encrypted(
> +				(unsigned long)hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to encrypt SYNIC event page\n");
> +				continue;
> +			}
> +
> +			ret =3D set_memory_encrypted(
> +				(unsigned long)hv_cpu->post_msg_page, 1);
> +			if (ret) {
> +				pr_err("Failed to encrypt post msg page\n");
> +				continue;
> +			}
> +		}
> +
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  		free_page((unsigned long)hv_cpu->post_msg_page);
> @@ -225,8 +275,9 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		if (!hv_cpu->synic_message_page)
>  			pr_err("Fail to map synic message page.\n");
>  	} else {
> -		simp.base_simp_gpa =3D virt_to_phys(hv_cpu->synic_message_page)
> -			>> HV_HYP_PAGE_SHIFT;
> +		simp.base_simp_gpa =3D
> +			cc_mkdec(virt_to_phys(hv_cpu->synic_message_page)) >>
> +			HV_HYP_PAGE_SHIFT;
>  	}
>=20
>  	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> @@ -244,8 +295,9 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		if (!hv_cpu->synic_event_page)
>  			pr_err("Fail to map synic event page.\n");
>  	} else {
> -		siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->synic_event_page)
> -			>> HV_HYP_PAGE_SHIFT;
> +		siefp.base_siefp_gpa =3D
> +			cc_mkdec(virt_to_phys(hv_cpu->synic_event_page)) >>
> +			HV_HYP_PAGE_SHIFT;
>  	}
>=20
>  	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> --
> 2.25.1

