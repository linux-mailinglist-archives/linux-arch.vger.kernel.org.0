Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542926218B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgIHU42 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 16:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgIHU4V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 16:56:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6AC061755
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 13:56:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so221195pjg.1
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1kwkhnnjfbD1n3YicFbQyeenHuldLrryzBMnu30RTk=;
        b=kqiVfXTqdvpE+D8HME82Bm/99OYWSZDGK7Oq76UCHFIRCcsokRD7oz4xAQHKlHR74v
         8jFd7Rm7VgphQioMxWqT6sB7WDRfEhiq+5dlPJB+VwsYe0Gws+0LJm6D9zwG/r15KK4j
         cuzPLvDpOo+kNSRVML9vt8TFZj2LIN0dx3+GMt+v/gfQiWWDTGc/5e1sfumXGI2CjeI6
         Wy++ioGxrd4TyZOe6AhKrFK49Dd0klSTZ4EyeBc8yeTCbAl+4UnrnXBHPmJZk+pzkRBq
         MO/Socm9d6L4MR4DbsbQU9qRVnfcNKA/i/3XI/d16ytiFjJKk9h0Y3hAMCxgdwcJ4siN
         gBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1kwkhnnjfbD1n3YicFbQyeenHuldLrryzBMnu30RTk=;
        b=WZrbWWFmxhcw1bdmTAyZZynhvfLa03CleovZ4U5BC9yFpBWp3MKiO2fxCHXjrw7toj
         yGGoIsd1E5RIsiTKcOWzkB6oeZZr6I6JNjNfOKojXPxGvvkK6rX2kkd/Xf2SAic+4oWj
         8yeEHzTLYV9F02awIQwifvp5jdA5Xq4ZXJz42cSh2yJqNYh1f6YrWriTJzT7QDYRjAHx
         DoSmpBd5Aa/vE+10e+ryyvJszUEDrvy/U6cDw1XYIlu97ZE9ukb5+gVY74DyPve03Gut
         gFEI6xGq3wJkJ5FqPkuPhXn3jr73g6Rhr+cAzxd2HDaI11meAHtJJB0MXZJVn8l+rmRg
         VPgg==
X-Gm-Message-State: AOAM531PypPM6f8xpumo+tslm/bwUYtQNkDl7hXIY7b+J7ilNAQC9Xp4
        DvOWB3BaSzZb9vWK7P2LncLVpQ==
X-Google-Smtp-Source: ABdhPJwmdCJZLAUsrl/QW5wKuUZMBwlVdVl2VXP+Jk7zMzVi2ljr8t2PHAqCINz0HMBlae3lzorpYw==
X-Received: by 2002:a17:90b:3444:: with SMTP id lj4mr574843pjb.78.1599598579801;
        Tue, 08 Sep 2020 13:56:19 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id e14sm187682pgu.47.2020.09.08.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:56:19 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:56:12 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
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
Subject: Re: [PATCH v2 11/28] kbuild: lto: postpone objtool
Message-ID: <20200908205612.GA1060586@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-12-samitolvanen@google.com>
 <202009031513.B558594FB9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009031513.B558594FB9@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 03:19:43PM -0700, Kees Cook wrote:
> On Thu, Sep 03, 2020 at 01:30:36PM -0700, Sami Tolvanen wrote:
> > With LTO, LLVM bitcode won't be compiled into native code until
> > modpost_link, or modfinal for modules. This change postpones calls
> > to objtool until after these steps.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> For a "fail fast" style of building, it makes sense to have objtool run
> as early as possible, so it makes sense to keep the current behavior in
> non-LTO mode. I do wonder, though, if there is a real benefit to having
> "fail fast" case. I imagine a lot of automated builds are using
> --keep-going with make, and actually waiting until the end to do the
> validation means more code will get build-tested before objtool rejects
> the results. *shrug*
> 
> > ---
> >  arch/Kconfig              |  2 +-
> >  scripts/Makefile.build    |  2 ++
> >  scripts/Makefile.modfinal | 24 ++++++++++++++++++++++--
> >  scripts/link-vmlinux.sh   | 23 ++++++++++++++++++++++-
> >  4 files changed, 47 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 71392e4a8900..7a418907e686 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -599,7 +599,7 @@ config LTO_CLANG
> >  	depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
> >  	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
> >  	depends on ARCH_SUPPORTS_LTO_CLANG
> > -	depends on !FTRACE_MCOUNT_RECORD
> > +	depends on HAVE_OBJTOOL_MCOUNT || !(X86_64 && DYNAMIC_FTRACE)
> >  	depends on !KASAN
> >  	depends on !GCOV_KERNEL
> >  	select LTO
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index c348e6d6b436..b8f1f0d65a73 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -218,6 +218,7 @@ cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),
> >  endif # USE_RECORDMCOUNT
> >  
> >  ifdef CONFIG_STACK_VALIDATION
> > +ifndef CONFIG_LTO_CLANG
> >  ifneq ($(SKIP_STACK_VALIDATION),1)
> >  
> >  __objtool_obj := $(objtree)/tools/objtool/objtool
> > @@ -253,6 +254,7 @@ objtool_obj = $(if $(patsubst y%,, \
> >  	$(__objtool_obj))
> >  
> >  endif # SKIP_STACK_VALIDATION
> > +endif # CONFIG_LTO_CLANG
> >  endif # CONFIG_STACK_VALIDATION
> >  
> >  # Rebuild all objects when objtool changes, or is enabled/disabled.
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 1005b147abd0..909bd509edb4 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -34,10 +34,30 @@ ifdef CONFIG_LTO_CLANG
> >  # With CONFIG_LTO_CLANG, reuse the object file we compiled for modpost to
> >  # avoid a second slow LTO link
> >  prelink-ext := .lto
> > -endif
> > +
> > +# ELF processing was skipped earlier because we didn't have native code,
> > +# so let's now process the prelinked binary before we link the module.
> > +
> > +ifdef CONFIG_STACK_VALIDATION
> > +ifneq ($(SKIP_STACK_VALIDATION),1)
> > +cmd_ld_ko_o +=								\
> > +	$(objtree)/tools/objtool/objtool				\
> > +		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
> > +		--module						\
> > +		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
> > +		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
> > +		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
> > +		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
> > +		$(if $(USE_OBJTOOL_MCOUNT),--mcount,)			\
> > +		$(@:.ko=$(prelink-ext).o);
> > +
> > +endif # SKIP_STACK_VALIDATION
> > +endif # CONFIG_STACK_VALIDATION
> 
> I wonder if objtool_args could be reused here instead of having two
> places to keep in sync? It looks like that might mean moving things
> around a bit before this patch, since I can't quite see if
> Makefile.build's variables are visible to Makefile.modfinal?

It doesn't look like they are. I suppose we could move objtool_args to
Makefile.lib. Masahiro, any thoughts?

Sami
