Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C25B6E73D
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfGSOVu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 10:21:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbfGSOVu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 10:21:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JEJOt6064327;
        Fri, 19 Jul 2019 14:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JoKUOQKxcg3kwqP1OpLXnoOqq0N//AEKX/KNLj2ooPI=;
 b=UnG+i2Qz8isDHZL9wS6kKik10qEXR1tR903rtD9h18XIXGS7M3NkY+XpJGnJGSDy4GAg
 ezUuKV91EHBPlm41089NDyCxRwIU41VtA3tJAywXojy4I1eXgEpwjbFMij0VXycGCEtx
 Eryn3HwG4JI8WDJITPXBmDtpi3T98ZIdAFwRrcycC3dnjTQ6B6r3zxFIEarABOA7DgXA
 8XeBFXbE+jU/5tdMJnHhrKZ12ja9LtmuykEmdwHuaxoHkwfseYE12a05WkZcpY0eAjzq
 GmzmK8xlFD4H+PZ1vd/TEdb7qFL5ekXhM7JbbS+KrbQ3o79HU4qCVJV9X+1zSYIPGmmE hQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78q70bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:21:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JEHcO7066582;
        Fri, 19 Jul 2019 14:21:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tsmcdme6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:21:23 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6JELIri020806;
        Fri, 19 Jul 2019 14:21:20 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jul 2019 14:21:17 +0000
Date:   Fri, 19 Jul 2019 10:21:13 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Message-ID: <20190719142113.ixalfoikevwnhvaq@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717232136.pboms73sqf6fdzic@ca-dmjordan1.us.oracle.com>
 <20190718033008.wle67s7esg27mrtz@gondor.apana.org.au>
 <20190718142515.teinr4da3gps5r7a@ca-dmjordan1.us.oracle.com>
 <20190718144950.yc6sambgdsz7vrvq@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718144950.yc6sambgdsz7vrvq@gondor.apana.org.au>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=526
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907190160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=578 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907190160
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 10:49:50PM +0800, Herbert Xu wrote:
> On Thu, Jul 18, 2019 at 10:25:15AM -0400, Daniel Jordan wrote:
> >
> > Which memory barrier do you mean?  I think you're referring to the one that
> > atomic_inc might provide?  If so, the memory model maintainers can correct me
> > here, but my understanding is that RMW atomic ops that don't return values are
> > unordered, so switching the lines has no effect.
> > 
> > Besides, the smp_mb__after_atomic is what orders the list insertion with the
> > trylock of pd->lock.
> 
> The primitive smp_mb__after_atomic only provides a barrier when
> used in conjunction with atomic_inc (and similar atomic ops).
> 
> The actual barrier may either be in smp_mb__after_atomic or the
> atomic op itself (which is the case on x86).  Since we need the
> barrier to occur after the list insertion we must move both of
> these after the list_add_tail.

Yes, my mistake!  Thanks for clarifying that.
