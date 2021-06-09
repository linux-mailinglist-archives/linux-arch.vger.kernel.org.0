Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3813A0C23
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 08:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhFIGHf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 02:07:35 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:54497
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229942AbhFIGHe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 02:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8PgaVTNXET42QV9zCoIgUIA0DW+bEwgw3WWWWmR77PkITXbk5+Ypx9NzglC5oP8oJUun36d7ud+63IwM+Z71gFGUMJ0s5/YFj9x8AFvLLbSEmSbVDuhVwuF+5oRQD+oDNESbkfFveUYOGjoBF5ua4+P6pD/EdjhgYDqPTyy8RpsUPoFf2jtlMHwHOAqwzvK7oEplOVIFCxZBs0DJuiOLU2uJj/dwD4YRupaOuLEGWWRp0sIeCrlTIwLj58+3VwrbL3tgSU0wiZtrd6iHL0iqIXNDhMIfusbSLa2rYp0yvJP3dD9fE39TDKZbVhYPFLMfVv25GZs14p4Wqb0oJdthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJTYHFKEvcJW5yuJvHYivybqE8KFb25n7flEo/NXteY=;
 b=PhNj1fQVYGV3jqSdqzI9qZFupgC0wW/x8EL668QgHpdcwJu8w39fezvmDMlnjYxB9RMtB8FB3yx++pU8x8QQNG+lckfdPfqKABbpCkCPWp5WIiE4SX94Pqmnv5ffgZ9ABVxqbkmwb8//3mHfC328JCSfS14K8dAYak+5mviT4ttmRTLCWW7mIXt1xGWMTabhEHHI/JGqNQLm4pQUJ35+kb8rZzF7BlvPZAxBHNi17KO6DXpKFyDaH4VYb3jUHzzIgNc9VR62FiA+uB0BuJe3sfc+2kOrQZVtG7Onl20NY4gk/ZbFX8/FXEDkE0YjG5UqMzq+EsE2/9PjgMkKjXMXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJTYHFKEvcJW5yuJvHYivybqE8KFb25n7flEo/NXteY=;
 b=bWYZr0w5pLHGzxcOwPlBwcE3hZ5kf/xwciqltXiV0mN+xDN5VhrdWEwoflylxv7sLlcogkFccnVWgZhFilY8sezt3hkk9B2SVWfOzFfD8As9cGNHtqrlzuaVZ/i7OMC2iAWRT3ZGByqxi7mdvEMK6MtXpWVVyruKSnV0nv+xXrc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN9PR03MB6092.namprd03.prod.outlook.com (2603:10b6:408:11d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 06:05:38 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%4]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 06:05:38 +0000
Date:   Wed, 9 Jun 2021 14:05:21 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Christoph Hellwig <hch@lst.de>,
        Drew Fustini <drew@beagleboard.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        "Wei Wu ( =?UTF-8?B?5ZC05Lyf?=)" <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Message-ID: <20210609140521.3038e40e@xhacker.debian>
