Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1F7B706C
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbjJCR62 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 13:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbjJCR62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 13:58:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF3A6;
        Tue,  3 Oct 2023 10:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngmmfHgbdjNCDI3Hk/Yd9DoTr3ZaC73rGaMU4n260Xl3wAKklH4U2dY0Z5nlV0h086KeJhvOKOuojPrpS/smlyvAlXf2yHyzENvb48aglULDzwNLWZdXIDZwuIcYU9XP8Ya9zsordRNKWrh8Q8wTdu9T5fD3Tr4IGRQzWlxlzA/qi1IPz1SBz6EI2GaOIYklJa7bGtfe59AvNzqBxgpTIb2Exqcc7kOfKtPG+jbnIFaqeY+43mtpz4pGQFINlmJOebTEdqM8jGHxgtsBkTIz24RjQBuSX+bYXgiYxU1bjyMhIt02oZLNf+AfuOGAq4RL1JqdRyHgCNLGld9i/tdP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+czx7X/JUK7vjfiuJrF6CjADJVnyrInu6F/zpc5mZPQ=;
 b=ONwa8a0seFpU+03tOtxqUepaJP2HhJCgzbzx3FMcPRjjmRLG4jyI6v82odgtg2gLw/lWB51ijKQMu4QE2rgfwcJV0l8czkEa4HcPA+4Wes6jy7o2QhsqZan/6vNcHwrYDl3yx96lB/eTmnRk9P9SkM+947jcwYliMPtxLVoprQtEa9Yly7pknhsc6bBedJnXIbgoodwOymKINSGQgPXdFHYmKfugE1mTswvLG1oq8WdgpQxYpFDRXg5h2TpRGVvZCkoRohVo1WSg2+lEThbPvmUjFJ1kmZXUtaSyFzzrT3bN4rbvwI+w7DuOMUsVQaM/YllyMvu9ZFFPcDPay2mZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+czx7X/JUK7vjfiuJrF6CjADJVnyrInu6F/zpc5mZPQ=;
 b=NAmIzY27Wf43zRFy91uxURizmdGYG0V1wW0GhYTTNMjtQdFbg5Q6JDLBGN0vA4viNtLcp6kK7SQiBbEor1hp47tJZAUENPEJ77Tx9l+cd71T6+yfNROsrWiAMRXsKM8nvJAvluwQS7fT0tTT3D/hO6DvW8gBRFByTeQgzjforN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5139.namprd17.prod.outlook.com (2603:10b6:806:1c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 3 Oct
 2023 17:58:20 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df%6]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 17:58:20 +0000
Date:   Tue, 3 Oct 2023 13:58:12 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-cxl@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
        x86@kernel.org
Subject: Re: [RFC v2 4/5] mm/migrate: Create move_phys_pages syscall
Message-ID: <ZRxWNFBdCAe9KIwj@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
 <20230919230909.530174-5-gregory.price@memverge.com>
 <20231002150746.00007516@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002150746.00007516@Huawei.com>
