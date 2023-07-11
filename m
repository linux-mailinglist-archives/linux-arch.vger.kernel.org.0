Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D174F357
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjGKPZK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjGKPZG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 11:25:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA001709;
        Tue, 11 Jul 2023 08:25:01 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BFElpw015862;
        Tue, 11 Jul 2023 15:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=8vRKIB/oQSe4Fw8xR2W+LRHW6mvyUpJiz4TUanc6P/U=;
 b=H417dPSMKp6L5jR6Xh6YEFUIDTLT7ar5WfwgdzN00bnd7a95kJVeRgk1K2eWeDyiK1sm
 WtNaeTrrnGHcw7ZdEjX4h9ZUMXD+SNjOUDlYnT8oJfj6S0LUeIz27PgXPKJXdDHdCyNq
 FLAkiSzM2lGIFd9Xir08B66tkl4MgigU35goPOepOTdYK9Xk9mOhI37g77N53nLKeHbj
 dv1ZzVjuY3f/uj3q9v0xCB8/5VKN4+UtJnIWt32oal0wzFuAkJDqFYgrQCY01WKU1glu
 hTPWxDb/h8I8bwoGhzQD6fuJjiWoxXMAdNjHdfc9aBY8ZLabEbXyKIG+upDPKjlK+1iP FA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs9j80ah4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 15:24:48 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9vbmo015539;
        Tue, 11 Jul 2023 15:24:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rpy2e1v28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 15:24:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36BFOgV550201022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 15:24:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 691A020040;
        Tue, 11 Jul 2023 15:24:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E1BC20043;
        Tue, 11 Jul 2023 15:24:42 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jul 2023 15:24:42 +0000 (GMT)
Date:   Tue, 11 Jul 2023 17:24:40 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v5 00/38] New page table range API
Message-ID: <20230711172440.77504856@p-imbrenda>
In-Reply-To: <ZK1My5hQYC2Kb6G1@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
        <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
        <ZK1My5hQYC2Kb6G1@casper.infradead.org>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HXlugPUk1Rr1lSlFvJf0rDVCUbZBdS0K
X-Proofpoint-GUID: HXlugPUk1Rr1lSlFvJf0rDVCUbZBdS0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 phishscore=0 spamscore=1
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 mlxscore=1 mlxlogscore=224 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 11 Jul 2023 13:36:27 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Jul 11, 2023 at 11:07:06AM +0200, Christian Borntraeger wrote:
> > Am 10.07.23 um 22:43 schrieb Matthew Wilcox (Oracle):  
> > > This patchset changes the API used by the MM to set up page table entries.
> > > The four APIs are:
> > >      set_ptes(mm, addr, ptep, pte, nr)
> > >      update_mmu_cache_range(vma, addr, ptep, nr)
> > >      flush_dcache_folio(folio)
> > >      flush_icache_pages(vma, page, nr)
> > > 
> > > flush_dcache_folio() isn't technically new, but no architecture
> > > implemented it, so I've done that for them.  The old APIs remain around
> > > but are mostly implemented by calling the new interfaces.
> > > 
> > > The new APIs are based around setting up N page table entries at once.
> > > The N entries belong to the same PMD, the same folio and the same VMA,
> > > so ptep++ is a legitimate operation, and locking is taken care of for
> > > you.  Some architectures can do a better job of it than just a loop,
> > > but I have hesitated to make too deep a change to architectures I don't
> > > understand well.
> > > 
> > > One thing I have changed in every architecture is that PG_arch_1 is now a
> > > per-folio bit instead of a per-page bit.  This was something that would
> > > have to happen eventually, and it makes sense to do it now rather than
> > > iterate over every page involved in a cache flush and figure out if it
> > > needs to happen.  
> > 
> > I think we do use PG_arch_1 on s390 for our secure page handling and
> > making this perf folio instead of physical page really seems wrong
> > and it probably breaks this code.  
> 
> Per-page flags are going away in the next few years, so you're going to

For each 4k physical page frame, we need to keep track whether it is
secure or not.

A bit in struct page seems the most logical choice. If that's not
possible anymore, how would you propose we should do?

> need a new design.  s390 seems to do a lot of unusual things.  I wish

s390 is an unusual architecture. we are working on un-weirding our
code, but it takes time

> you'd talk to the rest of us more.

