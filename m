Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08742D485F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Dec 2020 18:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgLIRwk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Dec 2020 12:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgLIRwe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Dec 2020 12:52:34 -0500
X-Gm-Message-State: AOAM530y4QUf0cGgU8zIRU8GLYcT9iFMN2zPz6qZljF3tBpaqdUei+kM
        PYF8OBSdIJK0mBtVaUng82kgkNjcDBZ33/ojEgA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607536312;
        bh=PkhafiKufzKb4ug4EZv6MWBGYou8NhXyEMjpgO/uc5E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nO+yHSD0aD/myoaEBloVJSGAXz/9Z9jr2v13Ie8CZZquSOaxn9x54EWCBKPspHYr9
         C7ov27bcIKqHGqsw0G2b+SRoGTpaMyzBiPtAowkH+Ri14rs1FZxhzgI1YDBJU3B6Yh
         wsPQInRPENeXuhDzJK8x93nWLhePtzQbjVQ4JCq8GZAw33D4KaIEBkodUp45W78tZY
         oMFyQlU9exNc1aSWvJld48xqQbYIdgpTXz8nY/aMrldCE2NXZTQj2Tn4uTZWfo1B5Q
         6pvYNvOpCKBRZd+m8zIp2GDb95NKAzMEotGY/d8IZOzA4HjydrO2M2hq91pKktRA4J
         D4lKm4IJ0IP/Q==
X-Google-Smtp-Source: ABdhPJwZtZIjXcrCwL02Q3BtuaRQhJR6T9E0Dq/dAi3/J5U0ZXsANoGU6mTtSwfetrFJDwqXgvlouDcEx+44OiL8SQA=
X-Received: by 2002:aca:bd0b:: with SMTP id n11mr2533645oif.11.1607536311473;
 Wed, 09 Dec 2020 09:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
 <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
 <CAK8P3a2DYDCjkqf7oqWFfBT_=rjyJGgnh6kBzUkR8GyvxsB6uQ@mail.gmail.com> <CABCJKud7ZC7_rXVmrF5PnDOMZTJX9iB7uYAa03YF-dkEojnBxg@mail.gmail.com>
In-Reply-To: <CABCJKud7ZC7_rXVmrF5PnDOMZTJX9iB7uYAa03YF-dkEojnBxg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 9 Dec 2020 18:51:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a04nQwJkK-CPWNzvfKavZnHQYzKX5OGB7Rm3Ee_62oXhA@mail.gmail.com>
Message-ID: <CAK8P3a04nQwJkK-CPWNzvfKavZnHQYzKX5OGB7Rm3Ee_62oXhA@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 9, 2020 at 5:25 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On Wed, Dec 9, 2020 at 4:36 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Dec 8, 2020 at 1:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> >
> > It seems to happen because of CONFIG_TRIM_UNUSED_KSYMS,
> > which is a shame, since I think that is an option we'd always want to
> > have enabled with LTO, to allow more dead code to be eliminated.
>
> Ah yes, this is a known issue. We use TRIM_UNUSED_KSYMS with LTO in
> Android's Generic Kernel Image and the problem is that bitcode doesn't
> yet contain calls to these functions, so autoksyms won't see them. The
> solution is to use a symbol whitelist with LTO to prevent these from
> being trimmed. I suspect we would need a default whitelist for LTO
> builds.

A built-in allowlist sounds good to me. FWIW, in the randconfigs so far, I only
saw five symbols that would need to be on it:

memcpy(), memmove(), memset(), __stack_chk_fail() and __stack_chk_guard

       Arnd
