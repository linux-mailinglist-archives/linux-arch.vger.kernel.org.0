Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A524F5202C2
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbiEIQpq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 12:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbiEIQpp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 12:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8ADE1C5FB5
        for <linux-arch@vger.kernel.org>; Mon,  9 May 2022 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652114505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46wpjVCZhJPBmgWeRQ9uBt+Od81o8qIGqdyqzSCTbIU=;
        b=JeETDsMEypPXoCbhMDCa+O3IBoSCrTKGO0VF+qyxMrTnCd+PRERsIAnsnFww2ERFkTskcE
        jOX/3TfEjfJgImkU0e7Je6ySx8psTtD68Q+v1sW3ahycrUrerv1+H7xdinh7T8hGnEcuaI
        RYVZdm0CK6tq2y4UTmGRzdmIauP7d8c=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-pl2NMjjsPNaZAI4BzxotAg-1; Mon, 09 May 2022 12:41:44 -0400
X-MC-Unique: pl2NMjjsPNaZAI4BzxotAg-1
Received: by mail-il1-f200.google.com with SMTP id i15-20020a056e0212cf00b002cf3463ed24so7937488ilm.0
        for <linux-arch@vger.kernel.org>; Mon, 09 May 2022 09:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46wpjVCZhJPBmgWeRQ9uBt+Od81o8qIGqdyqzSCTbIU=;
        b=ce1zOgYwgk01xky1sI/7xLDSOyeNEmPdWTdsRsRJ0VxUV7SdAi8byyMELR11gKJnDe
         2z2muHUGU/C16peyFM537AzhA0nYWFWpmzYTYty2raDj0CBfXA2zKweL52zL3spWNnlw
         jDJQyp/50rHSOj/5ZMvZD/jbl0nivqpOP0TANxzzJ4wSsl7OYEjObJUFokgnrwCVb3Bt
         uSoiGFq5RjEHRolhzmkfZM60fSB+Ba9aYIkHjRfH50goizoXV9/258WYMcHBJlwKDb1j
         PdKzpBkwUbLfJdmkkqtd5UjbUiAPqUilp9NQGPAN+PUpiJ+aL4PJ8MzkkB6YL6mdXKgu
         SNRA==
X-Gm-Message-State: AOAM531Kv9CR0YK4aG2Pm7s2lX3AdGFaKuwFuhF9Ljj1n25U9Jt7jeK3
        QBGiMwP6eLW73u+JCeZ+If+hi7LJTNB3OGIrJPqfLnYkLvh7SQ1ibQBjKeWUGfgqKEUTaGfYWJa
        qeMTJr9aKyHDJ1SjNa7XqLw==
X-Received: by 2002:a05:6e02:164e:b0:2cf:82bc:6c76 with SMTP id v14-20020a056e02164e00b002cf82bc6c76mr6451778ilu.95.1652114503282;
        Mon, 09 May 2022 09:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE3U4JsTh97DMqQwaSKR+J9MOnj5nTpGNATaHacf1CibJGqYaNUSWSiHqNy5VvKai+5PTu/Q==
X-Received: by 2002:a05:6e02:164e:b0:2cf:82bc:6c76 with SMTP id v14-20020a056e02164e00b002cf82bc6c76mr6451741ilu.95.1652114503011;
        Mon, 09 May 2022 09:41:43 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id x26-20020a6bfe1a000000b0065a48a57f6dsm3633311ioh.40.2022.05.09.09.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:41:42 -0700 (PDT)
Date:   Mon, 9 May 2022 12:41:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Subject: Re: [PATCH 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 unmapping
Message-ID: <YnlEQvipCM6hnIYT@xz-m1.local>
References: <cover.1651216964.git.baolin.wang@linux.alibaba.com>
 <c91e04ebb792ef7b72966edea8bd6fa2dfa5bfa7.1651216964.git.baolin.wang@linux.alibaba.com>
 <20220429220214.4cfc5539@thinkpad>
 <bcb4a3b0-4fcd-af3a-2a2c-fd662d9eaba9@linux.alibaba.com>
 <20220502160232.589a6111@thinkpad>
 <48a05075-a323-e7f1-9e99-6c0d106eb2cb@linux.alibaba.com>
 <20220503120343.6264e126@thinkpad>
 <927dfbf4-c899-b88a-4d58-36a637d611f9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <927dfbf4-c899-b88a-4d58-36a637d611f9@oracle.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 06, 2022 at 12:07:13PM -0700, Mike Kravetz wrote:
> On 5/3/22 03:03, Gerald Schaefer wrote:
> > On Tue, 3 May 2022 10:19:46 +0800
> > Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> >> On 5/2/2022 10:02 PM, Gerald Schaefer wrote:

[...]

> >> Please see previous code, we'll use the original pte value to check if 
> >> it is uffd-wp armed, and if need to mark it dirty though the hugetlbfs 
> >> is set noop_dirty_folio().
> >>
> >> pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
> > 
> > Uh, ok, that wouldn't work on s390, but we also don't have
> > CONFIG_PTE_MARKER_UFFD_WP / HAVE_ARCH_USERFAULTFD_WP set, so
> > I guess we will be fine (for now).
> > 
> > Still, I find it a bit unsettling that pte_install_uffd_wp_if_needed()
> > would work on a potential hugetlb *pte, directly de-referencing it
> > instead of using huge_ptep_get().
> > 
> > The !pte_none(*pte) check at the beginning would be broken in the
> > hugetlb case for s390 (not sure about other archs, but I think s390
> > might be the only exception strictly requiring huge_ptep_get()
> > for de-referencing hugetlb *pte pointers).

We could have used is_vm_hugetlb_page(vma) within the helper so as to
properly use either generic pte or hugetlb version of pte fetching.  We may
want to conditionally do set_[huge_]pte_at() too at the end.

I could prepare a patch for that even if it's not really anything urgently
needed. I assume that won't need to block this patchset since we need the
pteval for pte_dirty() check anyway and uffd-wp definitely needs it too.

Thanks,

-- 
Peter Xu

