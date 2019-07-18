Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6E76C8D6
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 07:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfGRFmR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jul 2019 01:42:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57828 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfGRFmR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Jul 2019 01:42:17 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnzB8-0007Ci-E1; Thu, 18 Jul 2019 13:42:06 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnzB3-0005f1-MN; Thu, 18 Jul 2019 13:42:01 +0800
Date:   Thu, 18 Jul 2019 13:42:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] padata: use smp_mb in padata_reorder to avoid
 orphaned padata jobs
Message-ID: <20190718054201.jtfcwkygunyvgwe4@gondor.apana.org.au>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716163253.24377-1-daniel.m.jordan@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 12:32:53PM -0400, Daniel Jordan wrote:
> Testing padata with the tcrypt module on a 5.2 kernel...
> 
>     # modprobe tcrypt alg="pcrypt(rfc4106(gcm(aes)))" type=3
>     # modprobe tcrypt mode=211 sec=1
> 
> ...produces this splat:
> 
>     INFO: task modprobe:10075 blocked for more than 120 seconds.
>           Not tainted 5.2.0-base+ #16
>     modprobe        D    0 10075  10064 0x80004080
>     Call Trace:
>      ? __schedule+0x4dd/0x610
>      ? ring_buffer_unlock_commit+0x23/0x100
>      schedule+0x6c/0x90
>      schedule_timeout+0x3b/0x320
>      ? trace_buffer_unlock_commit_regs+0x4f/0x1f0
>      wait_for_common+0x160/0x1a0
>      ? wake_up_q+0x80/0x80
>      { crypto_wait_req }             # entries in braces added by hand
>      { do_one_aead_op }
>      { test_aead_jiffies }
>      test_aead_speed.constprop.17+0x681/0xf30 [tcrypt]
>      do_test+0x4053/0x6a2b [tcrypt]
>      ? 0xffffffffa00f4000
>      tcrypt_mod_init+0x50/0x1000 [tcrypt]
>      ...
> 
> The second modprobe command never finishes because in padata_reorder,
> CPU0's load of reorder_objects is executed before the unlocking store in
> spin_unlock_bh(pd->lock), causing CPU0 to miss CPU1's increment:
> 
> CPU0                                 CPU1
> 
> padata_reorder                       padata_do_serial
>   LOAD reorder_objects  // 0
>                                        INC reorder_objects  // 1
>                                        padata_reorder
>                                          TRYLOCK pd->lock   // failed
>   UNLOCK pd->lock
> 
> CPU0 deletes the timer before returning from padata_reorder and since no
> other job is submitted to padata, modprobe waits indefinitely.
> 
> Add a pair of full barriers to guarantee proper ordering:
> 
> CPU0                                 CPU1
> 
> padata_reorder                       padata_do_serial
>   UNLOCK pd->lock
>   smp_mb()
>   LOAD reorder_objects
>                                        INC reorder_objects
>                                        smp_mb__after_atomic()
>                                        padata_reorder
>                                          TRYLOCK pd->lock
> 
> smp_mb__after_atomic is needed so the read part of the trylock operation
> comes after the INC, as Andrea points out.   Thanks also to Andrea for
> help with writing a litmus test.
> 
> Fixes: 16295bec6398 ("padata: Generic parallelization/serialization interface")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/padata.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
