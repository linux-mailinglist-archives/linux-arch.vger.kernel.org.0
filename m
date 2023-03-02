Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F66A838D
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 14:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCBNcU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 08:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBNcT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 08:32:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F53B675;
        Thu,  2 Mar 2023 05:32:18 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322DFZvZ010455;
        Thu, 2 Mar 2023 13:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ba61TMgbgtq2qCLloS89YKVV6TrsoEUxqPkJmjoGD+Q=;
 b=rnzVAew6rlusCElG0+c9Ft8GCJZwxOCj9pEbrQJH+tbt377GnwnW5K7LZNsm7LkH6h7D
 3FMv95yDnAFSaN+R+B/pqQnEyh7H/PgW64tPAo+aMa0WViiNSm+uPom4zsUS2QdW+y1H
 ll1DU3Q2g91JJ9xAMaFuxpWI5Vbb7IWg1PVFK80T2xE7NLG3KmSB5KvHvjYcWd5ud6VY
 XUXBJ2GRH270NMAN3ZY6qxpD80fpT3CZfsH2LkFTLPYY587jtpGRMpSod+cvVnzmLr89
 M3VahycIScDLF7CY0xRfMBBjiYK5cge1YedI9OPgkfY1Gz2xFCk/ubdGygBh82tU6miC hQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2vhcrfbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 13:32:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32264nRo013030;
        Thu, 2 Mar 2023 13:32:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nybcq5uj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 13:32:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 322DVv9a64094476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Mar 2023 13:31:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F284920043;
        Thu,  2 Mar 2023 13:31:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81DE520040;
        Thu,  2 Mar 2023 13:31:56 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.152.212.238])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Mar 2023 13:31:56 +0000 (GMT)
Date:   Thu, 2 Mar 2023 14:31:54 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 21/34] s390: Implement the new page table range API
Message-ID: <20230302143154.1886c213@thinkpad-T15>
In-Reply-To: <20230228213738.272178-22-willy@infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
        <20230228213738.272178-22-willy@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aAeGP5EBVBGILPMKK7Fm47tHFTlZ37R7
X-Proofpoint-GUID: aAeGP5EBVBGILPMKK7Fm47tHFTlZ37R7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_07,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=640 mlxscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 28 Feb 2023 21:37:24 +0000
"Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Add set_ptes() and update_mmu_cache_range().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/include/asm/pgtable.h | 34 ++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 2c70b4d1263d..46bf475116f1 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -50,6 +50,7 @@ void arch_report_meminfo(struct seq_file *m);
>   * tables contain all the necessary information.
>   */
>  #define update_mmu_cache(vma, address, ptep)     do { } while (0)
> +#define update_mmu_cache_range(vma, addr, ptep, nr)	do { } while (0)
>  #define update_mmu_cache_pmd(vma, address, ptep) do { } while (0)
>  
>  /*
> @@ -1317,21 +1318,36 @@ pgprot_t pgprot_writecombine(pgprot_t prot);
>  pgprot_t pgprot_writethrough(pgprot_t prot);
>  
>  /*
> - * Certain architectures need to do special things when PTEs
> - * within a page table are directly modified.  Thus, the following
> - * hook is made available.
> + * Set multiple PTEs to consecutive pages with a single call.  All PTEs
> + * are within the same folio, PMD and VMA.
>   */
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t entry)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *ptep, pte_t entry, unsigned int nr)
>  {
>  	if (pte_present(entry))
>  		entry = clear_pte_bit(entry, __pgprot(_PAGE_UNUSED));
> -	if (mm_has_pgste(mm))
> -		ptep_set_pte_at(mm, addr, ptep, entry);
> -	else
> -		set_pte(ptep, entry);
> +	if (mm_has_pgste(mm)) {
> +		for (;;) {
> +			ptep_set_pte_at(mm, addr, ptep, entry);

There might be room for additional optimization here, regarding the
preempt_disable/enable() in ptep_set_pte_at(), i.e. move it out of
ptep_set_pte_at() and do it only once in this loop.

We could add that later with an add-on patch, but for this series it
all looks good.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
