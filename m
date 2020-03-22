Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258BF18E9F1
	for <lists+linux-arch@lfdr.de>; Sun, 22 Mar 2020 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVQA1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Mar 2020 12:00:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39881 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgCVQAZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Mar 2020 12:00:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so6179578pfn.6
        for <linux-arch@vger.kernel.org>; Sun, 22 Mar 2020 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZnunFMXbRiY6HhjSua+SYJfQ+tuSHBnq9fjrfedNSU=;
        b=UiseloQi7Q50zpFXi5Sj0YO9rKXAWYBKycPFxzwvcjG+fSbAEz8JpjkczACNYpw6y8
         i43J4zt0Bu+J+WnbtpFAh1BdbvLy2cqLus59mgkM8/XjySQ2RuPeFya5b/pyiEZ74Bw2
         kzB/pjprqBnITJPTNa9esWoz6cPqUebmBsckA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZnunFMXbRiY6HhjSua+SYJfQ+tuSHBnq9fjrfedNSU=;
        b=PLaWN5+niLr4hiV8DUU/MUTkhw3+3Yz67/x6jUo8lB7EaY+9dLtCo97/SJ3V1Yfeli
         l8XL4q9DURzK6zdikBlCm6UFaGfzAIpC81otJBNfzT3YLcQsi63mH9h1ujQlN6trOBcf
         7HBMevxuOThVR9kIpdbMphlu/NUMeG3nJZNl5jFbmnbCl3317fIkzjcs3aQHDGmTZaKE
         FVnGaTCqEzJ7aW5Dv8ni8JW/wK06K5fQ8eTLtJ8fjSnG7BjmZeKKvz3C997DYX5QAwVL
         ZvHSydV+jnIAi8Ncv99Woy//Qe8EX4a+0BuZY03B6vyVPkFTI2B7y7xnD00vRviBNTKx
         zTpA==
X-Gm-Message-State: ANhLgQ1/aiIChPofELgq64kv1T9zmMC2Y2tKWyHAOq61q1tgSh29hCl6
        lJYtRXPrmyrCIdD0MijWvfTyJQ==
X-Google-Smtp-Source: ADFU+vvsIHJRgFm4AMsl8mZy4RcjRPdpt/Bxks2m7kQfkj84k1duCai32eKXFRMuQMfF7FOK2pobZA==
X-Received: by 2002:a63:7159:: with SMTP id b25mr8811601pgn.72.1584892824203;
        Sun, 22 Mar 2020 09:00:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 15sm10831504pfu.186.2020.03.22.09.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 09:00:23 -0700 (PDT)
Date:   Sun, 22 Mar 2020 09:00:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux@googlegroups.com,
        "H.J. Lu" <hjl.tools@gmail.com>, James Morse <james.morse@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH 1/9] scripts/link-vmlinux.sh: Delay orphan handling
 warnings until final link
Message-ID: <202003220859.E54327D98C@keescook>
References: <20200228002244.15240-1-keescook@chromium.org>
 <20200228002244.15240-2-keescook@chromium.org>
 <1584672297.mudnpz3ir9.astroid@bobo.none>
 <202003201121.8CBD96451B@keescook>
 <1584868418.o62lxee8k1.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584868418.o62lxee8k1.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 22, 2020 at 07:16:29PM +1000, Nicholas Piggin wrote:
> Kees Cook's on March 21, 2020 4:24 am:
> > On Fri, Mar 20, 2020 at 12:47:54PM +1000, Nicholas Piggin wrote:
> >> Kees Cook's on February 28, 2020 10:22 am:
> >> > Right now, powerpc adds "--orphan-handling=warn" to LD_FLAGS_vmlinux
> >> > to detect when there are unexpected sections getting added to the kernel
> >> > image. There is no need to report these warnings more than once, so it
> >> > can be removed until the final link stage.
> >> > 
> >> > This helps pave the way for other architectures to enable this, with the
> >> > end goal of enabling this warning by default for vmlinux for all
> >> > architectures.
> >> > 
> >> > Signed-off-by: Kees Cook <keescook@chromium.org>
> >> > ---
> >> >  scripts/link-vmlinux.sh | 6 ++++++
> >> >  1 file changed, 6 insertions(+)
> >> > 
> >> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> >> > index 1919c311c149..416968fea685 100755
> >> > --- a/scripts/link-vmlinux.sh
> >> > +++ b/scripts/link-vmlinux.sh
> >> > @@ -255,6 +255,11 @@ info GEN modules.builtin
> >> >  tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
> >> >  	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
> >> >  
> >> > +
> >> > +# Do not warn about orphan sections until the final link stage.
> >> > +saved_LDFLAGS_vmlinux="${LDFLAGS_vmlinux}"
> >> > +LDFLAGS_vmlinux="$(echo "${LDFLAGS_vmlinux}" | sed -E 's/ --orphan-handling=warn( |$)/ /g')"
> >> > +
> >> >  btf_vmlinux_bin_o=""
> >> >  if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
> >> >  	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
> >> > @@ -306,6 +311,7 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
> >> >  	fi
> >> >  fi
> >> >  
> >> > +LDFLAGS_vmlinux="${saved_LDFLAGS_vmlinux}"
> >> >  vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
> >> >  
> >> >  if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
> >> 
> >> That's ugly. Why not just enable it for all archs?
> > 
> > It is ugly; I agree.
> > 
> > I can try to do this for all architectures, but I worry there are a
> > bunch I can't test. But I guess it would stand out. ;)
> 
> It's only warn, so it doesn't break their builds (unless there's a 
> linker error on warn option I don't know about?). We had a powerpc bug 
> that would have been caught with it as well, so it's not a bad idea to
> get everyone using it.

Well, it's bad form to add warnings to a build. I am expected to fix any
warnings before I enable a warning flag.

> I would just do it. Doesn't take much to fix.

I will do my best on the archs I can't test. :)

-- 
Kees Cook
