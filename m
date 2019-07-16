Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427C36A95D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfGPNPj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 09:15:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfGPNPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 09:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ES3PIEwIKlpc8yeZqCcy+3GMlubNnq9R+cjjP/ZkFA=; b=KDexd3gOaL6nWm+EGPUyUsNB7
        SSEWeRGUFI/5JEm/W2MdiDIP9MCZadRbIj+cIsd63qeOzHJRLPPxbGkEf3Wxq8+pwpk3YpqYx5nQZ
        qLQDrItjT0rZ8vCOC+zCKizhOqkoJG2vetAVwwWriTWA0HuzeR9zGfoWLaEGoOq/0p+H6vmv1pwns
        85v4LcdS1sveFj4jHUSHu0YsJQDmHtcVvsLisi5/RL4Rvd9aXIOp0QlIuNvotEHM1NR+oyoG5hHiP
        IUMkyjLTGPHF1pzQ02WXLQBG1xan4S4ymQwSxFPA2zh/XKZoqD+uinl9/JI2lLobwehpUOPZo0bam
        v+BQdeViw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnNIg-0003H0-6F; Tue, 16 Jul 2019 13:15:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E93620B172D1; Tue, 16 Jul 2019 15:15:20 +0200 (CEST)
Date:   Tue, 16 Jul 2019 15:15:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: Use RCU when fetching pd from do_serial
Message-ID: <20190716131520.GB3402@hirez.programming.kicks-ass.net>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 08:57:04PM +0800, Herbert Xu wrote:
> On Tue, Jul 16, 2019 at 01:14:10PM +0200, Steffen Klassert wrote:
> >
> > Maybe we can fix it if we call padata_free_pd() from
> > padata_serial_worker() when it sent out the last object.
> 
> How about using RCU?
> 
> We still need to fix up the refcnt if it's supposed to limit the
> overall number of outstanding requests.
> 
> ---8<---
> The function padata_do_serial uses parallel_data without obeying
> the RCU rules around its life-cycle.  This means that a concurrent
> padata_replace call can result in a crash.
> 
> This patch fixes it by using RCU just as we do in padata_do_parallel.
> 
> Fixes: 16295bec6398 ("padata: Generic parallelization/...")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

> diff --git a/kernel/padata.c b/kernel/padata.c
> index 2d2fddbb7a4c..fb5dd1210d2b 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -128,7 +128,7 @@ int padata_do_parallel(struct padata_instance *pinst,
>  
>  	err = 0;
>  	atomic_inc(&pd->refcnt);
> -	padata->pd = pd;
> +	padata->inst = pinst;
>  	padata->cb_cpu = cb_cpu;
>  
>  	target_cpu = padata_cpu_hash(pd);
> @@ -367,7 +368,7 @@ void padata_do_serial(struct padata_priv *padata)
>  	struct parallel_data *pd;
>  	int reorder_via_wq = 0;
>  
> -	pd = padata->pd;
> +	pd = rcu_dereference_bh(padata->inst->pd);
>  
>  	cpu = get_cpu();
>  

That's weird for not having a matching assign and lacking comments to
explain that.
