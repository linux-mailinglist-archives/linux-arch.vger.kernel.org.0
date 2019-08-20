Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED20D96BBD
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 23:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfHTVuA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 17:50:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:58881 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730689AbfHTVuA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 17:50:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 14:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,410,1559545200"; 
   d="scan'208";a="378730455"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2019 14:49:59 -0700
Message-ID: <bd4caadd8a9110bbbcfb4e8748d0bb416161d8e3.camel@intel.com>
Subject: Re: [RFC PATCH 2/2] ELF: Add ELF program property parsing support
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 20 Aug 2019 14:40:54 -0700
In-Reply-To: <1566295063-7387-3-git-send-email-Dave.Martin@arm.com>
References: <1566295063-7387-1-git-send-email-Dave.Martin@arm.com>
         <1566295063-7387-3-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2019-08-20 at 10:57 +0100, Dave Martin wrote:
> ELF program properties will needed for detecting whether to enable
> optional architecture or ABI features for a new ELF process.
> 
> For now, there are no generic properties that we care about, so do
> nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> 
> Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> phdrs entry (if any), and notify each property to the arch code.
> 
> For now, the added code is not used.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  fs/binfmt_elf.c          | 109
> +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/compat_binfmt_elf.c   |   4 ++
>  include/linux/elf.h      |  21 +++++++++
>  include/uapi/linux/elf.h |   4 ++
>  4 files changed, 138 insertions(+)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index d4e11b2..52f4b96 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -39,12 +39,18 @@
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/cputime.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
>  #include <linux/cred.h>
>  #include <linux/dax.h>
>  #include <linux/uaccess.h>
>  #include <asm/param.h>
>  #include <asm/page.h>
>  
> +#ifndef ELF_COMPAT
> +#define ELF_COMPAT 0
> +#endif
> +
>  #ifndef user_long_t
>  #define user_long_t long
>  #endif
> @@ -690,6 +696,93 @@ static unsigned long randomize_stack_top(unsigned long
> stack_top)
>  #endif
>  }
>  
> +static int parse_elf_property(const void **prop, size_t *notesz,
> +			      struct arch_elf_state *arch)
> +{
> +	const struct gnu_property *pr = *prop;
> +	size_t sz = *notesz;
> +	int ret;
> +	size_t step;
> +
> +	BUG_ON(sz < sizeof(*pr));
> +
> +	if (sizeof(*pr) > sz)
> +		return -EIO;
> +
> +	if (pr->pr_datasz > sz - sizeof(*pr))
> +		return -EIO;
> +
> +	step = round_up(sizeof(*pr) + pr->pr_datasz, elf_gnu_property_align);
> +	if (step > sz)
> +		return -EIO;
> +
> +	ret = arch_parse_elf_property(pr->pr_type, *prop + sizeof(*pr),
> +				      pr->pr_datasz, ELF_COMPAT, arch);
> +	if (ret)
> +		return ret;
> +
> +	*prop += step;
> +	*notesz -= step;
> +	return 0;
> +}
> +
> +#define NOTE_DATA_SZ SZ_1K
> +#define GNU_PROPERTY_TYPE_0_NAME "GNU"
> +#define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
> +
> +static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
> +				struct arch_elf_state *arch)
> +{
> +	ssize_t n;
> +	loff_t pos = phdr->p_offset;
> +	union {
> +		struct elf_note nhdr;
> +		char data[NOTE_DATA_SZ];
> +	} note;
> +	size_t off, notesz;
> +	const void *prop;
> +	int ret;
> +
> +	if (!IS_ENABLED(ARCH_USE_GNU_PROPERTY))
> +		return 0;
> +
> +	BUG_ON(phdr->p_type != PT_GNU_PROPERTY);
> +
> +	/* If the properties are crazy large, that's too bad (for now): */
> +	if (phdr->p_filesz > sizeof(note))
> +		return -ENOEXEC;
> +	n = kernel_read(f, &note, phdr->p_filesz, &pos);
> +
> +	BUILD_BUG_ON(sizeof(note) < sizeof(note.nhdr) + NOTE_NAME_SZ);
> +	if (n < 0 || n < sizeof(note.nhdr) + NOTE_NAME_SZ)
> +		return -EIO;
> +
> +	if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
> +	    note.nhdr.n_namesz != NOTE_NAME_SZ ||
> +	    strncmp(note.data + sizeof(note.nhdr),
> +		    GNU_PROPERTY_TYPE_0_NAME, n - sizeof(note.nhdr)))
> +		return -EIO;
> +
> +	off = round_up(sizeof(note.nhdr) + NOTE_NAME_SZ,
> +		       elf_gnu_property_align);
> +	if (off > n)
> +		return -EIO;
> +
> +	prop = (const struct gnu_property *)(note.data + off);
> +	notesz = n - off;
> +	if (note.nhdr.n_descsz > notesz)
> +		return -EIO;
> +
> +	while (notesz) {
> +		BUG_ON(((char *)prop - note.data) % elf_gnu_property_align);
> +		ret = parse_elf_property(&prop, &notesz, arch);

Properties need to be in ascending order.  Can we keep track of it from here.
Also, can we replace BUG_ON with returning an error.

Thanks,
Yu-cheng
