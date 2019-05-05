Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5513E7D
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2019 10:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfEEIxd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 May 2019 04:53:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbfEEIxd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 May 2019 04:53:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x458qBC3033838
        for <linux-arch@vger.kernel.org>; Sun, 5 May 2019 04:53:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s9r5hfgh1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 05 May 2019 04:53:31 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 5 May 2019 09:53:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 5 May 2019 09:53:26 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x458rPKe63242432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 May 2019 08:53:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7928852052;
        Sun,  5 May 2019 08:53:25 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 9E0295204F;
        Sun,  5 May 2019 08:53:24 +0000 (GMT)
Date:   Sun, 5 May 2019 11:53:23 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190419142835.GM18914@techsingularity.net>
 <9e7b80a9-b90e-ac04-8b30-b2f285cd4432@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e7b80a9-b90e-ac04-8b30-b2f285cd4432@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19050508-0012-0000-0000-0000031878B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050508-0013-0000-0000-00002150EEE3
Message-Id: <20190505085322.GH15755@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=755 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905050080
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Fri, Apr 19, 2019 at 10:08:31PM +0200, Helge Deller wrote:
> On 19.04.19 16:28, Mel Gorman wrote:
> > On Fri, Apr 19, 2019 at 07:05:21AM -0700, Matthew Wilcox wrote:
> >> On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> >>> DISCONTIG is essentially deprecated and even parisc plans to move to
> >>> SPARSEMEM so there is no need to be fancy, this patch simply disables
> >>> watermark boosting by default on DISCONTIGMEM.
> >>
> >> I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
> >> scenarios.  Grepping the arch/ directories shows:
> >>
> >> alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
> >> arc (for supporting more than 1GB of memory)
> >> ia64 (looks complicated ...)
> >> m68k (for multiple chunks of memory)
> >> mips (does support NUMA but also non-NUMA)
> >> parisc (both NUMA and non-NUMA)
> >>
> >> I'm not sure that these architecture maintainers even know that DISCONTIGMEM
> >> is deprecated.  Adding linux-arch to the cc.
> >
> > Poor wording then -- yes, DISCONTIGMEM is still used but look where it's
> > used. I find it impossible to believe that any new arch would support
> > DISCONTIGMEM or that DISCONTIGMEM would be selected when SPARSEMEM is
> > available.`It's even more insane when you consider that SPARSEMEM can be
> > extended to support VMEMMAP so that it has similar overhead to FLATMEM
> > when mapping pfns to struct pages and vice-versa.
> 
> FYI, on parisc we will switch from DISCONTIGMEM to SPARSEMEM with kernel 5.2.
> The patch was quite simple and it's currently in the for-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?h=for-next&id=281b718721a5e78288271d632731cea9697749f7

A while ago I've sent a patch that removes ARCH_DISCARD_MEMBLOCK option [1]
so the hunk below is not needed:

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index c8038165b81f..26c215570adf 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -36,6 +36,7 @@ config PARISC
 	select GENERIC_STRNCPY_FROM_USER
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_EXCEPTION_TRACE
+	select ARCH_DISCARD_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC
 	select VIRT_TO_BUS
 	select MODULES_USE_ELF_RELA


[1] https://lore.kernel.org/lkml/1556102150-32517-1-git-send-email-rppt@linux.ibm.com/
 
> Helge
> 

-- 
Sincerely yours,
Mike.

