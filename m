Return-Path: <linux-arch+bounces-6989-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C296ACF4
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CF31C243B2
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651761D798C;
	Tue,  3 Sep 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVs7gRMu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24F1D6DBE
	for <linux-arch@vger.kernel.org>; Tue,  3 Sep 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725406883; cv=none; b=h30ndYhIuSRrAC2tf9u5iSjyGKrkEkKmJsYX25HIqM+tZ6HMinDssLwun0j+djgsS4BlfHt0gO9MAlwciI3JRbf9RP5JMGLkSBqvg4os5bSRZEO6FiPo4ialJVtbDSE+qZUvYDRPltJgzbLMbeGuSH2gJAVuv8AXiW2yBZHzQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725406883; c=relaxed/simple;
	bh=5iIbSt1aCUfaT7ma92jE9I4MrBY9Tx59H37wbUkPkLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVuvAsrtFc5jIsDT9bgzHJdBuBsz/n3+eGWgwdUSRuKgVjdjxFFZoud6HHxVMz+pPuS3KNjciFFx6dZzhGt/czpECcV3L/fpy3j2Urx7p4kjbXPrU22O+7A6DoTvXCeI37hOZxTvvU1S9AZjG2p9NreuiPhMlwfNqdHA5A8IZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVs7gRMu; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so4348655276.3
        for <linux-arch@vger.kernel.org>; Tue, 03 Sep 2024 16:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725406880; x=1726011680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5M0Sum4xgHlTMU2fLROf8XBEuOZsxnLsFF2EblQMHc=;
        b=BVs7gRMu6QXpsp/trICFc6Sjuqb09w5JLyi8bYWgW63RtG0MQaoDqarHqpJPg6UHb3
         wGteZ+Dejq2tP9BGZQojQuyhiiHWPsb/w0C0F8TgTPkBZN1y5l7LKrsk772ZtBH3/NlI
         XA1ukqmb2k1gO1ZXjsTudSS9CMetMzzn98TCr1AeQkuRf4DABBmWm40hxovC8ivbO0Ho
         QXQHUQoSF0uHDMCg/prDsm0emwMxMgTvzv7hwhP+jDBmgerMWoLzqMVeg8u1mHOrwo9a
         NbKRt6Ndhxkk16sOIHnYz1h08g66MkdBtmO0UT8GD5zo24dVKqgv+CEC8iNbVK+qC97W
         /kQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725406880; x=1726011680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5M0Sum4xgHlTMU2fLROf8XBEuOZsxnLsFF2EblQMHc=;
        b=PagDH/fQJ9QwMJjZ9Xw2z4wZkYhzPuS0o9T37yaN0ufhYqEcls+H18L2IE3ip6JY8G
         J1Yea89RDpaie7BIo5dGXk0j9cQJ5A6hALoN4h5nxd0Z6zIS/A9ux6FVlssKWTmYgIJl
         lm1fx4cqYdZiSOtWUbFIWCZKBh5U9rSzrT6fjLF1cl1fTB57EklADXszU4iK06drEUXk
         6QtRlGKKGgoMHOS+yqM8GX3lCAglDP/IM97w2y2+F+0YrTjZg0Dnm8H8AgpBYrbqs70P
         4pQgZaIGQblVyI9ALcdWo95yeTvPSUSLctdOVRkdtqL4LlqITNdxr8E2xr82zjkGLl0l
         xUAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr0ZY9e7QEx7J9PzlDj0t/GgSPHcsHX8TBT9Ze9Zt8WnEjQNi04gHpHRgT9AV+GdOErP19lfdSh2Fp@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKTPeOIJ5wuh91MffF2uGnZ8+ilHTccvoyeIAb/xgzChsV6CM
	TpBMnva8g9TdSVaVor5929aDaqfnCLyzBWxjiWKvjyaRoAHd78CLFeJMP49PqnvaOodmWZWodmS
	MeZedYLobw+8FwzfNzs+KbBwN8ixO0DkWUDBm
