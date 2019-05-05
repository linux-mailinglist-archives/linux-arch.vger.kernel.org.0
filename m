Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3813DDE
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2019 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfEEGX4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 May 2019 02:23:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727353AbfEEGXz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 May 2019 02:23:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x456LQ4E106890
        for <linux-arch@vger.kernel.org>; Sun, 5 May 2019 02:23:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s9pe36vdv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 05 May 2019 02:23:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 5 May 2019 07:23:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 5 May 2019 07:23:44 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x456Nh9r52560040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 May 2019 06:23:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40EC84C046;
        Sun,  5 May 2019 06:23:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D4414C040;
        Sun,  5 May 2019 06:23:41 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  5 May 2019 06:23:41 +0000 (GMT)
Date:   Sun, 5 May 2019 09:23:39 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-mips@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, linux-hexagon@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matt Turner <mattst88@gmail.com>,
        Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-m68k@lists.linux-m68k.org, Greentime Hu <green.hu@gmail.com>,
        nios2-dev@lists.rocketboards.org, Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/15] powerpc/nohash/64: switch to generic version of
 pte allocation
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-13-git-send-email-rppt@linux.ibm.com>
 <adcb6ae6-48d9-5ba9-2732-a0ab1d96667c@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adcb6ae6-48d9-5ba9-2732-a0ab1d96667c@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19050506-0020-0000-0000-000003397072
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050506-0021-0000-0000-0000218C0137
Message-Id: <20190505062339.GF15755@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905050057
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 02, 2019 at 06:56:07PM +0200, Christophe Leroy wrote:
> 
> 
> Le 02/05/2019 à 17:28, Mike Rapoport a écrit :
> >The 64-bit book-E powerpc implements pte_alloc_one(),
> >pte_alloc_one_kernel(), pte_free_kernel() and pte_free() the same way as
> >the generic version.
> 
> Will soon be converted to the same as the 3 other PPC subarches, see
> https://patchwork.ozlabs.org/patch/1091590/
 
Thanks for the heads up. I'll drop this from the next re-spin.

> Christophe
> 
> >
> >Switch it to the generic version that does exactly the same thing.
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >  arch/powerpc/include/asm/nohash/64/pgalloc.h | 35 ++--------------------------
> >  1 file changed, 2 insertions(+), 33 deletions(-)
> >
> >diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> >index 66d086f..bfb53a0 100644
> >--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
> >+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> >@@ -11,6 +11,8 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/percpu.h>
> >+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
> >+
> >  struct vmemmap_backing {
> >  	struct vmemmap_backing *list;
> >  	unsigned long phys;
> >@@ -92,39 +94,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
> >  	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
> >  }
> >-
> >-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >-{
> >-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> >-}
> >-
> >-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
> >-{
> >-	struct page *page;
> >-	pte_t *pte;
> >-
> >-	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT);
> >-	if (!pte)
> >-		return NULL;
> >-	page = virt_to_page(pte);
> >-	if (!pgtable_page_ctor(page)) {
> >-		__free_page(page);
> >-		return NULL;
> >-	}
> >-	return page;
> >-}
> >-
> >-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> >-{
> >-	free_page((unsigned long)pte);
> >-}
> >-
> >-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
> >-{
> >-	pgtable_page_dtor(ptepage);
> >-	__free_page(ptepage);
> >-}
> >-
> >  static inline void pgtable_free(void *table, int shift)
> >  {
> >  	if (!shift) {
> >
> 

-- 
Sincerely yours,
Mike.

