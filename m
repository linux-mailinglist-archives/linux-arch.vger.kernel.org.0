Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1E3436806
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUQjo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJUQjm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:39:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09CFC0613B9
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:37:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so954360pjb.3
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=04I9TWsIOGOn1eFIVJttMz+DLb6FF5THXFpZBPJ94b0=;
        b=c9NjlmmwB9EIkOtNs2OZL3o5o6lJtDFinTGZ6nhR4luI6tRvXaab0oE3TxNz8G+k5T
         nvfNYTYcmfzobFjCkXvDAtIjp3305XmGGtAYNOqma8EfZm12pH/GEc0ZjS3vfNETciLe
         i1+F0TjfsACCrpedibS9YYFpckwey2mKwdr7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=04I9TWsIOGOn1eFIVJttMz+DLb6FF5THXFpZBPJ94b0=;
        b=HYl/4Re+rzHMBWXrJWcsOHQjrcMR508/vCyNbPyHeATc2rY+r3aQmsA0jp9+nS2DF4
         xPO/CG+iOyiKWxTPzxsAUI1NwnaLGZNojunoRl7MRZxvY62RssSMsQ0AKpVSFSs68Nte
         csRV7PNijojPbppT7rH8W3cyj7xk1RtYBa84/KMfJbosbNfcCBs/IZai6dyZfxXk/K+N
         a3tbl7xhJzYieBz6S8Yyz4uCdB0i2F05wsnF8xHqzULweRA9HyPu9n0bGVXkIGePZMUw
         y9jT6da+Juhd8nFcbK8S3EfRyuZhKWUHuR5o7fUXB2sN7xyx/DgQtD5SoRfdHCzsMtro
         PVoA==
X-Gm-Message-State: AOAM531CVsh55KRAZQm/vIKyJTIQA1h+q9Zdu+7Guc1yJUcTkmtjFFD0
        YCgFHs0KoAR1Tjfn3RGlvy0jbg==
X-Google-Smtp-Source: ABdhPJwTX2X/AYbjPA9YRUX5PvKnOkaTy47qVh3VdzDhl1OXm9PPmyUW/ZOC/n5J3iKqKkjSZ5uI6Q==
X-Received: by 2002:a17:90b:1bc3:: with SMTP id oa3mr7854106pjb.75.1634834246460;
        Thu, 21 Oct 2021 09:37:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lp9sm7373908pjb.35.2021.10.21.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:37:26 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:37:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 19/20] exit/rtl8712: Replace the macro thread_exit with a
 simple return 0
Message-ID: <202110210937.1AE72B4E59@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-19-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-19-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:05PM -0500, Eric W. Biederman wrote:
> The macro thread_exit is called is at the end of a function started
> with kthread_run.  The code in kthread_run has arranged things so a
> kernel thread can just return and do_exit will be called.
> 
> So just have the cmd_thread return instead of calling complete_and_exit.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
