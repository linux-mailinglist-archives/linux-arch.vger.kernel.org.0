Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7956C20779D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404195AbgFXPgX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 11:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403931AbgFXPgW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 11:36:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD133C0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 08:36:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so1582587pgo.9
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XJUzgH5TgVAKrlAz/oLGoEzf+4q4DR2SPe5g3v8Hoz0=;
        b=L87UOx1rFbEBv6EAXMjq42JQm86UtPUvAjrSDFUjZV7/S2Fdwtz80FtkbJzD8kccUr
         iRuRTc98qsUUvW4wRLaZIRPNfFKjSXe1ODNggmES4VHyXOVp9NEfQINR136Asyjj1o/J
         v+lhjyzt2oK0bGeFeFUl+FR9FpGwVWyk6cXTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XJUzgH5TgVAKrlAz/oLGoEzf+4q4DR2SPe5g3v8Hoz0=;
        b=keNgV9hy0aur7rAQE3jjjPZ/qFwhuvjz5e4vam0LCOQ9zUPlZNAkjahTlzMU5QkM3j
         Swz04OR20GDlJqtnj8/RsWz+KnonKf+1gFlzmT7vZQXV45HEAduPStgLG4HSbKFT3xmz
         F8FvJtnllbvxS6cbZ+L89bxlvsHBnXqR7iiuI4Hxo6HpZr/qy5aDgrhotqQl8McCkb+I
         hQ89j9rd3ppbXL6jkpciOFj+h91s1n9WW0IXcORcYcPbVnY7BMjOWEvQ+icvK5YAdzkH
         uOJ0pEAAMheTcVM7uxhguhjOWk0sLFPb5ivKxdpa8aTWoXGw5vZNnOTt2blDGodeMdGp
         yWgg==
X-Gm-Message-State: AOAM5318zSSBztxWYUDue3xNyVkJEnsEcX2YyutAQfLfy9/h3fsCqabg
        39XKE1emxxfOcPkZpUWvQlfLfg==
X-Google-Smtp-Source: ABdhPJzh0NIgxXcoqTxHGxMf5jIULfS15W7YCEH1YCRk0fdSR5z7SraN22S3afSROtaHxZ0aAd1AOA==
X-Received: by 2002:a63:aa42:: with SMTP id x2mr21604671pgo.361.1593012982182;
        Wed, 24 Jun 2020 08:36:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j36sm17984549pgj.39.2020.06.24.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:36:21 -0700 (PDT)
Date:   Wed, 24 Jun 2020 08:36:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] arm64/build: Warn on orphan section placement
Message-ID: <202006240835.E474048BBF@keescook>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-10-keescook@chromium.org>
 <20200624075712.GB5853@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624075712.GB5853@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 08:57:12AM +0100, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 06:49:40PM -0700, Kees Cook wrote:
> > We don't want to depend on the linker's orphan section placement
> > heuristics as these can vary between linkers, and may change between
> > versions. All sections need to be explicitly named in the linker
> > script.
> > 
> > Avoid .eh_frame* by making sure both -fno-asychronous-unwind-tables and
> > -fno-unwind-tables are present in both CFLAGS and AFLAGS. Remove one
> > last instance of .eh_frame by removing the needless Call Frame Information
> > annotations from arch/arm64/kernel/smccc-call.S.
> > 
> > Add .plt, .data.rel.ro, .igot.*, and .iplt to discards as they are not
> > actually used. While .got.plt is also not used, it must be included
> > otherwise ld.bfd will fail to link with the error:
> > 
> >     aarch64-linux-gnu-ld: discarded output section: `.got.plt'
> > 
> > However, as it'd be better to validate that it stays effectively empty,
> > add an assert.
> > 
> > Explicitly include debug sections when they're present.
> > 
> > Fix a case of needless quotes in __section(), which Clang doesn't like.
> > 
> > Finally, enable orphan section warnings.
> > 
> > Thanks to Ard Biesheuvel for many hints on correct ways to handle
> > mysterious sections. :)
> 
> Sorry to be a pain, but this patch is doing 3 or 4 independent things at
> once. Please could you split it up a bit?
> e.g.
> 
>  - Removal of cfi directives from smccc macro
>  - Removal of quotes around section name for clang
>  - Avoid generating .eh_frame
>  - Ensure all sections are accounted for in linker script and warn on orphans
> 
> That way it's a bit easier to manage, we can revert/backport bits later if
> necessary and you get more patches in the kernel ;)

Yeah, this one patch did grow a bit. ;) I've split it up now.

> You can also add my Ack on all the patches:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks!

-- 
Kees Cook
