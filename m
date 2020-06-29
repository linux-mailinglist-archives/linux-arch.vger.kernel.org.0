Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8E20E28B
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgF2VGd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbgF2VGX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 17:06:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A9BC061755;
        Mon, 29 Jun 2020 14:06:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z2so14024217qts.5;
        Mon, 29 Jun 2020 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=doBBGB7xlE5VTXsZgCgPieACb98RUxeYYlyjRqBYqwk=;
        b=LqI1i8wzqXm8nU2Ic1Xkncf9ppAoV7PBHkxQVw49w+S1bUMRA+mPYwotwm1xevj+wz
         W7EprSOUg3PFhG5CK6k3/cDlwyEbzt528fqOgPyORXJYnow9dML18ccBtnqZJa0UdbP8
         f7kr1bzbgY0PbKRDt0Abfldoi/agCPG37BmIgJT9nW7J546oknUZM4hZiVXOCrNV9smK
         XGUkCXgopqK8G1MfzuL2Vf+yhTTvEPxPfxyb2lV+eZJ49nK25nTOmOpNG0bDxTKPO7Jb
         6d2EuO6hIIQsf3ZYt5qo346hnRJUH4p0HrQMgsRCSErlVd5C9z0ucwkOvhk8rUv6mZf8
         iEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=doBBGB7xlE5VTXsZgCgPieACb98RUxeYYlyjRqBYqwk=;
        b=Mw7z0IPBrrKxo1cx6we3Bj8CJITITGTFu5TF3Ifee8VFhBJZk6S/WtkczAGhXvg/sz
         Fa22CDEo3ccaJ60bHmrxgb4pNiq1vD3/pM7BBRiwl71rA2ZRr0x6Da2xEf6GMcTxAU7c
         I181Iq7awoZmGByzhA1VjyeoQLSRzq0+jJ1jHMB5UVlCdkchBmFNQkM2MAdiwH2Fk5ii
         69EBUufYGSg+nE4CMzZVgwLhymd/GY/SmA3OZltOisnDKHKXnD3oyHVUbYE+s7k9EcOF
         DhKoCsEB5qvNyT9WViMaE3iBfh85SVOGNCAG789JOA7qnXec9QmvcG9X4oA19y2upyRX
         9Nvg==
X-Gm-Message-State: AOAM531SLhhC8Rkiea0p2HbIu7PHEH8lmj5HKPYrl5sseOvbfDRV+5Kl
        KvkLdenNYAe6k1IccPG9JaY=
X-Google-Smtp-Source: ABdhPJwWfhACQdRSjlXr+8tYrYr5Js2ar1sW///HmVXlxpOfUFTESwvc3U+xILMwk4hI3IsVsOzReg==
X-Received: by 2002:ac8:48da:: with SMTP id l26mr17036060qtr.214.1593464782360;
        Mon, 29 Jun 2020 14:06:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u68sm864480qkd.59.2020.06.29.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:06:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 29 Jun 2020 17:06:19 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
Message-ID: <20200629210619.GA1603907@rani.riverdale.lan>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-9-keescook@chromium.org>
 <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
 <202006291301.46FEF3B7@keescook>
 <20200629205448.GA1474367@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629205448.GA1474367@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 04:54:48PM -0400, Arvind Sankar wrote:
> On Mon, Jun 29, 2020 at 01:04:31PM -0700, Kees Cook wrote:
> > On Mon, Jun 29, 2020 at 12:53:47PM -0700, Nick Desaulniers wrote:
> > > On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > Fix a case of needless quotes in __section(), which Clang doesn't like.
> > > >
> > > > Acked-by: Will Deacon <will@kernel.org>
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Yep, I remember bugs from this.  Probably should scan the kernel for
> > > other instances of this.  +Joe for checkpatch.pl validation.
> > 
> > I think the others are safe because they're in macros:
> 
> Why does that make it safe -- the commit msg is a bit sparse, but I
> assume the problem is that it generates
> 	__attribute__((__section__("\".foo\"")))
> from
> 	__section(".foo")
> after preprocessing, and clang keeps the quotes in the section name when
> generating assembly, while gcc appears to strip them off.
> 
> It does that even if nested in another macro, no?

Yep, I can see things like:
[25] ".discard.ksym"   PROGBITS         0000000000000000  0000217c
       0000000000000000  0000000000000000  WA       0     0     4

Doesn't seem to cause a build error, but that can't be good.

> 
> > 
> > $ git grep -4 '__section("'
> > include/linux/compiler.h-# define KENTRY(sym)                                           \
> 
> Am I missing something, or is KENTRY unused in the tree?
> 
> > include/linux/compiler.h-       extern typeof(sym) sym;                                 \
> > include/linux/compiler.h-       static const unsigned long __kentry_##sym               \
> > include/linux/compiler.h-       __used                                                  \
> > include/linux/compiler.h:       __section("___kentry" "+" #sym )                        \
> > include/linux/compiler.h-       = (unsigned long)&sym;
> > --
> > include/linux/export.h-#define __ksym_marker(sym)       \
> > include/linux/export.h: static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
> > --
> > include/linux/srcutree.h-# define __DEFINE_SRCU(name, is_static)                                \
> > include/linux/srcutree.h-       is_static struct srcu_struct name;                              \
> > include/linux/srcutree.h-       struct srcu_struct * const __srcu_struct_##name                 \
> > include/linux/srcutree.h:               __section("___srcu_struct_ptrs") = &name
> > 
> > 
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > 
> > Thanks!
> > 
> > -- 
> > Kees Cook
