Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6167782BCA
	for <lists+linux-arch@lfdr.de>; Mon, 21 Aug 2023 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjHUO3l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Aug 2023 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjHUO3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Aug 2023 10:29:40 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22489DB;
        Mon, 21 Aug 2023 07:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd2h5ZSNLK39HL21bC2D+WYuwIYRU8saE8R+Eho8/2niZJHujp90pjMzV+9A/ZU7aZg0/1pRpH43e18wXWf/z0yugi6ASMOjZcxsNQnLaTL3zy8T0mRHscw/aktbLlvIj7HC5q67zaRV+KU8ubmXBOCEyM7jiGGt5cXOoqk0pdDDf9fU5Lhs2U5jg2xSpEe9FuEAvvFpIYy6zwsutNdR/0FaUPcOTeau4mH2lfyxEAfMBdb2oqSw+0XUwLHkjOgpDs4mSCSBMVLIYmX2RSNeG0qSlaoERH6QGIIBd7PWUSu4I+98COApZeWhyCZcIFT6aXruOa0QEAbff+2lkEzCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxzd/3gid25O3bsdA4+m35Qfn7Jzi3qo6+SONByVVeE=;
 b=YM3LNmIgxuR/lpGUKcd7rJvJoN5pG9bIr1CBosXjH1r0CpcaysuB81N/YH7gR10xS1v71DfgaKO0yZQH1UoqoTZlZ0QPJwV2c/YCHLcYfsQYwQJ6RLlpC78N2r23h45kwcmN75OO4k3FC8hHQ51H6cQDupo2fv+3vSlfC159SpOqbT5v0IqsJtUGrhHTjO58aU3NVq2WLQsFCxTXRmVi3R66MyugjcQQWHOP0HWV7aIGUifL4xshsGnD+4WAzztBhCYxASpSKZSpTPLIlLfd0hX/ZFDrHQ28nf80tZdhbjU5ADWA+3E+CYbLuj1AMPYRb4l3D8nC0JE3iD4UFcE74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxzd/3gid25O3bsdA4+m35Qfn7Jzi3qo6+SONByVVeE=;
 b=HiD9FzqFt90bk2k8JUXCYEa45wgON/ataWF4cbfwoUWVpZDSmwijqK2e0/pNi8yJvwCOoUdv3A8f9oGuLPUvxaogSNoDrIVC+03L6r2SgjCtIFOEmN8MCGUON5PGxHl8n86MEmQ76hdX3GIT7VRnAulkl8VAF7i5JRUPYUbwPW0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3643.namprd21.prod.outlook.com (2603:10b6:208:3e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Mon, 21 Aug
 2023 14:29:35 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%4]) with mapi id 15.20.6745.001; Mon, 21 Aug 2023
 14:29:34 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
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
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH v2 5/9] Drivers: hv: vmbus: Support >64 VPs for a fully
 enlightened TDX/SNP VM
Thread-Topic: [PATCH v2 5/9] Drivers: hv: vmbus: Support >64 VPs for a fully
 enlightened TDX/SNP VM
Thread-Index: AQHZ06TUj05o/4FsiU6WoMQ7db/eq6/0zgLQ
Date:   Mon, 21 Aug 2023 14:29:34 +0000
Message-ID: <BYAPR21MB1688D35BBB82B43320C8A04BD71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230820202715.29006-1-decui@microsoft.com>
 <20230820202715.29006-6-decui@microsoft.com>
