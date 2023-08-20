Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CFD781F13
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjHTRq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjHTRqX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 13:46:23 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5DFBF;
        Sun, 20 Aug 2023 10:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2Kx3g9Xbncs9/uI9+Ggm373M1CWL2V/karhhb+uI/448Sc7JHO+7uWhgRIN9vkZkHscXN6YldTRIyMS2vJZDRkz8Vz3pUqRTNU2ycEZFc9ShY8QfAj2/ybUHY8vTDDkVxxDxR3JihrxtNBIz/eMUD/EGDZwTKjswbqahvanlWYeVBS4TlhrIDlCzrI6De4dIwe4p29m2YEXssPZHcrcjcw9o5npwmW3MErw7iDet+aYNSjSOO8E8FT7ZFdJMJYTzJbraajeKIKDdy6GoY2DPA7XoP/tmrEkn7Z4D1kX8CGaXYcSQwaBGvr7J7jwOS1r7ddd/BcsV7g4vSWdpwGj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAZHaGHpisMlEaA6zcJ8p7EYYIvgoG5q7MP7f3GH024=;
 b=Zq8W2UC9hf4ug4j5Atx3rkcRekQ7ISFa/z9YmMLGfBMpGjLbT4qM1DjH4aND+nUwhR7kgMCNPbZkNKlstqd6L8rSn47q2nPCxiH5UAhK5VTEhUluEybqEfEUNsXrR8WiWtm3c5FbRW9+X73gpqmX6LdHFIT6JxQDVab5IZjaOqFCkvKmJw1wUvs9hlorP0KF3vxXySiD+aKxJ876FVSm1/gYDEve5h6EkiqNsBtH+3zgbw9yZ05xeolpa3WAh4Krjz9LfFZET4eLUzH1snco4DMd1EHuNrtDKh90sWTwbRzH3KOYBkSXfbDes1l9DlmZLcq4IEBMhtb+D25q8r35wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAZHaGHpisMlEaA6zcJ8p7EYYIvgoG5q7MP7f3GH024=;
 b=b9wpEZNsWbpgewVWOQBfT619pf7UnMgHwT8iK4L20QQ3JqVvP2hF2PHgMqnAqgR2UafSSI+P6cAfk2+itzRqc7FMIZ6EjQSePhwRMegWXNQIGEUCWcLacftCaxAraEHE6ioTyNtRwN8Z0dUwb1DINlxpivFc/tpYHYtUeAmki4o=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3267.namprd21.prod.outlook.com (2603:10b6:208:37f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.11; Sun, 20 Aug
 2023 17:41:42 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.000; Sun, 20 Aug 2023
 17:41:42 +0000
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
Subject: RE: [PATCH v7 5/8] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Topic: [PATCH v7 5/8] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Index: AQHZ0b7h1d5wrlxLZkWDDoGloD35f6/zd42A
Date:   Sun, 20 Aug 2023 17:41:41 +0000
Message-ID: <SA1PR21MB1335384AAF2F3F53DB059540BF19A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230818102919.1318039-1-ltykernel@gmail.com>
 <20230818102919.1318039-6-ltykernel@gmail.com>
In-Reply-To: <20230818102919.1318039-6-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fee37bec-2561-430c-b4a7-d403a129831a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-20T17:41:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3267:EE_
x-ms-office365-filtering-correlation-id: 5e07e9e5-809b-46a8-c75f-08dba1a4b6ea
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ILM/Mt2B48rnluVvBEQyjyt+zuMaZ8K9fW2ILSNU5OH4ZNhfRlufV0u4UhbGNDhZCdvMNGGp/DjAtdQ6olQo5drdlx3AkM3WAo5QPx7TvHbIZ5xnTvWa20LaR87GUBqyZxI/Q3FW5wRSI/wPLJ7NgbYmkMeNt+G8e86GRCXHfdI8vxq8UjO2b6a+o8IF1rSOhvpdeFwoL6ySydi5bajTtFGHFd6XOyfPmMg1Z3Xncc3Whr0dlsAcqUNBSv08MIgQph4C6jibQiNVpPOAns7CVlGkaNuuVV+J2cF6R5DD/+wx+HbUpDvIwCyUGVD8pXzwM01ivWp4gh7v98uRLmBbFMVF8O0NgiEeKKa9Ti9dd9OeFDdl38QXodYIa6RS/sTgP9K+wuihlteRgO7fCLGV9cSRXP13XO+TH4grGGfTsjqdL3WPOwDWzZHslcJxkmb4hXmQvZPnADAV0Jd+BD56ZLPzqjKFL5l0VxR7I5uYQLyZGaDuz/r5n1+rCz5UPuhUFywyT8YPSALtO8YlK1yKyPbi7fj1zrVAeHO2ewhrFI0JoG2Q8F5wNaCG5fzctlRSq1kq0LiPF7ZCF1zOGXJTa3PAsrcqZc+gf2ZraeSp3TVftDqALaX2XLTFal1Yy6jXssJd+mNRcO1dj+1qBh/LSFRcp69OPfzyjB6JLneKUB/Mu/gN/XygZHtxOnsVtG0n5qI/O7iCfupzXdT5S/UIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(1800799009)(451199024)(186009)(110136005)(76116006)(64756008)(12101799020)(5660300002)(33656002)(41300700001)(2906002)(316002)(66556008)(66946007)(54906003)(66476007)(6636002)(66446008)(10290500003)(478600001)(7416002)(52536014)(8936002)(4326008)(8676002)(86362001)(71200400001)(6506007)(82960400001)(7696005)(122000001)(38100700002)(38070700005)(9686003)(82950400001)(8990500004)(921005)(558084003)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZKejMw+TFFPfJp3/VFhtZKp/i3pGOiNhJY5x964uX7t4UZh8HAXI81tZPNRS?=
 =?us-ascii?Q?gERuXo8033LJrHNzOZ2kSNc/8plmhabFY5fxEyP+vP58dxeTsIqHpVaytriJ?=
 =?us-ascii?Q?mqhuLkR9+jy1y2yvYwe2EZZsUxkVXlFPJZGycrv8oD9mb9yWaV7sKzUTyzrf?=
 =?us-ascii?Q?j71VXJJ/lgunW04eo8jG6ikNwDAooefyg1jTkVwknlvs53lscZnUg0HklA6h?=
 =?us-ascii?Q?BrCdL1q/xQ8S+Txfol5jlL1RAayOuE6fCIxxYrOzCQrjg/ESg0a+qvNmu7Tc?=
 =?us-ascii?Q?F7xZKYPtt7G/TN0OClQodGyw7sxbETP95buZ97ym6UtHrkLRd622HyW6h6rz?=
 =?us-ascii?Q?aGZYs1/6g6x4N+9kO/nQRJd+7V23wz+f9NIihXYroAsLKaE7zLmKEPZ09eVS?=
 =?us-ascii?Q?gvW/6X2XddsToS72JLChKT9TFwBFUINhLEzpSHQh8Nl9SIb1hv4nUFY3vR8V?=
 =?us-ascii?Q?Wuge1zAFgcRv3zxcXKCXL2PTL/tLZ3k393hgk72VcoPB0lmhyB6SfSyTwtPU?=
 =?us-ascii?Q?kGrmwCfPg79wcDocSmRrtNcgdI9gWnkACTioXlK51GuTZ7MsXhyeuLGNjL7r?=
 =?us-ascii?Q?yKPuIbrb63A/hKXZtYqujO8mKVa46Na/bzYItdc/ZGWPxbh0s1GITmS0d0gn?=
 =?us-ascii?Q?mkN2fhr5TLi4YpR6hflGlTGt8wTCC2ui2MusEEBPio+DMfrQ+3VjlZhH5U+D?=
 =?us-ascii?Q?TSCy16XUW1NAhSP8BM614olXCfb6XVbkhG154MnR74mz87ewIUXnBtFgQHI3?=
 =?us-ascii?Q?G4mC4Cgji9eANj6ZrSacj45Zhg43/nkXcURR6QKTIRqGvBYoO93JwjKOS3Jh?=
 =?us-ascii?Q?O2Z9aYfdVE1p/fXcw1Kmybw/n0b/gYYDXEjRuRm9B3qI5R4AhOHOzzQWz6EB?=
 =?us-ascii?Q?3obkqSggq9bOi5KEgGvuTjKMgbIXP6LnQ+vlxe+UhyiM0lq/LzAp1l9CYyQx?=
 =?us-ascii?Q?6tHDH48TnIPKnOje9VcrNwNLCeGZ8ygstyXlJ01oBLZ3Ctx8ulAcDztJP2X6?=
 =?us-ascii?Q?hk7tn03XSre/j5oyqpBl/8ayPSPyqQ6z4n8xiPFZDLYmQn4JQ4Ol0Pgeu2wB?=
 =?us-ascii?Q?EDPP7yJHBIcdS0WyskgKpkqqL9HC3+d3li94PYCLiH5zYXL708UkEI06Ds1m?=
 =?us-ascii?Q?trIYhfCWTFKkqndIFfpzq4Kn78+4F0NyhgEoOTdyQsr34exV+cxPgf3KA4Oo?=
 =?us-ascii?Q?jk/wefkkhPUQ17AV5JzK3Xp54NfYw6dkxhgRsIIJddD4zNpCEtCTQqsZA7Lw?=
 =?us-ascii?Q?m7zybJ3bUvEB/Gl82zG7Uk4+twI5qP+pXxc4otxp8PWah4WkWDSRW74ERH2A?=
 =?us-ascii?Q?Dg+I62UuCOCVLB/ikl1brf0cBxHO/fbfXB+g7+RFwi3eudw183xrb7foxIkV?=
 =?us-ascii?Q?VOd7MHrr30Vsh0TNhkQA2W5hFstjtpGw/YkMBsv2AQfSHtmuN8rxYamgRsrh?=
 =?us-ascii?Q?YcwcA2AXlK9//f+a+kQDEi4g7QCNSM0SN7sGlCdt6MF2dtueh6F7S+hI2P/0?=
 =?us-ascii?Q?fv+GfuWtVXcJLDZvwZib1igfEM52vaXmuscn80XiHaNFm4jY2r+RQeQHBKdS?=
 =?us-ascii?Q?hmlGM77bKjDr442JcZWwLOuie9l0kHJcmlr300SsrjS+V4Z1JaU8s2KZTG8/?=
 =?us-ascii?Q?5cGD/eznG8SYqRWYFct0stJnjeKEEUD9T0bcroZEUxfH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e07e9e5-809b-46a8-c75f-08dba1a4b6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2023 17:41:41.8285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBDSHv2xX+3K01SCprSEACUowTlPrV2f85SyFZgis8YZIbKoZF3//uukEWt13+uiAluynOn3Iw21HLQGoBcgBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Friday, August 18, 2023 3:29 AM
>  [...]
> In sev-snp enlightened guest, Hyper-V hypercall needs
> to use vmmcall to trigger vmexit and notify hypervisor
> to handle hypercall request.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
