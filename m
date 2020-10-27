Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9C29C95A
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 21:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830615AbgJ0UAi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 16:00:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34922 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830614AbgJ0UAi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 16:00:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id s39so1506350qtb.2;
        Tue, 27 Oct 2020 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TVuLHKcXENXuQnK7BbqbATj1Ow+/O3OET0tWd5g550g=;
        b=mP0vr1qRuUQR81DKmnV8194x/AjZPMsguc2eq/A5LnYQc8WN31EdpclRq5QVEiguNC
         viciyDYZqo+cja357tj67V9Ldk0LSraSsvStPxeETJwDvUyDE0QqkcWdodVZFQKVwWxL
         epou4TbwiMHu7YGhXYGrCAeTC0M9FwqgpQSze1vdX6jE1Hycg9mcVCPQLugXG7BO4n3f
         ZKNCIrqLrRLE/IRXNhwwU6cP1LaeM2czwNcLqri8C9uV5dM+QmnFUKEZdmkSyS5SkMpZ
         6NJMI/dGiMEUrcA1CaTUHfY+8FHHy99q4+iH591UceHfx51c0qvDioxTaXMjQDk4tcQp
         Mr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TVuLHKcXENXuQnK7BbqbATj1Ow+/O3OET0tWd5g550g=;
        b=UT8nenYGTXpAFwAqfi16KZOTbzF2qOQzfAs1xYZ42aVp6W3CtETbQ1HsUXKqbIN6IU
         6xyJokFFCtO+ilO4/HdgCEg50DTGMFZ6reLSMYYpnVwvetVSs4wXBj6Euz6jKKqmNN1X
         T2KAfjqOi6CYepRhCpcIU+Rgpa6zu1GFOd4eNGu3IfzA9IWZnK9XW8xeCATsCwh3e6ms
         24bBjgMwqEhnV1NULAtCHIwHUTcqo/ECW5En55FTZwt0DYbAXgGiY9gS1l7dNDq+Coqf
         8Hj15X5jNNJes47s1WrG8wEgIqJbqeWu4BmDgeklpXqclUsNWsMCJecsbQYdzJ6obx0Q
         eZNA==
X-Gm-Message-State: AOAM530WWDKXlfwtZzK8lmJ1hZK9NZipKjx15KZs1PDo6I3n9bgZ7Soz
        107H4gz7QQlgU75Z7Ye+xZc=
X-Google-Smtp-Source: ABdhPJxU2pZfgj9I3plzFh3cez4o/WkT19yFU0erA2KwXzjCWYK8HyryZLdTY2tsgV+PFXrSig2WwQ==
X-Received: by 2002:ac8:4295:: with SMTP id o21mr3704200qtl.313.1603828836358;
        Tue, 27 Oct 2020 13:00:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z6sm1479349qtw.36.2020.10.27.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:00:35 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 27 Oct 2020 16:00:33 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
Message-ID: <20201027200033.GA1826217@rani.riverdale.lan>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org>
 <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
 <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
 <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
 <CAMj1kXEw+6Srqd5w9oxpik3VUbehapx_TcHLDCbmHZBSdY768Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEw+6Srqd5w9oxpik3VUbehapx_TcHLDCbmHZBSdY768Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 08:33:00PM +0100, Ard Biesheuvel wrote:
> On Tue, 27 Oct 2020 at 20:25, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > When I see .eh_frame, I think -fno-asynchronous-unwind-tables is
> > > missing from someone's KBUILD_CFLAGS.
> > > But I don't see anything curious in kernel/bpf/Makefile, unless
> > > cc-disable-warning is somehow broken.
> >
> > I tracked it down to kernel/bpf/core.c:___bpf_prog_run() being tagged
> > with __no_fgcse aka __attribute__((optimize("-fno-gcse"))).
> >
> > Even if the function is trivially empty ("return 0;"), a ".eh_frame" section
> > is generated.  Removing the __no_fgcse tag fixes that.
> >
> 
> 
> Given that it was added for issues related to retpolines, ORC and
> objtool, it should be safe to make that annotation x86-only.

The optimize attribute is not meant for production use. I had mentioned
this at the time but it got lost: the optimize attribute apparently does
not add options, it replaces them completely. So I'm guessing this one
is dropping the -fno-asynchronous-unwind-tables and causing the eh_frame
sections, though I don't know why that doesn't cause eh_frame on x86?

https://lore.kernel.org/lkml/alpine.LSU.2.21.2004151445520.11688@wotan.suse.de/
