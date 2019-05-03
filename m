Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C360412F79
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfECNsw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 May 2019 09:48:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfECNsw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 09:48:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43DmFMb105464
        for <linux-arch@vger.kernel.org>; Fri, 3 May 2019 09:48:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s8maaeqau-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 03 May 2019 09:48:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 3 May 2019 14:47:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 May 2019 14:47:22 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x43DlLHG23330858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 13:47:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27CA642045;
        Fri,  3 May 2019 13:47:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B8E742041;
        Fri,  3 May 2019 13:47:20 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  3 May 2019 13:47:20 +0000 (GMT)
Date:   Fri, 3 May 2019 15:47:19 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] s390: remove ARCH_SELECT_MEMORY_MODEL
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
 <1556740577-4140-3-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556740577-4140-3-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050313-0012-0000-0000-00000317F2E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050313-0013-0000-0000-0000215065E1
Message-Id: <20190503134719.GB5602@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=816 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030087
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 01, 2019 at 10:56:16PM +0300, Mike Rapoport wrote:
> The only reason s390 has ARCH_SELECT_MEMORY_MODEL option in
> arch/s390/Kconfig is an ancient compile error with allnoconfig which was
> fixed by commit 97195d6b411f ("[S390] fix sparsemem related compile error
> with allnoconfig on s390") by adding the ARCH_SELECT_MEMORY_MODEL option.
> 
> Since then a lot have changed and now allnoconfig builds just fine without
> ARCH_SELECT_MEMORY_MODEL, so it can be removed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/s390/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

