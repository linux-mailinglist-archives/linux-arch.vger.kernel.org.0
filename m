Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD84BD6F9
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 08:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345840AbiBUHKF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 02:10:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345834AbiBUHKE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 02:10:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68114B69;
        Sun, 20 Feb 2022 23:09:42 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L5x3mn032476;
        Mon, 21 Feb 2022 07:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=MJhpvW5MVCCMBBhzrfgNExQc0IJAxdOdzIWRCu/LHIo=;
 b=kY+b+y1ixGQnAmH1P7pnF4qQw019DYBKOHf5FD5EpNaHrcF7PN3pUsvbZS6xsTLU+62/
 8TO+FbGfGZgoP+TOOvp2f1+hNfhFBOCBO5WJrZXxWMlKSmiqtzWksLn3Ey5/Nu7OuK2V
 IS21jQoJKO4e4KBmPKv06Td7yb+U8EZ4E7tf4gBitpZt5HETC6Mpth2c+nEZn63SSwS1
 kgTIrPdpNH6qYKS7IhQ/kJ4/AvAfsMOeujVIeg+k87cvMYCBIMFlFVlEON63RXWYcLEQ
 D81j5gfmc0ZKu4LhbV89WaIucAL1z5hPqLxRNfkjDD4mTwXLiFdwCm5WNMi6XjZ0P453 Nw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec1a3ctws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:09:31 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21L78nOU018633;
        Mon, 21 Feb 2022 07:09:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3eaqtj7m7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:09:30 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21L79PC447055278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 07:09:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81269A4060;
        Mon, 21 Feb 2022 07:09:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32A2DA405B;
        Mon, 21 Feb 2022 07:09:25 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 21 Feb 2022 07:09:25 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH V2 14/30] s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
        <1645425519-9034-15-git-send-email-anshuman.khandual@arm.com>
Date:   Mon, 21 Feb 2022 08:09:24 +0100
In-Reply-To: <1645425519-9034-15-git-send-email-anshuman.khandual@arm.com>
        (Anshuman Khandual's message of "Mon, 21 Feb 2022 12:08:23 +0530")
Message-ID: <yt9d7d9oy9uj.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 44z3tJRQA9fHVPR-mZnYWCBOdkf3-xMR
X-Proofpoint-GUID: 44z3tJRQA9fHVPR-mZnYWCBOdkf3-xMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_02,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=724 impostorscore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202210045
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Sven Schnelle <svens@linux.ibm.com>

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
