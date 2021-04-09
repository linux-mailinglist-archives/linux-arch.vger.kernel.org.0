Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3912035A1D8
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhDIPUZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhDIPUZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 11:20:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336CC061762
        for <linux-arch@vger.kernel.org>; Fri,  9 Apr 2021 08:20:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b14so10271855lfv.8
        for <linux-arch@vger.kernel.org>; Fri, 09 Apr 2021 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BdyCaKl/yFk8RKzHPOIXKxOU3yTB+9Fr3zs0DpkeLKM=;
        b=d1siBDnR6tbrwRIdnsNOlc6NmlCCox/2Jn4ypJ4KC81Y4bNAMgjMseR+/nK3e5VDbG
         ojFCJJRxN1mxXKbEGZsasX+fDSTeoQEYxDMWr46YxnysDD4NcxU+4OFO50nm+bM768nN
         FMyZWZ1hm/ZA3A2TvlUd0sx63vQnN+Z9j86KxWoKOTtHi7X6/dx8IYkx9RRGpCmlAZ+Z
         2Ix6jFhc1cuRHLwW+INfVp1hpN+g5OzC3yVQxSg3bk+t7q0l7kckXYGg4nkDrAE90Yv0
         yQ3EoPc/AqyVJuvCymv5CIaeZ8/5fKQXVzalMV2DSlXxNZGgxsfDnAcEbIvliAmXavWp
         KiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BdyCaKl/yFk8RKzHPOIXKxOU3yTB+9Fr3zs0DpkeLKM=;
        b=gOI7dCRgAhvU5n4urLMJCxbTgOUNWnS/eSNnKVG8fSeg98osHBlEs/j/WSmNuJDQIi
         NYhn8W4OSxG/9I3trSI4bgRxkE/UCyLa3uqJ5K5s5By7ctz6r11wimhMtW0Y2OLsidcY
         zB9Udtyq678teDTTVCmIbq8k5b4I0AgT918Gn7fM96fFoXaBwEfqUdCvJIkMMhjGu+NF
         QdBzRZE71gLwj85YSjZWVzNqXtRCsbFktPyS6nlk9TuKGZxGRVwvLP6nuCPxyK7UscjH
         kj7Mko1JEoomjInKxl/+/kzT6JmJK91oBw4XFGWxS9GksKABv1DyWvz3+WvGcPIXrc9P
         kiHA==
X-Gm-Message-State: AOAM530oqXa6C6S6+/gDks5hvBwtkNfo31jbhL2fU9bh8hp6C5ywEO7G
        /uG0WqWN3OP0m+eLu2nKPe+zhQ==
X-Google-Smtp-Source: ABdhPJyeY3SOcNghbUnFtmBYutviMO6rEuJWu8D3EaniZ1hk2GrTHZuB3RQ8/DjT6S0hr71xS0x82A==
X-Received: by 2002:a19:c46:: with SMTP id 67mr10560336lfm.369.1617981610479;
        Fri, 09 Apr 2021 08:20:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s2sm306117ljj.36.2021.04.09.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:20:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 740FE102498; Fri,  9 Apr 2021 18:20:09 +0300 (+03)
Date:   Fri, 9 Apr 2021 18:20:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v24 16/30] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <20210409152009.xyewe3eefxce2dqq@box.shutemov.name>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-17-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221104.31584-17-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:50PM -0700, Yu-cheng Yu wrote:
> When serving a page fault, maybe_mkwrite() makes a PTE writable if it is in
> a writable vma.  A shadow stack vma is writable, but its PTEs need
> _PAGE_DIRTY to be set to become writable.  For this reason, maybe_mkwrite()
> has been updated.
> 
> There are a few places that call pte_mkwrite() directly, but have the
> same result as from maybe_mkwrite().  These sites need to be updated for
> shadow stack as well.  Thus, change them to maybe_mkwrite():
> 
> - do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE directly
>   and call pte_mkwrite(), which is the same as maybe_mkwrite().  Change
>   them to maybe_mkwrite().
> 
> - In do_numa_page(), if the numa entry was writable, then pte_mkwrite()
>   is called directly.  Fix it by doing maybe_mkwrite().
> 
> - In change_pte_range(), pte_mkwrite() is called directly.  Replace it with
>   maybe_mkwrite().
> 
>   A shadow stack vma is writable but has different vma
> flags, and handled accordingly in maybe_mkwrite().
> 

Have you checked THP side? Looks like at least do_huge_pmd_numa_page()
needs adjustment, no?

-- 
 Kirill A. Shutemov
