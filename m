Return-Path: <linux-arch+bounces-411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6ED7F5511
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 00:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68929281655
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 23:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA4219F7;
	Wed, 22 Nov 2023 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="k2iU0xAN"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9C83;
	Wed, 22 Nov 2023 15:53:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyucDrCgZAEvPONfs3dMkPkjP56rID/nWDtTQes/S+HUdBn91GGHShKfxagpHTL15+WHZNaIwY+GqSYPZqyEz318Omhb+dFANyOBkbDfoHoFCqfjU1PBWujw2hrEqlRW8T8RoDWR1ayvbbkE9e00A8yh87VPYY3lAbOOTvkSNfjAcj3YYTLxp8cix2tYCjSTZyl71mHY4220E7JTOWRzQKvM1euNzsmaVLvE6rucgrLfYTxR2Xhah9/Pta920aX9pzyZRe6GWVU2fcZHQ6F5MPxW8Cd/3d6wIilBdh+lKH9UqZDjRpZcqWfDsEr0QpZHCM6xKrH279HNjZCppVdNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDIkRfPSN3IGo3R4oDnLWtfjO/P1CG98n4ZTIzg+y1k=;
 b=fC6CNBqMkT/RBeySUNykkkFP6erEsz+xCZS4U9yRzS4mh2uDicCLfHO6wtmvPaPYbL8NgKJBiYKWEXJ3TiFje+aXHWYXMaP5odOZ/kmsAQCd47AHB44bF5j8Wt7yb5QCzPLb2PW3rBcZ5evbzM1lxX7gKEy/ZQU4iZWOZGorYbDEwMLrYWGfA2LiWSkOUM+tz082BUli6wPDDIcx7X1eRKbD6X7Wzf6SeqcaFrHC3cwcfjL4qOwbOszfvnvMHUGmVkahK0Mc2yQVg0EhI0WFFX5LQCGcAAd7w2p8mX8lEWaw4IKyvqL4bZW2FbokZXKDIGgWoiGslkP+2AD0vQUkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDIkRfPSN3IGo3R4oDnLWtfjO/P1CG98n4ZTIzg+y1k=;
 b=k2iU0xANbyaFP89ajCksg7N891AKT0+v0eI72VrsIuPXX82IClUZDauibRr/9Q5ht+ctkMLNStRrTyDysZ3yLOcaB8t+eLOC0HoMwwGIkCUCii6NHwQ+iWbIw2/5DO0lbROKMJTOflbldwC49JnwR7yzsAqI5tIN6FjMlZKm/aA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6336.namprd17.prod.outlook.com (2603:10b6:208:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Wed, 22 Nov
 2023 23:53:51 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 23:53:51 +0000
Date: Wed, 22 Nov 2023 18:53:42 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Vinicius Petrucci <vpetrucci@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	minchan@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
	Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com,
	ying.huang@intel.com, dan.j.williams@intel.com,
	hezhongkun.hzk@bytedance.com, fvdl@google.com, surenb@google.com,
	rientjes@google.com, hannes@cmpxchg.org, mhocko@suse.com,
	Hasan.Maruf@amd.com, jgroves@micron.com, ravis.opensrc@micron.com,
	sthanneeru@micron.com, emirakhur@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
Message-ID: <ZV6Uhsg6WLBtNqU3@memverge.com>
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
X-ClientProxiedBy: BYAPR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::24) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 181ca7c3-51f4-4485-57df-08dbebb6468f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n40EgeYER4u75qpL2UX4pZqAfWwjrdzNh0ITxSYSuIR/jZJHULNo74IOhtE71TJTWfAW099b1puw47LwszpzbsvOPDAQIMa89G9OCLRz+Sp9NfvRLsYMjvOIGMvCX5yESe+dkliaLle6BITvJO5DVnexlV1nbGJG1rPkuO7lPWzhc+6yw4zXozpTYsHfm3c0YrphaRBqv0ZZU8PEO6+eerStltWlwPXI02Y35ebG33nRJ8zVVnr1PJIkOYhQciOPW6XPhUsGSoQbXRR5RFe4Fh5LbkDd7OfaUxCBrGS7Jf25dvJvM33JNWP3JFsn9EHP+z6HxjrMQlKKQ4dDeGFh6wp+sWFpnwKsjskhIf1uzjaqdob+dtE/XxehY7dapdnq4t8kLXUhqZLHiGiF8evBabGQu/iDpyv5E9Lp6RBT28T15Dr2AquhK6fbN5rzSjTl9BNV+ODhjrU33f7/5SOq5T/PF+YUdC8yLb3g5vplw4YDDqRv/NCw9DuPnE4qowqm2CwpVvSDpLQUIAqxYREH31m83p/nlZRtyghljeTJblo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6506007)(6666004)(6512007)(26005)(2616005)(478600001)(316002)(6916009)(966005)(6486002)(83380400001)(66476007)(66556008)(66946007)(7416002)(5660300002)(8936002)(44832011)(4326008)(86362001)(38100700002)(8676002)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MKcQ4+Y+wOD2TMmkSwDmes5A14AGxMyrXaX7WxYogehH690jL2PAuvuZgfq/?=
 =?us-ascii?Q?YFg27lI4+NRsbKHfQcYAuCFBrKnoFPCGcndVMNwoCjmB5aFuOlzDJHlZs0vV?=
 =?us-ascii?Q?e3X5N5RJXfLSrInqvn6M0tbAanckIcM4ZzMCYviUK68WvbhnpQCQuqecRRgj?=
 =?us-ascii?Q?36ZaGF8tZu1HzcSGnB1HT/l+Fbb6KobiIkNzFBWxyD8uUafdpIDluJ+7+5yM?=
 =?us-ascii?Q?q33fxNKSMkLp04SDr27DeCKnJVZImdZctEAdxANHo/aDUzLcRupx8zUW80gx?=
 =?us-ascii?Q?LMSIAsuNqS7azE7BBEHXXVQ8xHWoaX3Q4G/4S+gZg0+XfLgCRtEnQ2Dvlqb/?=
 =?us-ascii?Q?Xe4M3t7zDLIjVcaQsbdGBVm3im8QT63nD8r3LvqdAd8Kf9caKofjaMT6Lt0/?=
 =?us-ascii?Q?Q+t3EknS06UKbGU4tLgWFcHdSuEKzE7uibAqSvQQZfs9jqbsw84FG3QCF3WR?=
 =?us-ascii?Q?XvcWFYclyalU6FKAtR1vVf8ty4XhXQ6CY1Mnc6N+mkqIFZ7InVRex595TseV?=
 =?us-ascii?Q?Md5HLnT5WM1TSwKwZfuSbjQXzsYVEP7ib5UUmdN28TyDeS9quuE3QFCJGQoP?=
 =?us-ascii?Q?UJhP+zPQPrbGPGUIHeQnpS/TIsI7V/V5O5OYBT1wsz/ISYwk2mp2NQ+jDgbG?=
 =?us-ascii?Q?cJRRFc+9XPPJq7qFz6gMyuWrn90RJbIdkQra6Gs0CQJ4LgkZt6qwgfQRJzEA?=
 =?us-ascii?Q?b2u2fCkRqBMc4DSAFmcX7v4cc2fTOTDHtxbBb85z19OUsckAL0lcHoXHqGk5?=
 =?us-ascii?Q?4/vuICIIuW3vrqNvUBxLxJJYbFHqfrKeab70XBukhCGwCZ2MNo6gWAfNBLbn?=
 =?us-ascii?Q?PDgW0IAXm8+uTWZF19uSrk2S4jhNRCjr/RLlwVXKtxlRYtWMqZ5WjLpxB+F8?=
 =?us-ascii?Q?PUJhosws/NdPWUvIgstXVgcxblk37c8HKswKp0ZZw9lUtjI4fgKBfaD9mkiU?=
 =?us-ascii?Q?7fFhh9/WpTeVkfN035F+g8CVCKhxrgaqm9aDDmhjJwudmgp0Efzb2NAYDNbr?=
 =?us-ascii?Q?LNsxInLXS6wdq8l9pFcWxqP5hCD0SOhtocrYZsqoXBEhJzZ1vMVvURiDBaom?=
 =?us-ascii?Q?uTkjZKNLR4JtR5fQc3kLos6zxf4e34scUo1cWIlh+2N4wFKPmrNd13mJ4Xoa?=
 =?us-ascii?Q?YKZFBh2994evk4C1FTzi4jTaQCQp8o+7SnHEIdT15qw+R2ZpXgu5nUuwVvCh?=
 =?us-ascii?Q?WrBu1Fo8f0R/QDq6DHdxSTTDGyaHFtv5XhvAybMkr2hiOkQ5MT+lOxy/15j4?=
 =?us-ascii?Q?Qif/0sVIsXZPtN+xjXit7kCcsMX1FE0g34owyU2h/m0akakdvcYdTrfj9L0A?=
 =?us-ascii?Q?/098VNp6z2A65/ZHVOTWls9NGf28sP2azlsQEY5axHU4xhRge1kQfc/mHqBj?=
 =?us-ascii?Q?BLCiKM4Fph/8ToLFLAPSxckS3Et0wHzfQUJrFi7FyvfpAXlqFu8VxqsShyVD?=
 =?us-ascii?Q?RH4JzQQ6C5/hsTOGhdQTGDg5+n2hN3Lxk2b7YbDXR88eJJavICz1GMaUdVQT?=
 =?us-ascii?Q?F7ugrhq1UVj5e/PK/foRrVT0YVtG5RGjWJBXxtU6kFc+QR9BD361lgvHs+uF?=
 =?us-ascii?Q?fbpocdilpZGTV6OXXh65d6W9eKfd+Z/b7JGNsPTvHQeI2Arx9gE0ki85pCcb?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181ca7c3-51f4-4485-57df-08dbebb6468f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 23:53:50.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d5vrYzz7icOIHqI+rC6PRnpx7Rb8ZWikj4jI7kh2MCtcgVNkuiyl4j9XKff1kqiAUrxE5aBh5sU2ZjGvNYIRxd6mKUkjYZUzGEswDI2HQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6336

