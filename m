Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2E4262FFC
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 16:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIIOtT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 10:49:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729935AbgIIMbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 08:31:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089CJwer171227;
        Wed, 9 Sep 2020 08:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=GkaEv/0DUgjoFJ/sLWVerb24X+/pHjQgNqP/DNe1tXI=;
 b=XbQz4n9iTHtJDGQO9CZAgLFI2HTH0DExHrpy9r8Jb6UgN/j9t+yJW4DDEJ/r6mXI2D1e
 kEueEF6svz/bwwdJsy4ZKnHZmJiGpPZeQ2ru7yXD1mb1H3zWTzlGZA1e1M0hHMGQpwti
 1OaYI6tidGwSMZ6jHjA2ujxFfweEL++pxbQmD88za0Sd+bgLMk9cweQCaPZVFHV35cDX
 YuuiNfDVXOOefxWa8DlE744vBqJTgFub2JvXbc4IqpnQzeu010RHZNYF+vuCC+9BalTI
 VKOHs8iCEkMfwoe3+X4Unbc8lgOi0i/jim59CEBNL0QrsBBm0haWZaGWerQhf2XpTpM+ Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33exyar9ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 08:29:15 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089CKbKB173414;
        Wed, 9 Sep 2020 08:29:14 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33exyar97k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 08:29:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089CMkts028029;
        Wed, 9 Sep 2020 12:29:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8ch08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 12:29:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089CT8mO22217190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 12:29:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD7B64204F;
        Wed,  9 Sep 2020 12:29:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7957C42045;
        Wed,  9 Sep 2020 12:29:05 +0000 (GMT)
Received: from thinkpad (unknown [9.171.79.102])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  9 Sep 2020 12:29:05 +0000 (GMT)
Date:   Wed, 9 Sep 2020 14:29:04 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
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
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200909142904.00b72921@thinkpad>
In-Reply-To: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_06:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090103
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 8 Sep 2020 07:30:50 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/7/20 11:00 AM, Gerald Schaefer wrote:
> > Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> > code") introduced a subtle but severe bug on s390 with gup_fast, due to
> > dynamic page table folding.
> 
> Would it be fair to say that the "fake" page table entries s390
> allocates on the stack are what's causing the trouble here?  That might
> be a nice thing to open up with here.  "Dynamic page table folding"
> really means nothing to me.

Sorry, I guess my previous reply does not really explain "what the heck
is dynamic page table folding?".

On s390, we can have different number of page table levels for different
processes / mms. We always start with 3 levels, and update dynamically
on process demand to 4 or 5 levels, hence the dynamic folding. Still,
the PxD_SIZE/SHIFT is defined statically, so that e.g. pXd_addr_end() will
not reflect this dynamic behavior.

For the various pagetable walkers using pXd_addr_end() (w/o READ_ONCE
logic) this is no problem. With static folding, iteration over the folded
levels will always happen at pgd level (top-level folding). For s390,
we stay at the respective level and iterate there (dynamic middle-level
folding), only return to pgd level if there really were 5 levels.

This only works well as long there are real pagetable pointers involved,
that can also be used for iteration. For gup_fast, or any other future
pagetable walkers using the READ_ONCE logic w/o lock, that is not true.
There are pointers involved to local pXd values on the stack, because of
the READ_ONCE logic, and our middle-level iteration will suddenly iterate
over such stack pointers instead of pagetable pointers.

This will be addressed by making the pXd_addr_end() dynamic, for which
we need to see the pXd value in order to determine its level / type.
