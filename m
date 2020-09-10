Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6046D264C1E
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIJSAy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 14:00:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgIJSAD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Sep 2020 14:00:03 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AHYY7h006938;
        Thu, 10 Sep 2020 13:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=G9Zv2DFfzXQ+AcQ+DZwioP8Um0SpBOmEagJC1mqcw8c=;
 b=YfCX/fYM/+0cU4iK0BOtwuIlzhkFZzTLrSdJXWxJ1k4qvuqNmGqxiyn/KPt+KO86LgCv
 HLH9k4JhR6BcmigWtTWBD6ZPqiZuUa47ahKdOpl8NTgL6knGqAsfYVupChmLtkca9Bsc
 I831JKul4hMzTIOVuB0rQhwZQk9ohHxm25Hjd2rWK5KvyJjzUOFASuUvmuwRLK/W0F3S
 15Nj4qDZJzISHQuSxWNdTxPuNefS3nEELxbeP0vDnPGrlCROMOBhYiQko1YZndl1q0z+
 /SnTTR+pYYRZOgX5pbpEMBYvpoOAlBwiL4k1va7ddddU5XSao6D8/ff297hykAE5qXrl Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33frf88wyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 13:57:58 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08AHYZQN007007;
        Thu, 10 Sep 2020 13:57:57 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33frf88wy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 13:57:57 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AHvttm028822;
        Thu, 10 Sep 2020 17:57:55 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 33c2a86aw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 17:57:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08AHvqcP35914082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 17:57:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85058A4055;
        Thu, 10 Sep 2020 17:57:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48D47A4053;
        Thu, 10 Sep 2020 17:57:51 +0000 (GMT)
Received: from thinkpad (unknown [9.171.93.242])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 10 Sep 2020 17:57:51 +0000 (GMT)
Date:   Thu, 10 Sep 2020 19:57:49 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
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
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910195749.795232d1@thinkpad>
In-Reply-To: <20200910130233.GK87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
        <20200909142904.00b72921@thinkpad>
        <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
        <20200909192534.442f8984@thinkpad>
        <20200909180324.GI87483@ziepe.ca>
        <20200910093925.GB29166@oc3871087118.ibm.com>
        <20200910130233.GK87483@ziepe.ca>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_05:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100162
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 10 Sep 2020 10:02:33 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Sep 10, 2020 at 11:39:25AM +0200, Alexander Gordeev wrote:
> 
> > As Gerald mentioned, it is very difficult to explain in a clear way.
> > Hopefully, one could make sense ot of it.
> 
> I would say the page table API requires this invariant:
> 
>         pud = pud_offset(p4d, addr);
>         do {
> 		WARN_ON(pud != pud_offset(p4d, addr);
>                 next = pud_addr_end(addr, end);
>         } while (pud++, addr = next, addr != end);
> 
> ie pud++ is supposed to be a shortcut for 
>   pud_offset(p4d, next)
> 

Hmm, IIUC, all architectures with static folding will simply return
the passed-in p4d pointer for pud_offset(p4d, addr), for 3-level
pagetables. There is no difference for s390. For gup_fast, that p4d
pointer is not really a pointer to a value in a pagetable, but
to some local copy of such a value, and not just for s390.

So, pud = p4d = pointer to copy, and increasing that pud pointer
cannot be the same as pud_offset(p4d, next). I do see your point
however, at last I think :-) My problem is that I do not see where
we would have an s390-specific issue here. Maybe my understanding
of how it works for others with static folding is wrong. That
would explain my difficulties in getting your point...

> While S390 does not follow this. Fixing addr_end brings it into
> alignment by preventing pud++ from happening.

Exactly, only that nobody seems to follow it, IIUC. Fixing it up
with pXd_addr_end was my impression of what we need to do, in order to
have it work the same way as for others.

> The only currently known side effect is that gup_fast crashes, but it
> sure is an unexpected thing.

Well, from my understanding it feels more unexpected that something
that is supposed to be a pointer to an entry in a page table, really is
just a pointer to some copy somewhere.
