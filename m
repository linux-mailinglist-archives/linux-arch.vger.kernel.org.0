Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE1730FDDF
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhBDTy2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 14:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239573AbhBDTxf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 14:53:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC2C061793
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 11:52:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e9so2443694pjj.0
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 11:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T9AG0M0o5O+h9fP2xKRDxPlB8Ctdkqhf6o2D4rpy6+g=;
        b=RAOV7LdWTzqKAFqnvxTN/A7FE6XLME1YD2+exfJflocSTPK0YEmGOdX5o134MKOn3w
         3e132GGs/Rrn66muOUOTMHl/0FdfpJXiSp02skj/T7NO8geQxKHEM/K26V1fSG8W0vFq
         6AlcCB7zV3dWnr4cjWNj2b1nXANmZXfVYAjcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T9AG0M0o5O+h9fP2xKRDxPlB8Ctdkqhf6o2D4rpy6+g=;
        b=M9+5W4riCSl0o9ENls0xZpoIfUOz6oaBzIrcs7b9Vhs2tC1ojcwV9Z8ykI4+Zb/9s0
         5A7/222GIUS/SsS+OR0tkZCx5oxea9tZ01Gu/owTRlimynSif8DhbWyPyGmI9ye9HQSL
         Mcq4b2UXJ3nzMfMe9Lm6tyKcCuwYbiTyWDOZPZwktvUCM+poyq+etD8FFCO0QD0x5nV9
         wasSaDj/WXvBq6+tJbAGgnd+1MFo3N2jNaeaEAHn7OjIEHOAdESt0ga4lixO2TF2IVte
         I0hLhJpLGr1iVRhrv8QHZaBWKyvadyK/CCHyi9TryfFSmcY1VLLjP193UeA1edWu7q0D
         A5mw==
X-Gm-Message-State: AOAM532VIuhmBPxuo2Fyl0nEa1wvUqwwAntI1baPAY9uS6L+Q+ph+sfQ
        IlizeOYf70RryMjVvNm1ahL8wg==
X-Google-Smtp-Source: ABdhPJzp+1ZimY7nJijJSKbz7msA3e2GL3ZygWVrX3UvWeThNpaUiW7HjJrS/JYH1z9vn0t+7eB3Zg==
X-Received: by 2002:a17:90b:4a4d:: with SMTP id lb13mr595128pjb.44.1612468374865;
        Thu, 04 Feb 2021 11:52:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a24sm7359811pff.18.2021.02.04.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:52:54 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:52:53 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 01/25] Documentation/x86: Add CET description
Message-ID: <202102041152.E257D3E2BE@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-2-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:23PM -0800, Yu-cheng Yu wrote:
> Explain no_user_shstk/no_user_ibt kernel parameters, and introduce a new
> document on Control-flow Enforcement Technology (CET).
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
