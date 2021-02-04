Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B123030FE52
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhBDU3E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 4 Feb 2021 15:29:04 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:38078 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbhBDU24 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:28:56 -0500
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 0C55230278CD;
        Thu,  4 Feb 2021 21:28:05 +0100 (CET)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id D4F1840C9DA3; Thu,  4 Feb 2021 21:28:05 +0100 (CET)
Message-ID: <42d2542d4b7f9836121b92d9bf349afa920bd4cd.camel@klomp.org>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
From:   Mark Wielaard <mark@klomp.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <nathan@kernel.org>
Date:   Thu, 04 Feb 2021 21:28:05 +0100
In-Reply-To: <CAKwvOdmT4t==akMN7eHWgD_XdpN--PLpUj8vgujGJ4TpREvteQ@mail.gmail.com>
References: <20210130004401.2528717-1-ndesaulniers@google.com>
         <20210130004401.2528717-2-ndesaulniers@google.com>
         <20210204103946.GA14802@wildebeest.org>
         <CAKwvOdm0O8m_+mxy7Z91Lu=Hzf6-DyCdAjMOsCRiMmNis4Pd2A@mail.gmail.com>
         <20fdd20fe067dba00b349407c4a0128c97c1a707.camel@klomp.org>
         <CAKwvOdmT4t==akMN7eHWgD_XdpN--PLpUj8vgujGJ4TpREvteQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2021-02-04 at 12:04 -0800, Nick Desaulniers wrote:
> On Thu, Feb 4, 2021 at 11:56 AM Mark Wielaard <mark@klomp.org> wrote:
> > I agree with Jakub. Now that GCC has defaulted to DWARF5 all the
> > tools
> > have adopted to the new default version. And DWARF5 has been out
> > for
> 
> "all of the tools" ?

I believe so yes, we did a mass-rebuild of all of Fedora a few weeks
back with a GCC11 pre-release and did find some tools which weren't
ready, but as far as I know all have been fixed now. I did try to
coordinate with the Suse and Debian packagers too, so all the major
distros should have all the necessary updates once switching to GCC11.

> > more than 4 years already. It isn't unreasonable to assume that people
> > using GCC11 will also be using the rest of the toolchain that has moved
> > on. Which DWARF consumers are you concerned about not being ready for
> > GCC defaulting to DWARF5 once GCC11 is released?
> 
> Folks who don't have top of tree pahole or binutils are the two that
> come to mind.

I believe pahole just saw a 1.20 release. I am sure it will be widely
available once GCC11 is released (which will still be 1 or 2 months)
and people are actually using it. Or do you expect distros/people are
going to upgrade to GCC11 without updating their other toolchain tools?
BTW. GCC11 doesn't need top of tree binutils, it will detect the
binutils capabilities (bugs) and adjust its DWARF output based on it.

>   I don't have specifics on out of tree consumers, but
> some Aarch64 extensions which had some changes to DWARF for ARMv8.3
> PAC support broke some debuggers.

It would be really helpful if you could provide some specifics. I did
fix some consumers to handle the PAC operands in CFI last year, but I
don't believe that had anything to do with the default DWARF version,
just with dealing with DW_CFA_AARCH64_negate_ra_state.

> I don't doubt a lot of work has gone into fixing many downstream
> projects and then when building everything from ToT that there are no
> issues with DWARF v5.  The issue is getting upgrades into developers
> hands, and what to default to until then.

I would suggest you simply default to what you already do when the
compiler is given -g. Just like you do already for the implicit default
-std=gnuc*. Once GCC11 is actually released and people upgrade their
toolchain to use it the tools will be ready and in developers hands.

Cheers,

Mark
