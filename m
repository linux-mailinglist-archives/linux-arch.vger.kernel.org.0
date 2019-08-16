Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFC9037C
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2019 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfHPNza (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Aug 2019 09:55:30 -0400
Received: from foss.arm.com ([217.140.110.172]:57350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfHPNza (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Aug 2019 09:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92EBB344;
        Fri, 16 Aug 2019 06:55:28 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 062AD3F694;
        Fri, 16 Aug 2019 06:55:24 -0700 (PDT)
Date:   Fri, 16 Aug 2019 14:55:22 +0100
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
        Borislav Petkov <bp@alien8.de>,
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v8 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
Message-ID: <20190816135520.GN10425@arm.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
 <20190813205225.12032-23-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813205225.12032-23-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:52:20PM -0700, Yu-cheng Yu wrote:
> An ELF file's .note.gnu.property indicates features the executable file
> can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> GNU_PROPERTY_X86_FEATURE_1_SHSTK.
> 
> With this patch, if an arch needs to setup features from ELF properties,
> it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and specific
> arch_parse_property() and arch_setup_property().
> 
> For example, for X86_64:
> 
> int arch_setup_property(void *ehdr, void *phdr, struct file *f, bool inter)
> {
> 	int r;
> 	uint32_t property;
> 
> 	r = get_gnu_property(ehdr, phdr, f, GNU_PROPERTY_X86_FEATURE_1_AND,
> 			     &property);
> 	...
> }
> 
> This patch is derived from code provided by H.J. Lu <hjl.tools@gmail.com>.

This is a nice simplification over the previous version, but I'm still
wondering whether it would be better to follow others folks' suggestions
and simply iterate over all the properties found, calling an arch
function for each note that the core doesn't care about.

Something like the following pseudocode:

include/x86/elf.h:
	int arch_elf_property(p)
	{
		if (p->pr_type == GNU_PROPERTY_X86_FEATURE_1_AND)
			return elf_property_x86_feature_1_and(p);
		else
			return 0;
	}

binfmt_elf.c:
	while (p = find next property)
		arch_elf_property(p);


This would also be more efficient when more than one property needs to
be extracted, since it ensures the file is only read once.

Anyway, comments below...

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  fs/Kconfig.binfmt        |   3 +
>  fs/Makefile              |   1 +
>  fs/binfmt_elf.c          |  20 +++++
>  fs/gnu_property.c        | 178 +++++++++++++++++++++++++++++++++++++++
>  include/linux/elf.h      |  11 +++
>  include/uapi/linux/elf.h |  14 +++
>  6 files changed, 227 insertions(+)
>  create mode 100644 fs/gnu_property.c
> 
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 62dc4f577ba1..d2cfe0729a73 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -36,6 +36,9 @@ config COMPAT_BINFMT_ELF
>  config ARCH_BINFMT_ELF_STATE
>  	bool
>  
> +config ARCH_USE_GNU_PROPERTY
> +	bool
> +
>  config BINFMT_ELF_FDPIC
>  	bool "Kernel support for FDPIC ELF binaries"
>  	default y if !BINFMT_ELF
> diff --git a/fs/Makefile b/fs/Makefile
> index d60089fd689b..939b1eb7e8cc 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
>  obj-$(CONFIG_COMPAT_BINFMT_ELF)	+= compat_binfmt_elf.o
>  obj-$(CONFIG_BINFMT_ELF_FDPIC)	+= binfmt_elf_fdpic.o
>  obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat.o
> +obj-$(CONFIG_ARCH_USE_GNU_PROPERTY) += gnu_property.o
>  
>  obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
>  obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index d4e11b2e04f6..a4e87fcb10a8 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -852,6 +852,21 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			}
>  	}
>  
> +	if (interpreter) {
> +		retval = arch_parse_property(&loc->interp_elf_ex,
> +					     interp_elf_phdata,
> +					     interpreter, true,
> +					     &arch_state);
> +	} else {
> +		retval = arch_parse_property(&loc->elf_ex,
> +					     elf_phdata,
> +					     bprm->file, false,
> +					     &arch_state);
> +	}
> +
> +	if (retval)
> +		goto out_free_dentry;
> +
>  	/*
>  	 * Allow arch code to reject the ELF at this point, whilst it's
>  	 * still possible to return an error to the code that invoked
> @@ -1080,6 +1095,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		goto out_free_dentry;
>  	}
>  
> +	retval = arch_setup_property(&arch_state);
> +
> +	if (retval < 0)
> +		goto out_free_dentry;
> +
>  	if (interpreter) {
>  		unsigned long interp_map_addr = 0;
>  
> diff --git a/fs/gnu_property.c b/fs/gnu_property.c
> new file mode 100644
> index 000000000000..b22b43f4d6a0
> --- /dev/null
> +++ b/fs/gnu_property.c
> @@ -0,0 +1,178 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Extract an ELF file's .note.gnu.property.
> + *
> + * The path from the ELF header to .note.gnu.property is:
> + *	elfhdr->elf_phdr->elf_note.
> + *
> + * .note.gnu.property layout:
> + *
> + *	struct elf_note {
> + *		u32 n_namesz; --> sizeof(n_name[]); always (4)
> + *		u32 n_ndescsz;--> sizeof(property[])
> + *		u32 n_type;   --> always NT_GNU_PROPERTY_TYPE_0 (5)
> + *	};
> + *	char n_name[4]; --> always 'GNU\0'
> + *
> + *	struct {
> + *		struct gnu_property {
> + *			u32 pr_type;
> + *			u32 pr_datasz;
> + *		};
> + *		u8 pr_data[pr_datasz];
> + *	}[];
> + */

Do we need all this comment?  We already have Elf{32,64}_Nhdr and
struct gnu_property in <uapi/elf.h>.

> +
> +#include <linux/elf.h>
> +#include <linux/slab.h>
> +#include <linux/fs.h>
> +#include <linux/string.h>
> +#include <linux/compat.h>
> +
> +/*
> + * Search a note's payload for 'pr_type'.
> + */
> +static int check_note_payload(void *buf, unsigned long len, u32 pr_type,
> +			      u32 *property)
> +{
> +	u32 pr_type_max = 0;
> +
> +	*property = 0;
> +
> +	while (len > 0) {
> +		struct gnu_property *pr = buf;
> +		unsigned long pr_len;
> +
> +		if (sizeof(*pr) > len)

checkpatch? (space required between sizeof and "(")

> +			return 0;

Shouldn't this be an error?
I'd have thought we should return 0 only if the property is found.

> +
> +		pr_len = sizeof(*pr) + pr->pr_datasz;

Overflow?

> +
> +		if (pr_len > len)
> +			return -ENOEXEC;

These seem to be the same class of error, i.e., trailing garbage in the
note, so why don't we return the same thing in both cases?

Maybe

	if (sizeof (*pr) > len ||
	    pr->pr_datasz > len - sizeof (*pr))
		return -ENOEXEC;

	pr_len = sizeof (*pr) + pr->pr_datasz;

> +		/* property types are in ascending order */
> +		if ((pr_type_max != 0) && (pr->pr_type > pr_type_max))
> +			return 0;

Redundant ().  The first part of the condition may be redundant too.
We also don't check for pr->pr_type == pr_type_max (which is presume
is also not supposed to happen).

Do we really need to check this anyway?  I presume this rule is only in
the spec to facilitate binary search (which the spec then defeats by
having a variable property size).

If we consider the ELF file invalid when this check fails, shouldn't
this be -ENOEXEC?

> +		if (pr->pr_type > pr_type)
> +			return 0;
> +
> +		if ((pr->pr_type == pr_type) &&
> +		    (pr->pr_datasz >= sizeof(u32))) {
> +			*property = *(u32 *)(buf + sizeof(*pr));
> +			return 0;
> +		}

Shouldn't pr->pr_datasz be exactly == sizeof (u32)?

> +
> +		if (pr->pr_type > pr_type_max)
> +			pr_type_max = pr->pr_type;

All these checks have my head spinning... if we ignore the ordering
requirement, can't we reduce it all to

	if (pr->pr_type == pr_type) {
		if (pr->pr_datasz != sizeof (u32))
			return -ENOEXEC;

		*property = *(u32 *)(buf + sizeof (*pr));
		return 0;
	}

> +

Do we need to up to the appropriate alignment after each property?

> +		buf += pr_len;
> +		len -= pr_len;
> +	}
> +
> +	return 0;

-ENOENT?

> +}
> +
> +/*
> + * Look at an ELF file's NT_GNU_PROPERTY for the property of pr_type.
> + *
> + * Input:
> + *	buf: the buffer containing the whole note.
> + *	len: size of buf.
> + *	align: alignment of the note's payload.
> + *	pr_type: the property type.
> + *
> + * Output:
> + *	The property found.
> + *
> + * Return:
> + *	Zero or error.
> + */
> +static int check_note(void *buf, unsigned long len, int align,
> +			  u32 pr_type, u32 *property)

