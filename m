Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B37B10E3E
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2019 22:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfEAUq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 16:46:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbfEAUq1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 16:46:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41Kgnnt075034
        for <linux-arch@vger.kernel.org>; Wed, 1 May 2019 16:46:26 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7f5g92xt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2019 16:46:26 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 1 May 2019 21:46:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 21:46:21 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41KkK9W62324976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 20:46:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CBCA42042;
        Wed,  1 May 2019 20:46:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 538C74203F;
        Wed,  1 May 2019 20:46:19 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.12])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 May 2019 20:46:19 +0000 (GMT)
Date:   Wed, 1 May 2019 23:46:17 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christoph Hellwig <hch@infradead.org>
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
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
 <20190421211604.GN18914@techsingularity.net>
 <20190423071354.GB12114@infradead.org>
 <20190424113352.GA6278@rapoport-lnx>
 <20190428081107.GA30901@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428081107.GA30901@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19050120-0008-0000-0000-000002E24E29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050120-0009-0000-0000-0000224EBA0A
Message-Id: <20190501204616.GB6135@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010128
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Apr 28, 2019 at 01:11:07AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 02:33:53PM +0300, Mike Rapoport wrote:
> > On Tue, Apr 23, 2019 at 12:13:54AM -0700, Christoph Hellwig wrote:
> > > On Sun, Apr 21, 2019 at 10:16:04PM +0100, Mel Gorman wrote:
> > > > 32-bit NUMA systems should be non-existent in practice. The last NUMA
> > > > system I'm aware of that was both NUMA and 32-bit only died somewhere
> > > > between 2004 and 2007. If someone is running a 64-bit capable system in
> > > > 32-bit mode with NUMA, they really are just punishing themselves for fun.
> > > 
> > > Can we mark it as BROKEN to see if someone shouts and then remove it
> > > a year or two down the road?  Or just kill it off now..
> > 
> > How about making SPARSEMEM default for x86-32?
> 
> Sounds good.
> 
> Another question:  I always found the option to even select the memory
> models like a bad tradeoff.  Can we really expect a user to make a sane
> choice?  I'd rather stick to a relativelty optimal choice based on arch
> and maybe a few other parameters (NUMA or not for example) and stick to
> it, reducing the testing matrix.

I've sent patches that remove ARCH_SELECT_MEMORY_MODEL from arm, s390 and
sparc where it anyway has no effect [1].

That leaves arm64, ia64, parisc, powerpc, sh and i386.

I'd say that for i386 selecting between FLAT and SPARSE based on NUMA
sounds reasonable.

I'm not familiar enough with others to say if such enforcement makes any
sense.

Probably powerpc and sh can enable the preferred memory model in
platform/board part of their Kconfig, just like arm.

[1] https://lore.kernel.org/lkml/1556740577-4140-1-git-send-email-rppt@linux.ibm.com

-- 
Sincerely yours,
Mike.

