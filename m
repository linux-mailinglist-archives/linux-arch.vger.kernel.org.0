Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066B720E15B
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 23:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbgF2Uyy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgF2Uyw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 16:54:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5506C061755;
        Mon, 29 Jun 2020 13:54:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b4so16599606qkn.11;
        Mon, 29 Jun 2020 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9HwG2hptkvSOrRKZDzSfX9HShvoVlZLEE89Q4pxGwKg=;
        b=s+op9n5qGA+glqVosZzqTbnD2UvIqP3N7tNJyJ/kireTnyE28fdGxODM2aWtaXNSAC
         t29PEGKsQHLLcaLTDHrNrMGtDXQ8YlfqGe+c+vcrvwaDrgsSi88W6vRLEzpzcdDlh1g1
         QHWPA5CGNY+wCzuiB7BwRCYt59ZK5WRsL+IHULDPubTQnwZk71cECIxPIFoh0bWOx0AX
         /M+hABUsvTA9G3EtAnMYeuCjL++xxyOyaLYBGYECi236pOeEmU39iaMolrQnh8DN/7QZ
         fLO9TQVNO2jTJAUWFk/FzhFWKlPslVJzS9+zm8yEdDZJyYFUieqf87rZqYhOeAHzoYly
         n1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9HwG2hptkvSOrRKZDzSfX9HShvoVlZLEE89Q4pxGwKg=;
        b=a6P9aBw6ZvyY1aUxOAbqGC068wgG9pVGQ+NOs8CscNDMTkDpmw7E60UZUjtP5CQ/ar
         86QhKW05giGa1LhLVhc50evPVW8NvD4qtHhToVPHAmHRnHmBZhAoxvyl7TObS6uovWM3
         wb/Rcl9JLbbE28d52D4EnC9JU0/ld6CjfWWOG9WsodY1o66CGuydB4IbvLiWTycH+Gow
         C9PEaz1SAkcjO7je2cjqvh9zHz5CEDZI+GwlFWzuOZ+teEWT8h5nrVv7+WXuJlcvyVJM
         7p6pzWF5LgaJ/vT5MUp5jEXYcwmf5Wn1fgVjGgJRouHgIL30wwh3XclMUPiRgM1MEIUN
         jyYg==
X-Gm-Message-State: AOAM532F7a7ulxVRuSVLcI6Q09ce0RqPDjefG4bh3D14vO/dV3GNZBF0
        0eHfUZb2UWUBl19HN1mqtXc=
X-Google-Smtp-Source: ABdhPJzhU0UkI4NLmVT8XqBz5+IwnGuJPy0JQVzhW8zoa0QRRRLDmRVoyW3MbJrOFD6WdNnoAHaCyg==
X-Received: by 2002:ae9:efc7:: with SMTP id d190mr16745385qkg.212.1593464090890;
        Mon, 29 Jun 2020 13:54:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i22sm964461qki.4.2020.06.29.13.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:54:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 29 Jun 2020 16:54:48 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
Message-ID: <20200629205448.GA1474367@rani.riverdale.lan>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-9-keescook@chromium.org>
 <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
 <202006291301.46FEF3B7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202006291301.46FEF3B7@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 01:04:31PM -0700, Kees Cook wrote:
> On Mon, Jun 29, 2020 at 12:53:47PM -0700, Nick Desaulniers wrote:
> > On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Fix a case of needless quotes in __section(), which Clang doesn't like.
> > >
> > > Acked-by: Will Deacon <will@kernel.org>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Yep, I remember bugs from this.  Probably should scan the kernel for
> > other instances of this.  +Joe for checkpatch.pl validation.
> 
> I think the others are safe because they're in macros:

Why does that make it safe -- the commit msg is a bit sparse, but I
assume the problem is that it generates
	__attribute__((__section__("\".foo\"")))
from
	__section(".foo")
after preprocessing, and clang keeps the quotes in the section name when
generating assembly, while gcc appears to strip them off.

It does that even if nested in another macro, no?

> 
> $ git grep -4 '__section("'
> include/linux/compiler.h-# define KENTRY(sym)                                           \

Am I missing something, or is KENTRY unused in the tree?

> include/linux/compiler.h-       extern typeof(sym) sym;                                 \
> include/linux/compiler.h-       static const unsigned long __kentry_##sym               \
> include/linux/compiler.h-       __used                                                  \
> include/linux/compiler.h:       __section("___kentry" "+" #sym )                        \
> include/linux/compiler.h-       = (unsigned long)&sym;
> --
> include/linux/export.h-#define __ksym_marker(sym)       \
> include/linux/export.h: static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
> --
> include/linux/srcutree.h-# define __DEFINE_SRCU(name, is_static)                                \
> include/linux/srcutree.h-       is_static struct srcu_struct name;                              \
> include/linux/srcutree.h-       struct srcu_struct * const __srcu_struct_##name                 \
> include/linux/srcutree.h:               __section("___srcu_struct_ptrs") = &name
> 
> 
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Thanks!
> 
> -- 
> Kees Cook
