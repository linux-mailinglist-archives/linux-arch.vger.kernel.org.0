Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43C5FFE10
	for <lists+linux-arch@lfdr.de>; Sun, 16 Oct 2022 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJPIPW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Oct 2022 04:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJPIPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Oct 2022 04:15:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6122C135;
        Sun, 16 Oct 2022 01:15:19 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G3wxUw032333;
        Sun, 16 Oct 2022 08:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hMozpMwg+vZnUk1wC1EQIabeNAUmNvS/E5iI/01UZHU=;
 b=KDoOnXfRMJz3cUc7B79z9yw8KStrFIzwJBmhtyFhn5/O2AEXWmIylIQv6HU5ttKb4Ijg
 876VNGIYgG8P9OIbZ2ox5RQ+PmwtglxLZrOFu5Gq86h9EuqnIEvVLBkunbGalu8wC3vB
 SA19IzqdxHxXs0JM6j2HxT8vY9vPXy85t/pOfD8oCAeykIxNxDh3Yc2mtfmoS0HO6Xsq
 9zZz6Ag1PXmvW9fKvh9S4qetJkqaNiLLQUj4qRToN/QuuoqUtfzTomy8qDhYsbKXkD87
 19SX/TLy4forcuPlIUbvv49R2MGtusMWffSqAr0Gj8Lh9aYoaexQkxtaTZhcH6FMl0IE gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k866art41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Oct 2022 08:14:57 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29G8Eujq012129;
        Sun, 16 Oct 2022 08:14:56 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k866art3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Oct 2022 08:14:56 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29G85b5O007953;
        Sun, 16 Oct 2022 08:14:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3k7mg8s2b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Oct 2022 08:14:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29G8EpBx50594108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Oct 2022 08:14:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FA914203F;
        Sun, 16 Oct 2022 08:14:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E79014204B;
        Sun, 16 Oct 2022 08:14:50 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.58.10])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 16 Oct 2022 08:14:50 +0000 (GMT)
Date:   Sun, 16 Oct 2022 10:14:49 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Baoquan He <bhe@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com
Subject: Re: [RFC PATCH 3/8] mm/ioremap: Define generic_ioremap_prot() and
 generic_iounmap()
Message-ID: <Y0u9ec0Bi+FWtyA5@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <32dedfbe00c1da0114f66d6a43c56f4a16a85b64.1665568707.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32dedfbe00c1da0114f66d6a43c56f4a16a85b64.1665568707.git.christophe.leroy@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jBURfmDGT6azRIRzYI1iuxxRjRloJWlc
X-Proofpoint-ORIG-GUID: 6KdXepSdsv_24mTO-01aIVOQKmd5G-rM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_03,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=819 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 12, 2022 at 12:09:39PM +0200, Christophe Leroy wrote:
> Define a generic version of ioremap_prot() and iounmap() that
> architectures can call after they have performed the necessary
> alteration to parameters and/or necessary verifications.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

[...]

> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 8652426282cc..9f34a8f90b58 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -11,8 +11,8 @@
>  #include <linux/io.h>
>  #include <linux/export.h>
>  
> -void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> -			   unsigned long prot)
> +void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
> +				   pgprot_t prot)
>  {
>  	unsigned long offset, vaddr;
>  	phys_addr_t last_addr;
> @@ -28,7 +28,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
> -	if (!ioremap_allowed(phys_addr, size, prot))
> +	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
>  		return NULL;

It seems to me ioremap_allowed() is not needed anymore.
Whatever is checked here would move to architecture-
specific implementation.

>  	area = get_vm_area_caller(size, VM_IOREMAP,
> @@ -38,17 +38,24 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	vaddr = (unsigned long)area->addr;
>  	area->phys_addr = phys_addr;
>  
> -	if (ioremap_page_range(vaddr, vaddr + size, phys_addr,
> -			       __pgprot(prot))) {
> +	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot)) {
>  		free_vm_area(area);
>  		return NULL;
>  	}
>  
>  	return (void __iomem *)(vaddr + offset);
>  }
> +
> +#ifndef ioremap_prot

I guess, this is also needed:

#define ioremap_prot ioremap_prot

> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot)
> +{
> +	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
> +}
>  EXPORT_SYMBOL(ioremap_prot);
> +#endif
>  
> -void iounmap(volatile void __iomem *addr)
> +void generic_iounmap(volatile void __iomem *addr)
>  {
>  	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
>  
> @@ -58,4 +65,11 @@ void iounmap(volatile void __iomem *addr)
>  	if (is_vmalloc_addr(vaddr))
>  		vunmap(vaddr);
>  }
> +
> +#ifndef iounmap

Same here.

> +void iounmap(volatile void __iomem *addr)
> +{
> +	generic_iounmap(addr);
> +}
>  EXPORT_SYMBOL(iounmap);
> +#endif
