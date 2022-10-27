Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1961001C
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 20:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiJ0SYl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 14:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbiJ0SYi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 14:24:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE0DF75;
        Thu, 27 Oct 2022 11:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg0/otnarxcygzNgw3TeLxm2r4Wdvy72WgZZlcmkHitB7aBPHWZgsbbsA737/5oG1798WD2yqOmo0MHSa1HY46uQAVTbGdfxAjSqCAUEEF2Eu5S/H2NLGhZDGjMrymhBKAixgRZxMyXov9cNl5CJ5G0JQXzTpHa2wsxUBO+EqAo18B+hIHA6e5AzW90p6UiLL5GVLuBGa5oYorcJ4cJ2Dbv7bOXAw0UtRsHAvATY7QHKGpU1WHDb84JEk+3FNHx2XhBHuNamfDmzc7QfNE+CtpwlXVv9+U5nDbNIQi2t6rC0UxAm4d4ousDR8Q3WyehmM0L5yq9cPjHDYA0pB5/0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzd9laxZC2tSaRWAbacRwJSwyM72buGy1BrzADX9oio=;
 b=J2Xg+KyuVeiSFtyuQ9g47FZgKCllyrD1VWkROE/gnKjQFhAN8tlPQmyCFhAJOsvFBF/dScxJA8vZEaXf7h4SeOXQ0ZargrMoT9wkN91LdoHnkt+9VRG/qgXxf1zYdnbxLvy4948cx+s7mX9clDnB7Kt81giQ6c7f5GIk6ymP0CJ82gs87HHM1MrTicY1fOX3ymJdN69pdZBcq03VXE5qnp9lHD/TYa8QXGQo3LZqUsgqocQkHAmFDnQWA0ugRVs4IapZ3lNiMWByfbuv9OyhutA5LbrgtHd5j5hDFf9onvd9kHcZSpr1pN3lyJuegMorcfEK1zefeZs+lxux02B+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzd9laxZC2tSaRWAbacRwJSwyM72buGy1BrzADX9oio=;
 b=nkBwj3Pthxm4TOOrwvShavsUJJi+n/I+8fFhbNuVQnEhQzpuOXBmTKnzXEolYlDL4jppHy1+cIE66/C2F3nmtlQ4G5f4LuhT2zSutISOy88dww3X7uxoN53XQ9tWCWBmMaij7wwIRdWmtzlBvNcwOtitjcdlFpCcINQ0NNekPGHsz5yXrV8tuE6rom3v6E/nW9Mto90QyAhEeOt/wSYUYw2rf3MSLDpx+XQHc9fZGcuXayH4Sl9nBtaefNi65/NSZg9elyZ+5qytQNyky/+fkI4oii5Lz+J+srQR5xLxmxHFeEdQ2bVjRSvHGjQPbcnOdOut19q3W/1Jtn/tUAvyUg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 18:24:35 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 18:24:35 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
Thread-Index: AQHY3JEEUGpScoYh8UGbpcw6oN0VqK4THE8AgADc+4CAAIFqgIAAJRcwgA4HJICAAAKPMA==
Date:   Thu, 27 Oct 2022 18:24:35 +0000
Message-ID: <PH0PR12MB5481D4417D82F130804ABA4FDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
 <20221018100554.GA3112@willie-the-truck>
 <20221018174907.GT5600@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR12MB54810CA260159E805D448375DC289@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221027181503.GE5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221027181503.GE5600@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV2PR12MB5894:EE_
