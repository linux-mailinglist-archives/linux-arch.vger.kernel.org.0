Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61743674D
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhJUQLN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJUQLL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:11:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F8C061764
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:08:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so929937pjb.0
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gdc/lGkpR61OHyRBqYEJcDW/apWS1Be/eKAz+upJlxI=;
        b=LonpLY3i1mcr5QH9xueFci4gVBhS4w4hZeP9OccoTe+okgVH16P2bdB7i6Ci0R5PI5
         m8nFWAVndkNdANKs/qI5gVj/CIkTu69zyscVm3CA9HzZj7LIK4o7RzwTpBLbX44Ffo49
         EX2qo1Mg9MWz90Ihs+Lb1UXAuTMRxN3FOAzb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gdc/lGkpR61OHyRBqYEJcDW/apWS1Be/eKAz+upJlxI=;
        b=7C6vecJcbC49NdDUD40ms19tLvjjN8EerX7NdcegIcbmTA2b02scR9iMASJ9RvelIa
         UKS8tlpNKbg9lc+6RjzuhudGcEK09wMA/l250D9zTdhT3FGXTOZJ314kqap9gcgl/E9d
         4dciwNEPgmLfvypP6lm+DyLwzRLuDyEz94PvrzqMcZIUjUeRtHGLEj0jbysLN8vOdfGq
         cpokyKlt6zuQZss4CM85hT9Ul66npP/3H5sXs563I35x/y8YX5iuOYCQhqAega4BR/l4
         njB8QSUxC9t0sOgaCtaEpLVPhB0H7bEMsvrpDXLQH9PJ4Z0AHOYNoIK/O+OfaPcm7+RJ
         Dvxg==
X-Gm-Message-State: AOAM531WcWF29Y5t25c0thrpWCDY84GCKeeePzxu8+PieGQW+yS85d3o
        JnLqfbXNE65xK3E7I9ZzZmTtfw==
X-Google-Smtp-Source: ABdhPJxNic93QUUUnNiH4nY5D0N9RVoxSTNlinHs1JSkR6W8jwHyvo6/dHFZ4veSckMo10M5iHcLug==
X-Received: by 2002:a17:902:7b84:b0:13b:90a7:e270 with SMTP id w4-20020a1709027b8400b0013b90a7e270mr6009591pll.21.1634832534672;
        Thu, 21 Oct 2021 09:08:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z10sm5668734pgv.81.2021.10.21.09.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:08:54 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:08:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH 06/20] signal/sh: Use force_sig(SIGKILL) instead of
 do_group_exit(SIGKILL)
Message-ID: <202110210907.F89199BB2@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-6-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:52PM -0500, Eric W. Biederman wrote:
> Today the sh code allocates memory the first time a process uses
> the fpu.  If that memory allocation fails, kill the affected task
> with force_sig(SIGKILL) rather than do_group_exit(SIGKILL).
> 
> Calling do_group_exit from an exception handler can potentially lead
> to dead locks as do_group_exit is not designed to be called from
> interrupt context.  Instead use force_sig(SIGKILL) to kill the
> userspace process.  Sending signals in general and force_sig in
> particular has been tested from interrupt context so there should be
> no problems.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Fixes: 0ea820cf9bf5 ("sh: Move over to dynamically allocated FPU context.")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks sane; there should be no observable changes.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
