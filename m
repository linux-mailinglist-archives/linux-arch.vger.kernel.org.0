Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29A4261DED
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbgIHTnk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 15:43:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730833AbgIHPvu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 11:51:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088FmxJI086290;
        Tue, 8 Sep 2020 11:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=x24BGm+Fgj3ZmsKuCsewlqbYqVJ7sKXiAIAB+WpCSQQ=;
 b=o9fodx6aD+G5ovOeGdx+fReCygo8F9juW4hJnKEQD/cPODCcYnB/bESRUSSg0txDwJ3T
 s3+8p48PIEQWOvgrXNsEgEOlEzy9WhCb+NqT4vAKVPisD+cU5b/bX7skoEK8XLbP+Y2/
 z4thcEr1pcmoVBsucNvfM7/C+irxyK4o0Mp5+etHK2oTpTvs2PA5zNNYd/qI0Cb/fq4r
 9yKNDycsJ40VLR6idpwh8cvjjexSVGQm/V5bFxNG58QYlfmrKN9+JGS+EOXURr3eSM2O
 1S2JxrYWDL29kHIrcM4vKfxAe9F4fONUsRq7PHz468Oh8/bKKjjJy4VhxIp+qO9wdxci Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33earbnp3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 11:49:09 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 088Fn8gU087247;
        Tue, 8 Sep 2020 11:49:08 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33earbnp29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 11:49:08 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088FlvUq015855;
        Tue, 8 Sep 2020 15:49:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 33dxdr0ryw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 15:49:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088Fn2TJ55312698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 15:49:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B866C52050;
        Tue,  8 Sep 2020 15:49:02 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.58.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3B0BF52054;
        Tue,  8 Sep 2020 15:49:01 +0000 (GMT)
Date:   Tue, 8 Sep 2020 17:48:59 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 3/3] mm: make generic pXd_addr_end() macros inline
 functions
Message-ID: <20200908154859.GA11583@oc3871087118.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
 <4c101685-5b29-dace-9dd2-b6f0ae193a9c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c101685-5b29-dace-9dd2-b6f0ae193a9c@csgroup.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_08:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080143
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 08, 2020 at 07:19:38AM +0200, Christophe Leroy wrote:

[...]

> >diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >index 67ebc22cf83d..d9e7d16c2263 100644
> >--- a/include/linux/pgtable.h
> >+++ b/include/linux/pgtable.h
> >@@ -656,31 +656,35 @@ static inline int arch_unmap_one(struct mm_struct *mm,
> >   */
> >  #ifndef pgd_addr_end
> >-#define pgd_addr_end(pgd, addr, end)					\
> >-({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
> >-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> >-})
> >+#define pgd_addr_end pgd_addr_end
> 
> I think that #define is pointless, usually there is no such #define
> for the default case.

Default pgd_addr_end() gets overriden on s390 (arch/s390/include/asm/pgtable.h):

#define pgd_addr_end pgd_addr_end
static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
{
	return rste_addr_end_folded(pgd_val(pgd), addr, end);
}

> >+static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
> >+{	unsigned long __boundary = (addr + PGDIR_SIZE) & PGDIR_MASK;
> >+	return (__boundary - 1 < end - 1) ? __boundary : end;
> >+}
