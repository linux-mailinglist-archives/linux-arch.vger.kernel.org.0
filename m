Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE98393DF
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbfFGSBZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 14:01:25 -0400
Received: from foss.arm.com ([217.140.110.172]:45188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730714AbfFGSBZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 14:01:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CC49337;
        Fri,  7 Jun 2019 11:01:24 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0B63F718;
        Fri,  7 Jun 2019 11:01:20 -0700 (PDT)
Date:   Fri, 7 Jun 2019 19:01:18 +0100
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
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
Message-ID: <20190607180115.GJ28398@e103592.cambridge.arm.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-23-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200646.3951-23-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 06, 2019 at 01:06:41PM -0700, Yu-cheng Yu wrote:
> An ELF file's .note.gnu.property indicates features the executable file
> can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> GNU_PROPERTY_X86_FEATURE_1_SHSTK.
> 
> With this patch, if an arch needs to setup features from ELF properties,
> it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and a specific
> arch_setup_property().
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

Although this code works for the simple case, I have some concerns about
some aspects of the implementation here.  There appear to be some bounds
checking / buffer overrun issues, and the code seems quite complex.

Maybe this patch tries too hard to be compatible with toolchains that do
silly things such as embedding huge notes in an executable, or mixing
NT_GNU_PROPERTY_TYPE_0 in a single PT_NOTE with a load of junk not
relevant to the loader.  I wonder whether Linux can dictate what
interpretation(s) of the ELF specs it is prepared to support, rather than
trying to support absolutely anything.


I've commented on some potential issues below, but my review isn't
exhaustive -- I may also have simply not understood the code in some
cases, so I apologise in advance for that!

I've also marked a few coding style nits that make the code harder to
read than necessary (but this is partly a matter of taste).

Comments below.

Cheers
---Dave

> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  fs/Kconfig.binfmt        |   3 +
>  fs/Makefile              |   1 +
>  fs/binfmt_elf.c          |  13 ++
>  fs/gnu_property.c        | 351 +++++++++++++++++++++++++++++++++++++++
>  include/linux/elf.h      |  12 ++
>  include/uapi/linux/elf.h |  14 ++
>  6 files changed, 394 insertions(+)
>  create mode 100644 fs/gnu_property.c
> 
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index f87ddd1b6d72..397138ab305b 100644
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
> index c9aea23aba56..b69f18c14e09 100644
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
> index 8264b468f283..c3ea73787e93 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1080,6 +1080,19 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		goto out_free_dentry;
>  	}
>  
> +	if (interpreter) {
> +		retval = arch_setup_property(&loc->interp_elf_ex,
> +					     interp_elf_phdata,
> +					     interpreter, true);
> +	} else {
> +		retval = arch_setup_property(&loc->elf_ex,
> +					     elf_phdata,
> +					     bprm->file, false);
> +	}
> +
> +	if (retval < 0)
> +		goto out_free_dentry;
> +
>  	if (interpreter) {
>  		unsigned long interp_map_addr = 0;
>  
> diff --git a/fs/gnu_property.c b/fs/gnu_property.c
> new file mode 100644
> index 000000000000..9c4d1d5ebf00
> --- /dev/null
> +++ b/fs/gnu_property.c
> @@ -0,0 +1,351 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Extract an ELF file's .note.gnu.property.
> + *
> + * The path from the ELF header to the note section is the following:
> + * elfhdr->elf_phdr->elf_note->property[].
> + */
> +
> +#include <uapi/linux/elf-em.h>
> +#include <linux/processor.h>
> +#include <linux/binfmts.h>
> +#include <linux/elf.h>
> +#include <linux/slab.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/string.h>
> +#include <linux/compat.h>
> +
> +/*
> + * The .note.gnu.property layout:
> + *
> + *	struct elf_note {
> + *		u32 n_namesz; --> sizeof(n_name[]); always (4)
> + *		u32 n_ndescsz;--> sizeof(property[])
> + *		u32 n_type;   --> always NT_GNU_PROPERTY_TYPE_0
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
> +
> +#define BUF_SIZE (PAGE_SIZE / 4)

Nit: magic number in disguise.  What does the size of ELF notes have
to do with the page size?

> +
> +typedef bool (test_item_fn)(void *buf, u32 *arg, u32 type);
> +typedef void *(next_item_fn)(void *buf, u32 *arg, u32 type);
> +
> +static inline bool test_note_type(void *buf, u32 *align, u32 note_type)
> +{
> +	struct elf_note *n = buf;
> +
> +	return ((n->n_type == note_type) && (n->n_namesz == 4) &&
> +		(memcmp(n + 1, "GNU", 4) == 0));
> +}
> +
> +static inline void *next_note(void *buf, u32 *align, u32 note_type)
> +{
> +	struct elf_note *n = buf;
> +	u64 size;
> +
> +	if (check_add_overflow((u64)sizeof(*n), (u64)n->n_namesz, &size))
> +		return NULL;

sizeof(*n) is a small integer under our control, and n->n_namesz is a
u32.

So, I'm not sure how we would overflow 64 bits here, although if we can
get arbitrarily close to ~(u64)0 then:

> +
> +	size = round_up(size, *align);

this can overflow too.

> +
> +	if (check_add_overflow(size, (u64)n->n_descsz, &size))
> +		return NULL;
> +
> +	size = round_up(size, *align);

Similarly here.

> +
> +	if (buf + size < buf)

Isn't this undefined behaviour of it overflows?  If so, the compiler can
probably delete the check entirely, making it useless.  Does UBSAN warn
about it?

> +		return NULL;
> +	else
> +		return (buf + size);

Nit: Unnecessary ()  (There are surplus () all over this patch; I won't
comment on them all.)

> +}
> +
> +static inline bool test_property(void *buf, u32 *max_type, u32 pr_type)
> +{
> +	struct gnu_property *pr = buf;
> +
> +	/*
> +	 * Property types must be in ascending order.
> +	 * Keep track of the max when testing each.
> +	 */
> +	if (pr->pr_type > *max_type)
> +		*max_type = pr->pr_type;

Is this worthwhile?  In general we don't try very hard to check that the
ELF file is well-formed.

Ideally we could search by binary chop, but the property size is
variable, so the sortedness is useless to us (yay).

> +
> +	return (pr->pr_type == pr_type);
> +}
> +
> +static inline void *next_property(void *buf, u32 *max_type, u32 pr_type)

