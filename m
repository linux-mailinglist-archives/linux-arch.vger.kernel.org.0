Return-Path: <linux-arch+bounces-7706-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1CA990F8C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 22:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7061F23E47
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 20:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FD51DDC07;
	Fri,  4 Oct 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYfU5nCF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87471DDC02;
	Fri,  4 Oct 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069075; cv=none; b=Td1tO3vdfWUccAsCTmcT/S2izMHAP/UrkuqznWewkh/iXnA3UB0TrZtW198U6KRHiB9AmrP49GTwXunnA9pUWEUAxzT/XEe2tCpMcHprUdDPOD24TqpjX60mQLfAEM1SV/+JcVaSnN40Wqd6+Wtnvt+CeI3a4pglWMnuAvKtPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069075; c=relaxed/simple;
	bh=YYYFR4xM6pq64tyhxGwfZ3sPFhLIXiPYgsZ0dStL10M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drByXn6E+WvRJYgCQxuk7XS/szLTW1Y7Q646CX38oIcjFp28X5ZJYCSieDG5BrdQ05ZLpHl2fv8wtBRjfWKRYS8CrcjRHbdEv3hJA1utieY6gMqwSb4/TjASoMT8CaaNPaESw6Oo2NE0CTMylVklkgQuWsKIx6n+/6MoiWhRHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYfU5nCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109CEC4CEC6;
	Fri,  4 Oct 2024 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069074;
	bh=YYYFR4xM6pq64tyhxGwfZ3sPFhLIXiPYgsZ0dStL10M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYfU5nCF1IhcG9r/BLUlZ83fopNKYX/W4gNeO7INGLlb3hG5q7ZfL/MItsNOF7lvD
	 Z0TfCzp7GYj74VR2pfNgN7Q//fzAy3lRSXTLX/YNyIB2c4P24z0ZJizhfSxu/y8/Bn
	 xtlL5gXdG/ygxQ8t7ZTAswkYupUyG+14LV5wjlxC3QTC+B4Tkat8cU/9fQIjRu407n
	 Y2dIB/ITsG6b2oH0nwxPpgrhcjKCN2rWwK6UkDUe5m6pkwrygKAZJO1vGsl8PPR86D
	 dHzMujwLCbQYn7S/FYdKe9qAowdS8s5p4I9nlpPVoY+oHL3F3dHvy5JJATMDW8qHln
	 fk6pRwV/iNalA==
Date: Fri, 4 Oct 2024 20:11:04 +0100
From: Simon Horman <horms@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	sgarzare@redhat.com, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: Re: [PATCH 5/5] hyperv: Use hvhdk.h instead of hyperv-tlfs.h in
 Hyper-V code
Message-ID: <20241004191104.GI1310185@kernel.org>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Oct 03, 2024 at 12:51:04PM -0700, Nuno Das Neves wrote:
> To move toward importing headers from Hyper-V directly, switch to
> using hvhdk.h in all Hyper-V code. KVM code that uses Hyper-V
> definitions from hyperv-tlfs.h remains untouched.
> 
> Add HYPERV_NONTLFS_HEADERS everywhere mshyperv.h, asm/svm.h,
> clocksource/hyperv_timer.h is included in Hyper-V code.
> 
> Replace hyperv-tlfs.h with hvhdk.h directly in linux/hyperv.h, and
> define HYPERV_NONTLFS_HEADERS there, since it is only used in
> Hyper-V device code.
> 
> Update a couple of definitions to updated names found in the new
> headers: HV_EXT_MEM_HEAT_HINT, HV_SUBNODE_TYPE_ANY.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

...

> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index b1a4de4eee29..62b2a270ae65 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -15,6 +15,7 @@
>  #include <linux/errno.h>
>  #include <linux/version.h>
>  #include <linux/cpuhotplug.h>
> +#define HYPERV_NONTLFS_HEADERS
>  #include <asm/mshyperv.h>
>  
>  static bool hyperv_initialized;

Hi,

With this change in place I see allmodconfig x86_64 builds reporting that
HV_REGISTER_FEATURES is undeclared.

arch/arm64/hyperv/mshyperv.c: In function 'hyperv_init':
arch/arm64/hyperv/mshyperv.c:53:26: error: 'HV_REGISTER_FEATURES' undeclared (first use in this function); did you mean 'HV_REGISTER_FEATURES_INFO'?
   53 |         hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
      |                          ^~~~~~~~~~~~~~~~~~~~
      |                          HV_REGISTER_FEATURES_INFO
arch/arm64/hyperv/mshyperv.c:53:26: note: each undeclared identifier is reported only once for each function it appears in
arch/arm64/hyperv/mshyperv.c:58:26: error: 'HV_REGISTER_ENLIGHTENMENTS' undeclared (first use in this function); did you mean 'HV_ACCESS_REENLIGHTENMENT'?
   58 |         hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |                          HV_ACCESS_REENLIGHTENMENT

> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 6d83ceb7f1ba..5f4053c49658 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -25,6 +25,7 @@
>  #include <asm/page.h>
>  #include <asm/desc.h>
>  #include <asm/cpufeature.h>
> +#define HYPERV_NONTLFS_HEADERS
>  #include <clocksource/hyperv_timer.h>
>  
>  #undef _ASM_X86_VVAR_H
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index f022d5f64fb6..4fe3b3b13256 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
>  #include <asm/hypervisor.h>
> +#define HYPERV_NONTLFS_HEADERS
>  #include <asm/mshyperv.h>
>  #include <asm/apic.h>
>  
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index fc3c3d76c181..680c4abc456e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -19,6 +19,7 @@
>  #include <asm/sev.h>
>  #include <asm/ibt.h>
>  #include <asm/hypervisor.h>
> +#define HYPERV_NONTLFS_HEADERS
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
>  #include <asm/set_memory.h>

And here too, with x86_64 allmodconfig.

In file included from ./include/linux/string.h:390,
                 from ./include/linux/efi.h:16,
                 from arch/x86/hyperv/hv_init.c:12:
arch/x86/hyperv/hv_init.c: In function 'get_vtl':
./include/linux/overflow.h:372:23: error: invalid application of 'sizeof' to incomplete type 'struct hv_get_vp_registers_input'
  372 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
      |                       ^
./include/linux/fortify-string.h:502:42: note: in definition of macro '__fortify_memset_chk'
  502 |         size_t __fortify_size = (size_t)(size);                         \
      |                                          ^~~~
arch/x86/hyperv/hv_init.c:427:9: note: in expansion of macro 'memset'
  427 |         memset(input, 0, struct_size(input, element, 1));
      |         ^~~~~~
arch/x86/hyperv/hv_init.c:427:26: note: in expansion of macro 'struct_size'
  427 |         memset(input, 0, struct_size(input, element, 1));
      |                          ^~~~~~~~~~~

[errors trimmed for the sake of brevity]

...

> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 04775346369c..a8bb6ad7efb6 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -10,6 +10,7 @@
>  #include <asm/boot.h>
>  #include <asm/desc.h>
>  #include <asm/i8259.h>
> +#define HYPERV_NONTLFS_HEADERS
>  #include <asm/mshyperv.h>
>  #include <asm/realmode.h>
>  #include <../kernel/smpboot.h>

And, likewise, with this patch applied I see a number of errors when
compiling this file. This is with allmodconfig on x86_64 with:

Modified: CONFIG_HYPERV=y (instead of m)
Added: CONFIG_HYPERV_VTL_MODE=y

arch/x86/hyperv/hv_vtl.c: In function 'hv_vtl_bringup_vcpu':
arch/x86/hyperv/hv_vtl.c:154:34: error: 'HVCALL_ENABLE_VP_VTL' undeclared (first use in this function)
  154 |         status = hv_do_hypercall(HVCALL_ENABLE_VP_VTL, input, NULL);
      |                                  ^~~~~~~~~~~~~~~~~~~~
arch/x86/hyperv/hv_vtl.c:154:34: note: each undeclared identifier is reported only once for each function it appears in
In file included from ./include/linux/string.h:390,
                 from ./include/linux/bitmap.h:13,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/apic.h:5,
                 from arch/x86/hyperv/hv_vtl.c:9:
arch/x86/hyperv/hv_vtl.c: In function 'hv_vtl_apicid_to_vp_id':
arch/x86/hyperv/hv_vtl.c:189:32: error: invalid application of 'sizeof' to incomplete type 'struct hv_get_vp_from_apic_id_in'
  189 |         memset(input, 0, sizeof(*input));
      |                                ^
./include/linux/fortify-string.h:502:42: note: in definition of macro '__fortify_memset_chk'
  502 |         size_t __fortify_size = (size_t)(size);                         \
      |                                          ^~~~
arch/x86/hyperv/hv_vtl.c:189:9: note: in expansion of macro 'memset'
  189 |         memset(input, 0, sizeof(*input));
      |         ^~~~~~
arch/x86/hyperv/hv_vtl.c:190:14: error: invalid use of undefined type 'struct hv_get_vp_from_apic_id_in'
  190 |         input->partition_id = HV_PARTITION_ID_SELF;
      |              ^~
arch/x86/hyperv/hv_vtl.c:191:14: error: invalid use of undefined type 'struct hv_get_vp_from_apic_id_in'
  191 |         input->apic_ids[0] = apic_id;
      |              ^~
arch/x86/hyperv/hv_vtl.c:195:45: error: 'HVCALL_GET_VP_ID_FROM_APIC_ID' undeclared (first use in this function)
  195 |         control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
      |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

...

