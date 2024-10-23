Return-Path: <linux-arch+bounces-8492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244E9AD395
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 20:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB86A1F22EE1
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E21A1D016A;
	Wed, 23 Oct 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="RtwE9vW/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22891C9DF0
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706777; cv=none; b=cZtqymoWHzRu6h8aVCP4O67xfsKRSDJVSXSYcH06vrJd8VBcZOar3e+uBDTT6VWcDZTag0jBnQ8IwKVSbREk0l47FmrOl1fMHHn0BMR75D/9zexY0QZa/8/T095CtnJDHdJJlZmenDUNnfe1AC5TKFsDuyThh0HCg3wWqqwVqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706777; c=relaxed/simple;
	bh=cj0wmYda6JyKfzAQ9+bP1HClP7SpBRbFhoC6ogfR6uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIs6h+tLCG/U8TqvCEBubMVbe7RFzIyVqzaTv5e/i0QNnyGYaJFTYTHalSsXGPHBIghxUC8bEESjyfvlbkWmjDVqJ6yh4b2FaOYIrtqrRmJqdKtJMlI/KZRu64c2SpGostrofK0THSUVidzWsA/cstS0FmPqjwoimpXKuWMHH1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=RtwE9vW/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46089a6849bso391501cf.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729706772; x=1730311572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7x/JU5xDajAsQP3ObgBUaPMttV7xfl0iIdjNQ1icZ4=;
        b=RtwE9vW/jyH9tWrKRc0kL0jtroak1cHAmTr1OFPNoLUmSlU4Au0NwpOWDoJNCCYb57
         klus225UxP+uZfUSb8iKdpeHyujTZPj6n0Q0JEkaoLqm6dlkfVnn62h2cNJXTD8gPzbB
         9K2KGhpf/HS3y5dDkMkLwnSYexs/u2ey06srdimR5p64kKbvlHLJCCmy8z6fMGeBEcMg
         fafQknkFLs82UkKk/SetUH5tXkzIPj4yJTUrTU53tQkqdThwYXb93GZOMuKjmqvgakNP
         g4jFJJyXfeTU+Jl+n+5pJ6l4+7LjFZuiH6V+LrtefaSUxhyUU0dhBLQaGX1RG//Ptr83
         tRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706772; x=1730311572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7x/JU5xDajAsQP3ObgBUaPMttV7xfl0iIdjNQ1icZ4=;
        b=EReGbNZilmdTbgOKj0o2c9UY+GG4qR1xIsQrA0j+qWeQvdKLwoLm2+wFStqp4zw3mt
         Zc+XUs6mhOwEf+q8Oe6NQYfN9H6JZbexqQruZOIVAWPjeHRCQNylhiqqZ8elpNcP/mq1
         3rsNKRSKCfwmsiQSXjZMaZdhHody2nJEtDs1RKdVhMDE2jBI8STHnOJrwFSWcZijWSLY
         JS6kWcoS1/+iEkeJj2EjzxL1Ys3k280T+Gq+5f/FAYD+F2vPyq5oebH0cj1Yk+z3yYwO
         cRVGEtrLiCR1MT66dVqS/DhAf9G7BF5lDuuIhjkazNM841im1My59w/xwJIGKEJMmJ9y
         0hEA==
X-Forwarded-Encrypted: i=1; AJvYcCX/t4YmWi2Wdh8bgJH8mvYkJ1fVjWtT5IPVRlHKzLu6HMjCuQkp61gEASMtJOfj+i7ON4k9I8mjfiFF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6YylrtQXMOZJItsik/jpUIlemvmje1Kr2ChUoR70JgDotKQiZ
	M+qqjOpiP5ZeD8he/7mLnvq8fDDUAkWoa+aq8z+FLdEUv4KNaOggUeLp2gmk0IgYxMOqhHRR+DW
	DN/vWpGFO8jA3JSeIUur6L1t3AnL9/cRLBJJRkw==
X-Google-Smtp-Source: AGHT+IE4KocYcI5mH80pu7NezqX1BOMC9zHIl2XfYZwbbn0D9UoHHrh7Hk4dVuya9HPeLuMFBmhi0afBey9pZL05d7Q=
X-Received: by 2002:ac8:594a:0:b0:460:a9d1:48b4 with SMTP id
 d75a77b69052e-461146d53e7mr36920061cf.32.1729706772256; Wed, 23 Oct 2024
 11:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-4-surenb@google.com>