In-Reply-To: <20230820202715.29006-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c727f11e-8a08-4ddb-b8dc-45cf0d42eec4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-21T14:20:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3643:EE_
x-ms-office365-filtering-correlation-id: 66d7a9ad-474d-45f5-1184-08dba2530a4b
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7kH/1dGjZaL4L7M1QoFl95BQysbigXWV7j0HNzlLqztxFi7b6bct31IyqF+MbgrmwcmBsKhjx0ex/DYc2OyZMgP4plizkfH6dYTnKqMn6/DICgBzBfiN/kQcBXqBMy4Ht8msOJ5E0YbUwEoxRONSgy3UzOioduAu5vM0Ha/3uDf5/2xdjRCJO2cTUV4Tkyr8nslXIqHnlJUi2TPPjrg9KTWqDxgI/QHE7h+BZwQ14woE4G2bkEp5rQ4ROhkG/ttCnStdltfJjo7ViSJ8Rw+GNgtMlC25tqdCRjth+0GqvgjzrKxt+uQxqvWh5adtRATReHJtQKxNT6kAMepT+w+47oPDhUKSaTCcAdH+E0KCdtMrJ3AC/pLEcX1Zolmxtoy6k7nsxUziOM8Z+GM009M0g1jpnGWBPaJeJoGMYTGeomGeZh0E/V0jfaE7GQwhxx7zzVy6pUZTKp3aKZOaEDKCfaECMzMVDfBIgLMAByMnb0M8wTAUT8CUWcpr9T/UOh+c6pw0uqDh5MXYc/YyScz/7boR09KNi0PUvDKicAooCppP1zNuUSS5FbM/kuFzB99/nKorQcPLmWoYQZyCDBSagASS+n2WNPqS+6obDvX9r6p0CME5ILOeZZdlG7t2T0isPbtU3kwhNlKoD2GfcTRzCiQcflzSlrvltP+wVqvmh7ourgAJHLTAgfc7zKERLyNQBoaFnkOYUVznpsPN8NaEGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199024)(186009)(1800799009)(83380400001)(10290500003)(52536014)(8676002)(5660300002)(82950400001)(4326008)(33656002)(478600001)(8936002)(921005)(26005)(12101799020)(2906002)(6506007)(7696005)(55016003)(8990500004)(9686003)(7406005)(7416002)(71200400001)(54906003)(110136005)(66946007)(82960400001)(76116006)(66556008)(66476007)(316002)(66446008)(38070700005)(38100700002)(41300700001)(64756008)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZrIl0yGrLDDYzQSJtMsWI/qW629u5sSTPkrTVjG/qZ4g9hxcbAHHRoSKSeKq?=
 =?us-ascii?Q?uXyEckbmkpXHSmBh7eutDY8swOVE1beOyKp2tp/TcGYUU0Jb9gKA58LuypnJ?=
 =?us-ascii?Q?kAgsH7ORc+ichHb3CaKFuNHYBSGv1P6KvEy5fLA3hWvBnQn03kJP9sdCJV0J?=
 =?us-ascii?Q?MPJf7XbbwNa0AMJ5WUwXNv9XDGQu3sQ7odHz+NYezfcXIqPWiE1nWFiuGpIf?=
 =?us-ascii?Q?Q5tWYaRrVvpXuMwduJ+uCs8FI9b1GgiStMIVx1Xaf4Sf9lTiSpv3VfovTElL?=
 =?us-ascii?Q?KKMSz4j/Xg5mF3mS9DIJkzxJwjto2P5AL8yvkAT/LEYD/1jFIFf905tZp33L?=
 =?us-ascii?Q?3+MnEZXIbK3iotdTlRn3K8uqRtRC/QnRWlqZ+zBHimbmzrXOV97Dt8DVDea0?=
 =?us-ascii?Q?SWO3IIg+DNJRdlFHs/F774aAcWVC2WE+P591s3d8NhmIHww3+b+WPMMpqx+w?=
 =?us-ascii?Q?0VSEHOia3ovrWy9aSN04SwHkaAtTZ2cSpKDpeJSEfvxSvlCOB9/azijHyZdK?=
 =?us-ascii?Q?5yCThFpy1cIM9nKiDVOJqKCoN3HY5L5idhtFSMsS9pjzhv1at8HOTJDn1ch/?=
 =?us-ascii?Q?uupdXHYENRlb4yWs5l087jF+VmT4F6JXEyIgODfGo4pg88pELVQsNS9Dct/C?=
 =?us-ascii?Q?1e8JPaHZO6Vbvnp2+ldkj44mdevEkR/1o/5bzfSwIsr/FqBl+jIJkNUxbLgj?=
 =?us-ascii?Q?jFR+IANSuUPH4J0PNQLVMSeUvy0+KlNJr0bhmZ2z4CSb8q5/Q2gBBQXM3WC5?=
 =?us-ascii?Q?8cYM3nTAdoL3hZTFDW8Adk0aMoZk16Mz0kUdEzZViBizKHTsyoOGdTJ33T+n?=
 =?us-ascii?Q?rWNk6FTqqsudLH+tWSdZT88zBL+kBTxIUXN0FW04yY4UsdGuUVPFnJsaOnEc?=
 =?us-ascii?Q?NmnIIoNG7CSK2fgwzQyssjFBZED/fm0NcZifzbOp6kImB3ep5Um7bJw9JglV?=
 =?us-ascii?Q?d4YOhHTMh8XAWXwVhfxxxlC5BWvmC/f+NuCmijn72jDsg/LoyMSjfhIjnJCa?=
 =?us-ascii?Q?MM8uN3JD3WnFbm85NECKb7q9jpwzVh2qlN9VuOOLpb3VMAewB4j8zahQXT01?=
 =?us-ascii?Q?kBFSilb2IstUjY/3RZb+KyFv3FyxhQoNoWGhYp4CBjtlUkDbAML8c09ebjZu?=
 =?us-ascii?Q?KwsmsEbhs6lReNSzTO/mcwrgDvkRNKUa3QJ30rTA7YLIslAiZQDgyRKfy2ZB?=
 =?us-ascii?Q?ITQou1uu6HdDfABL3hTjI1bVAlzFMAe4ITRakMp6qN5GteGKaIscdOOhvre7?=
 =?us-ascii?Q?pQ6kavm4FeKKIYpDeo5kfriQbcrEWOwtgAJA+cNgKu1EqNUSQmRxyWoei+mo?=
 =?us-ascii?Q?PtaTfCTCsnqYvTerCVFCEFRT+IdALCAFbWEJaKSUsRnHTykJF9C2krCWwYbb?=
 =?us-ascii?Q?5BQPEGwFlhf6mtTuMi+miGc5cMcNOQ3AJWMvFaxRG3yfBz8le83++tltSoH3?=
 =?us-ascii?Q?yLoP5QlFH6D/cm7GUHPJASfo5RjWzmThaYWgUG46B5wB7Mqpyy+T6TWjOjfk?=
 =?us-ascii?Q?y+NyLUuTNz+Gkj1Qr4nNfY13VACINtTa/61QdPHIa9W3vy/w4WdzjSiiDTK0?=
 =?us-ascii?Q?rMK2NaRO7wJozoQgijcSgPv1lxbtpFZSMxEmTxH8mK+hSz9VccD3F8NmxV6V?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d7a9ad-474d-45f5-1184-08dba2530a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 14:29:34.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbiXcqsparDX3h8mtlfzYmiQL1KODTHzcckKmuk3H1ZrC8D1F3uk86fDn8AIH9YDmnq+LPHNzAuLITJjKQDI4xOGhw9q0EqoMCWrHVTwlwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, August 20, 2023 1:27 P=
