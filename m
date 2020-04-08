Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 000A41A217C
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgDHMPQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:15:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgDHMPQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 08:15:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 038C6XeS108357
        for <linux-arch@vger.kernel.org>; Wed, 8 Apr 2020 08:15:15 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 309208tru0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 08 Apr 2020 08:15:15 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 8 Apr 2020 13:15:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Apr 2020 13:14:51 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 038CF24e50987260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 12:15:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C021542052;
        Wed,  8 Apr 2020 12:15:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB5164203F;
        Wed,  8 Apr 2020 12:15:01 +0000 (GMT)
Received: from thinkpad (unknown [9.145.23.121])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Apr 2020 12:15:01 +0000 (GMT)
Date:   Wed, 8 Apr 2020 14:15:00 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, christophe.leroy@c-s.fr,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH V2 0/3] mm/debug: Add more arch page table helper tests
In-Reply-To: <253cf5c8-e43e-5737-24e8-3eda3b6ba7b3@arm.com>
References: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
        <20200331143059.29fca8fa@thinkpad>
        <e3e35885-6852-16aa-3889-e22750a0cc87@arm.com>
        <20200407175440.41cc00a5@thinkpad>
        <253cf5c8-e43e-5737-24e8-3eda3b6ba7b3@arm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20040812-0012-0000-0000-000003A0A8D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040812-0013-0000-0000-000021DDCDD9
Message-Id: <20200408141500.75b2e1a7@thinkpad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080102
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 8 Apr 2020 12:41:51 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

[...]
> >   
> >>
> >> Some thing like this instead.
> >>
> >> pte_t pte = READ_ONCE(*ptep);
> >> pte = pte_mkhuge(__pte((pte_val(pte) | RANDOM_ORVALUE) & PMD_MASK));
> >>
> >> We cannot use mk_pte_phys() as it is defined only on some platforms
> >> without any generic fallback for others.  
> > 
> > Oh, didn't know that, sorry. What about using mk_pte() instead, at least
> > it would result in a present pte:
> > 
> > pte = pte_mkhuge(mk_pte(phys_to_page(RANDOM_ORVALUE & PMD_MASK), prot));  
> 
> Lets use mk_pte() here but can we do this instead
> 
> paddr = (__pfn_to_phys(pfn) | RANDOM_ORVALUE) & PMD_MASK;
> pte = pte_mkhuge(mk_pte(phys_to_page(paddr), prot));
> 

Sure, that will also work.

BTW, this RANDOM_ORVALUE is not really very random, the way it is
defined. For s390 we already changed it to mask out some arch bits,
but I guess there are other archs and bits that would always be
set with this "not so random" value, and I wonder if/how that would
affect all the tests using this value, see also below.

> > 
> > And if you also want to do some with the existing value, which seems
> > to be an empty pte, then maybe just check if writing and reading that
> > value with set_huge_pte_at() / huge_ptep_get() returns the same,
> > i.e. initially w/o RANDOM_ORVALUE.
> > 
> > So, in combination, like this (BTW, why is the barrier() needed, it
> > is not used for the other set_huge_pte_at() calls later?):  
> 
> Ahh missed, will add them. Earlier we faced problem without it after
> set_pte_at() for a test on powerpc (64) platform. Hence just added it
> here to be extra careful.
> 
> > 
> > @@ -733,24 +733,28 @@ static void __init hugetlb_advanced_test
> >         struct page *page = pfn_to_page(pfn);
> >         pte_t pte = READ_ONCE(*ptep);
> >  
> > -       pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
> > +       set_huge_pte_at(mm, vaddr, ptep, pte);
> > +       WARN_ON(!pte_same(pte, huge_ptep_get(ptep)));
> > +
> > +       pte = pte_mkhuge(mk_pte(phys_to_page(RANDOM_ORVALUE & PMD_MASK), prot));
> >         set_huge_pte_at(mm, vaddr, ptep, pte);
> >         barrier();
> >         WARN_ON(!pte_same(pte, huge_ptep_get(ptep)));
> > 
> > This would actually add a new test "write empty pte with
> > set_huge_pte_at(), then verify with huge_ptep_get()", which happens
> > to trigger a warning on s390 :-)  
> 
> On arm64 as well which checks for pte_present() in set_huge_pte_at().
> But PTE present check is not really present in each set_huge_pte_at()
> implementation especially without __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT.
> Hence wondering if we should add this new test here which will keep
> giving warnings on s390 and arm64 (at the least).

Hmm, interesting. I forgot about huge swap / migration, which is not
(and probably cannot be) supported on s390. The pte_present() check
on arm64 seems to check for such huge swap / migration entries,
according to the comment.

The new test "write empty pte with set_huge_pte_at(), then verify
with huge_ptep_get()" would then probably trigger the
WARN_ON(!pte_present(pte)) in arm64 code. So I guess "writing empty
ptes with set_huge_pte_at()" is not really a valid use case in practice,
or else you would have seen this warning before. In that case, it
might not be a good idea to add this test.

I also do wonder now, why the original test with
"pte = __pte(pte_val(pte) | RANDOM_ORVALUE);"
did not also trigger that warning on arm64. On s390 this test failed
exactly because the constructed pte was not present (initially empty,
or'ing RANDOM_ORVALUE does not make it present for s390). I guess this
just worked by chance on arm64, because the bits from RANDOM_ORVALUE
also happened to mark the pte present for arm64.

This brings us back to the question above, regarding the "randomness"
of RANDOM_ORVALUE. Not really sure what the intention behind that was,
but maybe it would make sense to restrict this RANDOM_ORVALUE to
non-arch-specific bits, i.e. only bits that would be part of the
address value within a page table entry? Or was it intentionally
chosen to also mess with other bits?

Regards,
Gerald

