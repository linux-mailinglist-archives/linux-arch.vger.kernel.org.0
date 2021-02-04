Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FFA30FD78
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 20:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhBDT5w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 4 Feb 2021 14:57:52 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:37446 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbhBDT46 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 14:56:58 -0500
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id DA19930278CD;
        Thu,  4 Feb 2021 20:56:05 +0100 (CET)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id 880BF40C9DA3; Thu,  4 Feb 2021 20:56:05 +0100 (CET)
Message-ID: <20fdd20fe067dba00b349407c4a0128c97c1a707.camel@klomp.org>
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
Date:   Thu, 04 Feb 2021 20:56:05 +0100
In-Reply-To: <CAKwvOdm0O8m_+mxy7Z91Lu=Hzf6-DyCdAjMOsCRiMmNis4Pd2A@mail.gmail.com>
References: <20210130004401.2528717-1-ndesaulniers@google.com>
         <20210130004401.2528717-2-ndesaulniers@google.com>
         <20210204103946.GA14802@wildebeest.org>
         <CAKwvOdm0O8m_+mxy7Z91Lu=Hzf6-DyCdAjMOsCRiMmNis4Pd2A@mail.gmail.com>
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

On Thu, 2021-02-04 at 11:18 -0800, Nick Desaulniers wrote:
> On Thu, Feb 4, 2021 at 2:41 AM Mark Wielaard <mark@klomp.org> wrote:
> > On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> > > Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> > > the default. Does so in a way that's forward compatible with existing
> > > configs, and makes adding future versions more straightforward.
> > > 
> > > GCC since ~4.8 has defaulted to this DWARF version implicitly.
> > 
> > And since GCC 11 it defaults to DWARF version 5.
> > 
> > It would be better to set the default to the DWARF version that the
> > compiler generates. So if the user doesn't select any version then it
> > should default to just -g (or -gdwarf).
> 
> I disagree.
> 
> https://lore.kernel.org/lkml/CAKwvOdk0zxewEOaFuqK0aSMz3vKNzDOgmez=-Dae4+bodsSg5w@mail.gmail.com/
> """
> I agree that this patch takes away the compiler vendor's choice as to
> what the implicit default choice is for dwarf version for the kernel.
> (We, the Linux kernel, do so already for implicit default -std=gnuc*
> as well). ...
> But I'm
> going to suggest we follow the Zen of Python: explicit is better than
> implicit.
> """
> We have a number of in tree and out of tree DWARF consumers that
> aren't ready for DWARF v5.  Kernel developers need a way to disable
> DWARF v5 until their dependencies are deployed or more widely
> available.

I agree with Jakub. Now that GCC has defaulted to DWARF5 all the tools
have adopted to the new default version. And DWARF5 has been out for
more than 4 years already. It isn't unreasonable to assume that people
using GCC11 will also be using the rest of the toolchain that has moved
on. Which DWARF consumers are you concerned about not being ready for
GCC defaulting to DWARF5 once GCC11 is released?

Thanks,

Mark
