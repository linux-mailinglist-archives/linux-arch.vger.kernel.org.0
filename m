Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33646170B7
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 23:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiKBWbx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 18:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiKBWbu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 18:31:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D0865E3;
        Wed,  2 Nov 2022 15:31:49 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2M098E006615;
        Wed, 2 Nov 2022 22:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fky39m8nQf+woEzTA5Y8KhT4xAJLqTECx7ts/LTg4G4=;
 b=hXwFwRKAeqvSDFD5Nk1JgKFrocDY4NdkLTQvSIhEDBLQgIjDS1ngH6wfDIrgWtFolcSe
 NV7qW1lGbXVgIU5Rz6eClk2EH5SOeK96lf/NF1EUVlCOY5movL5MThg9tIdOIGviFGQh
 T7pbvAaLo+sJrR+CyF/77hACPMkKTKk7ziorKUNIZEB4P6NOoK5aPTSvK9hp6pRJar3O
 yB1VraUNRXYhkz9FGH9Ox1EUNeSSPlM0GHfQzMdZCC1xaSj2ziUEAMQjWJejAQLrTfP9
 Cw6XSmQnXVuezfJgjcnkF6xSWh34T9oTuC0mxVxH0F4138vx93iUdkuWYvU+0CR2OZki Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkxvkvdg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 22:31:36 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2MIrvM024935;
        Wed, 2 Nov 2022 22:31:36 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkxvkvdew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 22:31:35 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2MKD66009030;
        Wed, 2 Nov 2022 22:31:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3kgut8npwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 22:31:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2MVUuj33620256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 22:31:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91DC011C06F;
        Wed,  2 Nov 2022 22:31:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8939211C06E;
        Wed,  2 Nov 2022 22:31:29 +0000 (GMT)
Received: from thinkpad (unknown [9.171.6.109])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  2 Nov 2022 22:31:29 +0000 (GMT)
Date:   Wed, 2 Nov 2022 23:31:27 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
Message-ID: <20221102233127.423a6112@thinkpad>
In-Reply-To: <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
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
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -Hwy5sQnZ-UsY13arSJV7ojGnJ2nPK57
X-Proofpoint-GUID: PdCd33Glyi7_bnQwqUmI7VO4EjOPpWd2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 31 Oct 2022 11:43:30 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Updated subject line, and here's the link to the original discussion
> for new people:
> 
>     https://lore.kernel.org/all/B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com/
> 
> On Mon, Oct 31, 2022 at 10:28 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ok. At that point we no longer have the pte or the virtual address, so
> > it's not going to be exactly the same debug output.
> >
> > But I think it ends up being fairly natural to do
> >
> >         VM_WARN_ON_ONCE_PAGE(page_mapcount(page) < 0, page);
> >
> > instead, and I've fixed that last patch up to do that.
> 
> Ok, so I've got a fixed set of patches based on the feedback from
> PeterZ, and also tried to do the s390 updates for this blindly, and
> pushed them out into a git branch:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=mmu_gather-race-fix
> 
> If people really want to see the patches in email again, I can do
> that, but most of you already have, and the changes are either trivial
> fixes or the s390 updates.
> 
> For the s390 people that I've now added to the participant list maybe
> the git tree is fine - and the fundamental explanation of the problem
> is in that top-most commit (with the three preceding commits being
> prep-work). Or that link to the thread about this all.
> 
> That top-most commit is also where I tried to fix things up for s390
> that uses its own non-gathering TLB flush due to
> CONFIG_MMU_GATHER_NO_GATHER.
> 
> NOTE NOTE NOTE! Unlike my regular git branch, this one may end up
> rebased etc for further comments and fixes. So don't consider that
> stable, it's still more of an RFC branch.
> 
> At a minimum I'll update it with Ack's etc, assuming I get those, and
> my s390 changes are entirely untested and probably won't work.
> 
> As far as I can tell, s390 doesn't actually *have* the problem that
> causes this change, because of its synchronous TLB flush, but it
> obviously needs to deal with the change of rmap zapping logic.

Correct, we need to flush already when we change a PTE, which is
done in ptep_get_and_clear() etc. Only exception would be lazy
flushing when only one active thread is attached, then we would
flush later in flush_tlb_mm/range(), or as soon as another thread
is attached (IIRC).

So it seems straight forward to just call page_zap_pte_rmap()
from our private __tlb_remove_page_size() implementation.

Just wondering a bit why you did not also add the
VM_WARN_ON_ONCE_PAGE(page_mapcount(page) < 0, page), like
in the generic change.

Acked-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com> # s390
