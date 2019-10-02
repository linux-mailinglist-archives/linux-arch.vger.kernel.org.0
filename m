Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AABC8911
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2019 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfJBM4D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 08:56:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39816 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfJBM4D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2019 08:56:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id w144so17509772oia.6;
        Wed, 02 Oct 2019 05:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdK03n3+2me9Sk19EdnaoVUhfmldNzf5bSdl3P4k3vY=;
        b=MOly8uCnmzYYz+9aKY5gmsgwWRFU2ZTLX0qM4JSEQvxvnj4GRT0naw9sq3bKVOqUCm
         mpNf0bq+vhMzeFrQtSwGUhLt/I7WErgFqGTRZ5UNGh7HOTLkcyHsmX8W4yoM1a91V1Lx
         BNaBl8RVepiVIoXQmMLS2llTuRdCxAydWfhFUCkhypleXikhdJS/dtsxRAjHeyumg2Ni
         yqEBx66NtFDiYqhQH3DpvPm+HdZqeqbSe5AAQ3VOIcQ7dNCYsBtO0gBUK3H9RdeWKuGv
         4zIfuihwHr4M77rBsGK09BuzByc24IU186nIOKPYS2uWJzZL+NWtHTdYSOwhsZPp3Qwe
         08vA==
X-Gm-Message-State: APjAAAWrj+dZ6N6OBsCT09H7E0ut2ICIO9hvj9yI1wRiPqHVQN6Helay
        4a92RrVBqgD7PHiw1RV8s5edFxgNtz2PSzWOJFQ=
X-Google-Smtp-Source: APXvYqzU1MgQE5NJFF64vkAcQB5Y8/wYO3KQbh9gwqE/n127GIcUuBYJp52kR5qIxlSQPIBlNHi8a4L/TiF5BpuRXTE=
X-Received: by 2002:aca:3908:: with SMTP id g8mr2794516oia.54.1570020961944;
 Wed, 02 Oct 2019 05:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
In-Reply-To: <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Oct 2019 14:55:50 +0200
Message-ID: <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nick,

On Wed, Oct 2, 2019 at 6:33 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Tue, Oct 1, 2019 at 11:14 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Tue, Oct 01, 2019 at 11:00:11AM -0700, Nick Desaulniers wrote:
> > > On Tue, Oct 1, 2019 at 10:55 AM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > > On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> > > > > I apologize; I don't mean to be difficult.  I would just like to avoid
> > > > > surprises when code written with the assumption that it will be
> > > > > inlined is not.  It sounds like we found one issue in arm32 and one in
> > > > > arm64 related to outlining.  If we fix those two cases, I think we're
> > > > > close to proceeding with Masahiro's cleanup, which I view as a good
> > > > > thing for the health of the Linux kernel codebase.
> > > >
> > > > Except, using the C preprocessor for this turns the arm32 code into
> > > > yuck:
> > > >
> > > > 1. We'd need to turn get_domain() and set_domain() into multi-line
> > > >    preprocessor macro definitions, using the GCC ({ }) extension
> > > >    so that get_domain() can return a value.
> > > >
> > > > 2. uaccess_save_and_enable() and uaccess_restore() also need to
> > > >    become preprocessor macro definitions too.
> > > >
> > > > So, we end up with multiple levels of nested preprocessor macros.
> > > > When something goes wrong, the compiler warning/error message is
> > > > going to be utterly _horrid_.
> > >
> > > That's why I preferred V1 of Masahiro's patch, that fixed the inline
> > > asm not to make use of caller saved registers before calling a
> > > function that might not be inlined.
> >
> > ... which I objected to based on the fact that this uaccess stuff is
> > supposed to add protection against the kernel being fooled into
> > accessing userspace when it shouldn't.  The whole intention there is
> > that [sg]et_domain(), and uaccess_*() are _always_ inlined as close
> > as possible to the call site of the accessor touching userspace.
>
> Then use the C preprocessor to force the inlining.  I'm sorry it's not
> as pretty as static inline functions.

Which makes us lose the baby^H^H^H^Htype checking performed
on function parameters, requiring to add more ugly checks.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
