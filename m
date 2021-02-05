Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65F3311504
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhBEWWf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 17:22:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232630AbhBEO26 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Feb 2021 09:28:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D08C264D92;
        Fri,  5 Feb 2021 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612541205;
        bh=m0Ived/Gtw9H0h9wzJs3877Bi8G+nGI9iZ9HA2qfSi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N19lstyfIjNxGz0mYNCERX8vzhh1nu7jBG58K4mykiqzTPnAy4sUWlGy2fihm8BZi
         2hvg6JcH/74yAAhr6kGe8CSdh/ZWeu7AyEJ/8qD47xa5QJXEcaBroFOEc+OXUz08Kp
         qhqV4TzpAkO2qCCq6/smiou/HyIojpMLPsUEmQSznsUqfZar1K0byzoV/LkJWHiyNf
         GSn6boP/u4Jy3y4I3pqrJKex77yGszmnrQq2B9G46HiUhOHS3NpdMcNFKD1T+gKx66
         v6VBSmMkbxAta0qgbDwCXodwiEat97uh2Wh2Hy5PeLCJ7Pi/wtO0lNQ74b3RcRPfKe
         1dLN2PLyiSV1w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3750740513; Fri,  5 Feb 2021 13:06:41 -0300 (-03)
Date:   Fri, 5 Feb 2021 13:06:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>
Subject: Re: [FIXED] Re: 5:11: in-kernel BTF is malformed
Message-ID: <20210205160641.GE920417@kernel.org>
References: <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
 <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
 <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com>
 <20210204010038.GA854763@kernel.org>
 <CAJCQCtQfgRp78_WSrSHLNUUYNCyOCH=vo10nVZW_cyMjpZiNJg@mail.gmail.com>
 <CAEf4Bza4XQxpS7VTNWGk6Rz-iUwZemF6+iAVBA_yvrWnV0k8Qg@mail.gmail.com>
 <CAJCQCtRDJ_uiJcanP_p+y6Kz76c4P-EmndMyfHN5f4rtkgYhjA@mail.gmail.com>
 <20210204132625.GB910119@kernel.org>
 <20210204163319.GD910119@kernel.org>
 <CAJCQCtT-i0Lv2zxUDko3XuiHpUqOnYPeND5LzD=zgrB1-GNvAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtT-i0Lv2zxUDko3XuiHpUqOnYPeND5LzD=zgrB1-GNvAg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Thu, Feb 04, 2021 at 08:10:52PM -0700, Chris Murphy escreveu:
> On Thu, Feb 4, 2021 at 9:33 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > So I think that for the problems related to building the kernel with gcc
> > 11 in Fedora Rawhide using the default that is now DWARF5, pahole 1.20
> > is good to go and I'll tag it now.
> 
> dwarves-1.20-1.fc34.x86_64
> libdwarves1-1.20-1.fc34.x86_64
> 
> Fixes both "failed to validate module [?????] BTF: -22" type errors,
> and 'in-kernel BTF is malformed" with qemu-kvm and libvirt.

Cool! Any fedora user here please give the update some love by bumping
its karma at:

https://bodhi.fedoraproject.org/updates/FEDORA-2021-804e7a572c

- Arnaldo
