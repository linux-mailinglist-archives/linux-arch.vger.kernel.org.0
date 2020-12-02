Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B512CB2F3
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 03:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgLBCyn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 21:54:43 -0500
Received: from condef-01.nifty.com ([202.248.20.66]:16984 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgLBCyn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 21:54:43 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2020 21:54:42 EST
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-01.nifty.com with ESMTP id 0B22iHKQ013099;
        Wed, 2 Dec 2020 11:44:17 +0900
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 0B22gx4q032295;
        Wed, 2 Dec 2020 11:42:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 0B22gx4q032295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1606876979;
        bh=//nWGYyIDtis41/3ZWUbaJfDU17XquHuh1VxESk+fpY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YhmiZCSWdh+h7s2WRTav0INDhIR0rcnW35LlnpIfVUtKyPSMmn+U17B/PK2aeTfa0
         fTnIGUz3KTJn2M/uiSK20i3edyMDKfviF8pdQau6NsNFuR5b+RtdIG7+HHZ9VW1XBz
         0GSmvELzZl434j3vtGAy0eAhTaGhMeqCKOAa5PHzgTqSpTWn8ylQtVj1qzI0S88FpS
         5Qmc1v9gpgH4CSlyu1l3vJez8xoPDRUopIN9fnCrE1/m/NaN6WWHtUaRXetDnkb7Qh
         ClAnpe17jQ5AWERHhKiobDQLrM8nw0OP1rORNoH9up9fs2A9pm23zlyZViLl2L/fJF
         iti0WfF94tSpA==
X-Nifty-SrcIP: [209.85.210.182]
Received: by mail-pf1-f182.google.com with SMTP id y7so260820pfq.11;
        Tue, 01 Dec 2020 18:42:59 -0800 (PST)
X-Gm-Message-State: AOAM532sqHjnu2Q91CS7sGZ32cLRiVh074gCuaIH6ycxqvFH0zD3eZl0
        lYqG4GbJRq0Bp/Odz0lqqnAuigEzabKBg/2cZxw=
X-Google-Smtp-Source: ABdhPJzi9iDwIta7ZmCbotxfEvvd7Hv2CLzIMvLHO3nRGZI4HCgMqMJzj1Z+ul8DEREU6Yg0tTulHGqnbS5vWd1Hxg8=
X-Received: by 2002:aa7:9606:0:b029:198:14c4:4f44 with SMTP id
 q6-20020aa796060000b029019814c44f44mr748749pfg.80.1606876978646; Tue, 01 Dec
 2020 18:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201130120130.GF24563@willie-the-truck> <202012010929.3788AF5@keescook>
In-Reply-To: <202012010929.3788AF5@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 2 Dec 2020 11:42:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQPOGohtUyzBM6n54pzpLN35kDXC7VbvWzX8QWUmqq9g@mail.gmail.com>
Message-ID: <CAK7LNASQPOGohtUyzBM6n54pzpLN35kDXC7VbvWzX8QWUmqq9g@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 2, 2020 at 2:31 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Nov 30, 2020 at 12:01:31PM +0000, Will Deacon wrote:
> > Hi Sami,
> >
> > On Wed, Nov 18, 2020 at 02:07:14PM -0800, Sami Tolvanen wrote:
> > > This patch series adds support for building the kernel with Clang's
> > > Link Time Optimization (LTO). In addition to performance, the primary
> > > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> > > be used in the kernel. Google has shipped millions of Pixel devices
> > > running three major kernel versions with LTO+CFI since 2018.
> > >
> > > Most of the patches are build system changes for handling LLVM bitcode,
> > > which Clang produces with LTO instead of ELF object files, postponing
> > > ELF processing until a later stage, and ensuring initcall ordering.
> > >
> > > Note that v7 brings back arm64 support as Will has now staged the
> > > prerequisite memory ordering patches [1], and drops x86_64 while we work
> > > on fixing the remaining objtool warnings [2].
> >
> > Sounds like you're going to post a v8, but that's the plan for merging
> > that? The arm64 parts look pretty good to me now.
>
> I haven't seen Masahiro comment on this in a while, so given the review
> history and its use (for years now) in Android, I will carry v8 (assuming
> all is fine with it) it in -next unless there are objections.


What I dislike about this implementation is
it cannot drop any unreachable function/data.
(and it is completely different from GCC LTO)

This is not real LTO.




> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202012010929.3788AF5%40keescook.



-- 
Best Regards
Masahiro Yamada
