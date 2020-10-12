Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99B828C2E6
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 22:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgJLUpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgJLUpC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 16:45:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB30C0613D6
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 13:45:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t18so9325104plo.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/je9IGonHzFsuF/SNifo0ZcXgtv4yeAu6zOR0qhli4g=;
        b=iBvAVUobGLxYChgzQDFIjdgKitAhC2jHTTevcSYvj7umuQsfw68FrsiS588nddPL9n
         rvr2pXp07ZQWqM/LOhZO8EaapVG+BSzu0jORrfEH3ohPyD3qyDxXqnlKu5B0F1SooZd2
         mIgofFGRcvthuFUyb4XxZSLu96zkfV5bLY9hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/je9IGonHzFsuF/SNifo0ZcXgtv4yeAu6zOR0qhli4g=;
        b=d9k7g6CMNySxzktPveMdyKZ3WQJUFrOeFg5OY9y+NHZdhQmClZ5UeIFJyFNQvO6hf/
         NGYsHJKxy5ow39jRsyVcTHF+yAn6zQTkLKuqzwQB1tu/Hbn/FXQ7jS8s/X6zLVQsXWpE
         Gq6raOXPbpWpKW39sg7Y+YEqHW2LS9vELaptQbz+5JbyqStuzCDkt9XEZgPqYq0yQuFC
         NfwHWdn8hOk1SkxDneo+G/MiCL3AnTBezwmbzdB+L0bj7yXo01BGceT4EbkeSoJuEChX
         3fQIaVynYoLPDSW92WjvfA7fStncYTy5jHYbvaxbpQ116P6cmjQZwcPn4UUHEkOmHLc7
         3fmQ==
X-Gm-Message-State: AOAM532QPxt4wVgdMsq3pVFEtn0cjOidur6Zu7jp6hhW8Dy3Y2vV/iY7
        YxUAJhU/2wIDTB1IaU9WRyp5ZDxjlTK39A==
X-Google-Smtp-Source: ABdhPJxf12qi2TvIPdMo3b44hzG/IVxwKW/VadUKNptF9UK+YkxRipHLl4jP/u0pgN9HY2DkPgijnw==
X-Received: by 2002:a17:902:cd07:b029:d3:9be0:2679 with SMTP id g7-20020a170902cd07b02900d39be02679mr25530237ply.68.1602535499967;
        Mon, 12 Oct 2020 13:44:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v20sm16032300pjh.5.2020.10.12.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:44:58 -0700 (PDT)
Date:   Mon, 12 Oct 2020 13:44:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 25/29] arm64: allow LTO_CLANG and THINLTO to be
 selected
Message-ID: <202010121344.53780D8CD2@keescook>
References: <20201009161338.657380-1-samitolvanen@google.com>
 <20201009161338.657380-26-samitolvanen@google.com>
 <20201012083116.GA785@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012083116.GA785@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 12, 2020 at 09:31:16AM +0100, Will Deacon wrote:
> On Fri, Oct 09, 2020 at 09:13:34AM -0700, Sami Tolvanen wrote:
> > Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm64/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index ad522b021f35..7016d193864f 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -72,6 +72,8 @@ config ARM64
> >  	select ARCH_USE_SYM_ANNOTATIONS
> >  	select ARCH_SUPPORTS_MEMORY_FAILURE
> >  	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
> > +	select ARCH_SUPPORTS_LTO_CLANG
> > +	select ARCH_SUPPORTS_THINLTO
> 
> Please don't enable this for arm64 until we have the dependency stuff sorted
> out. I posted patches [1] for this before, but I think they should be part
> of this series as they don't make sense on their own.

Oh, hm. We've been trying to trim down this series, since it's already
quite large. Why can't [1] land first? It would make this easier to deal
with, IMO.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=rwonce/read-barrier-depends

-- 
Kees Cook
