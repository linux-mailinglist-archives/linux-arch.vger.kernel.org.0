Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79E82427
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2019 19:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfHERoA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Aug 2019 13:44:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728800AbfHERoA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Aug 2019 13:44:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75HgVZP089223
        for <linux-arch@vger.kernel.org>; Mon, 5 Aug 2019 13:43:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u6pek84d4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 05 Aug 2019 13:43:58 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 5 Aug 2019 18:43:58 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Aug 2019 18:43:53 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x75Hhqik13500934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Aug 2019 17:43:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AD80B2064;
        Mon,  5 Aug 2019 17:43:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CB3EB205F;
        Mon,  5 Aug 2019 17:43:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  5 Aug 2019 17:43:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 552DA16C9A4C; Mon,  5 Aug 2019 10:43:55 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:43:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
Reply-To: paulmck@linux.ibm.com
References: <20190805121517.4734-1-parri.andrea@gmail.com>
 <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
 <20190805151545.GA1615@aparri>
 <1565018618.3341.6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565018618.3341.6.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080517-0072-0000-0000-000004508466
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011555; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01242523; UDB=6.00655387; IPR=6.01023980;
 MB=3.00028053; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-05 17:43:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080517-0073-0000-0000-00004CC188B2
Message-Id: <20190805174355.GJ28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050187
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 05, 2019 at 08:23:38AM -0700, James Bottomley wrote:
> On Mon, 2019-08-05 at 17:15 +0200, Andrea Parri wrote:
> > > Why don't you also add an entry in .mailmap as Will did in commit
> > > c584b1202f2d ("MAINTAINERS: Update my email address to use
> > > @kernel.org")?
> > 
> > I considered it but could not understand its purpose...  Maybe you
> > can explain it to me?  ;-) (can resend with this change if
> > needed/desired).
> 
> man git-shortlog gives you the gory detail, but its use is to "coalesce
> together commits by the same person in the shortlog, where their name
> and/or email address was spelled differently."  The usual way this
> happens is that people have the name that appears in the From field
> with and without initials.

New one on me, thank you!  So I should have a line in .mailmap like this?

Paul E. McKenney <paulmck@linux.vnet.ibm.com> <paul.mckenney@linaro.org> <paulmck@linux.ibm.com>

							Thanx, Paul

