Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2AC5C3D0
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 21:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfGATtz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 15:49:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44351 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfGATtz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2019 15:49:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so14691089otl.11
        for <linux-arch@vger.kernel.org>; Mon, 01 Jul 2019 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S054NJSICxH2WVYMj2QZmBzpirBW9pu17gcUOC2JL3E=;
        b=SSKFoyjUoA5JrydqG/b5ZPIrzADUe8JTb/5kFit1n4z3dZXZHbsIUbUPSFaLcPWQ7S
         hUBUabZSRMA5reCCV573Ol0V8x132YoSogMnumLkpdWy61Tpzi27R5UW7XFaGrt2CHbt
         GYvK7rtfRxG2jcB2lwcOddkC0j3w9Mr4irv2kAR24PfPnMkUYcOHYi6EOxzzotWiEDgD
         2WXn1zuW3+cZBTxlXS2qKWFlHb2LRa+K9/uzPdYJm8Gomn6WUXCx1YkwWM27kFleYKkP
         A0mrOlF1izN/6pNYXQruGWLEU5j2sSgma956vsk4BakMTA+ezti++nAVyhDxNyn5of5O
         HANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S054NJSICxH2WVYMj2QZmBzpirBW9pu17gcUOC2JL3E=;
        b=OXuxyGD0RX+L29kncm7MGoJQzzzwnTcEc0HWZqrH0JmV06QjyUfmv3+4eBTjN+glnC
         Xv7hqt9AuIqpbGljx1Lybd3bkCxiAEVtALAqdc9MiOOcT0wrudbz7kC738xV/bHkReWN
         8i0r7bLyTR5z2Kojrx0jJd4Mos7SzY5Zk0s9FgOI0DQe6h1NN0Vvb+kreyHJdPtEnCPX
         E6biXXiMiz5iOCDuUrB3EdYLhuEuvOWq2dO++CuK20wBHKWBIGCqRXRzEya+ah5NcM77
         FRr9Qd/0Z5fLlkAHoYE7BdHMjzh9efr+943aknHmacLpCcpM4ADSJOSdC3c6MC8rce+I
         vx6w==
X-Gm-Message-State: APjAAAWPqow59s1tGGw5QO792Bo4WEXhPQA7UnlWqbxAMAygv0Dx6Gq4
        d0y2Xzizg/UVe6GzcracS1voPqZdi/t2PjyG8sRHMw==
X-Google-Smtp-Source: APXvYqyxybyOMgQXZ08JkS9lEK/3daLWamrFF7d27t960AJ7WyvV4rJHucpixSzLMPbun7eVkVzASylILF21wHo9QzY=
X-Received: by 2002:a05:6830:15cd:: with SMTP id j13mr22250500otr.110.1562010594048;
 Mon, 01 Jul 2019 12:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190628172203.797-1-yu-cheng.yu@intel.com>
