Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050AA66AB0
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2019 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGLKGy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Jul 2019 06:06:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:43770 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfGLKGx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Jul 2019 06:06:53 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hlsRw-0005RC-6Z; Fri, 12 Jul 2019 18:06:44 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hlsRo-0007zt-RH; Fri, 12 Jul 2019 18:06:36 +0800
Date:   Fri, 12 Jul 2019 18:06:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> CPU0                                 CPU1
> 
> padata_reorder                       padata_do_serial
>  LOAD reorder_objects  // 0
>                                       INC reorder_objects  // 1
>                                       padata_reorder
>                                         TRYLOCK pd->lock   // failed
>  UNLOCK pd->lock

I think this can't happen because CPU1 won't call padata_reorder
at all as it's the wrong CPU so it gets pushed back onto a work
queue which will go back to CPU0.

Steffen, could you please take a look at this as there clearly
is a problem here?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
