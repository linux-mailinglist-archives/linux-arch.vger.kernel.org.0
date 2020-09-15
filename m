Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622D826AD3F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgIOTB2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 15:01:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727430AbgIORLm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 13:11:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FH3pQx087775;
        Tue, 15 Sep 2020 13:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0SwsWPJcQ8csUf8qT+IW5LyVsjYQaHYS00V7321t2GI=;
 b=Su2Y/VZR9MFPTTe76itJJTC2PYOcVxxTPkTe16Z+dWUBxWmBnEEOPxMSKSiuSbIusBSD
 +muGOMobMoG+nNfYDxtE3jDvPkZxmtfg9tZiFjWrJvJlVTkTOGG7kqPJICVPKSZ5sKqg
 1sgfp6wjddy3brhgYwS8mw+c051uWPXeODG2jP0bn4wv5m61YFrcNzu3+fiyCM6evgRY
 Jd+HFnGXgVXjnS8FVFh8m8RCd5qh08IOuyExBsRsnHUWAiOweYzGOvZYsdmjTYSKG4b1
 7CerArw50uSE/wBNAL9yn7+mPPISXo8u+0b5hhswnVHoGWtYQzWCrj50oixD4qakn4LN 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33k1pdg5n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 13:09:38 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FH49XR088681;
        Tue, 15 Sep 2020 13:09:37 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33k1pdg5ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 13:09:37 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FH8Lnb026534;
        Tue, 15 Sep 2020 17:09:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 33gny820bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 17:09:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FH9VVo28901714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 17:09:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3DF152054;
        Tue, 15 Sep 2020 17:09:31 +0000 (GMT)
Received: from localhost (unknown [9.145.80.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1BD555204E;
        Tue, 15 Sep 2020 17:09:29 +0000 (GMT)
Date:   Tue, 15 Sep 2020 19:09:27 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2] mm/gup: fix gup_fast with dynamic page table folding
Message-ID: <your-ad-here.call-01600189767-ext-4442@work.hours>
References: <20200911200511.GC1221970@ziepe.ca>
 <patch.git-943f1e5dcff2.your-ad-here.call-01599856292-ext-8676@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch.git-943f1e5dcff2.your-ad-here.call-01599856292-ext-8676@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_12:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=993 suspectscore=1
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009150137
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 11, 2020 at 10:36:43PM +0200, Vasily Gorbik wrote:
> Currently to make sure that every page table entry is read just once
> gup_fast walks perform READ_ONCE and pass pXd value down to the next
> gup_pXd_range function by value e.g.:
...snip...
> ---
> v2: added brackets &pgd -> &(pgd)
> 
>  arch/s390/include/asm/pgtable.h | 42 +++++++++++++++++++++++----------
>  include/linux/pgtable.h         | 10 ++++++++
>  mm/gup.c                        | 18 +++++++-------
>  3 files changed, 49 insertions(+), 21 deletions(-)

Andrew, any chance you would pick this up?

There is an Ack from Linus. And I haven't seen any objections from Jason or John.
This seems to be as safe for other architectures as possible.

@Jason and John
Any acks/nacks?

Thank you,
Vasily
