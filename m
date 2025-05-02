Return-Path: <linux-arch+bounces-11808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FE3AA7887
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 19:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13B14C8104
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9630026AA8A;
	Fri,  2 May 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfPRW2Ty"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E826981A;
	Fri,  2 May 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206155; cv=none; b=AypKU73xcoRFPvx+caxUuyVWTXfl20pYflIuzJd7ckq1CNq1pH/uSAA2ErF+iXsAjYbf+1rUY6qnvz1b47uDVXz7eWaqU82U9Z21D890bKykXp+I7EWAd11culhTHwob0C09TT65qBIEKldkouJqfVf0uBi7Vf8G5du4ZcInsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206155; c=relaxed/simple;
	bh=7oAJ1fr3d5y8tx00o9/V7vXmU30c4iDM4H6tfuWHMYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdTYqYjBg04U8EUdYdWA3sP7+mbekZXVsCvDIhCXTcTIgY725mv4EmChvW5cUx26CNjIKvKPh1X4QaCll1VGuY5YPuNTkSwuYU1Kg8vO9TOW3If6dXxl45QGnUfi49t8R7AQpf5rr2V+PhPcVLYwjSshobN8TaoGVrJFxQfCfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfPRW2Ty; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso1342905f8f.1;
        Fri, 02 May 2025 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746206152; x=1746810952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIXFmIK20RXAQ5Up1vrTlXd9d3r7rt4iqcjaj17VsmI=;
        b=OfPRW2TyFeBLbntD7HET5kqJ8RQrYQ0vwLYhDSst1iVqxxSKYxyaEDZtitS04qXu3S
         WmiFN+R3S50EFS6P4sDHXtMwvlsZC6DcHuEjicwdmwiNDqK5XkudlVBDX3PhtkXQW8Qc
         9EVabltMqv4M57gtPxd/KMRIjmtE8XmM122/MwpCcg9YxLfkut6QMiezLzrXCMVz9RIo
         NbG9xap+YlzafyhCHS8UG2BI9HtXgV+n5qFtXWoU65PbYaO0S1pnyj7tmT4NmB2Ctn4U
         bNlzc/uCajTK6VuIyPuYoclITrh93oULEXtq+YI+C7SJAUhYPQ0c1ZUoXIF+P08xVjT7
         lZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746206152; x=1746810952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIXFmIK20RXAQ5Up1vrTlXd9d3r7rt4iqcjaj17VsmI=;
        b=bZo9fBY8qBNpMM97OoVSpMWwwwaGoY1RxNviejjb5XjFwwlGG+EjJ1wrfe7bPr07za
         6mSd61+IYZPF7Kzq5OSiaGrJ7aqetI2TDir78sN2KfOPOR5muRyYsfZWg8xrJ+cgi03A
         +8tqkN6iQjJf3PL49QIgW0Pg33rp6AVzO8wNPqLJ+/TlBVumsDctxkm91pwZdb6sG1KM
         9jnIPWe+eepMXslEE7OOC7UOoOCOKEIr1loyxC6h2u0bEBCAe1oItU5dMyB40p3+EKH8
         8Za397Gj7xISIROl0PCAXf2hJvayzwUxsL/F4QK0TfoPNnSRlkwejZtNCiXIF8L8/oEp
         t1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU4QspijuExdZQNfOI94b/QQBpBvYjNzMF5w8GjQns3f3+LF5iPViqmGQcJeFfTWXvJDnCZnGPP85XNciTmgMp5@vger.kernel.org, AJvYcCVHVBSEIZoIwlvZQ9gf6MkPdd4nBwS5Cac6xB/sqF+SkqtHFEdTO+pupQgpUZaJ9bCw/d8=@vger.kernel.org, AJvYcCWWNMYIlexqbVFIrSksxrdBkXAhcLkipAgkXTAAkprtB+MscAk8HoM5Z6u1r9Nv/eCrPyWhV9Rc/+g2HBhG@vger.kernel.org, AJvYcCXVNX5iOYPh03CXrtQUzEKsVtb1QhIZOMADFOHnP9nQUUi5+UOs9BewPmBQIzcouUlJmJy7VxdK0UWTQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr2+kDfnRQo42BCshKGV/QnV2c+QZSQFoYb7VttkGs9jfdTQiF
	K2BQYtKpG3mc5f0IOWtBNpqdPJfLG223XtqxNLtM/q9fnCvD5tjiGqNmWDBnFwMe4sFZkbDel9d
	zpnfmQl+dg4AOXYbL2vD/VA6RYv0=
X-Gm-Gg: ASbGncsQRmtjfx+V0p9Y+eLYuTaLIDnGzYOJ1QdABX6EyCL5qUjMMezgqqI0kqeOYBq
	iZh2I6lS6QB5basrO7IQ52pB1eyuSTElU6qv4d5vD46FjcPiLMMuXLNRNq1xWzmWcp+bodpKNH4
	KmuG+e13iB6x/O0Umoa9A6Ku59vGakdQTdpf8tFQ==
