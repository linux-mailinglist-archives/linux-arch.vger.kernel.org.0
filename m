Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801667C6731
	for <lists+linux-arch@lfdr.de>; Thu, 12 Oct 2023 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbjJLHZw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Oct 2023 03:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347114AbjJLHZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Oct 2023 03:25:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203B990;
        Thu, 12 Oct 2023 00:25:50 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C7JN7v017051;
        Thu, 12 Oct 2023 07:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5MqhUHWaw+1K2HvrJPqGawKne8YN3vxBSsQbSVm1zg8=;
 b=p50xijw8s91A2Q9ug3Gd49JWz4ZvgqA6Hy+zMLFDqVv4bzeNaYOveL4uET4RJOp3gesp
 DAwgrwHJ03HgF9eeEvp+eOO7qwrmg+XNvm8OUqoLNt7lJlDAVEqtjN8CiKqDMXhlLcky
 eKGNUZ1kMUtv/z8/kUcfCyEga3J/tdfvDxnt6ZfgS26CGMmztvCMkSoI1bmaVHklgkOD
 4j0SuHSA9ruFRWECactW6nhgOGtTYpcc3OzdI19+LWOAFipwZEMmcg23yiLFkz2UiyBh
 lGMGaxZYCj+Q2PbNgyXx8ufLOeAMZwfSd+coiMBtiELvWv8yrxN+BKmJ1I/kFUJhuVnc VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpca988bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 07:25:11 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39C7JNSY017085;
        Thu, 12 Oct 2023 07:25:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpca988ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 07:25:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39C4sB2E001239;
        Thu, 12 Oct 2023 07:25:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk5hry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 07:25:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39C7P7Zc27001390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 07:25:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA71020065;
        Thu, 12 Oct 2023 07:25:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AAA920063;
        Thu, 12 Oct 2023 07:25:07 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Oct 2023 07:25:07 +0000 (GMT)
Date:   Thu, 12 Oct 2023 09:25:05 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH mm-unstable v9 14/31] s390: Convert various pgalloc
 functions to use ptdescs
Message-ID: <20231012072505.6160-A-hca@linux.ibm.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
 <20230807230513.102486-15-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807230513.102486-15-vishal.moola@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R9BBv1jP5we_uE3OHfXIw10GtOr53ihr
X-Proofpoint-GUID: -0DchMoDG4gnKEi3H7t5YnEcLMTMxRGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=661
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07, 2023 at 04:04:56PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> Some of the functions use the *get*page*() helper functions. Convert
> these to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.
> 
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  arch/s390/include/asm/pgalloc.h |   4 +-
>  arch/s390/include/asm/tlb.h     |   4 +-
>  arch/s390/mm/pgalloc.c          | 128 ++++++++++++++++----------------
>  3 files changed, 69 insertions(+), 67 deletions(-)
...
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index d7374add7820..07fc660a24aa 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
...
> @@ -488,16 +486,20 @@ static void base_pgt_free(unsigned long *table)
>  static unsigned long *base_crst_alloc(unsigned long val)
>  {
>  	unsigned long *table;
> +	struct ptdesc *ptdesc;
>  
> -	table =	(unsigned long *)__get_free_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
> -	if (table)
> -		crst_table_init(table, val);
> +	ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, CRST_ALLOC_ORDER);

I guess I must miss something, but what is the reason to mask out
__GFP_HIGHMEM here? It is not part of GFP_KERNEL, nor does s390 support
HIGHMEM.
