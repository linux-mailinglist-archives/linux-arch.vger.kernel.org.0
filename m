Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD535EEB9
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349686AbhDNHre (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 03:47:34 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:36464 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232950AbhDNHrd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 03:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1618386430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9dDdHIwZkV7r9qGvEFNc4GuGdDLCHQvGS6qe4Cl1XQ=;
        b=QKmd300uUmSTnYdZhalVnYnsSnoa5mD4lO5RImlpJemk65SxqYLcTCqGXSvQ9AUdssxrAH
        dLMC5EzdlXhpOMVWxgpWBdncKZkpIvgsbrZrBiJ4SqVFPUsCtlHpSlIKx4KUMHtwxXEg2R
        6xht3U3laEqkifVAj93oPekJYh+Mtk0=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2051.outbound.protection.outlook.com [104.47.0.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-A2LKJI3BNg20qqrHwUpZRA-1;
 Wed, 14 Apr 2021 09:47:09 +0200
X-MC-Unique: A2LKJI3BNg20qqrHwUpZRA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmK8geGzi9Eh2tmuK+VcHgMr+B82krOehvDkElzftrnxK7CjVBn7uA91RZI0j4QJP+QGzqMjmmzLqvHL4TMnWtqUeVMRd5hX8jMEmWRBRtDzBfYdej/UKLFT+43eSBSq+EH7/XtidDsh9Qm8roZjaqyTCeT+QNPoZluIY5BBsYiPV/SDn04BHgx3djR7uATA+q+Rrdv0O+IOeicEjsxPGazDYcShYIPlqQn852ZBzfQorfyJi7aQUjT039P1eHZ1fzJQaKvQPYrFiMxBGGbFluIjI4jzc0JKd/deiUZjR0BtLloJJ1e8eRgIIOpTEWrCcgwx+989t06RgW0XsURiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XeQGLQwH+K7l/kwa9AoSsOVBvaaScPE9r1NyD17mf0=;
 b=kJD+OR9iaJNbhiucAEwGSAQVFhOW2zciNh3oYjOQblsjo2WIl+ksLjs9q53xF/Em6AHCLilCGfIe0lVC86DykO9hho5KzteE7IuvMSH2CjHjz021YWAxn0V4h9cXk8XiLaTyX2mgrGR6EcfVpRC365ih+dU3Iksh40yD5FPTsv5wrC3L84ayGic6zBvTB/Vdn3mxUdIy5k4Q3dQchx8+NUY7nmv1Y9fR8hw9xa5VsWAK0AfqdxVLKZuO1jg2iefsgnwGkMsu2Rlx59KPohTclDMu3ZXCB+2GZ1laJ/zbYAuL/bPWbeMVy5uBJlFeC5lTWy6b4SNts3W/AYJwNCwoxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4253.eurprd04.prod.outlook.com (2603:10a6:803:3e::28)
 by VE1PR04MB7280.eurprd04.prod.outlook.com (2603:10a6:800:1af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 07:47:06 +0000
Received: from VI1PR04MB4253.eurprd04.prod.outlook.com
 ([fe80::38a5:f78f:fc4c:8a44]) by VI1PR04MB4253.eurprd04.prod.outlook.com
 ([fe80::38a5:f78f:fc4c:8a44%5]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 07:47:06 +0000
Date:   Wed, 14 Apr 2021 09:47:01 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     Alex Kogan <alex.kogan@oracle.com>
CC:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com
Subject: Re: [PATCH v14 6/6] locking/qspinlock: Introduce the shuffle
 reduction optimization into CNA
Message-ID: <YHad9S5ckj5IR1l6@suselix>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-7-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210401153156.1165900-7-alex.kogan@oracle.com>
X-Originating-IP: [93.212.194.79]
X-ClientProxiedBy: AM9P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::8) To VI1PR04MB4253.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from suselix (93.212.194.79) by AM9P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 07:47:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d9853d1-49be-41a1-edbe-08d8ff19800f
X-MS-TrafficTypeDiagnostic: VE1PR04MB7280:
X-Microsoft-Antispam-PRVS: <VE1PR04MB7280A717670DCD892035072CC54E9@VE1PR04MB7280.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4iOOGzBKzvO/RenIevyl86nYlt0o3E98fxpT4jAYshqVdqldystv3WxsSbUNZI30MVKn4GmgbXJGAJhC2O1puubkYWfw52fxnGTXipVbS72aq6S8MXCNQVtteMw7dywv9zAX87wGtP3fU61gMMQj2j7nJ239HeR3FXSePH1A9uJdqfQoU9xH5IVG+TfLt4c5WFpQCAQhwHgrYOrgz35THmdvvWI1GV3AJ/46ySD+Iu8v8GCHM4a0JT0qvndtqefkngz9+woQzV/51FrzoffkhmTl2hnZWP7KFbpVh7bQsE8tgnAHAWsEkbGGdRu3MeUMc3Y7mroWgZhJQ5156fLLf9zb896nzf9269HrRJPKGS7G+W2JoGVXKhsdeu2rA1qIAkYw+jd6qNSPK9mY8OYlIUY68zg9SXjTPwD8z4pcKPw25pymJz8fsIqdqcD1n7ZkpjnfldC7pVlwbL+pX65j7ZejwpGne2tBYGxxQ35Qgi4hiSeG9moKHQg8QVQausURqucWVVrxoB+wyKMIVU/tJAWIdAvEaHa9uja1YFUeUcuhcX1oPFIuYF+crvdpRic1EfkfY9xgUnJfJRPF/JJcI0YlzZ394LAJRF3GtIfxx6+4QYI4wbN7j4N/i4okF87hiP+CVajflQI1i9iME+Ivg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(366004)(346002)(38350700002)(38100700002)(5660300002)(956004)(8676002)(2906002)(66476007)(33716001)(9576002)(26005)(7416002)(316002)(86362001)(6496006)(6666004)(6916009)(52116002)(478600001)(83380400001)(4326008)(55016002)(9686003)(66556008)(66946007)(186003)(8936002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tNzwdXgZ3SJZ1+e/f6Ih9k9+Hfz5EyfwrtJw3gh8eUVJPCf6MYSxeKRAwvPG?=
 =?us-ascii?Q?dJio7K7wK0gnl2oiJV7aWSnb9snOKHx9ehHdu4g1PLoggqCXq7FEWsoaCTXv?=
 =?us-ascii?Q?VtaX23B0dN2oaEhYBgBE7i7N6hR7/qBMStvUnRLb0SH96mexL2VDGCxLiitB?=
 =?us-ascii?Q?pZsL17V0gDTltEfyFSpfgKTteGGpwvKERQHoTarAlaHo6dCxKveJt2YcAPgn?=
 =?us-ascii?Q?60lyx+e+iXG73DE7qysdt/kllaQGh2dy+/sRicfIVq3EhLVEbhpVXGP+oCsA?=
 =?us-ascii?Q?zy2kKCp1+960wuKR6WgM2OvoGK7BBjm+Q+WvWztqpRtdwl5aKufZZwJZe82A?=
 =?us-ascii?Q?Cn+pqYmAXmL5g6jiWyPdL0EnlQGBWcAIK/smD3ZmK0F8qV5EQ6+Zuvd0OkOq?=
 =?us-ascii?Q?HglaDve+yILk2Jja86gwg/VV7AyJzizjJ61daLQHZuF21DssTngTPKhHs45I?=
 =?us-ascii?Q?3CY7dNmpzxPrC02oJoQo7kh1mkxyHdVdh6qB8mjQ+43ASfOgiVDmDme6sHtF?=
 =?us-ascii?Q?f+PZFf7CG1u6jAuTw71weaXySUM/LyitWlYRkKdfjtlORXkD7upGKV/iuDMa?=
 =?us-ascii?Q?ZNZXOmmGYugU49LO7hAEu5jliwDvufl1C4UNorhIkSWYNag/DfO23CuQUYD7?=
 =?us-ascii?Q?X4IAVE2vp4bpMZRCUUYkb8ra04yHVoUHSKSH0cO9/aG2NAZ7CIxswZdEZknJ?=
 =?us-ascii?Q?oB0UzrSYxZtFLdXHpzhQcYO4fWR6jlAg/A9iJ0tgQvcIZCN6ber4SCT4NPIO?=
 =?us-ascii?Q?fPB+OLpu9wha6FBkh8Nmr9bhW/HVJANPikJP9X+mC5M1OIH8YCTdYf5kDhI1?=
 =?us-ascii?Q?/k+ig9nc5IgeuwHxNZHXm30d7UKxHwcY3iACKTyPMCBWM3OmFjaPWzw2jXuv?=
 =?us-ascii?Q?eK4sKEFP7T6IU/W2ZPJc+0BoVALrpkl3svDo7w4sAP+cuVzdvlPmWpQ/oWyL?=
 =?us-ascii?Q?Hyzm+N6DY5pJoJ7SzVqxRKxrO/kzeQx6dcqOD6G5EsW97FkuIAdFw0XMiaBf?=
 =?us-ascii?Q?3O1TeAvWkWzsGAakuhdDA0ensPVqNAkhBwZ/uXZ00XeWFuvAMD3wbh3xF6uw?=
 =?us-ascii?Q?wMjOoWdpCu0Ofg4qZnWbuRYYRuzV5DhXEVoH9R7q7IMgiY4xZ5HaJ/YCMuUn?=
 =?us-ascii?Q?n6WyPaHo9ikwWyTwXbeFf/0qql+e29YAAi9yywv9k65aCNMs19l7DVKzpqzU?=
 =?us-ascii?Q?O6/MvN+7H9ieypqXrLnnt5FjhlggAhlFiQ3nqIB6AtlNhN/LkJ4LBvldPuc3?=
 =?us-ascii?Q?Fmg0d3Nw5kymocay5ugMx1z3cY03Ek5y3TUuUWf+BMeFkfPo2OYTc89BT3ox?=
 =?us-ascii?Q?nxMYqE+bL6tHJTZvQfNjk0qe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9853d1-49be-41a1-edbe-08d8ff19800f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 07:47:06.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEkmMptJxRSBh3K3WW8WSRcyL9RsnidAJYavQsrYqtjlh2SVMplvz12SqMrG4cDGHpPViImdqRnRFOqrnPQ8lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7280
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 11:31:56AM -0400, Alex Kogan wrote:
> This performance optimization chooses probabilistically to avoid moving
> threads from the main queue into the secondary one when the secondary que=
ue
> is empty.
>=20
> It is helpful when the lock is only lightly contended. In particular, it
> makes CNA less eager to create a secondary queue, but does not introduce
> any extra delays for threads waiting in that queue once it is created.
>=20
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock_cna.h | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cn=
a.h
> index 29c3abbd3d94..983c6a47a221 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -5,6 +5,7 @@
> =20
>  #include <linux/topology.h>
>  #include <linux/sched/rt.h>
> +#include <linux/random.h>
> =20
>  /*
>   * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware=
 lock).
> @@ -86,6 +87,34 @@ static inline bool intra_node_threshold_reached(struct=
 cna_node *cn)
>  	return current_time - threshold > 0;
>  }
> =20
> +/*
> + * Controls the probability for enabling the ordering of the main queue
> + * when the secondary queue is empty. The chosen value reduces the amoun=
t
> + * of unnecessary shuffling of threads between the two waiting queues
> + * when the contention is low, while responding fast enough and enabling
> + * the shuffling when the contention is high.
> + */
> +#define SHUFFLE_REDUCTION_PROB_ARG  (7)

Out of curiosity:

Have you used other values and done measurements what's an efficient
value for SHUFFLE_REDUCTION_PROB_ARG?
Maybe I miscalculated it, but if I understand it correctly this value
implies that the propability is 0.9921875 that below function returns
true.

My question is probably answered by following statement from
referenced paper:

"In our experiments with the shuffle reduction optimization enabled,
we set THRESHOLD2 to 0xff." (page with figure 5)

> +
> +/* Per-CPU pseudo-random number seed */
> +static DEFINE_PER_CPU(u32, seed);
> +
> +/*
> + * Return false with probability 1 / 2^@num_bits.
> + * Intuitively, the larger @num_bits the less likely false is to be retu=
rned.
> + * @num_bits must be a number between 0 and 31.
> + */
> +static bool probably(unsigned int num_bits)
> +{
> +	u32 s;
> +
> +	s =3D this_cpu_read(seed);
> +	s =3D next_pseudo_random32(s);
> +	this_cpu_write(seed, s);
> +
> +	return s & ((1 << num_bits) - 1);
> +}
> +
>  static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>  {
>  	struct mcs_spinlock *base =3D per_cpu_ptr(&qnodes[0].mcs, cpu);
> @@ -293,6 +322,16 @@ static __always_inline u32 cna_wait_head_or_lock(str=
uct qspinlock *lock,
>  {
>  	struct cna_node *cn =3D (struct cna_node *)node;
> =20
> +	if (node->locked <=3D 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) {

Again if I understand it correctly with SHUFFLE_REDUCTION_PROB_ARG=3D=3D7
it's roughly 1 out of 100 cases where probably() returns false.

Why/when is this beneficial?

I assume it has to do with following statement in the referenced
paper:

"The superior performance over MCS at 4 threads is the result of the
shuffling that does take place once in a while, organizing threads=E2=80=99
arrivals to the lock in a way that reduces the inter-socket lock
migration without the need to continuously modify the main queue. ..."
(page with figure 9; the paper has no page numbers)

But OTHO why this pseudo randomness?

How about deterministically treating every 100th execution differently
(it also matches "once in a while") and thus entirely removing the
pseudo randomness?

Have you tried this? If so why was it worse than pseudo randomness?

(Or maybe I missed something and pseudo randomness is required for
other reasons there.)

> +		/*
> +		 * When the secondary queue is empty, skip the call to
> +		 * cna_order_queue() below with high probability. This optimization
> +		 * reduces the overhead of unnecessary shuffling of threads
> +		 * between waiting queues when the lock is only lightly contended.
> +		 */
> +		return 0;
> +	}
> +
>  	if (!cn->start_time || !intra_node_threshold_reached(cn)) {
>  		/*
>  		 * We are at the head of the wait queue, no need to use
> --=20
> 2.24.3 (Apple Git-128)
>=20

--=20
Regards,
Andreas

