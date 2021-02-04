Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3879630FE58
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbhBDU3d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbhBDU3E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:29:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58544C061794
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:28:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d2so2485693pjs.4
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IZXHMkkF5la794RToqIjRZW5Sf0o5ADpzH8P/DUSqM8=;
        b=WPv79kCio4eGaa+1n6kJbUiCr+03EUTatrYglWJE03qfeFrKHQzZVbBtF49ld+k4ze
         7lEEgOI28vEeRahv9M+5hNCWfrIKDpDdagm/LThs/rcnb6mqbDMlpyjeSuswWn5/cjQF
         8HEg8Q2Ubdq/QtSINwilr9Xr1IyuglpkxjnlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IZXHMkkF5la794RToqIjRZW5Sf0o5ADpzH8P/DUSqM8=;
        b=uZqCI+TXuxbbUNXq9TnQpfOmhKExnVyDjAOVDKmByTBiAUmAGHORPEBU+avxfWQCl5
         oCUzl/+XhiprR2fA/ec08m/u7dEXr4VrOI/Fcb7XtnyQbxya4eP++mpM4CEQXnx2uAVL
         xdhvErUtaLqaOQOpazCsHB8RJWFWzlZTiXCErumCrc6/g1768ahhoStBjPz3cNDYpgta
         CjGdwaqi6ukpx7uJl6B7cRvZ6hJYsdyvSkkh89zK5mZa5dBlk7peK2xQO+Y+cuLgGpea
         frExghTb8o1FbPYT0ek66uo/40hnNCXTtoiJN3LirPu3e32nVaYvcceL/wdvT49dVHr8
         PlYg==
X-Gm-Message-State: AOAM530Wgdi9fszAjoPSOLyHpWGllXIR1EnUw9AInOYObywQUYnam6Ll
        pBXyC+rXuaz5KvQIjJ3nhBs8fw==
X-Google-Smtp-Source: ABdhPJxaLK/3FaRcCdBuM/ynvQhoUqRuwNE06CjEMBKRxvH0MC7s6Ljyc3PQcHyuCfh0R5pvWUrRfw==
X-Received: by 2002:a17:90b:4d06:: with SMTP id mw6mr708971pjb.24.1612470488976;
        Thu, 04 Feb 2021 12:28:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b26sm6838438pfo.202.2021.02.04.12.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:28:08 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:28:07 -0800
From:   Kees Cook <keescook@chromium.org>
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
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v19 19/25] mm: Re-introduce vm_flags to do_mmap()
Message-ID: <202102041228.E6FED55C@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-20-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-20-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:41PM -0800, Yu-cheng Yu wrote:
> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> removed from the function's input by:
> 
>     commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
> 
> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
> do_mmap().  Re-introduce vm_flags to do_mmap(), but without the old wrapper
> do_mmap_pgoff().  Instead, make all callers of the wrapper pass a zero
> vm_flags to do_mmap().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
