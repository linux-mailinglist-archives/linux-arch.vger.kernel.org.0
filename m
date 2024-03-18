Return-Path: <linux-arch+bounces-3026-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9DD87EEA2
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C485A1F25C96
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7D55766;
	Mon, 18 Mar 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LzSZuENQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB054651;
	Mon, 18 Mar 2024 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782509; cv=none; b=I4UZdDyCuX216z1WZkAK/Kb/Ap42Kgd/blphsWzLuEhNt9HLNJin8S5Qvt8eU/nwtRSCPDe9VwkzUnrzg7zs2VjF8lT85eLxOEhQ6m+jPpKWX5i1SSShhD9XeFr2TrjIZmpQe5PfnjUULTHbH7Ntl/1lGBQ/hj9HOA1gkEOB4qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782509; c=relaxed/simple;
	bh=/t8ZNnA2J1kvdXw4iuMOMJf4nHKtSzJoS0MMwcNeJXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FXnv1qxpgeVfqMrK6fAeCxeY2H757MKqE1P3UmPfDR8Zn5aRzUNBuX38JuqsAwpyHxYBrKnzCDS42wP35w/5qw+Iv0HIHBg+DO9J7bkGo//Ey+WmCsV4X35Yz2YeX+s517/Gr5ijlAMtdBiktkEFzGaYwwtC543L2OIIjhr52ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LzSZuENQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.1.10.114] (c-67-182-149-151.hsd1.wa.comcast.net [67.182.149.151])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD65820B74C0;
	Mon, 18 Mar 2024 10:21:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD65820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710782507;
	bh=oTQr0HD3N12x9AZW5Hauv8Wn4bKEK8+ueEdvw2RA5fs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LzSZuENQWhQs97qBTCx9DUjcoODRm989bry4MQ/1U7/5quG5lxDk1Ef4NnP1xdbXc
	 HAbxgRXPZHs9jngH8e7BKvB7zzTkKfRmHUhcj9xRVu0xmm29CmapmFM5tEpZ7y/bzf
	 NlYlAH45gIoDWOsjDCJdEMZdVcmh94Pgy2T3Ar6Q=
Message-ID: <36684e56-242f-4161-b1b6-ca0cd21c0a8b@linux.microsoft.com>
Date: Mon, 18 Mar 2024 10:21:46 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de, tytso@mit.edu,
 Jason@zx2c4.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20240318155408.216851-1-mhklinux@outlook.com>
