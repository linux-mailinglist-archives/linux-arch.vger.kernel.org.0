Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB63310B6B
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 13:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhBEMxv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 5 Feb 2021 07:53:51 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:52398 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbhBEMun (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2021 07:50:43 -0500
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 7CA5430278CD;
        Fri,  5 Feb 2021 13:49:25 +0100 (CET)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id 3300D4000D37; Fri,  5 Feb 2021 13:49:25 +0100 (CET)
Message-ID: <8696ef2e86c5d8078bf2d2c74fb3cbbecbd22c83.camel@klomp.org>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
From:   Mark Wielaard <mark@klomp.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
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
        Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Fri, 05 Feb 2021 13:49:24 +0100
In-Reply-To: <CAKwvOdmHM8srtLaEy+L_XGzO9TBbhP3csQNAhUTH_TmeDePkDQ@mail.gmail.com>
References: <20210130004401.2528717-1-ndesaulniers@google.com>
         <20210130004401.2528717-2-ndesaulniers@google.com>
         <20210204103946.GA14802@wildebeest.org>
         <CAKwvOdm0O8m_+mxy7Z91Lu=Hzf6-DyCdAjMOsCRiMmNis4Pd2A@mail.gmail.com>
         <20fdd20fe067dba00b349407c4a0128c97c1a707.camel@klomp.org>
         <CAKwvOdmT4t==akMN7eHWgD_XdpN--PLpUj8vgujGJ4TpREvteQ@mail.gmail.com>
         <42d2542d4b7f9836121b92d9bf349afa920bd4cd.camel@klomp.org>
         <CAKwvOdmHM8srtLaEy+L_XGzO9TBbhP3csQNAhUTH_TmeDePkDQ@mail.gmail.com>
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

Hi Nick,

On Thu, 2021-02-04 at 14:06 -0800, Nick Desaulniers wrote:
> On Thu, Feb 4, 2021 at 12:28 PM Mark Wielaard <mark@klomp.org> wrote:
> > I believe so yes, we did a mass-rebuild of all of Fedora a few weeks
> > back with a GCC11 pre-release and did find some tools which weren't
> > ready, but as far as I know all have been fixed now. I did try to
> 
> Congrats, I'm sure that was _a lot_ of work.  Our toolchain folks have
> been pouring a lot of effort over getting our internal code all moved
> over, and it doesn't look like it's been easy from my perspective.
> 
> > coordinate with the Suse and Debian packagers too, so all the major
> > distros should have all the necessary updates once switching to GCC11.
> 
> That's great for users of the next Fedora release who can and will
> upgrade, but I wouldn't assume kernel developers can, or will (or are
> even using those distros).

And that is fine, then they will probably also not run GCC11 yet when
it gets released. GCC11 (and Fedora34) will not be released for another
2 months. By then I hope all issues found have made it into upstream
releases.

> My intent is very much to allow for users of toolchains that have not
> switched the implicit default (such as all of the supported versions
> of GCC that have been released ie. up to GCC 10.2, and Clang; so all
> toolchains the kernel still supports) to enjoy the size saving of
> DWARF v5, and find what other tooling needs to be updated.

Which seems a good thing. No complaints about making it easier to
experiment with DWARFv5 for such older compiler releases.

> Does no one test linux kernel builds with top of tree GCC built from
> source?

Fedora rawhide (f34) builds rc kernels against GCC11 ToT now:
https://koji.fedoraproject.org/koji/packageinfo?packageID=8

>   Or does that require "updating their other toolchain tools?"
> If I build ToT GCC from source, do I need to do the same for
> binutils-gdb in order to build the kernel?  Pretty sure I don't.

It isn't required, but then GCC won't produce full DWARF5 (e.g. line
tables are then still emitted as DWARF4).

> https://bugzilla.redhat.com/show_bug.cgi?id=1922707 and
> https://bugzilla.redhat.com/show_bug.cgi?id=1922698 look like user
> reports to me, but hopefully some CI system reported earlier that
> builds of the Linux kernel with GCC 11 pre release would produce the
> warnings from those bug report.  Otherwise it looks like evidence that
> users "are going to upgrade to GCC11 without updating their other
> toolchain tools."  In the case of pahole, they could not, because
> fixes were not yet written.  "Just upgrade" doesn't work if there's no
> fix yet upstream.  (pahole is reported fixed for that specific issue,
> FWIW).

So those are users that are participating in the Fedora rawhide
experiment with the GC11-prerelease. That are precisely the bug reports
we need to make sure we caught all issues before the final release. I
don't think that is any different from users trying out rc kernels and
finding issues that are then fixed.

