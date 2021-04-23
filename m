Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A396369047
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbhDWK0C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 06:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbhDWK0A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 06:26:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7479BC06138B
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 03:25:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u4so55150637ljo.6
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJZaoWdkeQnUY9j6J7eTKZgTjYGHKGB6/6rEdFFQe98=;
        b=beqpNJ72OzZmv/fLA2ZCJ0G+pFLU09kepwTJi9zuvZV9ZZfR6NqBDeUdERxay9IpJi
         zkoMXRfzGU7/Hh9oDtQLf+gdrfHvoybEAVpjZdXuPvgl+94Lomf0Ca8unCBSlxxFa79Q
         FFmxK/3sKRFInYb4TH/aaZ9PPl2S+gWDgAlfFq18/7Ho3MxPfkeg5oU2vXMp7JUFteWE
         ICno5wkW5Apo4SJ4ICaICYwM0+pO05z6dVbJ6En6ddlSmqUP/OC1AqCBmxQNkQzryHl4
         vsBMKv/DS26j3TmEvEDNFsO9HgB9aNj6R03WGritQpz4vtz6ruLqWC6znDQms2cFAYDf
         4eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJZaoWdkeQnUY9j6J7eTKZgTjYGHKGB6/6rEdFFQe98=;
        b=te5TCq3364ZD8epNh2rq3/BSpkBfTsXStMG7v/j5AqOhF+lA8X3hms27WTQ9w3A3xB
         9YlFUwW3fYgcL/ZtUOSAhttjfUVzGNUZTAbZtGVRujJ8+6beCBOLxs1GWofOCKzOVYDf
         lk+57+nV7Zu7Ti7Wl8b5tg9ziXVS6SuyXg+QoEDzvg2qxyVU94AiSr3Dz2v79884eO0Z
         VeraN/rayD0xFExUc8fpyo8LddYUbWc2p+s7sLS+JCGkOgOEq6LsgIVe3tDFxiXzDmT6
         Wfg5RzMxpsQLky+ohirsTqV0gYvyTJcD2RH0aCKU8o+n/SORYVWxaf7laCa+0A6clhVK
         VVgg==
X-Gm-Message-State: AOAM531YVEgRLErXBH7G/UocgfrKgnN4qs3RDTtL6C2EggjS7hasoq0P
        4PQx+i3snaduxDTfLgYc2U6KTQ==
X-Google-Smtp-Source: ABdhPJzIcrcI4iYy/9BQUawjsw2eG72nBMivEh8e9Qpb7Hx+7AlNV8Wp+OHqNTBLn+PgjLSjWrvKaQ==
X-Received: by 2002:a2e:9c01:: with SMTP id s1mr2266581lji.402.1619173521574;
        Fri, 23 Apr 2021 03:25:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a11sm515574ljn.76.2021.04.23.03.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:25:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 983F310257F; Fri, 23 Apr 2021 13:25:22 +0300 (+03)
Date:   Fri, 23 Apr 2021 13:25:22 +0300
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
Subject: Re: [PATCH v25 19/30] mm: Update can_follow_write_pte() for shadow
 stack
Message-ID: <20210423102522.5djgt2fb3unsidnw@box.shutemov.name>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-20-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415221419.31835-20-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 15, 2021 at 03:14:08PM -0700, Yu-cheng Yu wrote:
> Can_follow_write_pte() ensures a read-only page is COWed by checking the
> FOLL_COW flag, and uses pte_dirty() to validate the flag is still valid.
> 
> Like a writable data page, a shadow stack page is writable, and becomes
> read-only during copy-on-write, but it is always dirty.  Thus, in the
> can_follow_write_pte() check, it belongs to the writable page case and
> should be excluded from the read-only page pte_dirty() check.  Apply
> the same changes to can_follow_write_pmd().
> 
> While at it, also split the long line into smaller ones.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> v25:
> - Split long line into smaller ones.
> v24:
> - Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().
> 
>  mm/gup.c         | 16 ++++++++++++----
>  mm/huge_memory.c | 16 ++++++++++++----
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ef7d2da9f03f..f2813cf4d07b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -356,10 +356,18 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>   * FOLL_FORCE can write to even unwritable pte's, but only
>   * after we've gone through a COW cycle and they are dirty.
>   */
> -static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
> +static inline bool can_follow_write_pte(pte_t pte, unsigned int flags,
> +					vm_flags_t vm_flags)
>  {

It might be cleaner to pass down vma pointer and dereference it within the
function: can_follow_write_pte(vma, pte, gup_flags).

Otherwise looks good to me:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
