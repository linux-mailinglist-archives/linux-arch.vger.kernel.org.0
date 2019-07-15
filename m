Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CE3698E3
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2019 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfGOQLX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jul 2019 12:11:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQLX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 12:11:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FG9K7g046431;
        Mon, 15 Jul 2019 16:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FHNs/VLuaqZ6nZAgJqcIiUHrYF7VNMT5n+FgGHZ8rBc=;
 b=R4wRB/lVnB1ltWkn/GMHIPbIECr3MzMvRuYL91sqD33inkHwuq+Szs0wGXTlwCC6z0j5
 7apQxbjsKIBBBrhCePlKJcEWM6pS48zSoAnF49EBkuf40UAZotacRDXx1lEkqzkf0r/6
 u0BSecvo6MhRdZJMcNj3r53xdgxQtSgx2MSBYw1g+k7PMClmOrkqXs4lVVDa1+93zOyB
 G5uIKr+d2OHcUtdqjTIyJV11TQRRN7EqlCDesVWZbrPM5LGjz10FHUqyyCPOglHuK22s
 BJQOEIw5w1zxHzmvXj5tEJPINnAHUZEV/0iiPAXUINZTEuwvRp3HKhgLi7EHqcfHFtbi aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qtfjbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 16:11:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FG7xVU011256;
        Mon, 15 Jul 2019 16:10:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tq6mmc445-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 16:10:59 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6FGApLd006898;
        Mon, 15 Jul 2019 16:10:56 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 09:10:51 -0700
Date:   Mon, 15 Jul 2019 12:10:46 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=876
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=921 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150188
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 13, 2019 at 01:03:21PM +0800, Herbert Xu wrote:
> On Fri, Jul 12, 2019 at 12:07:37PM -0400, Daniel Jordan wrote:
> >
> > modprobe (CPU2)               kworker/21:1-293 (CPU21)                              kworker/5:2-276 (CPU5)
> > --------------------------    ------------------------                              ----------------------
> > <submit job, seq_nr=16581>
> > ...
> >   padata_do_parallel
> >     queue_work_on(21, ...)
> > <sleeps>
> >                               padata_parallel_worker
> >                                 pcrypt_aead_dec
> >                                   padata_do_serial
> >                                     padata_reorder
> 
> This can't happen because if the job started on CPU2 then it must
> go back to CPU2 for completion.  IOW padata_do_serial should be
> punting this to a work queue for CPU2 rather than calling
> padata_reorder on CPU21.

I've been wrong before plenty of times, and there's nothing preventing this
from being one of those times :) , but in this case I believe what I'm showing
is correct.

The padata_do_serial call for a given job ensures padata_reorder runs on the
CPU that the job hashed to in padata_do_parallel, which is not necessarily the
same CPU as the one that padata_do_parallel itself ran on.

In this case, the padata job in question started via padata_do_parallel, where
it hashed to CPU 21:

  padata_do_parallel                    // ran on CPU 2
    ...
    target_cpu = padata_cpu_hash(pd);   // target_cpu == 21
    padata->cpu = target_cpu;
    ...
    queue_work_on(21, ...)

The corresponding kworker then started:

  padata_parallel_worker                // bound to CPU 21
    pcrypt_aead_dec
      padata_do_serial
        padata_reorder

Daniel
