Return-Path: <linux-arch+bounces-6394-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2565958E1F
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 20:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094BF1F230DC
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 18:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF314AD38;
	Tue, 20 Aug 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNPb+Gz5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3749622
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178931; cv=none; b=DU5u9E6gaOAV5GQbhqiD33pu0Pg2NnA8AAe3NyMBFdEynsKTyrW1M6e/8+eep7WwQD6BTFhfV1KESOy5rkCmwelIKOW+c8ti4MtWfF66JDuPOAHutN2xvVNapHFURdyfk6JRtMQTxgXoYhID1K1JnHIgpttCEtI0N0O8XICPo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178931; c=relaxed/simple;
	bh=pUPiM6E5ayNu2eKmNm2KYHpQU1eBR12oj8X4LuPui9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=n6NEc3nYwuNuayygjDRwTSqy2IXtBZJUjpYenVZMJlYGtFBLqMBE4ilZTJ8RMlKlt2Q0h5608kVlUhpryDYxz3gjBNUWMtjlvRX/rIgigQvtZwZTZI8RZEdNo8zW9NUb0x7XSTQxDFRxjydW8J0USbDWwFPpmtARxcVp99j1mJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aNPb+Gz5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-202018541afso26745ad.1
        for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724178928; x=1724783728; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDWLb4Mp3Nrwpcq0CepzFbIK/oUEvmoe84VoZsvLjGE=;
        b=aNPb+Gz5wrCklMvB67sAW2uJjJPHrFqd1ZNJq9UH+encK8atvv0tB5Fai5ktT3MFsz
         eb/VMbu7aUWsG1Cka3X8ESwPG1vchtX76NzXhFoToFE3O9dfvt03wod8YejiTmaRKwRy
         tchxx0ODAYGMwEm7SjeZ1xs2gsPBJLr0boDFuiPd3mwpADevC0MAPiEz/3TFIq7Z3smh
         OgPAqVZdKV0a/abeZ9BpFnDaf4srPrdfDvrpB56FxJb99PfUfwTfKSn1HPePV6LWf9TX
         pos/TkUbPmRgYl59fYduBDZqFv/UyW5msXEaRv7FyK2/mY87kL4JrHbV3EH5XowneWLq
         DS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724178928; x=1724783728;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDWLb4Mp3Nrwpcq0CepzFbIK/oUEvmoe84VoZsvLjGE=;
        b=AEZb8dqbP7EOPBSGgsAnIWepY7GKLTTc1NW6dtutJoU8xMZ5NpCL9BgsllrmWlBugj
         QJkDzaroH9HuujI8r9Pbw9Wms0s+hFXzryVeMILAF8RjygMHfC3UZ8xklfam4fQhrZMB
         NUCW+vfco39+9ySO6FNhQSGqvGvRSX6eyDaJ5jXfJVQg5db9lv5dW0eOyFI8TyqDnN1E
         FBji9nh12WfD/F4u+ucHpJaLoGujHPIFTixv6MvZYhWAnMhNK9zVpeSdpdxV1ZuuYhgA
         ZmCylS1QONlyxnNcIflsH8fifUnq0jTiUKD4InDAHOaQWvnnw3BPTwzRRK0LbnUM4z/q
         EEQw==
X-Forwarded-Encrypted: i=1; AJvYcCUorT3BFYyZtw+9O+0W/eb8vxpKDWQPA7k3BAiTZjS2wdTFgPDeRmd3IqJPkvK5p7aHiQAS89Ej8WJl@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCTjdJ0l3zjVz9L59EN4u8DLwcuVCG4vOMRTsQZUXQyQpRYVc
	oY/63D8LBroQZ8ja+AgisW752X7XNUqlx/MpXeU8A8LbwJhPX4SpZnnBUbuZ7pZ55PxCFkO/C3v
	7aRi4Dr1SjtwYT0HToDWEALIHcEOTtBq4ei2w
X-Google-Smtp-Source: AGHT+IHl3+f/aJurxITdhrVUSpulcl9Dnz3PXDYhibZcY5q8wXMV1m/CVenSzT4eFMhR+bi8kB5z1oUt+hQIwvDZUjE=
X-Received: by 2002:a17:902:d2d1:b0:1ff:44be:b9e6 with SMTP id
 d9443c01a7336-202af9f3a6cmr2760535ad.0.1724178927064; Tue, 20 Aug 2024
 11:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819151512.2363698-1-surenb@google.com> <20240819151512.2363698-2-surenb@google.com>
 <vixjfxqv7mat22rlaco4eyple465hada32ymis73aqiozcszte@claj6dxkgv5k>