On Wed, Nov 22, 2023 at 03:31:05PM -0600, Vinicius Petrucci wrote:
> From: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> 
> The proposed API is as follows:
> 
> long process_mbind(int pidfd, 
>                 const struct iovec *iovec, 
>                 unsigned long vlen, 
>                 unsigned long mode, 
>                 const unsigned long *nmask,
>                 unsigned int flags);
> 
> The `pidfd` argument is used to select the process that is identified by the PID file 
> descriptor provided in pidfd. (See pidofd_open(2) for more information)
>

This is probably a more maintainable interface than the pid_t interface
in my RFC, but I have not used pidfd extensively myself.

I can pivot my RFC to utilize pidfd as a whole and pop this on top, if
the other interfaces are generally useful.

> Please note the initial `maxnode` parameter from `mbind` was omitted 
> to ensure the API doesn't exceed 6 arguments. Instead, the constant 
> MAX_NUMNODES was utilized.
> 

I don't think this will work, users have traditionally been allowed to
shorten their nodemasks, and also for some level of portability.

We may want to consider an arg structure, rather than just chopping an
argument off.

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10a590ee1c89..91ee300fa728 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1215,11 +1215,10 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
>  }
>  #endif
>  
> -static long do_mbind(unsigned long start, unsigned long len,
> +static long do_mbind(struct mm_struct *mm, unsigned long start, unsigned long len,
>  		     unsigned short mode, unsigned short mode_flags,
>  		     nodemask_t *nmask, unsigned long flags)
>  {
> -	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma, *prev;
>  	struct vma_iterator vmi;
>  	struct migration_mpol mmpol;
> @@ -1465,10 +1464,84 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
>  	return 0;
>  }

This is a completely insufficient change to do_mbind.  do_mbind utilizes
`current` in a variety of places for nodemask (cpuset) validation and to
acquire the task's lock.  This will not work the way you intend it to,
you end up mixing up node masks between current and target task.

see here:
https://lore.kernel.org/all/20231122211200.31620-7-gregory.price@memverge.com/

I had to make do_mbind operate on the target task explicitly.

We may want to combine this change and with my change so that your iovec
changes can be re-used, because that is a very nice feature.

> +	unsigned long maxnode = MAX_NUMNODES;
> +	int err;
> +	nodemask_t nodes;
> +
> +	err = sanitize_mpol_flags(&lmode, &mode_flags);
> +	if (err)
> +		goto out;
> +
> +	err = get_nodes(&nodes, nmask, maxnode);

per above, userland MAX_NUMNODES may or may not be equal to kernel
MAX_NUMNODES, so i don't think you can just chop this argument off.


I think we can combine our RFCs here and get this sorted out.

~Gregory

