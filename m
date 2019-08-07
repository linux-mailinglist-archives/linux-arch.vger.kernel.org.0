Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DDF8508A
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2019 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfHGQCI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Aug 2019 12:02:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729745AbfHGQCI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Aug 2019 12:02:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77FhIhK102913
        for <linux-arch@vger.kernel.org>; Wed, 7 Aug 2019 12:02:07 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u810nak1t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 07 Aug 2019 12:02:06 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 7 Aug 2019 17:02:05 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Aug 2019 17:01:59 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x77G1wH135651914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Aug 2019 16:01:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98533B2068;
        Wed,  7 Aug 2019 16:01:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ABFDB2066;
        Wed,  7 Aug 2019 16:01:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Aug 2019 16:01:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C2E4F16C9A3D; Wed,  7 Aug 2019 09:01:58 -0700 (PDT)
Date:   Wed, 7 Aug 2019 09:01:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
Reply-To: paulmck@linux.ibm.com
References: <20190805121517.4734-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805121517.4734-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080716-0052-0000-0000-000003E90D08
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011566; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243437; UDB=6.00655942; IPR=6.01024906;
 MB=3.00028080; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-07 16:02:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080716-0053-0000-0000-000062026859
Message-Id: <20190807160158.GA15313@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070162
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 05, 2019 at 02:15:17PM +0200, Andrea Parri wrote:
> My @amarulasolutions.com address stopped working this July, so update
> to my @gmail.com address where you'll still be able to reach me.
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Queued for the v5.4 merge window, thank you!

							Thanx, Paul

> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6426db5198f05..527317026492f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9326,7 +9326,7 @@ F:	drivers/misc/lkdtm/*
>  
>  LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
>  M:	Alan Stern <stern@rowland.harvard.edu>
> -M:	Andrea Parri <andrea.parri@amarulasolutions.com>
> +M:	Andrea Parri <parri.andrea@gmail.com>
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Boqun Feng <boqun.feng@gmail.com>
> -- 
> 2.17.1
> 

