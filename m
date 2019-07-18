Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A157E6D053
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfGROuF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jul 2019 10:50:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52118 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfGROuF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Jul 2019 10:50:05 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ho7jI-0000EU-Ch; Thu, 18 Jul 2019 22:49:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ho7jC-0006I8-IG; Thu, 18 Jul 2019 22:49:50 +0800
Date:   Thu, 18 Jul 2019 22:49:50 +0800
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
Message-ID: <20190718144950.yc6sambgdsz7vrvq@gondor.apana.org.au>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717232136.pboms73sqf6fdzic@ca-dmjordan1.us.oracle.com>
 <20190718033008.wle67s7esg27mrtz@gondor.apana.org.au>
 <20190718142515.teinr4da3gps5r7a@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718142515.teinr4da3gps5r7a@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 10:25:15AM -0400, Daniel Jordan wrote:
>
> Which memory barrier do you mean?  I think you're referring to the one that
> atomic_inc might provide?  If so, the memory model maintainers can correct me
> here, but my understanding is that RMW atomic ops that don't return values are
> unordered, so switching the lines has no effect.
> 
> Besides, the smp_mb__after_atomic is what orders the list insertion with the
> trylock of pd->lock.

The primitive smp_mb__after_atomic only provides a barrier when
used in conjunction with atomic_inc (and similar atomic ops).

The actual barrier may either be in smp_mb__after_atomic or the
atomic op itself (which is the case on x86).  Since we need the
barrier to occur after the list insertion we must move both of
these after the list_add_tail.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