Nit: does this need to be inline?  The compiler's guess is usually good
enough...

> +{
> +	struct gnu_property *pr = buf;
> +
> +	if ((buf + sizeof(*pr) +  pr->pr_datasz < buf) ||

Nit: random extra space, redundant (), etc.

> +	    (pr->pr_type > pr_type) ||
> +	    (pr->pr_type > *max_type))
> +		return NULL;
> +	else
> +		return (buf + sizeof(*pr) + pr->pr_datasz);

We can exceed the underlying buffer bounds here, which is technically
undefined behaviour.

I suspect we may be relying on similar tricks all over the kernel, but
IT MAy be best avoided anyway.


If we always pass in the buffer base pointer and the size of the buffer, say

	static int next_property(void *buf, size_t *offset,
						size_t bufsz, ...)

then we may be able to use direct comparisons that can't overflow
rather than relying on potentially undefined behaviour.  For example:

	size_t o = *offset;

	if (o > bufsz || sizeof (*pr) > bufsz - o)
		return -1;

	pr = buf + o;
	if (pr->pr_type > pr_type || pr->pr_type > *max_type)
		return -1;

	if (pr->pr_datasz > bufsz - o - sizeof (*pr))
		return -1;

	*offset = o + sizeof (*pr) + pr->pr_datasz;
	return 0;

(There may be neater ways to do this.)

> +}
> +
> +/*
> + * Scan 'buf' for a pattern; return true if found.
> + * *pos is the distance from the beginning of buf to where
> + * the searched item or the next item is located.
> + */
> +static int scan(u8 *buf, u32 buf_size, int item_size, test_item_fn test_item,
> +		next_item_fn next_item, u32 *arg, u32 type, u32 *pos)
> +{
> +	int found = 0;
> +	u8 *p, *max;
> +
> +	max = buf + buf_size;
> +	if (max < buf)

See comment about undefined behaviour above.

Also, I'm not sure this check adds anything.  We know buf_size is
<= BUF_SIZE (though we could stick a WARN_ON() here and bail out if we
want to make absolutely sure).

If buf is always the base pointer returned by kmalloc(BUF_SIZE), then
I think buf_size can never go outside its bounds?

> +		return 0;
> +
> +	p = buf;
> +
> +	while ((p + item_size < max) && (p + item_size > buf)) {

                           ^ <= ?                   ^ undefined behaviour?

> +		if (test_item(p, arg, type)) {
> +			found = 1;
> +			break;
> +		}
> +
> +		p = next_item(p, arg, type);
> +	}
> +
> +	*pos = (p + item_size <= buf) ? 0 : (u32)(p - buf);

Can this be written more simply, say:

	if (p + item_size > buf)
		*pos += p - buf;

Also, since next_property() adds pr_datasz onto buf, could we get
unlucky and wrap past (void *)~0UL?  Then (u32)(p - buf) may be giant.
Not sure whether this breaks code elsewhere.

> +	return found;
> +}
> +
> +/*
> + * Search an NT_GNU_PROPERTY_TYPE_0 for the property of 'pr_type'.
> + */
> +static int find_property(struct file *file, unsigned long desc_size,
> +			 loff_t file_offset, u8 *buf,
> +			 u32 pr_type, u32 *property)
> +{
> +	u32 buf_pos;
> +	unsigned long read_size;
> +	unsigned long done;
> +	int found = 0;
> +	int ret = 0;
> +	u32 last_pr = 0;
> +
> +	*property = 0;
> +	buf_pos = 0;
> +
> +	for (done = 0; done < desc_size; done += buf_pos) {
> +		read_size = desc_size - done;
> +		if (read_size > BUF_SIZE)
> +			read_size = BUF_SIZE;
> +
> +		ret = kernel_read(file, buf, read_size, &file_offset);
> +
> +		if (ret != read_size)
> +			return (ret < 0) ? ret : -EIO;
> +
> +		ret = 0;
> +		found = scan(buf, read_size, sizeof(struct gnu_property),
> +			     test_property, next_property,
> +			     &last_pr, pr_type, &buf_pos);
> +
> +		if ((!buf_pos) || found)
> +			break;
> +
> +		file_offset += buf_pos - read_size;
> +	}
> +
> +	if (found) {
> +		struct gnu_property *pr =
> +			(struct gnu_property *)(buf + buf_pos);
> +
> +		if (pr->pr_datasz == 4) {
> +			u32 *max =  (u32 *)(buf + read_size);
> +			u32 *data = (u32 *)((u8 *)pr + sizeof(*pr));
> +
> +			if (data + 1 <= max) {
> +				*property = *data;
> +			} else {
> +				file_offset += buf_pos - read_size;
> +				file_offset += sizeof(*pr);
> +				ret = kernel_read(file, property, 4,
> +						  &file_offset);
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Search a PT_NOTE segment for NT_GNU_PROPERTY_TYPE_0.
> + */
> +static int find_note_type_0(struct file *file, loff_t file_offset,
> +			    unsigned long note_size, u32 align,
> +			    u32 pr_type, u32 *property)
> +{
> +	u8 *buf;
> +	u32 buf_pos;
> +	unsigned long read_size;
> +	unsigned long done;
> +	int found = 0;
> +	int ret = 0;
> +
> +	buf = kmalloc(BUF_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;

Do we really need to alloc/free this once per note?

> +
> +	*property = 0;
> +	buf_pos = 0;
> +
> +	for (done = 0; done < note_size; done += buf_pos) {
> +		read_size = note_size - done;
> +		if (read_size > BUF_SIZE)
> +			read_size = BUF_SIZE;
> +
> +		ret = kernel_read(file, buf, read_size, &file_offset);
> +
> +		if (ret != read_size) {
> +			ret = (ret < 0) ? ret : -EIO;
> +			kfree(buf);
> +			return ret;
> +		}
> +
> +		/*
> +		 * item_size = sizeof(struct elf_note) + elf_note.n_namesz.
> +		 * n_namesz is 4 for the note type we look for.
> +		 */
> +		ret = scan(buf, read_size, sizeof(struct elf_note) + 4,
> +			      test_note_type, next_note,
> +			      &align, NT_GNU_PROPERTY_TYPE_0, &buf_pos);
> +
> +		file_offset += buf_pos - read_size;
> +
> +		if (ret && !found) {
> +			struct elf_note *n =
> +				(struct elf_note *)(buf + buf_pos);
> +			u64 start = round_up(sizeof(*n) + n->n_namesz, align);
> +			u64 total = 0;
> +
> +			if (check_add_overflow(start, (u64)n->n_descsz, &total)) {
> +				ret = -EINVAL;
> +				break;
> +			}
> +			total = round_up(total, align);
> +
> +			ret = find_property(file, n->n_descsz,
> +					    file_offset + start,
> +					    buf, pr_type, property);
> +			found++;
> +			file_offset += total;
> +			buf_pos += total;
> +		} else if (!buf_pos || ret) {
> +			ret = 0;
> +			*property = 0;
> +			break;
> +		}
> +	}

Do we really need this complexity?  How big are the notes realistically
going to be?

Since a file with bloated notes is going to be inefficient to exec
anyway if we have to scan all the way through them, would it be better
just to choke on it and force the toolchain to do something more
sensible?

This in one reason why it would be good for the kernel to require
PT_GNU_PROPERTY if possible, so we know the precise offset and size
without having to search...

> +
> +	kfree(buf);
> +	return ret;
> +}
> +
> +/*
> + * Look at an ELF file's PT_NOTE segments, then NT_GNU_PROPERTY_TYPE_0, then
> + * the property of pr_type.
> + *
> + * Input:
> + *	file: the file to search;
> + *	phdr: the file's elf header;
> + *	phnum: number of entries in phdr;
> + *	pr_type: the property type.
> + *
> + * Output:
> + *	The property found.
> + *
> + * Return:
> + *	Zero or error.
> + */
> +static int scan_segments_64(struct file *file, struct elf64_phdr *phdr,
> +			    int phnum, u32 pr_type, u32 *property)
> +{
> +	int i;
> +	int err = 0;
> +
> +	for (i = 0; i < phnum; i++, phdr++) {
> +		if ((phdr->p_type != PT_NOTE) || (phdr->p_align != 8))
> +			continue;
> +
> +		/*
> +		 * Search the PT_NOTE segment for NT_GNU_PROPERTY_TYPE_0.
> +		 */
> +		err = find_note_type_0(file, phdr->p_offset, phdr->p_filesz,
> +				       phdr->p_align, pr_type, property);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int scan_segments_32(struct file *file, struct elf32_phdr *phdr,
> +			    int phnum, u32 pr_type, u32 *property)
> +{
> +	int i;
> +	int err = 0;
> +
> +	for (i = 0; i < phnum; i++, phdr++) {
> +		if ((phdr->p_type != PT_NOTE) || (phdr->p_align != 4))
> +			continue;
> +
> +		/*
> +		 * Search the PT_NOTE segment for NT_GNU_PROPERTY_TYPE_0.
> +		 */
> +		err = find_note_type_0(file, phdr->p_offset, phdr->p_filesz,
> +				       phdr->p_align, pr_type, property);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
> +		     u32 pr_type, u32 *property)
> +{
> +	struct elf64_hdr *ehdr64 = ehdr_p;
> +	int err = 0;
> +
> +	*property = 0;
> +
> +	if (ehdr64->e_ident[EI_CLASS] == ELFCLASS64) {
> +		struct elf64_phdr *phdr64 = phdr_p;
> +
> +		err = scan_segments_64(f, phdr64, ehdr64->e_phnum,
> +				       pr_type, property);
> +		if (err < 0)
> +			goto out;
> +	} else {
> +		struct elf32_hdr *ehdr32 = ehdr_p;
> +
> +		if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
> +			struct elf32_phdr *phdr32 = phdr_p;
> +
> +			err = scan_segments_32(f, phdr32, ehdr32->e_phnum,
> +					       pr_type, property);
> +			if (err < 0)
> +				goto out;
> +		}
> +	}
> +
> +out:
> +	return err;
> +}
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index e3649b3e970e..c15febebe7f2 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -56,4 +56,16 @@ static inline int elf_coredump_extra_notes_write(struct coredump_params *cprm) {
>  extern int elf_coredump_extra_notes_size(void);
>  extern int elf_coredump_extra_notes_write(struct coredump_params *cprm);
>  #endif
> +
> +#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
> +extern int arch_setup_property(void *ehdr, void *phdr, struct file *f,
> +			       bool interp);
> +extern int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
> +			    u32 pr_type, u32 *feature);
> +#else
> +static inline int arch_setup_property(void *ehdr, void *phdr, struct file *f,
> +				      bool interp) { return 0; }
> +static inline int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
> +				   u32 pr_type, u32 *feature) { return 0; }
> +#endif
>  #endif /* _LINUX_ELF_H */
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 34c02e4290fe..316177ce9e76 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -372,6 +372,7 @@ typedef struct elf64_shdr {
>  #define NT_PRFPREG	2
>  #define NT_PRPSINFO	3
>  #define NT_TASKSTRUCT	4
> +#define NT_GNU_PROPERTY_TYPE_0 5

Should this be in a separate block.  This required n_name = "GNU",
whereas the rest are "LINUX" notes AFAIK: it's really a separate
namespace.

I think the gap between 4 and 6 may be just coincidence: glibc's elf.h
already has NT_PLATFORM here (whatever that is).

>  #define NT_AUXV		6
>  /*
>   * Note to userspace developers: size of NT_SIGINFO note may increase
> @@ -443,4 +444,17 @@ typedef struct elf64_note {
>    Elf64_Word n_type;	/* Content type */
>  } Elf64_Nhdr;
>  
> +/* NT_GNU_PROPERTY_TYPE_0 header */
> +struct gnu_property {
> +  __u32 pr_type;
> +  __u32 pr_datasz;
> +};
> +
> +/* .note.gnu.property types */
> +#define GNU_PROPERTY_X86_FEATURE_1_AND		(0xc0000002)
> +
> +/* Bits of GNU_PROPERTY_X86_FEATURE_1_AND */
> +#define GNU_PROPERTY_X86_FEATURE_1_IBT		(0x00000001)
> +#define GNU_PROPERTY_X86_FEATURE_1_SHSTK	(0x00000002)
> +

Redundant ().  The rest of the file doesn't have them; can we conform to
the prevailing style there?

>  #endif /* _UAPI_LINUX_ELF_H */
> -- 
> 2.17.1
> 
