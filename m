Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEAB5E7F0A
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 17:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiIWPz7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiIWPz5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 11:55:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F21E3C3;
        Fri, 23 Sep 2022 08:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvvEGoiLUvMBURDElJnIoVA/m/PoEeAuqcxUynh9PUUoTpdOyGzYIHm4vCcjIBstZrJxzZOu5A+FVugi7AaR46LeMuveh0ecdG0vxaUxCiezTiiVoKliNu5d8cQnrDFr+E6YPLdMewlbkCM90b7+I3xW86ekIxdggdCjqzUaLUFKyhQjZZBaVV/yDHVkdEvhZGg+/g+7ixpXer4fBcisxYxA4X9qNKanK2wKGq2lYlR2IVTH3hg1iemzfmD++BURRZE48uEDKXFEHiTQzexXzmEeIYUFiUyjeL8zehBoCZgDenBdGEjkwfYKIzn1XZGumt53osm9OCC4t3geV0kMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keg/8KTYA/Hh629e2cVZB/vptyEcLsGo2T3bV6uil2s=;
 b=MutAftiUXAUXSthTblfDgTuyQXbUcQQeeMTGAIBVeirw0i5UR5HxeMEuaQCdfbTMFgdbg5HXYUFsg3dcs09d7l8VkVBx20B2RkKg/y/e8ZppHSUhcr2OaDlvqZ1RXVZYnyRgxkuX4x/azoP8to/CSolU34D0QMeMOxL4+S9UhCexjVva5hbp2Ncad2K6uDbMxHSHOZ+Hn70KN1P7TICjmsEExkI4gGLQmm6xDUR/d2V9JHJSpd8NOKqmQl3Mjr0QCiGZtYDa3PRjeTG2Sb25vDXLggN0HUYjog0oF/MNn3ZrPEbbt72bMXU0PfPWcdImDV7lTUSS3z3hpbBqFk27rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keg/8KTYA/Hh629e2cVZB/vptyEcLsGo2T3bV6uil2s=;
 b=RtcFQKNIlRzdPlL1MESCG/CxiKz6CgMttOEwdfl0+TpwKLx7L7wJ+8MXpRaus/bOy1op7m02y1QuKmFzSU5QRZ9qGPdK/JPhNYo5tisu01tkhKvIwfQAGCF2jBPY5snhJutbe/E093NCcuYEEScPUx6WGuj7zatXisWy6Mk4JYMJDkBytdlqYgTaXtIsjlqKm6NNKSpfHQ+bcdDAInrvLGbZxiylU6tW1yPu5fcp//v/yf0Czy2NfHXCmAOqUQ7laatJnLozmVGSaIIQ85hSjHknrxn+Jgw8n/IioB+1RGAL5L2bjN7cQZnFibG6LRRi0TWTYVC3vVT/MaXxy3pk7A==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 15:55:51 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%9]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 15:55:51 +0000
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
Thread-Index: AQHYyMA9YvMyHkwA3EyvMDv7VnmV1K3gbnaAgAAIXgCAACPnAIAAECbggAAocwCADGDdkA==
Date:   Fri, 23 Sep 2022 15:55:51 +0000
Message-ID: <PH0PR12MB548166865BF446C7F232DCE1DC519@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220915050106.650813-1-parav@nvidia.com>
 <96457b14-e196-4f29-be9a-7fa25ac805d9@www.fastmail.com>
 <PH0PR12MB5481192DB7B5C6E19683D514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a8ee97f5-b92f-47a6-9b50-197974738ff7@www.fastmail.com>
 <PH0PR12MB548113D13F9E9CE4D5206514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9ae25893-f19f-4186-a19a-7fc55d9295ed@www.fastmail.com>
