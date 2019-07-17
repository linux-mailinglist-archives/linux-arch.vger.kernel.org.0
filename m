Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8032E6C381
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 01:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfGQXWK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 19:22:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37382 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfGQXWK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 19:22:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HN8v7l017634;
        Wed, 17 Jul 2019 23:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hCHrTU7VoG4zjLFZxdulw58hq+gR27EbiMFMvD5jW0w=;
 b=EVotIEnZX5AMgotP0WiDlItf1sIKJK8zMiD9MwfJN4w21tzxOjUf174tLSG4Q8pEiv1m
 k8SY1pznBQmb+GYIWKaHihXYf0VtMdccxlMnT1CqCH6zIlKLggTlfL5iWD5O0855LzuG
 dhneqzxTiRGNGslIltrtaMGZ3z6gFRLH5XL1/ryGH+GjMpSEtBHdtphAIpNzRZm62XLP
 yu0yXZqVwYwnyYpyFS3yktrAjkncOnTgS+qdxR1EQ1MbugCZwAI16NWuyj7UDK5erZuq
 bZJ5qgu6tBRkwjv/dwNj+opvhg9NWvuoF/cI5mAW0IPpeXug3XvumbgwJ5/Vc+qmg0GZ sQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78pwq76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 23:21:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HN7wZT082185;
        Wed, 17 Jul 2019 23:21:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tsmccperb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 23:21:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6HNLf4A006652;
        Wed, 17 Jul 2019 23:21:41 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 23:21:41 +0000
Date:   Wed, 17 Jul 2019 19:21:36 -0400
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
Message-ID: <20190717232136.pboms73sqf6fdzic@ca-dmjordan1.us.oracle.com>
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=940
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170259
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=992 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170259
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 17, 2019 at 07:11:47PM +0800, Herbert Xu wrote:
> Note that we don't bother removing the work queue in
> padata_flush_queues because the whole premise is broken.  You
> cannot flush async crypto requests so it makes no sense to even
> try.  A subsequent patch will fix it by replacing it with a ref
> counting scheme.

Interested to see what happens with the ref counting.

You mean you don't bother removing the serial workqueue flushing, right, not
the parallel?

> @@ -122,10 +117,10 @@ struct padata_cpumask {
>   * @reorder_objects: Number of objects waiting in the reorder queues.
>   * @refcnt: Number of objects holding a reference on this parallel_data.
>   * @max_seq_nr:  Maximal used sequence number.
> + * @cpu: Next CPU to be processed.

Maybe something more specific...

      @cpu: CPU of the next reorder queue to process.

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

After this patch padata_index_to_cpu has only one caller, so it doesn't need to
be a function anymore.

> @@ -246,7 +237,6 @@ static void padata_reorder(struct parallel_data *pd)
>  		 * so exit immediately.
>  		 */
>  		if (PTR_ERR(padata) == -ENODATA) {
> -			del_timer(&pd->timer);
>  			spin_unlock_bh(&pd->lock);
>  			return;
>  		}
> @@ -265,70 +255,29 @@ static void padata_reorder(struct parallel_data *pd)
>  
>  	/*
>  	 * The next object that needs serialization might have arrived to
> -	 * the reorder queues in the meantime, we will be called again
> -	 * from the timer function if no one else cares for it.
> +	 * the reorder queues in the meantime.
>  	 *
> -	 * Ensure reorder_objects is read after pd->lock is dropped so we see
> -	 * an increment from another task in padata_do_serial.  Pairs with
> +	 * Ensure reorder queue is read after pd->lock is dropped so we see
> +	 * new objects from another task in padata_do_serial.  Pairs with
>  	 * smp_mb__after_atomic in padata_do_serial.
>  	 */
>  	smp_mb();
> -	if (atomic_read(&pd->reorder_objects)
> -			&& !(pinst->flags & PADATA_RESET))
> -		mod_timer(&pd->timer, jiffies + HZ);
> -	else
> -		del_timer(&pd->timer);
>  
> -	return;
> +	next_queue = per_cpu_ptr(pd->pqueue, pd->cpu);
> +	if (!list_empty(&next_queue->reorder.list))
> +		queue_work(pinst->wq, &pd->reorder_work);

It's possible that the work gets queued when it doesn't need to be when another
task adds a job to the reorder queue but hasn't grabbed pd->lock yet, but I
can't think of a way around it...and it does no harm anyway.

> @@ -376,9 +325,8 @@ void padata_do_serial(struct padata_priv *padata)
>  
>  	cpu = get_cpu();
>  
> -	/* We need to run on the same CPU padata_do_parallel(.., padata, ..)
> -	 * was called on -- or, at least, enqueue the padata object into the
> -	 * correct per-cpu queue.
> +	/* We need to enqueue the padata object into the correct
> +	 * per-cpu queue.
>  	 */
>  	if (cpu != padata->cpu) {
>  		reorder_via_wq = 1;

reorder_via_wq and I think get_cpu/put_cpu can go away now that we're always
using padata->cpu to get the parallel queue and then running padata_reorder in
the current task.

Maybe Steffen can check my reasoning on the get_cpu thing.  It looks like that
was added in the original padata commit to keep 'cpu' stable for getting the
parallel queue but is no longer needed because we just use padata->cpu.

> @@ -388,12 +336,12 @@ void padata_do_serial(struct padata_priv *padata)
>  	pqueue = per_cpu_ptr(pd->pqueue, cpu);
>  
>  	spin_lock(&pqueue->reorder.lock);
> -	atomic_inc(&pd->reorder_objects);
>  	list_add_tail(&padata->list, &pqueue->reorder.list);
> +	atomic_inc(&pd->reorder_objects);

Why switch the lines?  Seems ok to not do this.

> @@ -538,8 +479,6 @@ static void padata_flush_queues(struct parallel_data *pd)
>  		flush_work(&pqueue->work);
>  	}
>  
> -	del_timer_sync(&pd->timer);
> -

>  	if (atomic_read(&pd->reorder_objects))
>  		padata_reorder(pd);

I think we can do away with reorder_objects entirely by checking pd->cpu's
reorder queue here.

It's racy to read pd->cpu without pd->lock, but it doesn't matter.  If there
are objects left to process and no other task is in padata_reorder, this path
will notice that, and if there's another task in padata_reorder changing
pd->cpu from under us, that task will finish the reordering so this path
doesn't have to.
