Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB53FE737
	for <lists+linux-arch@lfdr.de>; Thu,  2 Sep 2021 03:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhIBBh7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Sep 2021 21:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhIBBh7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Sep 2021 21:37:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E6FC061757
        for <linux-arch@vger.kernel.org>; Wed,  1 Sep 2021 18:37:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u6so399961pfi.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Sep 2021 18:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FZj7bQstLxvnggT+mYiVUDNrPe/KHWsDuFwFpohZ6DE=;
        b=Yz45njvZVO+Cpr39aEBvL0FTZkY5Blnr5hSWS3nvZDHVvt9nqI3D43b3ByvoUj8ALi
         XaYzeq0y+rrbu/B617KfdfkLiwyeEwL/XJtt1vxFN3sW32gL26ZF1eArH00fHhn9u6sW
         l3BWFO4oXlVM/JcD7m9CWcHLzQKYeyGNWEGoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FZj7bQstLxvnggT+mYiVUDNrPe/KHWsDuFwFpohZ6DE=;
        b=Cf2vjz/DybMrkAb7bCU4tor2wzJaaGj168r2uJ9CaTNs7R9qf6MxCxcf9H0egCn5Mn
         GP4rRC7jnSyQZ2bpK9y5ID+4c+OzUTEEIhhUSk5t/qJ1Kjp50TStjsNx95kEEk5Xu4GM
         mb9O8BavAQ6y59pntAN+4uEWyoYbD11WZ/tu5f8LYKIaf7vr/A6acK10VNZrzfbcDQZq
         g4OC/JegzukbjxqzceraWbdZWW3JVoQlMkvcfbpGQLWHdIVWH8oBve7D+mYk5gMXDyLD
         eZZQS2alRjsgw6VemeocIOMuF0CNCzQgtd9rrP7uX6oFK7das6p7LqNjy2Zl7jc4SuSr
         FdUg==
X-Gm-Message-State: AOAM530zc3TS3C4zsDaqo6HMg3TBZlkmxzjSFkPLRPPjfFgb/syRIoiK
        p8mjhFX/Omp7hMZz4g9LgWFJfQ==
X-Google-Smtp-Source: ABdhPJzhAG9s+9WAnP6Ve94qoEOufRZ1W4NPrrIfMRuirMeW2MzBIWdc511hGMVFoIq7dNJHgFeSRQ==
X-Received: by 2002:a62:7c05:0:b0:40b:5d8f:6a56 with SMTP id x5-20020a627c05000000b0040b5d8f6a56mr778489pfc.74.1630546621308;
        Wed, 01 Sep 2021 18:37:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z131sm197063pfc.159.2021.09.01.18.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 18:37:00 -0700 (PDT)
Date:   Wed, 1 Sep 2021 18:36:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org,
        Kristen C Accardi <kristen.c.accardi@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        Marta A Plantykow <marta.a.plantykow@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v6 kspp-next 00/22] Function Granular KASLR
Message-ID: <202109011815.1C439A6DA9@keescook>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
 <202108311010.8250B34D5@keescook>
 <20210901103658.228-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901103658.228-1-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 01, 2021 at 12:36:58PM +0200, Alexander Lobakin wrote:
> Without FG-KASLR, we have only one .text section, and the total
> section number is relatively small.
> With FG-KASLR enabled, we have 40K+ separate text sections (I have
> 40K on a setup with ClangLTO and ClangCFI and about 48K on a
> "regular" one) and each of them is described in the ELF header. Plus
> a separate .rela.text section for every single of them. That's the
> main reason of the size increases.

If you have the size comparisons handy, I'd love to see them. My memory
from v5 was that none of that end up in-core. And in that case, why
limit the entropy of the resulting layout?

> We still have LD_ORPHAN_WARN on non-FG-KASLR builds, but we also
> have a rather different set of sections with FG-KASLR enabled. For
> example, I noticed the appearing of .symtab_shndx section only in
> virtue of LD_ORPHAN_WARN. So it's kinda not the same.

Agreed: I'd rather have LD_ORPHAN_WARN always enabled.

> I don't see a problem in this extra minute. FG-KASLR is all about

But not at this cost. Maybe the x86 maintainers will disagree, but I see
this as a prohibitive cost to doing development work under FGKASLR, and
if we expect this to become the default in distros, no one is going to
be happy with that change. Link time dominates the partial rebuild time,
so my opinion is that it should not be so inflated if not absolutely
needed. Perhaps once the link time bugs in ld.bfd and ld.lld get fixed,
but not now.

> security, and you often pay something for this. We already have a
> size increase, and a small delay while booting, and we can't get
> rid of them. With orphan sections you leave a space for potentional

