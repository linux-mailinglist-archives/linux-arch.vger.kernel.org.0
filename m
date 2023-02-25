Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB71E6A25D1
	for <lists+linux-arch@lfdr.de>; Sat, 25 Feb 2023 01:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBYAjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Feb 2023 19:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBYAi7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2023 19:38:59 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on0711.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe14::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE263A1E;
        Fri, 24 Feb 2023 16:38:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ6Q6TFNx1MX6jdhkV4mZcl5muZ+0W7POmBvLG6HwI5gd5NPJwQtdqbcKCw0kYH279kSaz5J7cm3/PMCzYLWMBKPKEDsPcwbpvO1xSeXjwFBmXxoWOTzD6qhZWhZfA1xYA1qNT1xLzClvH0kcBuD5Kjl57frHl9XhCsC46baimc+fjWVjbit8nM+AjzRS4Ais5XI9vX5IQFqNgRCnAVODAF8ehM9dHRe47Dd5Rj3rMXluf3XNqIB8j0WA/RUzG99vSbFJJRK6IruXRkSHxkXkvANjJT1KnbQeMkfnOZ08d5I2xbRrHlJ/AkQW8g1gT90BtZ3+AUHhADjYPOOnAzpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YDe2KOc7vhEbaOiydcHaKlxU6DLCBemy/0LRbmP4Fk=;
 b=YUqlgO2PSR/alHQRX4LP6RmmiA1UkvcdIjYDZoD6Ex3aEjy2i5q3U8Np5MXvJzuUVbUwPfB83UelVECXJemNUGtGs7HTbTTlp59ESxJ5n37N0AShQPvORrip8hDuYxmnNVS0eKfvbFzb5YQ2RLcF9SxllRQqmNmaRVfDouNVZ6LLVGmzm+dGjno3fAzGNlA5WvKz1d7Xe/eU013R76dRiO5x5/I721z7M1PRtyTGXbLCB3LuTsD9IlKlfrxYDOxdXenXbU8ttq3DS5D148SdrPIn4MRccHvfBhfrod/gorCThqWZsyfJ99EetO/WPRk146gsGINq807uZJ2Mm3S/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YDe2KOc7vhEbaOiydcHaKlxU6DLCBemy/0LRbmP4Fk=;
 b=rqLQHsaZOGJiM6u4W9vWBxtMnj79v549bBn9vRkN3WxUoxkZ1hUKMQrM8gzhztH6i37BkcV+xnU95zWMxsm+FYDtjlHUNmsCzr9mz1I+NeIOvWLP4R9YR+prcO/aeKTq9JX+SKDv0ZGJohjOCs3i+sg5CBNQg2YOmnTBe+foVc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:38:54 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:38:54 +0000
Date:   Sat, 25 Feb 2023 00:38:52 +0000
From:   Gary Guo <gary@garyguo.net>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Asahi Lina" <lina@asahilina.net>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        =?UTF-8?B?Qmo=?= =?UTF-8?B?w7Zybg==?= Roy Baron 
        <bjorn3_gh@protonmail.com>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] rust: ioctl: Add ioctl number manipulation functions
