Return-Path: <linux-arch+bounces-11908-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4DAAB4753
	for <lists+linux-arch@lfdr.de>; Tue, 13 May 2025 00:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DF819E3935
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD426560C;
	Mon, 12 May 2025 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCoelINx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E32AE68;
	Mon, 12 May 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747089253; cv=none; b=lsYZWn4YEt7JaobOs6SYTFp6fv4IYU2OdiXPvlIXWO+f8fHuyoGoAeKLUa2nhPbIXoedciPwn0p/K9Uzq0zB0Ow0VLSVDdjpHjQMCiHVVhpCVSAY4Vp6klfPEzHPDPLQPMA0uSx4RTqvjeCLb9+2MvPAEyHYGEkJHzo5XQJ7fV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747089253; c=relaxed/simple;
	bh=Uyv5f8G97uaVPehcv/OXsR7F2iqwhtMOvls3KtiMBGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC9GnALJaAnKrN0KffH4CdQKtcEnv0AfLy3rQCDffb3W3UFtCiVOloZsYtBYdQuIFsYgdMbKHJa2tF403G7U+2jX1HPFXkKiMMZdTjnDiQsldF4pkiUJCdIEzfAfOBX+S5cXlcvK1Tlhvhsg//E+5F7h8oanEJ7nM3yk8k4wyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCoelINx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22fa414c478so27561805ad.0;
        Mon, 12 May 2025 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747089251; x=1747694051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hd7t/cvsRC7PGuAegEDcr4Z+BMlJi19aw0rDaj30gSo=;
        b=JCoelINxF1QBLDqbNFL7EFVozs4RPR4kHiY1pFAoZUv2n2v3zDYrPtkUnobbVr9DhU
         zY872BFJV5ciN99B2IBVIk7e+aHGhFpuZoank1RM7yVOdeBkmeMfEw73A4PPeN8+Jrtv
         Zyu7yLsaE0EnGEPdE35r3TXBAm3rZ/VXpfARblLftxwaoKMRn9cCFYKSxnAj2r73+J1j
         Q5ttfgp3baOqyqfTd2SMKV0riNRMUelFiZR9Z66ID+AcUCRo00nZAu0OiqNRbbVwtL8y
         tzgI2oncGCnq+KMhNt4aUhjG1iWtBFt+XLNXEF8a/n94pZYpw6+ZXkHgc+5oX2lbLlv0
         mhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747089251; x=1747694051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hd7t/cvsRC7PGuAegEDcr4Z+BMlJi19aw0rDaj30gSo=;
        b=mt0y0eTNtCShX2VZp2RtemiBtUtLB8EAxC3qtYxcfbvGHs1KD+KxJgqW3zfVaIynQJ
         q89RJUgESrpxIFE6jEt9O5MM1nciKFlhTmQ6BlhrVfekXJlW/h2ypM94RhykljTraWH+
         xlJNji9KQZnZNZ4bCOOXKdmAvkBA/2NsRIALMQ66smo7zB+LNOh77bgQmAyT+VDEhQEg
         ouuCZvN0y0wXXF3YU/CzLkPRS6nZxa9LQVDgySynQooiw4wHFBHc3rTD1QHJAKJLKQsR
         m4EneMw1EbT2XVVwSxYBoQm+ru5z4hye3OlccjHQHbcJL2nV+wYBri6GQRmqpPnZaRQu
         ZF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7CthOk1p+EVc3xZoTthbDyOOuTViK+MNrwQYU0jpBYCAooISrDXKBPi8uh0QtuGZNq9ylhXywsl9wOX2D@vger.kernel.org, AJvYcCWG+jEr+cK5844JP2s0smjuevt4v/9pmYnLlQfh41/JCX9ww3xzyekEBpr4sXCU4RXgJJ2vIW58ewC78w==@vger.kernel.org, AJvYcCWpJmZraB9msOQw+TbffjWtT017a+Q+pCNqG50PARPWPuvQc7P3TYjGrNvVr+SPdisFQQE=@vger.kernel.org, AJvYcCXlWn1vSLUxo4JMVY/FacnUNtgYt86srqvEtdcDgDoIJp+rMHPEzeyxYqVy0wTRutUX8hRsGovQN9d6TpGU0/R/@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/7S9ZjLlrGW19ROrcUmn7nMgt5IZIODYWytK36cGUhCxMfza
	u7xpuFTqPE719eX1gvhDheiM3ldkBgGhbGQ8l+tEx95cGblqe9cQrivMb8Z+b5FQiYG7m3VtslA
	nCLR2FZnv8zx0iFHYdKh2zGWv7oM=
