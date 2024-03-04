Return-Path: <linux-arch+bounces-2787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C3B86FA5A
	for <lists+linux-arch@lfdr.de>; Mon,  4 Mar 2024 07:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EF3280FD3
	for <lists+linux-arch@lfdr.de>; Mon,  4 Mar 2024 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAF611CB9;
	Mon,  4 Mar 2024 06:57:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4A11CAE;
	Mon,  4 Mar 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535446; cv=none; b=qKds5SS9woda6DHzgS5fFN4yfvnagPU0TxVWJnAsLNTDEni6Wik6JHzUYpyDwEnwbDQRlERj3m190213//6HixTjbRHTOMM2F/S78EsXqgSU7soH3xofv/sRKh5n0+VxczIh6Z56Ewy8G+KxwTRTCKnavgly64Bx3kbTGNc7IpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535446; c=relaxed/simple;
	bh=9HfecEd6NkQd1IimPEySh5WxdNTj5CxZdNgtzk6A+tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNqQoVDK1xoRwf03nKNV4oTAis6mggpbPO0Bv5iwF7VZwYia+1zEHl5xHpCHxpMHYbabUE1NlJaMmqtGnGSIl6WeYguK6jniKMxiR9qxkOQuMRAH23xwXzVIrl1/2e5ZwcAwGh1LrKRT3/eMTRA8myI7ZlKMvq/zUARZX3S9/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd10a37d68so5129795ad.2;
        Sun, 03 Mar 2024 22:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535444; x=1710140244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6EAqa/4s94Z/gZxe9+vX8na4hVTPxTQWvOFoEAtEHo=;
        b=E3YMN1QmhukiefoH+demT+4loutm2Sjuykrp9rWKQfVA6pXbWbMh3+wJf+RopFe6ZH
         qqAWrMiy/sDfRReJgL2MIJd5uf3fUIdeCcV13Lab+xi+0jSFjpZEt08dAOkRGKDBTo+G
         QRJKmrKhQQWzpXXNkfJTBxT57wHPfDeHMb1ak1Cw08o7W6uGZtXU5kohr6PdL2oiKEgW
         lflfYtkHYK7WgjrQ2YMAZYiRhB7OdS8cLJgiLTmEqyi///NV//SCQNjhLugWAERZbgod
         LQ0seMhGdiTrJY3UEvkhfBCiAROGxljJlMqehoklHwzWC9tbOI33d8vm1ON/m8CZnhsh
         0x3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUbmoCCo0DcQRR1abEcvfvr5JA/KtxnK589nu4gu9vd3PR3/4YLKVC5K+bLb+j6DTIoBij5EBIZSrhbAbSxxdxPxlkNydtFJ5ebdvwa1nczmQ0HkiCvecGbdgAQYkSHWv4+NW6lBIo4GemBZHjPocAS8Yiv/ojK6ZgHiQQPprvxe8BMIAiHg==
X-Gm-Message-State: AOJu0YzMgM0hGqa3E6+WosX8bkFwh0C6gQvNNjvsa2Yi8oGHCHgIy1Ei
	hg64Lxp3CxyCkz0xt0GyPCUUq4bBQE92G66ewyxD71zJWh0T5TFb
X-Google-Smtp-Source: AGHT+IEiMnmSwhterl9pGeW1k1VWBF3rct/JlAgc50TQsfHPnUHkrNGF211q40yRwQ2JBUCuJuSBSw==
X-Received: by 2002:a17:902:7d94:b0:1db:e600:4585 with SMTP id a20-20020a1709027d9400b001dbe6004585mr7036875plm.19.1709535444039;
        Sun, 03 Mar 2024 22:57:24 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001db337d53ddsm7830555pln.56.2024.03.03.22.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:57:23 -0800 (PST)
Date: Mon, 4 Mar 2024 06:57:19 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de,
	tytso@mit.edu, Jason@zx2c4.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org, ssengar@linux.microsoft.com,
	longli@microsoft.com
Subject: Re: [PATCH 1/1] x86/hyperv: Use Hyper-V entropy to seed guest random
 number generator
Message-ID: <ZeVwz5qQUwbkgH1H@liuwe-devbox-debian-v2>
References: <20240122160003.348521-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122160003.348521-1-mhklinux@outlook.com>

On Mon, Jan 22, 2024 at 08:00:03AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> A Hyper-V host provides its guest VMs with entropy in a custom ACPI
> table named "OEM0".  The entropy bits are updated each time Hyper-V
> boots the VM, and are suitable for seeding the Linux guest random
> number generator (rng).  See a brief description of OEM0 in [1].
> 
> Generation 2 VMs on Hyper-V boot using UEFI.  Existing EFI code in

Using -> use, I think.

> Linux seeds the rng with entropy bits from the EFI_RNG_PROTOCOL.
> Via this path, the rng is seeded very early during boot with good
> entropy.  The ACPI OEM0 table is still provided in such VMs, though
> it isn't needed.
> 
> But Generation 1 VMs on Hyper-V boot from BIOS. For these VMs, Linux
> doesn't currently get any entropy from the Hyper-V host.  While this
> is not fundamentally broken because Linux can generate its own entropy,
> using the Hyper-V host provided entropy would get the rng off to a
> better start and would do so earlier in the boot process.

I think is a good idea.