There's a difference between development time costs and run time costs.
I don't think the LD_ORPHAN_WARN coverage is worth it in this case.

Either way, we need to fix the linker.

> flaws of the code, linker and/or linker script, which is really
> unwanted in case of a security feature.
> After all, ClangLTO increases the linking time at lot, and
> TRIM_UNUSED_KSYMS builds almost the entire kernel two times in a
> row, but nobody complains about this as there's nothing we can do
> with it and it's the price you pay for the optimizations, so again,
> I don't see a problem here.

I get what you mean with regard to getting the perfect situation, but
the kernel went 29 years without LD_ORPHAN_WARN. :) Anyway, we'll see
what other folks think, I guess.

> I still don't get why you're trying to split this series into two.
> It's been almost a year since v5 was published, I doubt you can get
> "basic FG-KASLR" accepted quickly just because it was reviewed back
> then.

Well, because it was blocked then by a single bug, and everything else
you've described are distinct improvements on v5, so to me it makes
sense to have it separated into those phases. I don't mean split the
series, I mean rearrange the series so that a rebased v5 is at the
start, and the improvements follow.

> I prefer to provide a full picture of what I'm trying to bring, so
> the community could review it all and throw much more ideas and
> stuff.

Understood. I am suggesting some ideas about how it might help with
review. :)

> > > * It's now fully compatible with ClangLTO, ClangCFI,
> > >   CONFIG_LD_ORPHAN_WARN and some more stuff landed since the last
> > >   revision was published;
> > 
> > FWIW, v5 was was too. :) I didn't have to do anything to v5 to make it
> > work with ClangLTO and ClangCFI.
> 
> Once again, repeating the thing I wrote earlier in our discussion:
> ClangCFI, at least shadowed implementation, requires the first text
> section of the module to be page-aligned and contain __cfi_check()
> at the very beginning of this section. With FG-KASLR and without
> special handling, this section gets randomized along with the
> others, and ClangCFI either rejects almost all modules or panics
> the kernel.

Ah-ha, thanks. I must have missed your answer to this earlier. I had
probably done my initial v5 testing without modules.

> > Great, this is a good start. One place we saw problems in the past was
> > with i386 build gotchas, so that'll need testing too.
> 
> For now, FG_KASLR for x86 depends on X86_64. We might relax this
> dependency later after enough testing or whatsoever (like it's been
> done for ClangLTO).

Yes, but we've had a history of making big patches that do _intend_ to
break the i386 build, but they do anyway. Hence my question.

> > Sounds good. It might be easier to base the series on linux-next, so a
> > smaller series. Though given the merge window just opened, it might make
> > more sense for a v7 to be based on v5.15-rc2 in three weeks.
> 
> I don't usually base any series on linux-next, because it contains
> all the changes from all "for-next" branches and repos, while the
> series finally gets accepted to the specific repo based on just
> v5.x-rc1 (sometimes on -rc2). This may bring additional apply/merge
> problems.

Understood. I just find it confusing to include patches on lkml that
already exist in a -next branch. Perhaps base on kbuild -next?

> > > Kees Cook (2):
> > >   x86/boot: Allow a "silent" kaslr random byte fetch
> > >   x86/boot/compressed: Avoid duplicate malloc() implementations
> > 
> > These two can get landed right away -- they're standalone fixes that
> > can safely go in -tip.
> > 
> > > 
> > > Kristen Carlson Accardi (9):
> > >   x86: tools/relocs: Support >64K section headers
> > 
> > Same for this.
> 
> They make little to no sense for non-FG-KASLR systems. And none of
> them are "pure" fixes.
> The same could be said about e.g. ORC lookup patch, but again, it
> makes no sense right now.

*shrug* They're trivial changes that have been reviewed before, so it
seems like we can avoid resending them every time.

> > I suspect it'll still be easier to review this series as a rebase v5
> > followed by the evolutionary improvements, since the "basic FGKASLR" has
> > been reviewed in the past, and is fairly noninvasive. The changes for
> > ASM, new .text rules, etc, make a lot more changes that I think would be
> > nice to have separate so reasonable a/b testing can be done.
> 
> I don't see a point in testing it two times instead of just one, as
> well as in delivering this feature in two halves. It sounds like
> "let's introduce ClangLTO, but firstly only for modules, as LTO for
> vmlinux requires changes in objtool code and a special handling for
> the initcalls".
> The changes you mentioned only seem invasive, in fact, they can
> carry way less harm than the "basic FG-KASLR" itself.

Mostly it's a question of building on prior testing (v5 worked), so that
new changes can be debugged if they cause problems. Regardless, it's
been so long, perhaps it won't matter to other reviewers and they'll
want to just start over from scratch.

-Kees

-- 
Kees Cook
