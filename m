Return-Path: <linux-arch+bounces-2441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AC38576C5
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 08:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF44D281F09
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBC6171D2;
	Fri, 16 Feb 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieRQ/e07"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475B14F64
	for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068154; cv=none; b=OK9O4eD8A6TtImTvG9kJxnUPlcwNo/0z8AZxOlofe3wkbqTDnPcRbptJ8dtZPL6oNUUtDvb1Cck1x+kgNSssUe/j4l+xx7MPHvDANpsZy+zgQZzuiCkNaXYEI9igciivYrzywHeAuhSx3RPNW/fcF+ra0Cqw9R1D3hXiQ9FiWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068154; c=relaxed/simple;
	bh=7wkob3Dsl+yKC4YkmO8O5cQpRl9OQycaM2RPLlfolAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPI7pcRFWRvIZXMW1BG7QVXbuD+EDDLHrJ5jqxgkZIcSwXTuvNckkKIdjZCd1s8XnAuxITo6nhmFI4DJQmuyzNJIoXr2pQEs4gBeulXKtZzhuQnaFUG/Xmnres8AlAbUWMesDpAcRxIodkxfrDqrgFM3FBVn2Kw5dgTNcXm0GYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ieRQ/e07; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607cd210962so13990857b3.2
        for <linux-arch@vger.kernel.org>; Thu, 15 Feb 2024 23:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708068150; x=1708672950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9+B+H3K0W9pJd8bNryL7B75GoSzScPALIXqjy44UEE=;
        b=ieRQ/e07WGvdivULmKs1tRVoWzf/6tC7Fskx1arcXdHXL6jqi10fZ8UO+yWCqOW5WS
         VQKcj2jy3OoRIK2N9f3ceWt/TDNsVAyfXe5FR8McehU8sx3udom8JswzXgPqDe12ia69
         wM5OICCYbSSlTQOpnEzKajAGYymESJwBk69HSPVrGVQgyEjgrihRKmvRIEgluiuE1eVg
         AeDmhJGHIdPi5IjSiGPwzVZ+tEhkbWnG+D9Ejt/6GfLh3rH0XqYpj1rh4AaFKSNthjvt
         Wwly+50NiNnO452SjvSSktmO5uEHt3RqBhOulUSEq6Ckksbx/RXQW5JrBbcWoxf6FoQA
         NN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708068150; x=1708672950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9+B+H3K0W9pJd8bNryL7B75GoSzScPALIXqjy44UEE=;
        b=UC+dynyC0/elabKtQDqdDpaAyORfRU7iPjIxLDDIht6KChS9XuQM6XZm6x229y8Het
         JrUGOD2Lj5+gFGHfDG00YwWk0U9++sRU1Ct10V4OweexRi+2XaKkQE3O1C6l9l6WrF1Y
         bhzm6HLGyTqPdEKzpmhDitGC32txnE93E2sPs9Ppq4ciqJ0aSRg2z16jLPe4rYsUyXiB
         x6VmHncMGoOarpyWV0EBP0XqsXwuY9ja/NwbOOe4g6x6dfu5+aomW4YvpMqW7fRlfnxK
         cHYnISeW6OVy06+Ciejtb5nqG1PHcIPt8eoCxCSsAUIPoqGy8KTKaxvyr2LSs+BaRASg
         gT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoaBp2z4GQIw9Io3msYnb+RrQMhqAsPKuMkO+ctPsM2lQUDe5cKddEA6/3R3c0ep5lNlE0ZoAudrlkOQQAD3Q3JbVJedx20SNFPA==
X-Gm-Message-State: AOJu0Yw0YyLq7458M/FzLIR5hfNDeFy1IYdkidxNXF7wjOcUIsTXeMzT
	b52n+vn/ZApRbD9xfft51vgEHhu0euyE1F0PVGATHyWT5EReMkwCTsdJQI9/4NmCA0jqxtdUJEF
	DjZkOu45KG1j5CNPMfZUpmx9uS2fjJA/Swha+
X-Google-Smtp-Source: AGHT+IGfhuzMecQLi+9TByo09qAXuYZmPn6jEQ/sIt9UYOpmXa2s1LS2SB61X5cRfaySalDuNypcx8p5p8IuAu0EvA8=
X-Received: by 2002:a0d:cc81:0:b0:5f6:d447:b85a with SMTP id
 o123-20020a0dcc81000000b005f6d447b85amr4793609ywd.7.1708068149910; Thu, 15
 Feb 2024 23:22:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-11-surenb@google.com>
 <202402121419.7C4AAF27ED@keescook> <CAJuCfpFpKKqCtU2EJM28fbYRYUbBLR9XuDONmS21zeTc2Z6nxw@mail.gmail.com>