X-Google-Smtp-Source: AGHT+IFWEFEBxEfnZLDRslHEZBai9WH4P0k103YAF6DmVxrdDw6kLMNpGPXrgYEEvE4DIx2uMMfkeh1c/yvpuejloeI=
X-Received: by 2002:a05:6902:1405:b0:e1a:7271:b3e6 with SMTP id
 3f1490d57ef6-e1a7a3d0fabmr17177041276.53.1725406879370; Tue, 03 Sep 2024
 16:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903232241.43995-1-anthony.yznaga@oracle.com> <20240903232241.43995-7-anthony.yznaga@oracle.com>
In-Reply-To: <20240903232241.43995-7-anthony.yznaga@oracle.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 3 Sep 2024 16:40:43 -0700
Message-ID: <CADrL8HV51t44EBKFwXoT-A48miq2TT7w1yjSUFo6uc5WDN=z9A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/10] mm/mshare: Add vm flag for shared PTEs
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:23=E2=80=AFPM Anthony Yznaga <anthony.yznaga@oracl=
e.com> wrote:
>
> From: Khalid Aziz <khalid@kernel.org>
>
> Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
> a function to determine if a vma shares PTEs by checking this flag.
> This is to be used to find the shared page table entries on page fault
> for vmas sharing PTEs.
>
> Signed-off-by: Khalid Aziz <khalid@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/linux/mm.h             | 7 +++++++
>  include/trace/events/mmflags.h | 3 +++
>  mm/internal.h                  | 5 +++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6549d0979b28..3aa0b3322284 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -413,6 +413,13 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_DROPPABLE           VM_NONE
>  #endif
>
> +#ifdef CONFIG_64BIT
> +#define VM_SHARED_PT_BIT       41
> +#define VM_SHARED_PT           BIT(VM_SHARED_PT_BIT)
> +#else
> +#define VM_SHARED_PT           VM_NONE
> +#endif
> +
>  #ifdef CONFIG_64BIT
>  /* VM is sealed, in vm_flags */
>  #define VM_SEALED      _BITUL(63)
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflag=
s.h
> index b63d211bd141..e1ae1e60d086 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -167,8 +167,10 @@ IF_HAVE_PG_ARCH_X(arch_3)
>
>  #ifdef CONFIG_64BIT
>  # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
> +# define IF_HAVE_VM_SHARED_PT(flag, name) {flag, name},
>  #else
>  # define IF_HAVE_VM_DROPPABLE(flag, name)
> +# define IF_HAVE_VM_SHARED_PT(flag, name)
>  #endif
>
>  #define __def_vmaflag_names                                            \
> @@ -204,6 +206,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,  "softdirty"     )=
               \
>         {VM_HUGEPAGE,                   "hugepage"      },              \
>         {VM_NOHUGEPAGE,                 "nohugepage"    },              \
>  IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,     "droppable"     )               \
> +IF_HAVE_VM_SHARED_PT(VM_SHARED_PT,     "sharedpt"      )               \
>         {VM_MERGEABLE,                  "mergeable"     }               \
>
>  #define show_vma_flags(flags)                                          \
> diff --git a/mm/internal.h b/mm/internal.h
> index b4d86436565b..8005d5956b6e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1578,4 +1578,9 @@ void unlink_file_vma_batch_init(struct unlink_vma_f=
ile_batch *);
>  void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm=
_area_struct *);
>  void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
>

Hi Anthony,

I'm really excited to see this series on the mailing list again! :) I
won't have time to review this series in too much detail, but I hope
something like it gets merged eventually.

> +static inline bool vma_is_shared(const struct vm_area_struct *vma)
> +{
> +       return VM_SHARED_PT && (vma->vm_flags & VM_SHARED_PT);
> +}

Tiny comment - I find vma_is_shared() to be a bit of a confusing name,
especially given how vma_is_shared_maywrite() is defined. (Sorry if
this has already been discussed before.)

How about vma_is_shared_pt()?

