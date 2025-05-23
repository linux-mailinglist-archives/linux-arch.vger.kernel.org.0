Return-Path: <linux-arch+bounces-12118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A9AC282A
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 19:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E1E543189
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C457A297B92;
	Fri, 23 May 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ+b75fH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F6297A45;
	Fri, 23 May 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020022; cv=none; b=qzU8M0iytMppo8++dDrQAnM9a2TJ46VyQLkqmuL9x6zLHU2a4d4ZrQ8dRm10MNs2ex6VIOOc42wMovVM+0miouI7f5TP7J2CqkpWUhHTd43G2RbVjBjxkrJW5kbbTJfnh19aUMMV4u0pxshpdZundd72kqnhX0wcYpFaX2HZsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020022; c=relaxed/simple;
	bh=ZqHKZ6mJKB+jnfNWj5/3OnOPNL1aPN9ZqTC2AbQ04RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WP6s3+wP+zLZQXMEAiyVAKpRBNF3bEyBjh8UAJzT3qq05+Od/DSEov5khh4IZtE7fGUP6Nth9DonxgZhyuoUN5juBSciELiAFwPoA8MnqHxSt1dCmBRdAXbqbub/nzwboHmZaulnnIyMUorw03mTqq3zETLMJgCMQSKlJDP4w8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ+b75fH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b271f3ae786so46154a12.3;
        Fri, 23 May 2025 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748020020; x=1748624820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTwe+31sgu40oVCV+aZlCbb9wmWAuQEyaX6cVFtKWRA=;
        b=IJ+b75fH5bpcmgXspM5zc+j1zx7RTT37FPQByh6NPJFb9LUN31tBa4YgfqvggCnJAd
         So1zdBUVPtHOgF8jJUWL1Bj3IhnS4c5Os8pcJAUVTNxVlOq9S7lx19lxRmcxQMTTRsVu
         /sj1UfuS+aQPtLlMOjxo+H3y7U8UT4feq91YBeGTKZJSEySX/KCnfw5h43Lnta+ib9px
         xnp07acJm4FNfMf7GtrXSPFpPRx27fEwahSRwyWSIBy3XYMStQGIT4dkzyr2s57LtJYn
         h5pWRxROGgw3i0SOzVFO3NWefkHaDMjUDA6bu+YLz1sDTyU/w/ULD6NCF9DgtUg84h/L
         wO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020020; x=1748624820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTwe+31sgu40oVCV+aZlCbb9wmWAuQEyaX6cVFtKWRA=;
        b=i8cXmEcuJZvVeTiFqHxm768jzQ7t+ZO1H+uPQvzVQV0xmY5mRpH5ceSW2o60gN5X5n
         W/bkg+tn7nybOGUqnG2O0TQT9An8dtc2VYxpYJecMlm7ri833fLpc1baH2UOvLBC3sBz
         fZZMtWxBBoSZa1M7qGn9XOVs0fkHJKWo3R4ld7jSBwOd8wTGIggzFJ+ENCjoMItDPscv
         YdOPK3quwJKofStrFybjkaWisguCc2C5+J8o9mJoZe1F0zacgAw6vbnQ+b4vNHTxsxcd
         WU41kQw9JOFVjo4Y0tAw7CH0xdwdkzwxxuHPjSa7WZ+/trkBvdl414JpMg+YoPjmAqgT
         cT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCULtsjLbUOoJ2zbmx6W+2yirOz4tQtRUHUwTEIg00i/PC5lasufJ967i41mM+8oYfu4Q3GU2hNIMekFRg==@vger.kernel.org, AJvYcCVjXQk1g1fJS58kizsHaG8U7lTVuBl5VqkjPlzlkQTPgq5INqhihNQSV5OD2tvxnFC9bWQ=@vger.kernel.org, AJvYcCWTzUkk5JZzjaV2dH1newFHHax4+BQ2x1eeXbza7Xvs4ZbaTjJjjEmYBFcjzkD32vysd/rmSUHYuZOeT+Cd@vger.kernel.org, AJvYcCXCMBAfM3n6Fs8ZOhNHlPJ/9Fo5BR+4sB847q2Xlb5rvfesuznY3i4shjsMwItK9QkQzQylsN4euE+Cp2sXk7r6@vger.kernel.org
X-Gm-Message-State: AOJu0YxHp3Fp+S/rbvVlYhUzl4qT/tQ/1dyLnXcNhFVGZE9SodANCH4j
	qK3hJJAK3JSoFJ8oDJSmFaMRIuwpm5JVrCyT9QRj2384BVlI8TAV28Yl2BL8/b3jG0/xK8paCw8
	dldiGHmvclLpdBOByBTDWAOvTmm0bd3E=
X-Gm-Gg: ASbGncsjg0ndKmyvKoFq++3+P3caehqj2dZ3Bft8+oX6cVqRCZ1KjvNWHg4dPJZITSH
	3dMU8738Klds9A0uW6USwsphjesOl3U4I8InYFwGcBfHQoubXQwsKse12fDYXrYU/O1nQ8ugfTS
	BS6xGLlOWc++mjxukWhUd9FpuRX8WNrs/KAovbL3mWhPgQ1fY=
