Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EAB5EB95E
	for <lists+linux-arch@lfdr.de>; Tue, 27 Sep 2022 06:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiI0Eyj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Sep 2022 00:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiI0Eyi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Sep 2022 00:54:38 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020026.outbound.protection.outlook.com [52.101.61.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1870113D13;
        Mon, 26 Sep 2022 21:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfLDo1y76BGotqxfmSBYvQcGr0nZcRihBsOMysxsIZhsHqf0xdHeJn2ao75d78s5zVEDPyyNT0U7RqUmTXeX7u9fJx44X7zTNElsXpe8br4TU+9rBF+OlAjUi3XiKjegJzEqlz1Ct7meWgLAJPb9mdKVJemWU2YOQPvaroMQ4NAdr08P2Ba2WUwpmU2tt2mGQ8q9g0S0cgO8ANYV3Iygo6OmNLAeXmOhQR/MI/8qZbIOFJRTFKnn2F/D8L69zAtzenJ9bDtDI2ufLuiTm+JKwfv6sSQA4f6EHv2hBhO33jS1nKpc65VC+yZRxnv0R10QqvxEoJsijCxNDITu16L3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfFdvC5ZogpnJ6fQOJqpWbxj0vAz+LU3C7aAmmkdPG0=;
 b=Caj16xUhGVNmDOJ4D0msoWm2pWMYB97PEqOpN6KkXmZzYn4l6Tjgq/v5YC62cF8baeLa4CPuXNcYmlA70ptr612GNKT4gtmwJCdZcfKgW/FurDiTbF1hY4NwcxjaSebyZfFVDiLe974/tR+4d4toJPW/RmFByCm8+0t8/thk5Sv1e+RJV0m0+mNxrk9GUQDCT7urGO1FIpTrLS+443boWbhBbLrF67gzGq31/CFRkZrhs/rU0gJGqeUHSxLbkq4gG4zrNZAc2+Yn3kWz2MvnpHwGZVv29a44IILltyD/+WVCrMvkIGfZQKxqC9eY/fROEUZvmZpEVSwYVI14P7aAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfFdvC5ZogpnJ6fQOJqpWbxj0vAz+LU3C7aAmmkdPG0=;
 b=P4Y7zhHJaUz/4DYIc460Wa4bhvszV/7HN0DE2SD+WefUtaeDAzHkVAaQ2JNMw4Nu4OjLZFXipUHuX6uvmOHwjLK64glLmVYNK5Nu4sOaWDEdIxQzcFEGJFDvHa7tqioG0gLYQzufkfY5ifMtL3s10spS8JPYwDajU9gs0CtcqaI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3731.namprd21.prod.outlook.com (2603:10b6:8:a0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.0; Tue, 27 Sep 2022 04:54:30 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5709.000; Tue, 27 Sep 2022
 04:54:30 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Olaf Hering <olaf@aepfle.de>
CC:     Li kunyu <kunyu@nfschina.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3] hyperv: simplify and rename generate_guest_id
Thread-Topic: [PATCH v3] hyperv: simplify and rename generate_guest_id
Thread-Index: AQHYz0GurzqyloJRkEuW72OO+2hVKq3tgveAgACIcrCAA1EjgIABXoxQ
Date:   Tue, 27 Sep 2022 04:54:30 +0000
Message-ID: <BYAPR21MB1688B51C9C5943738ED0DB0BD7559@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20220923114259.2945-1-kunyu@nfschina.com>
        <20220923230917.1506b24c.olaf@aepfle.de>
        <BYAPR21MB1688890F578A59F69DEB55C1D7509@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20220926095649.1f963340.olaf@aepfle.de>
In-Reply-To: <20220926095649.1f963340.olaf@aepfle.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=32451516-06a7-41c9-8fbb-99988f8c6744;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-27T04:51:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3731:EE_
x-ms-office365-filtering-correlation-id: 5cb4127f-6d48-44bf-abbc-08daa0445d23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FUPTwnOu4GKuIBxlMYZpbQwaipv79RRHdeCTvVEFO0R/waAOVAqFDirLh8N7sD7lBj5JaLeYpy10Us9B1aaFb0189j9NloTC4PBHGl+a3k2yreCgOsbMPDUtRrs2EDpvoWGkFAwRf4UexsxXJPgXVJ8ItHa1VCJVjLTvgXTcXI64YWoLNVTIn0U9HK7PfenzbA8mAsT0nyj8ImV9UhpXcO2IRn0fJQ43AZd/SS9lzEfFxc2cizBUNBRdMWM8jMibCORKhmS5vNXdurUwE/u5C+1BPfPNN/qiCVxi78hZVjyHc1Gn7kg3v4ehBZzbeQbC9iqIzfTk9NHEXLEXY3fZVKzObGIs9JrIMuihtlVoJDpIcOTgWJjoFvWPxZrdQqAZR+eHjmp1x9MDBrvNBWiZM5+YqYfQ5oEGysJwTftC+C28OEXte3LYZrC/lFBuwz7SbE7fNju8nl1T+ElaBCZiwUbMQt712Bq4QRdO8gQTJOHIEqc1HWjWMWKV26ooGE5D3O28/WWdB2BZLf7IKCJQIdET7rGlwDbHOmbltPr86bkJAT2P5IalMmzC5nIv3k5qGMubhRJAiPdV/yMwZ3JIMQKFTqumQN+XcVpjNQjCta+8YH4wNsE27Xi80A+Jmag3KZkmNymIWm/Cemcp68Hqf21TAiwPCl1P18bYbFmXfel8dQ8ETpfO0KuK5YwYs4UNI0C7RURTg+M8kSjt0SaRkIdFBQR5tttKwWm2ZMPWeZPIaHo3dwWB3NsXpNPrWSAvrLOiF+KgXjsozE5RcRT5Ioi0FGiQF6LW8pt4AtYZhZ4pgTk6VXF1Vvpkri1myKMl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(82950400001)(38070700005)(82960400001)(54906003)(6916009)(316002)(10290500003)(7416002)(33656002)(8676002)(52536014)(8936002)(86362001)(5660300002)(66556008)(64756008)(4326008)(76116006)(2906002)(55016003)(8990500004)(66946007)(41300700001)(66446008)(26005)(71200400001)(9686003)(186003)(478600001)(7696005)(6506007)(122000001)(38100700002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qo0NrWec5pRt0pT3lHRihn9cxoHBQWg7PTdjRcRDCla3V5bNZxwoYE0o0uY4?=
 =?us-ascii?Q?L1lGben7aEYqkbWNnejPoxuOJ0GxRoaUckYMVJvdaJP9pyhYBZ/WZ4lKb/id?=
 =?us-ascii?Q?VLcMkEZVaxT2FZQzH9Fg6cWZ43FILLeqpIJtPjcQMreTM4+59UQvOek2uXw+?=
 =?us-ascii?Q?BBfnhYZfDTzyq0+ThATntFDTmsOYLzgvEbhKVWRUZAm4WIkVnBHX64VZM3bz?=
 =?us-ascii?Q?cPIeyPJCK0w695dU5m34oY91iDf8tTLBosxLl6gu9Y3uHTlIlXb04RVbOCWv?=
 =?us-ascii?Q?Gp5oJDysnmv0Bk9MaZlcbudsq64WgHF6vWPCEUuK3pO+6RN6I+oa/AHbXF/9?=
 =?us-ascii?Q?85rCbtLQWYzAxRz35EY18HORqblECCf3g7BqsoQt+1TKjNlSMqtW06/ZspMN?=
 =?us-ascii?Q?rXEbOTMjF4hJVpRYNCFwN6cLoGa6LGMImAtE4Wdt18LV1CFxCJ5dyCv0huvd?=
 =?us-ascii?Q?SHCeYs+2Xpjqi04/NI2GEQJODb33EbZlMJg+DZmDmttDjfCOaETnk+DaXSGz?=
 =?us-ascii?Q?yvBGRAcEcoPn4frxoA4qTrTEPuxV40mF7G7yHIvKAe8XY1L+KgqbdilMCBiy?=
 =?us-ascii?Q?x90r9HZb5phPMoe/Vbka91eF9MZfbCfNeBy+XTkfur+sM/7RReIYj0yLefwI?=
 =?us-ascii?Q?UW1odJT47ydNtTcZSBR+Av6Ly/W4oMFRuddPsmHJrNOf9rM92vylDjkt1E1b?=
 =?us-ascii?Q?tCC0VtiJXwMRKmMmyBq+Fbj01YWIVoYMlTtFyx+AxJRlbXjQZjWaCyv2ar4s?=
 =?us-ascii?Q?i4gIcRLQ8BzX/DuK80rn00LTlA3JccJd/UUmw/t0V3p08Sepm/V9x8tgmjcR?=
 =?us-ascii?Q?A6c1GJhUrm+zlebnnQB2lvhyy/NyomgXisz92Ci31zSXIgL0BB2t2aHr1a6K?=
 =?us-ascii?Q?MJPhHrNfQfnh+BDq4Jn8s7ffzq+3BqIZrlrDmQ11Sqx90JUHqa34dwecDzsY?=
 =?us-ascii?Q?zsRvBQkTeon7OCtBFXKYN93pyf6/9PT0VRlYUgmUeTiCl2V46BtYcsdpUiyY?=
 =?us-ascii?Q?kHHaMwaxQCYIyzH8b1EbBZ834eq5gXDd+3VHLByUDmyGdifCcWl2q2bz6jKJ?=
 =?us-ascii?Q?6JFyYVgsZCDhcBo/N2aWiLCU2DkWlm5db9MjvkPlXCuOpMIM/8lnXm0yw1gw?=
 =?us-ascii?Q?PuRDEE0TweUS8MKxLlithcRYkxsQLDh2F1ZXq9JwA9ZRbRUiZSK+nF20HV+y?=
 =?us-ascii?Q?VWA3OwNo9Kwxl2axwOjB293KM78cV2+rK9Ckegl/QgsJRXkKggNuZOQ7I1dP?=
 =?us-ascii?Q?sqXTrdPCBGzl4syy1I2x0ReCfuB6na0h7MTJkfyD3dIMciyf6rFtanUntiYJ?=
 =?us-ascii?Q?J3gOJbhHGvRsLBFbI0Q9WaD/GnGkIVkwv/UHZVw3WHo2mrqV2l+UT/VTo78w?=
 =?us-ascii?Q?zA2cCjBNbqg79WAaZXTltoK3cTmZTGrhh2xss+3gYa7ZlnRIuIHKPL8IyCRz?=
 =?us-ascii?Q?D6745R+oShyhKyerxyAvYGsQBdI0yHfqP/P1CcIxcCdkpjl5Q8x/FU71dawI?=
 =?us-ascii?Q?fECyjUQizBj2Gd7ZTacGcbTtcuaxWPTNAZzggIm4MZ0qgOALqtHq84E1oMEN?=
 =?us-ascii?Q?gx+ACka3J2haQTXkRsC+L5622AQlTSUTy6rD90O11WJViipLaNnA7Re+0Kmg?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb4127f-6d48-44bf-abbc-08daa0445d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 04:54:30.6716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnpubRIz8yplPd48zVePUG6ho8bektwD4OgWmG1oWbopys3uaYoptPjq/fbdRSP63VNT7Mnh0TIQVSEXfqExCRXEwkJwlXthknvH51OZ/XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3731
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Olaf Hering <olaf@aepfle.de> Sent: Monday, September 26, 2022 12:57 A=
M
>=20
> Sat, 24 Sep 2022 05:31:34 +0000 "Michael Kelley (LINUX)" <mikelley@micros=
oft.com>:
>=20
> > From: Olaf Hering <olaf@aepfle.de> Sent: Friday, September 23, 2022 2:0=
9 PM
>=20
> > > A very long time ago I removed most usage of version.h AFAIR,
> > Could you elaborate?
>=20
> It is the cost of 'make LOCALVERSION=3Dx' vs. 'make LOCALVERSION=3Dy'.
>=20
> Too many drivers will be recompiled for no good reason as of today.
> I claim no consumer below drivers/ and sound/ has a valid usecase for ver=
sion.h.
> But, someone else has to take the energy and argue them out of the tree.
>=20
> With the proposed change every consumer of asm-generic/mshyperv.h will be=
 dirty,
> see 'touch include/asm-generic/mshyperv.h' for the impact. Therefore I th=
ink
> only the two existing c files should include this header, in case the pro=
vided
> information has a true value for the consumer.
>=20

Thanks, Olaf.  That makes sense and I agree.

Li Kunyu -- that means you should "undo" part of your patch.  Keep the use
of LINUX_VERSION_CODE and the #include of <linux/version.h> in the two
.c files, and pass LINUX_VERSION_CODE as an argument to hv_generate_guest_i=
d().
Remove the #include of <linux/version.h> from include/asm-generic/mshyperv.=
h.

Michael
