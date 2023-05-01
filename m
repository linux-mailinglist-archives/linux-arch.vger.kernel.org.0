Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439DF6F350E
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjEARcv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEARcu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 13:32:50 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E974125;
        Mon,  1 May 2023 10:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmu62xpw6SD4mF93hvnhmDR8EFybFMT0cIlCqy/q59EBnrSkZ27CGksS13/NaEYv6iCb726xFpAq86PskUGW5g5pnCi+kHmnn9BTt6kuIjfYTiqcfNttQWnBPqHBfNasUw+HEIUfgxb7+wMlzzOkKE9LjZPINKNn4jhKitQSWgLYb5GAMF7SfA0tmPHGPcCCrNWlAdM1+1NsRUAaT2lXDtqrW9Y7Us6nZ02cH7qrjgcvkmnfHCM+6rDjNAzsblOIwyuHIqGVE+lbq+g6L/XdfnghIaobbkkG2uTnle5X6Aqm6k/pa8ykXA4lMaKj3Itjs3kyvpDzCLZPMuzKnc79eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ilLeGTrdQ0aPUqpClqDA/l/W+My0Pnv74j7EgvgZK8=;
 b=IR8nOSnsUmcQ0HmCotxlMmvAR7wCusWUd2DHwk00LyQ5TwKTop7tf9Byh2qfgryUV4he3SPYSSracfM/GdvAsfJHvrEVl9U0l0/OJJ8yIo2QgaUKC77KCBCZ9MZ0JRPqIebmFwrbI89+9ULkex+StbnqccmFhgXpTkpCb6OBqrLYRsTMqzGbt0bHdxBbmkQPizn9w5oQ5F7iluhxHgchFpj0WGyco3AiDJr+YN67D6EWrq/yk8MW+S7l+s6IhhlZj68pBKrbD0wdMW7UAbapcEyXccAVbC3bPUbpb259hFPHQKsg8wYgRZYAC2AJLVnjOevIwiwT4oACOX71tiik9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ilLeGTrdQ0aPUqpClqDA/l/W+My0Pnv74j7EgvgZK8=;
 b=QHxX2Ioh4aFB/HudcNeWZ772Eu8X5b2mqMAF6RzhT2xNWJTXLHkKaEq+F3DHo8O9PPrU45BmVX+UM89CH68ORscnmwDndKxFoCFEIiGU2z5Z53czxi7A9dBk8670NLEdHhfL2UbEBwIhM3J8SJxjAgOYuXgdG6X05wCykOkQXgo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3415.namprd21.prod.outlook.com (2603:10b6:208:3d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.5; Mon, 1 May
 2023 17:32:39 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7%6]) with mapi id 15.20.6363.018; Mon, 1 May 2023
 17:32:39 +0000
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
Subject: RE: [PATCH v5 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v5 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZdMDlgRiCry573UqDSIN3qcYRLa9FtKkg
Date:   Mon, 1 May 2023 17:32:38 +0000
Message-ID: <BYAPR21MB16888DA20245DDBC572A2240D76E9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230422021735.27698-1-decui@microsoft.com>
 <20230422021735.27698-6-decui@microsoft.com>
In-Reply-To: <20230422021735.27698-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe447994-baa8-4b2f-a2ae-c9a8aadd7e33;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-01T17:05:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3415:EE_
x-ms-office365-filtering-correlation-id: f54947bb-c78f-45cb-605e-08db4a6a0f6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kXVOtNAZB0kayxAWX3ZL0gYUStaJ56TNkqR0A9UTf+9buPjXJubYIUfNOXG+Gx6gut8Nxw56h56V1/+GqtEJI6MpwTrnUY1up/RKueCBuixPunHOgKr5gB/JBR+sYZ7788dWLbhrXUJYJ79pMPlIDBjgUj8Y4UZrRYwDJ04+7rLqWmt0FknO6oc08MB0WkrXJClRxUpPWmmN18l4mZSfE83zxp0c54igi9I8gOjPrEL9HIideYdOxzVe32IlTMEuGnKZNWXBiptU55JLP2oaxGo7AjvsEmEbVp2QfLuXEUX5rKVBgw6f89DHGFFfJhjsDqcSaQTiQ8AD40JEUm1bd7Nxg40cCeSr5ZUu+huOeLTzP9NX17H09Qu297aLgI+dNaP1VBw27bqZQXSUyxUta/sGm7UPHqNpgHo28OzOBPXaQ8oiX3CxSrgJbVZ+yGBvhudmfsd5+Ouqst4kPEMeIC/epfsB9imVZPoy1Ozat88pVub7PgmiewgFWiCYTKfNy3C/y2k77j6fVgM5x7S+wWDVWleY2AhiRe8DSx/YjWrF6Ol2/nYxazTSm4fRToui7v2vvhMoGOhT3v/AjeA4HoEFrv+IoM9O65fgqxU1kafpNUPmleLeTKP0T7Q5Hx2VGR20JBV4n5Y5aNq/mujHOUFnFINwTJ8zn2rmoFGy/LIsXoM4AjfSy/lOsOn6i31A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(38070700005)(8936002)(8676002)(107886003)(26005)(9686003)(38100700002)(6506007)(8990500004)(33656002)(10290500003)(478600001)(55016003)(7416002)(5660300002)(186003)(52536014)(316002)(786003)(2906002)(71200400001)(54906003)(82960400001)(82950400001)(86362001)(83380400001)(7696005)(66476007)(66556008)(64756008)(66446008)(4326008)(66946007)(110136005)(76116006)(41300700001)(122000001)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ag6OnbXjBJYdRTAQClreRTKBZPgEVAQ3cQYI79gO1f54tDqIscPkTS5L2+Br?=
 =?us-ascii?Q?kT1WKFgiCry0REQBGBBxk/6jRgL+68ZqDu+6stgncpFvmCTvzrVAULCj1Ykn?=
 =?us-ascii?Q?evuaAx0LnZqNNZpLf8Mn6QbiPRN1EnS5DVvqT29s+oj9cv8Eq5pNNVa82N9M?=
 =?us-ascii?Q?bJ21kQKlcClj6azQhixf7a81c2W7Knt2ZVua4j/Jm6jl7Nm+1t4VUcQsqPCA?=
 =?us-ascii?Q?nLp65JwZ+Qa6Q/TJuDs+SSvqzuG9sBFkzhNH1CmBsVSDw2rAG3Gr1pJxWE0n?=
 =?us-ascii?Q?J2cxzLGGFbc+s/+NEMKBjzhkCLVzuEzIYa0Hz3JfVRrunV/hRoyDuEtXEH2D?=
 =?us-ascii?Q?HMiPsz01Fl/jd8Y/UdHDK/XlvDGs4jcv+/XAyz8773mWXLGTo7DgPZ9cPziv?=
 =?us-ascii?Q?Ajq58b1wbor27MowUULZvYqdm4a5/G8L1aYIIH/+nfl0F95+l2yYsgMmDve/?=
 =?us-ascii?Q?vxz3+cJ84VhbXfjEwYYhE5g26uOUsHmEeZ50pGqY0kBpo2e0pJimhlyaurVy?=
 =?us-ascii?Q?Yw3ZJkgu5j396MZSCHWAuHsaKWXowfCbJnavR9q9a03hK4jWwYfKUB2LMAdP?=
 =?us-ascii?Q?YVZtjgXXd6+AyNdc0e5do0eYl3NTZENWhE/NY115mW6q7Xlbu7R6FJKozOsf?=
 =?us-ascii?Q?eGgWcKsDrufvfvetqKdwcEkru2bZCU8ocrcdSZ+odx1trRBNkmDBSnFzitYG?=
 =?us-ascii?Q?YCkwtuVzL2Gr4mctHEiB3KI/Alf8XMwWawxQASoGBC+BquhH9iqv/cabEmz1?=
 =?us-ascii?Q?Aozq4oOWnXg9l6kWeQ6wilDSRDWGFxXIDh/WFkjTDSx6DogfVFSS3KhI97w+?=
 =?us-ascii?Q?1d6/YfnvqpSgE4DYhRW+ZgWQLXLUzOh6GltFqkhlZfRykkizi/DSDtP/zeyZ?=
 =?us-ascii?Q?yVzj0d19RCnq0RI/heAke+r8RIxr3puZ0Gvbj+0D3CBEoj77a3x8omMUTkC5?=
 =?us-ascii?Q?2GqBHDXv+Eo6etAJxTYxKMiJ1C7yLj3VRwJLkUfwkaPR6LCLiCctN5gs38DF?=
 =?us-ascii?Q?qsbQxeV7P+Un+TwdbHE+Cg53YrgF6wZsFrywiV1C5lpUq0FPaNrPDO7vZm+Q?=
 =?us-ascii?Q?Z3k+EWdC9kRg7xW4zTBSBO28Vfnqm3mCVlN+P2zrOZADkL9/HXrknFC00Zlh?=
 =?us-ascii?Q?Hrn/NeIh9wFqOg25KrE6HS4AQ15Ug75VsyRO6ENR7yYYgA6acAyOoSvnhjzT?=
 =?us-ascii?Q?PJmRsn8NE1PD5Ri05KXScClwUk9/vJNFMz3VwwpdXFbUboC5TfTPXRmNcGkN?=
 =?us-ascii?Q?iY8hjAje8r8wWshI8KuTbNj7Gp/nw3SM1lXyJcrqe9fNT9delok9cvPN+YQ6?=
 =?us-ascii?Q?d9M/+36l8OlB79GTiXDizTI+73KdK/c/UceXwIyo7vBHxbOTh1qcMlh/G0P+?=
 =?us-ascii?Q?QSYP+SjRwIzG4UNz0OXPSFpNkHU8tqabyiNfdBYWMDadnUVkzdpyuzsR3R/H?=
 =?us-ascii?Q?1oxv3VN2Kj4TqlWqGEK8w1/6PUiJ3ZsYZnOIvG2C8COgeyQ8I2endRiOVwvI?=
 =?us-ascii?Q?nUPsDxoZKzh5GGNr+5Ovga0uAxxBe9r/JiMAvCYpRyK8PxpgCgqltpPz8MnC?=
 =?us-ascii?Q?on4eudwb1KavsmTaeC0xeLr6liT4xpFyUezJrEMT2JhUarpPJZSiu0nSzotd?=
 =?us-ascii?Q?2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54947bb-c78f-45cb-605e-08db4a6a0f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 17:32:38.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsvSJsXDLoB6Zh0i1AJ4WwtUAyHrLibhGOQBaxqjWZSg63XOSw7FSuxveHGuuffbwxR4T9EU2I0430HTxgZqgmRTJz5EIZEBorb5kKChDzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3415
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, April 21, 2023 7:18 PM
>=20
> Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
>   No need to use hv_vp_assist_page.
>   Don't use the unsafe Hyper-V TSC page.
>   Don't try to use HV_REGISTER_CRASH_CTL.
>   Don't trust Hyper-V's TLB-flushing hypercalls.
>   Don't use lazy EOI.
>   Share SynIC Event/Message pages and VMBus Monitor pages with the host.

This patch no longer does anything with the VMBus monitor pages.

>   Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().

The above line in the commit message is stale and can be dropped.

>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c      |  6 ++--
>  arch/x86/hyperv/hv_init.c      | 19 +++++++++---
>  arch/x86/kernel/cpu/mshyperv.c | 21 ++++++++++++-
>  drivers/hv/hv.c                | 54 ++++++++++++++++++++++++++++++++--
>  4 files changed, 90 insertions(+), 10 deletions(-)
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
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index fb8b2c088681..16919c7b3196 100644
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
> index a87fb934cd4b..e9106c9d92f8 100644
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
> index 4e1407d59ba0..fa7dce26ec67 100644
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
> @@ -116,6 +117,7 @@ int hv_synic_alloc(void)
>  {
>  	int cpu;
>  	struct hv_per_cpu_context *hv_cpu;
> +	int ret =3D -ENOMEM;
>=20
>  	/*
>  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> @@ -159,6 +161,28 @@ int hv_synic_alloc(void)
>  				goto err;
>  			}
>  		}
> +
> +		/* It's better to leak the page if the decryption fails. */
> +		if (hv_isolation_type_tdx()) {
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC msg page\n");
> +				hv_cpu->synic_message_page =3D NULL;
> +				goto err;
> +			}
> +
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC event page\n");
> +				hv_cpu->synic_event_page =3D NULL;
> +				goto err;
> +			}

The error handling still doesn't work quite correctly.   In the TDX case, u=
pon
exiting this function, the synic_message_page and the synic_event_page must
each either be mapped decrypted or be NULL.  This requirement is so
that hv_synic_free() will do the right thing in changing the mapping back t=
o
encrypted.  hv_synic_free() can't handle a non-NULL page being encrypted.

In the above code, if we fail to decrypt the synic_message_page, then setti=
ng
it to NULL will leak the page (which we'll live with) and ensures that hv_s=
ynic_free()
will handle it correctly.  But at that point we'll exit with synic_event_pa=
ge
non-NULL and in the encrypted state, which hv_synic_free() can't handle.

Michael

> +
> +			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
> +		}
>  	}
>=20
>  	return 0;
> @@ -167,18 +191,40 @@ int hv_synic_alloc(void)
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
> +					pr_err("Failed to encrypt SYNIC msg page\n");
> +					hv_cpu->synic_message_page =3D NULL;
> +				}
> +			}
> +
> +			if (hv_cpu->synic_event_page) {
> +				ret =3D set_memory_encrypted((unsigned long)
> +					hv_cpu->synic_event_page, 1);
> +				if (ret) {
> +					pr_err("Failed to encrypt SYNIC event page\n");
> +					hv_cpu->synic_event_page =3D NULL;
> +				}
> +			}
> +		}
> +
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  	}
> @@ -215,7 +261,8 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		if (!hv_cpu->synic_message_page)
>  			pr_err("Fail to map synic message page.\n");
>  	} else {
> -		simp.base_simp_gpa =3D virt_to_phys(hv_cpu->synic_message_page)
> +		simp.base_simp_gpa =3D
> +			cc_mkdec(virt_to_phys(hv_cpu->synic_message_page))
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> @@ -234,7 +281,8 @@ void hv_synic_enable_regs(unsigned int cpu)
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

