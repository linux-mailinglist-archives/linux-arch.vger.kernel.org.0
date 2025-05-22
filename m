Return-Path: <linux-arch+bounces-12084-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698AEAC171B
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 01:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFED3ACDEF
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 23:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E862BFC93;
	Thu, 22 May 2025 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q3W+9IFW"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A52882D5
	for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954903; cv=none; b=FQA/NVB0ViRzUG9hVI4Vt4sYaLMZ65L5qTIo/CW3LEdqaSwYJC7DOCHYaCGT7VDBb6xgmFbqw//TtyJY8WLahDiqH3P+DfbEbocymypH3R0M2ffNjtKFDMEpOmJgXdG+nooUqzLxvM4POD1vnFhTm8cP3o3BO30eROOKZZdC854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954903; c=relaxed/simple;
	bh=CAq6Olkm0gyHVjAbyNXiMAUCtt/20xW3ZHsmPluUdEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztx6WvR2QfAJIemcSBxjHI8zWfD5zW+u7GXdg0VIyU+lHMxWt3je9+2vhXxLUACy7V7t0l8lKD8UTgBjm/BM3U4p1rcrILPY1ZvKY/P9ZapwbX52/HF/ZUzQEvDM1GJ3sSUeDJdFkfCPX1D3fcbUI40jUTYyylgxZ39Yj/1zZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q3W+9IFW; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 May 2025 16:01:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747954887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uf0ek8B4u+hUNQgv5LpC16rMo6YMxbrp0ZjUjPp6Kl0=;
	b=Q3W+9IFWgjXnivtRIyzeGR+bIhMb6UZ1xypwtk9xXcRKQsK3gS5RB+cHRknYQUUt/Sbrw1
	NhNwL1ZJi75D8oC7n2/0uVXCXXhlNZ0QVdQ2ZWvAtm2jcca6nlwzkteEPnvTqIye8xzyso
	tBGKJDhdlqzeGQhsw6t3TMdNJaGhx9A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenz Bauer <lmb@isovalent.com>
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
Message-ID: <y42h33hluaspiexeck5gkq7aow45stvf72is2k4hy46ydmlyhp@nr3lb27lrrqo>
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
X-Migadu-Flow: FLOW_OUT

On Tue, May 20, 2025 at 02:01:17PM +0100, Lorenz Bauer wrote:
> User space needs access to kernel BTF for many modern features of BPF.
> Right now each process needs to read the BTF blob either in pieces or
> as a whole. Allow mmaping the sysfs file so that processes can directly
> access the memory allocated for it in the kernel.
> 
> remap_pfn_range is used instead of vm_insert_page due to aarch64
> compatibility issues.
> 
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  3 ++-
>  kernel/bpf/sysfs_btf.c            | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 58a635a6d5bdf0c53c267c2a3d21a5ed8678ce73..1750390735fac7637cc4d2fa05f96cb2a36aa448 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -667,10 +667,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>   */
>  #ifdef CONFIG_DEBUG_INFO_BTF
>  #define BTF								\
> +	. = ALIGN(PAGE_SIZE);						\
>  	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
>  		BOUNDED_SECTION_BY(.BTF, _BTF)				\
>  	}								\
> -	. = ALIGN(4);							\
> +	. = ALIGN(PAGE_SIZE);						\
>  	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
>  		*(.BTF_ids)						\
>  	}
> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index 81d6cf90584a7157929c50f62a5c6862e7a3d081..941d0d2427e3a2d27e8f1cff7b6424d0d41817c1 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -7,14 +7,46 @@
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
> +static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
> +				  const struct bin_attribute *attr,
> +				  struct vm_area_struct *vma)
> +{
> +	unsigned long pages = PAGE_ALIGN(attr->size) >> PAGE_SHIFT;
> +	size_t vm_size = vma->vm_end - vma->vm_start;
> +	phys_addr_t addr = virt_to_phys(__start_BTF);
> +	unsigned long pfn = addr >> PAGE_SHIFT;
> +
> +	if (attr->private != __start_BTF || !PAGE_ALIGNED(addr))

With vmlinux.lds.h change above, is the page aligned check still needed?

Oh also can the size of btf region be non-page aligned?

> +		return -EINVAL;
> +
> +	if (vma->vm_pgoff)
> +		return -EINVAL;
> +
> +	if (vma->vm_flags & (VM_WRITE | VM_EXEC | VM_MAYSHARE))
> +		return -EACCES;
> +
> +	if (pfn + pages < pfn)
> +		return -EINVAL;
> +
> +	if ((vm_size >> PAGE_SHIFT) > pages)
> +		return -EINVAL;
> +
> +	vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC | VM_MAYWRITE);

Is it ok for fork() to keep the mapping in the child? (i.e. do you need
VM_DONTCOPY). BTW VM_DONTDUMP is added by remap_pfn_range(), so if you
want you can remove it here.

> +	return remap_pfn_range(vma, vma->vm_start, pfn, vm_size, vma->vm_page_prot);
> +}
> +
>  static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
>  	.attr = { .name = "vmlinux", .mode = 0444, },
>  	.read_new = sysfs_bin_attr_simple_read,
> +	.mmap = btf_sysfs_vmlinux_mmap,
>  };
>  
>  struct kobject *btf_kobj;
> 

Overall this looks good to me, so you can add:

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

