Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ACC77EA2C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 21:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjHPT6d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346003AbjHPT6K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 15:58:10 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5751E2D77;
        Wed, 16 Aug 2023 12:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvFLWJTjnmrnW/73QMmNQ5/I9ODXt/2rOHqGfj7oH7kZHyyUiUU/lUIbf28sPbu0n/RsKSFF2RBCPzUoQq9N05db0xhMeXX/vu1PCZDHm7mPSisGoXq7zIQmthIA/C4Ah7VJkCZscx6BE1MQi/3EikOULrEqd1XnrtP/ZjKQEdIfvzL4yENRQbjZNq8WPQs6fw0C0cXxB0wU+rxMbVdOmoaY/D7Gv/zxkcSrcPsiFJkgQzamKeGCCNlSK10ihDPpxJfcoJCFKbwCTUlpQnm26doLoW0f4NuOzNKFdkVT5EFuk/YlnIRSkoHqJ8nj2UAZ87NXNh8fhU2v29SpvwSm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbuoTz2VLxyh7kK+cFFQKQdW4ZHHjOiwqu3O99wEBw8=;
 b=OMhS2f/fvsZZ0KhLvVRkWa+oT6j/So7PXSN7h7B2EzkznjWFLMGfmTMxjd2KsCXgFbt8YycId62/LK7VZupUvC/rVW/xQAJ7uSyHCcLBGf9fG46ABgMMmlnEOfj9WDN39vGIncrC3E5nSWdyskW7uAGThYgAdp6hmQ8hGi0QnYp+CDjjVhXUBB/3lbn0yauqT9ajjmyAZ+oysTMH5m+DT3gCRzLPKrhq3GMBkkNhSkgpcougceqInmwSU8xWmij/hX75xIQAtknVyKIAqvbCcujyhkMa8qg46HhFE8/4QOrcRxpqlHFgpRVosywdzEFum8UVSBjmIMOAkDQsVo3epg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbuoTz2VLxyh7kK+cFFQKQdW4ZHHjOiwqu3O99wEBw8=;
 b=JBRQYaW2B1VzgzY7b+Ov+OPL1scw2MRjcJiqrArz8QcOg0VLbcFmD4db+ZxGg9nm74fHWNkLrbZSCCp6wiHKbHIz1NoI+yAZsWRHyP91dBKbJwdrlYGrUAcb53kEzyJTnaPTQd086W+A8TH45OMZVfhWmTuxf0TsA1kTvfiuXCI=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3665.namprd21.prod.outlook.com (2603:10b6:208:3e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.12; Wed, 16 Aug
 2023 19:57:40 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 19:57:40 +0000
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
Subject: RE: [PATCH v6 2/8] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Topic: [PATCH v6 2/8] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Index: AQHZ0FqU/LzNahlajkq+K1y6O/vU6K/tU1Bg
Date:   Wed, 16 Aug 2023 19:57:40 +0000
Message-ID: <SA1PR21MB1335B3A3622A80526E68A28ABF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
 <20230816155850.1216996-3-ltykernel@gmail.com>
In-Reply-To: <20230816155850.1216996-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=41677b60-cb7c-4266-9583-3ffb76a10fab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T19:44:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3665:EE_
x-ms-office365-filtering-correlation-id: 0a920257-2bd5-4cd8-fb65-08db9e930c14
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFoL1wYwnzpb/amHHGxwu1mdHBtYfl6sfKbrtGGcAxuGpXMoPYJHksAJCwobfSfCXGvr6yQz/gYgnpAYQ351H2UcxZFtUhGyiQnz9TdKEkN8LIyVV3uPDj71Xy/ZSYs7kk95iVdPbXdXa6KoYWAaS2MuD5pVZQ/tKthSO3w2oi4bVsbN0kBIihGS9xn880r7vLyHm1/6D273FYQblGCmdx5+r/jwpoR5gAniM0useSVT02rVKcYGhXdLlBvoKLHLfbuZ7enuLtsnRf3SCQwtJxSUhxwocjnJJ89mh0KTsFM+mWuH2Dc6is1gP17UArJwIV35SAfsN2kX7HstNNmPnXvve8ceBOglWyaz3iQEvJ+fVTBXiP6i+0XpUTB+KqVhSmDxPmVKfoDANKXJbD2GEfIh3Qmo03eVIaETWknntf6ykPywQ8DofCqS/gWTto59fjbWRcxRyhAhLKI2MPM2miw6g3BuYzH8UjasgCuXFDcuQmlTSR/FVPTZyIcr1MxJhjY2S1mlJ4V3LaPmeNCIU+zBctopYvHfiykquDAj6B7aYXE/xv3th81TSps4vhnIXNTclEajlFV2ovXJ3Goi2HspCGlnQmKkUENy+Xf98yrI3A3tDUWubHjQ/gEPsbywsAWzg4M7Z5xMGe+kCso+m8RIhD+cOxpKJv59pRev/c5HQ5MCJKlB4j+lOoIJmx5ephbBifaXPp8yG1v0/iEP4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(12101799020)(6506007)(107886003)(71200400001)(76116006)(66946007)(66476007)(66556008)(8936002)(66446008)(8676002)(5660300002)(7416002)(64756008)(6636002)(316002)(4326008)(86362001)(33656002)(38070700005)(38100700002)(55016003)(82960400001)(82950400001)(122000001)(83380400001)(8990500004)(7696005)(9686003)(2906002)(52536014)(41300700001)(110136005)(54906003)(478600001)(10290500003)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?McfPAL988nacplsrgHezg3akE7hDiXTnshez69/Fu83V9qNKOQcw7TrQJHEW?=
 =?us-ascii?Q?un29S4ZK0urgW27rzo+HovBLucV2N1XNjmqEYei+BWqxNqZ70sa+TjRAr2Uo?=
 =?us-ascii?Q?RT58Frq2VAormI8cWWRROrG5/eA4TwjQ0NFEJZ2TOgRCGWJRTZnAHT2Qhndc?=
 =?us-ascii?Q?2wh9SWtWUHe4D61RT0gdjSKW+Yqn5422a5x7wtJ+/FOIZqU/ptcKhvt2wpQ9?=
 =?us-ascii?Q?twnNhLpjNsXlydMV5xKcnqrTnpD/jzCi9N6uIrFn8LiddsRX148Lx5mUtZwM?=
 =?us-ascii?Q?vW7Alogi9vNaGzrigr583KiI3VzYA1K2gI5got/OZdAmA/7G09AlgdE27zt0?=
 =?us-ascii?Q?qe1+xfQeRXZIGmOFNaxghR0bGGOeCbfwCKAbiEEIJ0hxGxKhz+b7PnC7bUbk?=
 =?us-ascii?Q?YsSpzVyjeF5SfITmm8YgPMHTJQDUDDkRpQOuSWKmknXCLGpJQYv7J7nOCbkC?=
 =?us-ascii?Q?E5Mg9EeecNjMyZwKJez2VqgzjcR9slneYYmnxB7c05vpJ4Sosi6jOorT3anK?=
 =?us-ascii?Q?LBdtHbTqFrX82bhriSONMMsgaFvBwKQAlxHiuzPsuBqVaSdKe/Y3G1CSHj83?=
 =?us-ascii?Q?OebkBzlYdGvFsWOrFRD5Du2FeHS2AlVcG2roElwVYrS9Si/9V5FkuuzSIecj?=
 =?us-ascii?Q?Vptcyz1n+USuhQkels5BhoF5Ec3Wx5xxHkfxw/RhbEB9xa20SA9K1lqFVdFo?=
 =?us-ascii?Q?1EtZ/rCrciRdKtkadsYSau0CIdAsPayfdgVofalVoOWSMBGTB8GPDXUe4K9d?=
 =?us-ascii?Q?mhZl92Ba5qJm9q0YdkzS760zqVRyffV2EEUk8yCYtSsbX6ymo1QPOMWENj4y?=
 =?us-ascii?Q?CkbqPwOOvT2kN8qfz7U1yc0fM6aSjgXWWtxakXq8h6UIoyKJHCgvXj5nFeT7?=
 =?us-ascii?Q?xQazChjrjTqLGCAEZ4ZncBtonPsdu1V0KQbBaSYbiNZj1CrswoiypbeC+OVk?=
 =?us-ascii?Q?+C+MCMo920yWgy+9aM3lZUlti21mIT+lKOBn0AEXqRsN7wW1FjJeOwzAXq1V?=
 =?us-ascii?Q?dVGtKKXCX5vrxerhUp6V/xEBgODv9Xk2SL6wRPfeVHtcgroN0xpqTHtBnaL/?=
 =?us-ascii?Q?nEBhHdQTIHLmuT+08IoZIzn1sBrJV6fM3k0p2Wmy2LNzmTWQauwM0KY6f7eR?=
 =?us-ascii?Q?uWr2b42fRhVGCFviXrwPjXQDh2RNpnLawAydfKXZ/3s1ibkn50MTY1jPvb3P?=
 =?us-ascii?Q?LsGJfs26uEgnec6cUwFw7D7VKKBGRq2vm6K9QUO0Oy3HyAVYWSYomfqPDEM6?=
 =?us-ascii?Q?WDZLNJ/MnGpTcox7vWspEzfNzxmDnxYAf2sC4S/INUjbTDUAK/ErJGr1iIzk?=
 =?us-ascii?Q?tAb07A2RcraywpQkJiChuSJSSvP7NyKJYSY86gwjGXuCItJKtmEy/Nv7f+Gu?=
 =?us-ascii?Q?YQFLRPp8ou7vA+MWEDWpYV1ClxfJ6i8jlpTernLpWrlPv7IVL+8rL3EBYLst?=
 =?us-ascii?Q?emoJNx9DDVQnsSkfko6fa+aUW/RIbc4zxL7HBiTg1hGSDuNH4oiVQzIB4lUK?=
 =?us-ascii?Q?WmqlBrklBWcrF6+QYfGaUqJWxrh+Ql5BpgREXlYrobHnLIMUatIaI3z+N+6b?=
 =?us-ascii?Q?/LIRn9hbFKN3SiLBtckuCsJqn4QPQ9qiEn1ar0VbE52BRjt0gtW3J5lpGgo3?=
 =?us-ascii?Q?ierVw0GmvxSjTw+3r2hlf/U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a920257-2bd5-4cd8-fb65-08db9e930c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 19:57:40.2580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +I/75N1wopBQuC4AddYFCp0jjpEtIrtscEVAztIH/HLjQ2kY6DMuC7SkIrHx9PbHYFR/c2Hh/c+N1t0EzPnnwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3665
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
> Sent: Wednesday, August 16, 2023 8:59 AM
>  [...]
> @@ -378,6 +378,36 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>=20
> +static u8 __init get_vtl(void)
> +{
> +	u64 control =3D HV_HYPERCALL_REP_COMP_1 |
> HVCALL_GET_VP_REGISTERS;
> +	struct hv_get_vp_registers_input *input;
> +	struct hv_get_vp_registers_output *output;
> +	unsigned long flags;
> +	u64 ret =3D 0;

Nitpick:  we don't have to initialize 'ret' here.

Reviewed-by: Dexuan Cui <decui@microsoft.com>

> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D (struct hv_get_vp_registers_output *)input;
> +
> +	memset(input, 0, struct_size(input, element, 1));
> +	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> +	input->header.vpindex =3D HV_VP_INDEX_SELF;
> +	input->header.inputvtl =3D 0;
> +	input->element[0].name0 =3D HV_X64_REGISTER_VSM_VP_STATUS;
> +
> +	ret =3D hv_do_hypercall(control, input, output);

'ret' is always initialized here.

> +	if (hv_result_success(ret)) {
> +		ret =3D output->as64.low & HV_X64_VTL_MASK;
> +	} else {
> +		pr_err("Failed to get VTL(%lld) and set VTL to zero by
> default.\n", ret);
> +		ret =3D 0;
> +	}
> +
> +	local_irq_restore(flags);
> +	return ret;
> +}



