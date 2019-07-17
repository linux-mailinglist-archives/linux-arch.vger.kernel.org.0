Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB406B8A6
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfGQIxi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 04:53:38 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:35122 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfGQIxh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 04:53:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 7F5C0201AE;
        Wed, 17 Jul 2019 10:53:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XTJfI7HmDPTO; Wed, 17 Jul 2019 10:53:35 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id D995320189;
        Wed, 17 Jul 2019 10:53:35 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 17 Jul 2019
 10:53:36 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 8B819318055E;
 Wed, 17 Jul 2019 10:53:35 +0200 (CEST)
Date:   Wed, 17 Jul 2019 10:53:35 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        <andrea.parri@amarulasolutions.com>, <boqun.feng@gmail.com>,
        <paulmck@linux.ibm.com>, <peterz@infradead.org>,
        <linux-arch@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] padata: Use RCU when fetching pd from do_serial
Message-ID: <20190717085335.GR17989@gauss3.secunet.de>
References: <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
 <20190716130928.ga4acvxipsdzyzlp@gondor.apana.org.au>
 <20190717082815.GP17989@gauss3.secunet.de>
 <20190717084739.35evhqushmjejmmq@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190717084739.35evhqushmjejmmq@gondor.apana.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 17, 2019 at 04:47:40PM +0800, Herbert Xu wrote:
> On Wed, Jul 17, 2019 at 10:28:15AM +0200, Steffen Klassert wrote:
> >
> > I had a patch to support crypto backlog some years ago,
> > but testing with dm-crypt did not show any performance
> > improvement. So I decided to just skip that patch because
> > it added code for no need.
> 
> Well pcrypt is part of the API so it needs to obey the rules.
> So even if it wouldn't make sense to use dm-crypt with pcrypt
> it still needs to do the right thing.

Ok, makes sense. The old patch still exists:

https://git.kernel.org/pub/scm/linux/kernel/git/klassert/linux-stk.git/commit/?h=net-next-pcrypt&id=5909a88ccef6f4c78fe9969160155a8f0ce8fee7

Let me see if I can respin it...
