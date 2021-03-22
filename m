Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79563343FB7
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 12:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCVL21 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 07:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhCVL2S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 07:28:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40AC061762
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:28:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f3so12328379lfu.5
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e/8Ps0Ktb6d68R+KN9li/esf+RWOsAy/QWgNl2bsjCg=;
        b=EXIvWEM18cSmSwMF/NB1QYMgQXYnrAag4u6ZyxRYqOysOZ9V6Zm1RNdryV2IlGQhw2
         Ek1Kn+1pJVjPc5i2lvcfFI5k3QCu6NcvbQd34nDfqC7MXLB2sx7xJT/iMTjTwAMSPSPG
         EpytFnGn5r4e+M/rQ7/RbKlvP/LGQ/fTBvKJP2mhAZ+asjdXIY/Y3P4Q2nPbZKNg4/JK
         OySk2OW6uCpL1EnTT1i1YnAIrmZbaaZaijiuZ9RzQCjh9bzYxOM7XKr/qB1DtK67OHYM
         fUV/7LwKJAMZhJzkgF+CQiAD33C7f9+AA6GTWj77+IMVPkM+YbXZr3GwLongwJzicHFD
         3tUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/8Ps0Ktb6d68R+KN9li/esf+RWOsAy/QWgNl2bsjCg=;
        b=SbYDVSMYFqw1jw8+EkxmUzeQXz9o+C8o7WcYTD735q59G9f4TjFGIhoohXK2HM6uAu
         KB/UYQZ3iaKzq9XJmjIuBplbnRYj2pTNBoebxhovnLVcjWjP1ZPHSX3Ik6baV3jy2D2r
         0JCrT8ZxBBkAEBc7gUhpUzRg5dIDcLHzODqfVwZdnf/pjREFb6ld/sh5ULT6Fw5Y3iJm
         cTQKipW4bsU1LoyTfDmx5tW32tuNTXFwTYd2jMRxBeuBG+1gYjk8OUd7rplYyCojSxFy
         4hZuKu0FVH0t+e1AOvV6ar5npyrQt8ErodstXQWQa4oO1DXcehxZxxsAJmOex5V4vs0d
         y4GA==
X-Gm-Message-State: AOAM531IsPQ5jyrPQMKY8S/tQ/xJm43Iaomp7V32c88at4hSZefxUPq9
        eKRE2FNnO7t5cQRQVd3YxaASKQ==
X-Google-Smtp-Source: ABdhPJyIwFAEyp7IPkXX7n5PmF14citdfeN2uquuXcJSKueq8Q3O6jUD8ynDjrBejl3pfA961ybqGw==
X-Received: by 2002:a05:6512:3ec:: with SMTP id n12mr9170901lfq.536.1616412496066;
        Mon, 22 Mar 2021 04:28:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q7sm1582895lfc.260.2021.03.22.04.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:28:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 02871101DEB; Mon, 22 Mar 2021 14:28:23 +0300 (+03)
Date:   Mon, 22 Mar 2021 14:28:22 +0300
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
Subject: Re: [PATCH v23 08/28] x86/mm: Move pmd_write(), pud_write() up in
 the file
Message-ID: <20210322112822.3uvkufcbdj7gtwxn@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-9-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:34AM -0700, Yu-cheng Yu wrote:
> To prepare the introduction of _PAGE_COW, move pmd_write() and
> pud_write() up in the file, so that they can be used by other
> helpers below.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
