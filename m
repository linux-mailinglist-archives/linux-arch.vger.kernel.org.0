Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05CB3255F3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 19:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhBYS7P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 13:59:15 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:19621 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhBYS7I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 13:59:08 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 11PIw0du009804;
        Fri, 26 Feb 2021 03:58:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 11PIw0du009804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614279480;
        bh=YWSVUhATietGB4YUQJPH19+jt11VEF3gBJH/ogv8kWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iMvGIKa4zfgDP+r0/PrtqApwL6YlvoyvFLW26423kkWMcgTnni+saZjamGtzZ1RaM
         Zx8iPj6EQFPBVxBnSvKoN1kNSfzQOdFLf0AoZes3BP+38OMbwfw9uV4GVsd0FLVMvD
         uAauAcrJkJ9np3/O9rrXDKr9DQ0j9DQ9Q/uHnU6m7UC+AqTj08WjQ6LG9PqVlc74XV
         H0MOYFOekChztAhJ7HIZA877Yw9Gs2pf51S6hcLovX+qQFQbkIp+GEwNXfxYpD8sEx
         Esf97FrNdqOkaq4R59Wj0K/0kZ9PAGY3zTBc3BxYnmzg12tbMXZl2bA9SRUbIceWZg
         ZIRXk47HyoHDg==
X-Nifty-SrcIP: [209.85.216.43]
Received: by mail-pj1-f43.google.com with SMTP id t5so5453704pjd.0;
        Thu, 25 Feb 2021 10:58:00 -0800 (PST)
X-Gm-Message-State: AOAM532p6Ja4n06+tsDKZjvP4pvSGDWIuTUDaJzslljx4qlB8vUL4sk9
        RiYxgzxBtrLZsDN2cC2HK2O19DkeJoW9lu4vWRA=
X-Google-Smtp-Source: ABdhPJzVBtNm5MiPch2M96LutE7a6ihODnGlhjBUxfFu/spqTqt7AHfG1oyc0UWWG3pV0Y5GImsFew+sF+e/2+aP1Fw=
X-Received: by 2002:a17:90a:5510:: with SMTP id b16mr4654264pji.87.1614279479596;
 Thu, 25 Feb 2021 10:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20210225160247.2959903-1-masahiroy@kernel.org> <r3584n3-sq21-qo49-9sp5-r3qp6o611s55@syhkavp.arg>
In-Reply-To: <r3584n3-sq21-qo49-9sp5-r3qp6o611s55@syhkavp.arg>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 26 Feb 2021 03:57:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQeL7jQt1RJjLbU7MUj7XGAwEAhtTvMocQw85uJj9NA9g@mail.gmail.com>
Message-ID: <CAK7LNAQeL7jQt1RJjLbU7MUj7XGAwEAhtTvMocQw85uJj9NA9g@mail.gmail.com>
Subject: Re: [PATCH 0/4] kbuild: build speed improvment of CONFIG_TRIM_UNUSED_KSYMS
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 26, 2021 at 2:20 AM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Fri, 26 Feb 2021, Masahiro Yamada wrote:
>
> >
> > Now CONFIG_TRIM_UNUSED_KSYMS is revived, but Linus is still unhappy
> > about the build speed.
> >
> > I re-implemented this feature, and the build time cost is now
> > almost unnoticeable level.
> >
> > I hope this makes Linus happy.
>
> :-)
>
> I'm surprised to see that Linus is using this feature. When disabled
> (the default) this should have had no impact on the build time.

Linus is not using this feature, but does build tests.
After pulling the module subsystem pull request in this merge window,
CONFIG_TRIM_UNUSED_KSYMS was enabled by allmodconfig.


> This feature provides a nice security advantage by significantly
> reducing the kernel input surface. And people are using that also to
> better what third party vendor can and cannot do with a distro kernel,
> etc. But that's not the reason why I implemented this feature in the
> first place.
>
> My primary goal was to efficiently reduce the kernel binary size using
> LTO even with kernel modules enabled.


Clang LTO landed in this MW.

Do you think it will reduce the kernel binary size?
No, opposite.

CONFIG_LTO_CLANG cannot trim any code even if it
is obviously unused.
Hence, it never reduces the kernel binary size.
Rather, it produces a bigger kernel.

The reason is Clang LTO was implemented against
relocatable ELF (vmlinux.o) .

I pointed out this flaw in the review process, but
it was dismissed.

This is the main reason why I did not give any Ack
(but it was merged via Kees Cook's tree).


So, the help text of this option should be revised:

          This option allows for unused exported symbols to be dropped from
          the build. In turn, this provides the compiler more opportunities
          (especially when using LTO) for optimizing the code and reducing
          binary size.  This might have some security advantages as well.

Clang LTO is opposite to your expectation.



> Each EXPORT_SYMBOL() created a
> symbol dependency that prevented LTO from optimizing out the related
> code even though a tiny fraction of those exported symbols were needed.
>
> The idea behind the recursion was to catch those cases where disabling
> an exported symbol within a module would optimize out references to more
> exported symbols that, in turn, could be disabled and possibly trigger
> yet more code elimination. There is no way that can be achieved without
> extra compiler passes in a recursive manner.

I do not understand.

Modules are relocatable ELF.
Clang LTO cannot eliminate any code.
GCC LTO does not work with relocatable ELF
in the first place.


Are you talking about a story in a perfect world?
But, I do not know how LTO can eliminate dead code
from relocatable ELF.




- Current implementation

  CLANG LTO works against vmlinux.o,
  so it is completely useless for the purpose of
  eliminating dead code.

  So, this case is don't care.
  TRIM_UNUSED_KSYMS removes only the meta data of EXPORT_SYMBOL,
  but no further optimization anyway.


- What if Clang LTO had been implemented in the final link?
   (this means LTO runs 3 times if KALLSYMS_ALL is enabled)

  With proper linker script input with /DISCARD/,
  the meta-data of EXPORT_SYMBOL() will be dropped,
  and LTO should be able to do further dead code elimination.
  So, I guess we do not need to no-op EXPORT_SYMBOL by CPP
  (unless I am missing something).






--
Best Regards
Masahiro Yamada
