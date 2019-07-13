Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7967885
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2019 07:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfGMFDk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Jul 2019 01:03:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48170 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfGMFDj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 Jul 2019 01:03:39 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hmAC0-0006BY-Hm; Sat, 13 Jul 2019 13:03:28 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hmABt-0000yf-KY; Sat, 13 Jul 2019 13:03:21 +0800
Date:   Sat, 13 Jul 2019 13:03:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 12, 2019 at 12:07:37PM -0400, Daniel Jordan wrote:
>
> modprobe (CPU2)               kworker/21:1-293 (CPU21)                              kworker/5:2-276 (CPU5)
> --------------------------    ------------------------                              ----------------------
> <submit job, seq_nr=16581>
> ...
>   padata_do_parallel
>     queue_work_on(21, ...)
> <sleeps>
>                               padata_parallel_worker
>                                 pcrypt_aead_dec
>                                   padata_do_serial
>                                     padata_reorder

This can't happen because if the job started on CPU2 then it must
go back to CPU2 for completion.  IOW padata_do_serial should be
punting this to a work queue for CPU2 rather than calling
padata_reorder on CPU21.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