x-ms-office365-filtering-correlation-id: 68ba79f9-edf4-45c2-741f-08dab8488006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OYPmQ2RMxdA2Z8gxJM+j5iTDhQ1i+z3yoWYpFP8e/jqenNywchhIzBMopFmLzx5oe3TCcwoNXLzEx+QFNbBMHcNCOSH/4w6Z7FukwLDtDGmY19N5y5a8a8sZi3OGstsYgdzETI2FhA/f1E+Crl6htnWdsCIXNFIiEC9GeZE6W9v8fRu9SUbvmqKjMWyyhax2CCetFjXeN3EvvmhmivFZqzRRH1SBsWuvCGwglb4jAOICjIhC/5Pvt5Eg6hz5nAWK77E5/x17eJA2XwQ4uNrhyGtZmA0B5ZOGuZqloWI7j514nhtP3OOPKB+BQxowOePEBcogcbsBJ0Mb3S+vc/hjwFwxkMx3EmMy4dqgVBS7lT8NpQnIXzSzpLuPt/tlrgf2cjV75/Uai01rbTGNV0Xdp/VT3ygVgTFZgEe0TaOCsIYs5bQ7rIILK0Yy0lcNcaVWRwc9Xr57CwLpQ8XbWel3MLgPy1PAF7MMVqf1HSrS72m1B6iKE8fiEerPivW6M9G4+Tf7jm7RJ/Z22WAO6lYmQzut626H5o0VJf3OUU/AfK0SO7BjB2ywOObC/pdfXw6vv+DyWvPd4NKQNlGrRXtxOEARQBJH15My1Tt2DszGumqm46M4Zm2abrO2aSkiDDfGbbmaHvfhnPf/m7bgnt2RIUQ/YWu0T3plPX7Y4q8Yp+/JkZI8ChHeD2o4u2kLPSegcbSkQGWMxaYyv1JVM037LbydBiYW3MxHy0aiZ+uZIyMZRBi/RhaDD8L1wEbTDtm9lC1mj8SR9Gu4cQt4YQKWqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(316002)(6916009)(2906002)(38070700005)(9686003)(83380400001)(186003)(54906003)(8936002)(64756008)(86362001)(5660300002)(7416002)(41300700001)(122000001)(66446008)(52536014)(66476007)(66556008)(76116006)(66946007)(33656002)(55016003)(4326008)(8676002)(38100700002)(478600001)(71200400001)(66899015)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3RCWQJ5pcwTbjlmEBeGrAYXgl9M6ThvXkFGOfj9CR9xWgORnplL/xC9ctaYw?=
 =?us-ascii?Q?VTwdzMaqfnASV5kc76mZaLIF2OOLkyAd/6HVW0jU9xXK5wGgUQRizAuA4MFR?=
 =?us-ascii?Q?Od6Oon3PoVZkfEGMi3VeLldnIdvZZaFqhGadRju7te8IKarhrBB0YzOGUEv7?=
 =?us-ascii?Q?iYRHhI9sW+NTCLLn4vHVlYcp7c+uDG/8HaEN4rrjM5SmyDCmp6JncNesg5FC?=
 =?us-ascii?Q?YX2sryhuIKiCb/DZtCzSXK8SLL1cweledOWHQYvLIM7NuUkk/xEnlzgBHa3e?=
 =?us-ascii?Q?WCJpOlmKIHLjGc2CjKOoUOcrvWM8gY4rAGEyMSJdqTfTVtRGXWZSocDWBZ8X?=
 =?us-ascii?Q?X61TOusnCVpo4hkaYBYjD7C03FLfSoxbNlKv196jo+1Sg+f7wrWGVjVqylMn?=
 =?us-ascii?Q?2evLBuW+W13vCglpI3Glh2FgAnkYhycGXZ6owPu9v8pgJC16XFpVxvZC3omi?=
 =?us-ascii?Q?/7sWgULBy6zepv+jHflIl4D9p5SPe/wk50F474QaQpP6TEx8DIadM0Nkmv6e?=
 =?us-ascii?Q?LDGySRG1uLUgFI4HVLVlmh+jiGI+JS/3MDcxFkdENxHICvAvjx5FZj03NWG7?=
 =?us-ascii?Q?xHIbx4yKdy3HHQHdLb0iU5FFTaSvQ+kB+dfoXj0ShfzdHqP1wS5l02I3JePM?=
 =?us-ascii?Q?dUR1pTsbXw9BiBeyTX2QXrbfkrWR7GcCrVjX5qmYsmoMII+MPXgsrp+95O+L?=
 =?us-ascii?Q?QZYS56dpsCvhquKSWMVMyx6YuwRAGRcxzEkxW4/bYLkq0jRAnjK9EcJOOJO7?=
 =?us-ascii?Q?N+3d83ANJYoK+rYQWDoIJ3RimWqbEQB5ARTHcnSXEgbZX/+UFqwPUn/hsegw?=
 =?us-ascii?Q?x/64R0MzSzP7LJGgTmJsqTngxAMStr1K03LBAnRWU92gsVq36oKQaEpkdqTH?=
 =?us-ascii?Q?N98/+wtwQXKfJJ9xPFG2PKuwdit3TrU2bv25+190h2aVNjzUyP2emsYVBi8g?=
 =?us-ascii?Q?wR7qi5btIyHWSO4Ke7H0cGuZ2TdLpWRK9IsM9t4Hn7VEskTPVhEpODAKeEOE?=
 =?us-ascii?Q?WQ5k/L1ViDWTAxgOTon/8ekTwIiOoN+WvKE8UvYNucWI3S59bjBCBJ83iU2+?=
 =?us-ascii?Q?bd88gE9BCFdEZlxMDna1ps2cU39MmNlwZKhkvf6x/xuQHL9AoguxIaxa9d92?=
 =?us-ascii?Q?ULBOZkMHUVPDyvqDOwMDo2P+KuM60gc7H8tYeUjCtmw93UBhbExlYQb6Brn3?=
 =?us-ascii?Q?+VKwVOMT9ocd82CszMf4T8jjcNDkprx/VySlCPnKpAYVzR4ReKpYqCEakYUR?=
 =?us-ascii?Q?HFp2Cp65zXTB3ygbvus/buFM2jCu7lgdKIUEqnjqPeRtMMhHmjUklrhqzikg?=
 =?us-ascii?Q?9m3uQmOECnw8ZpHsglmIEqs6b/ABlXOWSebNrdXAC32XoWgCvBoj8uGxGH6O?=
 =?us-ascii?Q?krCRrc9qaiDRJqm29DzweDZrmk0J6dvqgUj4ilW471JIVLdr0d65Jitl0keP?=
 =?us-ascii?Q?sJMAcfXBYpPfANVVk/7k3B707oqebBbswPntBxAlhYSYjz2yYDl0LiaYjc8l?=
 =?us-ascii?Q?a+YAI4VaqDBQ80lqAEkPnTjiHd7lFTh1dR9hBB6MNDiM1NdQSI9hvr26A1Io?=
 =?us-ascii?Q?VoKEEQzPRStNxSNxGih7GSkOBo+UmD2qMzY176SaarsH8gYm0+G/uhlXHiRt?=
 =?us-ascii?Q?0/Oi54S2OY4Olbv4k/eiCfU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ba79f9-edf4-45c2-741f-08dab8488006
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 18:24:35.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcMzYyyqVZzTl7gLkZA+aHx9SsY7hE/WmeOiX8wLlt7CKTLeWDKXVShyb6qcNA9T/XP1N49GemSYdp46R7B/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Thursday, October 27, 2022 2:15 PM
>=20
> On Tue, Oct 18, 2022 at 08:33:08PM +0000, Parav Pandit wrote:
> > Hi Paul, Will,
> >
> > > From: Paul E. McKenney <paulmck@kernel.org>
> > > Sent: Tuesday, October 18, 2022 1:49 PM
> > >
> > > On Tue, Oct 18, 2022 at 11:05:55AM +0100, Will Deacon wrote:
> > > > On Mon, Oct 17, 2022 at 10:55:00PM +0200, Arnd Bergmann wrote:
> > > > > On Mon, Oct 10, 2022, at 12:13 PM, Parav Pandit wrote:
> > > > > > The cited commit describes that when using writel(), explcit
> > > > > > wmb() is not needed. wmb() is an expensive barrier. writel()
> > > > > > uses the needed platform specific barrier instead of expensive
> wmb().
> > > > > >
> > > > > > Hence update the example to be more accurate that matches the
> > > > > > current implementation.
> > > > > >
> > > > > > commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken
> > > > > > DMA
> > > vs.
> > > > > > MMIO ordering example")
> > > > > >
> > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > >
> > > > > I have no objections, though I still don't see a real need to
> > > > > change the wording here.
> > > >
> > > > FWIW, I also don't think this change is necessary. If anything,
> > > > I'd say we'd be better off _removing_ the text about writel from
> > > > this section and extending the reference to the "KERNEL I/O
> > > > BARRIER EFFECTS" section, as you could make similar comments about
> e.g.
> > > > readb() and subsequent barriers.
> > > >
> > > > For example, something like the diff below.
> > >
> > > I do like this change, but we might be dealing with two different
> > > groups of readers.  Will and Arnd implemented significant parts of
> > > the current MMIO/DMA ordering infrastructure.  It is thus quite
> > > possible that wording which suffices to remind them of how things
> > > work might or might not help someone new to Linux who is trying to
> > > figure out what is required to make their driver work.
> > >
> > > The traditional resolution of this sort of thing is to provide the
> > > documentation to a newbie and take any resulting confusion seriously.
> > >
> > > Parav, thoughts?
> >
> > I am ok with the change from Will that removes the writel() description=
.
> > However, it removes useful short description from the example of "why"
> writel() is used.
> > This is useful for newbie and experienced developers both.
> >
> > So how about below additional change on top of Will's change?
> > This also aligns to rest of the short C comments in this example pseudo
> code.
> >
> > If ok, I will take Will's and mine below change to v5.
> >
> > index 4d24d39f5e42..5939c5e09570 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1919,7 +1919,9 @@ There are some more advanced barrier functions:
> >                 /* assign ownership */
> >                 desc->status =3D DEVICE_OWN;
> >
> > -               /* notify device of new descriptors */
> > +               /* Make descriptor status visible to the device followe=
d by
> > +                * notify device of new descriptors
> > +                */
> >                 writel(DESC_NOTIFY, doorbell);
>=20
> Hearing no objections, please proceed.
>=20
> 							Thanx, Paul
Thanks Paul, I will respin v5 shortly.
