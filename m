Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D213C18D6C1
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCTSY0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 14:24:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38087 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCTSYZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 14:24:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so3722813pfn.5
        for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2020 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xWVMcAkfq5ne45p4xyMZVZzHfwNqETngAro5lkreP4=;
        b=egxARSlFh+gl8BSoKEBkPxmioi72UPPDmz+ssHOs8UemiCka73hYdGEersNQgdrjqn
         c9iW1spOQ7Y1EaKd8/93ca30yRGiOpdG1LxIk06m6fckNrb3yNGJ1b0zsz3OwKkRoNSS
         x85gCSRaoiqfjdrokwJmmZlkj+6L0Y12RifNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xWVMcAkfq5ne45p4xyMZVZzHfwNqETngAro5lkreP4=;
        b=qjL+Ko0pzREeLhFCBHjGAKnpRgwP2Rf5AIyITt+8kDlT6P65r4Spoz3ywLTH52+79u
         HwtGfZ31UvG+VD6AzrNBy4fdAIOz1L71kdnx5K0aqXTBaE62L8nXSGCuW/hlgu3ai/Pt
         DSQ/qgiYHWE2aVqSyFreY7zKXf/C67proBftjAG9WTn5+UXCJ06OxeAUm9veELVdaEBd
         HLNA7GQvPgvFxUP1dFcd9qmqo9AAoxI2ONCHTdHeDcEPz1IksCPmlaRpc4px1rOZHVAa
         ahgWDUyFCoDlcfyl+caD5imVpJj5ecQmw9x2hSLN7D2TfAKJ4xLUISWBSWHVhEid2F8Y
         A2eg==
X-Gm-Message-State: ANhLgQ0wd8o/oF12mUzfQAxlOBgX4EszYN1GARKTIvkvCjUT8H//fdwC
        WqmYStFbeVfXSmdO9rOMcsLGDw==
X-Google-Smtp-Source: ADFU+vvJ86QsFIReD0LB05B1a0McdUNTvZoxWG49MXWb/we6ziLuZVXT1lHzITCce8/XQ3hfd6rn8g==
X-Received: by 2002:a63:b706:: with SMTP id t6mr9859014pgf.329.1584728664667;
        Fri, 20 Mar 2020 11:24:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w205sm6244774pfc.75.2020.03.20.11.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:24:23 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:24:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <202003201121.8CBD96451B@keescook>
References: <20200228002244.15240-1-keescook@chromium.org>
 <20200228002244.15240-2-keescook@chromium.org>
 <1584672297.mudnpz3ir9.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584672297.mudnpz3ir9.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 20, 2020 at 12:47:54PM +1000, Nicholas Piggin wrote:
> Kees Cook's on February 28, 2020 10:22 am:
> > Right now, powerpc adds "--orphan-handling=warn" to LD_FLAGS_vmlinux
> > to detect when there are unexpected sections getting added to the kernel
> > image. There is no need to report these warnings more than once, so it
> > can be removed until the final link stage.
> > 
> > This helps pave the way for other architectures to enable this, with the
> > end goal of enabling this warning by default for vmlinux for all
> > architectures.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  scripts/link-vmlinux.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 1919c311c149..416968fea685 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -255,6 +255,11 @@ info GEN modules.builtin
> >  tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
> >  	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
> >  
> > +
> > +# Do not warn about orphan sections until the final link stage.
> > +saved_LDFLAGS_vmlinux="${LDFLAGS_vmlinux}"
> > +LDFLAGS_vmlinux="$(echo "${LDFLAGS_vmlinux}" | sed -E 's/ --orphan-handling=warn( |$)/ /g')"
> > +
> >  btf_vmlinux_bin_o=""
> >  if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
> >  	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
> > @@ -306,6 +311,7 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
> >  	fi
> >  fi
> >  
> > +LDFLAGS_vmlinux="${saved_LDFLAGS_vmlinux}"
> >  vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
> >  
> >  if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
> 
> That's ugly. Why not just enable it for all archs?

It is ugly; I agree.

I can try to do this for all architectures, but I worry there are a
bunch I can't test. But I guess it would stand out. ;)

-Kees

-- 
Kees Cook
