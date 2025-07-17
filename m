Return-Path: <linux-arch+bounces-12836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE9CB08D2D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 14:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5EC18954B0
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E52C17A3;
	Thu, 17 Jul 2025 12:39:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E829ACF3;
	Thu, 17 Jul 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755970; cv=none; b=AMEc2cJQRlRStBs+ay4X9H0+p4IQSctzta4YJusPleP04hH7KB1HKsOJL7jPbh4ahMJ7Q22MxYa6PFlOWkb4lC7FS8XQRjLnRBFvFppgc+83or+aT9BzY982ViPU7N38Iwjj3Mon9Ngjrdxwu7QJtgl4hWU1j6apT/vDdHWCGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755970; c=relaxed/simple;
	bh=YH2pOK4vBUjN8aM5VaclvCspIE9DyGdEoB1Ya5XTqD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvRJdK4oCH9GetZtb6LFxhbHvbatH4jpanvtDr26vXJIC7yE0BYSUTp2aeEL8Gi/8UxfODlhDInzolyH2OYCXWXdfbd76UFNvyJPGNwXxQ/fuAznNoY6ek7DhdDbJgDK455G4CI9dm2jHCVpUI+cly/KnLReVqUCe/nIht88bdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae3a604b43bso158962866b.0;
        Thu, 17 Jul 2025 05:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755966; x=1753360766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FbVsGYaq0NyKNgSaxcwvLjtec9H1rtMkyXCq5d8Dfs=;
        b=wl7vbN3cIgWuNXv62L9cvvyhZRLu+e2XWQkbrC2X881oUbS5EL0ss1Xfvh9Kq15g62
         H5ikdOp0Cdp0IOSLKFjNIqzoES05pkHn6aqScK1xBGfABwLSjqcSEM9D9XPeaEXbyx4+
         Q/9yDkyYlQvf6HK+bD/uf7j+Fhsu6kfypuyNx1wmMnxRTyZFmOBy5oUay9mvE6X7xJgW
         QUdQbVt1+to7bZXA8iSJWU6FbiAWrnnhemAzEnfS+UQJTjIlFqMa5bM2s8dDyXzJFfzk
         9hqonI/zpkQyd0xKUQB98GX06ol02OufZMWzGzZtJt71iYkLJRwCFH2H3A8/H9LFEtNQ
         rn1A==
X-Forwarded-Encrypted: i=1; AJvYcCUawH1+uOq8gbL5gCHKgBFGf/eryY4Tuo/BNYAwxaMxrQ4KG2x6RnRoAIcvQU9wF4CvC8EZFL8cn6de+A==@vger.kernel.org, AJvYcCUl0O8T5JH1VgS4K1FEr+kw9Wv1fQE8aWZFkin10FL2d/ao9BUjf7RuG5GL09J8IvNFqEE=@vger.kernel.org, AJvYcCXcNGV+8K9nxAXcliUnZUQIuE/bE1HTqnWuhaAbr6fW8A4Ft4/7s/roEHRJk96EJo5UTHaKdHg0GCY53Skt@vger.kernel.org, AJvYcCXe5KUdHzCr9HJy3j3faAa7bnvBqphtKOuvPF7OMle/l4KbjLqFiLjjw/6SsoJEzGIedIIMrp68FcPYmf7JvPZ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mB4MVWxDGdewprmK00HPfhLmPcOlLyJ/xMF4AFkcXNI00SbU
	8CvW05Dac48VlffML6Rd1Mfmyo6KTPk/iLu+fFDgYjJsbRh0YqRYCrpG
X-Gm-Gg: ASbGncs3uPzzQv40tqChYwix8VhPreRUz7LuFotji0ywbQwnAJJSH9TyBOM3lRi8W0X
	wcOFpk+kOLGns6mSUti52sju4fAd+IqNr0ddR630CN9k7R3UZrHRe0GEKBEbOu+BvYcJisHWOXU
	Cspuys8O4Siv55kQvJgKhUwoksUAtgR6/qeHOa9MothV9prDw9BE4rR0fI/IwVsFi5M/B7ekfVY
	XuhV2AeB5fWh8TtOoQcfE6pjUpkb+UCKMukqWtBHVQZG8fadcfwKVt8kYDuMv/P8YxXH9hkx1+V
	CnhZaujFwksC4u8dG9ifNJ97Pu2mKDVlawevZQv9cRDKu3nU8dMEcCPNrOf3VZ6Cv5W19ZGXyTG
	Eiuwx7JwkUYpWhTx4m/q3sbM=