> 
> Improve the rng seeding for Generation 1 VMs by having Hyper-V specific
> code in Linux take advantage of the OEM0 table to seed the rng. Because
> the OEM0 table is custom to Hyper-V, parse it directly in the Hyper-V
> code in the Linux kernel and use add_bootloader_randomness() to
> seed the rng.  Once the entropy bits are read from OEM0, zero them
> out in the table so they don't appear in /sys/firmware/acpi/tables/OEM0
> in the running VM.
> 
> An equivalent change is *not* made for Linux VMs on Hyper-V for
> ARM64.  Such VMs are always Generation 2 and the rng is seeded
> with entropy obtained via the EFI_RNG_PROTOCOL as described above.
> 
> [1] https://download.microsoft.com/download/1/c/9/1c9813b8-089c-4fef-b2ad-ad80e79403ba/Whitepaper%20-%20The%20Windows%2010%20random%20number%20generation%20infrastructure.pdf
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c |  1 +
>  drivers/hv/hv_common.c         | 62 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  2 ++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index e6bba12c759c..c202a60ecc6c 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -640,6 +640,7 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
>  	.init.x2apic_available	= ms_hyperv_x2apic_available,
>  	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
>  	.init.init_platform	= ms_hyperv_init_platform,
> +	.init.guest_late_init	= ms_hyperv_late_init,
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
>  	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ccad7bca3fd3..ebae19b708b4 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -20,6 +20,8 @@
>  #include <linux/sched/task_stack.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/ptrace.h>
> +#include <linux/random.h>
> +#include <linux/efi.h>
>  #include <linux/kdebug.h>
>  #include <linux/kmsg_dump.h>
>  #include <linux/slab.h>
> @@ -348,6 +350,66 @@ int __init hv_common_init(void)
>  	return 0;
>  }
>  
> +void __init ms_hyperv_late_init(void)
> +{
> +	struct acpi_table_header *header;
> +	acpi_status status;
> +	u8 *randomdata;
> +	u32 length, i;
> +
> +	/*
> +	 * Seed the Linux random number generator with entropy provided by
> +	 * the Hyper-V host in ACPI table OEM0.  It would be nice to do this
> +	 * even earlier in ms_hyperv_init_platform(), but the ACPI subsystem
> +	 * isn't set up at that point. Skip if booted via EFI as generic EFI
> +	 * code has already done some seeding using the EFI RNG protocol.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ACPI) || efi_enabled(EFI_BOOT))
> +		return;
> +
> +	status = acpi_get_table("OEM0", 0, &header);
> +	if (ACPI_FAILURE(status) || !header) {
> +		pr_info("Hyper-V: ACPI table OEM0 not found\n");

I would like this to be a pr_debug() instead of pr_info(), considering
using the negative case may cause users to think not having this table
can be problematic.

Alternatively, we can remove this message here, and then ...

> +		return;
> +	}
> +

... add a pr_debug() here to indicate that the table was found.

	pr_info("Hyper-V: Seeding randomness with data from ACPI table OEM0\n");

Dexuan, Saurabh, Haiyang and Long, can you give an ack or nack to this
patch and help test it?

Thanks,
Wei.

> +	/*
> +	 * Since the "OEM0" table name is for OEM specific usage, verify
> +	 * that what we're seeing purports to be from Microsoft.
> +	 */
> +	if (strncmp(header->oem_table_id, "MICROSFT", 8))
> +		goto error;
> +
> +	/*
> +	 * Ensure the length is reasonable.  Requiring at least 32 bytes and
> +	 * no more than 256 bytes is somewhat arbitrary.  Hyper-V currently
> +	 * provides 64 bytes, but allow for a change in a later version.
> +	 */
> +	if (header->length < sizeof(*header) + 32 ||
> +	    header->length > sizeof(*header) + 256)
> +		goto error;
> +
> +	length = header->length - sizeof(*header);
> +	randomdata = (u8 *)(header + 1);
> +	add_bootloader_randomness(randomdata, length);
> +
> +	/*
> +	 * To prevent the seed data from being visible in /sys/firmware/acpi,
> +	 * zero out the random data in the ACPI table and fixup the checksum.
> +	 */
> +	for (i = 0; i < length; i++) {
> +		header->checksum += randomdata[i];
> +		randomdata[i] = 0;
> +	}
> +
> +	acpi_put_table(header);
> +	return;
> +
> +error:
> +	pr_info("Hyper-V: Ignoring malformed ACPI table OEM0\n");
> +	acpi_put_table(header);
> +}
> +
>  /*
>   * Hyper-V specific initialization and die code for
>   * individual CPUs that is common across all architectures.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 430f0ae0dde2..e861223093df 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -193,6 +193,7 @@ extern u64 (*hv_read_reference_counter)(void);
>  
>  int __init hv_common_init(void);
>  void __init hv_common_free(void);
> +void __init ms_hyperv_late_init(void);
>  int hv_common_cpu_init(unsigned int cpu);
>  int hv_common_cpu_die(unsigned int cpu);
>  
> @@ -290,6 +291,7 @@ void hv_setup_dma_ops(struct device *dev, bool coherent);
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>  static inline bool hv_is_hibernation_supported(void) { return false; }
>  static inline void hyperv_cleanup(void) {}
> +static inline void ms_hyperv_late_init(void) {}
>  static inline bool hv_is_isolation_supported(void) { return false; }
>  static inline enum hv_isolation_type hv_get_isolation_type(void)
>  {
> -- 
> 2.25.1
> 