Message-ID: <20230225003852.1bbedc54.gary@garyguo.net>
In-Reply-To: <0818df3a-76c9-4cb3-8016-4717f4d5bf18@app.fastmail.com>
References: <20230224-rust-ioctl-v1-1-5142d365a934@asahilina.net>
        <0818df3a-76c9-4cb3-8016-4717f4d5bf18@app.fastmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::35) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 0413223a-d245-478e-8cf2-08db16c8ac41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IHPaTHOCOhHc6GceR2kiAGMRmkA3xbE/wjazzX7E3piUBpUEcCgsiEks7fhEQs2bfuMCIxz7MhApwCpQWbDM9816x7Ye+gtXc9SMy1ql4tzyYU5Gtbj0qF4oCl+Yb4IaplaV8rxo9oGTP5H1YdEo2LOO2ktkYkiPlSgshMWxsNP3eVKbt/eWlH70WjeeMywvnfv+NPW1MUY2MU7C0rO1uDWX+gBayrps6UoR+6Gy2qBSN5yAnbkiCnNIkSrlf8geP6ZCKqQOeCmk1c7aNvZRW0ENWbg5xJbu7ifAj0nrhXtbucdBuw2YnrcrRWck3x9Ty0BXpwnqtO6U41GhphydvFxxgmpgW5m543baVd9g91Bev+I75EjUaPTuS3M50xtVuwA6JYpGa8+muz27QIyoojBoJ5RXG2gW7VGWepazrOMtlUg0f9CZUWVEBEcv0HcdTbLJz778NBpJJ6eHBipkTHQEb2zHues5m2yZueLwTKXK/PsYqBaBkAWJWnJ98+h34v32VU3dTWu8uSziiDvEt2OfD4X/R/N7tg7Re9m8XYdYagQR8iHT+19VCOzcnRapAW83y0VVJKMtAoWF9PXxLFZEFuKCpcNlLSavcQwuIYvchNlzCiI6ecDuGdVJ3l55gYmBWGY0X2+kh2oH3ModQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(39830400003)(376002)(136003)(346002)(396003)(451199018)(5660300002)(54906003)(66556008)(66476007)(66946007)(316002)(7416002)(478600001)(8936002)(6916009)(8676002)(2906002)(41300700001)(4326008)(6486002)(6512007)(1076003)(6506007)(38100700002)(186003)(26005)(2616005)(36756003)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?my9mGts0YG5dTIvXOpD7SnLlIYMztXFEcKOxgiLcjzjhnsvKB1V+MHJizu4e?=
 =?us-ascii?Q?cuC3sldohPNuSIH29sTvIPgXANFeKjpyNwAkTZ8bb9FGcpKIj6jRyRlD3/lf?=
 =?us-ascii?Q?Jo8kygd4o4hfRhZqPsXECyQFX0q4jNfpDtAqn1U+oE+BhMbA0O5MIjqCqjXW?=
 =?us-ascii?Q?o/pCBaeCZuW1iXTtUGtPmNKnALPpXU8WcFDeL0TGlEgYjjWZlIhGCUsS9VdL?=
 =?us-ascii?Q?hS37XJFDcdCH0oLYnc/LlqFmFzljedbzheIETPQhI29fYZIT4kdIqnx/6azX?=
 =?us-ascii?Q?9qw+SAkZPtKfdH3Ikk2Oabmx4aL5MhBVBGbulljB6B2km90NDWGYUUXDcy5B?=
 =?us-ascii?Q?rRc1kBWHikuSB/62XcSNJKFBpZNeD4+/2G+aYzF5jTuY7gYJ7qIUZWsKCkIy?=
 =?us-ascii?Q?eDHMviupk1/LCJzTEpWgAlZmrNK7I5YrSadp24lqWVj+J3zSB7/hF2rKrLIh?=
 =?us-ascii?Q?e6pY7+HBZ16mllq4LT77X/QW8/i9Vw614tErDeKZKd6IbIolHgo9tt85AbzA?=
 =?us-ascii?Q?QJ70KcPHAsmWFzTWoNuI1wXU1gE4Ow4FC0Xxy4yYoRVKvNKiyY77pYd9FIEh?=
 =?us-ascii?Q?9LXz/drwRgC0nxpOquTSmNL129/9aw670uitX55FlfBEjac4kxJIUT4mSGQd?=
 =?us-ascii?Q?RRGkf9nhl58/MXMBrr9Iei7y+v0OQ9qNnB/b4WfOy4xcuCdom1r//VrXLg+Q?=
 =?us-ascii?Q?0psslHUbpf211ggiRyEy2HhBvciUl4UQ7nOYTSRf7qc91h3ANj4H6BzssUnh?=
 =?us-ascii?Q?Q5g9WSKOaN0K+3VrZ62QUphetZy2LP2B4SXgeWF1MMtiF+ZZjkmQvYOkWueG?=
 =?us-ascii?Q?25sEJ78l8YWdwyk36oErnwjE/GYfcDCB0RhBFssjfg/BUdqxfknsdgFr+cP7?=
 =?us-ascii?Q?kJx5BYpvXtISVnFhZGYmn8hKAis4qZHldKjenMgIoYZ+kJmVxAsHcnl4P14N?=
 =?us-ascii?Q?4h66JOFa6a23e+sU0j5a824nya13x0L62lzrmfECbvCE197TBLeI5InPqzjC?=
 =?us-ascii?Q?+vubviDazYtui3qW810DBdkVp7WF+5WsmgS0p/GODQh2BT17+XVohS3+2aC4?=
 =?us-ascii?Q?TUMXJdpH4oORCJL6zqphAmxpbQgLN8tbduTqtL3PVtqeehpzu6In+/PpUYDP?=
 =?us-ascii?Q?Rn5PL9JJSGTUDd4LofwH4okggCKC6+xZkrHDqA9T1guR94+XoCzG17CwjcvL?=
 =?us-ascii?Q?9lLIDp8i2j7Ki2uaPVg6BELOK23AegcBDrjAmFGUx4G7XxqfbRZXKcAtwfT+?=
 =?us-ascii?Q?oyfjbXDrGISi7uzKaRyjVASj8DJ3NL+nsoS8JVBPgcYeZ65ElAV7kuw4BBol?=
 =?us-ascii?Q?4abiGKQAP2mstVqQY7XOD2uzy5l3tsrsyMm0pMuRN2lMyMpAvgIoWUS6Vi9Z?=
 =?us-ascii?Q?URbO9W5TYHEZohvTbU0sfVnG9JsiWGwhruqtb2WHutVsZNh7yjIbZtqOwCWA?=
 =?us-ascii?Q?3mVVNFRbJNTDwVQ5C6JOLA3Rlz/TSK4X2RjIPhNWsW5dzCBSNzNx+YNUlGsK?=
 =?us-ascii?Q?oyiT0sHzEZ9lW6X6MXCOuzsHGcyJQDSGXqFew+wwp40naeXijiVWNGsrF55g?=
 =?us-ascii?Q?aZ0lW+9yvqU2+WOpLWhJI3pcLRiFVdZQzOKqbt0O?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0413223a-d245-478e-8cf2-08db16c8ac41
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:38:54.3566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vozOZLzUtiv8ySeTYu4GW97EQtOyiqiwIXjMkmQMAnE4610PjthviiuMk73759OZHSTxgQL4XaH3J/b49FtLJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 24 Feb 2023 09:43:27 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Fri, Feb 24, 2023, at 08:36, Asahi Lina wrote:
> > Add simple 1:1 wrappers of the C ioctl number manipulation functions.
> > Since these are macros we cannot bindgen them directly, and since they
> > should be usable in const context we cannot use helper wrappers, so
> > we'll have to reimplement them in Rust. Thankfully, the C headers do
> > declare defines for the relevant bitfield positions, so we don't need
> > to duplicate that.
> >
> > Signed-off-by: Asahi Lina <lina@asahilina.net>  
> 
> I don't know much rust yet, but it looks like a correct abstraction
> that handles all the corner cases of architectures with unusual
> _IOC_*MASK combinations the same way as the C version.
> 
> There is one corner case I'm not sure about:
> 
> > +/// Build an ioctl number, analogous to the C macro of the same name.
> > +const fn _IOC(dir: u32, ty: u32, nr: u32, size: usize) -> u32 {
> > +    core::assert!(dir <= bindings::_IOC_DIRMASK);
> > +    core::assert!(ty <= bindings::_IOC_TYPEMASK);
> > +    core::assert!(nr <= bindings::_IOC_NRMASK);
> > +    core::assert!(size <= (bindings::_IOC_SIZEMASK as usize));
> > +
> > +    (dir << bindings::_IOC_DIRSHIFT)
> > +        | (ty << bindings::_IOC_TYPESHIFT)
> > +        | (nr << bindings::_IOC_NRSHIFT)
> > +        | ((size as u32) << bindings::_IOC_SIZESHIFT)
> > +}  
> 
> This has the assertions inside of _IOC() while the C version
> has them in the outer _IOR()/_IOW() /_IOWR() helpers. This was
> intentional since some users of _IOC() pass a variable
> length in rather than sizeof(type), and this would cause
> a link failure in C.
> 
> How is the _IOC_SIZEMASK assertion evaluated here? It's
> probably ok if this is a compile-time assertion that prevents
> the variable-length arguments, but it would be bad if this
> could lead to a BUG() or panic() in case of a user-supplied
> length that is out of range.

This is a very good point.

The code, as currently written, will cause a compile-time error if
`_IOC` is used in const contexts (i.e. used in const generics
arguments, or inside a `const {}` block), and it will become a runtime
`BUG()` if used elsewhere.

We do have a facility to enforce compile-time checks, that's
`kernel::build_assert!()`. If runtime values are used and the
compiler can't optimise these assertions out, a link failure would
be triggered just like how our C code does that.

Lina, could you change these `core::assert!` calls to build assert?

Best,
Gary
