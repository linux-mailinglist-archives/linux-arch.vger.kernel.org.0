Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59C6E749
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfGSO2A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 10:28:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39944 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfGSO2A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 10:28:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JEJVOY170553;
        Fri, 19 Jul 2019 14:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=WPq+2EVaGsECQLAP69ghpdVbMZZEMFfA5hf01l4L/3Q=;
 b=MS0Q2am2bOEhSyldCDGr5IudVGNRM69cQuo3SdJgQwglQ7uwwPl/J1r/e0jay2lGTMdp
 aD0/ZSN72CRZibAKkluIjjtIQ17E1IFCpaWj5tBV5EmQDr+Jdbd+RPZXkrJ5WTSc01oa
 dxAvGqT2dqiM6rM2zI7BbGiW8B34jX5y7uNdrJ8lA+oDLei8DsvlbO293Wp6kDBkKJxA
 I+fR/EvAXTB7vJ8CpnxWVYTJAzg+4X9kjWbfznqIPhRX83mlmQojQ9BZ7BSqwN9rgWTv
 dR2ZJhFcLjiMuYsgUh0nEpolFqZc0bW/AwWS/pWDcKNMlQ1LG2T/2ZQMqepxWEPCt0B6 MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qu75mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:27:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6JEHbHg066514;
        Fri, 19 Jul 2019 14:27:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tsmcdmgtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jul 2019 14:27:42 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6JEReu2030896;
        Fri, 19 Jul 2019 14:27:41 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jul 2019 14:27:40 +0000
Date:   Fri, 19 Jul 2019 10:27:35 -0400
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
Message-ID: <20190719142735.s2oggziz4wqwebxf@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
 <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
 <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=376
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907190160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=428 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907190160
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 10:56:34PM +0800, Herbert Xu wrote:
> On Thu, Jul 18, 2019 at 10:27:30AM -0400, Daniel Jordan wrote:
> >
> > That's what I expected when I first saw it too, but nr_cpumask_bits is returned
> > to signal the end of the iteration.  The patch always passes 0 for the 'start'
> > argument, so when cpumask_next_wrap is called with the last cpu in the mask,
> > the end-of-iteration case is triggered.  To reassure you and myself :) I ran it
> > and got the expected crash.
> > 
> > Passing pd->cpu for the start argument instead avoids that problem, but the
> > one-cpu-in-mask case still needs handling because cpumask_next_wrap always
> > signals end of iteration for that, hence the cpumask_weight check.
> 
> My bad.  I should have set start to -1 to make it do the right thing.

Oh, you're right, that's nicer, just noticed other callers do it that way as
well.