In-Reply-To: <20190628172203.797-1-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Jul 2019 21:49:28 +0200
Message-ID: <CAG48ez0rHHfcRgiVZf5FP0YOzxsXigvpg6ci790cmiN6PBwkhQ@mail.gmail.com>
Subject: Re: [RFC PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 28, 2019 at 7:30 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
[...]
> In the discussion, we decided to look at only an ELF header's
> PT_GNU_PROPERTY, which is a shortcut pointing to the file's
> .note.gnu.property.
>
> The Linux gABI extension draft is here:
>
>     https://github.com/hjl-tools/linux-abi/wiki/linux-abi-draft.pdf.
>
> A few existing CET-enabled binary files were built without
> PT_GNU_PROPERTY; but those files' .note.gnu.property are checked by
> ld-linux, not Linux.  The compatibility impact from this change is
> therefore managable.
>
> An ELF file's .note.gnu.property indicates features the executable file
> can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> GNU_PROPERTY_X86_FEATURE_1_SHSTK.
>
> With this patch, if an arch needs to setup features from ELF properties,
> it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and specific
> arch_parse_property() and arch_setup_property().
[...]
> +typedef bool (test_item_fn)(void *buf, u32 *arg, u32 type);
> +typedef void *(next_item_fn)(void *buf, u32 *arg, u32 type);
> +
> +static bool test_property(void *buf, u32 *max_type, u32 pr_type)
> +{
> +       struct gnu_property *pr = buf;
> +
> +       /*
> +        * Property types must be in ascending order.
> +        * Keep track of the max when testing each.
> +        */
> +       if (pr->pr_type > *max_type)
> +               *max_type = pr->pr_type;
> +
> +       return (pr->pr_type == pr_type);
> +}
> +
> +static void *next_property(void *buf, u32 *max_type, u32 pr_type)
> +{
> +       struct gnu_property *pr = buf;
> +
> +       if ((buf + sizeof(*pr) + pr->pr_datasz < buf) ||

This looks like UB to me, see below.

> +           (pr->pr_type > pr_type) ||
> +           (pr->pr_type > *max_type))
> +               return NULL;
> +       else
> +               return (buf + sizeof(*pr) + pr->pr_datasz);
> +}
> +
> +/*
> + * Scan 'buf' for a pattern; return true if found.
> + * *pos is the distance from the beginning of buf to where
> + * the searched item or the next item is located.
> + */
> +static int scan(u8 *buf, u32 buf_size, int item_size, test_item_fn test_item,
> +               next_item_fn next_item, u32 *arg, u32 type, u32 *pos)
> +{
> +       int found = 0;
> +       u8 *p, *max;
> +
> +       max = buf + buf_size;
> +       if (max < buf)
> +               return 0;

How can this ever legitimately happen? If it can't, perhaps you meant
to put a WARN_ON_ONCE() or something like that here?
Also, computing out-of-bounds pointers is UB (section 6.5.6 of C99:
"If both the pointer operand and the result point to elements of the
same array object, or one past the last element of the array object,
the evaluation shall not produce an overflow; otherwise, the behavior
is undefined."), and if the addition makes the pointer wrap, that's
certainly out of bounds; so I don't think this condition can trigger
without UB.

> +
> +       p = buf;
> +
> +       while ((p + item_size < max) && (p + item_size > buf)) {

Again, as far as I know, this is technically UB. Please rewrite this.
For example, you could do something like:

    while (max - p >= item_size) {

and then make sure that next_item() never computes OOB pointers.

> +               if (test_item(p, arg, type)) {
> +                       found = 1;
> +                       break;
> +               }
> +
> +               p = next_item(p, arg, type);
> +       }
> +
> +       *pos = (p + item_size <= buf) ? 0 : (u32)(p - buf);
> +       return found;
> +}
> +
> +/*
> + * Search an NT_GNU_PROPERTY_TYPE_0 for the property of 'pr_type'.
> + */
> +static int find_property(u32 pr_type, u32 *property, struct file *file,
> +                        loff_t file_offset, unsigned long desc_size)
> +{
> +       u8 *buf;
> +       int buf_size;
> +
> +       u32 buf_pos;
> +       unsigned long read_size;
> +       unsigned long done;
> +       int found = 0;
> +       int ret = 0;
> +       u32 last_pr = 0;
> +
> +       *property = 0;
> +       buf_pos = 0;
> +
> +       buf_size = (desc_size > PAGE_SIZE) ? PAGE_SIZE : desc_size;

open-coded min(desc_size, PAGE_SIZE)

> +       buf = kmalloc(buf_size, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       for (done = 0; done < desc_size; done += buf_pos) {
> +               read_size = desc_size - done;
> +               if (read_size > buf_size)
> +                       read_size = buf_size;
> +
> +               ret = kernel_read(file, buf, read_size, &file_offset);
> +
> +               if (ret != read_size)
> +                       return (ret < 0) ? ret : -EIO;

This leaks the memory allocated for `buf`.

> +
> +               ret = 0;
> +               found = scan(buf, read_size, sizeof(struct gnu_property),
> +                            test_property, next_property,
> +                            &last_pr, pr_type, &buf_pos);
> +
> +               if ((!buf_pos) || found)
> +                       break;
> +
> +               file_offset += buf_pos - read_size;
> +       }
[...]
> +       kfree(buf);
> +       return ret;
> +}
