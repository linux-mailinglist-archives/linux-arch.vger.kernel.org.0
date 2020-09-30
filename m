Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB027F3F8
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 23:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgI3VKg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 17:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3VKg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 17:10:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62696C0613D1
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 14:10:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so1925287pgl.9
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=43NmDXRdfvytQQYY6+SkI5I3v0G1ZKlfq1R/B+8Rbe8=;
        b=aznXL+Mf1oo937XoxBdAUWYbrGQBox+mHPLXOBi8fxELvJxmtN4Oh2fdCubtsfNRrA
         rDHSxjRXgFROvxwZKbrgkOQaw+IdYULTR8nRNYUFnd02K6q1DKbVRP6qGTIrAq/ntqIt
         uicIip4Sy8y/dZqila87XWTqZiy3eaEQT/WgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=43NmDXRdfvytQQYY6+SkI5I3v0G1ZKlfq1R/B+8Rbe8=;
        b=jO9VfmFmMZPoLtmcAIwyR+CMFq+i2OdxM1czaXTp6tqXx/zkG+conuF/CDIfGIvVPR
         +3L7/uvdSMaIRfvJFxrVqNkrh9YuuKxme1cRe1+EUJx6BIce/v/+QqF4Bm3ikWmq1mcn
         418kxZCDSEVfC9t/w/qe6DzldZndd/kQK8sliEHBl62nMrqLEPWpNfKBLe13YajxsoKo
         KGTYAb+KTKa2WjoBAo61D7xPV7gZgb/VL8Hol3sVxtA68pygciLYV+JL2YY7zBTzM8YD
         QdzKeHcqf2KvCcdEUZZM5NfIKyIhIs549CphLH/85NXQUwQsQZ9YyM/4cZx5HnV5CSsW
         r+Lw==
X-Gm-Message-State: AOAM531MCsS02dUa7GxJMVZHpikre0bP+HzISRPxgl2O7Vyq8GgfiYKW
        kB+eKl7nF4aqI1/WMML8aB139g==
X-Google-Smtp-Source: ABdhPJyw4kR2hvM1gD9zLPKC5ogvJTlrWuluJmqFM9fB7y/1oreMiPXLmURVREruQgKi3Vr48qMMIg==
X-Received: by 2002:a17:902:c40d:b029:d2:562d:db9 with SMTP id k13-20020a170902c40db02900d2562d0db9mr4239380plk.46.1601500235715;
        Wed, 30 Sep 2020 14:10:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n2sm3182853pja.41.2020.09.30.14.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:10:34 -0700 (PDT)
Date:   Wed, 30 Sep 2020 14:10:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v4 00/29] Add support for Clang LTO
Message-ID: <202009301402.27A40DD1@keescook>
References: <20200929214631.3516445-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 29, 2020 at 02:46:02PM -0700, Sami Tolvanen wrote:
> Furthermore, patches 4-8 include Peter's patch for generating
> __mcount_loc with objtool, and build system changes to enable it on
> x86. With these patches, we no longer need to annotate functions
> that have non-call references to __fentry__ with LTO, which makes
> supporting dynamic ftrace much simpler.

Peter, can you take patches 4-8 into -tip? I think it'd make sense
to keep them together. Steven, it sounds like you're okay with the
changes (i.e. Sami showed the one concern you had was already handled)?
Getting these into v5.10 would be really really nice.

I'd really like to get the tree-spanning prerequisites nailed down
for this series. It's been difficult to coordinate given the multiple
maintainers. :)

Specifically these patches:

Peter Zijlstra (1):
  objtool: Add a pass for generating __mcount_loc

Sami Tolvanen (4):
  objtool: Don't autodetect vmlinux.o
  tracing: move function tracer options to Kconfig
  tracing: add support for objtool mcount
  x86, build: use objtool mcount

https://lore.kernel.org/lkml/20200929214631.3516445-5-samitolvanen@google.com/
https://lore.kernel.org/lkml/20200929214631.3516445-6-samitolvanen@google.com/
https://lore.kernel.org/lkml/20200929214631.3516445-7-samitolvanen@google.com/
https://lore.kernel.org/lkml/20200929214631.3516445-8-samitolvanen@google.com/
https://lore.kernel.org/lkml/20200929214631.3516445-9-samitolvanen@google.com/

Thanks!

-- 
Kees Cook
