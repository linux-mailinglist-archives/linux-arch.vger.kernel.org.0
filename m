Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED06A8FC
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGPM51 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 08:57:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58104 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfGPM50 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 08:57:26 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnN11-0005G9-5N; Tue, 16 Jul 2019 20:57:07 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnN0y-0001sk-IB; Tue, 16 Jul 2019 20:57:04 +0800
Date:   Tue, 16 Jul 2019 20:57:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] padata: Use RCU when fetching pd from do_serial
Message-ID: <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716111410.GN17989@gauss3.secunet.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 01:14:10PM +0200, Steffen Klassert wrote:
>
> Maybe we can fix it if we call padata_free_pd() from
> padata_serial_worker() when it sent out the last object.

How about using RCU?

We still need to fix up the refcnt if it's supposed to limit the
overall number of outstanding requests.

---8<---
The function padata_do_serial uses parallel_data without obeying
the RCU rules around its life-cycle.  This means that a concurrent
padata_replace call can result in a crash.

This patch fixes it by using RCU just as we do in padata_do_parallel.

Fixes: 16295bec6398 ("padata: Generic parallelization/...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 5d13d25da2c8..952f6514dd72 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -35,7 +35,7 @@
  * struct padata_priv -  Embedded to the users data structure.
  *
  * @list: List entry, to attach to the padata lists.
- * @pd: Pointer to the internal control structure.
+ * @inst: Pointer to the overall control structure.
  * @cb_cpu: Callback cpu for serializatioon.
  * @cpu: Cpu for parallelization.
  * @seq_nr: Sequence number of the parallelized data object.
@@ -45,7 +45,7 @@
  */
 struct padata_priv {
 	struct list_head	list;
-	struct parallel_data	*pd;
+	struct padata_instance	*inst;
 	int			cb_cpu;
 	int			cpu;
 	int			info;
diff --git a/kernel/padata.c b/kernel/padata.c
index 2d2fddbb7a4c..fb5dd1210d2b 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -128,7 +128,7 @@ int padata_do_parallel(struct padata_instance *pinst,
 
 	err = 0;
 	atomic_inc(&pd->refcnt);
-	padata->pd = pd;
+	padata->inst = pinst;
 	padata->cb_cpu = cb_cpu;
 
 	target_cpu = padata_cpu_hash(pd);
@@ -367,7 +368,7 @@ void padata_do_serial(struct padata_priv *padata)
 	struct parallel_data *pd;
 	int reorder_via_wq = 0;
 
-	pd = padata->pd;
+	pd = rcu_dereference_bh(padata->inst->pd);
 
 	cpu = get_cpu();
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
