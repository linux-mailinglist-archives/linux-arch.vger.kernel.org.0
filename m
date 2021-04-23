Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58211369056
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 12:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbhDWK1r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 06:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbhDWK1p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 06:27:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEF4C06138B
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 03:27:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y4so36571247lfl.10
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eWgAF6RQPL0b2x8b0Xdx/qwinLYytBxZ3RTzqyQw9+Q=;
        b=bkGdRfNnfy85o3qJkLv102MyP7pn4K3UpxeWrw33RGLg+1RUrWeCkMjX7a68IASh9K
         9wzf55FBQ/p6M5U32HxtpUch5JfX6evOwg7Z9EC6S+zFI3bLvRcxDxDN+xAHOkxZwIq1
         M1WP3vo6Mo/Y1pPSdKy4PHh5fYoQ4resPWoj4tp2E4pjP/dVNRz1h65VD6B05djccUfO
         2lOkZhqMBNjGiW5iC46LLvNl55o4IncIgfWkrGVBknc7Nfgc7eGCc363QGxQ7SHI+l9A
         lBTuyeynaCQEmtR1SO96RcUMq7y9QlmpTK61k5yeSEN2Drmyluw3He+Nd9tbhI8o5PQW
         Gvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWgAF6RQPL0b2x8b0Xdx/qwinLYytBxZ3RTzqyQw9+Q=;
        b=D8IRhc/jZ4rocZQI1FlNoA2b5T4ui4AkbSYUyzFUQ8TFTiPfpdpdTuqAF3EEfCDpyV
         f8JrBe5WgZFLyTZawpRlrOLU0xBrNXURdD4/dmxel0HqJeu8moeHxmqDLocrQInXOKp9
         j7zR6Cy7w0XA03xuuItxUZKAgkTAdUKCh2v3W5fL7bukmrgLOxPmRbT53VkfW9zpPzf8
         H7DkLsejZJomZ7VW1JzrEkTjggDUarzzL8ncdiJIh5lWQLpZ9wofYXnQt2qprcMKc5rh
         OYd5SWMOzKHekiAXfX2GQ7WszDoq9/w/Dwd1tlG+kU6MAeC5iSlT9D3leMqYuFFcvyVK
         b0Zg==
X-Gm-Message-State: AOAM531Wnxxlp4hol1fkmQ1TYmW5fIWFZN2mzlQrqBUZxvOFFQs49HrJ
        NCWfYGHTJQIhfdBjRXzmTAY3mw==
X-Google-Smtp-Source: ABdhPJxVdMtHaH4N7qrL7rs/iFLid0SiR/0I34D5a7seDxpN0PPppOm4pkZaxAKafv5e87oh9CjIYQ==
X-Received: by 2002:a05:6512:3c96:: with SMTP id h22mr2178504lfv.574.1619173627715;
        Fri, 23 Apr 2021 03:27:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z17sm511847lfd.87.2021.04.23.03.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:27:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E050010257F; Fri, 23 Apr 2021 13:27:08 +0300 (+03)
Date:   Fri, 23 Apr 2021 13:27:08 +0300
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
Subject: Re: [PATCH v25 20/30] mm/mprotect: Exclude shadow stack from
 preserve_write
Message-ID: <20210423102708.bau7z4xmgvtubl5y@box.shutemov.name>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-21-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415221419.31835-21-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 15, 2021 at 03:14:09PM -0700, Yu-cheng Yu wrote:
> In change_pte_range(), when a PTE is changed for prot_numa, _PAGE_RW is
> preserved to avoid the additional write fault after the NUMA hinting fault.
> However, pte_write() now includes both normal writable and shadow stack
> (RW=0, Dirty=1) PTEs, but the latter does not have _PAGE_RW and has no need
> to preserve it.
> 
> Exclude shadow stack from preserve_write test, and apply the same change to
> change_huge_pmd().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
