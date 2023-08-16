Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3112277EC18
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242774AbjHPVnr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 17:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346637AbjHPVng (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 17:43:36 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7325626BE;
        Wed, 16 Aug 2023 14:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8BR36EV7zcNyCnmnA8Lqhw/WSwmXp6gvCKzrRXSpE2QGr8+zeOfSQkwEOTadiuQdxzHqy+Vcj+S2TNQIgKP6JdK5BOH96DPBlUbp408U33K6uehQHBwJfIS8NXpy70BXLCqjAKLiJPQvqDbleH3EvzEYTGPm+646wY+qWxFMKPWiZzEQZeD5bD8hWyCy+0/xMfLo6qkwPXNGET8tdH8yAu5CZQ51T0pCbu/ckS/IllCm7NXO9+mKaQ2WmPmL+NDyedsCCVM9Pkxv/qgSveekQr01YOuuTBFTMuQkPDAak+cQkaDAGGiL1IDa5cy6h+aGrVsNFZTy1SjUcVNAf14Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7mfhZSvmGzAYdT5a2/00jviei+EN6qBo481c601Qg0=;
 b=FdAT/7+jf10ta7wbGo8y2Wg9/Az9yF8Sft7hN75OGkh4L1wyKTP8vEZdTOp2acrHphhcNBDtZ4VYQBOlUbaPXHFbUEam0cn8pc3No6q8klceujqGalJAML4SpUr1TO2daoNpFuzuxYnXlEeuRm37yNw903svx9/JUhAZO+89h5b4QnZZw8uFOR/gr9btzH+KQeKVw5IiWkGiwzZ1G7pgTKdFDPZFZnX+Pq1kLaIE/U56o3eSTncUK/N9t0WL4eGYTDt/oWe58aHecVjsdqHmx5nt8W7hKihSIFdTLlNEtlvNmNH5TyXB9kAqHp8SXfk6QCvp+yUGSyquQyLSTGuGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7mfhZSvmGzAYdT5a2/00jviei+EN6qBo481c601Qg0=;
 b=V/yzozJzAiDmfGxGz6PKBEnE2OSzntNhAw1zlqiU8KHuq5B5E0nSskZkAsdDvo4kLA/b/juUx9tu44t7rY+iW3ZJfkC3uWPEhqeqlaUNO3uAYWDVkk3ndRnssL0fcEhPbAxia14Kb4yfzHrz2maAlqe1i7XAZ/eGMnN9Z9Y2md0=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BL1PR21MB3307.namprd21.prod.outlook.com (2603:10b6:208:39c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.3; Wed, 16 Aug
 2023 21:43:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 21:43:31 +0000
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
Subject: RE: [PATCH v6 8/8] x86/hyperv: Add hyperv-specific handling for
 VMMCALL under SEV-ES
Thread-Topic: [PATCH v6 8/8] x86/hyperv: Add hyperv-specific handling for
 VMMCALL under SEV-ES
Thread-Index: AQHZ0FqaMqPZBN6V00+vnaHmoqfPAK/tdJGg
Date:   Wed, 16 Aug 2023 21:43:31 +0000
Message-ID: <SA1PR21MB133562080902E8F5527731B3BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
 <20230816155850.1216996-9-ltykernel@gmail.com>
In-Reply-To: <20230816155850.1216996-9-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cfbe7993-2898-49f4-aa5d-1893e596ec83;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T21:43:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BL1PR21MB3307:EE_
x-ms-office365-filtering-correlation-id: 12d89031-1a5c-491e-4045-08db9ea1d5db
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: II4BKbO/Cpxxu7ihUyzkI+JgHj2i6gS1+rb5yvyn899X8hRzJAh+guWSTlhoZteUpkzAQ46ikBIRnqY1rM+/J1x+WZPfM80LkG2LnEhHLeLRo1INTZe6rpecwLKga3z+CT87Xk/7jSoz8wXpR9DzdBzfUSYlyqCNrNGz34ZUi26uIJPhcP/klWsYTNV5s1qVDUP4QJZZ58ofP1HQrf8JqNtaU/w0cvZ4MQ6fhmfaO322hFz1lzH0mY45fm+kFtEUY4pLZEIvLa5RXdcevsgQBfUdeAu3GNDurkutpZ1lH9ThAxzXk+CtSjD37CjOujnsZ9PZI0PgpeFM/B8yS89ZBhKp+DhDu54B2imTrZtSm7z31L4W4LFexoXP/FMbkvBa5b8JueJPoekbrTLvq/BBRJJUWn6CugyQc3+uQ4LBLxxFtMEP2qL7uhy+i9oEmLlvNfILwXYrkpjF1LqKv5TtL2SKkBk7rr4YSArZQo/KIhd22SllO/e49ky1I9P7tw7aZkvkWSpNDj+RmPTv8WdrgV1tDiDo7QJLbUVacu7FTXVgQ8nRuDC1qZJ41eka3eCU4YchS9nA5y1do1/DV9RNWGOm/Vbj+XN9IdPGbn8r04Zod7RI/nD3NXQQr2nuEUs/U6ZBVqiTj3g+v+VIhtkASgmcSyRQWo/BGfK0v8tKd88YOge7PsVV0T4V6KlMYDGL42uDM7tVWllzwLwKlLpYfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(9686003)(8676002)(38100700002)(5660300002)(122000001)(52536014)(82950400001)(921005)(316002)(38070700005)(66946007)(66446008)(66556008)(41300700001)(7416002)(82960400001)(8936002)(76116006)(64756008)(4326008)(55016003)(6636002)(66476007)(33656002)(86362001)(558084003)(8990500004)(2906002)(54906003)(71200400001)(6506007)(10290500003)(12101799020)(110136005)(7696005)(478600001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k4Q2GQsr8aWor59/Guohqs4p6GqANSRvsXNWsI3/9fpgyac/g3Re0XhIE6eg?=
 =?us-ascii?Q?kXU3xmnqHhwdIIwLdJ/vL+kr30VDrobHVb7fHmRCoAVD4qF6XCFrDQ8FieR+?=
 =?us-ascii?Q?f4ODm5ArahwqzT0+fFyzdgEsMd9z8w5+16vpqcaQKGvimBnZZ7ZYVfKccFE4?=
 =?us-ascii?Q?x1XFFOKz2H51zK2JxhTbGzmetuZ7WhM/WxYMwS7Um7R4Rqb5dLzDoBe1pWQg?=
 =?us-ascii?Q?IN02t8mu55Ctqzg0/JHMYKBbaj9lIdHGX9eNe9SOgVRADlTJdxEFHPv1ZIBt?=
 =?us-ascii?Q?ogCnrnfOtelhI3isZkfQBKGPHRODkaBU5XPMxgyEVP5Cm8bDxqT61kU8Fy7r?=
 =?us-ascii?Q?ndvaufVpRTpTWKMkATtgOkVSsNR8CDEnCgcZojAvmFa3t/BfJBt8XIPj+TSN?=
 =?us-ascii?Q?dlcpgxC8a1LAa/jGxhGp99xVPuCy6ky3Dh2K5Ysjh3k9LbrBt6dpiZPgQp0o?=
 =?us-ascii?Q?UdihLFxDsP/J21wmiIi/SU4mC9sabmJh2GundFVFJHh9/BgW01vIJQccuF2R?=
 =?us-ascii?Q?jio8BpdKBBSO8ltofVGh+tRtAwZwX3FkecvV61OkpvGaSxksGu0+cdl40nkU?=
 =?us-ascii?Q?MSkU5QcdZ7MKb5zJnhUcNsna2Qyv7LPEaScRrWr3pSKnD+yQSda1BJbbhjZG?=
 =?us-ascii?Q?bN6XVRJv52Pei71xv2E7skUb6glVeVtBJgrhTE6aKyBzln8tTq3ZYEpCiQ+z?=
 =?us-ascii?Q?ZFaDjYSg1ILBLUaKM7iXEJUenQPj+fiiHUB3uSWYLHEtmBMpyKJNXXRAFcvT?=
 =?us-ascii?Q?tBSWkv50OBqCeW5FZEkMXBDK7kmkuSz+hDVuYieVmq9BSQicnQyyAsTKmAKY?=
 =?us-ascii?Q?L5oyxkAmqnnM6cn2k6xwOqhZHzeLlbmVpfSJ+Q/RJPvds27BzO5aKTaSSIU2?=
 =?us-ascii?Q?LheEfnnMAmx72iNTTeX8MdWkzbf6viEpmmnkMrSWsryhBEpFeRiWuQ79Z4Km?=
 =?us-ascii?Q?doIYc2U4YN+qD7LvM/gWZlGVmcmvfxmVTq2f641CR2uvQSkfmykZOtHcbPKZ?=
 =?us-ascii?Q?YGotpYDY2WJqW4sN4V2WMPMuKnmbcl1BDXEvyQZVuMjNyc2YFEcFoaeyKthb?=
 =?us-ascii?Q?3n2z3f6xteMcEzL1UH7dJIYwUESaXMDIBd/ZYrpnWUU7c5q4+OEu9IQhWdVP?=
 =?us-ascii?Q?DVOz2MO2GbbzN9WJXuFr4A0Gn8FkXKiaB5gCa2PY3bBsWZiqHtoEaPEoSySu?=
 =?us-ascii?Q?18MnL0xPvXQJ3WRGWzZBaXtsHvdmjVyoXHJnH+twTOqjf0Fd91EPqwrqLGZM?=
 =?us-ascii?Q?VieiiklSbMQVm3T8FR398pc40rRWAPxTDDvSE1OkUHzWHPXABZMeZ7QJs/Tg?=
 =?us-ascii?Q?M29sZ6IIu0sASBS2FmdvgML+9wwPR+dTQaBU1MtbRNeYSX+bn3tO8dNE5e1C?=
 =?us-ascii?Q?sx2+hR29SmZpChcJbj7Qxc5zku9D9pyhzP4IJtddnSMOot63fj8F8NN9YwGq?=
 =?us-ascii?Q?+6R32s59BQzieZYatd8VQGcT3wYg30E7DBcV03dvnT33NDD1JM1Y1RRTWrS4?=
 =?us-ascii?Q?hiELyQU4IbyQ1BY5AyYAFF8UuG2CEWLwfYs0L+5oeGooQj98yKZeavUTXVh/?=
 =?us-ascii?Q?BsfwsdZBn1AnDNKNA+Ir2hRaadq/8b3CY+YmJgrOGlBGBlkDgz5Xre9TjcG/?=
 =?us-ascii?Q?O71cwgrsat5v14mQF8BrqjQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d89031-1a5c-491e-4045-08db9ea1d5db
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 21:43:31.7395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzpjGLdTEg7cRxgC33u7JyL/iahznS9sVUoX9gzv5BkKgYZzmUysoJeiDm68UUrT51Icu3gHZqfLsQakinW89w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3307
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Wednesday, August 16, 2023 8:59 AM
> [...]
> Add Hyperv-specific handling for faults caused by VMMCALL
> instructions.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
