Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C23207ECD
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 23:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404656AbgFXVpj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404455AbgFXVpi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:45:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1363C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:45:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ne5so1773915pjb.5
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2I1W9/xF2d1Vj6fXUSW50a6lcRysW14cejGyX/KQrUE=;
        b=kAzFiuub3JptGeF8CNTcnC+CeP/FsxM38jl9PiZjmZ2NQEKCzf5W55HotGQ3RFsl47
         OU28gJzz3nFm0K+qZFZj3aI4XkCmA0i32hx7kEqSPXYASiEOFWG196YJXulcZC3Y9dyz
         7yrrrZ4gUvmMXog64rqdi3irHXMSe28OJl0jht0IedPAX5FdSbei28cHde7gFfC8WQTO
         Th94MFJ7oKpcHcW0N9ISYWBLrKFqFcAygWKu8Bgdc273Y+lpnMx+5Oa57A1RVV779WXs
         N9wCMhhfGA+gmYVaSfQFrOgexBHpRg0exI1Q7NtzxhM5Ml3G7MxFC3aUmhMIk7wXvif6
         SpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2I1W9/xF2d1Vj6fXUSW50a6lcRysW14cejGyX/KQrUE=;
        b=WZnVcReKzNcE5ncYynQ2bxdc7orU2doVq3pPSdwM1qT5N1SA1KCWqlA8w9K+pzLPku
         dE/JUPfMWWb7hcmlJf2Z4i/+PXDSWdQZpTUymDTnhx8SJvYRq6zzVNgr9BQix1s2dmhQ
         5ubxbws/yKwCpUeGpZw5flz32pUlChHzIYQidnR255gDT/EHKnZ09gKSD66A161XpHWr
         naOXLaxXSXGtoEYl87cVSrXnBwd1mFb37MjofvbY1COkl3aKWDVaT1NJcjib8D/Uc9ru
         l1Ac7evMmhT2wh2/fjZluO9rQCk0odEY3Mpob4GvHRKzFyyxf5di6GWUtupJGA8tPOTM
         hqjw==
X-Gm-Message-State: AOAM5319+u+2csCZPH2j8RrfZ8jGODSjBcOlCyVsi54tL16rokY5xjhJ
        iU5nYXFpJOGdNYZhNqli95iIyA==
X-Google-Smtp-Source: ABdhPJxJmUZYMRaQyfOp9XANW1+HBk5Vx8x0dWsfSmu7dydDXvUxNLtKKWPkOY7MNgSE/tyVCHzLvA==
X-Received: by 2002:a17:90b:916:: with SMTP id bo22mr7503001pjb.100.1593035136962;
        Wed, 24 Jun 2020 14:45:36 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id x1sm20175037pfn.76.2020.06.24.14.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 14:45:36 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:45:30 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 04/22] kbuild: lto: fix recordmcount
Message-ID: <20200624214530.GA120457@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624212737.GV4817@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 11:27:37PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 01:31:42PM -0700, Sami Tolvanen wrote:
> > With LTO, LLVM bitcode won't be compiled into native code until
> > modpost_link. This change postpones calls to recordmcount until after
> > this step.
> > 
> > In order to exclude specific functions from inspection, we add a new
> > code section .text..nomcount, which we tell recordmcount to ignore, and
> > a __nomcount attribute for moving functions to this section.
> 
> I'm confused, you only add this to functions in ftrace itself, which is
> compiled with:
> 
>  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> 
> and so should not have mcount/fentry sites anyway. So what's the point
> of ignoring them further?
> 
> This Changelog does not explain.

Normally, recordmcount ignores each ftrace.o file, but since we are
running it on vmlinux.o, we need another way to stop it from looking
at references to mcount/fentry that are not calls. Here's a comment
from recordmcount.c:

  /*
   * The file kernel/trace/ftrace.o references the mcount
   * function but does not call it. Since ftrace.o should
   * not be traced anyway, we just skip it.
   */

But I agree, the commit message could use more defails. Also +Steven
for thoughts about this approach.

Sami
