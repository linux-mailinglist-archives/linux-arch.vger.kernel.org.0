Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72452C911E
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2019 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfJBSvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 14:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfJBSvl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 14:51:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2ED21A4C;
        Wed,  2 Oct 2019 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570042300;
        bh=CRQhS30YGps7394nDLglJ442PO7GILfwsW96COK8hZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2jKtiPHBM4opCi8aDykOrFKWS3TvFjuWgksMPKcN/llJii5FgB1youQL+qF2c77I2
         Py+wnMifC2SjORaWtWQzOqj1TNZQbAjIQj/DOrLGEZszPwa1f0Tk7RpUQf1h/5BTAK
         RX4szP/nOWesKrzE1/RKdgpHwveT8zH76rrKkQWw=
Date:   Wed, 2 Oct 2019 19:51:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20191002185133.n6pldb4exyjfesfh@willie-the-truck>
References: <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
 <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
 <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk>
 <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 02, 2019 at 02:55:50PM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 2, 2019 at 6:33 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > On Tue, Oct 1, 2019 at 11:14 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > On Tue, Oct 01, 2019 at 11:00:11AM -0700, Nick Desaulniers wrote:
> > > > On Tue, Oct 1, 2019 at 10:55 AM Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > > On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> > > > > > I apologize; I don't mean to be difficult.  I would just like to avoid
> > > > > > surprises when code written with the assumption that it will be
> > > > > > inlined is not.  It sounds like we found one issue in arm32 and one in
> > > > > > arm64 related to outlining.  If we fix those two cases, I think we're
> > > > > > close to proceeding with Masahiro's cleanup, which I view as a good
> > > > > > thing for the health of the Linux kernel codebase.
> > > > >
> > > > > Except, using the C preprocessor for this turns the arm32 code into
> > > > > yuck:
> > > > >
> > > > > 1. We'd need to turn get_domain() and set_domain() into multi-line
> > > > >    preprocessor macro definitions, using the GCC ({ }) extension
> > > > >    so that get_domain() can return a value.
> > > > >
> > > > > 2. uaccess_save_and_enable() and uaccess_restore() also need to
> > > > >    become preprocessor macro definitions too.
> > > > >
> > > > > So, we end up with multiple levels of nested preprocessor macros.
> > > > > When something goes wrong, the compiler warning/error message is
> > > > > going to be utterly _horrid_.
> > > >
> > > > That's why I preferred V1 of Masahiro's patch, that fixed the inline
> > > > asm not to make use of caller saved registers before calling a
> > > > function that might not be inlined.
> > >
> > > ... which I objected to based on the fact that this uaccess stuff is
> > > supposed to add protection against the kernel being fooled into
> > > accessing userspace when it shouldn't.  The whole intention there is
> > > that [sg]et_domain(), and uaccess_*() are _always_ inlined as close
> > > as possible to the call site of the accessor touching userspace.
> >
> > Then use the C preprocessor to force the inlining.  I'm sorry it's not
> > as pretty as static inline functions.
> 
> Which makes us lose the baby^H^H^H^Htype checking performed
> on function parameters, requiring to add more ugly checks.

Indeed, and the resulting mess is (at least in my opinion) considerably
worse than where we were in 5.3 and earlier kernels with 'inline' defined
as '__always_inline'.

Will
