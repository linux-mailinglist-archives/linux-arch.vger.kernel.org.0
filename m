Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BFACAA86
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfJCRHo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Oct 2019 13:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404386AbfJCQgP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Oct 2019 12:36:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C33F2070B;
        Thu,  3 Oct 2019 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120574;
        bh=judodVvtfyPO1QPUMh5cBC0ImVnKv7kctqKG1EVeODU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w8bZ+hMV38XC1vWA/KGyoQUuiE4RMwZVD9yuxNZqO981Z3pQMRsrpGiZPZo57qbw1
         2NiUg7aTcpDliYgmtTHGHRnbLrGUeclrjXfMhOUoXSYlXrxMkyKovSCk2lBulZwJOw
         bNJJjmxrrIkGjj1w8uy8Xd6xBBr/QuxGzun0vLdI=
Date:   Thu, 3 Oct 2019 17:36:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
Message-ID: <20191003163606.iqzcxvghaw7hdqb5@willie-the-truck>
References: <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
 <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
 <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk>
 <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 02, 2019 at 01:39:40PM -0700, Linus Torvalds wrote:
> On Wed, Oct 2, 2019 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > >
> > > Then use the C preprocessor to force the inlining.  I'm sorry it's not
> > > as pretty as static inline functions.
> >
> > Which makes us lose the baby^H^H^H^Htype checking performed
> > on function parameters, requiring to add more ugly checks.
> 
> I'm 100% agreed on this.
> 
> If the inline change is being pushed by people who say "you should
> have used macros instead if you wanted inlining", then I will just
> revert that stupid commit that is causing problems.
> 
> No, the preprocessor is not the answer.
> 
> That said, code that relies on inlining for _correctness_ should use
> "__always_inline" and possibly even have a comment about why.
> 
> But I am considering just undoing commit 9012d011660e ("compiler:
> allow all arches to enable CONFIG_OPTIMIZE_INLINING") entirely. The
> advantages are questionable, and when the advantages are balanced
> against actual regressions and the arguments are "use macros", that
> just shows how badly thought out this was.

It's clear that opinions are divided on this issue, but you can add
an enthusiastic:

Acked-by: Will Deacon <will@kernel.org>

if you go ahead with the revert. I'm all for allowing the compiler to
make its own inlining decisions, but not when the potential for
miscompilation isn't fully understood and the proposed alternatives turn
the source into an unreadable mess. Perhaps we can do something different
for 5.5 (arch opt-in? clang only? invert the logic? work to move functions
over to __always_inline /before/ flipping the CONFIG option? ...?)

Will