In-Reply-To: <CAJuCfpFpKKqCtU2EJM28fbYRYUbBLR9XuDONmS21zeTc2Z6nxw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 23:22:16 -0800
Message-ID: <CAJuCfpF3ZHkuBejRp_2BBcC-Lp8achfaosVu0SfBNAA0Y27+vA@mail.gmail.com>
Subject: Re: [PATCH v3 10/35] lib: code tagging framework
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Feb 12, 2024 at 2:27=E2=80=AFPM Kees Cook <keescook@chromium.org>=
 wrote:
> >
> > On Mon, Feb 12, 2024 at 01:38:56PM -0800, Suren Baghdasaryan wrote:
> > > Add basic infrastructure to support code tagging which stores tag com=
mon
> > > information consisting of the module name, function, file name and li=
ne
> > > number. Provide functions to register a new code tag type and navigat=
e
> > > between code tags.
> > >
> > > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  include/linux/codetag.h |  71 ++++++++++++++
> > >  lib/Kconfig.debug       |   4 +
> > >  lib/Makefile            |   1 +
> > >  lib/codetag.c           | 199 ++++++++++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 275 insertions(+)
> > >  create mode 100644 include/linux/codetag.h
> > >  create mode 100644 lib/codetag.c
> > >
> > > diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> > > new file mode 100644
> > > index 000000000000..a9d7adecc2a5
> > > --- /dev/null
> > > +++ b/include/linux/codetag.h
> > > @@ -0,0 +1,71 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * code tagging framework
> > > + */
> > > +#ifndef _LINUX_CODETAG_H
> > > +#define _LINUX_CODETAG_H
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +struct codetag_iterator;
> > > +struct codetag_type;
> > > +struct seq_buf;
> > > +struct module;
> > > +
> > > +/*
> > > + * An instance of this structure is created in a special ELF section=
 at every
> > > + * code location being tagged.  At runtime, the special section is t=
reated as
> > > + * an array of these.
> > > + */
> > > +struct codetag {
> > > +     unsigned int flags; /* used in later patches */
> > > +     unsigned int lineno;
> > > +     const char *modname;
> > > +     const char *function;
> > > +     const char *filename;
> > > +} __aligned(8);
> > > +
> > > +union codetag_ref {
> > > +     struct codetag *ct;
> > > +};
> > > +
> > > +struct codetag_range {
> > > +     struct codetag *start;
> > > +     struct codetag *stop;
> > > +};
> > > +
> > > +struct codetag_module {
> > > +     struct module *mod;
> > > +     struct codetag_range range;
> > > +};
> > > +
> > > +struct codetag_type_desc {
> > > +     const char *section;
> > > +     size_t tag_size;
> > > +};
> > > +
> > > +struct codetag_iterator {
> > > +     struct codetag_type *cttype;
> > > +     struct codetag_module *cmod;
> > > +     unsigned long mod_id;
> > > +     struct codetag *ct;
> > > +};
> > > +
> > > +#define CODE_TAG_INIT {                                      \
> > > +     .modname        =3D KBUILD_MODNAME,               \
> > > +     .function       =3D __func__,                     \
> > > +     .filename       =3D __FILE__,                     \
> > > +     .lineno         =3D __LINE__,                     \
> > > +     .flags          =3D 0,                            \
> > > +}
> > > +
> > > +void codetag_lock_module_list(struct codetag_type *cttype, bool lock=
);
> > > +struct codetag_iterator codetag_get_ct_iter(struct codetag_type *ctt=
ype);
> > > +struct codetag *codetag_next_ct(struct codetag_iterator *iter);
> > > +
> > > +void codetag_to_text(struct seq_buf *out, struct codetag *ct);
> > > +
> > > +struct codetag_type *
> > > +codetag_register_type(const struct codetag_type_desc *desc);
> > > +
> > > +#endif /* _LINUX_CODETAG_H */
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 975a07f9f1cc..0be2d00c3696 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -968,6 +968,10 @@ config DEBUG_STACKOVERFLOW
> > >
> > >         If in doubt, say "N".
> > >
> > > +config CODE_TAGGING
> > > +     bool
> > > +     select KALLSYMS
> > > +
> > >  source "lib/Kconfig.kasan"
> > >  source "lib/Kconfig.kfence"
> > >  source "lib/Kconfig.kmsan"
> > > diff --git a/lib/Makefile b/lib/Makefile
> > > index 6b09731d8e61..6b48b22fdfac 100644
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -235,6 +235,7 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) +=
=3D \
> > >       of-reconfig-notifier-error-inject.o
> > >  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) +=3D error-inject.o
> > >
> > > +obj-$(CONFIG_CODE_TAGGING) +=3D codetag.o
> > >  lib-$(CONFIG_GENERIC_BUG) +=3D bug.o
> > >
> > >  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) +=3D syscall.o
> > > diff --git a/lib/codetag.c b/lib/codetag.c
> > > new file mode 100644
> > > index 000000000000..7708f8388e55
> > > --- /dev/null
> > > +++ b/lib/codetag.c
> > > @@ -0,0 +1,199 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <linux/codetag.h>
> > > +#include <linux/idr.h>
> > > +#include <linux/kallsyms.h>
> > > +#include <linux/module.h>
> > > +#include <linux/seq_buf.h>
> > > +#include <linux/slab.h>
> > > +
> > > +struct codetag_type {
> > > +     struct list_head link;
> > > +     unsigned int count;
> > > +     struct idr mod_idr;
> > > +     struct rw_semaphore mod_lock; /* protects mod_idr */
> > > +     struct codetag_type_desc desc;
> > > +};
> > > +
> > > +static DEFINE_MUTEX(codetag_lock);
> > > +static LIST_HEAD(codetag_types);
> > > +
> > > +void codetag_lock_module_list(struct codetag_type *cttype, bool lock=
)
> > > +{
> > > +     if (lock)
> > > +             down_read(&cttype->mod_lock);
> > > +     else
> > > +             up_read(&cttype->mod_lock);
> > > +}
> > > +
> > > +struct codetag_iterator codetag_get_ct_iter(struct codetag_type *ctt=
ype)
> > > +{
> > > +     struct codetag_iterator iter =3D {
> > > +             .cttype =3D cttype,
> > > +             .cmod =3D NULL,
> > > +             .mod_id =3D 0,
> > > +             .ct =3D NULL,
> > > +     };
> > > +
> > > +     return iter;
> > > +}
> > > +
> > > +static inline struct codetag *get_first_module_ct(struct codetag_mod=
ule *cmod)
> > > +{
> > > +     return cmod->range.start < cmod->range.stop ? cmod->range.start=
 : NULL;
> > > +}
> > > +
> > > +static inline
> > > +struct codetag *get_next_module_ct(struct codetag_iterator *iter)
> > > +{
> > > +     struct codetag *res =3D (struct codetag *)
> > > +                     ((char *)iter->ct + iter->cttype->desc.tag_size=
);
> > > +
> > > +     return res < iter->cmod->range.stop ? res : NULL;
> > > +}
> > > +
> > > +struct codetag *codetag_next_ct(struct codetag_iterator *iter)
> > > +{
> > > +     struct codetag_type *cttype =3D iter->cttype;
> > > +     struct codetag_module *cmod;
> > > +     struct codetag *ct;
> > > +
> > > +     lockdep_assert_held(&cttype->mod_lock);
> > > +
> > > +     if (unlikely(idr_is_empty(&cttype->mod_idr)))
> > > +             return NULL;
> > > +
> > > +     ct =3D NULL;
> > > +     while (true) {
> > > +             cmod =3D idr_find(&cttype->mod_idr, iter->mod_id);
> > > +
> > > +             /* If module was removed move to the next one */
> > > +             if (!cmod)
> > > +                     cmod =3D idr_get_next_ul(&cttype->mod_idr,
> > > +                                            &iter->mod_id);
> > > +
> > > +             /* Exit if no more modules */
> > > +             if (!cmod)
> > > +                     break;
> > > +
> > > +             if (cmod !=3D iter->cmod) {
> > > +                     iter->cmod =3D cmod;
> > > +                     ct =3D get_first_module_ct(cmod);
> > > +             } else
> > > +                     ct =3D get_next_module_ct(iter);
> > > +
> > > +             if (ct)
> > > +                     break;
> > > +
> > > +             iter->mod_id++;
> > > +     }
> > > +
> > > +     iter->ct =3D ct;
> > > +     return ct;
> > > +}
> > > +
> > > +void codetag_to_text(struct seq_buf *out, struct codetag *ct)
> > > +{
> > > +     seq_buf_printf(out, "%s:%u module:%s func:%s",
> > > +                    ct->filename, ct->lineno,
> > > +                    ct->modname, ct->function);
> > > +}
> >
> > Thank you for using seq_buf here!
> >
> > Also, will this need an EXPORT_SYMBOL_GPL()?

