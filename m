Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725D37B2538
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 20:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjI1S06 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Sep 2023 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1S05 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2023 14:26:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C1499;
        Thu, 28 Sep 2023 11:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/0Oc1+e26pozG7i/BqhyboWRawDpx6vvIKKa62trZ8IyMicy5F2aXwbItOfhyG7bearHfcRN0h4EhvZ7bbC7oQftx/I8Nld5KP+3KN/lGkv96Bvo/EcX1i1XqMZaOdeLbB+PEkwhPzx6Qefnef/1VuB0k0fWIg3wVXkMv5+FrN74bRulmWhcSscjnScU0GrSlERl5EHq/83zj2zZQ2YbMtHDAXemlOYp6U5u8NKuVbvRaEXM7WFQWjaEpxn1bMPcRL+HA3qYFImCmzQETarewGaq0u8LqfhPf8AYjK4VohcEgCgLJB7uTRAr8hxlP6EToX8fd63LtpuB+JXQikmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3qqUWK4e4LTY8ghSO7llJdus7jM/uPURv/0d3rItyA=;
 b=HNAE196d5hWWhAD1l0R2bm6OnRDcbeLf+11phu6QVFOT8XPWieTy5c8PdioekxCCZO+e3ARIfwTo09hUwTtTe11+LgQ1zVANHXQrVsjD6v9Qi9BM5o3LodtC/uaTqse9XCuXaNkpVLKYW4lL3fV6uayWz1t3TUBs1QVIObtz6lnkw92JoL5hvmQxrAPUgLpz/j7Mg/zKemNG/UvYj6kgzfUPbgf9ytJmUBDWdK1S+YWrg5HhB2ExwIni9dEZEyGIkJvnhLwsiegXTCTrRrgoz7sEVbqMQkKRauTKXLsEaMUXbGhb4dq+Zh2Di3ooWyZwdMGWV4n9MVEXb/L/Z59lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3qqUWK4e4LTY8ghSO7llJdus7jM/uPURv/0d3rItyA=;
 b=quuSJfsrt1hr/TC5Ydca3DVPrnnTCVVXy/MwPaK/jbynw8tNSOhUyewf6WMojnZnwvHrcnoIXkLs0d2tmvgV11AZEjt8USPr4hssp3A+7RnSgfvpwgiE36YElAzVYqotPN2MM/6yH1ubxDJX7T4XUhVwB/ko9o/LbWvBwvcpcqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6671.namprd17.prod.outlook.com (2603:10b6:208:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 18:26:49 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df%6]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 18:26:49 +0000
Date:   Thu, 28 Sep 2023 14:25:57 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Ravi Jonnalagadda <ravis.opensrc@micron.com>
Cc:     linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
        x86@kernel.org, aneesh.kumar@linux.ibm.com, ying.huang@intel.com,
        jgroves@micron.com, sthanneeru@micron.com, emirakhur@micron.com,
        vtanna@micron.com
Subject: Re: [PATCH 2/2] mm: mempolicy: Interleave policy for tiered memory
 nodes
Message-ID: <ZRXFNYyK7gOSt59D@memverge.com>
References: <20230927095002.10245-1-ravis.opensrc@micron.com>
 <20230927095002.10245-3-ravis.opensrc@micron.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927095002.10245-3-ravis.opensrc@micron.com>
