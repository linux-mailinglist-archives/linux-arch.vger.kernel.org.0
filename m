Return-Path: <linux-arch+bounces-3676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32548A4D95
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 13:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1452843F3
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFD960EF9;
	Mon, 15 Apr 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1NHa8/P"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC31E896;
	Mon, 15 Apr 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180164; cv=none; b=K8YoW3jJYJSAfSN82R0soG/bSEkbLYFRvEHT98E9gsxnGZL1GcnwN0lcFsCmjxKiVlDD1EoiDNOq28GAR6IOCAaIhoLTlS4aFzEUrqs/C3ZibTuEHF0uhxD5lgjiFxjrsTuoBsYObzmffwfEMpqUG5XkCzaoZPebTZVQri+K9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180164; c=relaxed/simple;
	bh=Ejm1aCCripul0+6BjYzjMjeA/lB7dWZX4qNm0cAvPz4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4GCqojaXil6yI0w+hgLNh2wW78NDNy3ujV9T7DAWy5tfXqcJ7xhOy1v5zNNR+YpQOevgFH8GcEXbUi0f/m7S73uCz2YDJ5bAAkGQBEpWz0WdqCXipXJ6qihamzxNsQWvoPh4U8dPBWfe6NKj+PBy7gosmB2C7BMhDJ+ivE4iEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1NHa8/P; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d3776334so3910140e87.1;
        Mon, 15 Apr 2024 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713180161; x=1713784961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIkONmgy9ZJbqCprg1mRBojeyA5GhfKbRxcMnCu9Nn8=;
        b=H1NHa8/PLtCVKTu8wTVaq+H5tbuAaL0iJQh6RvapTH4H/8r9e4LcjtEg2kNvDzgllv
         pVma8yvpKoYS6WzzS9tp8k+5Nmqp5E/AGqbjFeI42FKL46aCd/YcA4JUt2BC7aE5Sb++
         D1wJysCgPF2Te+QIaztm9DuYwd0wkvqGSHNqJ7T/+CokNL5aM55Tj+1qLxqeLvlK7j9c
         E+qZuuRk28osSV6USg8rEsM+kAUHv+1q6+ZcRyXiqZhXRf1JcHuWRmt+UxM17s+Mgq70
         H2Jti4JSdgaAbrBK76Xq/QJ1g2ZUvCdgvofSo1aGGUeyloSEbsnJG0WxuZZQ3r9sgTG8
         5j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713180161; x=1713784961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIkONmgy9ZJbqCprg1mRBojeyA5GhfKbRxcMnCu9Nn8=;
        b=Vc9T+hu7Z7ljj3+pExeDyr9lgbs42L9tL/jZ/HTgcP7CZzGC0sHuGvItcPYbKKql8i
         vdQ7v/tdebhMblsKO5dw9uJuXXReTFt3Q3QPr5/L/KrayjMedRUm/Yn08m11u1gux6vA
         u6vaO7yinBr5lr5TjJ2yhO4g0i0/GGWk5UhuAt1iI9cYTbQiThvql4E15GIZFZbndyVj
         N+HUMPN0GMKROK47qmDc/Fu3nsyjfD6vIUj43dlQy/RJM6UqH+L+8F10Np1ROz5k8IyT
         Ys9Ou7DX9/MmAOtftIwav77Z03n27GqldD7Le7pO+TUg6opm4mcWU/wCOA8oW9r+8RU9
         wXXA==
X-Forwarded-Encrypted: i=1; AJvYcCVIx5iGZvg/zFiZqhD2DF7b+WNguUz21OWAX39tdcWz6Fnxe+CvXihOIvqiWbC//L2TKDvdYGfDH/w7sDwkvqXtyM0L02zbf4eBilRi5NsvtyG1ZnWzr9Ih5teIY/yoiCVJzg2iEOx9Yytwf+NrPJsy59QR5FK89OAQr4u58Q==
X-Gm-Message-State: AOJu0YzkBNgooD2g4fiTgn+hhiK3XqaWMWFTsk0Bj+fbRbDCLQz9nisl
	Lz/DWk0RpLvGgrOatShTu1PZNaUYfwphT8bOLAVc2+hR4RsDGNL8