X-Gm-Gg: ASbGnctWWrpCvOE97g1em6IgI2eSw5ZZZIYG2Ly7FdOeqMG29aMK6wJHZDiAFscv1bx
	tnvRB3Wu0dsUdNsfD5yQeM1X0j6Ss5AXicDpVhwn6zfJws3fl5DNXp4K1xtdRmq++s5OJhGeNDG
	uZMDcNK2gnQ2pdQQ68kPApESXaAnJZM3xGdol9mJCB0FaArA/1
X-Google-Smtp-Source: AGHT+IG9nP0sPemMz+mmWcUwXeMKEGdKp44GT6mDHAkt7BEDOgfWF3AG5/vRgejvfA1WpxbSaaNXVTFychn8Mqfvx3g=
X-Received: by 2002:a17:902:e94d:b0:22e:6d46:a5d7 with SMTP id
 d9443c01a7336-22fc91862ffmr245029525ad.35.1747089251387; Mon, 12 May 2025
 15:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com> <20250510-vmlinux-mmap-v4-3-69e424b2a672@isovalent.com>
In-Reply-To: <20250510-vmlinux-mmap-v4-3-69e424b2a672@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 May 2025 15:33:58 -0700
X-Gm-Features: AX0GCFtbigaQt8b_TAnC8H-D6wLcJ88JLWb2gTUYC6ZTQTmYJwn564hP9GMIw7I
Message-ID: <CAEf4BzaPKc_ocE+XTEw6bU0GQ1KOVp+UosZkVKZcqWcJed2ebg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] libbpf: Use mmap to parse vmlinux BTF
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

On Sat, May 10, 2025 at 5:35=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> Teach libbpf to use mmap when parsing vmlinux BTF from /sys. We don't
> apply this to fall-back paths on the regular file system because there
> is no way to ensure that modifications underlying the MAP_PRIVATE
> mapping are not visible to the process.
>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>  tools/lib/bpf/btf.c | 85 +++++++++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 69 insertions(+), 16 deletions(-)
>

Almost there, see below. With those changes feel free to add my ack

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> +static struct btf *btf_parse_raw_mmap(const char *path, struct btf *base=
_btf)
> +{
> +       struct stat st;
> +       void *data;
> +       struct btf *btf;
> +       int fd, err;
> +
> +       fd =3D open(path, O_RDONLY);
> +       if (fd < 0)
> +               return libbpf_err_ptr(-errno);
> +
> +       if (fstat(fd, &st) < 0) {
> +               err =3D -errno;
> +               close(fd);
> +               return libbpf_err_ptr(err);
> +       }
> +
> +       data =3D mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);

err =3D -errno;

> +       close(fd);
> +
> +       if (data =3D=3D MAP_FAILED)
> +               return NULL;

s/return NULL;/libbpf_err_ptr(err);/

> +
> +       btf =3D btf_new(data, st.st_size, base_btf, true);
> +       if (IS_ERR(btf))
> +               munmap(data, st.st_size);
> +
> +       return btf;
> +}
> +
>  static struct btf *btf_parse(const char *path, struct btf *base_btf, str=
uct btf_ext **btf_ext)
>  {
>         struct btf *btf;
> @@ -1618,7 +1669,7 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf =
*base_btf)
>                 goto exit_free;
>         }
>
> -       btf =3D btf_new(ptr, btf_info.btf_size, base_btf);
> +       btf =3D btf_new(ptr, btf_info.btf_size, base_btf, false);
>
>  exit_free:
>         free(ptr);
> @@ -1659,8 +1710,7 @@ struct btf *btf__load_from_kernel_by_id(__u32 id)
>  static void btf_invalidate_raw_data(struct btf *btf)
>  {
>         if (btf->raw_data) {
> -               free(btf->raw_data);
> -               btf->raw_data =3D NULL;
> +               btf_free_raw_data(btf);
>         }

drop now unnecessary {} ?

>         if (btf->raw_data_swapped) {
>                 free(btf->raw_data_swapped);
> @@ -5331,7 +5381,10 @@ struct btf *btf__load_vmlinux_btf(void)
>                 pr_warn("kernel BTF is missing at '%s', was CONFIG_DEBUG_=
INFO_BTF enabled?\n",
>                         sysfs_btf_path);
>         } else {
> -               btf =3D btf__parse(sysfs_btf_path, NULL);
> +               btf =3D btf_parse_raw_mmap(sysfs_btf_path, NULL);
> +               if (IS_ERR_OR_NULL(btf))

just IS_ERR() with the fixes I pointed out above

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

