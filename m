Return-Path: <linux-arch+bounces-11863-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20657AAD061
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 23:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB273A73D8
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4221A94F;
	Tue,  6 May 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjyUxxS8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D1215F52;
	Tue,  6 May 2025 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567571; cv=none; b=iJ5XWCq+5ysPqkibrqjsN04/VyrtE8xzMtXckXR1rC1kHvSrnMVD2pSlatsG401lkX9xJ2wIS8SxofTCTGg+EZ4Ibdvk+4+DWijyF2kM4BQueXPutseaBhialFX0ysdIhFHUGKSFBHyyRRFmzpYt03Futaq38+UqvkWIbRJZm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567571; c=relaxed/simple;
	bh=0lohhYVdn+TgY3SWigx/PiQndU9ev8wH7rFbtOoS4WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pW5aR6MYxMlBM7+ZEgVIjlszt537uOfX9GomoqPWrViheAxIn7pglNKs2bbmpE3gSfWVkFCHQtjQMSFoONldQJXeXmp+DYzmAGDpTHxq8d5f+ogBpWvkQ4ZC1xvuLumG+Gobo5RvAOwscrZpfYDvaXvoDMHPCnIn6SM6rR/aMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjyUxxS8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736c1138ae5so6192466b3a.3;
        Tue, 06 May 2025 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746567569; x=1747172369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWhNUs+P89ubWzVD6SxMdaP1jmX7sIYm56sfjbBf6To=;
        b=JjyUxxS89saL0mrrajAep2qxhUeuNa9+gjs+2NGAbHL+G+Lcg0tLvGR7V+DeTS4jwC
         Z5ShxorOzpdOG/sILKQuKh8tpQo+QugFc3UBL5lA7MeU52OWqr9D9b6qv1MdaC+NyesV
         oZIhL5k3BwwN38EbEKG1dRFcJGJS7XV8RudOrdpE/izsIU+471GAOzHGnNXvLymhzyZa
         6t85q5D7iNf237lmsig5I056coZadB9gZ9t+8PjyjDNnhhdObDpk4CG7nBePasEMkgm/
         bHEigQp2SYJnpzqoVTqBmnb8X0MqlmmOCJE/74vZEchOyEpP3AEDGr0a4AC4boSYt0JV
         OrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746567569; x=1747172369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWhNUs+P89ubWzVD6SxMdaP1jmX7sIYm56sfjbBf6To=;
        b=Pwup2P417i7FkzUbPzOYeUjdXgV5dikdnUPQzU3v5unVFsD8zEvfr83yhIusaL9uy1
         UmuunwGlYVJz8yjkvHxFv8XGoOMi5URkePH2kgBqUY8pxCnLbaf2HKtwjUu1yZ692pTq
         5U2IHqy2SrBupfynJ9umS3vwkd1e+kez84+XhWvANld8o09ZU9pV0QSvttJqMMg+hM99
         Q1+766kb8kudvDscLAswqYtPf0KRPiDoCyIoeBrnfxrFU8DtsyuyZdBhC7nSWpxKK+uk
         6fYe8i1vIX+P4kYEC4IJgYFEhOy4nwEs6iZNUpwe+NCKZ7SmO1VTQ7YOKa9T3zR+5ZT6
         XG9w==
X-Forwarded-Encrypted: i=1; AJvYcCVZUK3H8E+kHge0xjFmeYlSh64OzZ/PFkAmhBT9PgW1dM/Kq79jt+HK2w6QVcQRQouPiip+QQdv+h0SqOX2WcRO@vger.kernel.org, AJvYcCWRXMpvRd+pEF39N5Zj15Rxa5M1HInX5zrR44QvO5UsmGlP3yUzm63iN0O2HDb46fAtw1E=@vger.kernel.org, AJvYcCWkbHTxCqsZ3nhNpjgBW9jkF2ZmAAvG11TRWi1NgqAKs7/oPQ9BIrSokHC2TZ2ogIf0SCKI3AOPd9vuqlfO@vger.kernel.org, AJvYcCWnhV2VT+WJa6AzdwfEqCHJ0ncGUI+OU1w7lI+j0rOX+lqMMHtW84nA5KDGV+a4Cf6tvczWa6HlWAKT1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQ/QpbfNIKu/+MoqSbWev/scT4iUoCIfpE9GZTO+VYdhzqklV
	veB12J/DNSrhsxyOu13VGbY0KTLpSAzymDskv4Xr491qW//crx7/2ZDZ5I+tV9Gzpw0s2WM69zL
	VIXg1gOYwRF8iLdCmHZSv8PJ1pgk=
X-Gm-Gg: ASbGncuSqWzjqk73Bm62e5lwSX1w1rTZvrz3TLd4t8sqFOClkoqzcy6yQkd4CKGNZop
	e4hfHGW7kyoIjikAvCNCYaz/Gf+egRT89MANuWxg0uX6z1r37y5Zgob0Lf/Pgm6PjXFZ8Kna3nM
	xjH14pdAdSXjbadeyareQAJ/dJhj10y5Z28op1kA==
