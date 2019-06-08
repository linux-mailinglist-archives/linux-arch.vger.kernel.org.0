Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950973A07C
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2019 17:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfFHPhu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jun 2019 11:37:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbfFHPhu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jun 2019 11:37:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58FawI1062908
        for <linux-arch@vger.kernel.org>; Sat, 8 Jun 2019 11:37:50 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t09j5a3ax-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 08 Jun 2019 11:37:49 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 8 Jun 2019 16:37:48 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Jun 2019 16:37:42 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x58FbfJT24904052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jun 2019 15:37:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB464B2064;
        Sat,  8 Jun 2019 15:37:41 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7084B205F;
        Sat,  8 Jun 2019 15:37:41 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.36])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  8 Jun 2019 15:37:41 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5A13C16C3421; Sat,  8 Jun 2019 08:37:43 -0700 (PDT)
Date:   Sat, 8 Jun 2019 08:37:43 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arch@vger.kernel.org, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 20/20] docs: pci: fix broken links due to conversion
 from pci.txt to pci.rst
Reply-To: paulmck@linux.ibm.com
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
 <780cb6c2dfe860873394675df6580765ea5a2680.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <780cb6c2dfe860873394675df6580765ea5a2680.1559933665.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060815-2213-0000-0000-0000039BF67E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011234; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01215056; UDB=6.00638755; IPR=6.00996147;
 MB=3.00027235; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-08 15:37:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060815-2214-0000-0000-00005EC5EE96
Message-Id: <20190608153743.GG28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=825 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906080117
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 07, 2019 at 03:54:36PM -0300, Mauro Carvalho Chehab wrote:
> Some documentation files were still pointing to the old place.
> 
> Fixes: 229b4e0728e0 ("Documentation: PCI: convert pci.txt to reST")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  Documentation/memory-barriers.txt                    | 2 +-
>  Documentation/translations/ko_KR/memory-barriers.txt | 2 +-
>  drivers/scsi/hpsa.c                                  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index f70ebcdfe592..f4170aae1d75 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -548,7 +548,7 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
>  
>  	[*] For information on bus mastering DMA and coherency please read:
>  
> -	    Documentation/PCI/pci.txt
> +	    Documentation/PCI/pci.rst
>  	    Documentation/DMA-API-HOWTO.txt
>  	    Documentation/DMA-API.txt
>  
> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> index db0b9d8619f1..07725b1df002 100644
> --- a/Documentation/translations/ko_KR/memory-barriers.txt
> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> @@ -569,7 +569,7 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
>  
>  	[*] 버스 마스터링 DMA 와 일관성에 대해서는 다음을 참고하시기 바랍니다:
>  
> -	    Documentation/PCI/pci.txt
> +	    Documentation/PCI/pci.rst
>  	    Documentation/DMA-API-HOWTO.txt
>  	    Documentation/DMA-API.txt
>  
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index 1bef1da273c2..53df6f7dd3f9 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -7760,7 +7760,7 @@ static void hpsa_free_pci_init(struct ctlr_info *h)
>  	hpsa_disable_interrupt_mode(h);		/* pci_init 2 */
>  	/*
>  	 * call pci_disable_device before pci_release_regions per
> -	 * Documentation/PCI/pci.txt
> +	 * Documentation/PCI/pci.rst
>  	 */
>  	pci_disable_device(h->pdev);		/* pci_init 1 */
>  	pci_release_regions(h->pdev);		/* pci_init 2 */
> @@ -7843,7 +7843,7 @@ static int hpsa_pci_init(struct ctlr_info *h)
>  clean1:
>  	/*
>  	 * call pci_disable_device before pci_release_regions per
> -	 * Documentation/PCI/pci.txt
> +	 * Documentation/PCI/pci.rst
>  	 */
>  	pci_disable_device(h->pdev);
>  	pci_release_regions(h->pdev);
> -- 
> 2.21.0
> 

