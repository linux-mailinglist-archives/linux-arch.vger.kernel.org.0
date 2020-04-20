Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05EB1B1165
	for <lists+linux-arch@lfdr.de>; Mon, 20 Apr 2020 18:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgDTQUf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Apr 2020 12:20:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbgDTQUf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Apr 2020 12:20:35 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KG3DmY022366
        for <linux-arch@vger.kernel.org>; Mon, 20 Apr 2020 12:20:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu601c4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 20 Apr 2020 12:20:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Mon, 20 Apr 2020 17:19:49 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Apr 2020 17:19:43 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03KGKPl455509026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 16:20:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E70A842042;
        Mon, 20 Apr 2020 16:20:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D9874203F;
        Mon, 20 Apr 2020 16:20:24 +0000 (GMT)
Received: from thinkpad (unknown [9.145.190.22])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 16:20:24 +0000 (GMT)
Date:   Mon, 20 Apr 2020 18:20:23 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zhenyu Ye <yezhenyu2@huawei.com>, npiggin@gmail.com,
        will.deacon@arm.com, mingo@kernel.org,
        torvalds@linux-foundation.org, Vasily Gorbik <gor@linux.ibm.com>,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arm@kernel.org, xiexiangyou@huawei.com,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [RFC][Qusetion] the value of cleared_(ptes|pmds|puds|p4ds) in
 struct mmu_gather
In-Reply-To: <68affa6e-44cd-37e3-cdfc-8eec31c4097e@de.ibm.com>
References: <fbb00ac0-9104-8d25-f225-7b3d1b17a01f@huawei.com>
        <20200330121654.GL20696@hirez.programming.kicks-ass.net>
        <68affa6e-44cd-37e3-cdfc-8eec31c4097e@de.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042016-4275-0000-0000-000003C366E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042016-4276-0000-0000-000038D8E918
Message-Id: <20200420182023.6b8e143a@thinkpad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_05:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=757
 suspectscore=2 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200131
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 8 Apr 2020 10:51:59 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

[...]
> 
> adding Gerald and Vasily. Gerald can you have a look?
> 
> >>
> >>
> >> In my view, the cleared_(ptes|pmds|puds) and (pte|pmd|pud)_free_tlb
> >> correspond one-to-one.  So we should set cleared_ptes in pte_free_tlb(),
> >> then use it when needed.
> > 
> > So pte_free_tlb() clears a table of PTE entries, or a PMD level entity,
> > also see free_pte_range(). So the generic code makes sense to me. The
> > PTE level invalidations will have happened on tlb_remove_tlb_entry().
> > 
> >> I'm very confused about this. Which is wrong? Or is there something
> >> I understand wrong?
> > 
> > I agree the s390 case is puzzling, Martin does s390 need a PTE level
> > invalidate for removing a PTE table or was this a mistake?
> > 

Peter is right, the PTE level invalidations will happen before. For
s390, not exactly at the tlb_remove_tlb_entry() itself, since
__tlb_remove_tlb_entry() is not defined, but rather directly at the
preceding ptep_get_and_clear(). I think this also the reason why we
cannot easily optimize for larger granularity.

Anyway, pte_free_tlb() will then later only take care of freeing
the page table page, no further PTE level clearing/invalidation
needed. I see no reason why s390 should behave differently from
the generic code, wrt to cleared_pxds setting in pxd_free_tlb().

So I guess this was an "off-by-one" mistake in commit 9de7d833e3708
("s390/tlb: Convert to generic mmu_gather"), since the other
pxd_free_tlb() functions also show similar puzzling behavior.
Not consistently off-by-one though, as pmd_free_tlb() seems
to behave correctly, setting tlb->cleared_puds = 1, similar to
generic code.

That was a very nice catch, Zhenyu, thanks for reporting!
We are not yet making use of the tlb->cleared_pxds for s390, but
we would certainly have stumbled over this if we ever tried.
Will send a patch to make s390 behave like generic code here.

Regards,
Gerald

