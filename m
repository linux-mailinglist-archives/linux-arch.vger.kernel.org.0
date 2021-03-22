Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCBA343FD5
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 12:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCVLbm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 07:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhCVLbP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 07:31:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8166C061574
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:31:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f3so12341713lfu.5
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W1w9xIW1N250EUFGaucw8NiWDfeMcMLKF9xerDg59Sg=;
        b=c8J6d+uJpziOInuiIgF76cKwKfjWpAdkplio0YS0yU0VhpyjuGkexA0TobTPHyIjJr
         trsjfvWByIY/pi+0UcM2oqIF7zijUwZs0dfE3o5z9zzGgEnuG0pzidW8HOSfnDZHaMX1
         Bb32BHW+e7ySRAd8v8+mq/XRcXflQxECYQ/6xQsXU2cjXPiQ8eypqlS/m0VaH+YfL0+M
         4pl/aE7uJGtdjjy2pjq7drs/mHGYw1XxrFx+diLJRzr3olG9nyezX7top3qh2FK/Px9Z
         PDWIgxpHu++lZV7p0y83RURtTNJifTURhS11QivpmZYQeWNxVhlB6Mg4D9wVuNNDilSw
         P5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W1w9xIW1N250EUFGaucw8NiWDfeMcMLKF9xerDg59Sg=;
        b=ZtvVHZBrjQaK5jztMoBKEW/3elx3H+GlCCnZtKusF7NGmNuqWcKh85ajG+e2ROEauY
         IsTeRqEYHSKHBkuE6GEL8Lrc6VkncpqOGmboT97R4GR0Mw70orjrL0H1O+W5S1OGtBGk
         nPtUAlte+YKhi7lgjOpuu6odVmL+NMKULhn2n2E2W1kVfDgvBqUhthO8bd0n9p6JQpg3
         Vk6pR5FgTcwDpi9foTjNqGfb705heZ0J6i3n0JWi5WL+Q1mA5zUCZVRp7mD4avhg+0U2
         V9D/VQIYPzbeXFz94aLw7QFf3ZavSjJOAO8EEO7C0WKNYVV1sd0SVs51PKW07+vwiIlu
         ciEg==
X-Gm-Message-State: AOAM533ASn/gUQTLS6kP4d8zAnIT6P8XC/Wo1dHCSXMWUfrs0YYW7s5R
        42e3UEEzkS6sA7v9D2lB7hLn6Q==
X-Google-Smtp-Source: ABdhPJxx6w/IrkyzNZNe9wJX93bhPJOm2+KsH61p1K12gRn3V/V44NNZfa5MrvxW018BX205rCWNNw==
X-Received: by 2002:ac2:41c5:: with SMTP id d5mr8760075lfi.459.1616412673497;
        Mon, 22 Mar 2021 04:31:13 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p22sm1546237lfh.113.2021.03.22.04.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:31:13 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 87326101DEB; Mon, 22 Mar 2021 14:31:20 +0300 (+03)
Date:   Mon, 22 Mar 2021 14:31:20 +0300
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 11/28] x86/mm: Update pte_modify for _PAGE_COW
Message-ID: <20210322113120.4qloiyj4ojmiis6n@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-12-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-12-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:37AM -0700, Yu-cheng Yu wrote:
> The read-only and Dirty PTE has been used to indicate copy-on-write pages.
> However, newer x86 processors also regard a read-only and Dirty PTE as a
> shadow stack page.  In order to separate the two, the software-defined
> _PAGE_COW is created to replace _PAGE_DIRTY for the copy-on-write case, and
> pte_*() are updated.
> 
> Pte_modify() changes a PTE to 'newprot', but it doesn't use the pte_*().
> Introduce fixup_dirty_pte(), which sets a dirty PTE, based on _PAGE_RW,
> to either _PAGE_DIRTY or _PAGE_COW.
> 
> Apply the same changes to pmd_modify().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