In-Reply-To: <vixjfxqv7mat22rlaco4eyple465hada32ymis73aqiozcszte@claj6dxkgv5k>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 20 Aug 2024 11:35:15 -0700
Message-ID: <CAJuCfpGmgTuKZTSuC85aLBF7Y1pS=D0j9rV7e+VmFWkVpV_HCA@mail.gmail.com>
Subject: Re: [PATCH 1/5] alloc_tag: load module tags into separate continuous memory
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:31=E2=80=AFAM 'Liam R. Howlett' via kernel-team
<kernel-team@android.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [240819 11:15]:
> > When a module gets unloaded there is a possibility that some of the
> > allocations it made are still used and therefore the allocation tags
> > corresponding to these allocations are still referenced. As such, the
> > memory for these tags can't be freed. This is currently handled as an
> > abnormal situation and module's data section is not being unloaded.
> > To handle this situation without keeping module's data in memory,
> > allow codetags with longer lifespan than the module to be loaded into
> > their own separate memory. The in-use memory areas and gaps after
> > module unloading in this separate memory are tracked using maple trees.
> > Allocation tags arrange their separate memory so that it is virtually
> > contiguous and that will allow simple allocation tag indexing later on
> > in this patchset. The size of this virtually contiguous memory is set
> > to store up to 100000 allocation tags and max_module_alloc_tags kernel
> > parameter is introduced to change this size.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   4 +
> >  include/asm-generic/codetag.lds.h             |  19 ++
> >  include/linux/alloc_tag.h                     |  13 +-
> >  include/linux/codetag.h                       |  35 ++-
> >  kernel/module/main.c                          |  67 +++--
> >  lib/alloc_tag.c                               | 245 ++++++++++++++++--
> >  lib/codetag.c                                 | 101 +++++++-
> >  scripts/module.lds.S                          |   5 +-
> >  8 files changed, 429 insertions(+), 60 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index d0d141d50638..17f9f811a9c0 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3205,6 +3205,10 @@
> >                       devices can be requested on-demand with the
> >                       /dev/loop-control interface.
> >
> > +
> > +     max_module_alloc_tags=3D  [KNL] Max supported number of allocatio=
n tags
> > +                     in modules.
> > +
> >       mce             [X86-32] Machine Check Exception
> >
> >       mce=3Doption      [X86-64] See Documentation/arch/x86/x86_64/boot=
-options.rst
> > diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/co=
detag.lds.h
> > index 64f536b80380..372c320c5043 100644
> > --- a/include/asm-generic/codetag.lds.h
> > +++ b/include/asm-generic/codetag.lds.h
> > @@ -11,4 +11,23 @@
> >  #define CODETAG_SECTIONS()           \
> >       SECTION_WITH_BOUNDARIES(alloc_tags)
> >
> > +/*
> > + * Module codetags which aren't used after module unload, therefore ha=
ve the
> > + * same lifespan as the module and can be safely unloaded with the mod=
ule.
> > + */
> > +#define MOD_CODETAG_SECTIONS()
> > +
> > +#define MOD_SEPARATE_CODETAG_SECTION(_name)  \
> > +     .codetag.##_name : {                    \
> > +             SECTION_WITH_BOUNDARIES(_name)  \
> > +     }
> > +
> > +/*
> > + * For codetags which might be used after module unload, therefore mig=
ht stay
> > + * longer in memory. Each such codetag type has its own section so tha=
t we can
> > + * unload them individually once unused.
> > + */
> > +#define MOD_SEPARATE_CODETAG_SECTIONS()              \
> > +     MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
> > +
> >  #endif /* __ASM_GENERIC_CODETAG_LDS_H */
> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > index 8c61ccd161ba..99cbc7f086ad 100644
> > --- a/include/linux/alloc_tag.h
> > +++ b/include/linux/alloc_tag.h
> > @@ -30,6 +30,13 @@ struct alloc_tag {
> >       struct alloc_tag_counters __percpu      *counters;
> >  } __aligned(8);
> >
> > +struct alloc_tag_module_section {
> > +     unsigned long start_addr;
> > +     unsigned long end_addr;
> > +     /* used size */
> > +     unsigned long size;
> > +};
> > +
> >  #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> >
> >  #define CODETAG_EMPTY        ((void *)1)
> > @@ -54,6 +61,8 @@ static inline void set_codetag_empty(union codetag_re=
f *ref) {}
> >
> >  #ifdef CONFIG_MEM_ALLOC_PROFILING
> >
> > +#define ALLOC_TAG_SECTION_NAME       "alloc_tags"
> > +
> >  struct codetag_bytes {
> >       struct codetag *ct;
> >       s64 bytes;
> > @@ -76,7 +85,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_al=
loc_tag);
> >
> >  #define DEFINE_ALLOC_TAG(_alloc_tag)                                  =
       \
> >       static struct alloc_tag _alloc_tag __used __aligned(8)           =
       \
> > -     __section("alloc_tags") =3D {                                    =
         \
> > +     __section(ALLOC_TAG_SECTION_NAME) =3D {                          =
         \
> >               .ct =3D CODE_TAG_INIT,                                   =
         \
> >               .counters =3D &_shared_alloc_tag };
> >
> > @@ -85,7 +94,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_al=
loc_tag);
> >  #define DEFINE_ALLOC_TAG(_alloc_tag)                                  =
       \
> >       static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr)=
;      \
> >       static struct alloc_tag _alloc_tag __used __aligned(8)           =
       \
