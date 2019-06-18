Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8034A6AA
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2019 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfFRQUN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jun 2019 12:20:13 -0400
Received: from foss.arm.com ([217.140.110.172]:48748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbfFRQUN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jun 2019 12:20:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4DBB344;
        Tue, 18 Jun 2019 09:20:12 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 284273F246;
        Tue, 18 Jun 2019 09:20:09 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:20:07 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
Message-ID: <20190618162005.GF2790@e103592.cambridge.arm.com>
References: <20190618091248.GB2790@e103592.cambridge.arm.com>
 <20190618124122.GH3419@hirez.programming.kicks-ass.net>
 <87ef3r9i2j.fsf@oldenburg2.str.redhat.com>
 <20190618125512.GJ3419@hirez.programming.kicks-ass.net>
 <20190618133223.GD2790@e103592.cambridge.arm.com>
 <d54fe81be77b9edd8578a6d208c72cd7c0b8c1dd.camel@intel.com>
 <87pnna7v1d.fsf@oldenburg2.str.redhat.com>
 <1ca57aaae8a2121731f2dcb1a137b92eed39a0d2.camel@intel.com>
 <87blyu7ubf.fsf@oldenburg2.str.redhat.com>
 <b0491cb517ba377da6496fe91a98fdbfca4609a9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0491cb517ba377da6496fe91a98fdbfca4609a9.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 18, 2019 at 09:00:35AM -0700, Yu-cheng Yu wrote:
> On Tue, 2019-06-18 at 18:05 +0200, Florian Weimer wrote:
> > * Yu-cheng Yu:
> > 
> > > > I assumed that it would also parse the main executable and make
> > > > adjustments based on that.
> > > 
> > > Yes, Linux also looks at the main executable's header, but not its
> > > NT_GNU_PROPERTY_TYPE_0 if there is a loader.
> > > 
> > > > 
> > > > ld.so can certainly provide whatever the kernel needs.  We need to tweak
> > > > the existing loader anyway.
> > > > 
> > > > No valid statically-linked binaries exist today, so this is not a
> > > > consideration at this point.
> > > 
> > > So from kernel, we look at only PT_GNU_PROPERTY?
> > 
> > If you don't parse notes/segments in the executable for CET, then yes.
> > We can put PT_GNU_PROPERTY into the loader.
> 
> Thanks!

Would this require the kernel and ld.so to be updated in a particular
order to avoid breakage?  I don't know enough about RHEL to know how
controversial that might be.

Also:

What about static binaries distrubited as part of RHEL?

A user would also reasonably expect static binaries built using the
distro toolchain to work on top of the distro kernel...  which might
be broken by this.


(When I say "broken" I mean that the binary would run, but CET
protections would be silently turned off.)

Cheers
---Dave