> > > I don't doubt a lot of work has gone into fixing many downstream
> > > projects and then when building everything from ToT that there are no
> > > issues with DWARF v5.  The issue is getting upgrades into developers
> > > hands, and what to default to until then.
> > 
> > I would suggest you simply default to what you already do when the
> > compiler is given -g. Just like you do already for the implicit default
> > -std=gnuc*. Once GCC11 is actually released and people upgrade their
> > toolchain to use it the tools will be ready and in developers hands.
> 
> Hmmm...thinking about this more over lunch.
> 
> I think the linker script additions for the new DWARF v5 sections are
> most important.  There's no need to hold those hostage over what we do
> with the configs. They are orthogonal, and can go in first.  There's
> already one section in the linker script already related to v5, and we
> know that DWARF v5 is coming, so there's no reason not to just add
> them.  That would resolve
> https://bugzilla.redhat.com/show_bug.cgi?id=1922707.

Yes, that patch seems fine without any of the other config changes. It
would be nice to see that go in.

> For configs, today the kernel has an explicit opt in for DWARF v4
> called CONFIG_DEBUG_INFO_DWARF4.  When it was introduced, I suspect
> DWARF v2 (or v3) was the default, so it let kernel developers opt in
> to newer versions (say, for testing) than what was the implicit
> default version.  With the advent of DWARF v5 and toolchains moving to
> producing that by default, maybe there is still a place for
> CONFIG_DEBUG_INFO_DWARF4, but as a way to opt in to older versions.
> Your installed version of pahole or binutils is too old for DWARF v5?
> Great, CONFIG_DEBUG_INFO_DWARF4 is your friend until you can update
> your tools.  CONFIG_DEBUG_INFO_DWARF4 becomes "opt backwards" rather
> than it's original "opt forwards" (if that makes sense).
> 
> One small issue I have with that is that it doesn't help users of GCC
> 5 through 10.2 (or clang) opt into DWARF v5 (to test, or for the size
> savings) similar to the original intent of CONFIG_DEBUG_INFO_DWARF4.
> That was my intent with this series; to opt into new versions so we
> can begin testing them and finding kinks in other tools.  It was not
> intentionally to hold back compilers once they upgrade their default
> versions, even if I still think explicit is better than implicit.  And
> it would be nice to have the framework to continue to do so for v6
> someday.
> 
> So opting in to v4 explicitly provides a "pressure relief valve" for
> developers that don't have the latest tools.  Opting into v5
> explicitly allows for testing of those tools with the latest DWARF
> version (and size savings that are worthwhile) for folks with older
> GCC and Clang.
> 
> What are your thoughts on this?

Yes, being able to opt into DWARF4 if you have some newer tools like
GCC11 that already default to version 5, but not others, like an old
pahole release that doesn't handle version 5 yet would be nice to have.
But I don't think that is a very likely scenario given that pahole (and
binutils) already got a new releases and GCC11 won't be released for a
couple of months yet.

Likewise having the option to opt into DWARF5 even though some of the
tools don't default to (or fully support) DWARF5 yet seems a good idea.
Just for users to see whether that works with all their tools.

> What if I modified the config to have 3 options:
> 1. (default) CONFIG_DEBUG_INFO_DWARF_VERSION_DONT_CARE (I'm open to a
> better color for the bikeshed). Does not set a -gdwarf-*.  This is the
> status quo today when you build the kernel.  You allow toolchain
> developers to decide your fate. If that makes you unhappy, congrats,
> you have the below options.

My color of the bikeshed would be
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT.

> 2. CONFIG_DEBUG_INFO_DWARF4 (the ship has already sailed on the name
> here, sorry) Explicitly sets -gdwarf-4. Use this if you have a good
> reason not to upgrade to the recommended -gdwarf-5.  We might
> disappear this option soon. (already exists in tree today, and doesn't
> need to be removed; instead repurposed)
> 3. CONFIG_DEBUG_INFO_DWARF5 Explicitly sets -gdwarf-5.  Use this if
> you would like to opt into a newer version than what's provided by
> default.  Provides significant size savings over DWARF v4. Avoid if
> you have broken shit you can't upgrade for whatever reason?
> 
> Then I think everyone can be happy? Toolchain vendors can to continue
> pursuing updates of implicit default dwarf version (aggressive, but
> necessary force adoption, perhaps), BTF/pahole/binutils users can
> downgrade until they have the necessary updates, and developers with
> older GCC and clang can opt in new features without having to upgrade
> the toolchain's implicit default (since that requires significant work
> for other codebases, but is making progress) and still realize the
> binary size savings.

That would certainly make me happy :)

Thanks,

Mark