X-ClientProxiedBy: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3929bd-7715-42be-7086-08dbc0507ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIe/8/zYkBARl2dCFdXceL8j0kDG6mxq2XEZRHku074Tk8QG1mUqXOCwnUiO4ayk7s9hg8n/xBFTijxRSTujfUDxSzwclenkq+Oy4tJgVXYoOmffTvbWSKDXMr2jYzYk4DSVC/Opk+O9DkJOK/9ZeTAtb1R2LYWP0/RkUV5EiM21BwxaMjFXb16+fvFsq9iE+V2onP0nwxKM/G9dqbxAly7MFJICJifRaV/WdEkZnfAoHq8PIPPtwK2eQ5MVjnWr9u+LC5Qy2D+7ZVkdcZlPHs40AEIoevc233wW/Bvszp1ARErwVMtFNJG4+OGujiX5dTu+rWPAQn0UfQy3VJxDhMbLmFYMQ2Ecjfb74t8vT6n7TDhbCPEGhB1+hUIl/pCJzE/QB/lnKSLXdwtyYLZR/kg01TZ7+bKznq6Ulm7o1NkxIT6qk9gX2Ouhg/X22DmixoAILtF6jNNChWaVYRS3V3lmSLxdBSq+9jYK0Wsfw3GVdYpYh+KY9F2qTQwDlhTCtM8tavOD6/WbWZzcKwnZHXZEHhofzLN/UI8pYCDZ9oxCmc3Mu1RlmpRTxdPTOKbX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39840400004)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(2906002)(86362001)(6486002)(6506007)(5660300002)(66476007)(316002)(44832011)(26005)(2616005)(66556008)(6512007)(478600001)(8676002)(41300700001)(4326008)(8936002)(6916009)(66946007)(83380400001)(38100700002)(6666004)(7416002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8I1UF1nSShMun7lOUbIR4y6w5XYyXDixLXPW7kY9u5gpAtc0b2R0VuWjjEA1?=
 =?us-ascii?Q?LpOTA5ciEIkYkPjiz3KvOPWHQdyGnbEeZn01tPJlwQsqb474G1RiGRYbejw5?=
 =?us-ascii?Q?nSlcghfOGdlb/4oWRmlHVHT+CAjUNV1gGFFUSFSMWSynUB9AAaVA7MGjPy9S?=
 =?us-ascii?Q?TTt9og7TsRK6WIhNub4XqNkHw9qqyI5OttjgZLMIkt9f/jRBS4QmyTkx7PwO?=
 =?us-ascii?Q?oy2hD/eaO/hUKk9gi4XDHoa0jG1vagHrjHVrMjhAKmbxjX/jbR25aL4j+Er6?=
 =?us-ascii?Q?VjBm4Ci5YzIeGCDMtXBKyqBThPqeueApkniA8MtdaQffoWjDSG5W0aSXmdDB?=
 =?us-ascii?Q?9VSRTtz6nXCTYLe2j1osy0ZCT5GGOS+1oZIz/C2EUKNRHyHs1SSXxW70l6df?=
 =?us-ascii?Q?WrvbN+Opuz2xMqCg1xYHqWddpxnBoO1bpysAwO9kv/FpAI3TDT8WInGzG/Wr?=
 =?us-ascii?Q?d4UUqAj03ngM3gLUoCxFJ0DMBXKYBvWe8zhBc/7/Xk9OCQB+fEwVPnXBX2ui?=
 =?us-ascii?Q?sDQs23nhgXP5X7wbExX1iKCHTdZ3Xje4hH1ViEChkn5rcG7ng6zHRtAm3+sv?=
 =?us-ascii?Q?/XSbdx+TkuqaWBjIu3IIk0FroTF85PJMVuyiLdrt9tpD6ZNCwM0EJvXKJinG?=
 =?us-ascii?Q?ScCCqs9yoxmRNBbCVSs7ZTzjFt5xtISB0wY0rCoz0WH6FIIViZjBPLgfSK40?=
 =?us-ascii?Q?gmjFxCNoV1huLm9kCxJRqdk5YL59/kuDPNq7kdEEu/xhkCTPzZmp/C7SGd8o?=
 =?us-ascii?Q?RFWMx3nSC2DSs3P2mdbE1IRHLoJTFIPzD/UJVMuP++9Qwr7dazvHMYPdUp/c?=
 =?us-ascii?Q?CjtQ1dRnHW85Vuw4Y8/f+0SpKbbcNHYEju/cwxNzxg05mXDmYeJQ1v6p7ITB?=
 =?us-ascii?Q?dr8GQgK7ctdeF6ETXRlji8LAD1bBDfVW4CRkOK4bTEYScKCtZ20/PB6UwO6H?=
 =?us-ascii?Q?zfCYhL2fOQNUg5E+nM8HM7phj72WZKexv5BShuz2zKYf1ooJ2IEVIuogMYRr?=
 =?us-ascii?Q?Tyc0Dai9OHubSswhXY7BEZZ1kH6Gcg0iPfzsq/XsnMsNTJZnRKjEbX2ZfJtQ?=
 =?us-ascii?Q?omm2AnM9UI3ZfzeouuyHjUI32sXiT8Vlpd2ULuLVKWhczjJqT/tTGEBjOCAZ?=
 =?us-ascii?Q?249EM1Cv/sowalYPIVq9ASu+65lQ7fzXdbLjkr7ePzPubSSoOAusgAxOMSzx?=
 =?us-ascii?Q?/CH486L7tJy90Mwl9yDrhHCAk4rsQy9qG+ch51kPq05KWu7XPmEm2D9dhRAw?=
 =?us-ascii?Q?TId3RUahM57VGhhObVY+9htG34LWU+FL9KWF5AWQw5Psm4QMDt5wyiLpC6fD?=
 =?us-ascii?Q?GhkdZ3qNscCDv/t9bTPAICo9LbdHbCbrFGRhlwqi/D9CjjZ5bo2R6mUF+0bG?=
 =?us-ascii?Q?Tu4375eLZXq6TiprKBN1kEZe5kedbGmoXCVFmh7H8wflRPMOIKkomM8Bx/gp?=
 =?us-ascii?Q?4AtofPx5j7+2qWL0ZWm801j2CUYJ1rpvDwWWUNiZnBNJk96zM4J7DsdiHk+T?=
 =?us-ascii?Q?YK9Nk7QSzXoMBwHIhP3xnnp7BPWew0dusqFl8eohEXaeNgfC9cFQV4spbMSC?=
 =?us-ascii?Q?P5E7fsV/OtCVtu8SHXW5az/ICl0OpBy0DVKM/f/h3ddUA7v456hHd+gx2Bmd?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3929bd-7715-42be-7086-08dbc0507ab5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 18:26:49.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfvAKBRGqp0hOMXEapNVu5kvfqKzVjLjgdUOfxxaebywTS8ptoF1HCnLxVm6UZxct0PBs4i64GyiLpgyjbYXnGAa1jGgoJyTpYN/P7aWpfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6671
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 27, 2023 at 03:20:02PM +0530, Ravi Jonnalagadda wrote:
> From: Srinivasulu Thanneeru <sthanneeru@micron.com>
> 
> Existing interleave policy spreads out pages evenly across a set of
> specified nodes, i.e. 1:1 interleave. Upcoming tiered memory systems
> have CPU-less memory nodes with different peak bandwidth and
> latency-bandwidth characteristics. In such systems, we will want to
> use the additional bandwidth provided by lowtier memory for
> bandwidth-intensive applications. However, the default 1:1 interleave
> can lead to suboptimal bandwidth distribution.
> 
> Introduce an interleave policy for multi-tiers that is based on
> interleave weights, where pages are assigned from nodes of the tier
> based on the tier weight.
> 
> For instance, 50:30:20 are the weights of tiers 0, 1, and 3, which
> leads to a 50%/30%/20% traffic breakdown across the three tiers.
> 
> Signed-off-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
> Co-authored-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
> ---
>  include/linux/memory-tiers.h |  25 +++++++-
>  include/linux/sched.h        |   2 +
>  mm/memory-tiers.c            |  31 ++--------
>  mm/mempolicy.c               | 107 +++++++++++++++++++++++++++++++++--
>  4 files changed, 132 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index c62d286749d0..74be39cb56c4 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_MEMORY_TIERS_H
>  #define _LINUX_MEMORY_TIERS_H
>  
> +#include <linux/device.h>
>  #include <linux/types.h>
>  #include <linux/nodemask.h>
>  #include <linux/kref.h>
> @@ -21,7 +22,27 @@
>  
>  #define MAX_TIER_INTERLEAVE_WEIGHT 100
>  
> -struct memory_tier;
> +struct memory_tier {
> +	/* hierarchy of memory tiers */
> +	struct list_head list;
> +	/* list of all memory types part of this tier */
> +	struct list_head memory_types;
> +	/*
> +	 * By default all tiers will have weight as 1, which means they
> +	 * follow default standard allocation.
> +	 */
> +	unsigned short interleave_weight;
> +	/*
> +	 * start value of abstract distance. memory tier maps
> +	 * an abstract distance  range,
> +	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
> +	 */
> +	int adistance_start;
> +	struct device dev;
> +	/* All the nodes that are part of all the lower memory tiers. */
> +	nodemask_t lower_tier_mask;
> +};
> +

I would make this change in a separate pull-ahead patch.  To make review
of the actual functional changes easier.

>  struct memory_dev_type {
>  	/* list of memory types that are part of same tier as this type */
>  	struct list_head tier_sibiling;
> @@ -38,6 +59,8 @@ struct memory_dev_type *alloc_memory_type(int adistance);
>  void put_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype);
> +struct memory_tier *node_get_memory_tier(int node);
> +nodemask_t get_memtier_nodemask(struct memory_tier *memtier);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 77f01ac385f7..07ea837c3afb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1252,7 +1252,9 @@ struct task_struct {
>  	/* Protected by alloc_lock: */
>  	struct mempolicy		*mempolicy;
>  	short				il_prev;
> +	unsigned short			il_count;
>  	short				pref_node_fork;
> +	unsigned int			current_node;
>  #endif
>  #ifdef CONFIG_NUMA_BALANCING
>  	int				numa_scan_seq;
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 7e06c9e0fa41..5e2ddc9f994a 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -8,27 +8,6 @@
>  
>  #include "internal.h"
>  
> -struct memory_tier {
> -	/* hierarchy of memory tiers */
> -	struct list_head list;
> -	/* list of all memory types part of this tier */
> -	struct list_head memory_types;
> -	/*
> -	 * By default all tiers will have weight as 1, which means they
> -	 * follow default standard allocation.
> -	 */
> -	unsigned short interleave_weight;
> -	/*
> -	 * start value of abstract distance. memory tier maps
> -	 * an abstract distance  range,
> -	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
> -	 */
> -	int adistance_start;
> -	struct device dev;
> -	/* All the nodes that are part of all the lower memory tiers. */
> -	nodemask_t lower_tier_mask;
> -};
> -

See above

>  struct demotion_nodes {
>  	nodemask_t preferred;
>  };
> @@ -115,7 +94,7 @@ static inline struct memory_tier *to_memory_tier(struct device *device)
>  	return container_of(device, struct memory_tier, dev);
>  }
>  
> -static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
> +nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
>  {
>  	nodemask_t nodes = NODE_MASK_NONE;
>  	struct memory_dev_type *memtype;
> @@ -264,7 +243,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>  	return memtier;
>  }
>  
> -static struct memory_tier *__node_get_memory_tier(int node)
> +struct memory_tier *node_get_memory_tier(int node)
>  {
>  	pg_data_t *pgdat;
>  
> @@ -380,7 +359,7 @@ static void disable_all_demotion_targets(void)
>  		 * We are holding memory_tier_lock, it is safe
>  		 * to access pgda->memtier.
>  		 */
> -		memtier = __node_get_memory_tier(node);
> +		memtier = node_get_memory_tier(node);
>  		if (memtier)
>  			memtier->lower_tier_mask = NODE_MASK_NONE;
>  	}
> @@ -417,7 +396,7 @@ static void establish_demotion_targets(void)
>  		best_distance = -1;
>  		nd = &node_demotion[node];
>  
> -		memtier = __node_get_memory_tier(node);
> +		memtier = node_get_memory_tier(node);
>  		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
>  			continue;
>  		/*
> @@ -562,7 +541,7 @@ static bool clear_node_memory_tier(int node)
>  	 * This also enables us to free the destroyed memory tier
>  	 * with kfree instead of kfree_rcu
>  	 */
> -	memtier = __node_get_memory_tier(node);
> +	memtier = node_get_memory_tier(node);
>  	if (memtier) {
>  		struct memory_dev_type *memtype;
>  

See above

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..4f80c6ee1176 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -100,6 +100,8 @@
>  #include <linux/ctype.h>
>  #include <linux/mm_inline.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/memory-tiers.h>
> +#include <linux/nodemask.h>
>  #include <linux/printk.h>
>  #include <linux/swapops.h>
>  
> @@ -882,8 +884,11 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
>  
>  	old = current->mempolicy;
>  	current->mempolicy = new;
> -	if (new && new->mode == MPOL_INTERLEAVE)
> +	if (new && new->mode == MPOL_INTERLEAVE) {
>  		current->il_prev = MAX_NUMNODES-1;
> +		current->il_count = 0;
> +		current->current_node = MAX_NUMNODES;
> +	}
>  	task_unlock(current);
>  	mpol_put(old);
>  	ret = 0;
> @@ -1899,13 +1904,76 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
>  	return nd;
>  }
>  

Should this be a change to MPOL_INTERLEAVE, or should this be a new
memory policy:  MPOL_TIERING?

For the sake of retaining the existing behavior of MPOL_INTERLEAVE as-is
and preventing the introduction of bugs, maybe creating MPOL_TIERING is
preferable?

That would allow the rest of mempolicy to be changed cleanly if the
intent is to override mempolicy with memtier behavior.

> +/* Return interleave weight of node from tier's weight */
> +static unsigned short node_interleave_weight(int nid, nodemask_t pol_nodemask)
> +{
> +	struct memory_tier *memtier;
> +	nodemask_t tier_nodes, tier_and_pol;
> +	unsigned short avrg_weight = 0;
> +	int node, nnodes, reminder;
> +
> +	memtier = node_get_memory_tier(nid);
> +
> +	if (!memtier)
> +		return 0;
> +
> +	tier_nodes = get_memtier_nodemask(memtier);
> +	nodes_and(tier_and_pol, tier_nodes, pol_nodemask);
> +	nnodes = nodes_weight(tier_and_pol);
> +	if (!nnodes)
> +		return 0;
> +
> +	avrg_weight = memtier->interleave_weight / nnodes;
> +	/* Set minimum weight of node as 1 so that at least one page
> +	 * is allocated.
> +	 */
> +	if (!avrg_weight)
> +		return 1;
> +
> +	reminder = memtier->interleave_weight % nnodes;
> +	if (reminder) {
> +		for_each_node_mask(node, tier_and_pol) {
> +			/* Increment target node's weight by 1, if it falls
> +			 * within remaining weightage 'reminder'.
> +			 */
> +			if (node == nid) {
> +				if (reminder > 0)
> +					avrg_weight = avrg_weight + 1;
> +				break;
> +			}
> +			reminder--;
> +		}
> +	}
> +	return avrg_weight;
> +}
> +

With this, there are now 3 components with node masks that have to be
cross-referenced to figure out what is both preferred and what is
allowed:  Mempolicy, Cgroups, MemTier.

is abstracting nodes with memtiers actually preferable to abstracting
devices with numa nodes and simply creating a new memory policy with
weights directly described in the policy?

>  /* Do dynamic interleaving for a process */
>  static unsigned interleave_nodes(struct mempolicy *policy)
>  {
>  	unsigned next;
>  	struct task_struct *me = current;
> +	unsigned short node_weight = 0;
>  
> -	next = next_node_in(me->il_prev, policy->nodes);
> +	/* select current node or next node from nodelist based on
> +	 * available tier interleave weight.
> +	 */
> +	if (me->current_node == MAX_NUMNODES)
> +		next = next_node_in(me->il_prev, policy->nodes);
> +	else
> +		next = me->current_node;
> +	node_weight = node_interleave_weight(next, policy->nodes);
> +	if (!node_weight)
> +		goto set_il_prev;
> +	if (me->il_count < node_weight) {

What happens if a node weight changes to be less than il_count in the
middle of operation?  Is il_count reset when node weights are changed?

Since memtier's weights are global, this can't possibly work as intended.

> +		me->il_count++;
> +		me->current_node = next;
> +		if (me->il_count == node_weight) {
> +			me->current_node = MAX_NUMNODES;
> +			me->il_count = 0;
> +		}
> +	}
> +
> +set_il_prev:
>  	if (next < MAX_NUMNODES)
>  		me->il_prev = next;
>  	return next;
> @@ -1966,9 +2034,10 @@ unsigned int mempolicy_slab_node(void)
>  static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
>  {
>  	nodemask_t nodemask = pol->nodes;
> -	unsigned int target, nnodes;
> -	int i;
> -	int nid;
> +	unsigned int target, nnodes, vnnodes = 0;
> +	unsigned short node_weight = 0;
> +	int nid, vtarget, i;
> +
>  	/*
>  	 * The barrier will stabilize the nodemask in a register or on
>  	 * the stack so that it will stop changing under the code.
> @@ -1981,7 +2050,33 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
>  	nnodes = nodes_weight(nodemask);
>  	if (!nnodes)
>  		return numa_node_id();
> -	target = (unsigned int)n % nnodes;
> +
> +	/*
> +	 * Calculate the virtual target for @n in a nodelist that is scaled
> +	 * with interleave weights....
> +	 */
> +	for_each_node_mask(nid, nodemask) {
> +		node_weight = node_interleave_weight(nid, nodemask);
> +		if (!node_weight)
> +			continue;
> +		vnnodes += node_weight;
> +	}

Should this be precomputed?  This seems like a considerable amount of
work in the hot path for page allocation and there are many numa nodes.

> +	if (!vnnodes)
> +		return numa_node_id();
> +	vtarget = (int)((unsigned int)n % vnnodes);
> +
> +	/* ...then map it back to the physical nodelist */
> +	target = 0;
> +	for_each_node_mask(nid, nodemask) {
> +		node_weight = node_interleave_weight(nid, nodemask);
> +		if (!node_weight)
> +			continue;
> +		vtarget -= node_weight;
> +		if (vtarget < 0)
> +			break;
> +		target++;
> +	}

See above, now you're double-counting.

> +
>  	nid = first_node(nodemask);
>  	for (i = 0; i < target; i++)
>  		nid = next_node(nid, nodemask);
> -- 
> 2.39.3
> 