Missed this question. I don't think we need EXPORT_SYMBOL_GPL() here
at least for now. Modules don't use these functions. The "alloc_tags"
sections will be generated for each module at compile time but they
themselves do not use it.

> >
> > > +
> > > +static inline size_t range_size(const struct codetag_type *cttype,
> > > +                             const struct codetag_range *range)
> > > +{
> > > +     return ((char *)range->stop - (char *)range->start) /
> > > +                     cttype->desc.tag_size;
> > > +}
> > > +
> > > +static void *get_symbol(struct module *mod, const char *prefix, cons=
t char *name)
> > > +{
> > > +     char buf[64];
> >
> > Why is 64 enough? I was expecting KSYM_NAME_LEN here, but perhaps this
> > is specialized enough to section names that it will not be a problem?
>
> This buffer is being used to hold the name of the section containing
> codetags appended with "__start_" or "__stop_" and the only current
> user is alloc_tag_init() which sets the section name to "alloc_tags".
> So, this buffer currently holds either "alloc_tags__start_" or
> "alloc_tags__stop_". When more codetag applications are added (like
> the ones we have shown in the original RFC [1]), there would be more
> section names. 64 was chosen as a big enough value to reasonably hold
> the section name with the suffix. But you are right, we should add a
> check for the section name size to ensure it always fits. Will add
> into my TODO list.
>
> [1] https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.com/
> > If so, please document it clearly with a comment.
>
> Will do.
>
> >
> > > +     int res;
> > > +
> > > +     res =3D snprintf(buf, sizeof(buf), "%s%s", prefix, name);
> > > +     if (WARN_ON(res < 1 || res > sizeof(buf)))
> > > +             return NULL;
> >
> > Please use a seq_buf here instead of snprintf, which we're trying to ge=
t
> > rid of.
> >
> >         DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
> >         char *buf;
> >
> >         seq_buf_printf(sb, "%s%s", prefix, name);
> >         if (seq_buf_has_overflowed(sb))
> >                 return NULL;
> >
> >         buf =3D seq_buf_str(sb);
>
> Will do. Thanks!
>
> >
> > > +
> > > +     return mod ?
> > > +             (void *)find_kallsyms_symbol_value(mod, buf) :
> > > +             (void *)kallsyms_lookup_name(buf);
> > > +}
> > > +
> > > +static struct codetag_range get_section_range(struct module *mod,
> > > +                                           const char *section)
> > > +{
> > > +     return (struct codetag_range) {
> > > +             get_symbol(mod, "__start_", section),
> > > +             get_symbol(mod, "__stop_", section),
> > > +     };
> > > +}
> > > +
> > > +static int codetag_module_init(struct codetag_type *cttype, struct m=
odule *mod)
> > > +{
> > > +     struct codetag_range range;
> > > +     struct codetag_module *cmod;
> > > +     int err;
> > > +
> > > +     range =3D get_section_range(mod, cttype->desc.section);
> > > +     if (!range.start || !range.stop) {
> > > +             pr_warn("Failed to load code tags of type %s from the m=
odule %s\n",
> > > +                     cttype->desc.section,
> > > +                     mod ? mod->name : "(built-in)");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     /* Ignore empty ranges */
> > > +     if (range.start =3D=3D range.stop)
> > > +             return 0;
> > > +
> > > +     BUG_ON(range.start > range.stop);
> > > +
> > > +     cmod =3D kmalloc(sizeof(*cmod), GFP_KERNEL);
> > > +     if (unlikely(!cmod))
> > > +             return -ENOMEM;
> > > +
> > > +     cmod->mod =3D mod;
> > > +     cmod->range =3D range;
> > > +
> > > +     down_write(&cttype->mod_lock);
> > > +     err =3D idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
> > > +     if (err >=3D 0)
> > > +             cttype->count +=3D range_size(cttype, &range);
> > > +     up_write(&cttype->mod_lock);
> > > +
> > > +     if (err < 0) {
> > > +             kfree(cmod);
> > > +             return err;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +struct codetag_type *
> > > +codetag_register_type(const struct codetag_type_desc *desc)
> > > +{
> > > +     struct codetag_type *cttype;
> > > +     int err;
> > > +
> > > +     BUG_ON(desc->tag_size <=3D 0);
> > > +
> > > +     cttype =3D kzalloc(sizeof(*cttype), GFP_KERNEL);
> > > +     if (unlikely(!cttype))
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     cttype->desc =3D *desc;
> > > +     idr_init(&cttype->mod_idr);
> > > +     init_rwsem(&cttype->mod_lock);
> > > +
> > > +     err =3D codetag_module_init(cttype, NULL);
> > > +     if (unlikely(err)) {
> > > +             kfree(cttype);
> > > +             return ERR_PTR(err);
> > > +     }
> > > +
> > > +     mutex_lock(&codetag_lock);
> > > +     list_add_tail(&cttype->link, &codetag_types);
> > > +     mutex_unlock(&codetag_lock);
> > > +
> > > +     return cttype;
> > > +}
> > > --
> > > 2.43.0.687.g38aa6559b0-goog
> > >
> >
> > --
> > Kees Cook

