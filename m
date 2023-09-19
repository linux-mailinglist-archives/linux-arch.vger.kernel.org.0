Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91707A6A97
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 20:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjISSUY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjISSUX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 14:20:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D8E8F;
        Tue, 19 Sep 2023 11:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ8iZ6qojclXKyS1znwXpZTNsfGVQn7t1tkhIVwsCJEkk1Ws2Q+cCb/WDHBivXao1/8UlM2RgXWtCZl7tg9+ydx2ZzZ/d62NhkX7og7OvIlm0syUwLc5cHVdlFtv2UEQzqBUZccdz/a7fsdb8W8nF3DZODZ5dj7kWmDQonKh6We9jkH+Ia5J7F1WMLNIixwVXqBkuWUg6fyGT0yx8bloYH3AkBkujMN8ts4xkQTgA1BRfEO074AR39Dq1mRLodIK7JgV6BVX8ZaeAFSwi7VCIygarTaemhLbxwkPafPBfFA5uxLNMHXvuBSEIa0buCfRr2afqeqDTtp2Z0C7rQ2LQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkq9CYpYNZr/jqpib3kXkUKWvV3EBJzWHBi8wqoEfuM=;
 b=femNtAML2Zvvei2BrV7Us2a3UiNWKYB2DkqZhOoQV0RXncwiGGFuI11hH+PuYx68FB0fwwdF51GA4shXgLzdfph40UCIpwwCH9WTieTN6KrNh2u0PBJ3V3N315MOd1vIbGb3yH1sMAlka2xNkM8mUZx/sc/sdWU6EZoQyAhcitT7rUNnp9Nxj2HHqJhy8J7j+8mIz982DzeUcpyeahtGzFancQlvvIzZD4ccpCMRdywUasUjji621K5KuozUEj2mTT1FXKh8yqR9myIKt0n0lpppNeufh5dV0AZlqg+9C3wRmlfjp10k61GxTjwpC5IT/mh+oGmopD8XUowPJBc/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkq9CYpYNZr/jqpib3kXkUKWvV3EBJzWHBi8wqoEfuM=;
 b=Sd1jr5/FqYwWytY/GBERMp3rrukNRvtDlhsfsLWhThwIxO4qxc/WYOhs8HHFVDBzvPpFF63x20CKIDD2Is0gRfOsa/GenI1SFrro/3SmDnM7eq/aMbw+MeibvPMP5hrmXG+LUElChrSWndcgWvlQugl4Ntj/1m9/JseXaiv+6kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB6403.namprd17.prod.outlook.com (2603:10b6:610:122::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 18:20:13 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 18:20:12 +0000
Date:   Tue, 19 Sep 2023 14:20:04 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Message-ID: <ZQnmVI0Q/Al5UKgQ@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <878r9dzrxj.fsf@meer.lwn.net>
 <ZP2tYY00/q9ElFQn@memverge.com>
 <42d97bb4-fa0c-4ecc-8a1b-337b40dca930@app.fastmail.com>
 <ZQnMzD26VI3C/ivf@memverge.com>
 <0a7e3ccc-db66-428e-8c09-66e67bfded51@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7e3ccc-db66-428e-8c09-66e67bfded51@app.fastmail.com>
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: b67734fc-ed2c-412c-87dc-08dbb93d107d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HtdWp9ixnIqopvQIA+SAsFsLuk/61/d35mVbizi71qYgtBjeqemCc/jTvCdVPvX/ckyt2c5KMdv8GFxRkwQbk8Ok+/nxvnvpR+2aWFR/SA5Hggqh7TDncAEqpOR7ztfbgulxRDJ3htsMh7r1koxvIkIwvRhW+5jXCy/EfGYkZ1oDsvqlkUhQmOnFaTz5s50cQm87U0aucpeeynvdYDIpIwjER6i/fb0lHCy8AIZpVz46cBlBRWZOPkMvfc4jq6+Nh2hfyZEp0moR2rCMOlWAx9VxOo06qmCjFckojHLaCwdori3fNbOC3xF2WgrPuew+YR46aDr4cCWtx6siQ6xT6C9bxX6XalfH6O1wGhjztJVfLOGKc7x7n2lki6QoarmcEiaZ84ARPqPwGvdK7/sYT1IOTOhlJt+nPcp3OdPzqMET+gBUNTcDRVdq3sMHI4N3vTpS7Md1ji3ksBvTGqr3bnTzeRACFii4ygcJ92KiAUogaZky4xuemQ1Fr8dLjwObMkFTtCnr/a1rrUjjETsXERF3A4Nf3ov2o5nC6sOF3Nhq/ZD/DcYhZE8Oo9tp0Ed
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(346002)(366004)(186009)(1800799009)(451199024)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(26005)(7416002)(5660300002)(2906002)(4326008)(66476007)(8676002)(66556008)(54906003)(66946007)(44832011)(8936002)(6916009)(316002)(41300700001)(2616005)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HqRGDCcN1EkY2MjkfgAuXrBFlHMDAI6jSFJkqWbx8JSMXXDlPkmAQYB/F1Gs?=
 =?us-ascii?Q?1CGMZb8/jlP8K7lvikA/8Yypl/7gFQSZq1YTC1C60I/kxhG9IedgeBgU43xP?=
 =?us-ascii?Q?tf80JDL0P6UHpMCqDlrdDajWmea9zaTJDu2O5U0Gekl73XG9zmrjwXPt6H5B?=
 =?us-ascii?Q?GaXoWXr3tKM+YSvO+Sz/4dquwR4Qies0j++9wJLWRT7rBCl5KHw/0P4t15x+?=
 =?us-ascii?Q?2RfEcK3ORaUvsH82/UPdmToCXNkk+GPmg62TT+BJT3Q01t9hFvD6S3bDIfn5?=
 =?us-ascii?Q?VREadmt394yLBm2ySOCUOFBQ0LWjWTGn/NzoktqUozFj2MrkxiX1VVeTXtqb?=
 =?us-ascii?Q?cbvZf9DT4WMaDAuYKYOQEU/q0s7zUXEh05bdP4dMzRrIXaBiuOxP6poD7vb3?=
 =?us-ascii?Q?xZFdWlpWnRcJbwKu7Hp5kXFcSILTu86HAxFcbZhimhaWFOK5c2AhuEjA2OgF?=
 =?us-ascii?Q?M4BuVr64Utskc0wXBVVlW8aue9LvkvKr7xWaa0pbuyPr1u8XXvpp+W71pXhw?=
 =?us-ascii?Q?odWrElv9mFIA6m+WhUDrIFBtra42k+M7QlKnla6mQwTGgBOvUURkJkIrpz0y?=
 =?us-ascii?Q?C/kcbB0B5KXGQs1NopkhugWaqdj9sK4fk3p2CDiQ8iE45zJg3YIFw3+GSFTg?=
 =?us-ascii?Q?bqVz5eJ1Q4pZpWVkMAydda0yEk91q8x4E7OU0QFwl2lGIc2l1Wsk05wI+x//?=
 =?us-ascii?Q?Gl+Tn1xByM/kjOissDGNU+r+DpFolcm2U3+Q91U+zHKt8EN9R5G9o80iHExD?=
 =?us-ascii?Q?6q18HObFuhbcnThjGFO5ScV+io02r+rVHJE5rzFHjhBqxSj4RpVR9211S1FD?=
 =?us-ascii?Q?JlNbzqSusC3IprEQAgLJrsdrXm9AfuGt9rD74ij+cia+enVIN5SOZxT0yKaU?=
 =?us-ascii?Q?3s0Ellk3CSboKqrpj1bY8gbVArRml5fFjBMr7OuBcmWyJZJ/uwtxQt0RTLLV?=
 =?us-ascii?Q?xexj+PPq/0rzNrcnL5o5VslBiF55qQ+EFykioKa8Vr00nS6FB96jndFLB5oA?=
 =?us-ascii?Q?VI5VbwSswdYtfcx5dzEjzMy4pPhHG60vj7TFJW4kj93yFdYxWMYiEJOuWqwT?=
 =?us-ascii?Q?nxmzUY8xQoDJ6duq1ffJtv2h/3fg5z5GFIv6inb/fTF9L9L03X72DTSeUfR0?=
 =?us-ascii?Q?Dgl5khJndTwhF9lXpHQw9zzbY7UkrWqCb2YOMZQpZvYPcAeEOESDWI7xQhu+?=
 =?us-ascii?Q?jo2S+EW99VfW9KdvgeVvRcViXFLMwlxl8UichsVVnT0PTuAa1/RbKBP6mTks?=
 =?us-ascii?Q?Da17B0NcUJdffr35ewzsotcfnCXdiUxbwJInIB/a2KJxwnWoPsfed5uug45O?=
 =?us-ascii?Q?XY2SwVt63FsUPy8dg18cpRUUpIUv3v1je9ubeAmUArhc79Fx6ZWa4pnFNKAq?=
 =?us-ascii?Q?KQD9f7qNJdXC0CyA0BU4Hw2o8vPlwiDozLo+RI4YJ87i2LCHFxe7iPTDyXHQ?=
 =?us-ascii?Q?oO3T07ianeqaZva4XYzrki5LbPQS3LRW/EeJk6iPBMKaxfynhnrrPV/iv0s+?=
 =?us-ascii?Q?IuIBvJQe36SRj07wiaPT+rCF4Jw3jHQPa6KHERItu1kdVZTxIttkt4j99gGa?=
 =?us-ascii?Q?5li+ODa92RD33cIe23nvnxOPsYZYFTrbI6qgQleKieVANL7vS5Q3AcfOiDA8?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67734fc-ed2c-412c-87dc-08dbb93d107d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 18:20:12.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gEbkMJWVW1UQrR3D9XATg7tewc+yjRDc8XM+o5TAPKHW3qPBBnZtSHZoEE4bWMN6HKzQWUKKDhADHPAi11M/sP8G7VJ2ZiwAoNeKtfihx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023 at 10:59:33AM -0700, Andy Lutomirski wrote:
> 
> I'm not complaining about the name.  I'm objecting about the semantics.
> 
> Apparently you have a system to collect usage statistics of physical addresses, but you have no idea what those pages map do (without crawling /proc or /sys, anyway).  But that means you have no idea when the logical contents of those pages *changes*.  So you fundamentally have a nasty race: anything else that swaps or migrates those pages will mess up your statistics, and you'll start trying to migrate the wrong thing.

How does this change if I use virtual address based migration?

I could do sampling based on virtual address (page faults, IBS/PEBs,
whatever), and by the time I make a decision, the kernel could have
migrated the data or even my task from Node A to Node B.  The sample I
took is now stale, and I could make a poor migration decision.

If I do move_pages(pid, some_virt_addr, some_node) and it migrates the
page from NodeA to NodeB, then the device-side collection is likewise
no longer valid.  This problem doesn't change because I used virtual
address compared to physical address.

But if i have a 512GB memory device, and i can see a wide swath of that
512GB is hot, while a good chunk of my local DRAM is not - then I
probably don't care *what* gets migrated up to DRAM, i just care that a
vast majority of that hot data does.

The goal here isn't 100% precision, you will never get there. The goal
here is broad-scope performance enhancements of the overall system
while minimizing the cost to compute the migration actions to be taken.

I don't think the contents of the page are always relevant.  The entire
concept here is to enable migration without caring about what programs
are using the memory for - just so long as the memcg's and zoning is
respected.

~Gregory
