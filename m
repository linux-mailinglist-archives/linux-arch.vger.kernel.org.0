Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8055C40E
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGAT6L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 15:58:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:28005 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAT6K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jul 2019 15:58:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 12:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="361947448"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2019 12:58:09 -0700
Message-ID: <ddba04d98c31963784231869088a37fe3ccefd09.camel@intel.com>
Subject: Re: [RFC PATCH] binfmt_elf: Extract .note.gnu.property from an ELF
 file
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Date:   Mon, 01 Jul 2019 12:49:51 -0700
In-Reply-To: <CAG48ez0rHHfcRgiVZf5FP0YOzxsXigvpg6ci790cmiN6PBwkhQ@mail.gmail.com>
References: <20190628172203.797-1-yu-cheng.yu@intel.com>
         <CAG48ez0rHHfcRgiVZf5FP0YOzxsXigvpg6ci790cmiN6PBwkhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2019-07-01 at 21:49 +0200, Jann Horn wrote:
> On Fri, Jun 28, 2019 at 7:30 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> [...]
> > In the discussion, we decided to look at only an ELF header's
> > PT_GNU_PROPERTY, which is a shortcut pointing to the file's
> > .note.gnu.property.
> > 
> > The Linux gABI extension draft is here:
> > 
> >     https://github.com/hjl-tools/linux-abi/wiki/linux-abi-draft.pdf.
> > 
> > A few existing CET-enabled binary files were built without
> > PT_GNU_PROPERTY; but those files' .note.gnu.property are checked by
> > ld-linux, not Linux.  The compatibility impact from this change is
> > therefore managable.
> > 
> > An ELF file's .note.gnu.property indicates features the executable file
> > can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> > indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> > GNU_PROPERTY_X86_FEATURE_1_SHSTK.
> > 
> > With this patch, if an arch needs to setup features from ELF properties,
> > it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and specific
> > arch_parse_property() and arch_setup_property().
> 
> [...]
> > +typedef bool (test_item_fn)(void *buf, u32 *arg, u32 type);
> > +typedef void *(next_item_fn)(void *buf, u32 *arg, u32 type);
> > +
> > +static bool test_property(void *buf, u32 *max_type, u32 pr_type)
> > +{
> > +       struct gnu_property *pr = buf;
> > +
> > +       /*
> > +        * Property types must be in ascending order.
> > +        * Keep track of the max when testing each.
> > +        */
> > +       if (pr->pr_type > *max_type)
> > +               *max_type = pr->pr_type;
> > +
> > +       return (pr->pr_type == pr_type);
> > +}
> > +
> > +static void *next_property(void *buf, u32 *max_type, u32 pr_type)
> > +{
> > +       struct gnu_property *pr = buf;
> > +
> > +       if ((buf + sizeof(*pr) + pr->pr_datasz < buf) ||
> 
> This looks like UB to me, see below.
> 
> > +           (pr->pr_type > pr_type) ||
> > +           (pr->pr_type > *max_type))
> > +               return NULL;
> > +       else
> > +               return (buf + sizeof(*pr) + pr->pr_datasz);
> > +}
> > +
> > +/*
> > + * Scan 'buf' for a pattern; return true if found.
> > + * *pos is the distance from the beginning of buf to where
> > + * the searched item or the next item is located.
> > + */
> > +static int scan(u8 *buf, u32 buf_size, int item_size, test_item_fn
> > test_item,
> > +               next_item_fn next_item, u32 *arg, u32 type, u32 *pos)
> > +{
> > +       int found = 0;
> > +       u8 *p, *max;
> > +
> > +       max = buf + buf_size;
> > +       if (max < buf)
> > +               return 0;
> 
> How can this ever legitimately happen? If it can't, perhaps you meant
> to put a WARN_ON_ONCE() or something like that here?
> Also, computing out-of-bounds pointers is UB (section 6.5.6 of C99:
> "If both the pointer operand and the result point to elements of the
> same array object, or one past the last element of the array object,
> the evaluation shall not produce an overflow; otherwise, the behavior
> is undefined."), and if the addition makes the pointer wrap, that's
> certainly out of bounds; so I don't think this condition can trigger
> without UB.
> 
> > +
> > +       p = buf;
> > +
> > +       while ((p + item_size < max) && (p + item_size > buf)) {
> 
> Again, as far as I know, this is technically UB. Please rewrite this.
> For example, you could do something like:
> 
>     while (max - p >= item_size) {
> 
> and then make sure that next_item() never computes OOB pointers.
> 
> > +               if (test_item(p, arg, type)) {
> > +                       found = 1;
> > +                       break;
> > +               }
> > +
> > +               p = next_item(p, arg, type);
> > +       }
> > +
> > +       *pos = (p + item_size <= buf) ? 0 : (u32)(p - buf);
> > +       return found;
> > +}
> > +
> > +/*
> > + * Search an NT_GNU_PROPERTY_TYPE_0 for the property of 'pr_type'.
> > + */
> > +static int find_property(u32 pr_type, u32 *property, struct file *file,
> > +                        loff_t file_offset, unsigned long desc_size)
> > +{
> > +       u8 *buf;
> > +       int buf_size;
> > +
> > +       u32 buf_pos;
> > +       unsigned long read_size;
> > +       unsigned long done;
> > +       int found = 0;
> > +       int ret = 0;
> > +       u32 last_pr = 0;
> > +
> > +       *property = 0;
> > +       buf_pos = 0;
> > +
> > +       buf_size = (desc_size > PAGE_SIZE) ? PAGE_SIZE : desc_size;
> 
> open-coded min(desc_size, PAGE_SIZE)
> 
> > +       buf = kmalloc(buf_size, GFP_KERNEL);
> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       for (done = 0; done < desc_size; done += buf_pos) {
> > +               read_size = desc_size - done;
> > +               if (read_size > buf_size)
> > +                       read_size = buf_size;
> > +
> > +               ret = kernel_read(file, buf, read_size, &file_offset);
> > +
> > +               if (ret != read_size)
> > +                       return (ret < 0) ? ret : -EIO;
> 
> This leaks the memory allocated for `buf`.
> 
> > +
> > +               ret = 0;
> > +               found = scan(buf, read_size, sizeof(struct gnu_property),
> > +                            test_property, next_property,
> > +                            &last_pr, pr_type, &buf_pos);
> > +
> > +               if ((!buf_pos) || found)
> > +                       break;
> > +
> > +               file_offset += buf_pos - read_size;
> > +       }
> 
> [...]
> > +       kfree(buf);
> > +       return ret;
> > +}

I will fix these.

Thanks,
Yu-cheng