X-ClientProxiedBy: BY5PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:180::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5b887f-507d-45fc-be2a-08dbc43a5437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ga+aIiLikx1I79diPTUvvwjQ6EwL3DBCqi8E0XtQxsyKg7+cNc9Bu5qFGqcOaYHYJUZroOAIrkfTcuSxYyyMVmpWKHMzlzvzvDd6mXBdDAyJm9JWPzXjex0OTtFuBhvq8hXf/BSF/QeBEOsgHbrvlwxZlv5wNEfZ16JacBdxj/3/zgbIJIsVyakE9jWMpWQQcHkfAf+zifcb9QuYoMUJ181QUSneQHDgoXTr5pGfR9vFRUS5oTF0WZJzloTWeEpnQq5hOJlD1KcAK/+now/gfS0i4/ezQK47As/DgjZbCW92W2VLTP2+wGscp32LIcGNi4xC3R5VN+S1YoqDN2zBo5pp+y/gSp+sowmrhmRAqpTWGvZXlZOx5/CztE02Y6DaXBcVRIGlpufiQU31tNsNUMUp5sFqVqYHH1LF0yU1Ae4/gBfnPT4ho+qbOUFG2pcv2D2v+b66Xo74+kXwyBiQ7s6XM9WMYkWc0GkKPsmPKy8oSBkyaH0hxBIUC2eXZs20YkMoEQUU2BFDkMbqHSdsCztZaj5Ev7O6+gsFXYPKEyLRa69ElVMcQ1VuTzVr5FRu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(136003)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6666004)(6512007)(6506007)(6486002)(478600001)(38100700002)(86362001)(2906002)(6916009)(83380400001)(2616005)(26005)(36756003)(8676002)(66946007)(66476007)(66556008)(4326008)(44832011)(5660300002)(7416002)(316002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6mscAyz5jzEA3eaFFW/pEbNgmUrYaRjcH1/ea3e+fAymoW04vjnNpo4zW4Jb?=
 =?us-ascii?Q?Wo7BKAUyftZNo5jD+Qq+jK4zts7GRkPsd3ttZ2LhsytZwmUYDR5rWeQbndzu?=
 =?us-ascii?Q?C2D1n9tyMy9Nmj2Ww7ogVFLsNT8p4X3lFQBg/kfWpA6wjmNhziOLj/yIpFbc?=
 =?us-ascii?Q?Advyvb4kT6y2E7VdLmx8lGqXr0Sx4jdpEKYxoKtQXxY/7jiEBsK1/XP9Lay1?=
 =?us-ascii?Q?n8bfFEnwGpWqPyrL1F7y5lCcwrsrCIFt56qwv3OiVGNczuc9H6P46ql9S4rb?=
 =?us-ascii?Q?Gz0JNEQYTWtpzvVfSlQamsR7QaFQeL/EVaSCWQN7/2HoEx0XjEWkVe2qwwPL?=
 =?us-ascii?Q?5g/2gJQlln87bw99I/pX9YzTRAvRKCizHInn4XC34LCQ+eu5QAuQAH8qq3L+?=
 =?us-ascii?Q?6vywDlWd6JKU5e6y5Z7qTlLfzh/sYenQGJ0Q0axsHqKM6RKnfhPf3DNKnI32?=
 =?us-ascii?Q?8DLUotGwiar5s37kwREHKKutR4Jt4K1aewXtrBiLX4QYXnubG3T/r1Vu97Qw?=
 =?us-ascii?Q?rCIFEdBgPNa5Ed470p2ugXWjK2tWNG3t4lFtU4yhPCB909/1PPRPZQC26d07?=
 =?us-ascii?Q?zLcVIdx9ooYC5ZLQlcge+thNc+RJmq0FsuHo1+Bz8uMa3DRoTIfdhXJt9LJB?=
 =?us-ascii?Q?zjerR3Ja0l7Z/vO4vYDIYNAFHCe91oZ+4oLk+3cKGr/7kFK8axLqbM5uu8CK?=
 =?us-ascii?Q?afyVy2Fgvi0UHk+vftV1HOc/qYYs1BNUuYu40Wnujk6ycCxRN3cZjxHMbvAw?=
 =?us-ascii?Q?jEzzgxTYs6ySEsyn9pXO79lZgw/0mQyZ6cOPsV4IborviBwa9TFkKKbr7PWs?=
 =?us-ascii?Q?hQJr6iLXT3KZFz3fSBEKszd+QktwL/zWvINzSUc7QVKixamF0UyFR5J2N08K?=
 =?us-ascii?Q?JsY4JMsqbT/zjAf7oPwTAKaMy1278QGyw10O60q6FxYrt69yB192cc5R31bd?=
 =?us-ascii?Q?0o3BCslbqbn1+Ae/qxfx7vxbW77saCVbBNWEF62Q207CxcU/N4t9pfEIo0Ai?=
 =?us-ascii?Q?x0+AG1xtWHWv8vG4sP9olcyEZe6fF+LaRwNaf8U3nd9Re8BdPhSag6Z1qp+u?=
 =?us-ascii?Q?DZrnx6viZ7P0Wr6KUcUqlImTJHI97GOfvFA9L3KJHOop9qFvgCbLEhnq3Ska?=
 =?us-ascii?Q?0HTrLOzyvQsbGrPUtfLiGgcUMBiakdn7a9GQcglLaLRd8FnDGha0DhFOoMqz?=
 =?us-ascii?Q?ukSxD2U3SghGBl0tKxFdLD55zddWDq85kMwkoyk3wZKI05XgPiF1RZhWCiL8?=
 =?us-ascii?Q?TPvwJUBubsyKYE92FqcaC6L3xLA3I9IV6OPyY+L0gXgOkk08sFvFWeYpRC2i?=
 =?us-ascii?Q?crqAbtSurXIJXa4o4UsFs7zWXMKd2yEz0JgJkLTLGi3YVuIzfVpNvCffxe6s?=
 =?us-ascii?Q?UYzLzHqJa1JHjvn6dadXu91M9qljhqi6BQJAmez9Odff4SXgSaM9/RUAc/4c?=
 =?us-ascii?Q?yy2mvs5jYozhl+ZQ+CQDpiIupNsNknmQpRDspRRczUnWJ9Oqk+8xfBGBSx6C?=
 =?us-ascii?Q?xltg22zUfu9ck/0sWC4ijARaspY1ivtPBfJFDpKLbhApqM2bazijnM34wyCW?=
 =?us-ascii?Q?Qmt8IRA0KSpMFEjpJLGEfWgHwPxe97TTh4KPMl0oh34rtYta8Hx3IsDRmcW9?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5b887f-507d-45fc-be2a-08dbc43a5437
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 17:58:20.5766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnG6TzgTqLblkbecGnC6eEIKY4u0M0sdsKtPCAOPR47eUjJo2+BAGgqtGIPCD9/UOVsmXlBxrsjBy6zEQZ8lERvUU2i6FBKYeyvml2TdfVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5139
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 02, 2023 at 03:07:46PM +0100, Jonathan Cameron wrote:
> On Tue, 19 Sep 2023 19:09:07 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > @@ -2181,6 +2290,10 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
> >  	int start, i;
> >  	int err = 0, err1;
> >  
> > +	/* This should never occur in regular operation */
> > +	if (!mm && nodes_weight(task_nodes) > 0)
> 
> You document below that task_nodes isn't used if !mm but it is used
> to indicate this condition...
> 

good point, and in fact the code below does ignore the contents of
nodes_weight if mm is null, so i can just drop this check.

> > +set_status:
> > +		*status = err;
> 
> Given you update it unconditionally this seems to wipe out earlier
> potential errors with the nid.
> 
> > +
> > +		pages++;
> > +		status++;
> > +	}
> > +}
> 

status is a list, the status++ increments the list pointer.

> > +	/*
> > +	 * When the mm argument to do_pages_move is null, the task_nodes
> > +	 * argument is ignored, so pass in an empty nodemask as a dummy.
> 
> If ignored, why bother clearing it?  Looks like you are using it as
> as signal rather than ignoring it. So not sure this comment is correct.
> 
> > +	 */
> > +	nodes_clear(dummy_nodes);

I'm a bit of a stickler around uninitialized memory, seemed better to
ensure the nodelist was empty to force errors associated with an empty
nodelist should future updates break do_pages_move to remove the
ignoring mechanism.

That said, I updated the function such that it does actually ignore it,
but I'll leave the here since there's no harm in clearing the nodemask
and leads to more predictable behavior.

Unless there is particularly strong feelings about this, then i'm fine
to remove it.
