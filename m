Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 210D9975ED
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfHUJUO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 05:20:14 -0400
Received: from foss.arm.com ([217.140.110.172]:54986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfHUJUN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 05:20:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9566C28;
        Wed, 21 Aug 2019 02:20:12 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A67B3F706;
        Wed, 21 Aug 2019 02:20:11 -0700 (PDT)
Date:   Wed, 21 Aug 2019 10:20:09 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/2] ELF: Add ELF program property parsing support
Message-ID: <20190821092007.GC27757@arm.com>
References: <1566295063-7387-1-git-send-email-Dave.Martin@arm.com>
 <1566295063-7387-3-git-send-email-Dave.Martin@arm.com>
 <bd4caadd8a9110bbbcfb4e8748d0bb416161d8e3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd4caadd8a9110bbbcfb4e8748d0bb416161d8e3.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 20, 2019 at 10:40:54PM +0100, Yu-cheng Yu wrote:
> On Tue, 2019-08-20 at 10:57 +0100, Dave Martin wrote:
> > ELF program properties will needed for detecting whether to enable
> > optional architecture or ABI features for a new ELF process.
> > 
> > For now, there are no generic properties that we care about, so do
> > nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> > 
> > Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> > phdrs entry (if any), and notify each property to the arch code.
> > 
> > For now, the added code is not used.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  fs/binfmt_elf.c          | 109
> > +++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/compat_binfmt_elf.c   |   4 ++
> >  include/linux/elf.h      |  21 +++++++++
> >  include/uapi/linux/elf.h |   4 ++
> >  4 files changed, 138 insertions(+)
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index d4e11b2..52f4b96 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -39,12 +39,18 @@
> >  #include <linux/sched/coredump.h>
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/sched/cputime.h>
> > +#include <linux/sizes.h>
> > +#include <linux/types.h>
> >  #include <linux/cred.h>
> >  #include <linux/dax.h>
> >  #include <linux/uaccess.h>
> >  #include <asm/param.h>
> >  #include <asm/page.h>
> >  
> > +#ifndef ELF_COMPAT
> > +#define ELF_COMPAT 0
> > +#endif
> > +
> >  #ifndef user_long_t
> >  #define user_long_t long
> >  #endif
> > @@ -690,6 +696,93 @@ static unsigned long randomize_stack_top(unsigned long
> > stack_top)
> >  #endif
> >  }
> >  
> > +static int parse_elf_property(const void **prop, size_t *notesz,
> > +			      struct arch_elf_state *arch)
> > +{
> > +	const struct gnu_property *pr = *prop;
> > +	size_t sz = *notesz;
> > +	int ret;
> > +	size_t step;
> > +
> > +	BUG_ON(sz < sizeof(*pr));
> > +
> > +	if (sizeof(*pr) > sz)
> > +		return -EIO;
> > +
> > +	if (pr->pr_datasz > sz - sizeof(*pr))
> > +		return -EIO;
> > +
> > +	step = round_up(sizeof(*pr) + pr->pr_datasz, elf_gnu_property_align);
> > +	if (step > sz)
> > +		return -EIO;
> > +
> > +	ret = arch_parse_elf_property(pr->pr_type, *prop + sizeof(*pr),
> > +				      pr->pr_datasz, ELF_COMPAT, arch);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*prop += step;
> > +	*notesz -= step;
> > +	return 0;
> > +}
> > +
> > +#define NOTE_DATA_SZ SZ_1K
> > +#define GNU_PROPERTY_TYPE_0_NAME "GNU"
> > +#define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
> > +
> > +static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
> > +				struct arch_elf_state *arch)
> > +{
> > +	ssize_t n;
> > +	loff_t pos = phdr->p_offset;
> > +	union {
> > +		struct elf_note nhdr;
> > +		char data[NOTE_DATA_SZ];
> > +	} note;
> > +	size_t off, notesz;
> > +	const void *prop;
> > +	int ret;
> > +
> > +	if (!IS_ENABLED(ARCH_USE_GNU_PROPERTY))
> > +		return 0;
> > +
> > +	BUG_ON(phdr->p_type != PT_GNU_PROPERTY);
> > +
> > +	/* If the properties are crazy large, that's too bad (for now): */
> > +	if (phdr->p_filesz > sizeof(note))
> > +		return -ENOEXEC;
> > +	n = kernel_read(f, &note, phdr->p_filesz, &pos);
> > +
> > +	BUILD_BUG_ON(sizeof(note) < sizeof(note.nhdr) + NOTE_NAME_SZ);
> > +	if (n < 0 || n < sizeof(note.nhdr) + NOTE_NAME_SZ)
> > +		return -EIO;
> > +
> > +	if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
> > +	    note.nhdr.n_namesz != NOTE_NAME_SZ ||
> > +	    strncmp(note.data + sizeof(note.nhdr),
> > +		    GNU_PROPERTY_TYPE_0_NAME, n - sizeof(note.nhdr)))
> > +		return -EIO;
> > +
> > +	off = round_up(sizeof(note.nhdr) + NOTE_NAME_SZ,
> > +		       elf_gnu_property_align);
> > +	if (off > n)
> > +		return -EIO;
> > +
> > +	prop = (const struct gnu_property *)(note.data + off);
> > +	notesz = n - off;
> > +	if (note.nhdr.n_descsz > notesz)
> > +		return -EIO;
> > +
> > +	while (notesz) {
> > +		BUG_ON(((char *)prop - note.data) % elf_gnu_property_align);
> > +		ret = parse_elf_property(&prop, &notesz, arch);
> 
> Properties need to be in ascending order.  Can we keep track of it from here.

We could, but do we need to?  If this order is violated, the ELF file is
invalid and it doesn't matter what we do, providing that the kernel
doesn't go wrong.

In general, the ELF loader already doesn't try to detect invalid ELF
files: for example EM_386 with ELFCLASS64 would just be executed as a
32-bit binary.  Of course, if the file is really structured as a 64-bit
ELF we'll probably fail to parse the file before we get as far as
executing it.

Here, we just care that a particular property is there.  If the
properties are shuffled, we will find the same set of properties
regardless.

The kernel isn't really responsible for debugging broken linkers...

OTOH the check would be trivial and I don't have a strong objection to
adding it.

> Also, can we replace BUG_ON with returning an error.

Sure, those BUG_ON() are for development purposes only.  I'd intended to
remove them, but I forgot to comment on it.

This BUG_ON() should be ensured by the round_up() logic in
parse_elf_property().

Thanks for taking a look!

Cheers
---Dave
