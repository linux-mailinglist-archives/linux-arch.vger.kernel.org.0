Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0331704A
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 20:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhBJTgT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 14:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhBJTfw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2021 14:35:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46478C0613D6
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 11:35:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q20so1942144pfu.8
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 11:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lVugRE6fF0oJTBQd7d0RHKP3QOjg3imenXxdGjYCNio=;
        b=FOurCcBoEOTC173g8WpQOh8MpvMQlo/WlTwQI/cXieTsGgI0OsJU6jFdMuPewnsA8x
         N+Lu45EOVe6MZGpC4MeQO9562gudu7ifC8x9TKKAd7WGRrJKzSki8Id6v4RZ3j9MW3T3
         T3kC9Rjk7f1qpSc/LzUtjVX0oVYUJoOrnsQ4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lVugRE6fF0oJTBQd7d0RHKP3QOjg3imenXxdGjYCNio=;
        b=MH4BSDpEIdy4AiNXZTbXOV1uZJsNHF/gxcAwcfMeA5TpnnqiRGG4HRKwIQdDN1s7y/
         VBVwhuDRgLUgK+hm4cB7lPVrNKySlcMBbCmseC4PHZX6m/1n/veHVjzfb4BL30nHbA2P
         XZj2ZzJQi2pVXDLKfnM3UK+TcUVibHyCQJXCr8wrWeLzVMC6SgeN8DN9LMJajLH7Qu9x
         /TdBqNKePS/AhAKjDnymRDjVss8wCk0mEBNtzpUeCXR5K8U4Zra5WzFgIpNaaNhB/HFr
         7I26AUIyqn0+bRseeOtoRWVeY5NcesAy1sUfxePhcaxpBMN9RTQb3e226areN9mClvX7
         lsqQ==
X-Gm-Message-State: AOAM532fNnFX5fzEZdquVeQz88eEYvId/3VfRsOvvRDATZLQw1ZNNKGW
        ZwR/10lgCgDXhqHr+Vd2LOLADA==
X-Google-Smtp-Source: ABdhPJyw/brekoVah28J4DYypOu+xfbWlmLb9xtdz4+0cBteusjYuV6Y5OvqRl1eOPZCqvkxSdOONQ==
X-Received: by 2002:a62:8445:0:b029:1c1:c862:8fc4 with SMTP id k66-20020a6284450000b02901c1c8628fc4mr4506463pfd.77.1612985702870;
        Wed, 10 Feb 2021 11:35:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u127sm3234989pfb.180.2021.02.10.11.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:35:02 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:35:01 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v20 07/25] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Message-ID: <202102101134.72F7495@keescook>
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210175703.12492-8-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 10, 2021 at 09:56:45AM -0800, Yu-cheng Yu wrote:
> The x86 family of processors do not directly create read-only and Dirty
> PTEs.  These PTEs are created by software.  One such case is that kernel
> read-only pages are historically setup as Dirty.
> 
> New processors that support Shadow Stack regard read-only and Dirty PTEs as
> shadow stack pages.  This results in ambiguity between shadow stack and
> kernel read-only pages.  To resolve this, removed Dirty from kernel read-
> only pages.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
