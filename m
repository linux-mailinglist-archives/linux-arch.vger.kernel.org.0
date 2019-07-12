Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA6D6730B
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2019 18:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfGLQK0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Jul 2019 12:10:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56766 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfGLQK0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jul 2019 12:10:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CFx4CS015324;
        Fri, 12 Jul 2019 16:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Wb5JusxFe8jjYmZhTUkvAEwxtlKfAgSqfJIMrgMwL4s=;
 b=3/Xd2s3w4xR6nzadGwYoukLdbcgJV8Gl4rxc+fL63xAIBmYqbbqrrvNYp6+2gVtmKAUL
 P1rt2Ya3gd6EPzEIESMMc5KtSZZq5WOHXVeVk04QmpuZBvQyRPiw6KjL7HKZUxgKtYi+
 dm8Yz1F4N8WxkN4rQZkWmhYu3mmX1uEz+Qic6Rd3tFOb1UsINlOdJmVcgtwvCFURvmOW
 envClJYB+BrHTLinM4QDfmlErQdFTq9usicw4Tx6eKEswfvLitNdVakjMiNpxSf5d1Bc
 xZ/5J8KVQG1FojSbQUtxGuuUVUou1Mc2mLUCo7KKWuG2kk43uips6Am7ipAOmGwoObAA dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tjm9r6ha1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 16:09:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CG2YOw116123;
        Fri, 12 Jul 2019 16:07:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tnc8u7st5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 16:07:50 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6CG7lhZ015324;
        Fri, 12 Jul 2019 16:07:47 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 09:07:46 -0700
Date:   Fri, 12 Jul 2019 12:07:37 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712101012.GW14601@gauss3.secunet.de>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9316 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9316 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120169
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 12, 2019 at 12:10:12PM +0200, Steffen Klassert wrote:
> On Fri, Jul 12, 2019 at 06:06:36PM +0800, Herbert Xu wrote:
> > Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> > >
> > > CPU0                                 CPU1
> > >
> > > padata_reorder                       padata_do_serial
> > >  LOAD reorder_objects  // 0
> > >                                       INC reorder_objects  // 1
> > >                                       padata_reorder
> > >                                         TRYLOCK pd->lock   // failed
> > >  UNLOCK pd->lock
> >
> > I think this can't happen because CPU1 won't call padata_reorder
> > at all as it's the wrong CPU so it gets pushed back onto a work
> > queue which will go back to CPU0.

Thanks for looking at this.

When you say the wrong CPU, I think you're referring to the reorder_via_wq
logic in padata_do_serial.  If so, I think my explanation was unclear, because
there were two padata jobs in flight and my tracepoints showed neither of them
punted padata_reorder to a workqueue.  Let me expand on this, hopefully it
helps.

pcrypt used CPU 5 for its callback CPU.  The first job in question, with
sequence number 16581, hashed to CPU 21 on my system.  This is a more complete
version of what led to the hanging modprobe command.

modprobe (CPU2)               kworker/21:1-293 (CPU21)                              kworker/5:2-276 (CPU5)
--------------------------    ------------------------                              ----------------------
<submit job, seq_nr=16581>
...
  padata_do_parallel
    queue_work_on(21, ...)
<sleeps>
                              padata_parallel_worker
                                pcrypt_aead_dec
                                  padata_do_serial
                                    padata_reorder
                                    | padata_get_next  // returns job, seq_nr=16581
                                    | // serialize seq_nr=16581
                                    | queue_work_on(5, ...)
                                    | padata_get_next  // returns -EINPROGRESS
                                    // padata_reorder doesn't return yet!
                                    | |                                             padata_serial_worker
                                    | |                                               pcrypt_aead_serial
                                    | |                                                 <wake up modprobe>
                                    | |                                             <worker finishes>
<submit job, seq_nr=16582>          | |
...                                 | |
  padata_do_parallel                | |
    queue_work_on(22, ...)          | | (LOAD reorder_objects as 0 somewhere
<sleeps>                            | |    in here, before the INC)
                                    | |                                             kworker/22:1-291 (CPU22)
                                    | |                                             ------------------------
                                    | |                                             padata_parallel_worker
                                    | |                                               pcrypt_aead_dec
                                    | |                                                 padata_do_serial
                                    | |                                                   // INC reorder_objects to 1
                                    | |                                                   padata_reorder
                                    | |                                                     // trylock fail, CPU21 _should_
                                    | |                                                     //   serialize 16582 but doesn't
                                    | |                                             <worker finishes>
                                    | // deletes pd->timer
                                    // padata_reorder returns
                              <worker finishes>
<keeps on sleeping lazily>

My tracepoints showed CPU22 increased reorder_objects to 1 but CPU21 read it as
0.

I think adding the full barrier guarantees the following ordering, and the
memory model people can correct me if I'm wrong:

CPU21                      CPU22
------------------------   --------------------------
UNLOCK pd->lock
smp_mb()
LOAD reorder_objects
                           INC reorder_objects
                           spin_unlock(&pqueue->reorder.lock) // release barrier
                           TRYLOCK pd->lock

So if CPU22 has incremented reorder_objects but CPU21 reads 0 for it, CPU21
should also have unlocked pd->lock so CPU22 can get it and serialize any
remaining jobs.
