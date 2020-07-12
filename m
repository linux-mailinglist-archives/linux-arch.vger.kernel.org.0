Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AFB21CAF9
	for <lists+linux-arch@lfdr.de>; Sun, 12 Jul 2020 20:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgGLSkr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jul 2020 14:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgGLSkq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2020 14:40:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581C1C061794;
        Sun, 12 Jul 2020 11:40:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so4964198pfq.11;
        Sun, 12 Jul 2020 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5TJ+34sQAVUrawBXByyfuwrbgj6i1cli/YCTjxtCBqw=;
        b=N0HHcMjVGeZLZKs6kySBi/kLjx//vGsHRhAgAn70NbsmCWAMm2ggej1XEym1TkTrI2
         1RaGmxT5o0gLydjCDJGV76FDHQsG0/MeBmIbxTv5DSaT3TULK/IfbYlfepfNEkiMQmk9
         pMxE7Rt2/EFgEH7Quq7GvESDdpvWY+RbR8tRKc/SElrWfewWr1bDfzmOZAel5bastYU4
         l+o96BGwta1qZ7PRMbDolq2P/ebYU/wwwO2jQcK/mwQ0tlDCRPQ2vZa/eEBWU7Y6nUZT
         K+Ku0Xl1nF8NMzl71Sss8yD4qs25ojddZtL3UAw9gfH97kt9dPHm6QwrFWkINM8fPBxh
         i8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5TJ+34sQAVUrawBXByyfuwrbgj6i1cli/YCTjxtCBqw=;
        b=kAL1AeVGyXcUTUofp0qT+d9ROc/R+wNt8dkopupUEhPCuq/jc1Gt03KugsDzsJWjHE
         kTbvdlXOS1ARfYblQhGYzP2k4WKWO0LXMsc+wHHI9i12AfcqztZwwFR4Mn0qL20CJSKd
         5ko93DICDZ746tqkIMbQGw8Ux7fWnb65OK6njOnbUfhliP0sRSMF4zcZYnX/tzi4gbUH
         rQWDCxSNJeEFTm75E+husyEjPvCYJehGLRPNrArLY8ngcYyGZuImcQGF9s9ZPPhf1Q1H
         MthfEG4ZccIJvIibF+kJLndGP1qckdL8/swH10GRpYvfq0EvmjBu14MJ9PZroF+9bZWL
         XS6A==
X-Gm-Message-State: AOAM530cuBKZLMCPFlIHhYhM0C3cEo2tnJU+eT67XP7WKbV1JixTbzIl
        54JQLAiWqfkDuySCN7QZqbE=
X-Google-Smtp-Source: ABdhPJwaLeWOxzmuhJhjgAdmI0j3ddtpspQ4OkHVexe7PvXeW20GC370vRPp3GnVrW9KjIJcaky3VQ==
X-Received: by 2002:a62:29c6:: with SMTP id p189mr52732155pfp.55.1594579245655;
        Sun, 12 Jul 2020 11:40:45 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain (ip98-167-246-98.ph.ph.cox.net. [98.167.246.98])
        by smtp.gmail.com with ESMTPSA id ci23sm11966956pjb.29.2020.07.12.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 11:40:45 -0700 (PDT)
Date:   Sun, 12 Jul 2020 11:40:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200712184041.GA1838@Ryzen-9-3900X.localdomain>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
 <CA+icZUXPB_C1bjA13zi3OLFCpiZh+GsgHT0y6kumzVRavs4LkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUXPB_C1bjA13zi3OLFCpiZh+GsgHT0y6kumzVRavs4LkQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 12, 2020 at 10:59:17AM +0200, Sedat Dilek wrote:
> On Sat, Jul 11, 2020 at 6:32 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >
> > Dear Sami,
> >
> >
> > Am 24.06.20 um 22:31 schrieb Sami Tolvanen:
> > > This patch series adds support for building x86_64 and arm64 kernels
> > > with Clang's Link Time Optimization (LTO).
> > >
> > > In addition to performance, the primary motivation for LTO is to allow
> > > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > > Pixel devices have shipped with LTO+CFI kernels since 2018.
> > >
> > > Most of the patches are build system changes for handling LLVM bitcode,
> > > which Clang produces with LTO instead of ELF object files, postponing
> > > ELF processing until a later stage, and ensuring initcall ordering.
> > >
> > > Note that first objtool patch in the series is already in linux-next,
> > > but as it's needed with LTO, I'm including it also here to make testing
> > > easier.
> >
> > […]
> >
> > Thank you very much for sending these changes.
> >
> > Do you have a branch, where your current work can be pulled from? Your
> > branch on GitHub [1] seems 15 months old.
> >
> 
> Agreed it's easier to git-pull.
> I have seen [1] - not sure if this is the latest version.
> Alternatively, you can check patchwork LKML by searching for $submitter.
> ( You can open patch 01/22 and download the whole patch-series by
> following the link "series", see [3]. )
> 
> - Sedat -
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/log/?h=lto
> [2] https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=19676
> [3] https://lore.kernel.org/patchwork/series/450026/mbox/
> 

Sami tagged this series on his GitHub:

https://github.com/samitolvanen/linux/releases/tag/lto-v1

git pull https://github.com/samitolvanen/linux lto-v1

Otherwise, he is updating the clang-cfi branch that includes both the
LTO and CFI patchsets. You can pull that and just turn on
CONFIG_LTO_CLANG.

Lastly, for the future, I would recommend grabbing b4 to easily apply
patches (specifically full series) from lore.kernel.org.

https://git.kernel.org/pub/scm/utils/b4/b4.git/
https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/README.rst

You could grab this series and apply it easily by either downloading the
mbox file and following the instructions it gives for applying the mbox
file:

$ b4 am 20200624203200.78870-1-samitolvanen@google.com

or I prefer piping so that I don't have to clean up later:

$ b4 am -o - 20200624203200.78870-1-samitolvanen@google.com | git am

Cheers,
Nathan
