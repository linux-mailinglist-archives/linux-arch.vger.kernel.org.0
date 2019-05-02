Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8411B6E
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEBOaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 May 2019 10:30:01 -0400
Received: from foss.arm.com ([217.140.101.70]:46854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfEBOaA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 May 2019 10:30:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C155F374;
        Thu,  2 May 2019 07:29:59 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4FB13F5AF;
        Thu,  2 May 2019 07:29:54 -0700 (PDT)
Date:   Thu, 2 May 2019 15:29:52 +0100
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
Message-ID: <20190502142951.GP3567@e103592.cambridge.arm.com>
References: <20190501211217.5039-1-yu-cheng.yu@intel.com>
 <20190502111003.GO3567@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502111003.GO3567@e103592.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 02, 2019 at 12:10:04PM +0100, Dave Martin wrote:
> On Wed, May 01, 2019 at 02:12:17PM -0700, Yu-cheng Yu wrote:
> > An ELF file's .note.gnu.property indicates features the executable file
> > can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> > indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> > GNU_PROPERTY_X86_FEATURE_1_SHSTK.
> > 
> > This patch was part of the Control-flow Enforcement series; the original
> > patch is here: https://lkml.org/lkml/2018/11/20/205.  Dave Martin responded
> > that ARM recently introduced new features to NT_GNU_PROPERTY_TYPE_0 with
> > properties closely modelled on GNU_PROPERTY_X86_FEATURE_1_AND, and it is
> > logical to split out the generic part.  Here it is.
> > 
> > With this patch, if an arch needs to setup features from ELF properties,
> > it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and a specific
> > arch_setup_property().
> > 
> > For example, for X86_64:
> > 
> > int arch_setup_property(void *ehdr, void *phdr, struct file *f, bool inter)
> > {
> > 	int r;
> > 	uint32_t property;
> > 
> > 	r = get_gnu_property(ehdr, phdr, f, GNU_PROPERTY_X86_FEATURE_1_AND,
> > 			     &property);
> > 	...
> > }

[...]

> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c > > index 7d09d125f148..40aa4a4fd64d 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1076,6 +1076,19 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  		goto out_free_dentry;
> >  	}
> >  
> > +	if (interpreter) {
> > +		retval = arch_setup_property(&loc->interp_elf_ex,
> > +					     interp_elf_phdata,
> > +					     interpreter, true);
> > +	} else {
> > +		retval = arch_setup_property(&loc->elf_ex,
> > +					     elf_phdata,
> > +					     bprm->file, false);
> > +	}

This will be too late for arm64, since we need to twiddle the mmap prot
flags for the executable's pages based on the detected properties.

Can we instead move this much earlier, letting the arch code stash
something in arch_state that can be consumed later on?

This also has the advantage that we can report errors to the execve()
caller before passing the point of no return (i.e., flush_old_exec()).

[...]

> > diff --git a/fs/gnu_property.c b/fs/gnu_property.c

[...]

> > +int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
> > +		     u32 pr_type, u32 *property)
> > +{
> > +	struct elf64_hdr *ehdr64 = ehdr_p;
> > +	int err = 0;
> > +
> > +	*property = 0;
> > +
> > +	if (ehdr64->e_ident[EI_CLASS] == ELFCLASS64) {
> > +		struct elf64_phdr *phdr64 = phdr_p;
> > +
> > +		err = scan_segments_64(f, phdr64, ehdr64->e_phnum,
> > +				       pr_type, property);
> > +		if (err < 0)
> > +			goto out;
> > +	} else {
> > +#ifdef CONFIG_COMPAT
> > +		struct elf32_hdr *ehdr32 = ehdr_p;
> > +
> > +		if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
> > +			struct elf32_phdr *phdr32 = phdr_p;
> > +
> > +			err = scan_segments_32(f, phdr32, ehdr32->e_phnum,
> > +					       pr_type, property);
> > +			if (err < 0)
> > +				goto out;
> > +		}
> > +#else
> > +	WARN_ONCE(1, "Exec of 32-bit app, but CONFIG_COMPAT is not enabled.\n");
> > +	return -ENOTSUPP;
> > +#endif
> > +	}

We have already made a ton of assumptions about the ELF class by this
point, and we don't seem to check it explicitly elsewhere, so it is a
bit weird to police it specifically here.

Can we simply pass the assumed ELF class as a parameter instead?

[...]

Cheers
---DavE
