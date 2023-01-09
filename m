Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59B662362
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 11:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbjAIKlz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 05:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbjAIKld (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 05:41:33 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2080.outbound.protection.outlook.com [40.107.13.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E916411;
        Mon,  9 Jan 2023 02:41:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDWPQPm1cPrAFsiCKcYoOkQn1Z2V7OudRDSflmQpck9DbzDmlQTC3JNnFwfPeEymwQmLMz03QXnKP9rCMkBGvctmBlc63J40BiU+sFYTu+g9WviZZexMiawvi1mfUvCDyP75uowEfuGchwRSlE0qGretvKKp4DJv7FQ6VM+SU3uA3NMHXPZfGzr9llS7j2IjFW+1c5UODQql7ngBmzIx/vyJFFJgFQxhhsRhXxpm7Q/PUwLPVmzzEFwAMUQQr9lLJhz7/JatsuLU0cVw0/Vi5CkyO4g+WGiLVwGTyGqmuFjjg7UA5id6A4Gl9sqmuAGMQz+/494iQnb/OAyitEIK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSkUEURUw2iF1o/81Vy7MF2iUb8d/dmw4SGiJ2j7+4s=;
 b=iMtndr2LncNXQcpfgHcwX6xF+V4iGKeesguIR7aK2fHklJCl5IhMeimWPOOTv8jiNzh9FZq/j0FqCKkhZt27T8J7gnXHRj39oMs6RZRzSt/H1jiAFxGStjEX8pvFAh/njuVlEudeKej/JlT9iCHCka2pzLCPl6kDF1Nf8krummURsY2ghBf6VzcNAhz+IZxQJRdkpeOLF0n1sUigC3ik1GrzHuv5rprZJ3Jm2WX9BGHzVN/BvbWsjZXHiXFVbDIuGfbj2lgZwUq2bosna7Grip1T7hQg8/0zFjxd5qQGoXnD8mDCkWW/xPKcy67WjWDK1Sv5KcxmvtynNBFBa0pHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSkUEURUw2iF1o/81Vy7MF2iUb8d/dmw4SGiJ2j7+4s=;
 b=mASl9yH9kqPyZAG7GO+NvY2Q6pxKcwIa4AhGIIgZz5prEk7EgIrwhyPGpB2hMNTN0N9o+7PPaCpT+48nMMFyQekyTb8P9hqKzOpcJqBglzsxTHSWGcr8sG8teeYFEYHtSxxmUF1+CdAgM8YknJroNxwRWBIW21HkIv08y83RLJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PA4PR04MB9567.eurprd04.prod.outlook.com (2603:10a6:102:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 10:40:58 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 10:40:58 +0000
Date:   Mon, 9 Jan 2023 12:40:54 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Sparse warning when using ioread64() from include/asm-generic/io.h
Message-ID: <20230109104054.gabdvjxyawdfbqii@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BE0P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::15) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|PA4PR04MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: f787dbc7-d253-43a1-3a56-08daf22dfe4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EC8D37CR2wsKYtKSK0Lkw/cAn67YWF6rXry7HeD8u2Y47UBBvm/u1yKWaZJ6uI4XwNDEeeZByovTl5dVNj0meRIs/vqJKD8HRz0gEDPjhBxkIskp36CoaZhB5x7WkBBe+ktqkitsLn2tm2q2RVWsMQmIHxdzDZyDfje6109APXFFH5CMSONHvfa+eZwOeEtLl6t1Z5oxNy2/EkuKZ0KPWVomSnqu8NGZvfd/dt0UFWcE+WS27z9GKMos18071pZyYNTwSRuzPuVTXwDM/Bi6cLdnjWvnpijzP9BVOvoP72nikbe9Cruajp6hvdx/VkDylHrbXZeu8BSK963QbhR1SEssdDrsmaZ84BULX0OaF9CMotmC3xcQwDWpaGs4Vj4ViUXQBnVUnAai0g2tdROolR2rDYBeHBLwyDTqEd3Zxdr8I29voSMuB4Res2Dcohd1XXivz0gjAH8QLVGgO96Ger98sgVb4KR9JKxozOR014EYVLU6T41R8QTJKuO+ylQQ49JIPQrl+TWxUR6SeIYMxz8XLC8U3D3eBQs5OZVisEfZLlCdSbz8TVQ7zhzhi+Z8CN5BVUs9YmUmFmW1ek8JiySKXvhdNV1BlWlc0PfpkzOZ4AyafzuTxV5Ta9iWHSysPbxTocaXUUEK/4Hd2g/WK3HKGdy/ZMHWOikY0U4Ki8ktWgXswNAinzsqZDJj6f3y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(9686003)(6506007)(6512007)(186003)(33716001)(1076003)(6666004)(86362001)(4744005)(66556008)(66946007)(8676002)(66476007)(38100700002)(5660300002)(4326008)(478600001)(6916009)(44832011)(2906002)(26005)(3716004)(316002)(8936002)(41300700001)(83380400001)(6486002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+QYzPILJeA9VVzH2Md0k9elPMBvArn5+P7zD5GPe3LvdgqNxMTxJDyG2nEV6?=
 =?us-ascii?Q?/xrd5NCPgg0woXntvASGupjQGJU+8simR4JwTcRpiWPMDxWZC92knp+P8PZS?=
 =?us-ascii?Q?KX9Rmxf3eg9Q+n48Egm+wpL4uZvLM2XWLOpLwdzOCqvuL+AomzuBUphTeFkY?=
 =?us-ascii?Q?kavipxJRSkqjTb2dnpcK74s5jLdokzndpKMS4xXE/RmwglFpzN1W5h2GekPP?=
 =?us-ascii?Q?BGZOCTCsRAweNSIYFpPNZ5TZdZitYVvVKAK0XDkOcpYs3dSVGe81olPzJQ+1?=
 =?us-ascii?Q?98R6HFT3iVGcPMxWEOH72bozJdOmLvW3/z5QjfrXgaT8xeYHIUfFwFF9BmZS?=
 =?us-ascii?Q?oNYQZNY1lCfoziVANAy7Kj4LCSAyEHSAAmqtHgYicBd2cgCkpmpOeBD6bkiJ?=
 =?us-ascii?Q?CWbSUPqesZMOdYM1uaRxnQs+kBXw1IUIyrLk5LrRtVQFqYnvNU8PjgVrknDy?=
 =?us-ascii?Q?56qQigXgFHSBZgruSnaiBEsU+rMICkr3rZiRgkbkS4NBra9uXAzRvDFdtNi1?=
 =?us-ascii?Q?a9b5FpR2u4DSuFlpZyQu5qvm7+d42V4yLkggGVs+SQF7Kc/D9mskRmx96BXa?=
 =?us-ascii?Q?TTi8KozDBeZ5R8Y0vllN/JsINHO8ODV4hz2Za/hi07dnd5FkMMDg78sN1sho?=
 =?us-ascii?Q?0Dp2pqDTsa2bHt5IBEiXvJrdP7DbLonr709s1mYsMGuyAhmQNIGHMcl4UCsZ?=
 =?us-ascii?Q?myK2JkjJUd+eL6fR69G/oDwxyaCC1zOSYRrYBETbqdkx1xXVsoS0ZoDUBijF?=
 =?us-ascii?Q?iQ7CgL/KlnNctps7zkJ6LdSFqSa7bUO/mzToLVgoEHM0+PrW2x3Nn6OI4Z4k?=
 =?us-ascii?Q?o7admloOU/u1aPL8/mkfo9FaAudl7fEAHFJm/IIBBasyJlvESIb1Q8Bebwla?=
 =?us-ascii?Q?aBSnRtVlK50QKoAUJIQA8GRWEkP1Nwu9JLh2ICRvv5QPrAtK0xo2UGSqJGQU?=
 =?us-ascii?Q?Y+MziK6jF3hGP46syMR8+W1WhaV8upGBRstm1SChRb2cI0tuM9pEs6xuCXzZ?=
 =?us-ascii?Q?FsGmecw+N6KoJSixeZytNESyJOZ4Im0lz7ClpCb/2m6q9o5Ls8Fb0EJppAnm?=
 =?us-ascii?Q?wJ3pEN8iTmKR+5b4xVM17yi818lUbZDtAZyYyb2Szsti7sHcbbExSmFMNEJl?=
 =?us-ascii?Q?zf6iLqMNU+33vJ4ewelUYaKqXC9M5z8XuIls76Q/a0bQ8LYMPLpGBmTRF8GG?=
 =?us-ascii?Q?4wC8P+qOzYcn4mKPNrjJOry1ldD9rKCMhb4lEw91rOSAXjdQSzO/CuQC8Oh/?=
 =?us-ascii?Q?IMn7FtTuiD7SH4qo+6gd3EFJ0ENwAwtO88eSkmlzNvJ0pJGdqqhe7ygFKbdI?=
 =?us-ascii?Q?casnMhfEgAMPscmMncubt1oYW2ZdJ1uhsAZx8pTV9HR32PQTmjNdKk/K1rkB?=
 =?us-ascii?Q?o5rj51XYf7FxCj2mPMiZIZPe0ZfuYMcS3fhxyCLMix8lRj8EPGoDWg19N2ik?=
 =?us-ascii?Q?G35BKV7O6ya+jD3daPqKoH+pJQDo3VoGWXrk2SFhS9YjbgMvFa5eRjFqZg9X?=
 =?us-ascii?Q?gowl4Lbd9YSdJCnemp1oHk9dX2ZQjg2ou+zqALqe/kjqColVyth1XdUYHJ+9?=
 =?us-ascii?Q?HvAHU5HTiLnm4lMRE6Q52wzWA9TwUwYes9P2R2Pfjl7dcuyCurD9nw9qA7pA?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f787dbc7-d253-43a1-3a56-08daf22dfe4c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 10:40:58.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvYo5KIStzFCw6jGkDomfjyq12y6sSx7pc/tSqtCrrF8p2DBTLFF+7HqtUXj24g8BRJ32PimK0EPl7f4Pqi8Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

I would like to get rid of the following sparse error in the enetc
driver (for arm64), which uses ioread64().

../drivers/net/ethernet/freescale/enetc/enetc_ethtool.c: note: in included file
	(through ../arch/arm64/include/asm/io.h, ../include/linux/io.h,
	../include/linux/irq.h, ../include/asm-generic/hardirq.h,
	../arch/arm64/include/asm/hardirq.h, ...):
../include/asm-generic/io.h:239:15: warning: cast to restricted __le64

The trouble is I don't understand why the casts to __le64 and use of
__le64_to_cpu() are even needed, when everything seems to be native
endianness. I've seen commit c1d55d50139b ("asm-generic/io.h: Fix sparse
warnings on big-endian architectures"), but that doesn't claim to fix
anything for little endian (and doesn't touch the 64 accessors, for some
reason).

Could you please help?

Thanks,
Vladimir
