Return-Path: <linux-arch+bounces-11775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E7AA64B6
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8F87B41B9
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F52522A4;
	Thu,  1 May 2025 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVXH4gYF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899052505D2;
	Thu,  1 May 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746131219; cv=none; b=N1NV/eJ/2I9YDuZRZpAgTXN57cu2zLr5z4DNSOh0eENvlXhhp4uVi42hhWpgTe6dRRcBxRxI6yNb2D5TUdgR+12phTUkU6OoN6ZlA/g/gHW7nLFgNls4nT0aKVsUgS6mksAANaEhCxdcqLnYI+u1ZMYZdbmRkkQSpEZFRNnVJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746131219; c=relaxed/simple;
	bh=ERI+uZsfRCrXXczPB24lqctJuTE3FABtXqF8FmU5CJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/OQa8cz/q7nHwk0ggl4Tzt8JK8suB8FFEAbCCrKDyqdL8gs5J4s59ORUeQY1sM4e9PhkwwEu7KgDNsXdjR3CnGYDfkLXyJz5AsahTcoH9oQoNu+gfhiobRUzKrWbh5CdbYkuQ+3JLJuf7//0VeqU6hQy6Y3TeRCGvKa4Va1h7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVXH4gYF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so1342304f8f.3;
        Thu, 01 May 2025 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746131216; x=1746736016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8CrQWlLzxb73F56MwUsevVcml0gCfK3bwjovrxEBe8=;
        b=TVXH4gYFG6KL1xsXGDXhbQ7k7nkJoj4ciD1l7lEdkiqDhbOtMMyPK+pbODXEI2CFmw
         CaJk6lJ7rqajA55zsObQUJvH0umezVX/vWNEJk7Z1BK0HnyECS9j9qSkbhBpgbVlkNwI
         vxpMOBfTv+W/g8WNDqbWEikQxE0fk8L9Nuwcdo9rnBkCnlQFPTfdTctVB3XEmSedNnbU
         ZSPuBKoRr7wGdFHOrxIl6tcEDMk5lcfC0te94Z6eLLVratKQquCUIhSvshzm65zGq+eN
         rK1Px8q7L6GIAJdRe6S/aFtA8vxDyDI1FlyerUvxWbBjnYXmqJfMGui2QkY0HxBSjown
         vjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746131216; x=1746736016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8CrQWlLzxb73F56MwUsevVcml0gCfK3bwjovrxEBe8=;
        b=OwdXHFHyP4NgbIFQ4SvG1RIc8Vnu/yG6fVsw7z2fBDW7kzH5Cf1s70tMQQJfF6dBZG
         c1NwTNAL2i2rE288Cu00Qtwr1UyD9UconPJtI5B59acggMOLMXdsBOvIlq+bj2TFI8WO
         0M93qAZFMxYhmdnasRFkEQQ+o1lv4GS+acYEW3OwTMwVKNjfmetwiEZHR/M4MzUP8h12
         p8ZiS8C9gQAsdYH1CQCpsxOrvNbLpKl/LN5ZkNJJUBI/S7IYEUYTI2GM2HUS9PRWmmiy
         HHXjQbxT/seWVnPYVawC1p7yKcyUesISj0FUymvi+7cjBxUr+NJ+84/iH2owFl+VSHXr
         BslQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1gIbRIdISClThlhIw5Qayhqb0U4Yt1+hFIBtiLD9cKXh7oGntMDt7sc8HXOmtGZ2l3631QnrsCvooDxpbzIo8@vger.kernel.org, AJvYcCWR5yRHVgew5ZFI2DZ2Dfgc4s7LJ9rUvvDlkuIxKwhpHy1/L8gMbZKjNTGgrN7suTuyjVTDMuekJHrAQrdk@vger.kernel.org, AJvYcCWv0AsLP7oNirfgfLdvTbLL1aiq+Y1kwF6LjXchvC5ErcHqE5E/09SoEi5KkQNi/4vjDShfusk9bzlLew==@vger.kernel.org, AJvYcCXBv7ED93Gz4vqQy4sw4xwvVet0hGUhPRdPNKCev9/CRjmOFBFbudZG21MerInRcoT556s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWBH7d1FrErPoxSVHC1lOph7/kvA/scojsxorjA9Cf4vLGOYT
	sIoYoc6g+DYQXZuFi9Sug+D4dELahPnl0Ud5qUcQrQ0kbrMu7Y1QVFB4ZdmfdTkWgKYMQk7tb9B
	51kKYh4nhvFKLBFIui5XFobRBIRE=
