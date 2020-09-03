Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6103F25CCB8
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgICVuM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgICVuG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 17:50:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA92C061245
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 14:50:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so3163076pgm.11
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9OR6JT/gDQkiw7Q3Fa+IeISt3W9FIEoweyBz21QtHYY=;
        b=SlD5lTtnmNwlNoqmJOqtx2+Yt4N1mjRl+6MJSYVsMfoK7/Vte9rczahAFAqHnyUmuV
         Sh7rwOVbBxjFQ8McJgNgBYopu598rgZcDcsmsFDuQmlnFjiaMgVEzupYqeqjeeE3eUEq
         lRP6kFMGcXoyupiZ9023vt2rn4Dd4rd9u4Z74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9OR6JT/gDQkiw7Q3Fa+IeISt3W9FIEoweyBz21QtHYY=;
        b=YMnCS838xcF02Wu/YLQppiKKUKhcz5jAICvXYOameJm5wB57k2MiVCB3qooXthGlM8
         sUpF6sa7ZDJfusY4bEcZSKOSCgYx86gqv4y/eirY3GnkBmqzDItn/AyOXCMKwy6hE6u7
         XZPg/iE0oCjCvumsv4njLlSb3gmMlSWBYTbsxPb/O+ssIAa/74oQqFOd2xZTOb9KtPOw
         Z2lt53FUe3BH5v8vfr1AmblGnm6J6Wer3p9e7Sf8o2kVKS5Sen7iD1t7RJ4R1fvjUqCR
         5k9zDrKNpsvZ3gKUCy9P1GsbDnjFJHPjs1IrG/nda/w8QIk/7xkbaDkss90zJWsa3ueS
         hzEg==
X-Gm-Message-State: AOAM532KVDHJ+qBNrLGE0/Gv3wXk0Wo55RDkfwADAkI/wcWpShLIsr3K
        1m5I05nlDmPS2o59McBDbfnsyg==
X-Google-Smtp-Source: ABdhPJzv22i9c6AyREMh2qsXkXGwLuQNiCYhEpeSxCHuz3ZxEVmXaBNaH/fkJhsoZ2M5HPXWMnRolQ==
X-Received: by 2002:a65:648c:: with SMTP id e12mr4696062pgv.57.1599169805900;
        Thu, 03 Sep 2020 14:50:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s198sm3628323pgc.4.2020.09.03.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:50:04 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:50:03 -0700
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
        x86@kernel.org, Luca Stefani <luca.stefani.ge1@gmail.com>
Subject: Re: [PATCH v2 04/28] RAS/CEC: Fix cec_init() prototype
Message-ID: <202009031449.287535C@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-5-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:29PM -0700, Sami Tolvanen wrote:
> From: Luca Stefani <luca.stefani.ge1@gmail.com>
> 
> late_initcall() expects a function that returns an integer. Update the
> function signature to match.
> 
>  [ bp: Massage commit message into proper sentences. ]
> 
> Fixes: 9554bfe403nd ("x86/mce: Convert the CEC to use the MCE notifier")
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>

I don't see this in -next yet (next-20200903), but given Boris's SoB, I
suspect it just hasn't snuck it's way there from -tip. Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
