Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95EEF6D08B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfGRO4s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jul 2019 10:56:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52432 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfGRO4s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Jul 2019 10:56:48 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ho7pl-0000NL-DQ; Thu, 18 Jul 2019 22:56:37 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ho7pi-0006Id-9i; Thu, 18 Jul 2019 22:56:34 +0800
Date:   Thu, 18 Jul 2019 22:56:34 +0800
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
Message-ID: <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
 <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 10:27:30AM -0400, Daniel Jordan wrote:
>
> That's what I expected when I first saw it too, but nr_cpumask_bits is returned
> to signal the end of the iteration.  The patch always passes 0 for the 'start'
> argument, so when cpumask_next_wrap is called with the last cpu in the mask,
> the end-of-iteration case is triggered.  To reassure you and myself :) I ran it
> and got the expected crash.
> 
> Passing pd->cpu for the start argument instead avoids that problem, but the
> one-cpu-in-mask case still needs handling because cpumask_next_wrap always
> signals end of iteration for that, hence the cpumask_weight check.

My bad.  I should have set start to -1 to make it do the right thing.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