X-Gm-Gg: ASbGncv3YgPgp7+poMRAn17fXx2m8XhPoJkgoWVkXXbmI8LgcZRouLOspgU0o8GW5Cg
	yneOwRtJ8B74E6fYeLN0ZWiMdNPhU6I6Mtw7Qartek5MKqALrwi9STVhj3ugAdGOM3Eg3MVJg2Y
	zv8bk7GKoKAWvOU4vypL3HzmCDtK1RbdYTWxj1Xw==
X-Google-Smtp-Source: AGHT+IFyyVNBhAK86S6/gTxF1u6RLF+ZnvJ2af6I4Dm6NW31PYqEKZ3qL024vehedXt1lvYARAGY/vlbgUEdQuGJNKc=
X-Received: by 2002:a05:6000:2403:b0:3a0:831d:267c with SMTP id
 ffacd0b85a97d-3a099ad95cfmr134236f8f.18.1746131215660; Thu, 01 May 2025
 13:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com> <20250501-vmlinux-mmap-v1-1-aa2724572598@isovalent.com>
In-Reply-To: <20250501-vmlinux-mmap-v1-1-aa2724572598@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 May 2025 13:26:44 -0700
X-Gm-Features: ATxdqUG94EJ8b0Ioc6f73ltsWz7TlIo7AyQmedPU8WKJQgKrow8M--2t83OE_sg
Message-ID: <CAADnVQK3hSgs_hic2Yuo84vR=2GZNtryki+TDNkNGY_7URsLiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] btf: allow mmap of vmlinux btf
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 7:28=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wro=
te:
>
> User space needs access to kernel BTF for many modern features of BPF.
> Right now each process needs to read the BTF blob either in pieces or
> as a whole. Allow mmaping the sysfs file so that processes can directly
> access the memory allocated for it in the kernel.
>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  3 ++-
>  kernel/bpf/sysfs_btf.c            | 25 +++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 3 deletions(-)
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
> index 81d6cf90584a7157929c50f62a5c6862e7a3d081..7651f37b82c78b8afd9607856=
7a5b6612f5f4d97 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -7,18 +7,39 @@
>  #include <linux/kobject.h>
>  #include <linux/init.h>
>  #include <linux/sysfs.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
>
>  /* See scripts/link-vmlinux.sh, gen_btf() func for details */
>  extern char __start_BTF[];
>  extern char __stop_BTF[];
>
> +struct kobject *btf_kobj;
> +
> +static int btf_vmlinux_mmap(struct file *filp, struct kobject *kobj,
> +                           const struct bin_attribute *attr,
> +                           struct vm_area_struct *vma)
> +{
> +       size_t btf_size =3D __stop_BTF - __start_BTF;
> +
> +       if (kobj !=3D btf_kobj)
> +               return -EINVAL;
> +
> +       if (vma->vm_flags & (VM_WRITE|VM_EXEC|VM_MAYSHARE))
> +               return -EACCES;
> +
> +       vm_flags_clear(vma, VM_MAYEXEC);
> +       vm_flags_clear(vma, VM_MAYWRITE);

Probably should set VM_DONTDUMP to avoid being in the core dump.
vm_flags_mod() can set and clear in one operation.

> +
> +       return vm_iomap_memory(vma, virt_to_phys(__start_BTF), btf_size);

and this one should probably be vm_insert_pages().
Since it's not an IO area.

Overall I think it's a good idea.
As Daniel suggested pls make use of it in libbpf too.
That exercise will make sure that feature probing works
with fallback.

pw-bot: cr

