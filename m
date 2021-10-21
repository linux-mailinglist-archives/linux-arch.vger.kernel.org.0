Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591A74367E2
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhJUQgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhJUQgs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:36:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F86C0613B9
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:34:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a15-20020a17090a688f00b001a132a1679bso3584606pjd.0
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qGPTNek+6NWWYDzAeqngJPEge0t+CkBjWVvJhkdvjR0=;
        b=dF2s5YhhpTniB+xkm1SrsDfZS8oIz+muJ2oNJr2HTBlV0rFbjaD5JFlGpPuSi20as6
         MRwOTFnvxuyG84H6wihc440P6TBkG4ZtP7ZeFbaCT8dE+LKO35ljO8LaikKKabWaX0G5
         u2nrGF32jSZY8c7WAi+EfyvOyiG3JWrcCKiJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qGPTNek+6NWWYDzAeqngJPEge0t+CkBjWVvJhkdvjR0=;
        b=KFTzJdyHKkLPLHq8QLbeyDQ7rG2W1voEi5uX04S6wDnojy3WZLOwvExlUDZIV569q5
         TR+o7yny+7d3buSEQNVevd2bCBCrG5KkZVLuJyV/AQ5I/GkXKipcHLhp4J2dki4tWER8
         gwO6/JEjtUGCclPuNcuYyinjrHxgyeLmn6ps5/uj1B3F+4smAKx8C2Hhov9Xwj92xPmT
         v3Yj3Wcrd6iirlI/6pLScN0a/JPIbYbtrLMunRF79eVnrcPscE+qbHf171eRA6V0OyqG
         3XvlPTMWzJi3Q9//pdl1Xj8KeYGVwvYC0FVxog9DkWz6X80LBbNR5vNnQ/I9goQdmGYT
         RFCA==
X-Gm-Message-State: AOAM531IF5nVqTqXv0uw9WelOGeMTxAABznugQKtcRCFHwyIv2/cdkoB
        yJDBWmHUOLiU+U9+69nUieCjhA==
X-Google-Smtp-Source: ABdhPJxJzlbLOUp/qTLnqyd+XrRHGcIFYf6vDxWlNuADk1BHVR4Rp0WpGOHOQ2f1pxaYLqHqfszezg==
X-Received: by 2002:a17:902:b711:b029:11e:6480:258a with SMTP id d17-20020a170902b711b029011e6480258amr6095915pls.41.1634834072178;
        Thu, 21 Oct 2021 09:34:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s21sm7088592pfg.70.2021.10.21.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:34:31 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:34:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH 15/20] signal/sparc32: Exit with a fatal signal when
 try_to_clear_window_buffer fails
Message-ID: <202110210927.D0B4B0342@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-15-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-15-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:01PM -0500, Eric W. Biederman wrote:
> The function try_to_clear_window_buffer is only called from
> rtrap_32.c.  After it is called the signal pending state is retested,

nit: rtrap_32.S

> and signals are handled if TIF_SIGPENDING is set.  This allows
> try_to_clear_window_buffer to call force_fatal_signal and then rely on
> the signal being delivered to kill the process, without any danger of
> returning to userspace, or otherwise using possible corrupt state on
> failure.

The TIF_SIGPENDING test happens in do_notify_resume(), though I see
other code before that:

...
        call    try_to_clear_window_buffer
        add    %sp, STACKFRAME_SZ, %o0

        b       signal_p
...
signal_p:
        andcc   %g2, _TIF_DO_NOTIFY_RESUME_MASK, %g0
        bz,a    ret_trap_continue
        ld     [%sp + STACKFRAME_SZ + PT_PSR], %t_psr

        mov     %g2, %o2
        mov     %l6, %o1
        call    do_notify_resume

Will the ret_trap_continue always be skipped?

Also I see the "tp->w_saved = 0" never happens due to the "return" in
try_to_clear_window_buffer. Is that okay? Only synchronize_user_stack()
uses it, and that could be called in do_sigreturn(). Should the "return"
be removed?

-- 
Kees Cook