X-Google-Smtp-Source: AGHT+IH09VpogiVWRSV3TGFY/J0lThnTV8LJdFkmB9/EYkitPgoh7Oyng/UL/+QrWFSwykW245ng7yngVOX9+T2DJRw=
X-Received: by 2002:a17:90b:5548:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-30e7d2bee8amr55478092a91.0.1748020020149; Fri, 23 May 2025
 10:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com> <y42h33hluaspiexeck5gkq7aow45stvf72is2k4hy46ydmlyhp@nr3lb27lrrqo>
In-Reply-To: <y42h33hluaspiexeck5gkq7aow45stvf72is2k4hy46ydmlyhp@nr3lb27lrrqo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 May 2025 10:06:47 -0700
X-Gm-Features: AX0GCFsNteYjlsaXUoYqWQs5Ij-induCXRLQMApohCHBA8b86WtDRzByCTf4H4g
Message-ID: <CAEf4Bzaro8n8aGh2B6bKOjjzVR=ADyY67ipvt_tvb5HUSeX49w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lorenz Bauer <lmb@isovalent.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 4:01=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, May 20, 2025 at 02:01:17PM +0100, Lorenz Bauer wrote:
> > User space needs access to kernel BTF for many modern features of BPF.
> > Right now each process needs to read the BTF blob either in pieces or
> > as a whole. Allow mmaping the sysfs file so that processes can directly
> > access the memory allocated for it in the kernel.
> >
> > remap_pfn_range is used instead of vm_insert_page due to aarch64
> > compatibility issues.
> >
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h |  3 ++-
> >  kernel/bpf/sysfs_btf.c            | 32 +++++++++++++++++++++++++++++++=
+
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index 58a635a6d5bdf0c53c267c2a3d21a5ed8678ce73..1750390735fac7637cc4d2f=
a05f96cb2a36aa448 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -667,10 +667,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_P=
ROPELLER_CLANG)
> >   */
> >  #ifdef CONFIG_DEBUG_INFO_BTF
> >  #define BTF                                                          \
> > +     . =3D ALIGN(PAGE_SIZE);                                          =
 \
> >       .BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {                           \
> >               BOUNDED_SECTION_BY(.BTF, _BTF)                          \
> >       }                                                               \
> > -     . =3D ALIGN(4);                                                  =
 \
> > +     . =3D ALIGN(PAGE_SIZE);                                          =
 \
> >       .BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {                   \
> >               *(.BTF_ids)                                             \
> >       }
> > diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> > index 81d6cf90584a7157929c50f62a5c6862e7a3d081..941d0d2427e3a2d27e8f1cf=
f7b6424d0d41817c1 100644
> > --- a/kernel/bpf/sysfs_btf.c
> > +++ b/kernel/bpf/sysfs_btf.c
> > @@ -7,14 +7,46 @@
> >  #include <linux/kobject.h>
> >  #include <linux/init.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/mm.h>
> > +#include <linux/io.h>
> > +#include <linux/btf.h>
> >
> >  /* See scripts/link-vmlinux.sh, gen_btf() func for details */
> >  extern char __start_BTF[];
> >  extern char __stop_BTF[];
> >
> > +static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *k=
obj,
> > +                               const struct bin_attribute *attr,
> > +                               struct vm_area_struct *vma)
> > +{
> > +     unsigned long pages =3D PAGE_ALIGN(attr->size) >> PAGE_SHIFT;
> > +     size_t vm_size =3D vma->vm_end - vma->vm_start;
> > +     phys_addr_t addr =3D virt_to_phys(__start_BTF);
> > +     unsigned long pfn =3D addr >> PAGE_SHIFT;
> > +
> > +     if (attr->private !=3D __start_BTF || !PAGE_ALIGNED(addr))
>
> With vmlinux.lds.h change above, is the page aligned check still needed?
>
> Oh also can the size of btf region be non-page aligned?

I'd probably leave this as a sanity/safety check, just in case someone
modifies linker script and we miss this.

BTF region size isn't page-aligned but in the linker script we
page-align .BTF_ids that follows it, so the padding should be zeroed
out. And Lorenz added a check in the selftest to validate this, so we
should be covered.

>
> > +             return -EINVAL;
> > +
> > +     if (vma->vm_pgoff)
> > +             return -EINVAL;
> > +
> > +     if (vma->vm_flags & (VM_WRITE | VM_EXEC | VM_MAYSHARE))
> > +             return -EACCES;
> > +
> > +     if (pfn + pages < pfn)
> > +             return -EINVAL;
> > +
> > +     if ((vm_size >> PAGE_SHIFT) > pages)
> > +             return -EINVAL;
> > +
> > +     vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC | VM_MAYWRITE);
>
> Is it ok for fork() to keep the mapping in the child? (i.e. do you need
> VM_DONTCOPY). BTW VM_DONTDUMP is added by remap_pfn_range(), so if you
> want you can remove it here.

I think it's good to keep it in the fork, otherwise libbpf might crash
after work due to BTF data suddenly disappearing.

>
> > +     return remap_pfn_range(vma, vma->vm_start, pfn, vm_size, vma->vm_=
page_prot);
> > +}
> > +
> >  static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init =3D {
> >       .attr =3D { .name =3D "vmlinux", .mode =3D 0444, },
> >       .read_new =3D sysfs_bin_attr_simple_read,
> > +     .mmap =3D btf_sysfs_vmlinux_mmap,
> >  };
> >
> >  struct kobject *btf_kobj;
> >
>
> Overall this looks good to me, so you can add:
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks Shakeel, I've applied the patches to bpf-next!