In-Reply-To: <20241023170759.999909-4-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 14:05:34 -0400
Message-ID: <CA+CK2bAo+i5d0jWgvOFcdNXwGATT3gQ7eQB8N-HyFRWe6-PmxA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] alloc_tag: load module tags into separate
 contiguous memory
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> When a module gets unloaded there is a possibility that some of the
> allocations it made are still used and therefore the allocation tags
> corresponding to these allocations are still referenced. As such, the
> memory for these tags can't be freed. This is currently handled as an
> abnormal situation and module's data section is not being unloaded.
> To handle this situation without keeping module's data in memory,
> allow codetags with longer lifespan than the module to be loaded into
> their own separate memory. The in-use memory areas and gaps after
> module unloading in this separate memory are tracked using maple trees.
> Allocation tags arrange their separate memory so that it is virtually
> contiguous and that will allow simple allocation tag indexing later on
> in this patchset. The size of this virtually contiguous memory is set
> to store up to 100000 allocation tags.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

> ---
>  include/asm-generic/codetag.lds.h |  19 +++
>  include/linux/alloc_tag.h         |  13 +-
>  include/linux/codetag.h           |  37 ++++-
>  kernel/module/main.c              |  80 ++++++----
>  lib/alloc_tag.c                   | 249 +++++++++++++++++++++++++++---
>  lib/codetag.c                     | 100 +++++++++++-
>  scripts/module.lds.S              |   5 +-
>  7 files changed, 441 insertions(+), 62 deletions(-)
>
> diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/code=
tag.lds.h
> index 64f536b80380..372c320c5043 100644
> --- a/include/asm-generic/codetag.lds.h
> +++ b/include/asm-generic/codetag.lds.h
> @@ -11,4 +11,23 @@
>  #define CODETAG_SECTIONS()             \
>         SECTION_WITH_BOUNDARIES(alloc_tags)
>
> +/*
> + * Module codetags which aren't used after module unload, therefore have=
 the
> + * same lifespan as the module and can be safely unloaded with the modul=
e.
> + */
> +#define MOD_CODETAG_SECTIONS()
> +
> +#define MOD_SEPARATE_CODETAG_SECTION(_name)    \
> +       .codetag.##_name : {                    \
> +               SECTION_WITH_BOUNDARIES(_name)  \
> +       }
> +
> +/*
> + * For codetags which might be used after module unload, therefore might=
 stay
> + * longer in memory. Each such codetag type has its own section so that =
we can
> + * unload them individually once unused.
> + */
> +#define MOD_SEPARATE_CODETAG_SECTIONS()                \
> +       MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
> +
>  #endif /* __ASM_GENERIC_CODETAG_LDS_H */
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 1f0a9ff23a2c..7431757999c5 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -30,6 +30,13 @@ struct alloc_tag {
>         struct alloc_tag_counters __percpu      *counters;
>  } __aligned(8);
>
> +struct alloc_tag_module_section {
> +       unsigned long start_addr;
> +       unsigned long end_addr;
> +       /* used size */
> +       unsigned long size;
> +};
> +
>  #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
>
>  #define CODETAG_EMPTY  ((void *)1)
> @@ -54,6 +61,8 @@ static inline void set_codetag_empty(union codetag_ref =
*ref) {}
>
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
>
> +#define ALLOC_TAG_SECTION_NAME "alloc_tags"
> +
>  struct codetag_bytes {
>         struct codetag *ct;
>         s64 bytes;
> @@ -76,7 +85,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_allo=
c_tag);
>
>  #define DEFINE_ALLOC_TAG(_alloc_tag)                                    =
       \
>         static struct alloc_tag _alloc_tag __used __aligned(8)           =
       \
> -       __section("alloc_tags") =3D {                                    =
         \
> +       __section(ALLOC_TAG_SECTION_NAME) =3D {                          =
         \
>                 .ct =3D CODE_TAG_INIT,                                   =
         \
>                 .counters =3D &_shared_alloc_tag };
>
> @@ -85,7 +94,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_allo=
c_tag);
>  #define DEFINE_ALLOC_TAG(_alloc_tag)                                    =
       \
>         static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr)=
;      \
>         static struct alloc_tag _alloc_tag __used __aligned(8)           =
       \
