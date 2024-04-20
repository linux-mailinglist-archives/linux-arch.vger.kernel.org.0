Return-Path: <linux-arch+bounces-3841-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3FA8ABBD1
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E11C209F0
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD75320326;
	Sat, 20 Apr 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zla6rS6r"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFC17C72;
	Sat, 20 Apr 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713620590; cv=none; b=fKvukhOubESS3v/tn2yu+i9T2yz0cKjebvCZEPQnOcUTpPqoEEqE5TGzTEVngRjExvsWEDtly4DWGeZeGNvskN6V/wgeU3aJB+B0HzGzup/4nSysppOh8IkuskiKNe5hoeNnjVE96rY5Od4BivY0b90DiJNBpC57bjzKbp45Yzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713620590; c=relaxed/simple;
	bh=L98CzF8+ryVMoo7uKsd+i7iikr53sn0mgEqJKSQLgtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwWishCY6ayOdmwNe+S++6h+3X4VFqw625w5U/Rx+DufXUBNq1O7lWzN3bKZceMVUXpyBcnPicjl5fYW18lxViGED6rFq/DfJurShIweVQBAz95i4HPNH96SK8LIzceDw9YFCvBq7HnykhFGBOGLsucIpkSP+fLi4S845yiS0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zla6rS6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198E7C4AF09;
	Sat, 20 Apr 2024 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713620590;
	bh=L98CzF8+ryVMoo7uKsd+i7iikr53sn0mgEqJKSQLgtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zla6rS6rzoIO8wcXkN7xCQUbBYqm1ZwIQfNyj+Z0vSVel6XpzYBJLtTDyMm0uRO4s
	 /TZu/shfOfmwYvGarI5Lc8B7qy/MUEkPdT+7yfGs7/oyUrTBaAff0ssj8zc/+TnQTl
	 OpEzfM9OD7Kk0SoJAM1f9kntb91wWZhTuwTTt7YiyTBKR3gDvTMYDNqkvr/fhRdKrQ
	 SPCoGw4PHKacCdkHvyH+ELqFq69Kjz53Ik/7bMfmVOSjoH3XJDnu4w0OCuenG4a7HC
	 rPA//ez31Nqxa+oWHz/MHHyKknZMc2RDwnOqnPZvDI9R47YNzyel/x4kw2EvOsyHzM
	 hsry5oZ4JnzcA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso4708018e87.2;
        Sat, 20 Apr 2024 06:43:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/3kCrvQcNBM+shbLjQLUZSK/FX/zI1WtatPNB7Gv4+hQC1onsB18Vxo0AFPZcySYgwKhKDw1QxIjdqb4LSyu35zs1HRN6XNlgs95MhhPYuDB5CEowvXTmla3c0uc2TNuTe0ooUl4dxWKeVEZk0c/7ry7b8bbmmMOPJ/DtAw==
X-Gm-Message-State: AOJu0YwpvJS5cYCbt3igDMTzhvBeUefF+GHJ31l6KP+eCYQs9jrNPY8O
	YsHQQm/3qha0PDlslZva4XFIwFVcEGs8cZ0QefzmLDCfPEoUJcMMAFJHLl/HjWM7Pj/vyPDivJ5
	+cug9c34lPMnVlbwp2+llMxBPtlw=
X-Google-Smtp-Source: AGHT+IE+SSE2pQ3+Ft8GLnh+z8jjmNx8FhR5p4+yxVCk+TUOwVnWCcxWblDVtNbjfJaxmlV+mvQOapYErRlqcOKIhK4=
X-Received: by 2002:a05:6512:4012:b0:51a:ff87:bae with SMTP id
 br18-20020a056512401200b0051aff870baemr16467lfb.7.1713620588825; Sat, 20 Apr
 2024 06:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com> <20240415162041.2491523-7-ardb+git@google.com>
In-Reply-To: <20240415162041.2491523-7-ardb+git@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Apr 2024 22:42:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASq6ieck5Gw1sLZVp9mC3g-HhZWEhHQmG+wDB__4mX8QA@mail.gmail.com>
Message-ID: <CAK7LNASq6ieck5Gw1sLZVp9mC3g-HhZWEhHQmG+wDB__4mX8QA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] vmlinux: Avoid weak reference to notes section
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 1:20=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Weak references are references that are permitted to remain unsatisfied
> in the final link. This means they cannot be implemented using place
> relative relocations, resulting in GOT entries when using position
> independent code generation.
>
> The notes section should always exist, so the weak annotations can be
> omitted.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>


Applied to linux-kbuild.
Thanks.




> ---
>  kernel/ksysfs.c | 4 ++--
>  lib/buildid.c   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index 495b69a71a5d..07fb5987b42b 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -228,8 +228,8 @@ KERNEL_ATTR_RW(rcu_normal);
>  /*
>   * Make /sys/kernel/notes give the raw contents of our kernel .notes sec=
tion.
>   */
> -extern const void __start_notes __weak;
> -extern const void __stop_notes __weak;
> +extern const void __start_notes;
> +extern const void __stop_notes;
>  #define        notes_size (&__stop_notes - &__start_notes)
>
>  static ssize_t notes_read(struct file *filp, struct kobject *kobj,
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 898301b49eb6..7954dd92e36c 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -182,8 +182,8 @@ unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __r=
o_after_init;
>   */
>  void __init init_vmlinux_build_id(void)
>  {
> -       extern const void __start_notes __weak;
> -       extern const void __stop_notes __weak;
> +       extern const void __start_notes;
> +       extern const void __stop_notes;
>         unsigned int size =3D &__stop_notes - &__start_notes;
>
>         build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
> --
> 2.44.0.683.g7961c838ac-goog
>
>


--=20
Best Regards
Masahiro Yamada

