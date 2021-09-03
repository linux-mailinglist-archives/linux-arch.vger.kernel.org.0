Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DC3FFEE9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349256AbhICLUU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 07:20:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:22342 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349261AbhICLUS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 07:20:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="216251377"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="216251377"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 04:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="543475263"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2021 04:19:14 -0700
Received: from alobakin-mobl.ger.corp.intel.com (alobakin-mobl.ger.corp.intel.com [10.237.140.120])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 183BJCO3031959;
        Fri, 3 Sep 2021 12:19:12 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org,
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
Date:   Fri,  3 Sep 2021 13:19:07 +0200
Message-Id: <20210903111907.136-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <202109011815.1C439A6DA9@keescook>
References: <20210831144114.154-1-alexandr.lobakin@intel.com> <202108311010.8250B34D5@keescook> <20210901103658.228-1-alexandr.lobakin@intel.com> <202109011815.1C439A6DA9@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kees Cook <keescook@chromium.org>
> Date: Wed, 1 Sep 2021 18:36:59 -0700
> 
> On Wed, Sep 01, 2021 at 12:36:58PM +0200, Alexander Lobakin wrote:
> > Without FG-KASLR, we have only one .text section, and the total
> > section number is relatively small.
> > With FG-KASLR enabled, we have 40K+ separate text sections (I have
> > 40K on a setup with ClangLTO and ClangCFI and about 48K on a
> > "regular" one) and each of them is described in the ELF header. Plus
> > a separate .rela.text section for every single of them. That's the
> > main reason of the size increases.
> 
> If you have the size comparisons handy, I'd love to see them. My memory
> from v5 was that none of that end up in-core. And in that case, why
> limit the entropy of the resulting layout?

My testing machine is down for now, but I could send a size
comparison later. It's something about 10 Mb of uncompressed kernel
between 1 and 4 fps or so.

> > We still have LD_ORPHAN_WARN on non-FG-KASLR builds, but we also
> > have a rather different set of sections with FG-KASLR enabled. For
> > example, I noticed the appearing of .symtab_shndx section only in
> > virtue of LD_ORPHAN_WARN. So it's kinda not the same.
> 
> Agreed: I'd rather have LD_ORPHAN_WARN always enabled.
> 
> > I don't see a problem in this extra minute. FG-KASLR is all about
> 
> But not at this cost. Maybe the x86 maintainers will disagree, but I see
> this as a prohibitive cost to doing development work under FGKASLR, and
> if we expect this to become the default in distros, no one is going to
> be happy with that change. Link time dominates the partial rebuild time,
> so my opinion is that it should not be so inflated if not absolutely
> needed. Perhaps once the link time bugs in ld.bfd and ld.lld get fixed,
> but not now.

I don't think FG-KASLR will be enabled by default in distros. Apart
from linking time, it also increases cache misses a lot, and when
it comes to performance critical usecases like high-speed servers
and datacenters, I don't believe their maintainers would consider
FG-KASLR.
Speaking about distros, almost no build systems to my knowledge use
partial building, so this is only a downside for developers.

> > security, and you often pay something for this. We already have a
> > size increase, and a small delay while booting, and we can't get
> > rid of them. With orphan sections you leave a space for potentional
> 
> There's a difference between development time costs and run time costs.
> I don't think the LD_ORPHAN_WARN coverage is worth it in this case.
> 
> Either way, we need to fix the linker.

I agree on that, I was surprised both BFD and LLD choke on big LD
scripts.

> > flaws of the code, linker and/or linker script, which is really
> > unwanted in case of a security feature.
> > After all, ClangLTO increases the linking time at lot, and
> > TRIM_UNUSED_KSYMS builds almost the entire kernel two times in a
> > row, but nobody complains about this as there's nothing we can do
> > with it and it's the price you pay for the optimizations, so again,
> > I don't see a problem here.
> 
> I get what you mean with regard to getting the perfect situation, but
> the kernel went 29 years without LD_ORPHAN_WARN. :) Anyway, we'll see
> what other folks think, I guess.

Also agree, let's wait for more opinions on that, I'm open to
everything.

