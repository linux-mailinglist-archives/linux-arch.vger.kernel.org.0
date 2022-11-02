Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F326170AF
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 23:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKBWal (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 18:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKBWak (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 18:30:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1AA95A6;
        Wed,  2 Nov 2022 15:30:39 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2MMjMm026692;
        Wed, 2 Nov 2022 22:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=9bcvBNVAtfWLhzk+C7N9ZU35vBoa+nKNpCdOWBorsPQ=;
 b=F6JepXmZF6InnQfiXLpRCD45SFK0dRMYASUNqr3WS0Ls4Uojbm+kk2tuAYhpJGdsN3sk
 oPVaAW9mltuK3t6QE8B1VDnnNJQiiaxsc6q8NI5vpBrgRU9n389BsvADlT5AyPwojGIT
 s+lHXIHlLOeZrBn6a/qDDYLszKYJDvI4sE0E3m9XUc6S2G1euhrCfcaWTrz/+ZPTSslA
 tskqzYPOg9iIgbEJk1TWNwAbrmRjTXuYulwDoRChJLzt9qlyoCHIwifLguYEIEK08JUt
 DH9wVYdkr2nA7uFhYWpVaW6gTXZ3uS2iShFjtc9vJDwxBM8u7+r/IJJagZQp/gGTZmqs 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km19v04av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 22:30:08 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2MMnqq027183;
        Wed, 2 Nov 2022 22:30:08 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km19v048j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 22:30:08 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2MKcvw018509;
        Wed, 2 Nov 2022 22:30:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut97mx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 22:30:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2MU1RZ16319110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 22:30:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7415FA404D;
        Wed,  2 Nov 2022 22:30:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6489DA4040;
        Wed,  2 Nov 2022 22:30:00 +0000 (GMT)
Received: from thinkpad (unknown [9.171.6.109])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  2 Nov 2022 22:30:00 +0000 (GMT)
Date:   Wed, 2 Nov 2022 23:29:58 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: mm: delay rmap removal until after TLB flush
Message-ID: <20221102232958.3f5eaa53@thinkpad>
In-Reply-To: <CAHk-=wja5+tuvbV6vzJSbLBWSR8--WUq-ss0j0K-JQXe_EsqhQ@mail.gmail.com>
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
        <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
        <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
        <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
        <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
        <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
        <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
        <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
        <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
        <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
        <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
        <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
        <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
        <50458458-9b57-aa5a-0d67-692cc4dbf2ad@linux.ibm.com>
        <CAHk-=wja5+tuvbV6vzJSbLBWSR8--WUq-ss0j0K-JQXe_EsqhQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x6KDpMx1-hZ1Wv6Lmf2TD7IsfYnRJzO5
X-Proofpoint-GUID: 5beV_M9V3vzREGfV2fcnorJeJPYJUuNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=712
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2 Nov 2022 10:55:10 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Nov 2, 2022 at 2:15 AM Christian Borntraeger
> <borntraeger@linux.ibm.com> wrote:
> >
> > It certainly needs a build fix for s390:
> >
> > In file included from kernel/sched/core.c:78:
> > ./arch/s390/include/asm/tlb.h: In function '__tlb_remove_page_size':
> > ./arch/s390/include/asm/tlb.h:50:17: error: implicit declaration of function 'page_zap_pte_rmap' [-Werror=implicit-function-declaration]
> >     50 |                 page_zap_pte_rmap(page);
> >        |                 ^~~~~~~~~~~~~~~~~
> 
> Hmm. I'm not sure if I can add a
> 
>    #include <linux/rmap.h>
> 
> to that s390 asm header file without causing more issues.
> 
> The minimal damage would probably be to duplicate the declaration of
> page_zap_pte_rmap() in the s390 asm/tlb.h header where it is used.
> 
> Not pretty to have two different declarations of that thing, but
> anything that then includes both <asm/tlb.h> and <linux/rmap.h> (which
> is much of mm) would then verify the consistency of  them.
> 
> So I'll do that minimal fix and update that branch, but if s390 people
> end up having a better fix, please holler.

It compiles now with your duplicate declaration, but adding the #include
also did not cause any damage, so that should also be OK.
