Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6091736B255
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 13:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhDZLaF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 07:30:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229554AbhDZLaF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 07:30:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QBPA6t132771;
        Mon, 26 Apr 2021 07:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=/qHO8gYWVWiijTjYukocta+N/QRWzwXBMwKqV8e4rSs=;
 b=RypTNGqTF2vB7dWQRxNArlcT5XzLc1tOO94tpVwUKp10pLjHkLuROcvIuQEgpbVmTJom
 WgUVjEREb3Lko9pBpUYF7ZZWHZedfM9m0T/NrCkMSXJ+eSV64smrGNZPNch9vWsJQok0
 FRLPgY13X7pqEPhfMIaYCXNB81+sWdgdioqSuQxeccbVo3hprmJuISdNKEDkbX/79O/J
 qjunH7ATqAjOk3Wx5jO5s20Z287Br/jUqvasCSph2FKmmXcogpfXIjAKyV5r/ntBieNW
 GbSPbG1HJl8fGa3pBF1dOZPS7XY06TM/Gd/3b9sGaW/FUQOVgX2QUV43snMGOIUHxfRm vA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 385stkw5e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 07:29:18 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QBRN1U014586;
        Mon, 26 Apr 2021 11:29:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 384akh8e3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 11:29:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QBTCRM30867860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 11:29:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D43754204B;
        Mon, 26 Apr 2021 11:29:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A50D42049;
        Mon, 26 Apr 2021 11:29:12 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.40.129])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 26 Apr 2021 11:29:12 +0000 (GMT)
Date:   Mon, 26 Apr 2021 14:29:09 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Vladimir Isaev <Vladimir.Isaev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARC: Use max_high_pfn as a HIGHMEM zone border
Message-ID: <YIakBTNpLsPJaj7i@linux.ibm.com>
References: <20210426101004.42695-1-isaev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426101004.42695-1-isaev@synopsys.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VjGorx5mtmwpxzP8K8upRwr2Xg7V1Bu0
X-Proofpoint-GUID: VjGorx5mtmwpxzP8K8upRwr2Xg7V1Bu0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_03:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260082
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Mon, Apr 26, 2021 at 01:10:04PM +0300, Vladimir Isaev wrote:
> Commit 4af22ded0ecf ("arc: fix memory initialization for systems with two
> memory banks") fixed highmem, but not for PAE case when highmem is
> actually bigger than lowmem.
> 
> Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arc/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> index ce07e697916c..59bad6f94105 100644
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -157,7 +157,7 @@ void __init setup_arch_memory(void)
>  	min_high_pfn = PFN_DOWN(high_mem_start);
>  	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
>  
> -	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;
> +	max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;

This is correct with PAE40, but it will break !PAE40 when "highmem" has
lower addresses than lowmem.

It rather should be something like:

        if (IS_ENABLED(CONFIG_ARC_HAS_PAE40))
                max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
        else
            	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;


>  
>  	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
>  
> -- 
> 2.16.2
> 

-- 
Sincerely yours,
Mike.
