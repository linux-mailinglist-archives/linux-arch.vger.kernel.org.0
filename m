Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3536E04C
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 22:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbhD1Ub6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbhD1Ubz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 16:31:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3405C06138B
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 13:31:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c3so25783122pfo.3
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3hSpg15pn1DIdYpOUvqCiqtWYItHFsCiBWHhgVzIduI=;
        b=BkbeBwVw+8kNECD6Fty+KhB2F/UCVh05XwhcmlkxtMeFxAnK7zGdWcsac/9xp0+LIX
         QhDKeE0HJgN1UAjMxq9aw9nfBPmpRThrwcnkH4T+puZNHQ/z+cvGTjixSvIDru7sf04s
         rh4FBCLuTD4dbIHz7KjZ6We84KXuMRxzFeZgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3hSpg15pn1DIdYpOUvqCiqtWYItHFsCiBWHhgVzIduI=;
        b=kSEx857y87VU1LYsukSLl8RmALNIqQxrtQ25GFJMAq7BTRXsI12XToU8uCwoLruWRY
         ifFqzw8vpSOztO7hJAQG0A1uCLf2xh3QuPiaqYSMSvtMayyUGo1FcnyYdPd5iWzPgUh8
         kAaLSufePOWlMgfk3xspUY5z79UTa1khiYUNmzTOKUP7lUC+neOdOacUPrvF1EPEGEWi
         hIK8Rkzlmx0zUmaE4PiB0kadvqpAu5DLBlhB864u+V2BcXtBqd/611Q5/iq1zwh8kicn
         WLQUDfKSnlbcOVy039IcTW7qx5RLmFL6x1hvddHC5kuSykrMo6F/6FSaj156LJsQfLuI
         x6eg==
X-Gm-Message-State: AOAM533d7vqn9kPL5ANpfbx9PWfZYEs3ZDENL7UD33wSGW+C6eu5lIt2
        rz1XeqzqmcpwKfoHlIvqOIPWuA==
X-Google-Smtp-Source: ABdhPJwCKd2mYh14iAXFwA+maLNCPvFw4QLlsMbajfD2OFtjkT8lLbxJACSI1jhHg7cX9+DygGbR1w==
X-Received: by 2002:a63:6486:: with SMTP id y128mr10004830pgb.414.1619641868603;
        Wed, 28 Apr 2021 13:31:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oj6sm5513649pjb.5.2021.04.28.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:31:08 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:31:07 -0700
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 3/9] x86/cet/ibt: Handle signals for Indirect Branch
 Tracking
Message-ID: <202104281331.C09D5479E@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-4-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:14PM -0700, Yu-cheng Yu wrote:
> When an indirect CALL/JMP instruction is executed and before it reaches
> the target, it is in 'WAIT_ENDBR' status, which can be read from
> MSR_IA32_U_CET.  The status is part of a task's status before a signal is
> raised and preserved in the signal frame.  It is restored for sigreturn.
> 
> IBT state machine is described in Intel SDM Vol. 1, Sec. 18.3.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
