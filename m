Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A832603401
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJRUdS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJRUdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 16:33:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B61BA938;
        Tue, 18 Oct 2022 13:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjFoiozROYhMJyIrZr4zLZwx3KzrHDdWDUZ4gu8YFqmi+HOgBQ6+NgAUI/58YTjAGcBZWB/6jVtVz7O6SH0JnQs8eL7OKsU9aIQ1+GWSCU79Yo4fydC/Vj3hj/iWcQSLzb4XB+I/dah8VvQL/H7aVeQVvMzGfUEJvE1C7T+vF6S9mva5/AAbeeJVeTSMZvlMWzJYUOj49hqe3UawGcGiDuJSkH7hFYIZP+vRP3FLEJ/JFjbgAuoujTqk/k9RjOvbyUamv5NtgoJ7ZsZqFoxGpOJvTjBaOP1rQZFpPG8lmIaM195JA2t+ZjZzz6QWoXgvpb92fZZPmo1RuC5Q/Uob3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyv8sZW22LRXcosbyImr2bSk42/tWtAnjGKSk7wEXCU=;
 b=T2SOQJKEXl8egoL7C6tYF0zRKcrTUqlFZ9PYVifi6Pz0DHx+RxyJ+GAX2iXexOHtFTVLk8Im5XL110YVqaxi+VW41Xd07kNNl7Ii2NQzG7eCi7s1yMTheUOlkAawjjNUJk7zOJFM9Fx08bIPW8y6J0aXNQCiNogVh7upR0XmFSGUU/h0z/2DP/TZyURa07mGI5GSE54RdhAC3ITIehc4P9QWpmDKR5hs0zxW6o9gPxn9nnhv5+Xyj6AIaL4fpEUdPebg95x5Y1w2CZnegYEo+HpoWyOzlJIv3UquVlgLSIUzbwK6R1H1CmoxK3L3fzc8n10B5W9Xdmix25BrlZRAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyv8sZW22LRXcosbyImr2bSk42/tWtAnjGKSk7wEXCU=;
 b=jW3zNqlVLDQ36i7vBrhvzljcRYvx/c7FyiNvwzBM1QMnqXNHb8DEqr4KZ9BPjbMshGnk2nTwfVTtLvOOSqSuOuozYj08Q3JOreEB88i8tObxKde0dha39foxe/LzZmnrRSDTTvYV4him4h4sFW6umU2Czpo6pt/dV5mFjhw0GzHzzYhXpRholLVwB7pEtoshmBe+Oxk5CNyJ3irKHBKJnZVhv+4vW0y8BP/MwjP54MRjaCCgA83xgaSIOwFgC5ZzRWzPkYgZGWJdvA1V7R73VBnhR4QwChVEdvhw+ipB2E049MmDgyHDp8h7NkZaW6nEIAJycSc6aYs3hYj+R83X5g==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 20:33:08 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 20:33:08 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Dan Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v4] locking/memory-barriers.txt: Improve documentation for
 writel() example
Thread-Topic: [PATCH v4] locking/memory-barriers.txt: Improve documentation
 for writel() example
Thread-Index: AQHY3JEEUGpScoYh8UGbpcw6oN0VqK4THE8AgADc+4CAAIFqgIAAJRcw
Date:   Tue, 18 Oct 2022 20:33:08 +0000
Message-ID: <PH0PR12MB54810CA260159E805D448375DC289@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
 <20221018100554.GA3112@willie-the-truck>
 <20221018174907.GT5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221018174907.GT5600@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5092:EE_
