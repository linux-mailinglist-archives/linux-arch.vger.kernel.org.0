Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA24B517134
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385484AbiEBOIk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 10:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiEBOIj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 10:08:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA275F97;
        Mon,  2 May 2022 07:05:09 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242E1xes006582;
        Mon, 2 May 2022 14:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=pa3Y8njUgOpmxlb35vPiYLCiL63dwiQj0l9BRN8zD7Y=;
 b=pz2TcaKG09iPWvjb8QT+j50Yq/fjYuV2BbisWIzf7sFeQmk7HocWYItceAG6H8sh3g6q
 AdlRZxpsr5YFu38WbvzT5fbiz17a9xGPu8DBT9NVpih8czdyQc8Hm4CUtEEqAHfU500I
 J2kCZOXOiUxe6p8q9zLw026UfSKfc+DUStFqbOskx2R93/+fhQimCCv8zsOHnCy+RXuS
 YaymiLl/K0xslk0P57DJIhR4Yf9ZbNo+lzQgataaunD6lWOoYZVfWwXYbMWCuAJ4Gx7X
 Iuz/AT5jsuC/dXuUtr6gZLh318HoWCyXwiYFAvjNLLzRIGDZ78c/I03oBs7qIq6pryDU 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftgq400qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 14:02:42 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 242E2GTs007491;
        Mon, 2 May 2022 14:02:41 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftgq400pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 14:02:41 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 242DwVPB016037;
        Mon, 2 May 2022 14:02:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3frvr8t992-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 14:02:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 242E2bdp26476826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 14:02:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D2B9A4051;
        Mon,  2 May 2022 14:02:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4016A4040;
        Mon,  2 May 2022 14:02:34 +0000 (GMT)
Received: from thinkpad (unknown [9.171.50.173])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  2 May 2022 14:02:34 +0000 (GMT)
Date:   Mon, 2 May 2022 16:02:32 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        catalin.marinas@arm.com, will@kernel.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 unmapping
Message-ID: <20220502160232.589a6111@thinkpad>
In-Reply-To: <bcb4a3b0-4fcd-af3a-2a2c-fd662d9eaba9@linux.alibaba.com>
References: <cover.1651216964.git.baolin.wang@linux.alibaba.com>
        <c91e04ebb792ef7b72966edea8bd6fa2dfa5bfa7.1651216964.git.baolin.wang@linux.alibaba.com>
        <20220429220214.4cfc5539@thinkpad>
        <bcb4a3b0-4fcd-af3a-2a2c-fd662d9eaba9@linux.alibaba.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XuufQO1q4HTBDbV5Aeg2IfsJiDYUZ4kF
X-Proofpoint-ORIG-GUID: wX4sYDOGP4Gb-gqEiz4w3Jylk1LdzAUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_04,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 30 Apr 2022 11:22:33 +0800
Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 4/30/2022 4:02 AM, Gerald Schaefer wrote:
> > On Fri, 29 Apr 2022 16:14:43 +0800
> > Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> >> hugetlb, which means it can support not only PMD/PUD size hugetlb:
> >> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
> >> size specified.
> >>
> >> When unmapping a hugetlb page, we will get the relevant page table
> >> entry by huge_pte_offset() only once to nuke it. This is correct
> >> for PMD or PUD size hugetlb, since they always contain only one
> >> pmd entry or pud entry in the page table.
> >>
> >> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
> >> since they can contain several continuous pte or pmd entry with
> >> same page table attributes, so we will nuke only one pte or pmd
> >> entry for this CONT-PTE/PMD size hugetlb page.
> >>
> >> And now we only use try_to_unmap() to unmap a poisoned hugetlb page,
> >> which means now we will unmap only one pte entry for a CONT-PTE or
> >> CONT-PMD size poisoned hugetlb page, and we can still access other
> >> subpages of a CONT-PTE or CONT-PMD size poisoned hugetlb page,
> >> which will cause serious issues possibly.
> >>
> >> So we should change to use huge_ptep_clear_flush() to nuke the
> >> hugetlb page table to fix this issue, which already considered
> >> CONT-PTE and CONT-PMD size hugetlb.
> >>
> >> Note we've already used set_huge_swap_pte_at() to set a poisoned
> >> swap entry for a poisoned hugetlb page.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>   mm/rmap.c | 34 +++++++++++++++++-----------------
> >>   1 file changed, 17 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 7cf2408..1e168d7 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1564,28 +1564,28 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> >>   					break;
> >>   				}
> >>   			}
> >> +			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
> > 
> > Unlike in your patch 2/3, I do not see that this (huge) pteval would later
> > be used again with set_huge_pte_at() instead of set_pte_at(). Not sure if
> > this (huge) pteval could end up at a set_pte_at() later, but if yes, then
> > this would be broken on s390, and you'd need to use set_huge_pte_at()
> > instead of set_pte_at() like in your patch 2/3.
> 
> IIUC, As I said in the commit message, we will only unmap a poisoned 
> hugetlb page by try_to_unmap(), and the poisoned hugetlb page will be 
> remapped with a poisoned entry by set_huge_swap_pte_at() in 
> try_to_unmap_one(). So I think no need change to use set_huge_pte_at() 
> instead of set_pte_at() for other cases, since the hugetlb page will not 
> hit other cases.
> 
> if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
> 	pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
> 	if (folio_test_hugetlb(folio)) {
> 		hugetlb_count_sub(folio_nr_pages(folio), mm);
> 		set_huge_swap_pte_at(mm, address, pvmw.pte, pteval,
> 				     vma_mmu_pagesize(vma));
> 	} else {
> 		dec_mm_counter(mm, mm_counter(&folio->page));
> 		set_pte_at(mm, address, pvmw.pte, pteval);
> 	}
> 
> }

OK, but wouldn't the pteval be overwritten here with
pteval = swp_entry_to_pte(make_hwpoison_entry(subpage))?
IOW, what sense does it make to save the returned pteval from
huge_ptep_clear_flush(), when it is never being used anywhere?
