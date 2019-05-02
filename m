Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0974911F95
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEBP4M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 May 2019 11:56:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:8954 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfEBP4M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 May 2019 11:56:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 08:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,422,1549958400"; 
   d="scan'208";a="147702137"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by fmsmga007.fm.intel.com with ESMTP; 02 May 2019 08:56:09 -0700
Message-ID: <ed56d7930e630213d74a7df8b9144d01415dac7c.camel@intel.com>
Subject: Re: [PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Martin <Dave.Martin@arm.com>
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
Date:   Thu, 02 May 2019 08:48:42 -0700
In-Reply-To: <20190502142951.GP3567@e103592.cambridge.arm.com>
References: <20190501211217.5039-1-yu-cheng.yu@intel.com>
         <20190502111003.GO3567@e103592.cambridge.arm.com>
         <20190502142951.GP3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2019-05-02 at 15:29 +0100, Dave Martin wrote:
> On Thu, May 02, 2019 at 12:10:04PM +0100, Dave Martin wrote:
> > On Wed, May 01, 2019 at 02:12:17PM -0700, Yu-cheng Yu wrote:
> 
> [...]
> 
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c > > index
> > > 7d09d125f148..40aa4a4fd64d 100644
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -1076,6 +1076,19 @@ static int load_elf_binary(struct linux_binprm
> > > *bprm)
> > >  		goto out_free_dentry;
> > >  	}
> > >  
> > > +	if (interpreter) {
> > > +		retval = arch_setup_property(&loc->interp_elf_ex,
> > > +					     interp_elf_phdata,
> > > +					     interpreter, true);
> > > +	} else {
> > > +		retval = arch_setup_property(&loc->elf_ex,
> > > +					     elf_phdata,
> > > +					     bprm->file, false);
> > > +	}
> 
> This will be too late for arm64, since we need to twiddle the mmap prot
> flags for the executable's pages based on the detected properties.
> 
> Can we instead move this much earlier, letting the arch code stash
> something in arch_state that can be consumed later on?
> 
> This also has the advantage that we can report errors to the execve()
> caller before passing the point of no return (i.e., flush_old_exec()).

I will look into that.

> 
> [...]
> 
> > > diff --git a/fs/gnu_property.c b/fs/gnu_property.c
> 
> [...]
> 
> > > +int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
> > > +		     u32 pr_type, u32 *property)
> > > +{
> > > +	struct elf64_hdr *ehdr64 = ehdr_p;
> > > +	int err = 0;
> > > +
> > > +	*property = 0;
> > > +
> > > +	if (ehdr64->e_ident[EI_CLASS] == ELFCLASS64) {
> > > +		struct elf64_phdr *phdr64 = phdr_p;
> > > +
> > > +		err = scan_segments_64(f, phdr64, ehdr64->e_phnum,
> > > +				       pr_type, property);
> > > +		if (err < 0)
> > > +			goto out;
> > > +	} else {
> > > +#ifdef CONFIG_COMPAT
> > > +		struct elf32_hdr *ehdr32 = ehdr_p;
> > > +
> > > +		if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
> > > +			struct elf32_phdr *phdr32 = phdr_p;
> > > +
> > > +			err = scan_segments_32(f, phdr32, ehdr32-
> > > >e_phnum,
> > > +					       pr_type, property);
> > > +			if (err < 0)
> > > +				goto out;
> > > +		}
> > > +#else
> > > +	WARN_ONCE(1, "Exec of 32-bit app, but CONFIG_COMPAT is not
> > > enabled.\n");
> > > +	return -ENOTSUPP;
> > > +#endif
> > > +	}
> 
> We have already made a ton of assumptions about the ELF class by this
> point, and we don't seem to check it explicitly elsewhere, so it is a
> bit weird to police it specifically here.
> 
> Can we simply pass the assumed ELF class as a parameter instead?

Yes.

Yu-cheng
