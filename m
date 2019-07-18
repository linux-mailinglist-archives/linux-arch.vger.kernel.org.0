Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91C56C7E8
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 05:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbfGRDa2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 23:30:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38000 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390101AbfGRDa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 23:30:28 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnx7Y-0005UF-6D; Thu, 18 Jul 2019 11:30:16 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnx7Q-00051w-C7; Thu, 18 Jul 2019 11:30:08 +0800
Date:   Thu, 18 Jul 2019 11:30:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Message-ID: <20190718033008.wle67s7esg27mrtz@gondor.apana.org.au>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717232136.pboms73sqf6fdzic@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717232136.pboms73sqf6fdzic@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 17, 2019 at 07:21:36PM -0400, Daniel Jordan wrote:
>
> > @@ -388,12 +336,12 @@ void padata_do_serial(struct padata_priv *padata)
> >  	pqueue = per_cpu_ptr(pd->pqueue, cpu);
> >  
> >  	spin_lock(&pqueue->reorder.lock);
> > -	atomic_inc(&pd->reorder_objects);
> >  	list_add_tail(&padata->list, &pqueue->reorder.list);
> > +	atomic_inc(&pd->reorder_objects);
> 
> Why switch the lines?  Seems ok to not do this.

This is crucial because otherwise the memory barrier won't apply
to the list insertion.  With this patch, we are now using the list
insertion as the indicator, rather than reorder_objects.

> > @@ -538,8 +479,6 @@ static void padata_flush_queues(struct parallel_data *pd)
> >  		flush_work(&pqueue->work);
> >  	}
> >  
> > -	del_timer_sync(&pd->timer);
> > -
> 
> >  	if (atomic_read(&pd->reorder_objects))
> >  		padata_reorder(pd);
> 
> I think we can do away with reorder_objects entirely by checking pd->cpu's
> reorder queue here.

As I said this will probably disappear altogether since we can't
guarantee that padata_reorder will actually do anything if the
jobs are stuck in async crypto processing.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
