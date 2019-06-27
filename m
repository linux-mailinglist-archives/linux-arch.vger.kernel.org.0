Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F068157F50
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2019 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfF0J1Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jun 2019 05:27:24 -0400
Received: from foss.arm.com ([217.140.110.172]:49994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfF0J1Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jun 2019 05:27:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA992B;
        Thu, 27 Jun 2019 02:27:23 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BA343F718;
        Thu, 27 Jun 2019 02:27:19 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:27:17 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>
Subject: Re: [PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
Message-ID: <20190627092715.GB2790@e103592.cambridge.arm.com>
References: <20190501211217.5039-1-yu-cheng.yu@intel.com>
 <20190502111003.GO3567@e103592.cambridge.arm.com>
 <CALCETrVZCzh+KFCF6ijuf4QEPn=R2gJ8FHLpyFd=n+pNOMMMjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVZCzh+KFCF6ijuf4QEPn=R2gJ8FHLpyFd=n+pNOMMMjA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 26, 2019 at 10:14:07AM -0700, Andy Lutomirski wrote:
> On Thu, May 2, 2019 at 4:10 AM Dave Martin <Dave.Martin@arm.com> wrote:

[...]

> > A couple of questions before I look in more detail:
> >
> > 1) Can we rely on PT_GNU_PROPERTY being present in the phdrs to describe
> > the NT_GNU_PROPERTY_TYPE_0 note?  If so, we can avoid trying to parse
> > irrelevant PT_NOTE segments.
> >
> >
> > 2) Are there standard types for things like the program property header?
> > If not, can we add something in elf.h?  We should try to coordinate with
> > libc on that.  Something like
> >
> 
> Where did PT_GNU_PROPERTY come from?  Are there actual docs for it?
> Can someone here tell us what the actual semantics of this new ELF
> thingy are?  From some searching, it seems like it's kind of an ELF
> note but kind of not.  An actual description would be fantastic.

https://github.com/hjl-tools/linux-abi/wiki/linux-abi-draft.pdf

I don't know _when_ it was added, and the description is minimal, but
it's there.

(I'd say it's fairly obvious how it should be used, but it could do with
some clarification...)

> Also, I don't think there's any actual requirement that the upstream
> kernel recognize existing CET-enabled RHEL 8 binaries as being
> CET-enabled.  I tend to think that RHEL 8 jumped the gun here.  While
> the upstream kernel should make some reasonble effort to make sure
> that RHEL 8 binaries will continue to run, I don't see why we need to
> go out of our way to keep the full set of mitigations available for
> binaries that were developed against a non-upstream kernel.

If that's an accpetable approach, it should certainly make our life
easier.

> In fact, if we handle the legacy bitmap differently from RHEL 8, we
> may *have* to make sure that we don't recognize existing RHEL 8
> binaries as CET-enabled.

Can't comment on that.  If the existing RHEL 8 binaries strictly don't
have the PT_GNU_PROPERTY phdr, then this might serve a dual purpose ...
otherwise, x86 might need some additional annotation for new binaries.

I'll leave it for others to comment.

Cheers
---Dave