> > -     __section("alloc_tags") =3D {                                    =
         \
> > +     __section(ALLOC_TAG_SECTION_NAME) =3D {                          =
         \
> >               .ct =3D CODE_TAG_INIT,                                   =
         \
> >               .counters =3D &_alloc_tag_cntr };
> >
> > diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> > index c2a579ccd455..c4a3dd60205e 100644
> > --- a/include/linux/codetag.h
> > +++ b/include/linux/codetag.h
> > @@ -35,8 +35,13 @@ struct codetag_type_desc {
> >       size_t tag_size;
> >       void (*module_load)(struct codetag_type *cttype,
> >                           struct codetag_module *cmod);
> > -     bool (*module_unload)(struct codetag_type *cttype,
> > +     void (*module_unload)(struct codetag_type *cttype,
> >                             struct codetag_module *cmod);
> > +     void (*module_replaced)(struct module *mod, struct module *new_mo=
d);
> > +     bool (*needs_section_mem)(struct module *mod, unsigned long size)=
;
> > +     void *(*alloc_section_mem)(struct module *mod, unsigned long size=
,
> > +                                unsigned int prepend, unsigned long al=
ign);
> > +     void (*free_section_mem)(struct module *mod, bool unused);
> >  };
> >
> >  struct codetag_iterator {
> > @@ -71,11 +76,31 @@ struct codetag_type *
> >  codetag_register_type(const struct codetag_type_desc *desc);
> >
> >  #if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
> > +
> > +bool codetag_needs_module_section(struct module *mod, const char *name=
,
> > +                               unsigned long size);
> > +void *codetag_alloc_module_section(struct module *mod, const char *nam=
e,
> > +                                unsigned long size, unsigned int prepe=
nd,
> > +                                unsigned long align);
> > +void codetag_free_module_sections(struct module *mod);
> > +void codetag_module_replaced(struct module *mod, struct module *new_mo=
d);
> >  void codetag_load_module(struct module *mod);
> > -bool codetag_unload_module(struct module *mod);
> > -#else
> > +void codetag_unload_module(struct module *mod);
> > +
> > +#else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> > +
> > +static inline bool
> > +codetag_needs_module_section(struct module *mod, const char *name,
> > +                          unsigned long size) { return false; }
> > +static inline void *
> > +codetag_alloc_module_section(struct module *mod, const char *name,
> > +                          unsigned long size, unsigned int prepend,
> > +                          unsigned long align) { return NULL; }
> > +static inline void codetag_free_module_sections(struct module *mod) {}
> > +static inline void codetag_module_replaced(struct module *mod, struct =
module *new_mod) {}
> >  static inline void codetag_load_module(struct module *mod) {}
> > -static inline bool codetag_unload_module(struct module *mod) { return =
true; }
> > -#endif
> > +static inline void codetag_unload_module(struct module *mod) {}
> > +
> > +#endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> >
> >  #endif /* _LINUX_CODETAG_H */
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 71396e297499..d195d788835c 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -1225,18 +1225,12 @@ static int module_memory_alloc(struct module *m=
od, enum mod_mem_type type)
> >       return 0;
> >  }
> >
> > -static void module_memory_free(struct module *mod, enum mod_mem_type t=
ype,
> > -                            bool unload_codetags)
> > +static void module_memory_free(struct module *mod, enum mod_mem_type t=
ype)
> >  {
> > -     void *ptr =3D mod->mem[type].base;
> > -
> > -     if (!unload_codetags && mod_mem_type_is_core_data(type))
> > -             return;
> > -
> > -     execmem_free(ptr);
> > +     execmem_free(mod->mem[type].base);
> >  }
> >
> > -static void free_mod_mem(struct module *mod, bool unload_codetags)
> > +static void free_mod_mem(struct module *mod)
> >  {
> >       for_each_mod_mem_type(type) {
> >               struct module_memory *mod_mem =3D &mod->mem[type];
> > @@ -1247,25 +1241,20 @@ static void free_mod_mem(struct module *mod, bo=
ol unload_codetags)
> >               /* Free lock-classes; relies on the preceding sync_rcu().=
 */
> >               lockdep_free_key_range(mod_mem->base, mod_mem->size);
> >               if (mod_mem->size)
> > -                     module_memory_free(mod, type, unload_codetags);
> > +                     module_memory_free(mod, type);
> >       }
> >
> >       /* MOD_DATA hosts mod, so free it at last */
> >       lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA=
].size);
> > -     module_memory_free(mod, MOD_DATA, unload_codetags);
> > +     module_memory_free(mod, MOD_DATA);
> >  }
> >
> >  /* Free a module, remove from lists, etc. */
> >  static void free_module(struct module *mod)
> >  {
> > -     bool unload_codetags;
> > -
> >       trace_module_free(mod);
> >
> > -     unload_codetags =3D codetag_unload_module(mod);
> > -     if (!unload_codetags)
> > -             pr_warn("%s: memory allocation(s) from the module still a=
live, cannot unload cleanly\n",
> > -                     mod->name);
> > +     codetag_unload_module(mod);
> >
> >       mod_sysfs_teardown(mod);
> >
> > @@ -1308,7 +1297,7 @@ static void free_module(struct module *mod)
> >       kfree(mod->args);
> >       percpu_modfree(mod);
> >
> > -     free_mod_mem(mod, unload_codetags);
> > +     free_mod_mem(mod);
> >  }
> >
> >  void *__symbol_get(const char *symbol)
> > @@ -1573,6 +1562,14 @@ static void __layout_sections(struct module *mod=
, struct load_info *info, bool i
> >                       if (WARN_ON_ONCE(type =3D=3D MOD_INVALID))
> >                               continue;
> >
> > +                     /*
> > +                      * Do not allocate codetag memory as we load it i=
nto
> > +                      * preallocated contiguous memory. s->sh_entsize =
will
> > +                      * not be used for this section, so leave it as i=
s.
> > +                      */
> > +                     if (codetag_needs_module_section(mod, sname, s->s=
h_size))
> > +                             continue;
> > +
> >                       s->sh_entsize =3D module_get_offset_and_type(mod,=
 type, s, i);
> >                       pr_debug("\t%s\n", sname);
> >               }
> > @@ -2247,6 +2244,7 @@ static int move_module(struct module *mod, struct=
 load_info *info)
