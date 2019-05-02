Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C8D11FDB
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEBQOd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 May 2019 12:14:33 -0400
Received: from foss.arm.com ([217.140.101.70]:48710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfEBQOd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 May 2019 12:14:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D96CA78;
        Thu,  2 May 2019 09:14:32 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9783F5AF;
        Thu,  2 May 2019 09:14:27 -0700 (PDT)
Date:   Thu, 2 May 2019 17:14:24 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        libc-alpha@sourceware.org
Subject: Re: [PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
Message-ID: <20190502161424.GQ3567@e103592.cambridge.arm.com>
References: <20190501211217.5039-1-yu-cheng.yu@intel.com>
 <20190502111003.GO3567@e103592.cambridge.arm.com>
 <5b2c6cee345e00182e97842ae90c02cdcd830135.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2c6cee345e00182e97842ae90c02cdcd830135.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 02, 2019 at 08:47:06AM -0700, Yu-cheng Yu wrote:
> On Thu, 2019-05-02 at 12:10 +0100, Dave Martin wrote:
> > On Wed, May 01, 2019 at 02:12:17PM -0700, Yu-cheng Yu wrote:
> > > An ELF file's .note.gnu.property indicates features the executable file
> > > can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> > > indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> > > GNU_PROPERTY_X86_FEATURE_1_SHSTK.
> 
> [...]
> > A couple of questions before I look in more detail:
> > 
> > 1) Can we rely on PT_GNU_PROPERTY being present in the phdrs to describe
> > the NT_GNU_PROPERTY_TYPE_0 note?  If so, we can avoid trying to parse
> > irrelevant PT_NOTE segments.
> 
> Some older linkers can create multiples of NT_GNU_PROPERTY_TYPE_0.  The code
> scans all PT_NOTE segments to ensure there is only one NT_GNU_PROPERTY_TYPE_0. 
> If there are multiples, then all are considered invalid.

I'm concerned that in the arm64 case we would waste some effort by
scanning multiple notes.

Could we do something like iterating over the phdrs, and if we find
exactly one PT_GNU_PROPERTY then use that, else fall back to scanning
all PT_NOTEs?

> > 2) Are there standard types for things like the program property header?
> > If not, can we add something in elf.h?  We should try to coordinate with
> > libc on that.  Something like
> > 
> > typedef __u32 Elf_Word;
> > 
> > typedef struct {
> > 	Elf_Word pr_type;
> > 	Elf_Word pr_datasz;
> > } Elf_Gnu_Prophdr;
> > 
> > (i.e., just the header part from [1], with a more specific name -- which
> > I just made up).
> 
> Yes, I will fix that.
> 
> [...]
> > 3) It looks like we have to go and re-parse all the notes for every
> > property requested by the arch code.
> 
> As explained above, it is necessary to scan all PT_NOTE segments.  But there
> should be only one NT_GNU_PROPERTY_TYPE_0 in an ELF file.  Once that is found,
> perhaps we can store it somewhere, or call into the arch code as you mentioned
> below.  I will look into that.

Just to get something working on arm64, I'm working on some hacks that
move things around a bit -- I'll post when I have something.

Did you have any view on my other point, below?

Cheers
---Dave

> > For now there is only one property requested anyway, so this is probably
> > not too bad.  But could we flip things around so that we have some
> > CONFIG_ARCH_WANTS_ELF_GNU_PROPERTY (say), and have the ELF core code
> > call into the arch backend for each property found?
> > 
> > The arch could provide some hook
> > 
> > 	int arch_elf_has_gnu_property(const Elf_Gnu_Prophdr *prop,
> > 					const void *data);
> > 
> > to consume the properties as they are found.
> > 
> > This would effectively replace the arch_setup_property() hook you
> > currently have.
> > 
> > Cheers
> > ---Dave
> > 
> > [1] https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI
> 