x-ms-office365-filtering-correlation-id: 4045a575-14ae-493d-670b-08dab147f7de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzMvudGaqBaVrXj7psaThW2R8tSLZ1c2T5PLmDCKMrOubVe3WhWPpfqmAOHiYaLtdvkM5lc4fMsHQO7KgFXkfYKXhZUF5CDidDV+FkP9Sc5HDhmb1Ax+xfL21RBNvJdt4L1T1fJ2nob1S6Vm9zIcfLewGPsma+nHHmZnhylLQrFUaxC2bReg4wiGsnxd9k5SK62TqLVwfJAGPKHb3FabTrK6tQrBzTbUHBoRo43bMgSymEB8k7x2UZS71MZjTrhDMMuLGv3Xz9h3SzgyaUdGneYyfy1DtG0d0eXQfXDkX0kBGkj82w2Hq0ftaS2AzzEKPHgIJiEQcQlkbq8vZzuhIBODK4w5pThqUX1JvL7yiqQlCCk13flXe5aLgPO6zaAebL8xuyQOlSVOtw70v7CaH6A+P0n4I4N6t54SNw2BPmu6KjmiL63UI4lEfqE/VC5Gzmi8W/9214lS4fZqae5LogWvlYxIekITe8KiyRnALk0kXhnLG3kRrjuExAV7LfllpL3I4DYYhZpr2W7BDqmicVlr1YNinRMJodoFd60huyt1m5yrXnUs/7XmkTKWlv1XsyQmNrVjVsdps2tF92kNpvxR3lZWfrCDoKOK14j2qmnm+L5PGKBYIgr+g7Pf2aKP7MGGuCpvegnD4ohF7LvOtfmy1hOALxEelsXx8fiifGYrFSr+/PSptfEuKq44RD9xajEicErcAchN/KDOYgkFwJrHY15wXatygaab3141g0dFqH4Z5sSlFPlvBL8V1ebGBGf+eY6zQZUHyK9EANcCxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(66899015)(86362001)(33656002)(38070700005)(38100700002)(122000001)(2906002)(7416002)(55016003)(5660300002)(7696005)(6506007)(26005)(186003)(9686003)(83380400001)(71200400001)(66556008)(478600001)(316002)(54906003)(110136005)(76116006)(66476007)(66446008)(8676002)(4326008)(64756008)(41300700001)(8936002)(52536014)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NRgrqQcd3sHy1qVGHu5/khcBRUKnm2bydwB82wprj/Q7ZMWv9q5TYaxbY2iM?=
 =?us-ascii?Q?AwqdwEgGvSgyCVJZjVWPiXb/DR+LNrYoT2pEqHybx1qjR2wc4BG14lk4smiI?=
 =?us-ascii?Q?ilgU+QOlPMyyUEgp3bDyWFDDj7JelzxX85ooQ18pXzOD/n5OCt/HwGuKMnFc?=
 =?us-ascii?Q?YDfuEt/MSH5ba6IOklEgkcxhbrcLBrW4+bxuhTCyovhCPpD1eYsvMVPNcK7s?=
 =?us-ascii?Q?KOOAhMbXsm+rfO1Ig6S9xcIrH5LKtGMQrs/k5H5hyZjEF7rc04bNXEWXHwBs?=
 =?us-ascii?Q?h2hsJnuySYX8A4fq+gmRYTkfdpgGF5o+1hqK3ZNGPJ9dXLvwJLG4mjIiKg/L?=
 =?us-ascii?Q?wJX1qdWNF/+OM1JXSnksX036ZcpRvxnLBiqh394+LlnZplf30PKxpJ9RT9xV?=
 =?us-ascii?Q?+P3cfaUAXIeM1slmihapJJaOTJTrVeq+3pe7BK78Qa5nztU7MZhMcoyTrW1s?=
 =?us-ascii?Q?T1AC/A71bagNHyyZlhm47WHaD96+0W9D25WEX6uVlAOuLfYphQHKtVg3zlfl?=
 =?us-ascii?Q?NLlfW6n11etfFAcFopDCj8lFNCycgEye77ge/32/fRJ7sHu1hXGA6Agfk+Y2?=
 =?us-ascii?Q?TFnLpXfOWRTymeuGg2TXYgKwQ/mKMDlRkn2cZlx+mHb4UhMOg4SsQztu0sek?=
 =?us-ascii?Q?nlCoyKL88Oa9FX6oLFLdtPOEEOEJ0d9iKWUi3ifsJVaepO286/VSajIqKCal?=
 =?us-ascii?Q?JsF2HufL3L4EuT+D+2S2p2tuGriw1P2S6Hzj/Di9tWWTwk8NPmMwRPTGW7aw?=
 =?us-ascii?Q?VapEQ9yT7i7l8H8cU54V9QSk5NN7SYVt9o178xP7Wvp243ZGRv6Hrn0VqZtx?=
 =?us-ascii?Q?D3hyU0n/FKDAyrNaNuPuNyEa/SPR9WBNiWs68hQyNoe3zF06LpElgBQitaLZ?=
 =?us-ascii?Q?Kzz2qXH5I51QI4pf8h9yiPKrQxbERuerVIlFGv1BDU9MCepr0U+PUu30xND6?=
 =?us-ascii?Q?lTKpTVVCOVkLt/50t58IiTooZa8K1/NFlOqTeO7F3tGGzZBQUGDVuBdmtfra?=
 =?us-ascii?Q?/D/LKlWpsQlzMi0qN/Evlogza6x0rdA2msQyheazRdH4yP7KcH58K/MfBkVR?=
 =?us-ascii?Q?v4hcxcewHRnKFjBbv4zdM1sssS3ij1UaHOMoqy9QvWZDEkK4dEQuQP1IJXFI?=
 =?us-ascii?Q?QwrLTMC5/5G4SExLXe0SQx/q96mR6Oa0alK2CoX0YxiM1d/kPw5P27DmOZuF?=
 =?us-ascii?Q?G34mhP7FP8tECUgzK9vGU8k0XUtPd3XLukfTOEcxzDdJvtwKOmB8+b2Pqc/d?=
 =?us-ascii?Q?Z27C512nR8VxLWdpQZj3RD70OJrDat9F4aL24ceSAaVwB70Cr66+VTw9yKR1?=
 =?us-ascii?Q?LIEDKhQkV3vt7iy4MpkcHoUZVyMysCZwnhDFXrjjEPIRuzi+8HlzYum9c1eB?=
 =?us-ascii?Q?nAMyGAf7vMHQ3Gz/B4kLwCqe6beDcXzy4phnEvhEzX97ZlClXE2l37C5tY/g?=
 =?us-ascii?Q?Gc0ZTv3JXy1OHw/RzKqEA7EWfbQzTb1DEd+F8kN9T3KVCXKam1oWgo6E25RO?=
 =?us-ascii?Q?LupZsG2m3oebKnRfuhFSA+COlx9v2QFsjBCCza4WSNwYkq774fcMdW7pBYqQ?=
 =?us-ascii?Q?YtesI2VseN+MORLxCak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4045a575-14ae-493d-670b-08dab147f7de
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 20:33:08.5532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVoY9OOS2G2H8mb7meE7pDG966Y7Sb+2PK0a/4dkCS2hvsdpMoOIw+Rs0637aQLE+lYEDHF783pHaiAfvI8C5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul, Will,

> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Tuesday, October 18, 2022 1:49 PM
>=20
> On Tue, Oct 18, 2022 at 11:05:55AM +0100, Will Deacon wrote:
> > On Mon, Oct 17, 2022 at 10:55:00PM +0200, Arnd Bergmann wrote:
> > > On Mon, Oct 10, 2022, at 12:13 PM, Parav Pandit wrote:
> > > > The cited commit describes that when using writel(), explcit wmb()
> > > > is not needed. wmb() is an expensive barrier. writel() uses the
> > > > needed platform specific barrier instead of expensive wmb().
> > > >
> > > > Hence update the example to be more accurate that matches the
> > > > current implementation.
> > > >
> > > > commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA
> vs.
> > > > MMIO ordering example")
> > > >
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > >
> > > I have no objections, though I still don't see a real need to change
> > > the wording here.
> >
> > FWIW, I also don't think this change is necessary. If anything, I'd
> > say we'd be better off _removing_ the text about writel from this
> > section and extending the reference to the "KERNEL I/O BARRIER
> > EFFECTS" section, as you could make similar comments about e.g.
> > readb() and subsequent barriers.
> >
> > For example, something like the diff below.
>=20
> I do like this change, but we might be dealing with two different groups =
of
> readers.  Will and Arnd implemented significant parts of the current
> MMIO/DMA ordering infrastructure.  It is thus quite possible that wording
> which suffices to remind them of how things work might or might not help
> someone new to Linux who is trying to figure out what is required to make
> their driver work.
>=20
> The traditional resolution of this sort of thing is to provide the
> documentation to a newbie and take any resulting confusion seriously.
>=20
> Parav, thoughts?

I am ok with the change from Will that removes the writel() description.
However, it removes useful short description from the example of "why" writ=
el() is used.
This is useful for newbie and experienced developers both.

So how about below additional change on top of Will's change?
This also aligns to rest of the short C comments in this example pseudo cod=
e.

If ok, I will take Will's and mine below change to v5.

index 4d24d39f5e42..5939c5e09570 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1919,7 +1919,9 @@ There are some more advanced barrier functions:
                /* assign ownership */
                desc->status =3D DEVICE_OWN;

-               /* notify device of new descriptors */
+               /* Make descriptor status visible to the device followed by
+                * notify device of new descriptors
+                */
                writel(DESC_NOTIFY, doorbell);
