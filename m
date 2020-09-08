Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF742620E8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 22:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgIHURl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 16:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgIHURi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 16:17:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE5EC061573;
        Tue,  8 Sep 2020 13:17:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g72so348805qke.8;
        Tue, 08 Sep 2020 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/08OEII2Gc2davobAmINkHdHlTLoM3yBel115LZWEGE=;
        b=qZ/9AznDVXFtr6CrHuhiw4QW5HmClw8tl/kn16sP+vAL9BwyB1TalbAKldIgIIFtb+
         4gbcw6Ixl7WWm6+eR7AOeeEgNHRd9KO82LOanYAhZnktvDEwnWkiDthqJWrrSp8D42u4
         fIeAiy4POw3wf4Z6SvhKEEye1aUrwOIWslhBv+79RaCXHWn4YpCcP2k1rJp/fR64lnQC
         8jnqEJ5IzfX5q10Y72vrRW9J8/NnBj7zCdAZsoK7DHNMvg7HjynBh+r4iRBw+V66mCG0
         KesRtoiYqBsl5xile5AfugcBIKBCC3vQzS/rH6rs/JmItACffhMLEWNQHzOwlPtwLyAt
         KhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/08OEII2Gc2davobAmINkHdHlTLoM3yBel115LZWEGE=;
        b=K925NchmjXWEiCGzH/kNzYavYK/+3NvvHQbPDKJID+oSaUT+/F7KgHrJeQq6W4BUd3
         HVUWnSZUpFirCvHtH6NXxK2lTqJGjxBCCyEd0vmtXN/MZPj+9JqZ5SUmtNXuEr3PAi7l
         QVig32ntP3fPbaJ8MZzx7i4Msq5VVP/kqO/bncdGSdDlu2rYTgAZup6YnMMwIHuRYRj0
         NB71p+E7fxsbYAKUN9dePcukfKFUQqkHVS7UJixLzmnlGr1PB+7e/EhWxaNa+r163tp3
         W1BfEXyKu4jLczdr/Sv8p4NB+h54CBFjccKqaITKNI6FYftKGc1a8/yNuszY6CcJNR4N
         nV5w==
X-Gm-Message-State: AOAM531Bd7P55qEyfZpPCr0xrPOYptsEA+iNJgs4TwdAy+YLtD91YELP
        UZz7Cb72I157G9mxj1cT1n4=
X-Google-Smtp-Source: ABdhPJwNSgWEhWS2D5NSJFniOHBOS9/EWNgGqZsCsA91Ij4q3VjCGMYQaXbuPxF07dtwVNjz7gPPBQ==
X-Received: by 2002:a05:620a:955:: with SMTP id w21mr302081qkw.69.1599596256656;
        Tue, 08 Sep 2020 13:17:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z6sm335661qkl.39.2020.09.08.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:17:35 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 8 Sep 2020 16:17:34 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] x86/build: Warn on orphan section placement
Message-ID: <20200908201734.GA87825@rani.riverdale.lan>
References: <20200902025347.2504702-1-keescook@chromium.org>
 <20200902025347.2504702-5-keescook@chromium.org>
 <20200905224835.GA1500331@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905224835.GA1500331@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 05, 2020 at 06:48:35PM -0400, Arvind Sankar wrote:
> On Tue, Sep 01, 2020 at 07:53:46PM -0700, Kees Cook wrote:
> > We don't want to depend on the linker's orphan section placement
> > heuristics as these can vary between linkers, and may change between
> > versions. All sections need to be explicitly handled in the linker script.
> > 
> > Now that all sections are explicitly handled, enable orphan section
> > warnings.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 4346ffb2e39f..154259f18b8b 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -209,6 +209,10 @@ ifdef CONFIG_X86_64
> >  LDFLAGS_vmlinux += -z max-page-size=0x200000
> >  endif
> >  
> > +# We never want expected sections to be placed heuristically by the
> > +# linker. All sections should be explicitly named in the linker script.
> > +LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
> > +
> >  archscripts: scripts_basic
> >  	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
> >  
> > -- 
> > 2.25.1
> > 
> 
> With LLVM=1 and GCOV_KERNEL/GCOV_PROFILE_ALL enabled, there are
> .eh_frame sections created. I see that KASAN and KCSAN currently discard
> them. Does GCOV actually need them or should it also discard?
> 
> Thanks.

Also, with LLD 10.0.1 which is going to be the minimum supported
version, the relocation sections etc still generate warnings.

ld.lld: warning:
arch/x86/video/built-in.a(fbdev.o):(.rela.orc_unwind_ip) is being placed
in '.rela.orc_unwind_ip'
ld.lld: warning: .tmp_vmlinux.kallsyms2.o:(.rela.rodata) is being placed
in '.rela.rodata'
ld.lld: warning: <internal>:(.bss.rel.ro) is being placed in
'.bss.rel.ro'
ld.lld: warning: <internal>:(.eh_frame) is being placed in '.eh_frame'
ld.lld: warning: <internal>:(.symtab_shndx) is being placed in
'.symtab_shndx'
