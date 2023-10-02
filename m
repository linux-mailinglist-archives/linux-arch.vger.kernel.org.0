Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0797B573F
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjJBQKR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 12:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbjJBQKQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 12:10:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575858E;
        Mon,  2 Oct 2023 09:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhsD2MIKvpDPfQQu51njYvg6+Ghb6AKdCVGWIXbvtU90PfQTikGPeoa831QpGE7ODHbNp51iu3q/9pY1kSsG0xY64LvMpHyhEBV6UzoEXU4h55tgRgUo5Hw4aMBWf/oJ6azv4kIvmF5r/DcNNW4T3ImbV+u/IV+MzdGZ/Jh95ny24h+BhWenwv4k1w5hySO/183qEmE+fnTyByfI4KnobC6xgjS0HXq/PnFX/TSQGdbWZUWiicFdeyacfDN/kSgz1DE5w3XCXLfiL01sW7GJ3GFq3yhpTXOsPXgl070XupBcVssi2m5OvFF5/8wyA/GYVpXLhiKb6zA0K5UnpUDK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz/K7q6OgntI3HA3jHpdUUv9/M63BBgvhNQVey7ApTc=;
 b=XK6xAn7G9UbcjJNDj+VQ+Xez3GSKul3k+sUKNveYz06SMlzL2m0KjfKgOsRQdTrfSQ4oI2qN+6+xf0I+RokIaA4nrKRsFoueTN52HjOIqA6/oTcYShscoSAXeSryvbxtdqbIZdTsPKD+57Ct27iq3PfuBMzErS1mvca68hzQQC90Rp41zYzZxIONO7wNqZCxBpVNCC9hnK6lbBAWBXM22WZOU4JEOrBi60V66N/Hmm6IlAb8MC3PwJy0H6EhdlfZrp3YdPUulkOiZD2n0J02PFWIV5OZwGw7GJfEBnO6lMV+9owOPuWGb8iLobuLfbihhad83gzhJRVbl3CmE1vIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz/K7q6OgntI3HA3jHpdUUv9/M63BBgvhNQVey7ApTc=;
 b=be7MXJB9sWmccrb980h3KniiME0szS5hfkVZERX2+kped5JJHJ6Gxx+n5Rrepb1ToCgNaQF86bGBSu5JPlFPszhx70m1yXU14R7x6IWqaYycU0pqrxMIqfEWnHFa1XT4yELJ8vxOEZ2f/ITxmuWiU7/nnJTE7x9eGmogFfWsaPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW3PR17MB4156.namprd17.prod.outlook.com (2603:10b6:303:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 16:10:10 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df%6]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 16:10:10 +0000
Date:   Mon, 2 Oct 2023 12:10:01 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-cxl@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/mempolicy: implement a partial-interleave
 mempolicy
