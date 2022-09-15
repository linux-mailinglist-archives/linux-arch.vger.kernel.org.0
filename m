Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C505B9CC9
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIOOSU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 10:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIOOST (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 10:18:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C558B5756B;
        Thu, 15 Sep 2022 07:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhw8l4wzTj5hK0ten3hZ91AMdPqa3N8wuFz+l5+KMUDt9hFJZYFgREX05N8pvwGqx9DUIlP7DmZRtTm6aZSi6HumLTz0aHI74bHFfqoUfseyJmCJ1XO4HsdulmSxz8Yp018u8aqHOYQ/AJwdJCc51xIOYACFobBRt/nUzutBxjDOEDkY2JQrMnGI0NTj1UXZ5zETNmyBvpmqbsTJiO9LaYSYEVG5lvzPLhdOJtCz6l0QIQH+PsvNyncE3Eyli1+uWwWNbEMuqcaNifl4j3hmn4/3vofWiQbX27kpJ+BtvJeFGvV47PlvNGIuYCZbkNKG9jt9MJLxu1zjhuosYgL+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PTtfh2WqJrjUDO/yi+uESM0WQ/Sp0zHf+EoR0D07u8=;
 b=B4u1CpiseNYIHQy92A8nYSTYp9fltX8xHXNjSrpo/dMnpYMLOPhH0rmhPG0YcMw1G6VODToBL+zD+vBblnvZgS3213+1RzQHoEGNR6AZJiCftTqPe6R03UGqFTNM6r5M7ixFXpfW/5Eh/KRb7xDaR4KSF3rpfiLwJxD/FYmZKmmEm/GV+unWYq7yEA2x8wr5xitY04VqJySnXO+c4Mz7USGVJHx4gwDyXc89FjWIDWcj0tTaLrnrFKs/tHOuudb13OmrcnMx+83uq0ZWfv7GYY28VDFjKj3TncORR0wHVxF9sCvcmojjLIQgdI0Q0PHedNFoNGw2/rgM72fj8IWS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PTtfh2WqJrjUDO/yi+uESM0WQ/Sp0zHf+EoR0D07u8=;
 b=EQDVk1RR/7gUV4J/XcGnZHOtt8+q8iHmGeFpZtCQsG4EDrnyrBfUVe7CF3mEFKdt6DuUTz6YAGCb/WuC0rE2f/QCiIBxbFjzLaBME2EVxNJ3m0LQT7bsdIPckNNZx/sXk2InMQcLaKECTtp6KDz1ScNz1sMzu0G9Vue6YF2mvrsZlhqzyp2xlWJ5kfdwiuw0s75JEfpAv8rM5MufAa62hw/gN0jAI03mRizJKG/PI+F8YjsayExoiNfo6JtSwYQfnf0MNRIFeUU0EvY3BArmjVRTSBKtfOZ4c+o3953rBkGVsiEpmCL91abIA2ZiUgjinrI7JhEtoADpszqnWbZ3ow==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Thu, 15 Sep
 2022 14:18:16 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%9]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:18:15 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        Dan Lustig <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Thread-Topic: [PATCH] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Thread-Index: AQHYyMA9YvMyHkwA3EyvMDv7VnmV1K3gbnaAgAAIXgA=
Date:   Thu, 15 Sep 2022 14:18:15 +0000
Message-ID: <PH0PR12MB5481192DB7B5C6E19683D514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220915050106.650813-1-parav@nvidia.com>
 <96457b14-e196-4f29-be9a-7fa25ac805d9@www.fastmail.com>
