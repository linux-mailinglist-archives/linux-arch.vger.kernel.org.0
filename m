Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D54BF6E79A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfGSO4C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 10:56:02 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56562 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSO4C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Jul 2019 10:56:02 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hoUIa-0002zi-L4; Fri, 19 Jul 2019 22:55:52 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hoUIU-00089C-5q; Fri, 19 Jul 2019 22:55:46 +0800
Date:   Fri, 19 Jul 2019 22:55:46 +0800
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
Subject: Re: [v2 PATCH] padata: Replace delayed timer with immediate
 workqueue in padata_reorder
Message-ID: <20190719145546.hkpe77mevab3gzwq@gondor.apana.org.au>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
 <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
 <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
 <20190718150146.bztw3uugd5sqhdvk@gondor.apana.org.au>
 <20190719143721.awtvjf2pk37f5zsv@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719143721.awtvjf2pk37f5zsv@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 19, 2019 at 10:37:21AM -0400, Daniel Jordan wrote:
>
> If I'm not missing anything, still looks like get_cpu() and reorder_via_wq no
> longer have an effect with this patch and can be removed.

You're right that they're not needed.  But we shouldn't mix clean-ups
with substantial changes (in case we break something this would make
bisection less efficient).  So feel free to send a patch on top of
this one to remove them.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