> > I still don't get why you're trying to split this series into two.
> > It's been almost a year since v5 was published, I doubt you can get
> > "basic FG-KASLR" accepted quickly just because it was reviewed back
> > then.
> 
> Well, because it was blocked then by a single bug, and everything else
> you've described are distinct improvements on v5, so to me it makes
> sense to have it separated into those phases. I don't mean split the
> series, I mean rearrange the series so that a rebased v5 is at the
> start, and the improvements follow.
> 
> > I prefer to provide a full picture of what I'm trying to bring, so
> > the community could review it all and throw much more ideas and
> > stuff.
> 
> Understood. I am suggesting some ideas about how it might help with
> review. :)
> 
> > > > * It's now fully compatible with ClangLTO, ClangCFI,
> > > >   CONFIG_LD_ORPHAN_WARN and some more stuff landed since the last
> > > >   revision was published;
> > > 
> > > FWIW, v5 was was too. :) I didn't have to do anything to v5 to make it
> > > work with ClangLTO and ClangCFI.
> > 
> > Once again, repeating the thing I wrote earlier in our discussion:
> > ClangCFI, at least shadowed implementation, requires the first text
> > section of the module to be page-aligned and contain __cfi_check()
> > at the very beginning of this section. With FG-KASLR and without
> > special handling, this section gets randomized along with the
> > others, and ClangCFI either rejects almost all modules or panics
> > the kernel.
> 
> Ah-ha, thanks. I must have missed your answer to this earlier. I had
> probably done my initial v5 testing without modules.
> 
> > > Great, this is a good start. One place we saw problems in the past was
> > > with i386 build gotchas, so that'll need testing too.
> > 
> > For now, FG_KASLR for x86 depends on X86_64. We might relax this
> > dependency later after enough testing or whatsoever (like it's been
> > done for ClangLTO).
> 
> Yes, but we've had a history of making big patches that do _intend_ to
> break the i386 build, but they do anyway. Hence my question.
> 
> > > Sounds good. It might be easier to base the series on linux-next, so a
> > > smaller series. Though given the merge window just opened, it might make
> > > more sense for a v7 to be based on v5.15-rc2 in three weeks.
> > 
> > I don't usually base any series on linux-next, because it contains
> > all the changes from all "for-next" branches and repos, while the
> > series finally gets accepted to the specific repo based on just
> > v5.x-rc1 (sometimes on -rc2). This may bring additional apply/merge
> > problems.
> 
> Understood. I just find it confusing to include patches on lkml that
> already exist in a -next branch. Perhaps base on kbuild -next?

That's not a problem anymore I believe, since it doesn't hit 5.15
window, so the rebased v7 will be on top of 5.15-rc1 which will
already contain those Kbuild fixes.

> > > > Kees Cook (2):
> > > >   x86/boot: Allow a "silent" kaslr random byte fetch
> > > >   x86/boot/compressed: Avoid duplicate malloc() implementations
> > > 
> > > These two can get landed right away -- they're standalone fixes that
> > > can safely go in -tip.
> > > 
> > > > 
> > > > Kristen Carlson Accardi (9):
> > > >   x86: tools/relocs: Support >64K section headers
> > > 
> > > Same for this.
> > 
> > They make little to no sense for non-FG-KASLR systems. And none of
> > them are "pure" fixes.
> > The same could be said about e.g. ORC lookup patch, but again, it
> > makes no sense right now.
> 
> *shrug* They're trivial changes that have been reviewed before, so it
> seems like we can avoid resending them every time.
> 
> > > I suspect it'll still be easier to review this series as a rebase v5
> > > followed by the evolutionary improvements, since the "basic FGKASLR" has
> > > been reviewed in the past, and is fairly noninvasive. The changes for
> > > ASM, new .text rules, etc, make a lot more changes that I think would be
> > > nice to have separate so reasonable a/b testing can be done.
> > 
> > I don't see a point in testing it two times instead of just one, as
> > well as in delivering this feature in two halves. It sounds like
> > "let's introduce ClangLTO, but firstly only for modules, as LTO for
> > vmlinux requires changes in objtool code and a special handling for
> > the initcalls".
> > The changes you mentioned only seem invasive, in fact, they can
> > carry way less harm than the "basic FG-KASLR" itself.
> 
> Mostly it's a question of building on prior testing (v5 worked), so that
> new changes can be debugged if they cause problems. Regardless, it's
> been so long, perhaps it won't matter to other reviewers and they'll
> want to just start over from scratch.
> 
> -Kees
> 
> -- 
> Kees Cook

Thanks,
Al