In-Reply-To: <CAJF2gTQ5271AP8aw42yvfOg0LjtnmPD8j_Uza6NH2nHxVz_QgQ@mail.gmail.com>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
        <20210519052048.GA24853@lst.de>
        <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
        <20210519064435.GA3076809@x1>
        <20210519065352.GA31590@lst.de>
        <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
        <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
        <CAJF2gTQ5271AP8aw42yvfOg0LjtnmPD8j_Uza6NH2nHxVz_QgQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR13CA0191.namprd13.prod.outlook.com (2603:10b6:a03:2c3::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 9 Jun 2021 06:05:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35e66c63-5c4a-4713-c880-08d92b0c9a71
X-MS-TrafficTypeDiagnostic: BN9PR03MB6092:
X-Microsoft-Antispam-PRVS: <BN9PR03MB6092FB3E0AEEF4A2F54EAB3EED369@BN9PR03MB6092.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2fOxA78HXwRDfbQKpeTHSv/mfqudkIq2CzGCQ2WdqWrWnbJavZpZfg+DdmAS/QqQwBpFqW/Js4h1stmDjTuz7KO217pnVzD1RFybyrIR6PSJV+d78ORZ9i3JIEhXPNVFgZHUmUD537IsKyQCH6DwSrUhfEyxXEmuGEhaHYVplgSHz4DZFO/3q6YWQeDsIhCyo6trR+wz8+XxjxzNz1dQq1XyV3O3Aj885x8e6jDE3wBgyvDIF5+xoyHK8yl95rcSxOHOOzkVAJgpl90Qoqo3kXq36BLE0Jvh+a9pR6i4Ih4z2uf/X9Y7yeInCBY1pFOlvNsVXUE2FEoJR9jZkxVLi4cmEUi+8+78NZNl6AaVzRQW6I8M/EIRHLZsvCE7R2St1VBG4TYFyFZJ3LkxmFsF5mSnsmUhnZIVZPQhhjCEFTlxjR+11lMVWai2KshdfBfHLNCnIsw1UOYYEVKfd1BIPjk+nyosg6GY6I4ZnIkf0pW7SKkvj1RCEn0DWz+v4wY8RFeq/LNmX9eHwwN6qEZaf6dlpCfxCDKUtXIG44XnDxYzGCH/FdqK+LD6h5vg3Ec2JBMQjhSqjdZRdCw/Zxm9TiSa3YhCAG9Y2MkHKx5PQLL2ATTXnHBUF3v1y81G2lEcb7ZozuJZojQZleEdothTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(136003)(39850400004)(66946007)(66556008)(66476007)(83380400001)(53546011)(956004)(6916009)(26005)(16526019)(86362001)(186003)(8676002)(7416002)(6506007)(316002)(478600001)(4326008)(54906003)(55016002)(9686003)(7696005)(52116002)(5660300002)(38350700002)(2906002)(38100700002)(6666004)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNJSVVuSmlyc1JmQUR6a3JZMkVyTTFUOXVMZGQ3RGdDdnFYWW1FdXNlQ1N3?=
 =?utf-8?B?SDJVenpBZ2MzS3d4UWpMUjVkS1kyVCtJNnpHclVPUXYwNlZsWTVFNkFUSzRH?=
 =?utf-8?B?TmV6NXd6VjZFMTlVRllydzZhR1R0OVBONWQ3azZpOC9wbE9jdVZoQnlxbHNj?=
 =?utf-8?B?RHhVZDNnY3ZSc2tRbEZrOEtjaEJDL01VZ2o2QlFNUUZLVWdOaSt6Y013MExa?=
 =?utf-8?B?azM1dTByV2wrOGZRbnlLY1hIbkh5dStPelpRVmNJOWxsN1ppTStabTZCY2dJ?=
 =?utf-8?B?NlM1QnBueEZraUx0M1lONkJ4aXRXdlI4TXd0UHJGcit6RVBtRGgxK3RuNmpM?=
 =?utf-8?B?eXIvR09HY3ZCY2RobVorU0xkbm5ob3JZaDFvUHZEa3p0K1QwcFJoWVU3M1JW?=
 =?utf-8?B?MW52Qnp2YnRmREttNlpYd3BpQ3gybTh1WVpyUTNTSGhtczdUdWZKV1p6VjNx?=
 =?utf-8?B?dVc3eGtUT0dScHFNa1E1WVhTYWYzdkhJUEtjMDgzeUQ4WXZoWFRSU1Nrb2x1?=
 =?utf-8?B?SjJiYVAvS0hZNGp1VkE0ZkNWenhOaXNYTHFjTTArUUNpY3ZHR1VNbmFERzFz?=
 =?utf-8?B?Z2lPcngzbGc3cDR5RmFDTzBrUEh1MDlka0NwZUllL29QRmVLZWNJY1ZFM0pK?=
 =?utf-8?B?K3l0YWV0bVFSSW1jczc5cGI3djRoZEc3emM2VzRkOXVGd1MySEM1clBXWTE3?=
 =?utf-8?B?aU9SeDh0aHhoU21aak1KTEpDNEhHOXk2ZmN1b0lLRXpsdjRnckNUSUpDSlph?=
 =?utf-8?B?ekUrQ09KWDNJM2d1aXczdVluSmMyNSt6RkRza3E1QW5nY0p6K2Y4dXU1Vjh2?=
 =?utf-8?B?eTh0clpOVENEaEc4Ulpha2VIb3ZFZ28xMFdlQjJ4VUtVS0JjRjlaVWVZNHNr?=
 =?utf-8?B?Qm9vNVd1ZFRVdWhxb0Y1ako1SytjLzNUWW5uYlRodGkrQXE4cWlnWjE0Yi9o?=
 =?utf-8?B?OUNFN0tGTTBkbWZkQWdlYVQvQUpad0RQMmgrUnBRUHJYNVROQzQvUjYyNFY4?=
 =?utf-8?B?dkVvTjdZSS82cU9KSTVOQisxa2daS0sralhFcGtBNGZ2cEJxWGRlNU5zZ1dH?=
 =?utf-8?B?N1c0QXVNblhJTGJRMjVhVlhyOGtRQm1zVnRGeCtMZmVCTkd1aEJ4UllZSkt0?=
 =?utf-8?B?aURoNE52SlgvQlRDNG9xMG5PVHBoL05ia3dnRm9BWXVVZERpZlJMcWh4dzJX?=
 =?utf-8?B?V2Rtbko3UVIyNDY1bGk2VVRWSXpMbjJYbEdFMEJ1T2Z6TVAvUUZNUWUwZWNs?=
 =?utf-8?B?TU01KzI3U3FsYVpkQWpzeXovT3FZTE11dWxzcWpuKzk1dHZYaWFHY0VISDVn?=
 =?utf-8?B?dVVNVGM0ZGt1UDd3R0poM1pTUWpEalJVcHcvMWFOWXFxRFJTajlvZlllSlFa?=
 =?utf-8?B?b3AydG91OVJHcHZTdng2Q1E1aThrc0FlRVZyYXN4dmF0QjV6bFY1d3R5MFhz?=
 =?utf-8?B?M1kzUWJxVkYwY2VEWVdPUGRLYlF4ZFkxb1cyc2xvb1hsTnNvUmI4RExySVNB?=
 =?utf-8?B?SzBKYmNEam41YU9MeEVReEhYUE1jeVZIeUdyRnJmTGRnWmNkZTFsQnhIQjRQ?=
 =?utf-8?B?TkRlN2R3ZU1wczZxWHBLTUtJY2x1NUI4MGQ2QzV0QXF2VGFyUWdIa05pd2U1?=
 =?utf-8?B?UEc1cUVWMTJvV1Y5N09wbmx3cVFXSzdoRGZCQ0pYUWdGVllIOFhvQTh0cjRF?=
 =?utf-8?B?QnYxWjVHZTJJT3J0Tjl2VHRId3p0cFg4QTJ0TnVreDNZdUVLWkZoRFpUU2hM?=
 =?utf-8?Q?PYgloUhPsksAko8KvgrjWOLKV2A5ohpE2F+G9ws?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e66c63-5c4a-4713-c880-08d92b0c9a71
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 06:05:38.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUDfMEROW9xoyOQf8GTuUFF/oxj6e6c6FqZqIg4kfZhI/M/6/Xa89TMK6zgx4sCSBWCX7NCgvmDdZ4htgWEGDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6092
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 9 Jun 2021 11:28:19 +0800
Guo Ren <guoren@kernel.org> wrote:


>=20
>=20
> On Mon, Jun 7, 2021 at 2:14 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
> >
> > =CE=A3=CF=84=CE=B9=CF=82 2021-05-20 04:45, Guo Ren =CE=AD=CE=B3=CF=81=
=CE=B1=CF=88=CE=B5: =20
> > > On Wed, May 19, 2021 at 2:53 PM Christoph Hellwig <hch@lst.de> wrote:=
 =20
> > >>
> > >> On Tue, May 18, 2021 at 11:44:35PM -0700, Drew Fustini wrote: =20
> > >> > This patch series looks like it might be useful for the StarFive J=
H7100
> > >> > [1] [2] too as it has peripherals on a non-coherent interconnect. =
GMAC,
> > >> > USB and SDIO require that the L2 cache must be manually flushed af=
ter
> > >> > DMA operations if the data is intended to be shared with U74 cores=
 [2]. =20
> > >>
> > >> Not too much, given that the SiFive lineage CPUs have an uncached
> > >> window, that is a totally different way to allocate uncached memory.=
 =20
> > > It's a very big MIPS smell. What's the attribute of the uncached
> > > window? (uncached + strong-order/ uncached + weak, most vendors still
> > > use AXI interconnect, how to deal with a bufferable attribute?) In
> > > fact, customers' drivers use different ways to deal with DMA memory i=
n
> > > non-coherent SOC. Most riscv SOC vendors are from ARM, so giving them
> > > the same way in DMA memory is a smart choice. So using PTE attributes
> > > is more suitable.
> > >

<snip>

> > > 4.4.1
> > > The draft supports custom attribute bits in PTE.
> > > =20
> >
> > Not only it doesn't support custom attributes on PTEs:
> >
> > "Bits63=E2=80=9354 are reserved for future standard use and must be zer=
oed by
> > software for forward compatibility."
> >
> > It also goes further to say that:
> >
> > "if any of these bits are set, a page-fault exception is raised" =20
> Agree, when our processor's mmu works in compatible mmu, we must keep
> "Bits63=E2=80=9354 bit" zero in Linux.
> So, I think this is the first version of the PTE format.
>=20
> If the "PBMT" extension proposal is approved, it will cause the second
> version of the PTE format.
>=20
> Maybe in the future, we'll get more versions of the PTE formats.
>=20
> So, seems Linux must support multi versions of PTE formats with one
> Image, right?
>=20
> Okay, we could stop arguing with the D1 PTE format. And talk about how
> to let Linux support multi versions of PTE formats that come from the
> future RISC-V privilege spec.
>=20

Just my humble opinion:
When those bits(63~54) usage are standardized in future RISC-V privilege sp=
ec
generic Image can still be supported with the following solutions:

*alternative patch only fly:
If the bit is only need to be set during init, we may insert nop instructio=
n(s)
at proper place, then patch the nop into set_the_target_bit instruction(s) =
by
hart's feature.

*normal check feature then use:
If the feature needs a bit complex code, we could go through the "feature c=
heck
then use". static key tech can be used here to avoid branches.
