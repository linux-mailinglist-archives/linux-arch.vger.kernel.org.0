Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D271D619122
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 07:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiKDGdz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 02:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKDGdy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 02:33:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE9205C2;
        Thu,  3 Nov 2022 23:33:53 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A46TBaG007843;
        Fri, 4 Nov 2022 06:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DVozv4ww3RPgAifx8iLDCASk/cNq9WwNyTxXIFAOdb0=;
 b=sh3WaLpz0o8YwRtQncBs6tLt83uA6Si+IZYLXqxN8ZEG2nU7PU0SNLNwIm9/noMBo9EL
 /QZRw/ypiN8Y+oU1IwHN3tYbIeQSv2sbpASRcCDfYMYR1PU9h3VH2Qz2hBzPgr2Yx/rr
 5ar7J+BN4T6oQ7NnEILbQjywDhhZPQ+VybBZBsxLDtA/AmhCYic5kkhUPAZX2cOXJh8A
 SMWX0ZJfg1KJQlHkULTfBxiOy8+zHwVHcjAqVqiWOJm3WEbqf4BR3yayXPWOqUvmqnYt
 9qlyThUVvgEnm0r/c8Bswo8F/DeniIMxqpC9xN0nPuox0P0vlmgx1k7ZiW+rVSIX6BOS hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmq07jtcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 06:33:19 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A44g7gZ010675;
        Fri, 4 Nov 2022 06:33:19 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmq07jtbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 06:33:18 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A46KiUw009676;
        Fri, 4 Nov 2022 06:33:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3kguejfe7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 06:33:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A46XoWW51577136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Nov 2022 06:33:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A235F4C059;
        Fri,  4 Nov 2022 06:33:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65DC34C044;
        Fri,  4 Nov 2022 06:33:12 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.40.122])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  4 Nov 2022 06:33:12 +0000 (GMT)
Date:   Fri, 4 Nov 2022 07:33:10 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
Message-ID: <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
 <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
 <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4FNpXyGGRtv1khih7wgAOdB8NGiyES6G
X-Proofpoint-ORIG-GUID: oUVm0NIeVEvSk1VZrf3NeD5Pcsl8qKsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=921 mlxscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 31, 2022 at 11:43:30AM -0700, Linus Torvalds wrote:
[...]
> If people really want to see the patches in email again, I can do
> that, but most of you already have, and the changes are either trivial
> fixes or the s390 updates.
> 
> For the s390 people that I've now added to the participant list maybe
> the git tree is fine - and the fundamental explanation of the problem
> is in that top-most commit (with the three preceding commits being
> prep-work). Or that link to the thread about this all.

I rather have a question to the generic part (had to master the code quotting).

> static void clean_and_free_pages_and_swap_cache(struct encoded_page **pages, unsigned int nr)
> {
> 	for (unsigned int i = 0; i < nr; i++) {
> 		struct encoded_page *encoded = pages[i];
> 		unsigned int flags = encoded_page_flags(encoded);
> 		if (flags) {
> 			/* Clean the flagged pointer in-place */
> 			struct page *page = encoded_page_ptr(encoded);
> 			pages[i] = encode_page(page, 0);
> 
> 			/* The flag bit being set means that we should zap the rmap */

Why TLB_ZAP_RMAP bit is not checked explicitly here, like in s390 version?
(I assume, when/if ENCODE_PAGE_BITS is not TLB_ZAP_RMAP only, calling
page_zap_pte_rmap() without such a check would be a bug).

> 			page_zap_pte_rmap(page);
> 			VM_WARN_ON_ONCE_PAGE(page_mapcount(page) < 0, page);
> 		}
> 	}
> 
> 	/*
> 	 * Now all entries have been un-encoded, and changed to plain
> 	 * page pointers, so we can cast the 'encoded_page' array to
> 	 * a plain page array and free them
> 	 */
> 	free_pages_and_swap_cache((struct page **)pages, nr);
> }

Thanks!