Message-ID: <ZRrrWTTjPR62qR/Q@memverge.com>
References: <20230914235457.482710-1-gregory.price@memverge.com>
 <20230914235457.482710-4-gregory.price@memverge.com>
 <20231002144035.00000b36@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002144035.00000b36@Huawei.com>
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW3PR17MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c8c7ba-59b3-40b0-eb89-08dbc3620d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4hLgZf98jVacUJmTFooeG3m0SIi8uyP2snsmvHIiyrEWuU+KbplGrTIjIKx7uyrV0yIexrNWwMCnbmKmm80Itz9dvO9uWJRNPUsKADQjGiP0rWEL3eqlmJ0kCppAYh1G+QqV+Bau3v02Dq5IO+59ta67im2HyfuYvDzjnIYfKI7XqjNhKBTWyiZbAzrueUdZfq9qHSmFVuoyKClOZKmBrHIgl0z2lKDxwTlsBc+SXJrUatp4VjRy7DpDbUitsd9hTlciTj3ZOBDNxB5qDxo1031eQc1MhmLOWXmws86bJqbW1iVGMl+OXt6NkuleJbs8IAfI1d5iebabL8rF/0J7chtqDUgpE9zLsT0I3gsgUrw+BHyQ4dmnzalefIVEVYSQTAZh+guYJ/jxIxtOtkZ+ddUWkLKfP2xVuwuvL3B7U5qG7rP56S5339zOKwgoY0yyUlw6bXTDdLjrDc9etINfFDiRDXS8PVvWw3Mf/NN4wyoLfN7aEH6eN204ryk+FSjyJxQslACaXEdaPKs/br4dEbXG02iXhkNK+uoyLAqyPelZl4jeQEAtDg2OIRns6o9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39850400004)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6666004)(6506007)(66946007)(8676002)(4326008)(6916009)(8936002)(83380400001)(26005)(316002)(41300700001)(2616005)(66556008)(2906002)(7416002)(478600001)(6486002)(66476007)(44832011)(5660300002)(6512007)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2WskHvz9bS6FSiZPvdh1cA6SHn9RO99byYW38njHz0DQ0+bd2knbxIqcRm4P?=
 =?us-ascii?Q?DRTv0gP7b+GPTy9zMQykyoDcDYjGsRSgE5Y9jlwriDX9Pd5s/Adkl4yD7AiM?=
 =?us-ascii?Q?ntIjUB+xX3b32PgOVvNeXVKe7wkZ3qGkF+MKjUCRK8a23H0N1oDYx96B9mBO?=
 =?us-ascii?Q?Cw9apsiWARGfkORYaDOUm3SFZJU1n2YSb+jaQFO4Angi/XKVTPMS75neU2qe?=
 =?us-ascii?Q?MUp4mCFm/5pGirdjy6ZRnn69d4ohiObM8QbYAoJubbTgtzMr9R3aqYaRgukG?=
 =?us-ascii?Q?ThgNapxfKPU++CKEFSBdA27rIr7W4qpmKqmAaP9fDHVTlgLt5+dbu1ivDaUz?=
 =?us-ascii?Q?j+hf7onfkJIjIx8pzIgtM2Fy5LuXIiW9+2P9DItvZb8Q3QUaNkOBbsM3Q17Z?=
 =?us-ascii?Q?3Tqrmuzafa2W6LWVeoF85GXEWhF1HqlUo04FNZ5Mtpb9oIWsDOZWncSzOP9Z?=
 =?us-ascii?Q?abmwX398ZmgQj8SYZjsjyc3nwEZarikQq2l148XzLXKK3BS9BgW9DVvZsUIj?=
 =?us-ascii?Q?Arg2WgKSz9LH0ZOu5Q1e3ijxAKpZR5YC6rBWPq2cm8uWufzgeS38fE6kdLpR?=
 =?us-ascii?Q?xUvrMHfPX6EcAavbATdBUAeiPAdKhilDexQZFf+265u0vrKhNstbB0XbK+X5?=
 =?us-ascii?Q?ti23US5DXsFQYVMfb2iXV9Fieqpn0TdNX+eXmce5PGY6eJklC8ATGyCrt0C+?=
 =?us-ascii?Q?JH5luqXDm00Y1FMx0B6A6xfo+Dlyi8vcn3X6q3Ke9vcS5alxfp4OgW8tSzcs?=
 =?us-ascii?Q?lx7l5U7gzLRNstF8T9kvk8zd0bNe19OKxrzkwn7UzdqE8BfQqyKprIzqlvIy?=
 =?us-ascii?Q?Brxt15YBlNFiVGEuuV5K90PELZoWt6sXQaGJY1ktadCbbVUl94azOfdTVV7F?=
 =?us-ascii?Q?ys62zbTXm40KXiX64VECEhYjeHiBfROKTJLeivpQAkAVZkasbP9tep6UPzpa?=
 =?us-ascii?Q?wyRFhwDj4O8FhZY1lYTw2cI1nDnIxJzsZqELDCLDRBamNCav5s2eG1iiw54b?=
 =?us-ascii?Q?zIarTSy76fL1KwrejKIw0XP5OStM9A71mgd/s4em7BejDLraeRinqdisZ+zU?=
 =?us-ascii?Q?tSVuGQ3fwFtGtqIHJPWU8MLm6Iaw9RkxLGZa9I/lS50w/S1tA0n2I4/YgchU?=
 =?us-ascii?Q?gntwKtZunVITxUBGwU1fqOYte8F0EOvbJ+H14ztXlNkcHeYQ281PjY0SUX/p?=
 =?us-ascii?Q?Ug2VcTBRPb/gSyPA+NGn6apIespuCpEATTnntUriSjsT1imlrLxunWWoQQpi?=
 =?us-ascii?Q?SVwS10Qed+Osya3NMQ8/tTIYOYyV4HIO3bLd4ohGFalpIvmWTba/Wx9KJRtk?=
 =?us-ascii?Q?rRE7sg+qsiBGXa4M7tsoW7vKzVkjj1x4PkYGq+gqMJT9Av4ndluEa8PMVI3k?=
 =?us-ascii?Q?tX3Yt/wn8w48AwvGRcxHwGmgHP6H5zo/WSZ7yN5oCpzg49yN8D6ABxTBmgnf?=
 =?us-ascii?Q?Q3MyPCQnT/HSkHtse8XTnxj135rqecjVTVQrRfOzbUt2gvkLyJcwDGYMoE3v?=
 =?us-ascii?Q?NHN6XmXwPD6519/nSuMehWj6nkUXUBGrLKH/6NeYNH7n3Tpa3KWkXVT9fDrX?=
 =?us-ascii?Q?oqN2nU2bO+/tUHzjSC7wXaGSRhHXimrgvTni7z/ej/sKbDKm9FPRSq+lU5uc?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c8c7ba-59b3-40b0-eb89-08dbc3620d43
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:10:10.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzj2Arc+yvqEIgw2xfKKs7hdTOs0C+BtVEqz9+jdskjkYFU5vnIlMeQE87Z5L77Ps2bWgoBDqXfvoyOybgCNaejySOFyT7gfWmH5jif53kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR17MB4156
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 02, 2023 at 02:40:35PM +0100, Jonathan Cameron wrote:
> On Thu, 14 Sep 2023 19:54:57 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > The partial-interleave mempolicy implements interleave on an
> 
> I'm not sure 'partial' really conveys what is going on here.
> Weighted, or uneven-interleave maybe?
>
> > local_node% : interval/((nr_nodes-1)+interval-1)
> > other_node% : (1-local_node%)/(nr_nodes-1)
> 
> I'd like to see more discussion here of why you would do this...
> 

