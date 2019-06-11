Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915C03CA33
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2019 13:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403826AbfFKLlS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jun 2019 07:41:18 -0400
Received: from foss.arm.com ([217.140.110.172]:59198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403817AbfFKLlS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jun 2019 07:41:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F861344;
        Tue, 11 Jun 2019 04:41:15 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A54D3F557;
        Tue, 11 Jun 2019 04:42:53 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:41:09 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
Message-ID: <20190611114109.GN28398@e103592.cambridge.arm.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-23-yu-cheng.yu@intel.com>
 <20190607180115.GJ28398@e103592.cambridge.arm.com>
 <94b9c55b3b874825fda485af40ab2a6bc3dad171.camel@intel.com>
 <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 10, 2019 at 07:24:43PM +0200, Florian Weimer wrote:
> * Yu-cheng Yu:
> 
> > To me, looking at PT_GNU_PROPERTY and not trying to support anything is a
> > logical choice.  And it breaks only a limited set of toolchains.
> >
> > I will simplify the parser and leave this patch as-is for anyone who wants to
> > back-port.  Are there any objections or concerns?
> 
> Red Hat Enterprise Linux 8 does not use PT_GNU_PROPERTY and is probably
> the largest collection of CET-enabled binaries that exists today.

For clarity, RHEL is actively parsing these properties today?

> My hope was that we would backport the upstream kernel patches for CET,
> port the glibc dynamic loader to the new kernel interface, and be ready
> to run with CET enabled in principle (except that porting userspace
> libraries such as OpenSSL has not really started upstream, so many
> processes where CET is particularly desirable will still run without
> it).
> 
> I'm not sure if it is a good idea to port the legacy support if it's not
> part of the mainline kernel because it comes awfully close to creating
> our own private ABI.

I guess we can aim to factor things so that PT_NOTE scanning is
available as a fallback on arches for which the absence of
PT_GNU_PROPERTY is not authoritative.

Can we argue that the lack of PT_GNU_PROPERTY is an ABI bug, fix it
for new binaries and hence limit the efforts we go to to support
theoretical binaries that lack the phdrs entry?

If we can make practical simplifications to the parsing, such as
limiting the maximum PT_NOTE size that we will search for the program
properties to 1K (say), or requiring NT_NOTE_GNU_PROPERTY_TYPE_0 to sit
by itself in a single PT_NOTE then that could help minimse the exec
overheads and the number of places for bugs to hide in the kernel.

What we can do here depends on what the tools currently do and what
binaries are out there.

Cheers
---Dave
