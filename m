Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1212448C9
	for <lists+linux-arch@lfdr.de>; Fri, 14 Aug 2020 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgHNL2c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Aug 2020 07:28:32 -0400
Received: from foss.arm.com ([217.140.110.172]:33292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNL2c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Aug 2020 07:28:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9919B1063;
        Fri, 14 Aug 2020 04:28:31 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.33.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A90F3F6CF;
        Fri, 14 Aug 2020 04:28:29 -0700 (PDT)
Date:   Fri, 14 Aug 2020 12:28:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 8/8] locking/atomics: Use read-write instrumentation for
 atomic RMWs
Message-ID: <20200814112826.GB68877@C02TD0UTHF1T.local>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-9-elver@google.com>
 <20200721141859.GC10769@hirez.programming.kicks-ass.net>
 <CANpmjNM6C6QtrtLhRkbmfc3jLqYaQOvvM_vKA6UyrkWadkdzNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM6C6QtrtLhRkbmfc3jLqYaQOvvM_vKA6UyrkWadkdzNQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Sorry to come to this rather late -- this comment equally applies to v2
so I'm replying here to have context.

On Wed, Jul 22, 2020 at 12:11:18PM +0200, Marco Elver wrote:
> On Tue, 21 Jul 2020 at 16:19, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jul 21, 2020 at 12:30:16PM +0200, Marco Elver wrote:
> >
> > > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > > index 6afadf73da17..5cdcce703660 100755
> > > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > > @@ -5,9 +5,10 @@ ATOMICDIR=$(dirname $0)
> > >
> > >  . ${ATOMICDIR}/atomic-tbl.sh
> > >
> > > -#gen_param_check(arg)
> > > +#gen_param_check(meta, arg)
> > >  gen_param_check()
> > >  {
> > > +     local meta="$1"; shift
> > >       local arg="$1"; shift
> > >       local type="${arg%%:*}"
> > >       local name="$(gen_param_name "${arg}")"
> > > @@ -17,17 +18,24 @@ gen_param_check()
> > >       i) return;;
> > >       esac
> > >
> > > -     # We don't write to constant parameters
> > > -     [ ${type#c} != ${type} ] && rw="read"
> > > +     if [ ${type#c} != ${type} ]; then
> > > +             # We don't write to constant parameters
> > > +             rw="read"
> > > +     elif [ "${meta}" != "s" ]; then
> > > +             # Atomic RMW
> > > +             rw="read_write"
> > > +     fi
> >
> > If we have meta, should we then not be consistent and use it for read
> > too? Mark?
> 
> gen_param_check seems to want to generate an 'instrument_' check per
> pointer argument. So if we have 1 argument that is a constant pointer,
> and one that isn't, it should generate different instrumentation for
> each. By checking the argument type, we get that behaviour. Although
> we are making the assumption that if meta indicates it's not a 's'tore
> (with void return), it's always a read-write access on all non-const
> pointers.
> 
> Switching over to checking only meta would always generate the same
> 'instrument_' call for each argument. Although right now that would
> seem to work because we don't yet have an atomic that accepts a
> constant pointer and a non-const one.
> 
> Preferences?

Given the only non-rmw cases use the 'l' and 's' meta values, and those
only have a single argument, I reckon it's preferable to special-case
those specifically, e.g.

	case "{meta}" in
	l) rw="read";;	
	s) rw="write";;
	*) rw="read_write";;
	esac

... then we can rework that in future if we ever need to handle multiple
atomic variables that have distinct r/w/rw access types.

Thanks,
Mark.
