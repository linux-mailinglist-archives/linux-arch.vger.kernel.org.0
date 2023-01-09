Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE4662462
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjAILk2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 06:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbjAILkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 06:40:23 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD531F1;
        Mon,  9 Jan 2023 03:40:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Taid3Rw6DjtWA48MgtDcD+bUhA9USIjBKJlpbJExUwyWxPOBBD1vrBLA+S+CMY2Mz67Oe1Chlij/AjBmL3fRuvuTOeBE605KJTbgZcCAMM2iszV/VB1HbVzZS1OKgyPdFkZVUZ53omR2qKb5D73A1tXC4yXQcY2kRq6Z7OM1E1mZUs67SIN7SyyLlU226V59rTppFjTHemKz3E+3zbkNYRjCRfDRU2vuqOzzY9D9ITzBop8ZFWUASW/loR4G15fvfZq7KldZJ/PGLumK2mmBdUFhkI3wO4Ok6JY/Prh3zDQOry9LthD+nEiXY5NEon15dyReD+N/a9JdvVMkj2qCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtsGF99Xzr4uqDBj2kDgx7Vo+UbdtLaqx9hP0XKFK9o=;
 b=JocZUTJvwUsP/jF1NlfkNLxqsLQPIOWzQycYGarTRlLxHLIsTamdGdbTz1wGeOrP7rS9zCinmlr+vlp2q4jOOlgodveW1O0p1lmeGeMkuwjsS56gxQzpwYl77VcgJqt2kD+zrRpmEX0jXY1St8+0V8isvFPwsi6GE572rpLFX3wERlNuflG5AXn5QZHlJcy1f0e2LP8/YVszFWkQE/cVodjHVw1Pqtb/meKzN9UXjso9k6+bzGj2Zc9BlKjOfJrGB7N8iD96smsr41jt47T3MyCWGu6T2MCf4zkPShbC9959mmnvBiaNhA06a8ao6gyPC8XdWemOGBMvnGkAfL126g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtsGF99Xzr4uqDBj2kDgx7Vo+UbdtLaqx9hP0XKFK9o=;
 b=OhseKkbLuIzA1D7NR+gcoA3nXuHdw5LKvp7eN3Gt4vYkgXruNYA4+S0t7wxSYf6/kkxTT0PMS4H7X81yn/Zt1lxsynbWMrou5aFDuFafRBCA6hnt6N7geW02iP+GYPHXLJ9/GrsyG8XudxMFag95fRZH8RPg8iB/UNVofTM0eRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 11:40:20 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 11:40:19 +0000
Date:   Mon, 9 Jan 2023 13:40:16 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Sparse warning when using ioread64() from
 include/asm-generic/io.h