X-Google-Smtp-Source: AGHT+IGsWH8hvkgWTnSmJZma8ocO18tq1tcLHnilXGa21I2AQO+Lmbt/Mi2Wcn2qRzx1DIlvjAyAyA==
X-Received: by 2002:a19:915e:0:b0:516:d4c2:53eb with SMTP id y30-20020a19915e000000b00516d4c253ebmr6353557lfj.58.1713180160823;
        Mon, 15 Apr 2024 04:22:40 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id k9-20020adff289000000b0033e45930f35sm11877262wro.6.2024.04.15.04.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:22:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 15 Apr 2024 13:22:38 +0200
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v3 3/3] btf: Avoid weak external references
Message-ID: <Zh0N_nJKgu43GvYY@krava>
References: <20240415075837.2349766-5-ardb+git@google.com>
 <20240415075837.2349766-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415075837.2349766-8-ardb+git@google.com>

On Mon, Apr 15, 2024 at 09:58:41AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> If the BTF code is enabled in the build configuration, the start/stop
> BTF markers are guaranteed to exist in the final link but not during the
> first linker pass.
> 
> Avoid GOT based relocations to these markers in the final executable by
> providing preliminary definitions that will be used by the first linker
> pass, and superseded by the actual definitions in the subsequent ones.
> 
> Make the preliminary definitions dependent on CONFIG_DEBUG_INFO_BTF so
> that inadvertent references to this section will trigger a link failure
> if they occur in code that does not honour CONFIG_DEBUG_INFO_BTF.
> 
> Note that Clang will notice that taking the address of__start_BTF cannot
> yield NULL any longer, so testing for that condition is no longer
> needed.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 9 +++++++++
>  kernel/bpf/btf.c                  | 7 +++++--
>  kernel/bpf/sysfs_btf.c            | 6 +++---
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e8449be62058..4cb3d88449e5 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -456,6 +456,7 @@
>   * independent code.
>   */
>  #define PRELIMINARY_SYMBOL_DEFINITIONS					\
> +	PRELIMINARY_BTF_DEFINITIONS					\
>  	PROVIDE(kallsyms_addresses = .);				\
>  	PROVIDE(kallsyms_offsets = .);					\
>  	PROVIDE(kallsyms_names = .);					\
> @@ -466,6 +467,14 @@
>  	PROVIDE(kallsyms_markers = .);					\
>  	PROVIDE(kallsyms_seqs_of_names = .);
>  
> +#ifdef CONFIG_DEBUG_INFO_BTF
> +#define PRELIMINARY_BTF_DEFINITIONS					\
> +	PROVIDE(__start_BTF = .);					\
> +	PROVIDE(__stop_BTF = .);
> +#else
> +#define PRELIMINARY_BTF_DEFINITIONS
> +#endif
> +
>  /*
>   * Read only Data
>   */
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 90c4a32d89ff..6d46cee47ae3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5642,8 +5642,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
>  	return ERR_PTR(err);
>  }
>  
> -extern char __weak __start_BTF[];
> -extern char __weak __stop_BTF[];
> +extern char __start_BTF[];
> +extern char __stop_BTF[];
>  extern struct btf *btf_vmlinux;
>  
>  #define BPF_MAP_TYPE(_id, _ops)
> @@ -5971,6 +5971,9 @@ struct btf *btf_parse_vmlinux(void)
>  	struct btf *btf = NULL;
>  	int err;
>  
> +	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> +		return ERR_PTR(-ENOENT);
> +
>  	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
>  	if (!env)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index ef6911aee3bb..fedb54c94cdb 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -9,8 +9,8 @@
>  #include <linux/sysfs.h>
>  
>  /* See scripts/link-vmlinux.sh, gen_btf() func for details */
> -extern char __weak __start_BTF[];
> -extern char __weak __stop_BTF[];
> +extern char __start_BTF[];
> +extern char __stop_BTF[];
>  
>  static ssize_t
>  btf_vmlinux_read(struct file *file, struct kobject *kobj,
> @@ -32,7 +32,7 @@ static int __init btf_vmlinux_init(void)
>  {
>  	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
>  
> -	if (!__start_BTF || bin_attr_btf_vmlinux.size == 0)
> +	if (bin_attr_btf_vmlinux.size == 0)
>  		return 0;
>  
>  	btf_kobj = kobject_create_and_add("btf", kernel_kobj);
> -- 
> 2.44.0.683.g7961c838ac-goog
> 

