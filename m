Return-Path: <linux-arch+bounces-5200-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB391C53F
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 19:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D1A1C236E3
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8391CB33D;
	Fri, 28 Jun 2024 17:56:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18815253B;
	Fri, 28 Jun 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597399; cv=none; b=Af22rg3dW6eqT0hnSs8A4eez5iLFqpxuBjF4FSfgPLIxJag83nvTsLCZF4l7AcVA0a30tRr4N9kqbZPvTVnjBpF9kJ4j35DgAGNdTpkprjaeU0YYF4HslikjLJPpsZjzJoYjvQ4/zITU3ho66fs6YY0bzvs/jDrlTve2ruDOgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597399; c=relaxed/simple;
	bh=oYS7jmYESQRNo05AqB51F3nXEy6uK/Kv0yx6spSKe/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aq7n43jp/31Fjqz7YX1+eij7oNbVxTwbSGkpgiQj6vRbXaJxknUzd6rujOORRwUWrTLfaWU4GbY3gEhpKlcvSxxGmWsEKs6EsA6FDBpVqvDZuRR/7UJ7rz4F7JTQmIMdRaF7U9RiS9HOktj23D6ead7gEBDeV2LW+SG6TNpNEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8572C116B1;
	Fri, 28 Jun 2024 17:56:33 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	loongarch@lists.linux.dev,
	x86@kernel.org,
	Russell King <linux@armlinux.org.uk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Luis <miguel.luis@oracle.com>,
	James Morse <james.morse@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linuxarm@huawei.com,
	justin.he@arm.com,
	jianyong.wu@arm.com
Subject: Re: [PATCH v10 00/19] ACPI/arm64: add support for virtual cpu hotplug
Date: Fri, 28 Jun 2024 18:56:31 +0100
Message-Id: <171959723432.44645.7883276197359651212.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 29 May 2024 14:34:27 +0100, Jonathan Cameron wrote:
> v10:
> - Make acpi_processor_set_per_cpu() return 0 / error rather than bool
>   to simplify error handling at the call sites.
>   (Thanks to both Rafael and Gavin who commented on this)
> - Gather tags.
> - Rebase on v6.10-rc1
> 
> [...]

Applied to arm64 (for-next/vcpu-hotplug), thanks! If nothing falls
apart, it should end up in mainline for 6.11.

Thomas, the GICv3 patches have been acked by Marc but they are missing
your ack. If you want it added, I can refresh the series in the next day
or so, otherwise the branch should remain stable. Thanks.

[01/19] ACPI: processor: Simplify initial onlining to use same path for cold and hotplug
        https://git.kernel.org/arm64/c/c1385c1f0ba3
[02/19] cpu: Do not warn on arch_register_cpu() returning -EPROBE_DEFER
        https://git.kernel.org/arm64/c/d830ef3ac569
[03/19] ACPI: processor: Drop duplicated check on _STA (enabled + present)
        https://git.kernel.org/arm64/c/157080f03c7a
[04/19] ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()
        https://git.kernel.org/arm64/c/fadf231f0a06
[05/19] ACPI: processor: Fix memory leaks in error paths of processor_add()
        https://git.kernel.org/arm64/c/47ec9b417ed9
[06/19] ACPI: processor: Move checks and availability of acpi_processor earlier
        https://git.kernel.org/arm64/c/cd9239660b8c
[07/19] ACPI: processor: Add acpi_get_processor_handle() helper
        https://git.kernel.org/arm64/c/36b921637e90
[08/19] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
        https://git.kernel.org/arm64/c/b398a91decd9
[09/19] ACPI: scan: switch to flags for acpi_scan_check_and_detach()
        https://git.kernel.org/arm64/c/1859a671bdb9
[10/19] ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
        https://git.kernel.org/arm64/c/3b9d0a78aeda
[11/19] arm64: acpi: Move get_cpu_for_acpi_id() to a header
        https://git.kernel.org/arm64/c/8d34b6f17b9a
[12/19] arm64: acpi: Harden get_cpu_for_acpi_id() against missing CPU entry
        https://git.kernel.org/arm64/c/2488444274c7
[13/19] irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
        https://git.kernel.org/arm64/c/fa2dabe57220
[14/19] irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs
        https://git.kernel.org/arm64/c/d633da5d3ab1
[15/19] arm64: psci: Ignore DENIED CPUs
        https://git.kernel.org/arm64/c/643e12da4a49
[16/19] arm64: arch_register_cpu() variant to check if an ACPI handle is now available.
        https://git.kernel.org/arm64/c/eba4675008a6
[17/19] arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI_PROCESSOR is enabled.
        https://git.kernel.org/arm64/c/9d0873892f4d
[18/19] arm64: document virtual CPU hotplug's expectations
        https://git.kernel.org/arm64/c/828ce929d1c3
[19/19] cpumask: Add enabled cpumask for present CPUs that can be brought online
        https://git.kernel.org/arm64/c/4e1a7df45480

-- 
Catalin


