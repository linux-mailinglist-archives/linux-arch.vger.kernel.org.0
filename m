Return-Path: <linux-arch+bounces-11862-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948DFAAD05C
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 23:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4622A3B83E4
	for <lists+linux-arch@lfdr.de>; Tue,  6 May 2025 21:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE06243376;
	Tue,  6 May 2025 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjrugXko"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0F24394B;
	Tue,  6 May 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567535; cv=none; b=eWzkk8L2738DpbVKRgpQm3jQARnrdQjzl+OjiBz8C4r7lbrspDzLgeOIxMnusv95CyXSPFUowlOYdv8BIp2Cp3GSJytCZn7LDab8FHH9cSMGiSoP1dO6FMIx3CAgE7GW0DgypqYd8wKcr11x5wu1m9V2817gdCTEbLyPQJwnsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567535; c=relaxed/simple;
	bh=Cx5sE90y2ys6oIvTHH8GGP+3pdIrg0a6ManhGA6zXvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIlOFindkSnI8RvRifF2w72DGdbPHDm1IIMzD6RRHrk3HtyBp6oTN6APYCUZtGeQ+ooTWMd7Gztc7oIY1aPt9reZkdLdJ1VQ40OIkPz5uM8V+NrBNuDrYspNzjZ/q51fw5X8TAR192sr0I0Ge6StbGilk1f5hCn7CM4KO7sWAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjrugXko; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso8751909b3a.2;
        Tue, 06 May 2025 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746567533; x=1747172333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwAZSNowo2VD817mfe3d2H1QWy3kKfRxNc/esdLbsOY=;
        b=IjrugXko7ojrDOY0ymsoxlvfbvDVndscjViMXUAOWX6zrMOw5LkIRSOG57CmxPcGNx
         8ZwWE9Cwsh4gHvzBb8+OW71PviT7tdYY+GkS5CweyySQrsQj2PVgEkk1EFDC2kxIsIYa
         XSFye11RQxV4cVFqq+gaAfvOmolisfHRcWz8qiL9bh+z0aDhL9x9208HXUBbYCqysehQ
         mmLhm2TMD1l58yWT+XLMutkucI8rB0WIzt32IDKL1upZeu5VkngO5S8oNfHJPWCE/FhI
         4r03nbSZWMhoiP+8KxlsbfAhJkVRZ4r2A1ThJJzG2ZYehHz9ObI5C5DioCpmQ96NPgRH
         sgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746567533; x=1747172333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwAZSNowo2VD817mfe3d2H1QWy3kKfRxNc/esdLbsOY=;
        b=AzhyP1quYSqOzGKi6T7OCFhuVwFGdg7BUpIFM+9+tKNPRlFGG9D7gszc8feRt1o7Gy
         YWJoMNjTKSh7hLMJlMQ0BRlUEAlgQq1L56TX9FFDltbKmUgMgHAkDSaasiSofJzsIUFF
         +0myoRZ0r9bdun2vCQTX4KqBSNwLrdnnjaT0raxpo57X1+LdJ+HkGKLNLhaslXjW1kSB
         m+MOP3IZdrxrgDSRuG5QkC1IPalngqMO53FUbIXbSN0EuhY2wvOJrrbXrVMIwFBE9A4i
         y73m9j6bY/kKdWoeaDrDtn9SAPj9nbpbFcE5D3PXbq6orSdaHg5B5Fpft/wHPbmqRmMi
         4Jaw==
X-Forwarded-Encrypted: i=1; AJvYcCVKT+qij96cCVzD6pIAU5YSd/zZUwkvIeLDnhOG5QfDq/oZdyetN2TbpDJjuCv/S9jyo4XU7QnWf535EB9v@vger.kernel.org, AJvYcCVc7GADyTMQ9lTWd8uSf3t5LjHenXohKsELhcxWQ7MyGYjIk/DOCtrdSA/n+5NlHXluJQJ/2AmSRv3G4g==@vger.kernel.org, AJvYcCWT2TBRQUSQmJIoaSuaWnlFlPV8Xl29Jglk9+qtLiUIpx22XYbvqGJ/wA/YNIQ8xzBaQkZnT9nmsj/aV+8MIb1K@vger.kernel.org, AJvYcCXrYZ276Tku7Ificnzxg2HLb4zxER0C3JbPpJS3hOmDqrlOKpQtyoZ0O4osbdLfwI0Jffc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1agfYoaxHTcBZ1mYx5HAzPOT3JH6rrmgLb62wvCOBSc0EuX9
	h7xYuOejxm0vA3WsLvFiJBf/hTvvAWztAunr7FfyBmC0M8RrnE8KlM2rG9wzVINQTvfNbLcBIbm
	rfBpvTR7LA4iOGJFbmuupIny84vY=
X-Gm-Gg: ASbGncuUyMYLyVD42X3izZcU4e+/udGZ/6jbyxuEw47R6pWwB4DhLrhlMb2tcndZECm
	tHLorm9inWCDqNv3JRj9AouF5WbThC8lPZRw4p0/q9D8m5sxnYSshE8ZW4ntqfu15QVZX+6+xnC
	mP6Wl1tfSDfVZJSXlZmmKV76ty28zohDAkbiiDjg==
X-Google-Smtp-Source: AGHT+IFl39fQ8h8T+0SA+xJDCF75R2jxrXBkpuHplE/SWGUZUhK1/6qhJ+bggwGK8zL9HYkNpHa11ZiCq5yV3f2kw8w=
X-Received: by 2002:a05:6a00:8f0c:b0:740:9c57:3907 with SMTP id
 d2e1a72fcca58-7409cfd4fe2mr1001525b3a.19.1746567533410; Tue, 06 May 2025
 14:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com> <20250505-vmlinux-mmap-v3-3-5d53afa060e8@isovalent.com>
