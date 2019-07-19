Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E286E779
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfGSOhq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 10:37:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46590 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfGSOhp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 10:37:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JEJPOp174728;
        Fri, 19 Jul 2019 14:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Ea7YAj6aCsOltfu+jfPBwzRyC/igLXsJVch2fiMu4OQ=;
 b=Nc3vuAQCpmSezUOfAD5aodlXEX8+XXr1jDfVvso0ldX2DXHlakZ/J1xpqhw27m9yoma3
 i5rFPxHTnRo/WZ4SnHwJQXtR7g67e5E1jIfYdjtvYZsddu2JUphFxIxUdwrcqmQZu+bj
 zTTrHrAj6q5mJKSIB/kWiHSdWVWQAFVX5rd1QUr13vO+kK1Zqqd+1nF9m8TcBIjtkrVN
 2N1ce658/fORcx4y6/BRjTib5eUK8FyRjlpbjcPnXbC57cUJrbTBFZHoZqF9aCxmB+rL
 ryT+KGXIKOEnzdaOIT4SG650/5atByMcw4AfGHNYNWbAHYXKaKLotEnaGnq4Qf0uRMPr +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xrf0gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:37:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JEHcM8066621;
        Fri, 19 Jul 2019 14:37:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tsmcdmnqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:37:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6JEbQV4005554;
        Fri, 19 Jul 2019 14:37:27 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jul 2019 14:37:26 +0000
Date:   Fri, 19 Jul 2019 10:37:21 -0400
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
Subject: Re: [v2 PATCH] padata: Replace delayed timer with immediate
 workqueue in padata_reorder
Message-ID: <20190719143721.awtvjf2pk37f5zsv@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
 <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
 <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
 <20190718150146.bztw3uugd5sqhdvk@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718150146.bztw3uugd5sqhdvk@gondor.apana.org.au>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=702
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907190160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=744 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907190160
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 11:01:46PM +0800, Herbert Xu wrote:
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
> @@ -388,12 +336,12 @@ void padata_do_serial(struct padata_priv *padata)
>  	pqueue = per_cpu_ptr(pd->pqueue, cpu);
>  
>  	spin_lock(&pqueue->reorder.lock);
> -	atomic_inc(&pd->reorder_objects);
>  	list_add_tail(&padata->list, &pqueue->reorder.list);
> +	atomic_inc(&pd->reorder_objects);
>  	spin_unlock(&pqueue->reorder.lock);
>  
>  	/*
> -	 * Ensure the atomic_inc of reorder_objects above is ordered correctly
> +	 * Ensure the addition to the reorder list is ordered correctly
>  	 * with the trylock of pd->lock in padata_reorder.  Pairs with smp_mb
>  	 * in padata_reorder.
>  	 */
> @@ -401,13 +349,7 @@ void padata_do_serial(struct padata_priv *padata)
>  
>  	put_cpu();
>  
> -	/* If we're running on the wrong CPU, call padata_reorder() via a
> -	 * kernel worker.
> -	 */
> -	if (reorder_via_wq)
> -		queue_work_on(cpu, pd->pinst->wq, &pqueue->reorder_work);
> -	else
> -		padata_reorder(pd);
> +	padata_reorder(pd);
>  }
>  EXPORT_SYMBOL(padata_do_serial);

If I'm not missing anything, still looks like get_cpu() and reorder_via_wq no
longer have an effect with this patch and can be removed.
