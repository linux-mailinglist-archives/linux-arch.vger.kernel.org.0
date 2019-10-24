Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA1E3801
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 18:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503456AbfJXQgN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 12:36:13 -0400
Received: from foss.arm.com ([217.140.110.172]:56142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503452AbfJXQgI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Oct 2019 12:36:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D418369;
        Thu, 24 Oct 2019 09:35:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459D93F71F;
        Thu, 24 Oct 2019 09:35:48 -0700 (PDT)
Date:   Thu, 24 Oct 2019 17:35:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v2 4/8] seqlock, kcsan: Add annotations for KCSAN
Message-ID: <20191024163545.GI4300@lakrids.cambridge.arm.com>
References: <20191017141305.146193-1-elver@google.com>
 <20191017141305.146193-5-elver@google.com>
 <20191024122801.GD4300@lakrids.cambridge.arm.com>
 <CANpmjNPFkqOSEcEP475-NeeJnY5pZ44m+bEhtOs8E_xkRKr-TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPFkqOSEcEP475-NeeJnY5pZ44m+bEhtOs8E_xkRKr-TQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 24, 2019 at 04:17:11PM +0200, Marco Elver wrote:
> On Thu, 24 Oct 2019 at 14:28, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Oct 17, 2019 at 04:13:01PM +0200, Marco Elver wrote:
> > > Since seqlocks in the Linux kernel do not require the use of marked
> > > atomic accesses in critical sections, we teach KCSAN to assume such
> > > accesses are atomic. KCSAN currently also pretends that writes to
> > > `sequence` are atomic, although currently plain writes are used (their
> > > corresponding reads are READ_ONCE).
> > >
> > > Further, to avoid false positives in the absence of clear ending of a
> > > seqlock reader critical section (only when using the raw interface),
> > > KCSAN assumes a fixed number of accesses after start of a seqlock
> > > critical section are atomic.
> >
> > Do we have many examples where there's not a clear end to a seqlock
> > sequence? Or are there just a handful?
> >
> > If there aren't that many, I wonder if we can make it mandatory to have
> > an explicit end, or to add some helper for those patterns so that we can
> > reliably hook them.
> 
> In an ideal world, all usage of seqlocks would be via seqlock_t, which
> follows a somewhat saner usage, where we already do normal begin/end
> markings -- with subtle exception to readers needing to be flat atomic
> regions, e.g. because usage like this:
> - fs/namespace.c:__legitimize_mnt - unbalanced read_seqretry
> - fs/dcache.c:d_walk - unbalanced need_seqretry
> 
> But anything directly accessing seqcount_t seems to be unpredictable.
> Filtering for usage of read_seqcount_retry not following 'do { .. }
> while (read_seqcount_retry(..));' (although even the ones in while
> loops aren't necessarily predictable):
> 
> $ git grep 'read_seqcount_retry' | grep -Ev 'seqlock.h|Doc|\* ' | grep
> -v 'while ('
> => about 1/3 of the total read_seqcount_retry usage.
> 
> Just looking at fs/namei.c, I would conclude that it'd be a pretty
> daunting task to prescribe and migrate to an interface that forces
> clear begin/end.
> 
> Which is why I concluded that for now, it is probably better to make
> KCSAN play well with the existing code.

Thanks for the detailed explanation, it's very helpful.

That all sounds reasonable to me -- could you fold some of that into the
commit message?

Thanks,
Mark.