check_note_payload() and check_note() are somewhat misleadingly named,
since they don't just check.

Maybe call them gnu_property_type_0_extract_property(),
note_extract_property()?

Admittedly the first of those names would be super-verbose :/

> +{
> +	struct elf_note *n = buf;
> +	char *note_name = buf + sizeof(*n);
> +	unsigned long payload_offset;
> +	unsigned long payload_len;
> +
> +	if (len < sizeof(*n) + 4)
> +		return -ENOEXEC;
> +
> +	if ((n->n_namesz != 4) || strncmp("GNU", note_name, 3))
> +		return -ENOEXEC;

Should that be , n->n_namesz? (or , sizeof ("GNU"))?

Also, no check on n->n_type?

Alternatively, we could just not bother to check the note header:
this was found via PT_GNU_PROPERTY, so if it's not a properly
formatted NT_GNU_PROPERTY_TYPE_0 then the file is garbage anyway
and it doesn't matter exactly what we do.

Personally I would check it though.

> +
> +	payload_offset = round_up(sizeof(*n) + n->n_namesz, align);
> +	payload_len = n->n_descsz;
> +
> +	if (payload_offset + payload_len > len)

May this overflow on 32-bit?

What about:

	if (payload_offset > len ||
	    payload_len > len - payload_offset)

> +		return -ENOEXEC;
> +
> +	buf += payload_offset;
> +	len -= payload_offset;
> +
> +	return check_note_payload(buf, len, pr_type, property);
> +}
> +
> +#define find_note(phdr, nr_phdrs, align, pos, len) { \
> +	int cnt; \
> +	\
> +	for (cnt = 0; cnt < nr_phdrs; cnt++) { \

Just to avoid future surprises:

(nr_phdrs)

> +		if ((phdr)[cnt].p_align != align) \

Similarly:

(align)

> +			continue; \
> +		if ((phdr)[cnt].p_type == PT_GNU_PROPERTY) { \
> +			pos = (phdr)[cnt].p_offset; \
> +			len = (phdr)[cnt].p_filesz; \
> +		} \
> +	} \
> +}
> +
> +int get_gnu_property(void *ehdr, void *phdr, struct file *file,
> +		     u32 pr_type, u32 *property)
> +{
> +	Elf64_Ehdr *ehdr64 = ehdr;
> +	Elf32_Ehdr *ehdr32 = ehdr;
> +	void *buf;
> +	int align;
> +	loff_t pos = 0;
> +	unsigned long len = 0;
> +	int err = 0;
> +
> +	/*
> +	 * Find PT_GNU_PROPERTY from ELF program headers.
> +	 */
> +	if (ehdr64->e_ident[EI_CLASS] == ELFCLASS64) {

Can we trust e_ident[EI_CLASS] to tell us how big the header is?

We don't check that anywhere AFAICT.  For the ELF interpreter in
particular, we kmalloc() the appropriate header size determined by
e_machine, so a malicious binary could have e_machine = EM_I386 with
e_ident[ELFCLASS] == ELFCLASSS64, causing a buffer overrun here.

For the main elf header, we get away with it because the bprm->buf[] is
statically allocated as BINPRM_BUF_SIZE and zero-padded in the case of a
short read.

We could pass in the header size explicitly here, or otherwise
validate that e_ident[ELFCLASS] is sane before calling in.

> +		align = 8;
> +		find_note((Elf64_Phdr *)phdr, ehdr64->e_phnum, align, pos, len);
> +	} else if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
> +		align = 4;
> +		find_note((Elf32_Phdr *)phdr, ehdr32->e_phnum, align, pos, len);
> +	}

Maybe make the name of find_note upper case, or pass pos and len by
reference.  Otherwise, this looks a bit like a function call -- in
which case pos and len couldn't be modified.

> +
> +	/*
> +	 * Read in the whole note.  PT_GNU_PROPERTY
> +	 * is not expected to be larger than a page.
> +	 */
> +	if (len == 0)
> +		return 0;
> +
> +	if (len > PAGE_SIZE)
> +		return -ENOEXEC;

Add a comment explaining the rationale?

> +
> +	buf = kmalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	err = kernel_read(file, buf, len, &pos);
> +	if (err < len) {
> +		if (err >= 0)
> +			err = -EIO;
> +		goto out;
> +	}
> +
> +	err = check_note(buf, len, align, pr_type, property);
> +out:
> +	kfree(buf);
> +	return err;
> +}

[...]

Cheers
---Dave
