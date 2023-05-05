Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE7F6F8697
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjEEQWs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 May 2023 12:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjEEQWq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 May 2023 12:22:46 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCC418FF6;
        Fri,  5 May 2023 09:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrPLKdaTOUQr8TMOfR4pFq7tGdKFunAlgbS/kf2FZMKhqHmMdEdd5MO+8RWVOSNe0YK3prFSP5Ixmn/o9zQAF/GIqAkCKvt8sJaQnrS0k8wl3jnWXaTKL3ALEU4YT3KUMDbNEYNM02k/et4hbiyu/2EVk+gJr2LCKY4gGli5Hx8zVibFyuY1O3pSPtnhy8IWNS1/VjQ4XEtfqXhaUnzAs6Bm07HULaYNloiZwye3tErgB2qGuEM/Z4DvCJKg9HuYjOeNLehtbhv6mCBquh4TMZK954LHvafS6HzKPu/n5SUFKhbywWIae1mlYfyHrQ/xLAsqgYk2fWCPP4PhrArziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmQAM5R3EP4RF3cfH/IdS0AJZ0l8bvoMwfmfJPzIp6Q=;
 b=jcCMGEM6IuS0WA2ZAGXM3f3IHupYKwUgemceWIyzUF51HIQEVud7vFxXVRV9jkPWg/Kx/ufOPnvKTjXwl9JbD3JJ3jMgslVXyXc8khSxjvXSBpRUp27ZBdTWiHzzgDYKDTMIUuEhOiv0t1VOABPX8t66Uu1JnsQdQ1/sdWpptrdwaNe9KSCCMY/ptbZd+p8e3z7tl2cwzUKm9gA9aA6II/d3kip5yRjLuwGDeVwECLhiZIN4eUilAAbc1fgYQSCL1fkrxbJvyQLSdbFKV51PlpDGFCqSW6hGvq5LerRnf2b/6DN5s/ZKuBIAwN8sbMeiDET/UnpP8qB9SPmDpoA65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmQAM5R3EP4RF3cfH/IdS0AJZ0l8bvoMwfmfJPzIp6Q=;
 b=Q0nHrwFD4Ow8A8l9z5PxgQ3qmIqX+kpR+n/R9xuA6l/4m4ORgb/703ySFWwHWOkE9CRam7pxbu71Ip+cZGltn+pm2fIZCx50u1lOg2f94umlo7NdGd8DxoMjzDD+oeqxPbNCtvGYhqbiCJ5zulWnuQXh9/+BNTeARdmMYmpKdzs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3139.namprd21.prod.outlook.com (2603:10b6:208:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.7; Fri, 5 May
 2023 16:22:41 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622%4]) with mapi id 15.20.6387.012; Fri, 5 May 2023
 16:22:40 +0000
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
Subject: RE: [PATCH v6 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v6 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZfttz9He9zHooa0q8pB8usY0kq69L3DoA
Date:   Fri, 5 May 2023 16:22:40 +0000
Message-ID: <BYAPR21MB16888F04BF0761A44396FF90D7729@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230504225351.10765-1-decui@microsoft.com>
 <20230504225351.10765-6-decui@microsoft.com>
In-Reply-To: <20230504225351.10765-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ca619e06-5cc5-479d-93c2-cdb8176563ea;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-05T16:16:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3139:EE_
x-ms-office365-filtering-correlation-id: 3aa9a957-ca90-44f4-3024-08db4d84f2d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HNCLl8/BJPxPz9hoZvTHstyV5T17UNmHGA3quHf3kDmwnlGED247dD3b4RGJgmt36P6yMmvVmWRD2QXkCt9CUPDQ+YSevkZV6WQWKQ/tsSYdpQ8XOJYzEbGHaWS3JOidUXb/14OZ4524378VLAc/MqgjnYS0djWYy2YLaeGVwia7UQN4AuyNVx8TQJ0sXCGT4HiQmTEgW7s6DdVdR5WEfMkG1o6KrFZKsM0iaM2/kykD/S6+AV53dYy2c9QGrP5Z+2AkjxgzgfsL6HWN/SWcNz9dc4yZaZXC7orCcC9qu961qh6bNGVBl/AvmTLHxuhLJO7mZecumkrFgKONzhFtCrWj9TWvCpmnZcNKzKBOSyAl+z60sXquwHALdPqHg+yOKKDS/oqljDskcQOmYfIMnueta2Los+BrsfEKqQCcob0FmXNHooG2I7dGpWsrNxiWNSMLd0fIGMMXbF4DdGcHPA7Oyn1GDGexNMyQVllRPJ2/X6AiHqW8/TUo+ac61+mKL5Eh6XGEfoSXQpNx6Y0VRa6bYA+Q24IjVr0yWWNe9HDgllg+d9qFBiRN2Y2u6daWjkQInV9cI3wgpduvTAnSmzptJQIZxfDu9NzTE0SuOTsJtg3fhccJACNHbUDwVMTRKDR7L83ZrMz+5pZa3syQTeuIoQkzoKSLoYqf5oWXNrkHwWT4oHZpXsCgl7upKdwy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(82960400001)(122000001)(2906002)(921005)(38100700002)(7416002)(55016003)(52536014)(5660300002)(8936002)(8676002)(33656002)(86362001)(82950400001)(8990500004)(38070700005)(71200400001)(7696005)(478600001)(110136005)(10290500003)(9686003)(6506007)(26005)(186003)(54906003)(83380400001)(107886003)(41300700001)(66446008)(64756008)(66476007)(66946007)(76116006)(66556008)(4326008)(786003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n1vrJdRh8w5lvEK07iRPi0fiUNgCae3X93/tBFCrqtk7blQbDDM77uU2UkJn?=
 =?us-ascii?Q?4KoGJMZ6rdmHjybWLrcu+QF8ZRy3sJeHTkjFN+hAdwI6rIpR/OlyLp4ADHZr?=
 =?us-ascii?Q?tyICHSF1m7/kgXdvW8yhJa5JPtqXYJ8kZHYsnPqiL71Nk47fJU0fVDQc7zeA?=
 =?us-ascii?Q?crs1xXr+7nt/AXX9uObHFNsxWIGg+QhYobsksyUh7uj7Q+bOQ+1y9XaeOk0+?=
 =?us-ascii?Q?ReXhJN6d2CRd0NMta4Q6Xcg0qOMKgs9JyylWJA0Y37FHYSdbGAFJTj0MZRNt?=
 =?us-ascii?Q?HzZoznBoWhvzn8AFBdw9kUQ4Dw6r5EDS5LkUNVB8EwtcVR+1p32U/b2tv8RG?=
 =?us-ascii?Q?TPFJ4nQ9J1AcUevcvpjOtekVnmcc8KO7nanjH/UQ9MtRjJxP0Sm+pqVrzdgN?=
 =?us-ascii?Q?JiPjwy+IJwPZh4qcEHWZY0VDZan3KhWYVZNWkxqsmdg6s9FO8ZpFoFx0I2PF?=
 =?us-ascii?Q?Q3Hcqy5C+a4sUUITXspM3WQEsdf5s7WBTkjT1Z6w30TvhVavrtG7qGLuXTli?=
 =?us-ascii?Q?prSxJ21IESuXrn4iEOAVqgJhejtoHBStL7d0hCdZI7ot4l+HRlLivlsf4DFO?=
 =?us-ascii?Q?g6P8fzmEWCEYDnM0UOSAhcZSpL9/+uTQo/W8demx99cZy2CiSRVlOnNQaLUq?=
 =?us-ascii?Q?jnrg+kjK6es9fiaNjs+BlmOsd17tUW/iKdfSEnLOYSYoHvkLT1VIiSIveu3e?=
 =?us-ascii?Q?DGhZqyV/jb/ZDtPCwd3oghhdTemMm8StzhX9T/BELy9WqtvKAJzXZf5tdjwe?=
 =?us-ascii?Q?RE8+Pbl6inSY2AHlyco6B+nnqeY/wXvLnFZlypFo7jV/P9wxFA8vUTKm8QU6?=
 =?us-ascii?Q?G84iet3+gnQt591qHwQhp/vqMrfC30T3kEibBj4l5Q4BkW0DGOGlKv1I5/as?=
 =?us-ascii?Q?7TyqZeybPGujuZCJq/pg6zqbva1zgjXV2vJ6V463WWJzMF4sABQRbk1H+PJd?=
 =?us-ascii?Q?csmzh1TwLaAU04f9xPqx5wGDEspA0GWCxP39XIzGQYCAaaMNO2UuFgKCako3?=
 =?us-ascii?Q?a+PauDOLFZJ/Y+dhpLWWoU3Mov/HujJQIGieuX/EDoV0tLAZ7xntoicb3pBh?=
 =?us-ascii?Q?PvsBDziJPbhY2XCv9Tjqv/IptfF1N8FPGQDevTGMajN+ScnT906vQE1vGrJB?=
 =?us-ascii?Q?iF6BHEZ9hkoFQmP2bj08rGwnowKq8hS5lO5vWurmyB5uDDXJ9gpYl9OeQR8k?=
 =?us-ascii?Q?+kK7EIX/3hpegN2W6Gpp112J27fhuQv16+fqqY9F9qr0uvIgHSczPjvvtTNz?=
 =?us-ascii?Q?O4JQRzymv9aHFmokIctG7wDFx+m0WFEhJXgRwc336qGbjy1imTPgC89aQQma?=
 =?us-ascii?Q?+z11b9Kps4SSwK0Zwvsc6J3OTLxDNXhJgzrgjo+T7AN4K+LK/nUa4z9IJPcv?=
 =?us-ascii?Q?1246+66KTxdAjyFbGpRnqHQOpThw+24D8O5V1ajwOjNr9Ha4UoYzAbjlp7qp?=
 =?us-ascii?Q?8oDqrpDB4IPKzPZkmgW8z47nCAV6dTuQ/A2kqwg2ssoWECcVRveQvxi5IXEH?=
 =?us-ascii?Q?Jui7G/QyH0pJHlthzfs/pmkBUZg+z1hlKpTGy68cBehGmR6risyektM1STcq?=
 =?us-ascii?Q?xJwCgWihFri5c2vTcBHx4ubUwYljhaGgZ8bMFByuyOYEr+dnzfYJL2Wj5pxf?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa9a957-ca90-44f4-3024-08db4d84f2d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 16:22:40.8013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVvxprO2XXi1R01JAD9GFsrwDaAa83KdMJ2S6Tg9coxhmbvpBcbDx37BdevhQQNZpC2jvY0mou3u3INPO+nOCDeZk1DQynyKCc1EiZWjauQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3139
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
>=20
> Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
>   No need to use hv_vp_assist_page.
>   Don't use the unsafe Hyper-V TSC page.
>   Don't try to use HV_REGISTER_CRASH_CTL.
>   Don't trust Hyper-V's TLB-flushing hypercalls.
>   Don't use lazy EOI.

Nit:  Actually, you overdid the cleanup. :-(  The line in v5 about
"Share SynIC Event/Message pages" was correct.  It was only the
part about VMBus Monitor pages that no longer applied.

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
> Changes in v5:
>   Added memset() to clear synic_message_page and synic_event_page()
> after set_memory_decrypted().
>   Rebased the patch since "post_msg_page" has been removed in
> hyperv-next.
>   Improved the error handling in hv_synic_alloc()/free() [Michael
> Kelley]
>=20
> Changes in v6:
>   Adressed Michael Kelley's comments on patch 5:
>     Removed 2 unnecessary lines of messages from the commit log.
>     Fixed the error handling path for hv_synic_alloc()/free().
>     Printed the 'ret' in hv_synic_alloc()/free().
>=20
>  arch/x86/hyperv/hv_apic.c      |  6 ++--
>  arch/x86/hyperv/hv_init.c      | 19 +++++++---
>  arch/x86/kernel/cpu/mshyperv.c | 21 ++++++++++-
>  drivers/hv/hv.c                | 65 ++++++++++++++++++++++++++++++++--
>  4 files changed, 101 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 1fbda2f94184..b28da8b41b45 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -177,7 +177,8 @@ static bool __send_ipi_mask(const struct cpumask *mas=
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
> @@ -231,7 +232,8 @@ static bool __send_ipi_one(int cpu, int vector)
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
> index f175e0de821c..f28357ecad7d 100644
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
> index 2fd687a80033..b95b689efa07 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -404,8 +404,27 @@ static void __init ms_hyperv_init_platform(void)
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
> index de6708dbe0df..af959e87b6e7 100644
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
> @@ -80,6 +81,7 @@ int hv_synic_alloc(void)
>  {
>  	int cpu;
>  	struct hv_per_cpu_context *hv_cpu;
> +	int ret =3D -ENOMEM;
>=20
>  	/*
>  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> @@ -120,9 +122,42 @@ int hv_synic_alloc(void)
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (hv_cpu->synic_event_page =3D=3D NULL) {
>  				pr_err("Unable to allocate SYNIC event page\n");
> +
> +				free_page((unsigned long)hv_cpu->synic_message_page);
> +				hv_cpu->synic_message_page =3D NULL;
> +
>  				goto err;
>  			}
>  		}
> +
> +		/* It's better to leak the page if the decryption fails. */
> +		if (hv_isolation_type_tdx()) {
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
> +				hv_cpu->synic_message_page =3D NULL;
> +
> +				/*
> +				 * Free the event page so that a TDX VM won't
> +				 * try to encrypt the page in hv_synic_free().
> +				 */
> +				free_page((unsigned long)hv_cpu->synic_event_page);
> +				hv_cpu->synic_event_page =3D NULL;
> +				goto err;
> +			}
> +
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
> +				hv_cpu->synic_event_page =3D NULL;
> +				goto err;
> +			}
> +
> +			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
> +		}
>  	}
>=20
>  	return 0;
> @@ -131,18 +166,40 @@ int hv_synic_alloc(void)
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
> +		/* It's better to leak the page if the encryption fails. */
> +		if (hv_isolation_type_tdx()) {
> +			if (hv_cpu->synic_message_page) {
> +				ret =3D set_memory_encrypted((unsigned long)
> +					hv_cpu->synic_message_page, 1);
> +				if (ret) {
> +					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
> +					hv_cpu->synic_message_page =3D NULL;
> +				}
> +			}
> +
> +			if (hv_cpu->synic_event_page) {
> +				ret =3D set_memory_encrypted((unsigned long)
> +					hv_cpu->synic_event_page, 1);
> +				if (ret) {
> +					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
> +					hv_cpu->synic_event_page =3D NULL;
> +				}
> +			}
> +		}
> +
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  	}
> @@ -179,7 +236,8 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		if (!hv_cpu->synic_message_page)
>  			pr_err("Fail to map synic message page.\n");
>  	} else {
> -		simp.base_simp_gpa =3D virt_to_phys(hv_cpu->synic_message_page)
> +		simp.base_simp_gpa =3D
> +			cc_mkdec(virt_to_phys(hv_cpu->synic_message_page))
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> @@ -198,7 +256,8 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		if (!hv_cpu->synic_event_page)
>  			pr_err("Fail to map synic event page.\n");
>  	} else {
> -		siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->synic_event_page)
> +		siefp.base_siefp_gpa =3D
> +			cc_mkdec(virt_to_phys(hv_cpu->synic_event_page))
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> --
> 2.25.1

Commit message nit notwithstanding --

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