X-Google-Smtp-Source: AGHT+IFGMudLSa+MO2VRzIbQxkbKfo9sFMUMYLFenyZfvGkLpQS2jb+5lrL6tqgUkH/mp49v4K+DYQ==
X-Received: by 2002:a17:907:80b:b0:aec:55c0:6d5e with SMTP id a640c23a62f3a-aec55c0765dmr171272166b.30.1752755965867;
        Thu, 17 Jul 2025 05:39:25 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee471asm1374427366b.54.2025.07.17.05.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:39:25 -0700 (PDT)
Date: Thu, 17 Jul 2025 05:39:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Lorenz Bauer <lmb@isovalent.com>, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
Message-ID: <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com>

Hello Lorenz,

On Tue, May 20, 2025 at 02:01:17PM +0100, Lorenz Bauer wrote:
> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index 81d6cf90584a7157929c50f62a5c6862e7a3d081..941d0d2427e3a2d27e8f1cff7b6424d0d41817c1 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c

>  extern char __start_BTF[];
>  extern char __stop_BTF[];

> +static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
> +				  const struct bin_attribute *attr,
> +				  struct vm_area_struct *vma)
> +{
> +	unsigned long pages = PAGE_ALIGN(attr->size) >> PAGE_SHIFT;
> +	size_t vm_size = vma->vm_end - vma->vm_start;
> +	phys_addr_t addr = virt_to_phys(__start_BTF);

I am getting the following warning on arm64 which seems related to this
code here. lines are based on cd031354087d8ae ("Merge branch
'net-mlx5e-add-support-for-pcie-congestion-events') net-next branch

	[   58.896157] virt_to_phys used for non-linear address: 000000009fea9737 (__start_BTF+0x0/0x685530)
	[   23.988669] WARNING: CPU: 25 PID: 1442 at arch/arm64/mm/physaddr.c:15 __virt_to_phys (arch/arm64/mm/physaddr.c:?)
	[   24.018136] Modules linked in: nvidia_cspmu(E) mlx5_ib(E) ipmi_ssif(E) arm_smmuv3_pmu(E) arm_cspmu_module(E) coresight_trbe(E) ib_uverbs(E) ipmi_devintf(E) ipmi_msghandler(E) coresight_stm(E) coresight_etm4x(E) coresight_tmc(E) coresight_funnel(E) stm_core(E) coresight(E) cppc_cpufreq(E) sch_fq_codel(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) xhci_pci(E) xhci_hcd(E) sm3_ce(E) sha3_ce(E) sha512_ce(E) spi_tegra210_quad(E) acpi_power_meter(E) loop(E) efivarfs(E) autofs4(E)
	[   24.075371] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
	[   24.080276] Hardware name: Quanta S7GM 20S7GCU0010/S7G MB (CG1), BIOS 3D22 07/03/2024
	[   24.088295] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
	[   24.098440] pc : __virt_to_phys (arch/arm64/mm/physaddr.c:?)
	[   24.105398] lr : __virt_to_phys (arch/arm64/mm/physaddr.c:?)
	[   24.112227] sp : ffff8000ba00f8e0
	[   24.115620] x29: ffff8000ba00f8e0 x28: ffff8000ba00faf0 x27: ffff8000ba00fa88
	[   24.122919] x26: ffff8000ba00fa40 x25: ffff800082772000 x24: 0000fffd6db70000
	[   24.130226] x23: 0000000000685530 x22: 0000fffd6e200000 x21: ffff800081cc0000
	[   24.140540] x20: ffff800081be02d8 x19: ffff800081cc0000 x18: 5f5f282037333739
	[   24.150708] x17: 6165663930303030 x16: 0000000000000fc4 x15: 0000000000000003
	[   24.160737] x14: ffff800082923398 x13: 0000000000000003 x12: 0000000000000003
	[   24.168042] x11: 00000000fffeffff x10: ffff800082663784 x9 : cc38fcac5cdabe00
	[   24.175348] x8 : 0001000000000000 x7 : ffff8000813dd878 x6 : 0000000000000000
	[   24.182653] x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
	[   24.189959] x2 : 0000000000000000 x1 : ffff800081a3a6d0 x0 : 0000000000000055
	[   24.197257] Call trace:
	[   24.199761] __virt_to_phys (arch/arm64/mm/physaddr.c:?) (P)
	[   24.206883] btf_sysfs_vmlinux_mmap (kernel/bpf/sysfs_btf.c:27)
	[   24.214264] sysfs_kf_bin_mmap (fs/sysfs/file.c:179)
	[   24.218536] kernfs_fop_mmap (fs/kernfs/file.c:462)
	[   24.222461] mmap_region (./include/linux/fs.h:? mm/internal.h:167 mm/vma.c:2405 mm/vma.c:2467 mm/vma.c:2622 mm/vma.c:2692)


Should __pa_symbol() be used instead of virt_to_phys()?

Thanks
--breno

