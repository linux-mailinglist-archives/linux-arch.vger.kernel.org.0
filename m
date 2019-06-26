Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD256F63
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFZROV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jun 2019 13:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZROV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jun 2019 13:14:21 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A3B2177B
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2019 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561569260;
        bh=IPJPblNMOSzpc4o8oUY4BwkKbCN4n/1QDhjL5Fv7ep4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m+cjANgMOKu9iYPrmIEkq3ir867euC6fdTabpwRWKebv6Efr6ulwc+y5QuteG304H
         /QfQMK0QGFunEvQafok0oocQabttk4YNZs1+7OtTC3sL8zB6GFf2+B0BddImiFJWF2
         BYP7KtBDmXc/06DRGFT2JJ7dkt9otFAQzEU2u14U=
Received: by mail-wr1-f50.google.com with SMTP id f9so3596091wre.12
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2019 10:14:20 -0700 (PDT)
X-Gm-Message-State: APjAAAWcxt/NL5pn2Y/F4HWUkpMLFAYPW80UQGs7VHhgsneAPqaYfBnD
        MXX/0+JKl8t0XHTzc1XpkAkWfnG4ARUx6PdVG0UiDg==
X-Google-Smtp-Source: APXvYqwnPPumX5RBRaLP0km8dly68xVsmM8NNvDYkvDSTBBYKWMqVhDoaa+pINUPBix2TVy8TAUL3d69gE4hjyvE0Jw=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr4711752wro.343.1561569259059;
 Wed, 26 Jun 2019 10:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190501211217.5039-1-yu-cheng.yu@intel.com> <20190502111003.GO3567@e103592.cambridge.arm.com>
In-Reply-To: <20190502111003.GO3567@e103592.cambridge.arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Jun 2019 10:14:07 -0700
X-Gmail-Original-Message-ID: <CALCETrVZCzh+KFCF6ijuf4QEPn=R2gJ8FHLpyFd=n+pNOMMMjA@mail.gmail.com>
Message-ID: <CALCETrVZCzh+KFCF6ijuf4QEPn=R2gJ8FHLpyFd=n+pNOMMMjA@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 2, 2019 at 4:10 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Wed, May 01, 2019 at 02:12:17PM -0700, Yu-cheng Yu wrote:
> > An ELF file's .note.gnu.property indicates features the executable file
> > can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> > indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> > GNU_PROPERTY_X86_FEATURE_1_SHSTK.
> >
> > This patch was part of the Control-flow Enforcement series; the original
> > patch is here: https://lkml.org/lkml/2018/11/20/205.  Dave Martin responded
> > that ARM recently introduced new features to NT_GNU_PROPERTY_TYPE_0 with
> > properties closely modelled on GNU_PROPERTY_X86_FEATURE_1_AND, and it is
> > logical to split out the generic part.  Here it is.
> >
> > With this patch, if an arch needs to setup features from ELF properties,
> > it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and a specific
> > arch_setup_property().
> >
> > For example, for X86_64:
> >
> > int arch_setup_property(void *ehdr, void *phdr, struct file *f, bool inter)
> > {
> >       int r;
> >       uint32_t property;
> >
> >       r = get_gnu_property(ehdr, phdr, f, GNU_PROPERTY_X86_FEATURE_1_AND,
> >                            &property);
> >       ...
> > }
>
> Thanks, this is timely for me.  I should be able to build the needed
> arm64 support pretty quickly around this now.
>
> [Cc'ing libc-alpha for the elf.h question -- see (2)]
>
>
> A couple of questions before I look in more detail:
>
> 1) Can we rely on PT_GNU_PROPERTY being present in the phdrs to describe
> the NT_GNU_PROPERTY_TYPE_0 note?  If so, we can avoid trying to parse
> irrelevant PT_NOTE segments.
>
>
> 2) Are there standard types for things like the program property header?
> If not, can we add something in elf.h?  We should try to coordinate with
> libc on that.  Something like
>

Where did PT_GNU_PROPERTY come from?  Are there actual docs for it?
Can someone here tell us what the actual semantics of this new ELF
thingy are?  From some searching, it seems like it's kind of an ELF
note but kind of not.  An actual description would be fantastic.

Also, I don't think there's any actual requirement that the upstream
kernel recognize existing CET-enabled RHEL 8 binaries as being
CET-enabled.  I tend to think that RHEL 8 jumped the gun here.  While
the upstream kernel should make some reasonble effort to make sure
that RHEL 8 binaries will continue to run, I don't see why we need to
go out of our way to keep the full set of mitigations available for
binaries that were developed against a non-upstream kernel.

In fact, if we handle the legacy bitmap differently from RHEL 8, we
may *have* to make sure that we don't recognize existing RHEL 8
binaries as CET-enabled.

Sigh.
