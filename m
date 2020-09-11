Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98DC265F86
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgIKM1r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 08:27:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbgIKMVF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Sep 2020 08:21:05 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BCD1YB165620;
        Fri, 11 Sep 2020 08:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zdacK9mbo5spNdP46BQjABMYJwrXCJIDnRxfJoMcJ0g=;
 b=c7kD188Z/Z4gvIPcxs2/53B0y6s1z7VhRaAT0ErwVdvd138i/8bz0A8lemIpkNrMfEs3
 q5jr6rOT4C4c10eReNFGsDMU2GXrMcRpJcaXQlf4B6cejax3Gmr2BXysGWGgCzYA/3VO
 MBIpQtcXLb+e+HOhOUFJ9AdIH4DB033b/w9FMF/vIWMkQ6GBhu3vs7uxNNdh0mRAFIKq
 myJOwb6CaKZlbztnlr2vxb0VWmYVFXUfiMTdjOupJLJTHIgNHqqDRpPpTJeAZOAcVpyN
 1bsjZXy0k97mfdz3cF+vsikucIjnhDCMIRd7Ev+khJpbI0j+zQCR+ordHQRlxjq6msW3 mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33g91v073v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 08:20:05 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BCET1B169362;
        Fri, 11 Sep 2020 08:20:05 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33g91v072d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 08:20:04 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BCCx1R020959;
        Fri, 11 Sep 2020 12:20:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 33f3yrh5sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 12:20:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BCJxKU21627358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 12:19:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4811F52051;
        Fri, 11 Sep 2020 12:19:59 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.1.245])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id A66A45204E;
        Fri, 11 Sep 2020 12:19:57 +0000 (GMT)
Date:   Fri, 11 Sep 2020 14:19:56 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20200911121955.GA10250@oc3871087118.ibm.com>
References: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
 <0c9bcb54-914b-e582-dd6d-3861267b6c94@nvidia.com>
 <20200910221116.GQ87483@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910221116.GQ87483@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_04:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110095
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 10, 2020 at 07:11:16PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 02:22:37PM -0700, John Hubbard wrote:
> 
> > Or am I way off here, and it really is possible (aside from the current
> > s390 situation) to observe something that "is no longer a page table"?
> 
> Yes, that is the issue. Remember there is no locking for GUP
> fast. While a page table cannot be freed there is nothing preventing
> the page table entry from being concurrently modified.
> 
> Without the stack variable it looks like this:
> 
>        pud_t pud = READ_ONCE(*pudp);
>        if (!pud_present(pud))
>             return
>        pmd_offset(pudp, address);
> 
> And pmd_offset() expands to
> 
>     return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
> 
> Between the READ_ONCE(*pudp) and (*pud) inside pmd_offset() the value
> of *pud can change, eg to !pud_present.
> 
> Then pud_page_vaddr(*pud) will crash. It is not use after free, it
> is using data that has not been validated.

One thing I ask myself and it is probably a good moment to wonder.

What if the entry is still pud_present, but got remapped after
READ_ONCE(*pudp)? IOW, it is still valid, but points elsewhere?

> Jason
