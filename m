Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C726119C5
	for <lists+linux-arch@lfdr.de>; Fri, 28 Oct 2022 20:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJ1SAD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Oct 2022 14:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJ1R7z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2022 13:59:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F1255A5;
        Fri, 28 Oct 2022 10:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaFpdTaqaPnZBoeFnmBv+4+RijFI5q2OQRwMpJtHlTv9OO1a7BJMgUGMRbS7ezzI4i48AWM2Nv67RGiLYAv6xWY4ZjYn1HtjTSeQJq8iE9u/Gsy+EH2W5intKPuiGGPYzxxkOGNywSkdfxAoPcNwBksACstdPnUsEtatck4/BdXESJ3+gcFKppqOrq6sp8Ougaf2W/3nn+O8kFYszsD2HmOszvGtYfFmyNvzKtBsQYspyhhQNMAG9+ch8kIFUVBpkYtgnlNwh8RW1pZuK0m2VhTadxMo14zJss8spZoTkf04WXfqweT0/BSdbTw2Z3l9hn0RaZX11nCOBM65ZPGd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwtpDinFLB2/XjLCQb9eZH5/KilYYhKSH3ZIhD2SbcA=;
 b=jn2RLVeCiZaPa8TzGAsaiZbXwpiwF7Pam99jkIo73AfDzi3LG2EbmJHeqzQ8Jx3XMIloHlQUp+s2OE0M82B+hVDiQmmcnsvQEkoxtkWxwdoZ5qRXqyg7bSYLV1JmQojUjP2ODWcRvbrBnzJo9i+gbKDRGDxMNATacKocVe5RhMow1ICt+ZX5IkCHpYfOn4IePJlDRAcVlZl4/Bw9XtamckG3BRBFAA/mp2uv2QvkCsOGZiz09BsvNxKwiF3QhbxVKx0raQAE8ZPy/t8iPcUE867n/MCYzA4Nqc/c4S2lUoxFRskWNDogqxfI1Ug72QfvdO2HGVXp+/lPq98ydcRhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwtpDinFLB2/XjLCQb9eZH5/KilYYhKSH3ZIhD2SbcA=;
 b=ljhsuEG72D1OruDhK8TOZ6sBDIiDKI6fGEcsr4V5fvjq/r/r+n/gaN4Z52EmlTo+LjZyoq3+5e0YXFaqqKzg5A8WErVRA9tw+bz2+gk4Gz2tecv3StW7JSGh3E2uYGlElV1O2RdrKUyHFjd9s/q3jR07UDrce4bMV1/xnOOwW2mXuEV6+FIXPPOZZSdn9ncbA4U7H/n7fhks2oaIIeA5I7xVHGdKqPyRPRo4UbxWPui4QtmYOO/gZicM/2n8FiMWgYxJVgQRwscoO6zEQcKV09gL4gvvCn7g7G0i+a7Ntb1G0HrETYz2yvdmvY3cSirhDXx7YiWUbNnuC6zUWYjTDg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 17:59:50 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 17:59:50 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        Dan Lustig <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v5] locking/memory-barriers.txt: Improve documentation for
 writel() example
Thread-Topic: [PATCH v5] locking/memory-barriers.txt: Improve documentation
 for writel() example
Thread-Index: AQHY6kAqLU+7ipMTX0yMR63yx+lrfK4kGJiAgAAAJXA=
Date:   Fri, 28 Oct 2022 17:59:50 +0000
Message-ID: <PH0PR12MB548171D8D6271B88FF27D156DC329@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221027201000.219731-1-parav@nvidia.com>
 <20221028175605.GO5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221028175605.GO5600@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB7110:EE_
