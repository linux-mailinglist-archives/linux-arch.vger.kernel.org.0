Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9513A6A96C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbfGPNST (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 09:18:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59358 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfGPNST (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 09:18:19 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnNLN-0005bY-LT; Tue, 16 Jul 2019 21:18:09 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnNLL-0004oo-Eq; Tue, 16 Jul 2019 21:18:07 +0800
Date:   Tue, 16 Jul 2019 21:18:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: Use RCU when fetching pd from do_serial
Message-ID: <20190716131807.twahbbdff6jhpnu2@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
 <20190716131520.GB3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716131520.GB3402@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 03:15:20PM +0200, Peter Zijlstra wrote:
>
> > @@ -367,7 +368,7 @@ void padata_do_serial(struct padata_priv *padata)
> >  	struct parallel_data *pd;
> >  	int reorder_via_wq = 0;
> >  
> > -	pd = padata->pd;
> > +	pd = rcu_dereference_bh(padata->inst->pd);
> >  
> >  	cpu = get_cpu();
> >  
> 
> That's weird for not having a matching assign and lacking comments to
> explain that.

There is a matching rcu_assign_pointer.  But we should add some
RCU markers.

Or perhaps you're misreading the level of indirections :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
