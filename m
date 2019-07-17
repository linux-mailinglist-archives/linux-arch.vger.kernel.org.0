Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7B6C100
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfGQSdG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 14:33:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfGQSdF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 14:33:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HIOMrp104085;
        Wed, 17 Jul 2019 18:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Nt1djCiW2v5DCWrFgJ4gH6llZFolu0csYx/x53Q36PY=;
 b=vzEDQebF8/I2vM9bCDO6V7GLz4jTyBpGCSlB0Ge9uO1/K54cE2hQLoXMamB8Bf6+m3hl
 rLNR+evgTsmVYQ4Vf9ZHMCKre92BBTW79CY5ggJ0o5BHo7rfFbRQwT798qe84/xhRtIi
 b6Ikjym84OB+G0i9mwun/OXMRIv8P3kIcvTZTCqkdcrFSMMMKMkuOI/Di+9hEXWEDYvI
 1tH4CLFVByOwpRWo+6Zf76R30ldwEOBJsWxq8iK1tSmRNSrE4otxt9cpYtwR1oHQ4fTL
 nbQzcxU8qu5YX7THZhIaFjVb834UFN1b0wthL1TQyHVoJrfOoPHntlF98RrcDEOvj9Jx 1w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtvqq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 18:32:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HIWZSR035259;
        Wed, 17 Jul 2019 18:32:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tt77h9x8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 18:32:36 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6HIWWKM019968;
        Wed, 17 Jul 2019 18:32:32 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 18:32:32 +0000
Date:   Wed, 17 Jul 2019 14:32:27 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Message-ID: <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=895
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170210
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=947 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170209
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 17, 2019 at 07:11:47PM +0800, Herbert Xu wrote:
> On Tue, Jul 16, 2019 at 12:32:53PM -0400, Daniel Jordan wrote:
> > Testing padata with the tcrypt module on a 5.2 kernel...
> 
> Thanks for the patch!
> 
> And here is an incremental patch to get rid of the timer that
> appears to be an attempt at fixing a problem related to this.

Nice, +1 for getting rid of the timer.

> diff --git a/kernel/padata.c b/kernel/padata.c
> index 15a8ad63f4ff..b5dfc21e976f 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -165,23 +165,12 @@ EXPORT_SYMBOL(padata_do_parallel);
>   */
>  static struct padata_priv *padata_get_next(struct parallel_data *pd)
>  {
> -	int cpu, num_cpus;
> -	unsigned int next_nr, next_index;
>  	struct padata_parallel_queue *next_queue;
>  	struct padata_priv *padata;
>  	struct padata_list *reorder;
> +	int cpu = pd->cpu;
>  
> -	num_cpus = cpumask_weight(pd->cpumask.pcpu);
> -
> -	/*
> -	 * Calculate the percpu reorder queue and the sequence
> -	 * number of the next object.
> -	 */
> -	next_nr = pd->processed;
> -	next_index = next_nr % num_cpus;
> -	cpu = padata_index_to_cpu(pd, next_index);
>  	next_queue = per_cpu_ptr(pd->pqueue, cpu);
> -
>  	reorder = &next_queue->reorder;
>  
>  	spin_lock(&reorder->lock);
> @@ -192,7 +181,8 @@ static struct padata_priv *padata_get_next(struct parallel_data *pd)
>  		list_del_init(&padata->list);
>  		atomic_dec(&pd->reorder_objects);
>  
> -		pd->processed++;
> +		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, 0,
> +					    false);

We'll crash when cpumask_next_wrap returns nr_cpumask_bits and later try to get
the corresponding per-cpu queue.

This handles that as well as the case where there's only 1 CPU in the parallel
mask:

diff --git a/kernel/padata.c b/kernel/padata.c
index b5dfc21e976f..ab352839df04 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -181,8 +181,10 @@ static struct padata_priv *padata_get_next(struct parallel_data *pd)
 		list_del_init(&padata->list);
 		atomic_dec(&pd->reorder_objects);
 
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, 0,
-					    false);
+		if (cpumask_weight(pd->cpumask.pcpu) > 1) {
+			pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, cpu,
+						    false);
+		}
 
 		spin_unlock(&reorder->lock);
 		goto out;



Haven't finished looking at the patch, but have to run somewhere for now, will
pick it up later today.
