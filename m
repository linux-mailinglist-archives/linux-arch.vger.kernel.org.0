Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9B35900F
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 00:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhDHXAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 19:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhDHXAG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 19:00:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE8C061760
        for <linux-arch@vger.kernel.org>; Thu,  8 Apr 2021 15:59:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t20so1782649plr.13
        for <linux-arch@vger.kernel.org>; Thu, 08 Apr 2021 15:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=60tuWIbUjG0iyC8nYrQdXxsGuNpmQhEiUDZqyLR6c1Y=;
        b=mTnrJmw6Pc4S3mQP2I8SdRxPl0N5UkqJYhxgb56iNBXgYefgG11RdYQzPa/MB/dvPV
         jbLIhoH9o0hDGMLI5J3taqG+MEIgRNkMDDkUxbyMT5US7eZygaGqQIpeNB+TgGrghMRI
         gHQzdPXo0gJXu2PRuODNsA4Gmr8eePdCipd+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60tuWIbUjG0iyC8nYrQdXxsGuNpmQhEiUDZqyLR6c1Y=;
        b=hYCyZComrGYmWm64Gd22ytozQ6UMMvNy68vELakBA2T6iqq05ETHr2iPSBqlv+dAPy
         VLonTvaGfIjgOr6qCFri/DJLp2nGS7qCm8MC2vpcEUhJggk2rJrFQUZ5MyI6lhngSzyP
         Vfs4HmVE1Olg3x6kKtCw1zca+TGf7daUAGdoKCwUnsWqRuEAczSHc1czYEiAzl0ijo+u
         42UQ//AXCScRmn3mRe71d4f6NlJIyD7m+3CmsZUbg8E3YED5kSBDHv0xx+DNrG8o/0pz
         399NqDg0k66pB+8yxxeeZFKt+54YHNKhfA2CzaLYcS2/OAnXKeC1BDnWGeTxUlrRuNhI
         F37g==
X-Gm-Message-State: AOAM533gJYhKWr8qH0IKnB4SV2qv65CG2Hec7hzmLY3O0sKjxGy/yqht
        atfxKrrA/oMqC8iDW2Z+AIMPog==
X-Google-Smtp-Source: ABdhPJxpI62oGhUH5bf1MYiaJE6hoG/InXmCoxk2tAKn9J92fdY9RsD06VJoBDcDoxV3vya9jT2KOA==
X-Received: by 2002:a17:902:7c83:b029:e8:c368:543 with SMTP id y3-20020a1709027c83b02900e8c3680543mr9895464pll.58.1617922794624;
        Thu, 08 Apr 2021 15:59:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q95sm368117pjq.20.2021.04.08.15.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:59:54 -0700 (PDT)
Date:   Thu, 8 Apr 2021 15:59:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v6 00/18] Add support for Clang CFI
Message-ID: <202104081558.9A5FE3A@keescook>
References: <20210408182843.1754385-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 08, 2021 at 11:28:25AM -0700, Sami Tolvanen wrote:
> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking. With CFI, the compiler injects a runtime check before each
> indirect function call to ensure the target is a valid function with
> the correct static type. This restricts possible call targets and
> makes it more difficult for an attacker to exploit bugs that allow the
> modification of stored function pointers. For more details, see:
> 
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> The first patch contains build system changes and error handling,
> and implements support for cross-module indirect call checking. The
> remaining patches address issues caused by the compiler
> instrumentation. These include fixing known type mismatches, as well
> as issues with address space confusion and cross-module function
> address equality.
> 
> These patches add support only for arm64, but I'll post patches also
> for x86_64 after we address the remaining issues there, including
> objtool support.
> 
> You can also pull this series from
> 
>   https://github.com/samitolvanen/linux.git cfi-v6

This is working quite well for me and it looks like there are
good reviews. I'm going to toss it in linux-next unless anyone has
objections. I'm very excited to start using this. :)

-Kees

-- 
Kees Cook
