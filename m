Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3DC86AB3F
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbfGPPCA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 11:02:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34330 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387924AbfGPPB7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 11:01:59 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnOxg-0007MZ-Ra; Tue, 16 Jul 2019 23:01:48 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnOxa-00018j-64; Tue, 16 Jul 2019 23:01:42 +0800
Date:   Tue, 16 Jul 2019 23:01:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190716150142.rebjmpjjiesaiwyt@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190716125309.GA10672@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716125309.GA10672@andrea>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 02:53:09PM +0200, Andrea Parri wrote:
>
> P1(atomic_t *reorder_objects, spinlock_t *pd_lock, spinlock_t *reorder_lock)
> {
> 	int r1;
> 
> 	spin_lock(reorder_lock);
> 	atomic_inc(reorder_objects);
> 	spin_unlock(reorder_lock);
> 	//smp_mb();
> 	r1 = spin_trylock(pd_lock);
> }

Yes we need a matching mb on the other side.  However, we can
get away with using smp_mb__after_atomic thanks to the atomic_inc
above.

Daniel, can you please respin the patch with the matching smp_mb?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