X-Google-Smtp-Source: AGHT+IHFaDoUkiLv6qrDRiLHOymcCa1QAfKNS9cOooOeYdmz0087AG0msj1NuyGZYt79ubuFELZFUB0DHOcV0IxMdew=
X-Received: by 2002:a05:6000:4285:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-3a098469fb7mr3045104f8f.25.1746206151582; Fri, 02 May 2025
 10:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com> <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com>
In-Reply-To: <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 10:15:40 -0700
X-Gm-Features: ATxdqUHv70xDkjA1O8GM-6_W2bf266rBR3mODzmR7hfuUKQjRknKIt1rPiesetQ
Message-ID: <CAADnVQ+dMwAFPO-ASojjYPxODpCKf_9FCLjUvn2HeHigL53JdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] btf: allow mmap of vmlinux btf
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

On Fri, May 2, 2025 at 3:20=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wro=
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
>  kernel/bpf/sysfs_btf.c            | 36 +++++++++++++++++++++++++++++++++=
+--
>  2 files changed, 36 insertions(+), 3 deletions(-)
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
> index 81d6cf90584a7157929c50f62a5c6862e7a3d081..f4b59b1c2e5b11ffffa80662a=
d39334c730019ee 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -7,18 +7,50 @@
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
> +       phys_addr_t start =3D virt_to_phys(__start_BTF);
> +       size_t btf_size =3D __stop_BTF - __start_BTF;
> +       size_t vm_size =3D vma->vm_end - vma->vm_start;
> +       unsigned long pfn =3D start >> PAGE_SHIFT;
> +       unsigned long pages =3D PAGE_ALIGN(btf_size) >> PAGE_SHIFT;
> +
> +       if (kobj !=3D btf_kobj)
> +               return -EINVAL;
> +
> +       if (vma->vm_pgoff)
> +               return -EINVAL;
> +
> +       if (vma->vm_flags & (VM_WRITE|VM_EXEC|VM_MAYSHARE))
> +               return -EACCES;
> +
> +       if (pfn + pages < pfn)
> +               return -EINVAL;
> +
> +       if (vm_size >> PAGE_SHIFT > pages)
> +               return -EINVAL;
> +
> +       vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC|VM_MAYWRITE);
> +       return remap_pfn_range(vma, vma->vm_start, pfn, vm_size, vma->vm_=
page_prot);

remap_pfn_range() should be avoided.
See big comment in kernel/events/core.c in map_range().

The following seems to work:
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index f4b59b1c2e5b..7d0fd28070d8 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -20,13 +20,13 @@ static int btf_vmlinux_mmap(struct file *filp,
struct kobject *kobj,
                            const struct bin_attribute *attr,
                            struct vm_area_struct *vma)
 {
-       phys_addr_t start =3D virt_to_phys(__start_BTF);
+       unsigned long addr =3D (unsigned long)__start_BTF;
        size_t btf_size =3D __stop_BTF - __start_BTF;
        size_t vm_size =3D vma->vm_end - vma->vm_start;
-       unsigned long pfn =3D start >> PAGE_SHIFT;
        unsigned long pages =3D PAGE_ALIGN(btf_size) >> PAGE_SHIFT;
+       int i, err =3D 0;

-       if (kobj !=3D btf_kobj)
+       if (kobj !=3D btf_kobj || !pages)
                return -EINVAL;

        if (vma->vm_pgoff)
@@ -35,14 +35,17 @@ static int btf_vmlinux_mmap(struct file *filp,
struct kobject *kobj,
        if (vma->vm_flags & (VM_WRITE|VM_EXEC|VM_MAYSHARE))
                return -EACCES;

-       if (pfn + pages < pfn)
-               return -EINVAL;
-
        if (vm_size >> PAGE_SHIFT > pages)
                return -EINVAL;

        vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC|VM_MAYWRITE);
-       return remap_pfn_range(vma, vma->vm_start, pfn, vm_size,
vma->vm_page_prot);
+
+       for (i =3D 0; i < pages && !err; i++, addr +=3D PAGE_SIZE)
+               err =3D vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
+                                    virt_to_page(addr));
+       if (err)
+               zap_page_range_single(vma, vma->vm_start, pages *
PAGE_SIZE, NULL);
+       return err;
 }


Great that you added:
        /* Check padding is zeroed */
        for (int i =3D 0; i < trailing; i++) {
                if (((__u8 *)raw_data)[btf_size + i] !=3D 0) {
                        PRINT_FAIL("tail of BTF is not zero at page
offset %d\n", i);
                        goto cleanup;
                }
        }

but this part is puzzling:
        trailing =3D page_size - (btf_size % page_size) % page_size;

