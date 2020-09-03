Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F253025CDDD
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 00:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgICWnX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 18:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgICWnU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 18:43:20 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0860DC061247
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 15:43:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so3277065pgl.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JQ91+76gyHMY3xv40LcJfL22rVwnSHEWIrs+JY61Lfw=;
        b=Gv/ffUiV4cHAcDklljNvHcMHuBcglanuZNKtn6NOLTMdAobfJFLi4S3XUK/VF0cMoa
         YCSlZMjLzO+hSp1mb2H+OVfbR2yXR8wtEPXnlt5uMI360+iCnjR0H3cIuzPcnksebXGK
         d93lpCoPbskfIrQ+gg8nraNFnKZGq6Pjaz6ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JQ91+76gyHMY3xv40LcJfL22rVwnSHEWIrs+JY61Lfw=;
        b=EXsEo3xfDnD1mTvnenhk4KiCapwZTrGTqXtKS+9j1o6I/8Z6l6KY71qTyHe4HGRJKd
         3J83iyezN9U35usQQxIQpJmx2CTAzXxU2HQonLrPeFzyIhPdMoEc1uec3fICOmLY5aZa
         pX7M7k5AHRhl4dFd7YKJy9Nke8pH5OOdNSAPNINz6gncAwM6fLrwKjfBW+StZA0O0f6p
         a7DDDKH+LUlPHo+IqRI+n6aW/RqrmOo2gd3/jV/WaTnmnTOFye7ZQXHtSXzqWrB0FUcy
         JBkMpp9bUhlmTgRncHXCzXZMdAc4Dyefkg1+//N66hRs+a9sE7r/r+PwQzh5X1UQ1yuI
         EXeg==
X-Gm-Message-State: AOAM532aIkA+FJuWXT3nGD3osN6zAubNmSU6cwR5KTGIQUUf9pHYJnZA
        +zSvTCEc6k41VWhIWduLAHwMbQ==
X-Google-Smtp-Source: ABdhPJzsDxL6JJKJu36vJnlttgHabnBSHn20nTl7ZGP5hdybfETsgZLi8FgY6Utuj7Ord6vXDPO70Q==
X-Received: by 2002:a62:4e49:: with SMTP id c70mr5965062pfb.100.1599172999617;
        Thu, 03 Sep 2020 15:43:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 141sm4425163pfb.50.2020.09.03.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:43:18 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:43:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 19/28] scripts/mod: disable LTO for empty.c
Message-ID: <202009031543.A239909B@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-20-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-20-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:44PM -0700, Sami Tolvanen wrote:
> With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
> files. As empty.o is used for probing target properties, disable LTO
> for it to produce an object file instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