M
>=20
> Don't set *this_cpu_ptr(hyperv_pcpu_input_arg) before the function
> set_memory_decrypted() returns, otherwise we run into this ticky issue:
>=20
> For a fully enlightened TDX/SNP VM, in hv_common_cpu_init(),
> *this_cpu_ptr(hyperv_pcpu_input_arg) is an encrypted page before
> the set_memory_decrypted() returns.
>=20
> When such a VM has more than 64 VPs, if the hyperv_pcpu_input_arg is not
> NULL, hv_common_cpu_init() -> set_memory_decrypted() -> ... ->
> cpa_flush() -> on_each_cpu() -> ... -> hv_send_ipi_mask() -> ... ->
> __send_ipi_mask_ex() tries to call hv_do_fast_hypercall16() with the

Actually, it tries to call hv_do_rep_hypercall().  Using the memory-based
hyperv_pcpu_input_arg with a "fast" hypercall doesn't make sense.

> hyperv_pcpu_input_arg as the hypercall input page, which must be a
> decrypted page in such a VM, but the page is still encrypted at this
> point, and a fatal fault is triggered.
>=20
> Fix the issue by setting *this_cpu_ptr(hyperv_pcpu_input_arg) after
> set_memory_decrypted(): if the hyperv_pcpu_input_arg is NULL,
> __send_ipi_mask_ex() returns HV_STATUS_INVALID_PARAMETER immediately,
> and hv_send_ipi_mask() falls back to orig_apic.send_IPI_mask(),
> which can use x2apic_send_IPI_all(), which may be slightly slower than
> the hypercall but still works correctly in such a VM.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2: None
>=20
>  drivers/hv/hv_common.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 897bbb96f4118..4c858e1636da7 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -360,6 +360,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	int pgcount =3D hv_root_partition ? 2 : 1;
> +	void *mem;
>  	int ret;
>=20
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> @@ -372,25 +373,40 @@ int hv_common_cpu_init(unsigned int cpu)
>  	 * allocated if this CPU was previously online and then taken offline
>  	 */
>  	if (!*inputarg) {
> -		*inputarg =3D kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
> -		if (!(*inputarg))
> +		mem =3D kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
> +		if (!mem)
>  			return -ENOMEM;
>=20
>  		if (hv_root_partition) {
>  			outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> -			*outputarg =3D (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> +			*outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
>  		}
>=20
>  		if (hv_isolation_type_en_snp() || hv_isolation_type_tdx()) {
> -			ret =3D set_memory_decrypted((unsigned long)*inputarg, pgcount);
> +			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
>  			if (ret) {
> -				/* It may be unsafe to free *inputarg */
> -				*inputarg =3D NULL;
> +				/* It may be unsafe to free 'mem' */
>  				return ret;
>  			}
>=20
> -			memset(*inputarg, 0x00, pgcount * PAGE_SIZE);
> +			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
>  		}
> +
> +		/*
> +		 * In a fully enlightened TDX/SNP VM with more than 64 VPs, if
> +		 * hyperv_pcpu_input_arg is not NULL, set_memory_decrypted() ->
> +		 * ... -> cpa_flush()-> ... -> __send_ipi_mask_ex() tries to
> +		 * use hyperv_pcpu_input_arg as the hypercall input page, which
> +		 * must be a decrypted page in such a VM, but the page is still
> +		 * encrypted before set_memory_decrypted() returns. Fix this by
> +		 * setting *inputarg after the above set_memory_decrypted(): if
> +		 * hyperv_pcpu_input_arg is NULL, __send_ipi_mask_ex() returns
> +		 * HV_STATUS_INVALID_PARAMETER immediately, and the function
> +		 * hv_send_ipi_mask() falls back to orig_apic.send_IPI_mask(),
> +		 * which may be slightly slower than the hypercall, but still
> +		 * works correctly in such a VM.
> +		 */
> +		*inputarg =3D mem;
>  	}
>=20
>  	msr_vp_index =3D hv_get_register(HV_REGISTER_VP_INDEX);
> --
> 2.25.1

Modulo the minor correction in the commit message,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