Content-Language: en-CA
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20240318155408.216851-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/2024 8:54 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> A Hyper-V host provides its guest VMs with entropy in a custom ACPI
> table named "OEM0".  The entropy bits are updated each time Hyper-V
> boots the VM, and are suitable for seeding the Linux guest random
> number generator (rng). See a brief description of OEM0 in [1].
> 
> Generation 2 VMs on Hyper-V use UEFI to boot. Existing EFI code in
> Linux seeds the rng with entropy bits from the EFI_RNG_PROTOCOL.
> Via this path, the rng is seeded very early during boot with good
> entropy. The ACPI OEM0 table provided in such VMs is an additional
> source of entropy.
> 
> Generation 1 VMs on Hyper-V boot from BIOS. For these VMs, Linux
> doesn't currently get any entropy from the Hyper-V host. While this
> is not fundamentally broken because Linux can generate its own entropy,
> using the Hyper-V host provided entropy would get the rng off to a
> better start and would do so earlier in the boot process.
> 
> Improve the rng seeding for Generation 1 VMs by having Hyper-V specific
> code in Linux take advantage of the OEM0 table to seed the rng. For
> Generation 2 VMs, use the OEM0 table to provide additional entropy
> beyond the EFI_RNG_PROTOCOL. Because the OEM0 table is custom to
> Hyper-V, parse it directly in the Hyper-V code in the Linux kernel
> and use add_bootloader_randomness() to add it to the rng. Once the
> entropy bits are read from OEM0, zero them out in the table so
> they don't appear in /sys/firmware/acpi/tables/OEM0 in the running
> VM. The zero'ing is done out of an abundance of caution to avoid
> potential security risks to the rng. Also set the OEM0 data length
> to zero so a kexec or other subsequent use of the table won't try
> to use the zero'ed bits.
> 
> [1] https://download.microsoft.com/download/1/c/9/1c9813b8-089c-4fef-b2ad-ad80e79403ba/Whitepaper%20-%20The%20Windows%2010%20random%20number%20generation%20infrastructure.pdf
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v3:
> * Removed restriction to just Generation 1 VMs. Generation 2 VMs
>   now also use the additional entropy even though they also get
>   initial entropy via EFI_RNG_PROTOCOL [Jason Donenfeld]
> * Process the OEM0 table on ARM64 systems in addition to x86/x64,
>   as a result of no longer excluding Generation 2 VM.
> * Enlarge the range of entropy byte counts that are considered valid
>   in the OEM0 table. New range is 8 to 4K; previously the range was
>   32 to 256. [Jason Donenfeld]
> * After processing the entropy bits in OEM0, also set the OEM0
>   table length to indicate that the entropy byte count is zero,
>   to prevent a subsequent kexec or other use of the table from
>   trying to use the zero'ed bits. [Jason Donenfeld]
> 
> Changes in v2:
> * Tweaked commit message [Wei Liu]
> * Removed message when OEM0 table isn't found. Added debug-level
>   message when OEM0 is successfully used to add randomness. [Wei Liu]
> 
>  arch/arm64/hyperv/mshyperv.c   |  2 +
>  arch/x86/kernel/cpu/mshyperv.c |  1 +
>  drivers/hv/hv_common.c         | 69 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  2 +
>  4 files changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index f1b8a04ee9f2..c8193cec1b90 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -74,6 +74,8 @@ static int __init hyperv_init(void)
>  		return ret;
>  	}
>  
> +	ms_hyperv_late_init();
> +
>  	hyperv_initialized = true;
>  	return 0;
>  }
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 303fef824167..65c9cbdd2282 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -648,6 +648,7 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
>  	.init.x2apic_available	= ms_hyperv_x2apic_available,
>  	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
>  	.init.init_platform	= ms_hyperv_init_platform,
> +	.init.guest_late_init	= ms_hyperv_late_init,
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
>  	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 0285a74363b3..724de94d885f 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -20,8 +20,11 @@
>  #include <linux/sched/task_stack.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/ptrace.h>
> +#include <linux/random.h>
> +#include <linux/efi.h>
>  #include <linux/kdebug.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/set_memory.h>
> @@ -347,6 +350,72 @@ int __init hv_common_init(void)
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
> +	 * the Hyper-V host in ACPI table OEM0.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ACPI))
> +		return;
> +
> +	status = acpi_get_table("OEM0", 0, &header);
> +	if (ACPI_FAILURE(status) || !header)
> +		return;
> +
> +	/*
> +	 * Since the "OEM0" table name is for OEM specific usage, verify
> +	 * that what we're seeing purports to be from Microsoft.
> +	 */
> +	if (strncmp(header->oem_table_id, "MICROSFT", 8))
> +		goto error;
> +
> +	/*
> +	 * Ensure the length is reasonable. Requiring at least 8 bytes and
> +	 * no more than 4K bytes is somewhat arbitrary and just protects
> +	 * against a malformed table. Hyper-V currently provides 64 bytes,
> +	 * but allow for a change in a later version.
> +	 */
> +	if (header->length < sizeof(*header) + 8 ||
> +	    header->length > sizeof(*header) + SZ_4K> +		goto error;
> +
> +	length = header->length - sizeof(*header);
> +	randomdata = (u8 *)(header + 1);
> +
> +	pr_debug("Hyper-V: Seeding rng with %d random bytes from ACPI table OEM0\n",
> +			length);
> +
> +	add_bootloader_randomness(randomdata, length);
> +
> +	/*
> +	 * To prevent the seed data from being visible in /sys/firmware/acpi,
> +	 * zero out the random data in the ACPI table and fixup the checksum.
> +	 * The zero'ing is done out of an abundance of caution in avoiding
> +	 * potential security risks to the rng. Similarly, reset the table
> +	 * length to just the header size so that a subsequent kexec doesn't
> +	 * try to use the zero'ed out random data.
> +	 */
> +	for (i = 0; i < length; i++) {
> +		header->checksum += randomdata[i];
> +		randomdata[i] = 0;
> +	}
> +
> +	for (i = 0; i < sizeof(header->length); i++)
> +		header->checksum += ((u8 *)&header->length)[i];
> +	header->length = sizeof(*header);
> +	for (i = 0; i < sizeof(header->length); i++)
> +		header->checksum -= ((u8 *)&header->length)[i];
> +
> +error:
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

This patch looks good to me. The code comments were very helpful in explaining
what is going on.

Nuno