In-Reply-To: <96457b14-e196-4f29-be9a-7fa25ac805d9@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6727:EE_
x-ms-office365-filtering-correlation-id: 9c33f1e7-4004-4c49-15c8-08da97252194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hZA2al4zLAzsbA9oZo+vEWTCrKqd8/UQVDgMPn5fprSzySP/6b019lFY71rKtYxEeZGcXKY1I8Cu7D9or6ST2NMD2eKDsSykxZaj/5q50AwQUxDx6GOxTtmIlDRevzb8NhMBoYTRU5BHzg+/9MieRt9MW8g1UH/3Absn3ktrUraf6rVX0yaQ5aHnNJw13gPj5loqbsjtOGOOu6SX2q5ydG1zW6DtR+2/hz7EVbPxj3j5O/y+r+Sv4GMuqC8bHQMvyMveQfUf/mPEewn5TXneVoFoNFQnslwrdyjafN7qd90VAE5Uw060RXtA7c5pl0O9wsCXrKEinPGbPjIQHO7idEfpK/34/+5BEJ6LwqB0aKpCp+UjwHU0hLYd5RgheJ+MWieOVznivbKHi9bTkdmXjiquEdJAb0JLsZOlQhin6LaLLsGQv4EbycUwWsxAXz1DExtk2STti97ogv/dqimP9tvaX4wmyvQAEmo/DPoDY3PpnKNxetTCZh6zgRFK5j25Zem/3e7dGPjOIuRPdmsAMXDiAv57I9ZT6e9g/2iK0DB+qFs30edpNL/J1yQyCFIVvtuyyMFCZg1dPVVSBzsYmKPurReP0GjWF3M/isHlgunjaZ7aju/7FG3RGvRF4lI8M+8zC+EVtEdgxFQs9uMH9GHe/qrZygt8RrWD+ijC6mdIAG4KQ3Xwk82reOzv+cP0NvK7r6s9+sB8R42ORB/Sz/F00VanrQcHwZbr1wDBL7Gl54n9ygfcIH1iojGs9hPeWnc6SfJvxCAl9EInQKriscRhNF7DSRsXzwixxmFMy4Trj49VyOZmZWyQWDRv4Ufmgp9oX4Jy1a83Ws6wIzojMDDQbIU0brBx4KdYDGwwudUinijv/XongetWYDhhTBBhVCPrH9RQqRnC/9ZW7OQeIn/46yBHgkPOdxafcekV78=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(7416002)(5660300002)(38100700002)(122000001)(966005)(8676002)(921005)(7696005)(66556008)(64756008)(9686003)(71200400001)(8936002)(38070700005)(66946007)(76116006)(52536014)(478600001)(6506007)(316002)(83380400001)(186003)(66476007)(86362001)(55016003)(110136005)(41300700001)(33656002)(2906002)(26005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ibt43f1gkSpaGW/djU/XnB4sQ+Wy4coJU4YIXMGrvtVikEXYB12nZxkgF35Y?=
 =?us-ascii?Q?qalHc2Z+JeUfZzV0PFlB+KHpIZZzbgZJBJJZ/evC7RKPVgVTN4bauLPrOtFj?=
 =?us-ascii?Q?GvCNzBEWhdNzvQh+eikN8XFWniEfRmngOV4M1hQ87wQ5uIHJbnFiM1YpIB0Q?=
 =?us-ascii?Q?GkLeDzRhFBbR7EThS6mI38VD5Asvn5S25salhvsLdxmYZ5fuE+MdjJQOUFur?=
 =?us-ascii?Q?oT+6XoTBevYLt1fiJx5MaSRB3O4jZbw80RBYcm9eSCK6jCmz4/xj33x29ft3?=
 =?us-ascii?Q?Kc0S4Qu98wjeMWgB3d2QlY+Qlz5ozIPLVgpNX1j9w+brH9JSRalcB17P5xoc?=
 =?us-ascii?Q?+eZlbgGdv55X7hP3FIi8WMUtiGg9QTW7d7djYN5yXxoHN2pkPZR8Nl48taCr?=
 =?us-ascii?Q?HJXdcyf6CRyNGxLnuxnDd67kJMI6S0k2L2OC/8iPh/9gLiYLJZUHSyHWlpjO?=
 =?us-ascii?Q?r+RbiIS4YEk0Kv0F3uuiYD7vjBBw5qTZyX/5JJRtoVMoRay8GAMlQSVI9l1o?=
 =?us-ascii?Q?CxH3qSzovbFjhBPhlg4VIDjPzhyu9GgK9HGwRRD46RFz74iy6Q1qavxS2sqY?=
 =?us-ascii?Q?RSkUNvJ2ahbXXjHw6OnHJyFQueCPi52QU61R0zCWuEdwuSiFJPcmn239nTm1?=
 =?us-ascii?Q?A72PR4EeUzU+fyfWeI7molOCXr2QybbQ5njRpiWu2T5+bxMZbjSIvK1LQnxu?=
 =?us-ascii?Q?4YijEz2C0Am7ra7otlhryBc/4EZia7MED9UhuppfnaD5Fga8WCaOzUNx5rgn?=
 =?us-ascii?Q?42d14nry4PYagz58J5om6sKy9gTDpGlZ1s5YjSHDp1LajxxRxeptfb8xup3t?=
 =?us-ascii?Q?7Xa4tD1q6moqlCRvVdBA5zWQjLam0CzgYJKI/QoMGUE9DV4fioih8wFB1gwM?=
 =?us-ascii?Q?PdkxpOMFM11ZHXicLxmO24BCWUkqSMLT1Wlrz6o7ckjuZ66CnIv68rFWgOp2?=
 =?us-ascii?Q?GJ7SINcvXc7B9HeHXCOWcg/cN1woerXiWfcrAyx3Slf5WUTMQmhymkvoFvKZ?=
 =?us-ascii?Q?G3UiNnE4P75wZo0bKLMgfNpZ0KkBzO54LBSkBpEN0RFsRHXPUCAIfaOC+/KD?=
 =?us-ascii?Q?cp5Rj/IhhJuBzyAKtlJMTa05V3DQDWiewV/W6Vak+jFUpEHkpfr7MDNaOksU?=
 =?us-ascii?Q?DrxlekGNXqpj89a1TsNCV+59Xg1VO9BtCzYceWB8x1T4cfjkPd43MX/0MiIZ?=
 =?us-ascii?Q?9UOzlvlYz8Llv8MXYLR58op/l06yrbWZC3NfF2mH/76a8TAaSX3gYHcneFPC?=
 =?us-ascii?Q?atbErGs938i54jwRNT+MmVcCd19wDDgPBLMnyPvVUsziRO4HyOBAn2djTO8R?=
 =?us-ascii?Q?FkKPYGnghhSHwOighLzthxZcSobt9THmphDH3xDIxInJr4KlUeBATNENoh+q?=
 =?us-ascii?Q?hQRj1ubsl9gAUlXRTmanDesJnCLGlxOIXY4ewnlBFUvf2Azy8ns80+4Kc89J?=
 =?us-ascii?Q?VMGbrGJ5i7kipSdU/yLSOyCYDqvDrInuLZ8EfTqs9zj0jr+atMi3sTtoNPnQ?=
 =?us-ascii?Q?XX4ScyM5VTSiWFyZIgvCnZISKDRO/wNdw3O4z+OMRgWyqMVD9uDsJDE9i1z7?=
 =?us-ascii?Q?HBzCFSs0aC5uTHRIGQ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c33f1e7-4004-4c49-15c8-08da97252194
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:18:15.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YwOJM9lbTeta4dUkQ4dTVTV15pXcbML9ziBgSCxWqnJJWmThGtSNyIP/KuKPFwmBtFe+R1XroKVqFlqpK+bM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Thursday, September 15, 2022 8:38 AM
>=20
> On Thu, Sep 15, 2022, at 7:01 AM, Parav Pandit wrote:
> > The cited commit [1] describes that when using writel(), explcit wmb()
> > is not needed. However, it should have said that dma_wmb() is not
> > needed.
>=20
> Are you sure? As I understand it, the dma_wmb() only serializes a set of
> memory accesses, but does not serialized against an MMIO access, which
> depending on the CPU architecture may require a different type of barrier=
.
>=20
> E.g. on arm, writel() uses __iowmb(), which like wmb() is defined as "dsb=
(x);
> arm_heavy_mb();", while dma_wmb() is a "dmb(oshst)".

You are right, on arm heavy barrier dsb() is needed, while on arm64, dmb(os=
hst) is sufficient.

So more accurate documentation is to say that=20
'when using writel() a prior IO barrier is not needed ...'

How about that?

It started with my cleanup efforts to two drivers [1] and [2] that had diff=
iculty in using writel() on 32-bit system, and it ended up open coding writ=
el() as wmb() + mlx5_write64().

I am cleaning up the repetitive pattern of,=20
wmb();
mlx5_write64()

Before I fix drivers, I thought to improve the documentation that I can fol=
low. :)

[1] https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/hw/ml=
x5/wr.c#L1042
[2] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/mel=
lanox/mlx5/core/en/txrx.h#L226
