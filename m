Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D53311E5A
	for <lists+linux-arch@lfdr.de>; Sat,  6 Feb 2021 16:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhBFPNs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Feb 2021 10:13:48 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:45862 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhBFPNp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Feb 2021 10:13:45 -0500
Received: from librem (deer0x15.wildebeest.org [172.31.17.151])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id DFFA33027634;
        Sat,  6 Feb 2021 16:12:59 +0100 (CET)
Received: by librem (Postfix, from userid 1000)
        id 41626C100B; Sat,  6 Feb 2021 16:11:51 +0100 (CET)
Date:   Sat, 6 Feb 2021 16:11:51 +0100
From:   Mark Wielaard <mark@klomp.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jakub Jelinek <jakub@redhat.com>, Nick Clifton <nickc@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
Message-ID: <20210206151151.GB2851@wildebeest.org>
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com>
 <20210204103946.GA14802@wildebeest.org>
 <CAKwvOdm0O8m_+mxy7Z91Lu=Hzf6-DyCdAjMOsCRiMmNis4Pd2A@mail.gmail.com>
 <20fdd20fe067dba00b349407c4a0128c97c1a707.camel@klomp.org>
 <CAKwvOdmT4t==akMN7eHWgD_XdpN--PLpUj8vgujGJ4TpREvteQ@mail.gmail.com>
 <42d2542d4b7f9836121b92d9bf349afa920bd4cd.camel@klomp.org>
 <CAKwvOdmHM8srtLaEy+L_XGzO9TBbhP3csQNAhUTH_TmeDePkDQ@mail.gmail.com>
 <8696ef2e86c5d8078bf2d2c74fb3cbbecbd22c83.camel@klomp.org>
 <CAKwvOd=jMykgiR+fthEVeaP1c3-N6veZhKd2LZjeJ5KaqF4PHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=jMykgiR+fthEVeaP1c3-N6veZhKd2LZjeJ5KaqF4PHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nick,

On Fri, Feb 05, 2021 at 01:18:11PM -0800, Nick Desaulniers wrote:
> On Fri, Feb 5, 2021 at 4:49 AM Mark Wielaard <mark@klomp.org> wrote:
> I guess I'm curious whether
> https://bugzilla.redhat.com/show_bug.cgi?id=1922707 came up during the
> mass rebuild of all of Fedora a few weeks ago?  Assuming the Linux
> kernel was part of that test, those warnings would have been both new
> and obviously related to changing the implicit default DWARF version.

Yes, looking at the build.log that warning was also present.  But the
dwarves pahole update to process DWARF5 was more important.  Also at
first it was believed this came from the binutils ld linker
scripts. Which were also updated first. Once your patch is accepted we
can resolve that bug.

Cheers,

Mark
