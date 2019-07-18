Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980FB6CFA0
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbfGROZx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jul 2019 10:25:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfGROZx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 10:25:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IEOGU7129764;
        Thu, 18 Jul 2019 14:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bP97LQ2rSarzasJiMD4pbW+EGY25SG5SddSKUGqYY9U=;
 b=t97KHtQpbJtVeGXv8xB+M2/C10COpA4rPcuaOzOq4GF3VhBkcytDC58BZ9ROntOqsNKI
 cZDcb5uiJHqCI8Rhcq3WdDh1Iph1xAxZO0k1tl8GjLlfIyDB/nbfPQm6wwMRX3sZ+hYv
 u86psqTiAciZPBp2uccYv6nZpB5QEbvBXoOzys5J6ggvZ6GRohIIHds9LRYnjpfww59A
 wiHLSQyE5M7bq0aeMcGSi9RxbG7N0mpxg64fGVkjLR6PLuj4e94f1FSFZHwgUaXj0NWO
 hQ3pyea+PnmIlKvyxpNsnkSHLPe6UQneMnh7dYZSwDOxXCJtz6aMu1J2leWGRd/N9l/I YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tq78q18fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 14:25:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IEMoho116932;
        Thu, 18 Jul 2019 14:25:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tt77hrvnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 14:25:26 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6IEPLeg001422;
        Thu, 18 Jul 2019 14:25:23 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jul 2019 14:25:21 +0000
Date:   Thu, 18 Jul 2019 10:25:15 -0400
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
Message-ID: <20190718142515.teinr4da3gps5r7a@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717232136.pboms73sqf6fdzic@ca-dmjordan1.us.oracle.com>
 <20190718033008.wle67s7esg27mrtz@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718033008.wle67s7esg27mrtz@gondor.apana.org.au>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907180150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907180150
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 11:30:08AM +0800, Herbert Xu wrote:
> On Wed, Jul 17, 2019 at 07:21:36PM -0400, Daniel Jordan wrote:
> >
> > > @@ -388,12 +336,12 @@ void padata_do_serial(struct padata_priv *padata)
> > >  	pqueue = per_cpu_ptr(pd->pqueue, cpu);
> > >  
> > >  	spin_lock(&pqueue->reorder.lock);
> > > -	atomic_inc(&pd->reorder_objects);
> > >  	list_add_tail(&padata->list, &pqueue->reorder.list);
> > > +	atomic_inc(&pd->reorder_objects);
> > 
> > Why switch the lines?  Seems ok to not do this.
> 
> This is crucial because otherwise the memory barrier won't apply
> to the list insertion.  With this patch, we are now using the list
> insertion as the indicator, rather than reorder_objects.

Which memory barrier do you mean?  I think you're referring to the one that
atomic_inc might provide?  If so, the memory model maintainers can correct me
here, but my understanding is that RMW atomic ops that don't return values are
unordered, so switching the lines has no effect.

Besides, the smp_mb__after_atomic is what orders the list insertion with the
trylock of pd->lock.

> > > @@ -538,8 +479,6 @@ static void padata_flush_queues(struct parallel_data *pd)
> > >  		flush_work(&pqueue->work);
> > >  	}
> > >  
> > > -	del_timer_sync(&pd->timer);
> > > -
> > 
> > >  	if (atomic_read(&pd->reorder_objects))
> > >  		padata_reorder(pd);
> > 
> > I think we can do away with reorder_objects entirely by checking pd->cpu's
> > reorder queue here.
> 
> As I said this will probably disappear altogether since we can't
> guarantee that padata_reorder will actually do anything if the
> jobs are stuck in async crypto processing.

Ok, makes sense.