TL;DR: "Partial" in the sense that it's a simplified version of
weighted interleave.  I honestly struggled with the name, but i'm not
tied to it if there's something better.

I also considered "Preferred Interleave", where the local node is
preferred for some weight, and the remaining nodes are interleaved.
Maybe that's a more intuitive name.

For now i'll start calling it "preferred interleave" instead.



More generally:

This was a first pass at weighted interleave without adding the full
weights[MAX_NUMNODES] field to the mempolicy structure.

I've since added full weighted interleave and that'll be in v2 of the
RFC (hopefully pushing up today after addressing your notes).



I'll these notes for discussion in the RFC v2
---
I can see advantages of both full-weighted and preferred-interleave.

Something to consider: task migration and cpuset/memcg.

With "full-weighted" interleave, consider the scenario where the user
initially runs on Node 0/Socket 0, and sets the following weights

[0:10,1:3,2:5,3:1]
Where the nodes are as follows:
0 - socket 0 DRAM
1 - socket 1 DRAM
2 - socket 0 CXL
3 - socket 1 DRAM

If that task gets migrated to socket 1... that's not going to be a good
weighting plan.  This is the same reason a single set of weighted tiers
that abstract nodes is not a good idea - because Nodes 1 and 3 in this
scenario have "similar attributes" but only relative to their local
sockets (0-2 and 1-3).

Worse - if Nodes 2 and 3 *don't* have similar attributes, if we
implement an "auto-rebalance" mechanism, a lot of assumptions would have
to be made, and any time a migration is detected between nodes you would
have to do this auto-rebalance.

Even worse - I attempted to expose the weights per-task via procfs, and
realized the entire mempolicy subsystem is very unfriendly to outside
tasks twiddling bits (i.e. mempolicy is very 'current'-centric).

There are *tons* of race conditions that have to be handled, and it's
really rather nasty in my opinion.

consider this code:

2446 static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
2447 {
... snip ...
2458         nodemask = pol->nodes;
2459
2460         /*
2461          * The barrier will stabilize the nodemask in a register or on
2462          * the stack so that it will stop changing under the code.
2463          *
2464          * Between first_node() and next_node(), pol->nodes could be changed
2465          * by other threads. So we put pol->nodes in a local stack.
2466          */
2467         barrier();

big oof, you wouldn't be able to depend on this for weights, so you need
an algorithm that can allow some slop as weights are being replaced.

So unless we rewrite mempolicy.c to be more robust in this sense, I
would argue a fully-weighted scenario is most useful if you are very
confident that your task is not going to be migrated.  Otherwise there
will be very high costs associated with recalculating weights.



With preferred-interleave, if a task migrates, the rebalance happens
automatically based on the nodemask:  The new local node becomes the
heavily weighted node, and the rest interleave evenly.

(If local node is for some reason not in the nodemask, use first-node,
but this could possibly be changed to use a manually defined node))

So basically if you expect your task to be migrate-able, something like
"preferred interleave" gets you a more aligned post-migration behavior to
what you originally wanted.  Similarly, if your interleave ratios are
simple, then this strategy is the simplest way to get to the desired
outcome.


Is it the *best* strategy? TBD. The behavior is more predictable, though.

I will have a weighted interleave patch added to my next RFC.  I need to
test it first.


Thanks
Gregory
