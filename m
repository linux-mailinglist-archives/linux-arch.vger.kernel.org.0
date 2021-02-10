Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB07317089
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 20:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhBJTrQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 14:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhBJTrM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2021 14:47:12 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A919C06174A
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 11:46:32 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id j5so1902680pgb.11
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 11:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LOBexJVZl5O63ei2PKVTk/yEoofE8UPxbzZ4mG3AdFU=;
        b=TKGDKYbQHgIOPRKX8liktIsLemZyxUCEJfXoV6JuwuzbpfwUT19ClQa0tNbeh1kwjO
         peMEEpmUf/iJ9RMFYheTYcMNCbcH/fnYMVujd4ZvlaoHo7ETnnZNO/VAjDsY4D6U6AEl
         jJNufnxus0dZeQfIXmnTep06cZ8AGCzmOmAi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LOBexJVZl5O63ei2PKVTk/yEoofE8UPxbzZ4mG3AdFU=;
        b=Bdod/FwcZYRF/G4rpTHvR5iV3ptu4CWKE65zZ+HbYYWc0QyV1P6OZ16uq6ECVIVMqF
         N9tNzVCRWuCDHOV0qMJN1NU73W65jMY0LiXO7xgpWHVQF/4rCaOz6iRLxlHv29J5sfYy
         L79iS4AetvCOqqoiJcL7Tcxl+0MlmFAeBnb9l4XXfIt0lNAtVLsUDPJXgWI4Up89jXKY
         rCQPpRRk21R60DYaGIsoiLXrP6ypJ8KkpA3nHVB/PVew3LCplUqeBXCC14a558ARFWdk
         LExzEouQ0931noRQ7AAvlzYyROfeh2WPK/Q1kHGdBJYUTUKNeFf3OJXec31YwcvRB87n
         OICA==
X-Gm-Message-State: AOAM532Pyf86BjTh8ue0Ua9Rnx0tYH231DQtgHmhq+F9oUiOEja+qUkN
        RQ2KY2aRXNiRrg1lAslMPY3S+Q==
X-Google-Smtp-Source: ABdhPJzU36iPUZB59irH169GzgM6TNqXFDVT4lz6gU6IaKnXXV8mNiT8RQ8Q6WVoTQsGfLesTa299A==
X-Received: by 2002:a65:520d:: with SMTP id o13mr4568903pgp.57.1612986391981;
        Wed, 10 Feb 2021 11:46:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v23sm2966724pgo.43.2021.02.10.11.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:46:31 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:46:30 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com
Subject: Re: [PATCH v20 25/25] mm: Introduce PROT_SHSTK for shadow stack
Message-ID: <202102101145.7DE8B381@keescook>
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-26-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210175703.12492-26-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 10, 2021 at 09:57:03AM -0800, Yu-cheng Yu wrote:
> There are three possible options to create a shadow stack allocation API:
> an arch_prctl, a new syscall, or adding PROT_SHSTK to mmap()/mprotect().
> Each has its advantages and compromises.
> 
> An arch_prctl() is the least intrusive.  However, the existing x86
> arch_prctl() takes only two parameters.  Multiple parameters must be
> passed in a memory buffer.  There is a proposal to pass more parameters in
> registers [1], but no active discussion on that.
> 
> A new syscall minimizes compatibility issues and offers an extensible frame
> work to other architectures, but this will likely result in some overlap of
> mmap()/mprotect().
> 
> The introduction of PROT_SHSTK to mmap()/mprotect() takes advantage of
> existing APIs.  The x86-specific PROT_SHSTK is translated to VM_SHSTK and
> a shadow stack mapping is created without reinventing the wheel.  There are
> potential pitfalls though.  The most obvious one would be using this as a
> bypass to shadow stack protection.  However, the attacker would have to get
> to the syscall first.
> 
> Since arch_calc_vm_prot_bits() is modified, I have moved arch_vm_get_page
> _prot() and arch_calc_vm_prot_bits() to x86/include/asm/mman.h.
> This will be more consistent with other architectures.

This portion of the patch seems logically separate from the PROT_SHSTK
implementation. Can you please separate it into its own patch?

> 
> [1] https://lore.kernel.org/lkml/20200828121624.108243-1-hjl.tools@gmail.com/
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

With that done:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