> >       int i;
> >       enum mod_mem_type t =3D 0;
> >       int ret =3D -ENOMEM;
> > +     bool codetag_section_found =3D false;
> >
> >       for_each_mod_mem_type(type) {
> >               if (!mod->mem[type].size) {
> > @@ -2257,7 +2255,7 @@ static int move_module(struct module *mod, struct=
 load_info *info)
> >               ret =3D module_memory_alloc(mod, type);
> >               if (ret) {
> >                       t =3D type;
> > -                     goto out_enomem;
> > +                     goto out_err;
> >               }
> >       }
> >
> > @@ -2267,11 +2265,27 @@ static int move_module(struct module *mod, stru=
ct load_info *info)
> >               void *dest;
> >               Elf_Shdr *shdr =3D &info->sechdrs[i];
> >               enum mod_mem_type type =3D shdr->sh_entsize >> SH_ENTSIZE=
_TYPE_SHIFT;
> > +             const char *sname;
> >
> >               if (!(shdr->sh_flags & SHF_ALLOC))
> >                       continue;
> >
> > -             dest =3D mod->mem[type].base + (shdr->sh_entsize & SH_ENT=
SIZE_OFFSET_MASK);
> > +             sname =3D info->secstrings + shdr->sh_name;
> > +             /*
> > +              * Load codetag sections separately as they might still b=
e used
> > +              * after module unload.
> > +              */
> > +             if (codetag_needs_module_section(mod, sname, shdr->sh_siz=
e)) {
> > +                     dest =3D codetag_alloc_module_section(mod, sname,=
 shdr->sh_size,
> > +                                     arch_mod_section_prepend(mod, i),=
 shdr->sh_addralign);
> > +                     if (IS_ERR(dest)) {
> > +                             ret =3D PTR_ERR(dest);
> > +                             goto out_err;
> > +                     }
> > +                     codetag_section_found =3D true;
> > +             } else {
> > +                     dest =3D mod->mem[type].base + (shdr->sh_entsize =
& SH_ENTSIZE_OFFSET_MASK);
> > +             }
> >
> >               if (shdr->sh_type !=3D SHT_NOBITS) {
> >                       /*
> > @@ -2283,7 +2297,7 @@ static int move_module(struct module *mod, struct=
 load_info *info)
> >                       if (i =3D=3D info->index.mod &&
> >                          (WARN_ON_ONCE(shdr->sh_size !=3D sizeof(struct=
 module)))) {
> >                               ret =3D -ENOEXEC;
> > -                             goto out_enomem;
> > +                             goto out_err;
> >                       }
> >                       memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size=
);
> >               }
> > @@ -2299,9 +2313,12 @@ static int move_module(struct module *mod, struc=
t load_info *info)
> >       }
> >
> >       return 0;
> > -out_enomem:
> > +out_err:
> >       for (t--; t >=3D 0; t--)
> > -             module_memory_free(mod, t, true);
> > +             module_memory_free(mod, t);
> > +     if (codetag_section_found)
> > +             codetag_free_module_sections(mod);
> > +
> >       return ret;
> >  }
> >
> > @@ -2422,6 +2439,8 @@ static struct module *layout_and_allocate(struct =
load_info *info, int flags)
> >       /* Module has been copied to its final place now: return it. */
> >       mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
> >       kmemleak_load_module(mod, info);
> > +     codetag_module_replaced(info->mod, mod);
> > +
> >       return mod;
> >  }
> >
> > @@ -2431,7 +2450,7 @@ static void module_deallocate(struct module *mod,=
 struct load_info *info)
> >       percpu_modfree(mod);
> >       module_arch_freeing_init(mod);
> >
> > -     free_mod_mem(mod, true);
> > +     free_mod_mem(mod);
> >  }
> >
> >  int __weak module_finalize(const Elf_Ehdr *hdr,
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index 81e5f9a70f22..f33784f48dd2 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  #include <linux/alloc_tag.h>
> > +#include <linux/execmem.h>
> >  #include <linux/fs.h>
> >  #include <linux/gfp.h>
> >  #include <linux/module.h>
> > @@ -9,6 +10,12 @@
> >  #include <linux/seq_file.h>
> >
> >  static struct codetag_type *alloc_tag_cttype;
> > +static struct alloc_tag_module_section module_tags;
> > +static struct maple_tree mod_area_mt =3D MTREE_INIT(mod_area_mt, MT_FL=
AGS_ALLOC_RANGE);
> > +/* A dummy object used to indicate an unloaded module */
> > +static struct module unloaded_mod;
> > +/* A dummy object used to indicate a module prepended area */
> > +static struct module prepend_mod;
> >
> >  DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
> >  EXPORT_SYMBOL(_shared_alloc_tag);
> > @@ -149,29 +156,198 @@ static void __init procfs_init(void)
> >       proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
> >  }
> >
> > -static bool alloc_tag_module_unload(struct codetag_type *cttype,
> > -                                 struct codetag_module *cmod)
> > +static bool needs_section_mem(struct module *mod, unsigned long size)
> >  {
> > -     struct codetag_iterator iter =3D codetag_get_ct_iter(cttype);
> > -     struct alloc_tag_counters counter;
> > -     bool module_unused =3D true;
> > -     struct alloc_tag *tag;
> > -     struct codetag *ct;
> > +     return size >=3D sizeof(struct alloc_tag);
> > +}
> > +
> > +/* Called under RCU read lock */
> > +static void clean_unused_module_areas(void)
> > +{
> > +     MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> > +     struct module *val;
> > +
> > +     mas_for_each(&mas, val, module_tags.size) {
> > +             if (val =3D=3D &unloaded_mod) {
> > +                     struct alloc_tag *tag;
> > +                     struct alloc_tag *last;
> > +                     bool unused =3D true;
> > +
> > +                     tag =3D (struct alloc_tag *)(module_tags.start_ad=
dr + mas.index);
> > +                     last =3D (struct alloc_tag *)(module_tags.start_a=
ddr + mas.last);
> > +                     while (tag <=3D last) {
> > +                             struct alloc_tag_counters counter;
> > +
> > +                             counter =3D alloc_tag_read(tag);
> > +                             if (counter.bytes) {
> > +                                     unused =3D false;
> > +                                     break;
> > +                             }
> > +                             tag++;
> > +                     }
> > +                     if (unused) {
> > +                             mtree_store_range(&mod_area_mt, mas.index=
,
> > +                                               mas.last, NULL, GFP_KER=
NEL);
>
> There is an mtree_erase() or mas_erase() function as well, no problem
> doing it this way.

Yeah, mtree_erase() seems more clear. I'll use that.

>
> > +                     }
> > +             }
> > +     }
> > +}
> > +
> > +static void *reserve_module_tags(struct module *mod, unsigned long siz=
e,
> > +                              unsigned int prepend, unsigned long alig=
n)
> > +{
> > +     unsigned long section_size =3D module_tags.end_addr - module_tags=
.start_addr;
> > +     MA_STATE(mas, &mod_area_mt, 0, section_size - 1);
> > +     bool cleanup_done =3D false;
> > +     unsigned long offset;
> > +     void *ret;
> > +
> > +     /* If no tags return NULL */
> > +     if (size < sizeof(struct alloc_tag))
> > +             return NULL;
> > +
> > +     /*
> > +      * align is always power of 2, so we can use IS_ALIGNED and ALIGN=
.
> > +      * align 0 or 1 means no alignment, to simplify set to 1.
> > +      */
> > +     if (!align)
> > +             align =3D 1;
> > +
> > +     rcu_read_lock();
> > +repeat:
> > +     /* Try finding exact size and hope the start is aligned */
> > +     if (mas_empty_area(&mas, 0, section_size - 1, prepend + size))
> > +             goto cleanup;
> > +
> > +     if (IS_ALIGNED(mas.index + prepend, align))
> > +             goto found;
> > +
> > +     /* Try finding larger area to align later */
> > +     mas_reset(&mas);
> > +     if (!mas_empty_area(&mas, 0, section_size - 1,
> > +                         size + prepend + align - 1))
> > +             goto found;
> > +
> > +cleanup:
> > +     /* No free area, try cleanup stale data and repeat the search onc=
e */
> > +     if (!cleanup_done) {
> > +             clean_unused_module_areas();
> > +             cleanup_done =3D true;
> > +             mas_reset(&mas);
> > +             goto repeat;
> > +     } else {
> > +             ret =3D ERR_PTR(-ENOMEM);
> > +             goto out;
> > +     }
> > +
> > +found:
> > +     offset =3D mas.index;
> > +     offset +=3D prepend;
> > +     offset =3D ALIGN(offset, align);
> > +
> > +     if (mtree_insert_range(&mod_area_mt, offset, offset + size - 1, m=
od,
> > +                            GFP_KERNEL)) {
> > +             ret =3D ERR_PTR(-ENOMEM);
> > +             goto out;
> > +     }
> > +
> > +     if (offset !=3D mas.index) {
> > +             if (mtree_insert_range(&mod_area_mt, mas.index, offset - =
1,
> > +                                    &prepend_mod, GFP_KERNEL)) {
> > +                     mtree_store_range(&mod_area_mt, offset, offset + =
size - 1,
> > +                                       NULL, GFP_KERNEL);
>
> Aren't you negating the security of knowing you haven't raced to store
> in the same location as another reader if you use mtree_store_range()
> on the failure of mtree_insert_range()?

All functions using mod_area_mt are synchronized using
cttype->mod_lock (see codetag_alloc_module_section() for an example),
so we should not be racing.

>
> > +                     ret =3D ERR_PTR(-ENOMEM);
> > +                     goto out;
> > +             }
> > +     }
>
> mtree_insert and mtree_store do the locking for you, but will re-walk
> the tree to the location for the store.  If you use the advanced mas_
> operations, you can store without a re-walk but need to take the
> spinlock and check mas_is_err(&mas) yourself.
>
> mas.last =3D  offset - 1;
> mas_lock(&mas)
> mas_insert(&mas, prepend_mod)
> mas_unlock(&mas);
> if (mas_is_err(&mas))
>         ret =3D xa_err(mas->node);
>
> What you have works though.

Thanks for the tip. I'll try using this advanced API.

>
>
> > +
> > +     if (module_tags.size < offset + size)
> > +             module_tags.size =3D offset + size;
> > +
> > +     ret =3D (struct alloc_tag *)(module_tags.start_addr + offset);
> > +out:
> > +     rcu_read_unlock();
> > +
> > +     return ret;
> > +}
> > +
> > +static void release_module_tags(struct module *mod, bool unused)
> > +{
> > +     MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> > +     unsigned long padding_start;
> > +     bool padding_found =3D false;
> > +     struct module *val;
> > +
> > +     if (unused)
> > +             return;
> > +
> > +     unused =3D true;
> > +     rcu_read_lock();
> > +     mas_for_each(&mas, val, module_tags.size) {
> > +             struct alloc_tag *tag;
> > +             struct alloc_tag *last;
> > +
> > +             if (val =3D=3D &prepend_mod) {
> > +                     padding_start =3D mas.index;
> > +                     padding_found =3D true;
> > +                     continue;
> > +             }
> >
> > -     for (ct =3D codetag_next_ct(&iter); ct; ct =3D codetag_next_ct(&i=
ter)) {
> > -             if (iter.cmod !=3D cmod)
> > +             if (val !=3D mod) {
> > +                     padding_found =3D false;
> >                       continue;
> > +             }
> > +
> > +             tag =3D (struct alloc_tag *)(module_tags.start_addr + mas=
.index);
> > +             last =3D (struct alloc_tag *)(module_tags.start_addr + ma=
s.last);
> > +             while (tag <=3D last) {
> > +                     struct alloc_tag_counters counter;
> > +
> > +                     counter =3D alloc_tag_read(tag);
> > +                     if (counter.bytes) {
> > +                             struct codetag *ct =3D &tag->ct;
> >
> > -             tag =3D ct_to_alloc_tag(ct);
> > -             counter =3D alloc_tag_read(tag);
> > +                             pr_info("%s:%u module %s func:%s has %llu=
 allocated at module unload\n",
> > +                                     ct->filename, ct->lineno, ct->mod=
name,
> > +                                     ct->function, counter.bytes);
> > +                             unused =3D false;
> > +                             break;
> > +                     }
> > +                     tag++;
> > +             }
> > +             if (unused) {
> > +                     mtree_store_range(&mod_area_mt,
> > +                                       padding_found ? padding_start :=
 mas.index,
> > +                                       mas.last, NULL, GFP_KERNEL);
> > +             } else {
> > +                     /* Release the padding and mark the module unload=
ed */
> > +                     if (padding_found)
> > +                             mtree_store_range(&mod_area_mt, padding_s=
tart,
> > +                                               mas.index - 1, NULL, GF=
P_KERNEL);
> > +                     mtree_store_range(&mod_area_mt, mas.index, mas.la=
st,
> > +                                       &unloaded_mod, GFP_KERNEL);
> > +             }
> >
> > -             if (WARN(counter.bytes,
> > -                      "%s:%u module %s func:%s has %llu allocated at m=
odule unload",
> > -                      ct->filename, ct->lineno, ct->modname, ct->funct=
ion, counter.bytes))
> > -                     module_unused =3D false;
> > +             break;
> >       }
> > +     rcu_read_unlock();
>
> You may want to use a reverse iterator here, I don't think we have had a
> use for one yet..
>
> #define mas_for_each_rev(__mas, __entry, __min) \
>         while (((__entry) =3D mas_find_rev((__mas), (__min))) !=3D NULL)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
>
> ...
>
> rcu_read_lock();
> mas_for_each_rev(&mas, val, 0)
>         if (val =3D=3D mod)
>                 break;
>
> if (!val) /* no module found */
>         goto out;
>
> ..unused check loop here..
>
> mas_lock(&mas) /* spinlock */
> mas_store(&mas, unused ? NULL : &unloaded_mod);
> val =3D mas_prev_range(&mas, 0);
> if (val =3D=3D &prepend_mod)
>         mas_store(&mas, NULL);
> mas_unlock(&mas);
>
> out:
> rcu_read_unlock();
>

I see. Ok, that should simplify this loop. I'll try that out.

>
> > +}
> > +
> > +static void replace_module(struct module *mod, struct module *new_mod)
> > +{
> > +     MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> > +     struct module *val;
> >
> > -     return module_unused;
> > +     rcu_read_lock();
> > +     mas_for_each(&mas, val, module_tags.size) {
> > +             if (val !=3D mod)
> > +                     continue;
> > +
> > +             mtree_store_range(&mod_area_mt, mas.index, mas.last,
> > +                               new_mod, GFP_KERNEL);
> > +             break;
> > +     }
> > +     rcu_read_unlock();
> >  }
> >
> >  #ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> > @@ -252,17 +428,46 @@ static void __init sysctl_init(void)
> >  static inline void sysctl_init(void) {}
> >  #endif /* CONFIG_SYSCTL */
> >
> > +static unsigned long max_module_alloc_tags __initdata =3D 100000;
> > +
> > +static int __init set_max_module_alloc_tags(char *arg)
> > +{
> > +     if (!arg)
> > +             return -EINVAL;
> > +
> > +     return kstrtoul(arg, 0, &max_module_alloc_tags);
> > +}
> > +early_param("max_module_alloc_tags", set_max_module_alloc_tags);
> > +
> >  static int __init alloc_tag_init(void)
> >  {
> >       const struct codetag_type_desc desc =3D {
> > -             .section        =3D "alloc_tags",
> > -             .tag_size       =3D sizeof(struct alloc_tag),
> > -             .module_unload  =3D alloc_tag_module_unload,
> > +             .section                =3D ALLOC_TAG_SECTION_NAME,
> > +             .tag_size               =3D sizeof(struct alloc_tag),
> > +             .needs_section_mem      =3D needs_section_mem,
> > +             .alloc_section_mem      =3D reserve_module_tags,
> > +             .free_section_mem       =3D release_module_tags,
> > +             .module_replaced        =3D replace_module,
> >       };
> > +     unsigned long module_tags_mem_sz;
> >
> > +     module_tags_mem_sz =3D max_module_alloc_tags * sizeof(struct allo=
c_tag);
> > +     pr_info("%lu bytes reserved for module allocation tags\n", module=
_tags_mem_sz);
> > +
> > +     /* Allocate space to copy allocation tags */
> > +     module_tags.start_addr =3D (unsigned long)execmem_alloc(EXECMEM_M=
ODULE_DATA,
> > +                                                           module_tags=
_mem_sz);
> > +     if (!module_tags.start_addr)
> > +             return -ENOMEM;
> > +
> > +     module_tags.end_addr =3D module_tags.start_addr + module_tags_mem=
_sz;
> > +     mt_set_in_rcu(&mod_area_mt);
>
> If you are not toggling rcu-safe, then you can use the init of the tree
> to set rcu on by setting MT_FLAGS_USE_RCU.

Ack.

Thanks for the feedback, Liam!

>
> >       alloc_tag_cttype =3D codetag_register_type(&desc);
> > -     if (IS_ERR(alloc_tag_cttype))
> > +     if (IS_ERR(alloc_tag_cttype)) {
> > +             execmem_free((void *)module_tags.start_addr);
> > +             module_tags.start_addr =3D 0;
> >               return PTR_ERR(alloc_tag_cttype);
> > +     }
> >
> >       sysctl_init();
> >       procfs_init();
> > diff --git a/lib/codetag.c b/lib/codetag.c
> > index 5ace625f2328..d602a81bdc03 100644
> > --- a/lib/codetag.c
> > +++ b/lib/codetag.c
> > @@ -126,6 +126,7 @@ static inline size_t range_size(const struct codeta=
g_type *cttype,
> >  }
> >
> >  #ifdef CONFIG_MODULES
> > +
> >  static void *get_symbol(struct module *mod, const char *prefix, const =
char *name)
> >  {
> >       DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
> > @@ -155,6 +156,94 @@ static struct codetag_range get_section_range(stru=
ct module *mod,
> >       };
> >  }
> >
> > +#define CODETAG_SECTION_PREFIX       ".codetag."
> > +
> > +/* Some codetag types need a separate module section */
> > +bool codetag_needs_module_section(struct module *mod, const char *name=
,
> > +                               unsigned long size)
> > +{
> > +     const char *type_name;
> > +     struct codetag_type *cttype;
> > +     bool ret =3D false;
> > +
> > +     if (strncmp(name, CODETAG_SECTION_PREFIX, strlen(CODETAG_SECTION_=
PREFIX)))
> > +             return false;
> > +
> > +     type_name =3D name + strlen(CODETAG_SECTION_PREFIX);
> > +     mutex_lock(&codetag_lock);
> > +     list_for_each_entry(cttype, &codetag_types, link) {
> > +             if (strcmp(type_name, cttype->desc.section) =3D=3D 0) {
> > +                     if (!cttype->desc.needs_section_mem)
> > +                             break;
> > +
> > +                     down_write(&cttype->mod_lock);
> > +                     ret =3D cttype->desc.needs_section_mem(mod, size)=
;
> > +                     up_write(&cttype->mod_lock);
> > +                     break;
> > +             }
> > +     }
> > +     mutex_unlock(&codetag_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +void *codetag_alloc_module_section(struct module *mod, const char *nam=
e,
> > +                                unsigned long size, unsigned int prepe=
nd,
> > +                                unsigned long align)
> > +{
> > +     const char *type_name =3D name + strlen(CODETAG_SECTION_PREFIX);
> > +     struct codetag_type *cttype;
> > +     void *ret =3D NULL;
> > +
> > +     mutex_lock(&codetag_lock);
> > +     list_for_each_entry(cttype, &codetag_types, link) {
> > +             if (strcmp(type_name, cttype->desc.section) =3D=3D 0) {
> > +                     if (WARN_ON(!cttype->desc.alloc_section_mem))
> > +                             break;
> > +
> > +                     down_write(&cttype->mod_lock);
> > +                     ret =3D cttype->desc.alloc_section_mem(mod, size,=
 prepend, align);
> > +                     up_write(&cttype->mod_lock);
> > +                     break;
> > +             }
> > +     }
> > +     mutex_unlock(&codetag_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +void codetag_free_module_sections(struct module *mod)
> > +{
> > +     struct codetag_type *cttype;
> > +
> > +     mutex_lock(&codetag_lock);
> > +     list_for_each_entry(cttype, &codetag_types, link) {
> > +             if (!cttype->desc.free_section_mem)
> > +                     continue;
> > +
> > +             down_write(&cttype->mod_lock);
> > +             cttype->desc.free_section_mem(mod, true);
> > +             up_write(&cttype->mod_lock);
> > +     }
> > +     mutex_unlock(&codetag_lock);
> > +}
> > +
> > +void codetag_module_replaced(struct module *mod, struct module *new_mo=
d)
> > +{
> > +     struct codetag_type *cttype;
> > +
> > +     mutex_lock(&codetag_lock);
> > +     list_for_each_entry(cttype, &codetag_types, link) {
> > +             if (!cttype->desc.module_replaced)
> > +                     continue;
> > +
> > +             down_write(&cttype->mod_lock);
> > +             cttype->desc.module_replaced(mod, new_mod);
> > +             up_write(&cttype->mod_lock);
> > +     }
> > +     mutex_unlock(&codetag_lock);
> > +}
> > +
> >  static int codetag_module_init(struct codetag_type *cttype, struct mod=
ule *mod)
> >  {
> >       struct codetag_range range;
> > @@ -212,13 +301,12 @@ void codetag_load_module(struct module *mod)
> >       mutex_unlock(&codetag_lock);
> >  }
> >
> > -bool codetag_unload_module(struct module *mod)
> > +void codetag_unload_module(struct module *mod)
> >  {
> >       struct codetag_type *cttype;
> > -     bool unload_ok =3D true;
> >
> >       if (!mod)
> > -             return true;
> > +             return;
> >
> >       mutex_lock(&codetag_lock);
> >       list_for_each_entry(cttype, &codetag_types, link) {
> > @@ -235,18 +323,17 @@ bool codetag_unload_module(struct module *mod)
> >               }
> >               if (found) {
> >                       if (cttype->desc.module_unload)
> > -                             if (!cttype->desc.module_unload(cttype, c=
mod))
> > -                                     unload_ok =3D false;
> > +                             cttype->desc.module_unload(cttype, cmod);
> >
> >                       cttype->count -=3D range_size(cttype, &cmod->rang=
e);
> >                       idr_remove(&cttype->mod_idr, mod_id);
> >                       kfree(cmod);
> >               }
> >               up_write(&cttype->mod_lock);
> > +             if (found && cttype->desc.free_section_mem)
> > +                     cttype->desc.free_section_mem(mod, false);
> >       }
> >       mutex_unlock(&codetag_lock);
> > -
> > -     return unload_ok;
> >  }
> >
> >  #else /* CONFIG_MODULES */
> > diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> > index 3f43edef813c..711c6e029936 100644
> > --- a/scripts/module.lds.S
> > +++ b/scripts/module.lds.S
> > @@ -50,7 +50,7 @@ SECTIONS {
> >       .data : {
> >               *(.data .data.[0-9a-zA-Z_]*)
> >               *(.data..L*)
> > -             CODETAG_SECTIONS()
> > +             MOD_CODETAG_SECTIONS()
> >       }
> >
> >       .rodata : {
> > @@ -59,9 +59,10 @@ SECTIONS {
> >       }
> >  #else
> >       .data : {
> > -             CODETAG_SECTIONS()
> > +             MOD_CODETAG_SECTIONS()
> >       }
> >  #endif
> > +     MOD_SEPARATE_CODETAG_SECTIONS()
> >  }
> >
> >  /* bring in arch-specific sections */
> > --
> > 2.46.0.184.g6999bdac58-goog
> >
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

