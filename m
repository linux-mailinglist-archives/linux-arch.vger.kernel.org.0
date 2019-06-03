Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A7433993
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2019 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfFCUNc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jun 2019 16:13:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbfFCUNb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 16:13:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53KDOX8083623
        for <linux-arch@vger.kernel.org>; Mon, 3 Jun 2019 16:13:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sw9kxj5mn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 03 Jun 2019 16:13:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 3 Jun 2019 21:13:28 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Jun 2019 21:13:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x53KDPLJ37355998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jun 2019 20:13:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3805DB206A;
        Mon,  3 Jun 2019 20:13:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08559B2066;
        Mon,  3 Jun 2019 20:13:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.210.156])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jun 2019 20:13:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7742816C5DA0; Mon,  3 Jun 2019 13:13:24 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:13:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Reply-To: paulmck@linux.ibm.com
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060320-0060-0000-0000-0000034B921E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011209; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01212784; UDB=6.00637371; IPR=6.00993844;
 MB=3.00027168; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-03 20:13:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060320-0061-0000-0000-0000499BBCCD
Message-Id: <20190603201324.GN28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=792 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906030135
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 03, 2019 at 06:08:35PM +0000, Vineet Gupta wrote:
> On 5/31/19 1:21 AM, Peter Zijlstra wrote:
> >> I'm not sure how to interpret "natural alignment" for the case of double
> >> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> >> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> > Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))
> >
> > For any u64 type, that would give 8 byte alignment. the problem
> > otherwise being that your data spans two lines/pages etc..
> 
> Sure, but as Paul said, if the software doesn't expect them to be atomic by
> default, they could span 2 hardware lines to keep the implementation simpler/sane.

I could imagine 8-byte types being only four-byte aligned on 32-bit systems,
but it would be quite a surprise on 64-bit systems.

							Thanx, Paul