X-Google-Smtp-Source: AGHT+IHOaYPOkYIF2PbAi5hEr+BU0KDBILyf66/F0xwcAqFekute0Z50s3Df5VIzxrS63z+FUTKikhf0kCIz36zM4vk=
X-Received: by 2002:a05:6a00:4296:b0:73e:235a:1fca with SMTP id
 d2e1a72fcca58-7409cfed7ccmr1013340b3a.20.1746567568703; Tue, 06 May 2025
 14:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com> <20250505-vmlinux-mmap-v3-1-5d53afa060e8@isovalent.com>
In-Reply-To: <20250505-vmlinux-mmap-v3-1-5d53afa060e8@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 14:39:15 -0700
X-Gm-Features: ATxdqUGCpsMae_1KntCxxWHj4FDlU-53JBlJmUqkjUAP8ULVpvm66nkxAjEdxSE
Message-ID: <CAEf4BzbsLJgbnuLj6sYFgH7sUZPfn3SqRf_5edTSGuo2oYXN4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] btf: allow mmap of vmlinux btf
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:39=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> User space needs access to kernel BTF for many modern features of BPF.
> Right now each process needs to read the BTF blob either in pieces or
> as a whole. Allow mmaping the sysfs file so that processes can directly
> access the memory allocated for it in the kernel.
>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  3 ++-
>  kernel/bpf/sysfs_btf.c            | 37 +++++++++++++++++++++++++++++++++=
++++
>  2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 58a635a6d5bdf0c53c267c2a3d21a5ed8678ce73..1750390735fac7637cc4d2fa0=
5f96cb2a36aa448 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -667,10 +667,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PRO=
PELLER_CLANG)
>   */
>  #ifdef CONFIG_DEBUG_INFO_BTF
>  #define BTF                                                            \
> +       . =3D ALIGN(PAGE_SIZE);                                          =
 \
>         .BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {                           \
>                 BOUNDED_SECTION_BY(.BTF, _BTF)                          \
>         }                                                               \
> -       . =3D ALIGN(4);                                                  =
 \
> +       . =3D ALIGN(PAGE_SIZE);                                          =
 \
>         .BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {                   \
>                 *(.BTF_ids)                                             \
>         }
> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index 81d6cf90584a7157929c50f62a5c6862e7a3d081..37278d7f38ae72f2d7efcfa85=
9e86aaf12e39a25 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -7,14 +7,51 @@
>  #include <linux/kobject.h>
>  #include <linux/init.h>
>  #include <linux/sysfs.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/btf.h>
>
>  /* See scripts/link-vmlinux.sh, gen_btf() func for details */
>  extern char __start_BTF[];
>  extern char __stop_BTF[];
>
> +static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kob=
j,
> +                                 const struct bin_attribute *attr,
> +                                 struct vm_area_struct *vma)
> +{
> +       unsigned long pages =3D PAGE_ALIGN(attr->size) >> PAGE_SHIFT;
> +       size_t vm_size =3D vma->vm_end - vma->vm_start;
> +       unsigned long addr =3D (unsigned long)attr->private;
> +       int i, err =3D 0;
> +
> +       if (addr !=3D (unsigned long)__start_BTF || !PAGE_ALIGNED(addr))
> +               return -EINVAL;
> +
> +       if (vma->vm_pgoff)
> +               return -EINVAL;

any particular reason to not allow vm_pgoff?

> +
> +       if (vma->vm_flags & (VM_WRITE | VM_EXEC | VM_MAYSHARE))
> +               return -EACCES;
> +
> +       if (vm_size >> PAGE_SHIFT > pages)

() around shift operation, please, for those of us who haven't
memorized the entire C operator precedence table ;)

> +               return -EINVAL;
> +
> +       vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC | VM_MAYWRITE);
> +
> +       for (i =3D 0; i < pages && !err; i++, addr +=3D PAGE_SIZE)
> +               err =3D vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE=
,
> +                                    virt_to_page(addr));
> +
> +       if (err)
> +               zap_vma_pages(vma);

it's certainly subjective, but I find this error handling with !err in
for loop condition hard to follow. What's wrong with arguably more
straightforward (and as you can see I'm not a big fan of mutated addr
but calculated vma->vm_start + i * PAGE_SIZE: pick one style one
follow it for both entities?):


for (i =3D 0; i < pages; i++) {
    err =3D vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
                         virt_to_page(addr + i * PAGE_SIZE));
    if (err) {
        zap_vma_pages(vma);
        return err;
    }
}

return 0;

?


> +
> +       return err;
> +}
> +
>  static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init =3D {
>         .attr =3D { .name =3D "vmlinux", .mode =3D 0444, },
>         .read_new =3D sysfs_bin_attr_simple_read,
> +       .mmap =3D btf_sysfs_vmlinux_mmap,
>  };
>
>  struct kobject *btf_kobj;
>
> --
> 2.49.0
>

