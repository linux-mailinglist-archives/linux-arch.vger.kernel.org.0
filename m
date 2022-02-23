Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F754C111F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 12:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiBWLTQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 06:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbiBWLTO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 06:19:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819458F612;
        Wed, 23 Feb 2022 03:18:47 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21N8mKpn012722;
        Wed, 23 Feb 2022 11:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2edBr+yA1u4tfCoNZ51i6nGbnULTqu47+hi+OSwmfgE=;
 b=Uobji5yrBW4Xb1Ci8Jdi3aDpr2pFCL1nx9DWol7+wGXvDQN5GzZ0QuDpe25gVGRkKArL
 FO/YhuwTnq2zdFzHY8ZKiOYJp5JXDwlzlXVccVZLLvJ5JqMTOxGLjie0CmlzqIhMkFH9
 s2uFxEOxFec9xBrXP4P50jnJ3ihcbRLiBruaewIAWTTMa4J+tsDN5UF5W5zEdo/zZCWJ
 xaPumw0Ys0Brgi5bhwbFBKq+BZ3ggicyrxEV3SaHtcuFHAdiE+l9+4f8ACQyxtitW71q
 3r8RDZYf1cxWNC4nKaHXCtdIA6z2cQE+U2zgIv90prghN63R+bHfCe9qFGDUBWEy0opv 8g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edhqsaqkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 11:18:38 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NBGQ4E029180;
        Wed, 23 Feb 2022 11:18:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3ear69fugj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 11:18:36 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NBIU1i59113914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 11:18:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4FAC42049;
        Wed, 23 Feb 2022 11:18:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3223C4203F;
        Wed, 23 Feb 2022 11:18:30 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.72.183])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Feb 2022 11:18:30 +0000 (GMT)
Date:   Wed, 23 Feb 2022 12:18:28 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH V2 14/30] s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <YhYYBMT6HaSviD7X@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
 <1645425519-9034-15-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645425519-9034-15-git-send-email-anshuman.khandual@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UXZJEmT1Y-WzhFohdDob4sQiOuoY1tgv
X-Proofpoint-ORIG-GUID: UXZJEmT1Y-WzhFohdDob4sQiOuoY1tgv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_03,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=767 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 21, 2022 at 12:08:23PM +0530, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

> ---
>  arch/s390/Kconfig               |  1 +
>  arch/s390/include/asm/pgtable.h | 17 -----------------
>  arch/s390/mm/mmap.c             | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index be9f39fd06df..cb1b487e8201 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -78,6 +78,7 @@ config S390
>  	select ARCH_HAS_SYSCALL_WRAPPER
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_VDSO_DATA
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select ARCH_INLINE_READ_LOCK
>  	select ARCH_INLINE_READ_LOCK_BH
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 008a6c856fa4..3893ef64b439 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -422,23 +422,6 @@ static inline int is_module_addr(void *addr)
>   * implies read permission.
>   */
>           /*xwr*/
> -#define __P000	PAGE_NONE
> -#define __P001	PAGE_RO
> -#define __P010	PAGE_RO
> -#define __P011	PAGE_RO
> -#define __P100	PAGE_RX
> -#define __P101	PAGE_RX
> -#define __P110	PAGE_RX
> -#define __P111	PAGE_RX
> -
> -#define __S000	PAGE_NONE
> -#define __S001	PAGE_RO
> -#define __S010	PAGE_RW
> -#define __S011	PAGE_RW
> -#define __S100	PAGE_RX
> -#define __S101	PAGE_RX
> -#define __S110	PAGE_RWX
> -#define __S111	PAGE_RWX
>  
>  /*
>   * Segment entry (large page) protection definitions.
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index e54f928503c5..e99c198aa5de 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -188,3 +188,36 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>  		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>  	}
>  }
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +	case VM_NONE:
> +		return PAGE_NONE;
> +	case VM_READ:
> +	case VM_WRITE:
> +	case VM_WRITE | VM_READ:
> +		return PAGE_RO;
> +	case VM_EXEC:
> +	case VM_EXEC | VM_READ:
> +	case VM_EXEC | VM_WRITE:
> +	case VM_EXEC | VM_WRITE | VM_READ:
> +		return PAGE_RX;
> +	case VM_SHARED:
> +		return PAGE_NONE;
> +	case VM_SHARED | VM_READ:
> +		return PAGE_RO;
> +	case VM_SHARED | VM_WRITE:
> +	case VM_SHARED | VM_WRITE | VM_READ:
> +		return PAGE_RW;
> +	case VM_SHARED | VM_EXEC:
> +	case VM_SHARED | VM_EXEC | VM_READ:
> +		return PAGE_RX;
> +	case VM_SHARED | VM_EXEC | VM_WRITE:
> +	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
> +		return PAGE_RWX;
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);
> -- 
> 2.25.1
> 
