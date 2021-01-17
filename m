Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD52F9510
	for <lists+linux-arch@lfdr.de>; Sun, 17 Jan 2021 21:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbhAQUPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Jan 2021 15:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbhAQUPI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 Jan 2021 15:15:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0262221D7F;
        Sun, 17 Jan 2021 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610914468;
        bh=/275w1gmJINORnvZPOCvbcQvFYNu59iWeBPKZ1AiDLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbo6wEePj/G4UWwJpJc3Yl6I8K14+p9MFY6rNzEg2khiXV2pIH35IA1oyvlPrXMHZ
         H9KE+O30jdsfGkpXuzp9XVyGBM9WBymy7cURCikQ2VhCObmDHIMnGWnAwFy4r9Ot1i
         0siB0NSpehbI+6hEznDoN22w0sEW2aGthCHHp1e8gXbp9z8YaCHV2ptG9mavRadq4M
         yPdHlKK/8xovZS97HsRLHvyS6VH59ZH0nc6/K/b1VUuWdbD3iy0Iz7ksAZkw3Md/BG
         LCAy4p/egLE8B9dvauwF1OSwJd58W2kr5AaSPsYRY7TlQ0C5ZfyVF8yGtlpWB6emg9
         UbhigWiEllWaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A020540522; Sun, 17 Jan 2021 17:15:00 -0300 (-03)
Date:   Sun, 17 Jan 2021 17:15:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
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
        Nick Clifton <nickc@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
Message-ID: <20210117201500.GO457607@kernel.org>
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com>
 <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
 <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Fri, Jan 15, 2021 at 03:43:06PM -0800, Yonghong Song escreveu:
> 
> 
> On 1/15/21 3:34 PM, Nick Desaulniers wrote:
> > On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
> > > 
> > > 
> > > 
> > > On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > > > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > > > CONFIG_DEBUG_INFO_DWARF4.
> > > > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.
> > 
> > Can you privately send me your configs that repro? Maybe I can isolate
> > it to a set of configs?
> > 
> > > 
> > > I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> > > It is not there before and adding this may suddenly break some users.
> > > 
> > > If certain combination of gcc/llvm does not work for
> > > CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> > > should fix.
> > 
> > Is there a place I should report bugs?
> 
> You can send bug report to Arnaldo Carvalho de Melo <acme@kernel.org>,
> dwarves@vger.kernel.org and bpf@vger.kernel.org.

I'm coming back from vacation, will try to read the messages and see if
I can fix this.

Thanks,

- Arnaldo
 
> > 
> > > 
> > > > 
> > > > I had some other small nits commented in the single patches.
> > > > 
> > > > As requested in your previous patch-series, feel free to add my:
> > > > 
> > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > 
> > Yeah, I'll keep it if v6 is just commit message changes.
> > 

-- 

- Arnaldo
