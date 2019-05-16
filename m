Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95ECC1FEC6
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 07:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfEPFTd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 01:19:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbfEPFTd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 May 2019 01:19:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4G5HWaR121164
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 01:19:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgxr5wwhf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 01:19:31 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 16 May 2019 06:19:29 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 06:19:25 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4G5JOew57802782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 05:19:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A8A911C06E;
        Thu, 16 May 2019 05:19:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81D8911C05B;
        Thu, 16 May 2019 05:19:23 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 16 May 2019 05:19:23 +0000 (GMT)
Date:   Thu, 16 May 2019 08:19:21 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] remove ARCH_SELECT_MEMORY_MODEL where it has no
 effect
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19051605-4275-0000-0000-000003354B30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051605-4276-0000-0000-00003844D161
Message-Id: <20190516051921.GC21366@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=648 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160037
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andrew,

Can this go via the -mm tree?

On Wed, May 01, 2019 at 10:56:14PM +0300, Mike Rapoport wrote:
> Hi,
> 
> For several architectures the ARCH_SELECT_MEMORY_MODEL has no real effect
> because the dependencies for the memory model are always evaluated to a
> single value.
> 
> Remove the ARCH_SELECT_MEMORY_MODEL from the Kconfigs for these
> architectures.
> 
> Mike Rapoport (3):
>   arm: remove ARCH_SELECT_MEMORY_MODEL
>   s390: remove ARCH_SELECT_MEMORY_MODEL
>   sparc: remove ARCH_SELECT_MEMORY_MODEL
> 
>  arch/arm/Kconfig   | 3 ---
>  arch/s390/Kconfig  | 3 ---
>  arch/sparc/Kconfig | 3 ---
>  3 files changed, 9 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

