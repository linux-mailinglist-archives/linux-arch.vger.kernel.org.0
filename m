Return-Path: <linux-arch+bounces-3529-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F349889ED72
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 10:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558B8B22941
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D6413D535;
	Wed, 10 Apr 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjdrlWMc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701D13D523;
	Wed, 10 Apr 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737321; cv=none; b=Ym/ax79eJKlIMttu2jccZWD18FkjfanqO2mZg3VQbtnUEAAnU84dltc1niO1D0BwsTwxJMLs2nPqWba6RLGjbnhpJwO+V3qLyZXsu6guWCUc4ibZ0Xm1WEnlnr29r72XblzMM5RNsxdVHrzQJYZp20M9tFzhwte2smbWNNx5tnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737321; c=relaxed/simple;
	bh=T43KbF42fm8HsFmTxbZXO8nSYWOOBrDknmli7i2PLa4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK2zguNYq5YKbGAOi8oQ26ogHKG3WdO7jSTf2oN+08xeVYLoGKWEcV9OVt0zodSnBiZRk7QSVeTrfmJbhV0lS4+2psj/z/fhLp9HvrdH6mUq+fkkjigSRXQj0oa9W9k6pbdQ0e3HxDuLwtdHUsl4eMmXe3X+niCf3H+iLbbnr3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjdrlWMc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d0162fa1so7732942e87.3;
        Wed, 10 Apr 2024 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712737316; x=1713342116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9ncL6J099zDWm1volQeziNRO3e5GzIYLXP1BKZCft0=;
        b=VjdrlWMcx2GmYhnOOC+t3fS5F4C0Q285sAAHxu0+9Gt8aruZzjouKTJ9D1gKP+v2GP
         GhE+CBLfc7ssoXR7LHdHi7Zv91uIZ4U5FSdosQM6FAysyKeDs3jtPsgUAfiyDGYfzjWx
         yBzH21rFkqjZVbgfXRSkqog6LLoxDAM8807C5OyCnfoqbEKzMJDiWJoCPqPOYH9I2KA5
         Sd03jO7SkVrSpjMG7M7djzW0g2ssf2QWWJSOaFd+Gzk28MlCFJJVB23WhTbl1hXfA0uX
         kQUDrB0RQhqLXSOS4pNdY/tJ4hjBfv1JxPCx7mS5LX3+KRSYaVhP5MgBqXpyFHFpcNH9
         zKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712737316; x=1713342116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9ncL6J099zDWm1volQeziNRO3e5GzIYLXP1BKZCft0=;
        b=IG4cviILRNiJ+AwZHfKp6+U8X5XZ8hLzx44W7wkJUevUfjesTmkDiOZJgtJqcs55e2
         nKlcv6yJl3cPifUJOxMtNDz8Ohdua2JRlyY/iuyh1+4mHMdZ+muMdXkhKH02HaPZxS8o
         ngY++N911YguqlU+Mf1he+F8hsyOHK4vXiTj2aaDXzBXTVNTqTq/jL1kykGLBaj1XUp8
         LB5q1ttvaradkMXOOT/FwZCZjnONpGACvYCqs88sCr6i1voJDAmoHZOjsaucHVSjyDy+
         ebPEKP9e2fc7TbcOZ2a0AWxhWH3GjDRnS/2kIptRjpEmWOqqZVl0kISbbMD/mU7cXwOg
         2IuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB/NiqwZ6RfjHdbYu/3VhKerCgo/M/31QyIFvfKbhf8AcciKx0YrftwtztBy6wKk3YSEsUna0mwErufeM/HS+OJXfiJaDvoBMvv1M34PCWm/wCJsGXGw24EiA+AayCrXF9jSn89HkVGBGdKECUks6qRGXpFt+tsnx15vfYlA==
X-Gm-Message-State: AOJu0YwS76Ist9Cc8UHr7dgBQMz6yc5PomHZICLOheOz6qOw93HEzDbs
	/47CzLGEcfKc23syjuDpwdHCEs+xRb2rO/pHPfH2K5mCJMIiXzd2
X-Google-Smtp-Source: AGHT+IH/iUhygMfoz7qE+pEGl264dmAwnbM0yE56uCPtfUVV0GoU8JOg2uu3MTmCQbspBueLcpmk4Q==
X-Received: by 2002:a19:8c0c:0:b0:517:5ee6:4f5b with SMTP id o12-20020a198c0c000000b005175ee64f5bmr1477566lfd.43.1712737315665;
        Wed, 10 Apr 2024 01:21:55 -0700 (PDT)
Received: from krava ([2a02:168:f656:0:bbb9:17bc:93d7:223])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b00341dbb4a3a7sm13306716wrs.86.2024.04.10.01.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:21:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Apr 2024 10:21:53 +0200
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 3/3] btf: Avoid weak external references
Message-ID: <ZhZMITbXAR63hkoD@krava>
References: <20240409150132.4097042-5-ardb+git@google.com>
 <20240409150132.4097042-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409150132.4097042-8-ardb+git@google.com>

On Tue, Apr 09, 2024 at 05:01:36PM +0200, Ard Biesheuvel wrote:
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
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 9 +++++++++
>  kernel/bpf/btf.c                  | 4 ++--
>  kernel/bpf/sysfs_btf.c            | 6 +++---
>  3 files changed, 14 insertions(+), 5 deletions(-)
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

hi,
I'm getting following compilation fail when CONFIG_DEBUG_INFO_BTF is disabled

	[jolsa@krava linux-qemu]$ make 
	  CALL    scripts/checksyscalls.sh
	  DESCEND objtool
	  INSTALL libsubcmd_headers
	  UPD     include/generated/utsversion.h
	  CC      init/version-timestamp.o
	  LD      .tmp_vmlinux.kallsyms1
	ld: kernel/bpf/btf.o: in function `btf_parse_vmlinux':
	/home/jolsa/kernel/linux-qemu/kernel/bpf/btf.c:5988: undefined reference to `__start_BTF'
	ld: /home/jolsa/kernel/linux-qemu/kernel/bpf/btf.c:5989: undefined reference to `__stop_BTF'
	ld: /home/jolsa/kernel/linux-qemu/kernel/bpf/btf.c:5989: undefined reference to `__start_BTF'
	make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
	make[1]: *** [/home/jolsa/kernel/linux-qemu/Makefile:1160: vmlinux] Error 2
	make: *** [Makefile:240: __sub-make] Error 2

maybe the assumption was that kernel/bpf/btf.o is compiled only
for CONFIG_DEBUG_INFO_BTF, but it's actually:

  obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o

I guess we just need !CONFIG_DEBUG_INFO_BTF version of btf_parse_vmlinux
function

jirka

> +
>  /*
>   * Read only Data
>   */
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 90c4a32d89ff..46a56bf067a8 100644
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
> 2.44.0.478.gd926399ef9-goog
> 
> 