> -       __section("alloc_tags") =3D {                                    =
         \
> +       __section(ALLOC_TAG_SECTION_NAME) =3D {                          =
         \
>                 .ct =3D CODE_TAG_INIT,                                   =
         \
>                 .counters =3D &_alloc_tag_cntr };
>
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index c2a579ccd455..d10bd9810d32 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -35,8 +35,15 @@ struct codetag_type_desc {
>         size_t tag_size;
>         void (*module_load)(struct codetag_type *cttype,
>                             struct codetag_module *cmod);
> -       bool (*module_unload)(struct codetag_type *cttype,
> +       void (*module_unload)(struct codetag_type *cttype,
>                               struct codetag_module *cmod);
> +#ifdef CONFIG_MODULES
> +       void (*module_replaced)(struct module *mod, struct module *new_mo=
d);
> +       bool (*needs_section_mem)(struct module *mod, unsigned long size)=
;
> +       void *(*alloc_section_mem)(struct module *mod, unsigned long size=
,
> +                                  unsigned int prepend, unsigned long al=
ign);
> +       void (*free_section_mem)(struct module *mod, bool used);
> +#endif
>  };
>
>  struct codetag_iterator {
> @@ -71,11 +78,31 @@ struct codetag_type *
>  codetag_register_type(const struct codetag_type_desc *desc);
>
>  #if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
> +
> +bool codetag_needs_module_section(struct module *mod, const char *name,
> +                                 unsigned long size);
> +void *codetag_alloc_module_section(struct module *mod, const char *name,
> +                                  unsigned long size, unsigned int prepe=
nd,
> +                                  unsigned long align);
> +void codetag_free_module_sections(struct module *mod);
> +void codetag_module_replaced(struct module *mod, struct module *new_mod)=
;
>  void codetag_load_module(struct module *mod);
> -bool codetag_unload_module(struct module *mod);
> -#else
> +void codetag_unload_module(struct module *mod);
> +
> +#else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> +
> +static inline bool
> +codetag_needs_module_section(struct module *mod, const char *name,
> +                            unsigned long size) { return false; }
> +static inline void *
> +codetag_alloc_module_section(struct module *mod, const char *name,
> +                            unsigned long size, unsigned int prepend,
> +                            unsigned long align) { return NULL; }
> +static inline void codetag_free_module_sections(struct module *mod) {}
> +static inline void codetag_module_replaced(struct module *mod, struct mo=
dule *new_mod) {}
>  static inline void codetag_load_module(struct module *mod) {}
> -static inline bool codetag_unload_module(struct module *mod) { return tr=
ue; }
> -#endif
> +static inline void codetag_unload_module(struct module *mod) {}
> +
> +#endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
>
>  #endif /* _LINUX_CODETAG_H */
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index ef54733bd7d2..1787686e5cae 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1254,22 +1254,17 @@ static int module_memory_alloc(struct module *mod=
, enum mod_mem_type type)
>         return 0;
>  }
>
> -static void module_memory_free(struct module *mod, enum mod_mem_type typ=
e,
> -                              bool unload_codetags)
> +static void module_memory_free(struct module *mod, enum mod_mem_type typ=
e)
>  {
>         struct module_memory *mem =3D &mod->mem[type];
> -       void *ptr =3D mem->base;
>
>         if (mem->is_rox)
>                 vfree(mem->rw_copy);
>
> -       if (!unload_codetags && mod_mem_type_is_core_data(type))
> -               return;
> -
> -       execmem_free(ptr);
> +       execmem_free(mem->base);
>  }
>
> -static void free_mod_mem(struct module *mod, bool unload_codetags)
> +static void free_mod_mem(struct module *mod)
>  {
>         for_each_mod_mem_type(type) {
>                 struct module_memory *mod_mem =3D &mod->mem[type];
> @@ -1280,25 +1275,20 @@ static void free_mod_mem(struct module *mod, bool=
 unload_codetags)
>                 /* Free lock-classes; relies on the preceding sync_rcu().=
 */
>                 lockdep_free_key_range(mod_mem->base, mod_mem->size);
>                 if (mod_mem->size)
> -                       module_memory_free(mod, type, unload_codetags);
> +                       module_memory_free(mod, type);
>         }
>
>         /* MOD_DATA hosts mod, so free it at last */
>         lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA=
].size);
> -       module_memory_free(mod, MOD_DATA, unload_codetags);
> +       module_memory_free(mod, MOD_DATA);
>  }
>
>  /* Free a module, remove from lists, etc. */
>  static void free_module(struct module *mod)
>  {
> -       bool unload_codetags;
> -
>         trace_module_free(mod);
>
> -       unload_codetags =3D codetag_unload_module(mod);
> -       if (!unload_codetags)
> -               pr_warn("%s: memory allocation(s) from the module still a=
live, cannot unload cleanly\n",
> -                       mod->name);
> +       codetag_unload_module(mod);
>
>         mod_sysfs_teardown(mod);
>
> @@ -1341,7 +1331,7 @@ static void free_module(struct module *mod)
>         kfree(mod->args);
>         percpu_modfree(mod);
>
> -       free_mod_mem(mod, unload_codetags);
> +       free_mod_mem(mod);
>  }
>
>  void *__symbol_get(const char *symbol)
> @@ -1606,6 +1596,20 @@ static void __layout_sections(struct module *mod, =
struct load_info *info, bool i
>                         if (WARN_ON_ONCE(type =3D=3D MOD_INVALID))
>                                 continue;
>
> +                       /*
> +                        * Do not allocate codetag memory as we load it i=
nto
> +                        * preallocated contiguous memory.
> +                        */
> +                       if (codetag_needs_module_section(mod, sname, s->s=
h_size)) {
> +                               /*
> +                                * s->sh_entsize won't be used but popula=
te the
> +                                * type field to avoid confusion.
> +                                */
> +                               s->sh_entsize =3D ((unsigned long)(type) =
& SH_ENTSIZE_TYPE_MASK)
> +                                               << SH_ENTSIZE_TYPE_SHIFT;
> +                               continue;
> +                       }
> +
>                         s->sh_entsize =3D module_get_offset_and_type(mod,=
 type, s, i);
>                         pr_debug("\t%s\n", sname);
>                 }
> @@ -2280,6 +2284,7 @@ static int move_module(struct module *mod, struct l=
oad_info *info)
>         int i;
>         enum mod_mem_type t =3D 0;
>         int ret =3D -ENOMEM;
> +       bool codetag_section_found =3D false;
>
>         for_each_mod_mem_type(type) {
>                 if (!mod->mem[type].size) {
> @@ -2291,7 +2296,7 @@ static int move_module(struct module *mod, struct l=
oad_info *info)
>                 ret =3D module_memory_alloc(mod, type);
>                 if (ret) {
>                         t =3D type;
> -                       goto out_enomem;
> +                       goto out_err;
>                 }
>         }
>
> @@ -2300,15 +2305,33 @@ static int move_module(struct module *mod, struct=
 load_info *info)
>         for (i =3D 0; i < info->hdr->e_shnum; i++) {
>                 void *dest;
>                 Elf_Shdr *shdr =3D &info->sechdrs[i];
> -               enum mod_mem_type type =3D shdr->sh_entsize >> SH_ENTSIZE=
_TYPE_SHIFT;
> -               unsigned long offset =3D shdr->sh_entsize & SH_ENTSIZE_OF=
FSET_MASK;
> +               const char *sname;
>                 unsigned long addr;
>
>                 if (!(shdr->sh_flags & SHF_ALLOC))
>                         continue;
>
> -               addr =3D (unsigned long)mod->mem[type].base + offset;
> -               dest =3D mod->mem[type].rw_copy + offset;
> +               sname =3D info->secstrings + shdr->sh_name;
> +               /*
> +                * Load codetag sections separately as they might still b=
e used
> +                * after module unload.
> +                */
> +               if (codetag_needs_module_section(mod, sname, shdr->sh_siz=
e)) {
> +                       dest =3D codetag_alloc_module_section(mod, sname,=
 shdr->sh_size,
> +                                       arch_mod_section_prepend(mod, i),=
 shdr->sh_addralign);
> +                       if (IS_ERR(dest)) {
> +                               ret =3D PTR_ERR(dest);
> +                               goto out_err;
> +                       }
> +                       addr =3D (unsigned long)dest;
> +                       codetag_section_found =3D true;
> +               } else {
> +                       enum mod_mem_type type =3D shdr->sh_entsize >> SH=
_ENTSIZE_TYPE_SHIFT;
> +                       unsigned long offset =3D shdr->sh_entsize & SH_EN=
TSIZE_OFFSET_MASK;
> +
> +                       addr =3D (unsigned long)mod->mem[type].base + off=
set;
> +                       dest =3D mod->mem[type].rw_copy + offset;
> +               }
>
>                 if (shdr->sh_type !=3D SHT_NOBITS) {
>                         /*
> @@ -2320,7 +2343,7 @@ static int move_module(struct module *mod, struct l=
oad_info *info)
>                         if (i =3D=3D info->index.mod &&
>                            (WARN_ON_ONCE(shdr->sh_size !=3D sizeof(struct=
 module)))) {
>                                 ret =3D -ENOEXEC;
> -                               goto out_enomem;
> +                               goto out_err;
>                         }
>                         memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size=
);
>                 }
> @@ -2336,9 +2359,12 @@ static int move_module(struct module *mod, struct =
load_info *info)
>         }
>
>         return 0;
> -out_enomem:
> +out_err:
>         for (t--; t >=3D 0; t--)
> -               module_memory_free(mod, t, true);
> +               module_memory_free(mod, t);
> +       if (codetag_section_found)
> +               codetag_free_module_sections(mod);
> +
>         return ret;
>  }
>
> @@ -2459,6 +2485,8 @@ static struct module *layout_and_allocate(struct lo=
ad_info *info, int flags)
>         /* Module has been copied to its final place now: return it. */
>         mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
>         kmemleak_load_module(mod, info);
> +       codetag_module_replaced(info->mod, mod);
> +
>         return mod;
>  }
>
> @@ -2468,7 +2496,7 @@ static void module_deallocate(struct module *mod, s=
truct load_info *info)
>         percpu_modfree(mod);
>         module_arch_freeing_init(mod);
>
> -       free_mod_mem(mod, true);
> +       free_mod_mem(mod);
>  }
>
>  int __weak module_finalize(const Elf_Ehdr *hdr,
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 435aa837e550..d9f51169ffeb 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/alloc_tag.h>
> +#include <linux/execmem.h>
>  #include <linux/fs.h>
>  #include <linux/gfp.h>
>  #include <linux/module.h>
> @@ -9,6 +10,7 @@
>  #include <linux/seq_file.h>
>
>  #define ALLOCINFO_FILE_NAME            "allocinfo"
> +#define MODULE_ALLOC_TAG_VMAP_SIZE     (100000UL * sizeof(struct alloc_t=
ag))
>
>  #ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
>  static bool mem_profiling_support __meminitdata =3D true;
> @@ -174,31 +176,226 @@ static void __init procfs_init(void)
>         }
>  }
>
> -static bool alloc_tag_module_unload(struct codetag_type *cttype,
> -                                   struct codetag_module *cmod)
> +#ifdef CONFIG_MODULES
> +
> +static struct maple_tree mod_area_mt =3D MTREE_INIT(mod_area_mt, MT_FLAG=
S_ALLOC_RANGE);
> +/* A dummy object used to indicate an unloaded module */
> +static struct module unloaded_mod;
> +/* A dummy object used to indicate a module prepended area */
> +static struct module prepend_mod;
> +
> +static struct alloc_tag_module_section module_tags;
> +
> +static bool needs_section_mem(struct module *mod, unsigned long size)
>  {
> -       struct codetag_iterator iter =3D codetag_get_ct_iter(cttype);
> -       struct alloc_tag_counters counter;
> -       bool module_unused =3D true;
> -       struct alloc_tag *tag;
> -       struct codetag *ct;
> +       return size >=3D sizeof(struct alloc_tag);
> +}
> +
> +static struct alloc_tag *find_used_tag(struct alloc_tag *from, struct al=
loc_tag *to)
> +{
> +       while (from <=3D to) {
> +               struct alloc_tag_counters counter;
>
> -       for (ct =3D codetag_next_ct(&iter); ct; ct =3D codetag_next_ct(&i=
ter)) {
> -               if (iter.cmod !=3D cmod)
> +               counter =3D alloc_tag_read(from);
> +               if (counter.bytes)
> +                       return from;
> +               from++;
> +       }
> +
> +       return NULL;
> +}
> +
> +/* Called with mod_area_mt locked */
> +static void clean_unused_module_areas_locked(void)
> +{
> +       MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> +       struct module *val;
> +
> +       mas_for_each(&mas, val, module_tags.size) {
> +               if (val !=3D &unloaded_mod)
>                         continue;
>
> -               tag =3D ct_to_alloc_tag(ct);
> -               counter =3D alloc_tag_read(tag);
> +               /* Release area if all tags are unused */
> +               if (!find_used_tag((struct alloc_tag *)(module_tags.start=
_addr + mas.index),
> +                                  (struct alloc_tag *)(module_tags.start=
_addr + mas.last)))
> +                       mas_erase(&mas);
> +       }
> +}
> +
> +/* Called with mod_area_mt locked */
> +static bool find_aligned_area(struct ma_state *mas, unsigned long sectio=
n_size,
> +                             unsigned long size, unsigned int prepend, u=
nsigned long align)
> +{
> +       bool cleanup_done =3D false;
> +
> +repeat:
> +       /* Try finding exact size and hope the start is aligned */
> +       if (!mas_empty_area(mas, 0, section_size - 1, prepend + size)) {
> +               if (IS_ALIGNED(mas->index + prepend, align))
> +                       return true;
> +
> +               /* Try finding larger area to align later */
> +               mas_reset(mas);
> +               if (!mas_empty_area(mas, 0, section_size - 1,
> +                                   size + prepend + align - 1))
> +                       return true;
> +       }
>
> -               if (WARN(counter.bytes,
> -                        "%s:%u module %s func:%s has %llu allocated at m=
odule unload",
> -                        ct->filename, ct->lineno, ct->modname, ct->funct=
ion, counter.bytes))
> -                       module_unused =3D false;
> +       /* No free area, try cleanup stale data and repeat the search onc=
e */
> +       if (!cleanup_done) {
> +               clean_unused_module_areas_locked();
> +               cleanup_done =3D true;
> +               mas_reset(mas);
> +               goto repeat;
>         }
>
> -       return module_unused;
> +       return false;
> +}
> +
> +static void *reserve_module_tags(struct module *mod, unsigned long size,
> +                                unsigned int prepend, unsigned long alig=
n)
> +{
> +       unsigned long section_size =3D module_tags.end_addr - module_tags=
.start_addr;
> +       MA_STATE(mas, &mod_area_mt, 0, section_size - 1);
> +       unsigned long offset;
> +       void *ret =3D NULL;
> +
> +       /* If no tags return NULL */
> +       if (size < sizeof(struct alloc_tag))
> +               return NULL;
> +
> +       /*
> +        * align is always power of 2, so we can use IS_ALIGNED and ALIGN=
.
> +        * align 0 or 1 means no alignment, to simplify set to 1.
> +        */
> +       if (!align)
> +               align =3D 1;
> +
> +       mas_lock(&mas);
> +       if (!find_aligned_area(&mas, section_size, size, prepend, align))=
 {
> +               ret =3D ERR_PTR(-ENOMEM);
> +               goto unlock;
> +       }
> +
> +       /* Mark found area as reserved */
> +       offset =3D mas.index;
> +       offset +=3D prepend;
> +       offset =3D ALIGN(offset, align);
> +       if (offset !=3D mas.index) {
> +               unsigned long pad_start =3D mas.index;
> +
> +               mas.last =3D offset - 1;
> +               mas_store(&mas, &prepend_mod);
> +               if (mas_is_err(&mas)) {
> +                       ret =3D ERR_PTR(xa_err(mas.node));
> +                       goto unlock;
> +               }
> +               mas.index =3D offset;
> +               mas.last =3D offset + size - 1;
> +               mas_store(&mas, mod);
> +               if (mas_is_err(&mas)) {
> +                       mas.index =3D pad_start;
> +                       mas_erase(&mas);
> +                       ret =3D ERR_PTR(xa_err(mas.node));
> +               }
> +       } else {
> +               mas.last =3D offset + size - 1;
> +               mas_store(&mas, mod);
> +               if (mas_is_err(&mas))
> +                       ret =3D ERR_PTR(xa_err(mas.node));
> +       }
> +unlock:
> +       mas_unlock(&mas);
> +
> +       if (IS_ERR(ret))
> +               return ret;
> +
> +       if (module_tags.size < offset + size)
> +               module_tags.size =3D offset + size;
> +
> +       return (struct alloc_tag *)(module_tags.start_addr + offset);
>  }
>
> +static void release_module_tags(struct module *mod, bool used)
> +{
> +       MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
> +       struct alloc_tag *tag;
> +       struct module *val;
> +
> +       mas_lock(&mas);
> +       mas_for_each_rev(&mas, val, 0)
> +               if (val =3D=3D mod)
> +                       break;
> +
> +       if (!val) /* module not found */
> +               goto out;
> +
> +       if (!used)
> +               goto release_area;
> +
> +       /* Find out if the area is used */
> +       tag =3D find_used_tag((struct alloc_tag *)(module_tags.start_addr=
 + mas.index),
> +                           (struct alloc_tag *)(module_tags.start_addr +=
 mas.last));
> +       if (tag) {
> +               struct alloc_tag_counters counter =3D alloc_tag_read(tag)=
;
> +
> +               pr_info("%s:%u module %s func:%s has %llu allocated at mo=
dule unload\n",
> +                       tag->ct.filename, tag->ct.lineno, tag->ct.modname=
,
> +                       tag->ct.function, counter.bytes);
> +       } else {
> +               used =3D false;
> +       }
> +release_area:
> +       mas_store(&mas, used ? &unloaded_mod : NULL);
> +       val =3D mas_prev_range(&mas, 0);
> +       if (val =3D=3D &prepend_mod)
> +               mas_store(&mas, NULL);
> +out:
> +       mas_unlock(&mas);
> +}
> +
> +static void replace_module(struct module *mod, struct module *new_mod)
> +{
> +       MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> +       struct module *val;
> +
> +       mas_lock(&mas);
> +       mas_for_each(&mas, val, module_tags.size) {
> +               if (val !=3D mod)
> +                       continue;
> +
> +               mas_store_gfp(&mas, new_mod, GFP_KERNEL);
> +               break;
> +       }
> +       mas_unlock(&mas);
> +}
> +
> +static int __init alloc_mod_tags_mem(void)
> +{
> +       /* Allocate space to copy allocation tags */
> +       module_tags.start_addr =3D (unsigned long)execmem_alloc(EXECMEM_M=
ODULE_DATA,
> +                                                             MODULE_ALLO=
C_TAG_VMAP_SIZE);
> +       if (!module_tags.start_addr)
> +               return -ENOMEM;
> +
> +       module_tags.end_addr =3D module_tags.start_addr + MODULE_ALLOC_TA=
G_VMAP_SIZE;
> +
> +       return 0;
> +}
> +
> +static void __init free_mod_tags_mem(void)
> +{
> +       execmem_free((void *)module_tags.start_addr);
> +       module_tags.start_addr =3D 0;
> +}
> +
> +#else /* CONFIG_MODULES */
> +
> +static inline int alloc_mod_tags_mem(void) { return 0; }
> +static inline void free_mod_tags_mem(void) {}
> +
> +#endif /* CONFIG_MODULES */
> +
>  static int __init setup_early_mem_profiling(char *str)
>  {
>         bool enable;
> @@ -274,14 +471,26 @@ static inline void sysctl_init(void) {}
>  static int __init alloc_tag_init(void)
>  {
>         const struct codetag_type_desc desc =3D {
> -               .section        =3D "alloc_tags",
> -               .tag_size       =3D sizeof(struct alloc_tag),
> -               .module_unload  =3D alloc_tag_module_unload,
> +               .section                =3D ALLOC_TAG_SECTION_NAME,
> +               .tag_size               =3D sizeof(struct alloc_tag),
> +#ifdef CONFIG_MODULES
> +               .needs_section_mem      =3D needs_section_mem,
> +               .alloc_section_mem      =3D reserve_module_tags,
> +               .free_section_mem       =3D release_module_tags,
> +               .module_replaced        =3D replace_module,
> +#endif
>         };
> +       int res;
> +
> +       res =3D alloc_mod_tags_mem();
> +       if (res)
> +               return res;
>
>         alloc_tag_cttype =3D codetag_register_type(&desc);
> -       if (IS_ERR(alloc_tag_cttype))
> +       if (IS_ERR(alloc_tag_cttype)) {
> +               free_mod_tags_mem();
>                 return PTR_ERR(alloc_tag_cttype);
> +       }
>
>         sysctl_init();
>         procfs_init();
> diff --git a/lib/codetag.c b/lib/codetag.c
> index d1fbbb7c2ec3..654496952f86 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -207,6 +207,94 @@ static int codetag_module_init(struct codetag_type *=
cttype, struct module *mod)
>  }
>
>  #ifdef CONFIG_MODULES
> +#define CODETAG_SECTION_PREFIX ".codetag."
> +
> +/* Some codetag types need a separate module section */
> +bool codetag_needs_module_section(struct module *mod, const char *name,
> +                                 unsigned long size)
> +{
> +       const char *type_name;
> +       struct codetag_type *cttype;
> +       bool ret =3D false;
> +
> +       if (strncmp(name, CODETAG_SECTION_PREFIX, strlen(CODETAG_SECTION_=
PREFIX)))
> +               return false;
> +
> +       type_name =3D name + strlen(CODETAG_SECTION_PREFIX);
> +       mutex_lock(&codetag_lock);
> +       list_for_each_entry(cttype, &codetag_types, link) {
> +               if (strcmp(type_name, cttype->desc.section) =3D=3D 0) {
> +                       if (!cttype->desc.needs_section_mem)
> +                               break;
> +
> +                       down_write(&cttype->mod_lock);
> +                       ret =3D cttype->desc.needs_section_mem(mod, size)=
;
> +                       up_write(&cttype->mod_lock);
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&codetag_lock);
> +
> +       return ret;
> +}
> +
> +void *codetag_alloc_module_section(struct module *mod, const char *name,
> +                                  unsigned long size, unsigned int prepe=
nd,
> +                                  unsigned long align)
> +{
> +       const char *type_name =3D name + strlen(CODETAG_SECTION_PREFIX);
> +       struct codetag_type *cttype;
> +       void *ret =3D NULL;
> +
> +       mutex_lock(&codetag_lock);
> +       list_for_each_entry(cttype, &codetag_types, link) {
> +               if (strcmp(type_name, cttype->desc.section) =3D=3D 0) {
> +                       if (WARN_ON(!cttype->desc.alloc_section_mem))
> +                               break;
> +
> +                       down_write(&cttype->mod_lock);
> +                       ret =3D cttype->desc.alloc_section_mem(mod, size,=
 prepend, align);
> +                       up_write(&cttype->mod_lock);
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&codetag_lock);
> +
> +       return ret;
> +}
> +
> +void codetag_free_module_sections(struct module *mod)
> +{
> +       struct codetag_type *cttype;
> +
> +       mutex_lock(&codetag_lock);
> +       list_for_each_entry(cttype, &codetag_types, link) {
> +               if (!cttype->desc.free_section_mem)
> +                       continue;
> +
> +               down_write(&cttype->mod_lock);
> +               cttype->desc.free_section_mem(mod, false);
> +               up_write(&cttype->mod_lock);
> +       }
> +       mutex_unlock(&codetag_lock);
> +}
> +
> +void codetag_module_replaced(struct module *mod, struct module *new_mod)
> +{
> +       struct codetag_type *cttype;
> +
> +       mutex_lock(&codetag_lock);
> +       list_for_each_entry(cttype, &codetag_types, link) {
> +               if (!cttype->desc.module_replaced)
> +                       continue;
> +
> +               down_write(&cttype->mod_lock);
> +               cttype->desc.module_replaced(mod, new_mod);
> +               up_write(&cttype->mod_lock);
> +       }
> +       mutex_unlock(&codetag_lock);
> +}
> +
>  void codetag_load_module(struct module *mod)
>  {
>         struct codetag_type *cttype;
> @@ -220,13 +308,12 @@ void codetag_load_module(struct module *mod)
>         mutex_unlock(&codetag_lock);
>  }
>
> -bool codetag_unload_module(struct module *mod)
> +void codetag_unload_module(struct module *mod)
>  {
>         struct codetag_type *cttype;
> -       bool unload_ok =3D true;
>
>         if (!mod)
> -               return true;
> +               return;
>
>         /* await any module's kfree_rcu() operations to complete */
>         kvfree_rcu_barrier();
> @@ -246,18 +333,17 @@ bool codetag_unload_module(struct module *mod)
>                 }
>                 if (found) {
>                         if (cttype->desc.module_unload)
> -                               if (!cttype->desc.module_unload(cttype, c=
mod))
> -                                       unload_ok =3D false;
> +                               cttype->desc.module_unload(cttype, cmod);
>
>                         cttype->count -=3D range_size(cttype, &cmod->rang=
e);
>                         idr_remove(&cttype->mod_idr, mod_id);
>                         kfree(cmod);
>                 }
>                 up_write(&cttype->mod_lock);
> +               if (found && cttype->desc.free_section_mem)
> +                       cttype->desc.free_section_mem(mod, true);
>         }
>         mutex_unlock(&codetag_lock);
> -
> -       return unload_ok;
>  }
>  #endif /* CONFIG_MODULES */
>
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 3f43edef813c..711c6e029936 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -50,7 +50,7 @@ SECTIONS {
>         .data : {
>                 *(.data .data.[0-9a-zA-Z_]*)
>                 *(.data..L*)
> -               CODETAG_SECTIONS()
> +               MOD_CODETAG_SECTIONS()
>         }
>
>         .rodata : {
> @@ -59,9 +59,10 @@ SECTIONS {
>         }
>  #else
>         .data : {
> -               CODETAG_SECTIONS()
> +               MOD_CODETAG_SECTIONS()
>         }
>  #endif
> +       MOD_SEPARATE_CODETAG_SECTIONS()
>  }
>
>  /* bring in arch-specific sections */
> --
> 2.47.0.105.g07ac214952-goog
>

