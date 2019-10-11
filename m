Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB17D436B
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfJKOvz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 10:51:55 -0400
Received: from foss.arm.com ([217.140.110.172]:34842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKOvz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 10:51:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 614DB142F;
        Fri, 11 Oct 2019 07:51:54 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 607CF3F68E;
        Fri, 11 Oct 2019 07:51:51 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:51:49 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 04/12] arm64: docs: cpu-feature-registers: Document
 ID_AA64PFR1_EL1
Message-ID: <20191011145148.GK27757@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-5-git-send-email-Dave.Martin@arm.com>
 <87zhi7l8qz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhi7l8qz.fsf@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 02:19:48PM +0100, Alex Bennée wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > Commit d71be2b6c0e1 ("arm64: cpufeature: Detect SSBS and advertise
> > to userspace") exposes ID_AA64PFR1_EL1 to userspace, but didn't
> > update the documentation to match.
> >
> > Add it.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> >
> > ---
> >
> > Note to maintainers:
> >
> >  * This patch has been racing with various other attempts to fix
> >    the same documentation in the meantime.
> >
> >    Since this patch only fixes the documenting for pre-existing
> >    features, it can safely be dropped if appropriate.
> >
> >    The _new_ documentation relating to BTI feature reporting
> >    is in a subsequent patch, and needs to be retained.
> > ---
> >  Documentation/arm64/cpu-feature-registers.rst | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> > index 2955287..b86828f 100644
> > --- a/Documentation/arm64/cpu-feature-registers.rst
> > +++ b/Documentation/arm64/cpu-feature-registers.rst
> > @@ -168,8 +168,15 @@ infrastructure:
> >       +------------------------------+---------+---------+
> >
> >
> > -  3) MIDR_EL1 - Main ID Register
> > +  3) ID_AA64PFR1_EL1 - Processor Feature Register 1
> > +     +------------------------------+---------+---------+
> > +     | Name                         |  bits   | visible |
> > +     +------------------------------+---------+---------+
> > +     | SSBS                         | [7-4]   |    y    |
> > +     +------------------------------+---------+---------+
> > +
> >
> > +  4) MIDR_EL1 - Main ID Register
> >       +------------------------------+---------+---------+
> >       | Name                         |  bits   | visible |
> >       +------------------------------+---------+---------+
> > @@ -188,7 +195,7 @@ infrastructure:
> >     as available on the CPU where it is fetched and is not a system
> >     wide safe value.
> >
> > -  4) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
> > +  5) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
> 
> If I'm not mistaken .rst has support for auto-enumeration if the #
> character is used. That might reduce the pain of re-numbering in future.

Ack, though it would be good to go one better and generate this document
from the cpufeature.c tables (or from some common source).  The numbers
are relatively easy to maintain -- remembering to update the document
at all seems the bigger maintenance headache right now.

I think this particular patch is superseded by similar fixes from other
people, just not in torvalds/master yet.

[...]

Cheers
---Dave