Message-ID: <20230109114016.z6qowgppuh7uoj75@skbuf>
References: <20230109104054.gabdvjxyawdfbqii@skbuf>
 <9105d6fc-880b-4734-857d-e3d30b87ccf6@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9105d6fc-880b-4734-857d-e3d30b87ccf6@app.fastmail.com>
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 341ada09-5cb0-4d2b-6262-08daf2364941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tO/cFYfFgbFB6+pYh2vMbyomzp8mBfNJJoD6o32sj4QXC1nkM/tdUVcUzghd+qvOVZQbXKJM83OqYIN5YYH2QXP+X8RstkzL6rDg9XBpvO9KAty/IETS8O2tPzGNLK/03Ax9Ix+XBzxTYaCuOzjFpmcDTRDICt+Nub+Xi6ER7vxVURtlyL66Oh8/LufoOUwOLOzDdyvNLnYYQbc5z9wS8ytgcWZDhsxIFK54r0IBGGSwPc7HDy17oEV5Nd5wQcCQN3/TpzBYq/QuAtm2ZMJ0Sc2i/LskjyKVi2/2TRnMqHILVk5QiFoyU1/ZoaurT5jqSZil2u+5bTDM/G6jriENMm29cGhWaAuR5pAIkrXV9ZvglfHkyb7+uPFQQMkcMyRtJezl6Lx4PI6Cx39vjwJ2EemFZLtAbXF6yGFQqoIsS/eh+/f3pVTI+/2NTzgmd0qR/7TBFVltr4y8hweI5m6hx1qUBTgstKHrDfJYXj9RQRmu3rMlqU7hxxOysd928Bnbp0iHs0XI/rnrqOqtvMuGiewMrV7HANLfKebHrQxds6ReRc2Eaw5sjYWOxRtKrD2/MDOmgjy/Ct+8iVglL51/WsKDBXDwj3x/U3I6N3+Rp4TahorKPYgiCF7cjlLgQ5fGx7NUJkA+dhKeN4Oa1ZqoM0KlFHfXhKT/hg1WXJrHZz6VAkck7NN9PKEBb0M6G6Cj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(8676002)(4326008)(6916009)(316002)(66946007)(66556008)(66476007)(44832011)(2906002)(5660300002)(8936002)(41300700001)(86362001)(83380400001)(6666004)(6506007)(6486002)(478600001)(38100700002)(1076003)(9686003)(186003)(26005)(6512007)(33716001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1WmIq2LABxuX1xzlMhxux2Eta/w5/i56iFOjGkeWxwyxeR4jj9Dx29SzPzn/?=
 =?us-ascii?Q?d2aPudtiFbG9X5JVq/lVFjlLPCfbT92exSVGwNdt1ZSav2JZh/KkW+V5zKdZ?=
 =?us-ascii?Q?QDmD5zlGBcsUS8jmiO16TIiEOYrKQkXtpPWiUbHmIYyRGIhaOVw8Z6AEmrDh?=
 =?us-ascii?Q?YsD2VB6JL7gBWPMTz955MW/sveOjuHdQ1EWWlirI9FdJXdf7QcXkUmucybgY?=
 =?us-ascii?Q?Be+PdH8tf//TmKnADTj5ZltfoiatsKaBszmYn6Fr+EHGKbkRdrPBHIFxocgh?=
 =?us-ascii?Q?rZ9jdrdKvCWxnxZj2WJg7mKh5M1k+IwIyqD0jF5RUNdeSYbjG8ZtC0kQJ/VT?=
 =?us-ascii?Q?4Lm74/G5BIL1kOGz60Mc3y3GJp6j4DWKhdc/MgdgizTkagr78y0GL/S/7kkE?=
 =?us-ascii?Q?4kY6G9fQMTDhJ3bs2tDBUQ6d23T3Uy9vjGgUCY4ESQK2cd/I+lrzO2lZjKH+?=
 =?us-ascii?Q?g8onOL8OQZsN57LYrZWUxtO+pUS/XwWJs+rwa0600zLzxdBS34suHRi6+B8D?=
 =?us-ascii?Q?U3Ox5Tf5DfTugwan0HnjF9thbQaCF2Gg7iC0e9driRQdlXIO2EyPebkXQvMq?=
 =?us-ascii?Q?q1f36cBK84sY8lQ5iH+4OYQ4QdRkMZHKX86AH+hK3KQ6tQqpPa9gaJdA3A7K?=
 =?us-ascii?Q?Co6DTUPBp1WjBOQT4MnsgGhl7+VnzJcXtK8gindLzLZSKDR2PRMwto/ODlcz?=
 =?us-ascii?Q?XSV5CCOrQh1Xo850HXgzm1i3viBFxgibfjJH1X2/ZStTDj+SUyOjAGjU951L?=
 =?us-ascii?Q?JVyio4aWLOQ46a3QSCnULntWcuAbaFoOpe0ZRNLECCb5a7gARPHVaIAqpzYY?=
 =?us-ascii?Q?E3xRxUxznR+zQbuD41LtjsuJTBsoDdhrk8xnnSOnDag5C4QJKM7C1WwhjlxR?=
 =?us-ascii?Q?LsDDB1rRAyC/fj2FskNJlkLirE48vAYbiCib9Nsc9p3SSjg95mWA62mzziof?=
 =?us-ascii?Q?mtQ+xpgknCR2plHti70XPa10P87SQut2IcFtH5FAVzE8LRgKxHKCEhoSTHgk?=
 =?us-ascii?Q?eJfE8BXcm7yNGRiATt2HncTWdKf/eAb4EnjzWgJt4tjhfjyOM6OjLuPGswP3?=
 =?us-ascii?Q?jROnYrcCrSxhojT40zqC8dS2BoF+853oUNGUnASH9vAX6gc5mFjbj9gmlzr1?=
 =?us-ascii?Q?D5rL7cV1Vm4Z5Q4ArDUcueg7aXiPjzbiAOFxfeXQ7lWBxFEGRDBIyjppEH2z?=
 =?us-ascii?Q?Tu9H8jwtC1QFppUrsERv56NOoiF/HB8H7ydTdHKvFpWnE/NNKLdvuQN7B+4c?=
 =?us-ascii?Q?HD964RLLufSS42EhRAgXsk1tll5Qq6CkxEETNcK7xUGO18BHgIFCEwkrikxW?=
 =?us-ascii?Q?HRd+xCIuh4o1Y4K0HPM7BDNEeovbAiyw1feSo2yX/zawmq2MDHL3RJB7t8P+?=
 =?us-ascii?Q?jGh1N6BNVtUb7juyclmm9qm9AFx+a5Be239BGX6iIy14V8DW248hG0QjYd/Z?=
 =?us-ascii?Q?YuXLAdmJ2GWIA84p2GlyB7sjKYEByWTO4w4R0ngoiZ6E6/EdzHbi+8l2EuLH?=
 =?us-ascii?Q?3MGM0WuAsxJ6oZqzFlrRZL187dM9uXwP/5HrT1vD6kPqmb9uYsCX+ThSPWh4?=
 =?us-ascii?Q?bEmliXQhMENwzGXjZIE0bCPWi/io9BkLCTNlYf3ThPN+PORHtCU95wO2KZ6X?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341ada09-5cb0-4d2b-6262-08daf2364941
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 11:40:19.9242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwWpXZsxwP7+wDCtGP9w3SGI1R+hBfqs54miLpXt2j9zO+k7B5R29Vg2miHFDB+B1uGq2kn4u1AAXEZxF/N4OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 09, 2023 at 12:33:31PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 9, 2023, at 11:40, Vladimir Oltean wrote:
> > Hi,
> >
> > I would like to get rid of the following sparse error in the enetc
> > driver (for arm64), which uses ioread64().
> >
> > ../drivers/net/ethernet/freescale/enetc/enetc_ethtool.c: note: in included file
> > 	(through ../arch/arm64/include/asm/io.h, ../include/linux/io.h,
> > 	../include/linux/irq.h, ../include/asm-generic/hardirq.h,
> > 	../arch/arm64/include/asm/hardirq.h, ...):
> > ../include/asm-generic/io.h:239:15: warning: cast to restricted __le64
> >
> > The trouble is I don't understand why the casts to __le64 and use of
> > __le64_to_cpu() are even needed, when everything seems to be native
> > endianness. I've seen commit c1d55d50139b ("asm-generic/io.h: Fix sparse
> > warnings on big-endian architectures"), but that doesn't claim to fix
> > anything for little endian (and doesn't touch the 64 accessors, for some
> > reason).
> >
> > Could you please help?
> 
> From what I can tell, the fix for openrisc was described as
> a big-endian warning fix, but the warning is actually the same
> on both. The difference is that on little-endian kernels,
> the __le64_to_cpu() conversion only changes the type but not
> the value, while on big-endian machines, the value would
> be wrong without the conversion: __raw_readl() is defined
> to never byteswap the data, while readl() must byteswap
> little-endian MMIO registers into big-endian CPU registers
> when CONFIG_CPU_BIG_ENDIAN is set.
> 
> Since Stafford only tested on 32-bit OpenRISC, he missed the
> readq()/writeq() accessors that need the same warning fix.
> 
>      Arnd

Hmm, ok, didn't know that difference between __raw_readq() and readq().
With this information, I guess I can submit a patch. Thanks!
