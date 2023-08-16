Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A0C77E9DB
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjHPTn6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345906AbjHPTnq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 15:43:46 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42987273B;
        Wed, 16 Aug 2023 12:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHpzKC3fvN4KR/siDHj6qbvNEoy0PaNx6V+CmDC7Gr2flzITdjIBc2g6D7eDJNSa5umP/SDnPG+b00KeSKDERM+zZc1AABybkhgCqjsLNxFLLcij6HOm3UcOyWxMYSfqnq34A+XclkcfCkInJurDHCoi2TDbqnzgCvp+Uvs1EC4oWYKshdSUuBF+x6gBZiquxj/SMocRaE2EmIUdseATsa+6Zs81o+ESR0Ylw4hkhPW4TLM2TZXmn05qdvnB8mImrwgZFOYmeggKmcHf5X0Drj2iNQBT7lqDtAW31qx/urTbOanYG5kwVJjQNOmPV9HZz7Sx4F1h+0eB0B0XRTkTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnGKLsmy76tn6fYx97kvaZNWUQlfUAd2LKd1eeLQU0A=;
 b=ZNdcczzMfP64HFTmvAudqbOdTGuBEpgA52zrFAJ6rNjVNsq3Q4J+OaJdhf3g39LrJIg6+UNeLP3QpQXT0jjDkKaavIGtRsIBlmRsJdUR9q9l0Xmukcbr7qtxtaiJiw3qQBDMrtZaBySUFp9gFpWC/L8AkYIU6mcAeIDiTlaOFEkKtH0BlQRbySt5aSlnJsKB/gJA+ciyXYgH2liOZde0Vmd8JueW40DPo0UUNr8mf4HpRS/8F1RAwTWiVfEWtPHrSMnJqcDDVXOqkPOhIugX3onJ3qYZloosYmQyqVovlEyVDAUk0gvPO+QCdN+B340bYLjC/ALSLhF7QjhPxQOOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnGKLsmy76tn6fYx97kvaZNWUQlfUAd2LKd1eeLQU0A=;
 b=XUjDG4r4D+qxzqTmKv/ZGRblgRrT/fvQAuCvwDqQhUz+qCFH60A1B+A1Tq5Oe1qMZeboVFt+cUgZv+v9IcvN+0A/EwDifdV5cZ7lVpxYrE7z6EMN8osf7NOZcE47zzTM4zPqUVdx9HVrvxraEUfofr0uviv8KUUcOMpfCE/Oxwc=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3676.namprd21.prod.outlook.com (2603:10b6:208:3d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Wed, 16 Aug
 2023 19:43:36 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 19:43:36 +0000
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
Subject: RE: [PATCH v6 1/8] x86/hyperv: Add sev-snp enlightened guest static
 key
Thread-Topic: [PATCH v6 1/8] x86/hyperv: Add sev-snp enlightened guest static
 key
Thread-Index: AQHZ0FqS2zI/x1ruDUWF+tZCuC6fma/tUv6g
Date:   Wed, 16 Aug 2023 19:43:36 +0000
Message-ID: <SA1PR21MB13352FEF9E68D3A0153F7D33BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
 <20230816155850.1216996-2-ltykernel@gmail.com>
In-Reply-To: <20230816155850.1216996-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b85079b6-9cb3-443f-b639-6a5198e058d3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T19:42:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3676:EE_
x-ms-office365-filtering-correlation-id: dd5d73c2-21d1-421e-2a50-08db9e9114df
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kH6HOFIpvsJWdk0k+1k7cXpj8TMM3702vyxha+b7Z2hKftM2UbmBhthHZRtaEJWcczUo1EB6Bkmx2rehmohrN90jrEysA9l2SQl/mKWhyPxg4x6hAxedpkTFCeLCGyMg9hfyGT6n7jp7wBXzb6gu6YdJ6Cx9PdSMhj8qAz1AEksZAIh6KgNfyAetMirSrwi48nucQcioYFeSPYmV22OJeQSN8TNfuxRenvAEGsdr7hAv2doMuqWHYKTWhXMwKljqObj2IADFl4vZl6fgVwFCRQOutLK4P0xw5hbJjJuLwNK/Hpix6tx8DYblTTdTokzks4ogVNeKEwwPnGWsgXEAsT2LPRWyrYFaNMkZug74fuvOD/cHz6wdA0ia42vaQT0TJIGt6DX7d50uxuuA+oJuXXRSEAHPedT9RqXtdRzmUVOIWVxCF17WiVjm0ITZLOSDvsW/NAZgVuhqM2xvikdMF5Z/rZUwxJ1w916I+K1+TaHpeATI6dwFHxJI0+vTStafGjcHeUzKoetXufnlB0uPoohlxK5nFHc/jshF6zLelBUI0TJ1NZuyNUMtl3MamoaufZmLRuydTbaR9tMkur+P+gaF5Re1VrPFfNkbVtR0kdNWOxpEd4xeCPzKD2Uk1B4A8fCi/mo2rrqRKcRuOaDQ1nSQeaVvEj4pdX1WD/km6sOLueoYi80aD5RyE1vBw38bfvHURNIoa4x+oZlBHyMlMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(186009)(451199024)(1800799009)(10290500003)(8990500004)(54906003)(921005)(82960400001)(110136005)(9686003)(38070700005)(86362001)(478600001)(7696005)(33656002)(558084003)(71200400001)(82950400001)(55016003)(7416002)(107886003)(38100700002)(122000001)(6506007)(8676002)(52536014)(66946007)(66476007)(66446008)(8936002)(66556008)(6636002)(316002)(5660300002)(4326008)(41300700001)(12101799020)(2906002)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DHNa5Yn6vrCdZ6Iz+yNvYUq8LUp8yjeRSNjqAcuoCxtPIhFPN20mIDnfx0KR?=
 =?us-ascii?Q?8muAgmxgtOPDpZdos0qZ5a8d/gotmnrYdjFcQm4C7pWTrlBdYDHROASHUpyi?=
 =?us-ascii?Q?bi/kPD+glziSErXVrhxgq3wOiuJ4J1BgLiV7Xodg41lNm0RMg7MzKZpIvMUC?=
 =?us-ascii?Q?aqCh4/yWtahV3mad3nIk6bGBBzFiiROYC+3d0r3iuOtUmuY7CxfxiqhtMvFx?=
 =?us-ascii?Q?Nx3AujCPZlxsKsIuxuopjaHRA5P1KlcJIHvpa4tSNxfK8xjI0Be1rRoY+HEy?=
 =?us-ascii?Q?680WnzM7QtZ7PmvP5+Lq5cnKoWoJQLDtdx1D4R2b+V2ceAUBOxXIaGsR80jK?=
 =?us-ascii?Q?R+5ZHnfew+DgegOr/AyY28zm8Wn7Wsh93oguzz6mqkDUqOxXWC4F30qjVSde?=
 =?us-ascii?Q?R4J9Sq5CCtqsUZTMUXRGKjJSLo1L6HPbDd/p5arDfmS56TzJS+Sh0xoZKroh?=
 =?us-ascii?Q?NCF+yqlvwsDg1Dv2jxL57LZlki8u81OByiys4w650P/ErHei4UuIDCvgI8+E?=
 =?us-ascii?Q?tyRC3XqYXVu1u2u+sUw5JyoVqwy/bQa3KCyne1uoyb9gq/L+w4E0FD37O3eH?=
 =?us-ascii?Q?lrK54Gc3+5cS4EmH1Y5O29oTKNBgE1AQVDWPvEINfuZ55L8TMWP4aRBUBges?=
 =?us-ascii?Q?OU9KNKq+vnpny7AIUU9gYUTBJBBzuzf+xYSGm8YBO+aITjHzoFk6w+Vb4CGd?=
 =?us-ascii?Q?7pExLXGC7lHzk38BuLU1JAJnUtH2TcJCxxsfxgLvFV++b+ly3+h45SLE/14b?=
 =?us-ascii?Q?RbpnWwDzXjKdQkvYC54Idct2DL+h7x6/jrUdOykzaXRChXIWOsv0yNiGB9NI?=
 =?us-ascii?Q?bK9o0ADyAJzy6FGd976K04kh+ls1Dm8wlYdUvpuX2CfVv/DahpzaVRPPNpp9?=
 =?us-ascii?Q?KdSoZW2/EcxFpHXt1AKUSRuj6r2YKzaltsZmx+R5EwmRLRuBI+KffLg5gNtB?=
 =?us-ascii?Q?/ahVEr5G2EtYlgsfBB5qhtBp4yBB091vDf1sdFaLDIpywYZEqKzGfwiSoWa+?=
 =?us-ascii?Q?1T5NwtN2UXirie/eiW5xFqaeSkcElkjq/wo5fOGnEWxgzQZxR3W49CMnFeXN?=
 =?us-ascii?Q?3ow9VjT6HiyoEX/OJccZjS3vwLzdKSYwPiLiLJh2kHw3LUBlgO+CNIfN0Vrs?=
 =?us-ascii?Q?vpQII5XrCUraFbbQ0mWWcZrxk3NM2zK6Ix3txaH6L/2naGFqBH1Lz5AeUt+o?=
 =?us-ascii?Q?lA8q0A2rDwdgQusULnKVPGAuj1aZqpQexWPhz4touSV534/+M/BFhiV54OKI?=
 =?us-ascii?Q?nBqZSCqV4gCeNssjzh5+7/VRXNOPWxtkO8WSqheFlUGshCWUaRlTGfnapIlA?=
 =?us-ascii?Q?Rk8VkDPYu0MTCRv6+TPICTFuAJpkKc7Fk2nh6PuQNMBSqlJYBVSR9k3ice/b?=
 =?us-ascii?Q?DUVO0cJJ8jnVOsjdcz4j0qca1rfXSQwWQMmHxeyyed7AS/5p64mEtC46mp96?=
 =?us-ascii?Q?7wqoyelI2qg4gHgwJom22predgmTSK5UiPmFGoZwHauPIqErYbE/h2MCCxJq?=
 =?us-ascii?Q?OUi38OSAeduSzh0x+4fDiIMxWB7Zmsrq436iT26zsQ9STO4N07mG8DvfL4C4?=
 =?us-ascii?Q?Gh4Ie5gHZtoHl/OYElewPCVBe5LbEH3WPlGwLm88Ok865kAfVWHUndCbjYPW?=
 =?us-ascii?Q?bUPEtKdRG0W1a3Mznp5VIA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5d73c2-21d1-421e-2a50-08db9e9114df
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 19:43:36.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H50yFMhbRr0iNSog1FPK5G+nTIO3q9QYxYGAKM6glko8F8dCKMmbbs4C1LutMpresM8NuRpadqa4kttUQCVyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Wednesday, August 16, 2023 8:59 AM
> [...]
> Introduce static key isolation_type_en_snp for enlightened
> sev-snp guest check.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
