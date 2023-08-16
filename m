Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8427A77EBE8
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 23:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346525AbjHPVc6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 17:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346567AbjHPVck (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 17:32:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C041FD0;
        Wed, 16 Aug 2023 14:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqVsYRphWLZSDh1T245PAtTuy2hjbce0es8hPIaYnTovd/eiXLfn+OyI9Irg+IhZdGVtDsbJ3mVXouES1wEIPkXXRZsPrQDmDfQCsbGL8Ac4Lggwn9k+gHm3ITZZOaqtVO2RKZ+KbENTKg1VKOWmmZdVdZUJEEqYp0pKb43otnionWT3bzgeVBcSz7PB3KdHJv9eBiV30vrHPvJhp5lduusmqA/tRTm2O9+GaZP34lRI7XLQliAWuOCD85p+CGcAlsTtyk+COFrj5GeS8KEaqGGMS1kW7cQtTzNPaZcQjEZ1CAO8oINk27EVoHj06NkSdUuTGKXok2/8dZNZJ3fQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JwFyo46ZwXrrGeaxWfX8gE79kSiMqZpx3mpOHSXazA=;
 b=fE5W8yx7w+qiKGrlW7v0tISDUaFUebg2ERIMJLZUKjmmqXHiV65OxdT0lBJbuYUHU24NVbnwsr4qm4O2u6HoTFB91LUzAJeIXN6qs82iRp88p4Tu5GvIahGCGDUxmcZivjPVMCInnbGG/iseWpe0RGXAGcQaIElRZaYh8xjZf2WsC4vrupA+pukoHSgYr/5wFXi5YDBMcUU84/d/4j1W1FMFYgHu3Z5Ye7vgKsnJKEVQdywigqtYLvAcIv5YlgV/Dd8HcmxiTRHSkUJ4/GJkwEa/DqbSWLFuxGEQMDj2oRpjGDl11rBMtcHBxcEYvYEG4wFjd/A/egQsis4Dtz/33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JwFyo46ZwXrrGeaxWfX8gE79kSiMqZpx3mpOHSXazA=;
 b=ARKzvV+SOBZyJzhARi/QOlK3dP2bbU1VUgqt2j4NtVgE0KnFxVNTy+oBocFfTielcCW1/cMr3826773U5YI2dNcNny1qdl8C67DVKQJDlNyHyXSJ3Z0Gwda1dkICD4T/65TzNf/+cvvbbDghLH76rxWJPNDt2T44Zwp+YHNUHu4=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH0PR21MB1325.namprd21.prod.outlook.com (2603:10b6:510:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.4; Wed, 16 Aug
 2023 21:32:36 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 21:32:36 +0000
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
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v6 5/8] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Topic: [PATCH v6 5/8] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Index: AQHZ0FqWwwhYTLc5ZE2nEAVJ3M8pkq/tcATQ
Date:   Wed, 16 Aug 2023 21:32:36 +0000
Message-ID: <SA1PR21MB1335D07F52F526341E5709D5BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
 <20230816155850.1216996-6-ltykernel@gmail.com>
In-Reply-To: <20230816155850.1216996-6-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7ba6b65b-c122-4aba-86b8-8d23f91f73cd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T21:26:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH0PR21MB1325:EE_
x-ms-office365-filtering-correlation-id: 6f37e5c6-a0a7-4649-5b37-08db9ea04f0b
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XEISWCblQbJpOAsv5jgvpP4s1OK3cKVL2Vbbjman83pzS1lhsk0jrx8SSGwIXBKq8cx/+sPAZT6Ycxo5WQ9PSg3X278sG5ePyQpb/eeAOkaaLGK00bEuG90TjRVd5R4U4CljfU5OrGwwdM+nvfcW7LUxQHW60ANipVmrZ0KEzANFCQY4jCh2jAyN20pIyXe4/fdF4XsUfuITK6q47Jh63MO9JdSKwD423lkgcT0aIue5Hq0hNODeWsfo2vpPbGOZu+wO2zUSpELNhoqW00wOHZd2vXdM3C4kfyZLaj11Ye/KSKQJ4cUbdqQFcQkfe1OO34DTjpyqWx/4zt23xeLGZOtVSZs4kk+gQ4O7xI+VPQDC9WUBxz9VDkyEeXO5tlSno513QWwfpizpkZiPDyr//gvzcfJJVwAX0VcDq6UPqnr/DN2YGd/FIqc2a9loB8ZZtrUKEO4vE8hz8VTK7QVfkRaCyjGgcpcSDn4scLG8rlYFeXUNVNguml9fwlfVeAoNM6MX4IvLJfkQ7HnQX+VsoiKM0UQaQu0ZoCpRDC/oFepAGmoCl5Y1P+b73JATE72mr+Gr7LT+eCdeKAz2MlSiGntu4UA16P1eHU77WTMFI3xILGSFnREkQnTGo6dOm8uC9hi15dqjWS42G08qdLqmX/6IKe2komQdMRZal65rITHuH2UGXuOa22jkT2v8klXqBQQFgSXLFU1tCUZwaZa1Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199024)(186009)(1800799009)(66446008)(4326008)(86362001)(2906002)(82960400001)(82950400001)(83380400001)(110136005)(5660300002)(478600001)(921005)(38100700002)(38070700005)(122000001)(8676002)(8990500004)(7416002)(52536014)(8936002)(54906003)(71200400001)(33656002)(66556008)(41300700001)(66946007)(7696005)(6636002)(9686003)(76116006)(66476007)(64756008)(10290500003)(12101799020)(6506007)(55016003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zxHRP0Lo/h3qfoJhzlDP6cC38y1n3mnnqpYU6PCRvEop0oR+VfwBmwMzfQx/?=
 =?us-ascii?Q?uuTFi3ynTXW0+Lfkcphegdf8FcA0h6EgzUZe0IrxB5fWc7RvPJv+b+NQqeK5?=
 =?us-ascii?Q?5stW6iP/ORx7BW0Z85VXZC7R7w9hy3ppAmOwKKZ/51eex7A919KD7oeqdM8C?=
 =?us-ascii?Q?MDqGJsa8PdBoPjn3Sv0YPvolaP6mfA4SnyyLsHww7KGpintNzMvqMGhsm/n3?=
 =?us-ascii?Q?BEaWaoHAxrpTETTT9CasjnTDpjZSpCjAqCcXis5Qa4/bDvyh9np8I1Ge3zkK?=
 =?us-ascii?Q?EqjMbTM1CndFAbuziBF+qscsd7kazhDPanSWfYqsyaIgx1yFkJcJO+ojbno1?=
 =?us-ascii?Q?9P13+es/FcVSCDcTudxNIazEkdV/MY2igmMmIhqJDiz4pHLDl53jWMIYa3P4?=
 =?us-ascii?Q?3oZn1Eh6L2M2jIFW2Jme7LNTcrIq1vjMaQ6R1xBZE/Mh08qHh7erO5mioOo2?=
 =?us-ascii?Q?Uo390T2SXm9c95aex+AA42rJjcD7otek6SaowvvkCtUMydRcQeHYnr/8hqw3?=
 =?us-ascii?Q?jWngz+KtBv2RBEB1oP58qgJcZSlVLiyHaVW3k5jTQ2BaNwfhrBx7YuENhsGr?=
 =?us-ascii?Q?2ItG1RVx04vgmMagDYUczBqE9HRc9iLJtPsfLGlnM45y0yhkjtoF3Q/LzB/p?=
 =?us-ascii?Q?s68RBtyHxCsgoHLpipFMVxEJvr+PTp6JBE+zlUiPHkUdbbIDBDj6+4rTVULT?=
 =?us-ascii?Q?Z10Zdrb211BslouHfcQH5qp3xHPXepWc84pzj5rrCj8XvyfFl0iYA/DfNj4X?=
 =?us-ascii?Q?8BNjkClbKVswO9cAoRSenCRsBPEgBng8UaK9R73BvW1vddqvaCS8ROLK39hm?=
 =?us-ascii?Q?omKnAGvQB/gtjd3Zq66ysO3PhDm9+hnX6wnMpyLYECgg9HK53LEBXlRTcsQ8?=
 =?us-ascii?Q?nPMe3dwv38bA4AN9cy3S3khnHPMGKsnwIpbTiBTmnGVdW0+VJ6aS+GMSQqV/?=
 =?us-ascii?Q?WdQNXgK80ZPsLie7Ff2pRUiRXoA/EMa1UsZqP9naIDK1qR6CQA3FmhH+LqQX?=
 =?us-ascii?Q?DttMvr+MhFyXVY4r8hgbtlxqQJLz58T1SU3w6JWhTurVBswU0OxviY9xdXHy?=
 =?us-ascii?Q?G0WmiVmKWIfZj8cK4xiWcsFFyGQgcdYMGhzj2wF8tnqAOAF7dgCiypuUGtpo?=
 =?us-ascii?Q?68cw2slfXvIMoiSksZ/DvWuXsrGJcIv+le1Ag9lAOlMJsH2bvpkdChgn4Vug?=
 =?us-ascii?Q?Zrh+kUVl2mKLKmewdtnnDQbt7YwwdfVL+I090B+ktsOff83njuhqBYmVEQlN?=
 =?us-ascii?Q?WAxnLxXCTkKe1EA0ZJeiPS3KCUDS/m7+QTAiFwMG+K5gvLqKSgqbFjqJKnnW?=
 =?us-ascii?Q?GDa4Dk1b+8euiecxEQOyTzKQokJWatHdba/IWOWs7M3DVnCiFkt0dmGfKkzC?=
 =?us-ascii?Q?AOJ9Oujr3sYmjoALSTMz8ZjkJLMxMbRQQbWtBRX13JoKIHU//57jYWaDUjEr?=
 =?us-ascii?Q?imgQSii6+7Rbok8dOwSn4tAho88l0eONvM3UBbwbjaIPULAQRltt/0jDKNrt?=
 =?us-ascii?Q?srFz3IzQ9Sr3INcgtZbtJKWBA0dKlk5K/h3xqsh1u6ZCNxHPHUkh14gl0AUL?=
 =?us-ascii?Q?A2Cn/eCwlNVICanqCFtu2v50Jx7krxpdjxVHzvfknLaB6mnS/5pYskIWQVCx?=
 =?us-ascii?Q?PASD6la32BrPU5eS3xaV/dc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f37e5c6-a0a7-4649-5b37-08db9ea04f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 21:32:36.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVkwauXk+HK5USau5EeOig6vZT1i4loZ7vbNU+U/yxez/d96Tz1yJpVuQ69F8aRL/o1u3iMh/SdfDriTkncAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1325
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
> [...]
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -59,16 +59,25 @@ static inline u64 hv_do_hypercall(u64 control, void
> *input, void *output)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> -	if (!hv_hypercall_pg)
> -		return U64_MAX;
> +	if (hv_isolation_type_en_snp()) {

I got a build failure:

In file included from arch/x86/hyperv/hv_spinlock.c:15:
./arch/x86/include/asm/mshyperv.h: In function 'hv_do_hypercall':
./arch/x86/include/asm/mshyperv.h:69:6: error: implicit declaration of func=
tion 'hv_isolation_type_en_snp' [-Werror=3Dimplicit-function-declaration]
   69 |  if (hv_isolation_type_en_snp()) {
      |      ^~~~~~~~~~~~~~~~~~~~~~~~

In arch/x86/include/asm/mshyperv.h, we do have=20
	extern bool hv_isolation_type_en_snp(void);
but it's defined at a late place. I think we need to move it to before=20
hv_do_hypercall().

We also have=20
	extern bool hv_isolation_type_en_snp(void);
in include/asm-generic/mshyperv.h, but that header file
is included at the end of arch/x86/include/asm/mshyperv.h.


> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     "vmmcall"
> +				     : "=3Da" (hv_status),
> ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input_address)
> +				     :  "r" (output_address)
> +				     : "cc", "memory", "r8", "r9", "r10", "r11");

