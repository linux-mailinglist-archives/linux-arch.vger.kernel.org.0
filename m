Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71247520AA3
	for <lists+linux-arch@lfdr.de>; Tue, 10 May 2022 03:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiEJBbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 21:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiEJBbh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 21:31:37 -0400
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F9154B0C;
        Mon,  9 May 2022 18:27:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0VCo8GaE_1652146048;
Received: from 30.15.214.13(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCo8GaE_1652146048)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 09:27:31 +0800
Message-ID: <86671cb8-51e7-0e8e-430a-a325887391b3@linux.alibaba.com>
Date:   Tue, 10 May 2022 09:28:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 unmapping
To:     Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, tsbogend@alpha.franken.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1651216964.git.baolin.wang@linux.alibaba.com>
 <c91e04ebb792ef7b72966edea8bd6fa2dfa5bfa7.1651216964.git.baolin.wang@linux.alibaba.com>
 <20220429220214.4cfc5539@thinkpad>
 <bcb4a3b0-4fcd-af3a-2a2c-fd662d9eaba9@linux.alibaba.com>
 <20220502160232.589a6111@thinkpad>
 <48a05075-a323-e7f1-9e99-6c0d106eb2cb@linux.alibaba.com>
 <20220503120343.6264e126@thinkpad>
 <927dfbf4-c899-b88a-4d58-36a637d611f9@oracle.com>
 <YnlEQvipCM6hnIYT@xz-m1.local>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YnlEQvipCM6hnIYT@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/10/2022 12:41 AM, Peter Xu wrote:
> On Fri, May 06, 2022 at 12:07:13PM -0700, Mike Kravetz wrote:
>> On 5/3/22 03:03, Gerald Schaefer wrote:
>>> On Tue, 3 May 2022 10:19:46 +0800
>>> Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>> On 5/2/2022 10:02 PM, Gerald Schaefer wrote:
> 
> [...]
> 
>>>> Please see previous code, we'll use the original pte value to check if
>>>> it is uffd-wp armed, and if need to mark it dirty though the hugetlbfs
>>>> is set noop_dirty_folio().
>>>>
>>>> pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
>>>
>>> Uh, ok, that wouldn't work on s390, but we also don't have
>>> CONFIG_PTE_MARKER_UFFD_WP / HAVE_ARCH_USERFAULTFD_WP set, so
>>> I guess we will be fine (for now).
>>>
>>> Still, I find it a bit unsettling that pte_install_uffd_wp_if_needed()
>>> would work on a potential hugetlb *pte, directly de-referencing it
>>> instead of using huge_ptep_get().
>>>
>>> The !pte_none(*pte) check at the beginning would be broken in the
>>> hugetlb case for s390 (not sure about other archs, but I think s390
>>> might be the only exception strictly requiring huge_ptep_get()
>>> for de-referencing hugetlb *pte pointers).
> 
> We could have used is_vm_hugetlb_page(vma) within the helper so as to
> properly use either generic pte or hugetlb version of pte fetching.  We may
> want to conditionally do set_[huge_]pte_at() too at the end.
> 
> I could prepare a patch for that even if it's not really anything urgently
> needed. I assume that won't need to block this patchset since we need the
> pteval for pte_dirty() check anyway and uffd-wp definitely needs it too.

OK. Thanks Peter.
