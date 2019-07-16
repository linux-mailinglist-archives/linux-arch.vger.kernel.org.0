Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83EA6A61A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 12:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfGPKFG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 06:05:06 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49860 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfGPKFG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 06:05:06 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnKKN-0002OT-MR; Tue, 16 Jul 2019 18:04:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnKKF-0003tz-SN; Tue, 16 Jul 2019 18:04:47 +0800
Date:   Tue, 16 Jul 2019 18:04:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 12:10:46PM -0400, Daniel Jordan wrote:
>
> I've been wrong before plenty of times, and there's nothing preventing this
> from being one of those times :) , but in this case I believe what I'm showing
> is correct.
> 
> The padata_do_serial call for a given job ensures padata_reorder runs on the
> CPU that the job hashed to in padata_do_parallel, which is not necessarily the
> same CPU as the one that padata_do_parallel itself ran on.

You're right.  I was taking the comment in the code at face value,
never trust comments :)

While looking at the code in question, I think it is seriously
broken.  For instance, padata_replace does not deal with async
crypto at all.  It would fail miserably if the underlying async
crypto held onto references to the old pd.

So we may have to restrict pcrypt to sync crypto only, which
would obviously mean that it can no longer use aesni.  Or we
will have to spend a lot of time to fix this up properly.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