x-ms-office365-filtering-correlation-id: c9e68dd7-c279-4286-3a36-08dab90e3578
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L4jS3vorifhsD2IPbvZq5mlEKmtS7xIM3bJxDLAEWM6XOJqQNdDvxSrFiKkLZyHKlkEprZ4soOLiu7wNKu8fH7HSUEt55tt4q/ZmmLMFi1YYRz2wlM56mbVb3MFWpyn05sTq6OfLgdajUftjgb5BsS+ladF9ocMnn8W6BTP9p/x2RCABe+bfp7QAKx6uogewIHkHnGssoZFopDDdKxX5n5H0nUsUAaBvRHoWeAgwWJ+MfWpRwYBZUifab5UpcuT2FVVoQtjakPITgGYCoFwnjevq+INtZ6tG8omNgmeLdaaPqLZh89F4Pop+q7HIpMN4/Llq04C0XCrecJgIxsuTLfnnS4ps7r/oQg+Y+zq4W5NpD5DoLV6PTyJbd+5EpPQN10WRJdok9Nnm5k0wKXq2G++5vcuyePsxActMizQXhy0ttsknMIEz+fiV3f74PkeGElDQAg7bfnu8fmroWbrFbAknDqz/KKr/jVnx5grF+wmGewDtkOyFpViTHE6pr5hgehmq9cU0P6cR4rvJbjZ3oE2EAl/ETUdcIIO820SgyvisH1guhB/sQA6JIq6fBpty/dPThttGTW6RCFiiBQEqpO1IN8OwW4eocd0PzhiJUJZ8sMWt2enl5Q6Hy454r75xVn89R94vv+hujdUQY1JxKct511JOnKAvbpFNX2CpjFGZLas+bmNo2xQIvz7tVCwQtzbYr9eCMhKIf5yObWg4VEX08J15zf4IFUIU39Z/aYmZLncZ56OBXwMhKpxMUmmBwQ0rH/hfknid4kpHFBYLDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(6916009)(66946007)(64756008)(66556008)(66476007)(8676002)(4326008)(316002)(76116006)(66446008)(54906003)(71200400001)(41300700001)(478600001)(33656002)(83380400001)(55016003)(38070700005)(122000001)(7696005)(38100700002)(26005)(9686003)(86362001)(6506007)(186003)(2906002)(7416002)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rLER9cSqs7saYtgyLgZNsMiQkBGbQTH0k3XMCCzVcqq1fwrjUVWZs+3SjHVJ?=
 =?us-ascii?Q?8nAZwCtFFGBquFKMb1usc+8c/LQOYVFht2DIC7O60kY+7aBHwoULoyFiCKgy?=
 =?us-ascii?Q?0VwMap6BrCPwy6W9QFuvzlIzJzi6GXfK6G6VRvnHbUEOVccL1Eb6TnJHNFr3?=
 =?us-ascii?Q?t7bAg0ICkMSpuRKYbXADUMAJWqoEbE+8u6e/JpY1pwJW8rtdS+49tx/xeney?=
 =?us-ascii?Q?gGgqP61/TeW8etDI5aFYOl4UKBkmPtN2HHU/wvkSAmP+VGE2K2MwwQpkFryH?=
 =?us-ascii?Q?hpOz/cSBG6P6OCGlRZs/3/APKOGJ0AvrA2KBfwDN/MRgYeLo/9SkDOjZnxeX?=
 =?us-ascii?Q?rkFN4RqJFoGFggRaPdSTkKR/CvWT8Fe81dvHjzqlhR3mql+QnbqcwRT6EPBR?=
 =?us-ascii?Q?vNfX05vkqL+QvhWP889u7UUCLzBZr2K5+ZferfKiz1ygvGYGu3Z5kcGKsjVT?=
 =?us-ascii?Q?IfHHR5n4/teI1iQTK0PENeN2SncipNqCjceNfeKWQ3asQA0DdzzAlWRukJQP?=
 =?us-ascii?Q?mgLS4vLTmeVhMlwDlJriAIRM5eMAcJAP+VlFpaQTD/WXaOKSIKpNSwJndzgX?=
 =?us-ascii?Q?qP1TfhaDOLls5ocjZiQR2bgy+0f+NlzlvcN2oJzVk5e+eHb0k8q4LZ5TCFhF?=
 =?us-ascii?Q?kAfzn7ZCoJFkzPN5+jPZj8LxZVAjsuuMSS8fY4O0IPYuhVKgiQvazeuN8jBx?=
 =?us-ascii?Q?XaEPtuwvbCMnPFjOe1xxQOKcC8A++RtmJ5RoO9qHFpRSVLgylZYfMfXQepbL?=
 =?us-ascii?Q?DgCKzhI6tk5E73YWAylreHx6qz1EmNzOA2NQSaq8Io5boMGQ0Ubzrt+YLqq5?=
 =?us-ascii?Q?leAIzmZV+wva7hxq8loYk798hp4eRbjhwSprKjREBID/Vt9ZMl1uNbSiCuZf?=
 =?us-ascii?Q?N2HX47j7wdMQ7wbFm2f+yCz1qqUG+SgaOtXD7KaioRBed2lCJzMReZvzOUV7?=
 =?us-ascii?Q?IVmNwUBtdPFZLBqr1HiPhIkek+e8WBvPcAPiLF/D889yNv1nr1U7i6V8j6eu?=
 =?us-ascii?Q?LsjELFMCe07/9K6NFG07uzOg8rgdYmGi5lINfqe0xB3b/engSgDw2G6Y4k/i?=
 =?us-ascii?Q?+3rqbZIB6RpPmgJjNnrnSqLOpqYqvPd5Qw5kGImN5EdgSyCJ6btQuPBXKEMK?=
 =?us-ascii?Q?E5fUcRWYMzAzSS/uGa32h1qlIgVL3xYfgXJunmu6RHpxf3LJMWD4j516JY7r?=
 =?us-ascii?Q?FfgcAK7g1BI0UfhCdmmljZtzY8T2xReHw/zo/rX4INFBOA0B+0+3aLzUUkfq?=
 =?us-ascii?Q?/QjPnY02xgxqySUQEt5d7hO+NC2xkkCR2Y3VbS+RvO9y7Fvuz5q+DMuvKWyz?=
 =?us-ascii?Q?Gq61vOr76/7PdzC5WR9apUrmJm3gV6d1DFYSIhM9YSdZXiz29/Ox5z47eJi9?=
 =?us-ascii?Q?Hlea4ejfxTtGmMZlUuguz3pkB33EPhyE2GFGPV0uGxslCNJniTR6YK4yUnfD?=
 =?us-ascii?Q?pLbDf5le+QW8I77mL8kwGZXTG2iNpNRTc2dXX+ccaju6z8tEgsEYSdA8kSuQ?=
 =?us-ascii?Q?OATN0Kr+UoryhznQD7C5ERnKTkHgtIyMCTPcekxxFcAXopkXQfe2tRzByQgH?=
 =?us-ascii?Q?gVk/kuGc1fbJ9fRsBR8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e68dd7-c279-4286-3a36-08dab90e3578
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 17:59:50.3630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQ0WSC+JrCWviCBiZOm5xE2P6+xwlA3+nM8jZO/hvuophMWCDSm8dEgcxoMmtsxKeS2mntN7FNP03YCieHANjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will, Paul,

> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Friday, October 28, 2022 1:56 PM
>=20
> On Thu, Oct 27, 2022 at 11:10:00PM +0300, Parav Pandit wrote:
> > The cited commit describes that when using writel(), explicit wmb() is
> > not needed. wmb() is an expensive barrier. writel() uses the needed
> > platform specific barrier instead of wmb().
> >
> > writeX() section of "KERNEL I/O BARRIER EFFECTS" already describes
> > ordering of I/O accessors with MMIO writes.
> >
> > Hence add the comment for pseudo code of writel() and remove confusing
> > text around writel() and wmb().
> >
> > commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs.
> > MMIO ordering example")
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> Hearing no immediate objections, I have pulled this in for further review=
.  If
> all goes well, I intend to submit this during the upcoming
> v6.2 merge window.
>=20
> 							Thanx, Paul

I have taken Will's email patch suggestion with small editorial modificatio=
n in it.
But I was afraid to add his Signed-off-by myself in v5 without consulting h=
im.

Will,
Can you please reply to add your Signed-off-by as well or not?

