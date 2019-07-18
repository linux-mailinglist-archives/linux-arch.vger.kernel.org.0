Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0F6CFA5
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfGRO1z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jul 2019 10:27:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRO1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 10:27:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IEO9kS038738;
        Thu, 18 Jul 2019 14:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vhx0d9t56CEmR2/7oRomW1whOTJLUCdhb/u4q8az6RQ=;
 b=aDk3QWJcQe87LWj/Um5HM6XFKoz88VXLgQC3djynvqh3hgjgiEgG0ave5LgbIgPTcy1E
 qFTrmZ8+CW/TGRmXBPdlwIMsRCDIT7kjh2mnVkjrJQk+qgiB9Y4Te1v2afp6gODIHy38
 BmRuxS6mLeo4/gwOg8GxPmSpYcIMziPavDFR+N5awVWdf4mkgVZuiUpgTv9bCq21iyJX
 RJwDepv54+skBUTzB1E/df8PNKkE26Sp3Hr6OIqN1UYCZ2tRoKWrAR0BTVPJsh/NXhbO
 gamfxoH+wOYnZDgHwOM8EM+Hpz42/hN/u5BVdB/a0Na2+9bdk3cXyKJLLqI0UsHEdWj+ vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tq6qu1crb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 14:27:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IEMoDJ041553;
        Thu, 18 Jul 2019 14:27:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ttc8fm7sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 14:27:37 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6IERZSo021719;
        Thu, 18 Jul 2019 14:27:35 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jul 2019 14:27:35 +0000
Date:   Thu, 18 Jul 2019 10:27:30 -0400
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
Message-ID: <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=454
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907180150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=506 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907180150
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 11:31:31AM +0800, Herbert Xu wrote:
> On Wed, Jul 17, 2019 at 02:32:27PM -0400, Daniel Jordan wrote:
> >
> > We'll crash when cpumask_next_wrap returns nr_cpumask_bits and later try to get
> > the corresponding per-cpu queue.
> 
> The whole point of cpumask_next_wrap is to wrap around to the
> beginning when it hits nr_cpumask_bits.  So it cannot return
> nr_cpumask_bits.

That's what I expected when I first saw it too, but nr_cpumask_bits is returned
to signal the end of the iteration.  The patch always passes 0 for the 'start'
argument, so when cpumask_next_wrap is called with the last cpu in the mask,
the end-of-iteration case is triggered.  To reassure you and myself :) I ran it
and got the expected crash.

Passing pd->cpu for the start argument instead avoids that problem, but the
one-cpu-in-mask case still needs handling because cpumask_next_wrap always
signals end of iteration for that, hence the cpumask_weight check.