In-Reply-To: <9ae25893-f19f-4186-a19a-7fc55d9295ed@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7515:EE_
x-ms-office365-filtering-correlation-id: c10f550b-1781-45b5-9e11-08da9d7c1718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HmjuZ+ILWYa+IakPvn4iShToYBATK6nwJJBKNy4o0lb1kahDYe1VGMwaFPu1u9eKmuWYU0KhhSKmWTImwopjEaSfnpc4w87w6246Ulf4njuqvUHaypvrH1E85vufHOG1Kfkvg2wYO5/IwX3Ya7erUKvpu4Hty/YQHfIQ2pL2+ztxiomnR51pN38O5NiwI5T9tXopnA4bXzHyZ0ZCBCc1mTD0V5tIEFxcEYqTN2l0jeu7Fwy8dRIDDGOf7eCj3heBmK3sakCUrHG6XHhl9P6rBs9BuPpyD6PJR02kBMhavLwE4UHspG8oZWyEg1zZmcZ8Zw7dTeJcn20SsVnY7XEZkDRxM0rjY0etF2Ue31mYE994VNkBubPRxGtkYa2z1DsVAfk4kAXfElsJQB5LCeheGimsEqs457+Z91QmAfTBCPh48Pul2+Z97vEvYbyf3A+NQ8MQqMiQYok1l8BvHJy7ouevzLgpYts0n8CYNKbhNLs3yOqHIMZ9xB+nfMyc81Q4ZZHFCPPo0nEIY0vIOKWDTT0/4xbFSS0rz1G7F0xdJIC4ywvSQ/LRaKbk1QUhSCiLJPovsoI5EdCsRJ/WD7CaOj3TcwIegTEvHh7YhsXJk3cmfCiidwUGmOA5a97J75iF4xA7sqeLWQaeu5Z+C0bpQjgQSQDOWQs/ZGn5vBQzCYHy9zgQpFjiKOz/8sovXdPVuT8XQq68/di0CnlB3IZe2afTl66UbnHJzScQWUUSYW6NjZVq4Vck38NJsLcbqk0QcxKNy2yOoWi9J5zmYW+KDoNqQc+PZF56KC9EWea0SeA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(86362001)(7416002)(66556008)(41300700001)(66946007)(52536014)(64756008)(66446008)(66476007)(76116006)(8676002)(2906002)(8936002)(5660300002)(186003)(6506007)(7696005)(83380400001)(110136005)(316002)(9686003)(71200400001)(38070700005)(921005)(122000001)(38100700002)(478600001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QyouEsXzgJ5OVAcNvmNl/KiPIZbvwRMZWqbCYbfVWEySVSkjUfbSrz7JUvAJ?=
 =?us-ascii?Q?tH4qBXToZAVrvR2eX+rVC98aEnbxVaLkQwWvY940ndCBlRGG0o57OJejde9L?=
 =?us-ascii?Q?cdKD1x6FNyqk35KDgQ/ws//+x+wu8hyZ0EwsV0X4oFtoqMZr8jeGM9o2pz/P?=
 =?us-ascii?Q?guhxU8wsaWOwarFSXnIcTFaAy4nC5+/KFRyoLftklgDmoco1JWPEjFV2LVZ0?=
 =?us-ascii?Q?pvZWDiN2s3rXSr6lPGNNKiOJzl8yiW/AW4blbIhqDCWXiPUEL8z7XpZzGHze?=
 =?us-ascii?Q?jIMIfD+y9nPgUrRsW+N8yIarQ8SsiDsKthLBFG1S0JxwKu6Fqpwil61jDeo3?=
 =?us-ascii?Q?/gc8amkIYBo1KpOkAz5B+y+6j7X2awPBgLFVQcO/Mu1XreYsUp6qFccUICtR?=
 =?us-ascii?Q?MJTc83kuwilPKq0Jhnhzo6aM9SlJmwwTizRUvjpHc8T5hzV8B0SbTy40EZsE?=
 =?us-ascii?Q?wVlfVLsQIENsF11zYQ4Llc1V7cDu4YGLO9FDvmRE26Kp6JgZlIZY754hfTFJ?=
 =?us-ascii?Q?IvCYHpkpZSI1z7xfoYQbZLEV4KcVdUzGN0We48i5jwQnUTgrEwUQSU1Rtc3+?=
 =?us-ascii?Q?UJOHDGTzV48D4GQgMJ2bDobrdiLfdipiXNan9gjxnd40qQEdaN5ExWVr7Vos?=
 =?us-ascii?Q?rEo1pgI7mWYWk67/smmertmVMqG38qaJZL5AKHSwhc/qeAOHjQVBnn40Vg3g?=
 =?us-ascii?Q?Iny6qCOiRzub82PwjiAQG2EXU8MQ4csKrfHkdLGMpIvkq2549PfgyT1mCwcw?=
 =?us-ascii?Q?vR+KyHJlL6IdfJNimrPQewln9xrim85ZGMVfEzn1L/zFBpBgE0nABE5MYYed?=
 =?us-ascii?Q?e+mOjFzidcgw73Pz5NMtdLR4XCYJgqE/wwFMdhTulT8NAKTwt8EaXoSjuXvU?=
 =?us-ascii?Q?GuhxQO1v4hMvdBgBuVrWYlESBGMBljVQCgA3UgEXuSbX0e3kXC10nV/hXLBO?=
 =?us-ascii?Q?VY0cFCD4uYWDKfX84m13Bzl4EAk8xVyqmMGFlwBMV1kZ3nhA0d4eAixTrjTe?=
 =?us-ascii?Q?mZo2hmkmT2/4YzUy45ip0GBKvWax2OoZ6KT6nhKrP8rBzm6NZi+wThVwpHl/?=
 =?us-ascii?Q?C5rg+kxgxoO1Sgi9lbn1kE+694SAiXy5OJbhPbDzGxVRrItcg25RHN+aIU7s?=
 =?us-ascii?Q?rYZucpmP4dCuj5Hzi9ecaC26gDGwI/sdkEJH600nOYqDn3EPbeEh0Lep+64x?=
 =?us-ascii?Q?+T2r5whn0I1Zxhf8c9h/r37YZx7rPwRUiJmUtMXFXopPsCsA27dn6aoS2dnP?=
 =?us-ascii?Q?8hVwzFptG7l1QjnXU9VWfDXyI/ym91Oti4UqQu+dHfGP+fECQ1hdq3DO4z98?=
 =?us-ascii?Q?GPTiJZDNcw2W6T0ZDdk6gd8lgcIZ4fkdxo/tTSgy7EwwFYFKMt6OE3LYF+Dm?=
 =?us-ascii?Q?K8qXJsQcVlk1y9yYRFBgn962yjvw5EH+8Sqy88KyuVwHeY3aIiT/lFTs1Zf0?=
 =?us-ascii?Q?0qAoCsvXTuTXw/kZMahuw+0uE/lcfMdDbUKlXTBtpKVJJ5N6i/sBAERnPTC0?=
 =?us-ascii?Q?wLkF27xLWYqTDSev61IErrjV/b3YqKV+BfZEN777QfqLJzrnOckY9x3Elxj4?=
 =?us-ascii?Q?BanlLDeLxzWd7n3t7LKIwNLUfTJtdMhjxxQriKtsoygQnyFq3xkH6KmMqUg8?=
 =?us-ascii?Q?t+2unwIavDPCuS9pLF/Ztik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10f550b-1781-45b5-9e11-08da9d7c1718
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 15:55:51.5028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxMrht6mWFlWJ4tNaSzCaRjSWvAS+nr8JRuiA9HxuxlZQQI6m+qDFuHkD66miJyPPKlXICT5K45uub/KeU3b3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
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
> Sent: Friday, September 16, 2022 12:09 AM

[..]
> >>
> > I think it is worth because current documentation, indirectly (or
> > incorrectly) indicate that
> > "writel() does wmb() internally, so those drivers, who has difficulty
> > in using writel() can do, wmb() + raw write".
>=20
> I don't think it's wrong from a barrier perspective though:
> if a driver uses writel_relaxed(), then the only way to guarantee orderin=
g is
> to have a full wmb() before it.
>=20
Sorry for the late response.

Yes. Idea is to avoid wmb() whenever it is not necessary.

I will update the example description to reflect it.

> > And I sort of see above pattern in two drivers, and it is not good.
> > It ends up doing dsb(st) on arm64, while needed barrier is only
> > dmb(oshst).
> >
> > So to fix those two drivers, it is better to first avoid wmb()
> > documentation reference when referring to writel().
>=20
> Yes, this suggestion is correct. On x86 and a few others, I think it's ev=
en
> worse when wmb() is an expensive barrier, while writel() is the same as
> writel_relaxed() and the barrier is implied by the MMIO access.
>=20
> It might help to spell this out and say that writel() is always preferred=
 over
> wmb()+writel_relaxed().
>=20
True.

> Site note: there are several other problems with wmb()+__raw_writel(),
> which on many architectures does not guarantee any atomicity of the acces=
s
> (a word store could get split into four byte stores), breaks endianess
> assumptions and may still not provide the correct barrier semantics.
>
Hmm. So far didn't observe this on arm64, x86_64, ppc64 yet.
May be because the address is aligned to 8 bytes, we don't see the byte sto=
res?
=20
> >> I see that there is more going on with that function, at least the
> >> loop in
> >> post_send_nop() probably just wants to use __iowrite64_copy(), but
> >> that also has no barrier in it, while changing mlx5_write64() to use
> >> iowrite64be() or similar would of course add excessive barriers inside=
 of
> the loop.
> >
> > True. All other conversion seems possible.
> > For post_send_nop(), __iowmb() needs to be exposed, which is not
> > available today and it is only one-off user, I am inclined to keep
> > post_send_nop()  as-is, but want to improve/correct rest of the
> > callers in these two drivers.
>=20
> __iowmb() is architecture-specific and does not have a well-defined
> behavior. wmb() is probably the best choice for post_send_nop().
Yes.

> Alternatively, one could use __iowrite64_copy() for the first few fields
> followed by a single writel64be for the last one.
>=20
__iowrite64_copy() () seems right fit for post_send_nop() compare t current=
 code.

> If you think we need something better than that, maybe having an
> iowrite64_copy() (without leading __) that includes a barrier would work.

It is only one-off user, and not so critical path, so we can differ iowrite=
64_copy() for now.

mlx5_write64() variant to use writeX() and avoid wmb() post the documentati=
on update is good start.