In-Reply-To: <20250505-vmlinux-mmap-v3-3-5d53afa060e8@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 14:38:41 -0700
X-Gm-Features: ATxdqUGGCDGg2tnfgumvbm6h04EAY8VmSj63XahGKHqk0wu1txc2sMopPtImsZ0
Message-ID: <CAEf4BzYUMmpg2hqvaGphDzKSGKcS3zyTgxsyh_8iP79==jpVnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] libbpf: Use mmap to parse vmlinux BTF
 from sysfs
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
> Teach libbpf to use mmap when parsing vmlinux BTF from /sys. We don't
> apply this to fall-back paths on the regular file system because there
> is no way to ensure that modifications underlying the MAP_PRIVATE
> mapping are not visible to the process.
>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>  tools/lib/bpf/btf.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 72 insertions(+), 11 deletions(-)
>

[...]

> @@ -1030,7 +1045,7 @@ struct btf *btf__new_empty_split(struct btf *base_b=
tf)
>         return libbpf_ptr(btf_new_empty(base_btf));
>  }
>
> -static struct btf *btf_new(const void *data, __u32 size, struct btf *bas=
e_btf)
> +static struct btf *btf_new_no_copy(void *data, __u32 size, struct btf *b=
ase_btf)
>  {
>         struct btf *btf;
>         int err;
> @@ -1050,12 +1065,7 @@ static struct btf *btf_new(const void *data, __u32=
 size, struct btf *base_btf)
>                 btf->start_str_off =3D base_btf->hdr->str_len;
>         }
>
> -       btf->raw_data =3D malloc(size);
> -       if (!btf->raw_data) {
> -               err =3D -ENOMEM;
> -               goto done;
> -       }
> -       memcpy(btf->raw_data, data, size);
> +       btf->raw_data =3D data;
>         btf->raw_size =3D size;
>
>         btf->hdr =3D btf->raw_data;
> @@ -1081,6 +1091,24 @@ static struct btf *btf_new(const void *data, __u32=
 size, struct btf *base_btf)
>         return btf;
>  }
>
> +static struct btf *btf_new(const void *data, __u32 size, struct btf *bas=
e_btf)

btf_new() is internal, so I'd extend existing btf_new() with `bool
is_mmap` and not add btf_new_no_copy(), I think it's simpler.
Eventually we can turn is_mmap into some sort of flags, if we need
more tuning of data ownership behavior

> +{
> +       struct btf *btf;
> +       void *raw_data;
> +
> +       raw_data =3D malloc(size);
> +       if (!raw_data)
> +               return ERR_PTR(-ENOMEM);
> +
> +       memcpy(raw_data, data, size);
> +
> +       btf =3D btf_new_no_copy(raw_data, size, base_btf);
> +       if (IS_ERR(btf))
> +               free(raw_data);
> +
> +       return btf;
> +}
> +
>  struct btf *btf__new(const void *data, __u32 size)
>  {
>         return libbpf_ptr(btf_new(data, size, NULL));
> @@ -1354,6 +1382,37 @@ struct btf *btf__parse_raw_split(const char *path,=
 struct btf *base_btf)
>         return libbpf_ptr(btf_parse_raw(path, base_btf));
>  }
>
> +static struct btf *btf_parse_raw_mmap(const char *path, struct btf *base=
_btf)
> +{
> +       struct stat st;
> +       void *data;
> +       struct btf *btf;
> +       int fd;
> +
> +       fd =3D open(path, O_RDONLY);
> +       if (fd < 0)
> +               return libbpf_err_ptr(-errno);
> +
> +       if (fstat(fd, &st) < 0) {
> +               close(fd);

close() can clobber errno, so save `err =3D -errno` before it

> +               return libbpf_err_ptr(-errno);
> +       }
> +
> +       data =3D mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +       close(fd);

same, errno clobbering danger

> +
> +       if (data =3D=3D MAP_FAILED)
> +               return NULL;
> +
> +       btf =3D btf_new_no_copy(data, st.st_size, base_btf);
> +       if (!btf)

btf_new_no_copy() is returning ERR_PTR() on error, no?

pw-bot: cr

> +               munmap(data, st.st_size);
> +       else
> +               btf->raw_data_is_mmap =3D true;
> +
> +       return btf;
> +}
> +
>  static struct btf *btf_parse(const char *path, struct btf *base_btf, str=
uct btf_ext **btf_ext)
>  {
>         struct btf *btf;
> @@ -1659,8 +1718,7 @@ struct btf *btf__load_from_kernel_by_id(__u32 id)
>  static void btf_invalidate_raw_data(struct btf *btf)
>  {
>         if (btf->raw_data) {
> -               free(btf->raw_data);
> -               btf->raw_data =3D NULL;
> +               btf_free_raw_data(btf);
>         }
>         if (btf->raw_data_swapped) {
>                 free(btf->raw_data_swapped);
> @@ -5290,7 +5348,10 @@ struct btf *btf__load_vmlinux_btf(void)
>                 pr_warn("kernel BTF is missing at '%s', was CONFIG_DEBUG_=
INFO_BTF enabled?\n",
>                         sysfs_btf_path);
>         } else {
> -               btf =3D btf__parse(sysfs_btf_path, NULL);
> +               btf =3D btf_parse_raw_mmap(sysfs_btf_path, NULL);
> +               if (IS_ERR_OR_NULL(btf))
> +                       btf =3D btf__parse(sysfs_btf_path, NULL);
> +
>                 if (!btf) {
>                         err =3D -errno;
>                         pr_warn("failed to read kernel BTF from '%s': %s\=
n",
>
> --
> 2.49.0
>

