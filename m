Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89B2449CA
	for <lists+linux-arch@lfdr.de>; Fri, 14 Aug 2020 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgHNMeL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Aug 2020 08:34:11 -0400
Received: from foss.arm.com ([217.140.110.172]:33878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgHNMeL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Aug 2020 08:34:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C6EB31B;
        Fri, 14 Aug 2020 05:34:10 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.33.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40F0E3F6CF;
        Fri, 14 Aug 2020 05:34:08 -0700 (PDT)
Date:   Fri, 14 Aug 2020 13:34:05 +0100
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
Message-ID: <20200814123405.GD68877@C02TD0UTHF1T.local>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-9-elver@google.com>
 <20200721141859.GC10769@hirez.programming.kicks-ass.net>
 <CANpmjNM6C6QtrtLhRkbmfc3jLqYaQOvvM_vKA6UyrkWadkdzNQ@mail.gmail.com>
 <20200814112826.GB68877@C02TD0UTHF1T.local>
 <20200814113149.GC68877@C02TD0UTHF1T.local>
 <CANpmjNNXXMXMBOqJqQTkDDoavggDVktNL6AZn-hLMbEPYzZ_0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNXXMXMBOqJqQTkDDoavggDVktNL6AZn-hLMbEPYzZ_0w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 14, 2020 at 01:59:08PM +0200, Marco Elver wrote:
> On Fri, 14 Aug 2020 at 13:31, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Aug 14, 2020 at 12:28:26PM +0100, Mark Rutland wrote:
> > > Hi,
> > >
> > > Sorry to come to this rather late -- this comment equally applies to v2
> > > so I'm replying here to have context.
> >
> > ... and now I see that was already applied, so please ignore this!
> 
> Thank you for the comment anyway. If this is something urgent, we
> could send a separate patch to change.

I'm not particularly concerned; it would've been nice for legibility but
I don't think it's very important. I'm happy with leaving it as-is or
with a cleanup at some point -- I'll defer to Peter to decide either
way.

> My argument in favour of keeping it as-is was that the alternative
> would throw away the "type" and we no longer recognize a difference
> between arguments (in fairness, currently not important though). If,
> say, we get an RMW that has a constant argument though, the current
> version would do the "right thing" as far as I can tell. Maybe I'm
> overly conservative here, but it saves us worrying about some future
> use-case breaking this more than before.

I'd argue that clarity is preferable, since we'd have to change this to
deal with other variations in future (e.g. mixes of RW and W). I have
difficulty imagining an atomic op that'd work on multiple atomic
variables with different access types, so I suspect it's unlikely to
happen.

As above, not a big deal regardless.

Thanks,
Mark.
