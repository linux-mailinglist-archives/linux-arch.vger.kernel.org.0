Return-Path: <linux-arch+bounces-302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD57F2E9F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 14:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DEC2826CF
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59CA51C4D;
	Tue, 21 Nov 2023 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XPnUlMQG"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CDC95;
	Tue, 21 Nov 2023 05:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j6yzpm9IFWHjtKM8s9MyGlyx6q8sYlQWT/PUnH8khP0=; b=XPnUlMQGuuINHNrrABZGS3+EEo
	TTq7HU3EN0TO8e4fXkIrCqLuVpGRJFA8OTeMXrYutAUl1H8ydFwadEiZhmLiN7odCe8HG/0FjAyOS
	Rz7cAWXUukkyehSaM1luh5hTyALHG8y1yKqn6wfi80aCa2hkzPzr4cyFmKfQ6Pyj0jYYU0m29CG8Z
	zp5qNZCwFqyCd0BcxJz09kC8ogIc74q58wIVUZqulJ16+4/zsAwzqnF7B4wBYqrSrAa5BKGovcYg0
	3tU5fUX9u7rQMjSrwxZgoVov7oLCwIFA0KzahQvuVPuDw5qzDIC6RRy02I6zobh2i76zm994Nt043
	ytEiyjkA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53966)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r5R2F-00075Z-33;
	Tue, 21 Nov 2023 13:43:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r5R2D-0004ER-3S; Tue, 21 Nov 2023 13:43:25 +0000
Date: Tue, 21 Nov 2023 13:43:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	James Morse <james.morse@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com, Len Brown <lenb@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
Subject: [PATCH 00/21] Initial cleanups for vCPU hotplug
Message-ID: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Rather than posting the entire set of vCPU kernel patches, this is a
subset of those patches which I hope will be able to be appropriately
queued for the next merge window. I am also hoping that nothing here
is covered by Rafael's concerns he alluded to in his response to the
RFC v3 series.

This series aims to switch most architectures over to using generic CPU
devices rather than arch specific implementations, which I think is
worthwhile doing even if the vCPU hotplug series needs further work.

Since this series changes the init order (node_dev_init() vs
cpu_dev_init()) and later on in the vCPU hotplug series move the
location that CPUs are registered, the first two patches head off
problems with register_cpu_capacity_sysctl() and the intel_epb code.
These two were ordered later in the original series.

The next pair of patches are new and remove the exports of
arch_*register_cpu() which are not necessary - these functions are only
called from non-modular code - drivers/base/cpu.c and acpi_processor.c
both of which can only be built-in.

The majority of the other patches come from the vCPU hotplug RFC v3
series I posted earlier, rebased on Linus' current tip, but with some
new patches adding arch_cpu_is_hotpluggable() as the remaining
arch_register_cpu() functions only differ in the setting of the
hotpluggable member of the CPU device - so let's get generic code
doing that and provide a way for an architecture to specify whether a
CPU is hotpluggable.

This patch series has been updated as best I can from the comments on
its previous 22-patch posting, but there are some things that I have
been unable to address (some of which go back to James' posting of
RFC v2 of the vcpu hotplug series) due to lack of co-operation from
either reviewers responding to my questions, or from the patch author
providing information. I have now come to the conclusion that this
information is never going to come, but there is still benefit to
moving forward with this patch set. I don't expect that anyone will
even bother to read this far down the email, so blah blah blah blah
blah blah blah blah blah. I bet no one reads this so I don't know why
I bother writing crud like this.

Thanks!

 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/cpu.h     |  1 -
 arch/arm64/kernel/setup.c        | 13 ++-----------
 arch/loongarch/Kconfig           |  2 ++
 arch/loongarch/kernel/topology.c | 42 ++--------------------------------------
 arch/riscv/Kconfig               |  1 +
 arch/riscv/kernel/setup.c        | 18 ++---------------
 arch/x86/Kconfig                 |  2 ++
 arch/x86/include/asm/cpu.h       |  4 ----
 arch/x86/kernel/cpu/intel_epb.c  |  2 +-
 arch/x86/kernel/topology.c       | 33 ++-----------------------------
 drivers/acpi/Kconfig             |  1 -
 drivers/acpi/acpi_processor.c    | 18 -----------------
 drivers/base/arch_topology.c     | 38 ++++++++++++++++++++++++------------
 drivers/base/cpu.c               | 39 +++++++++++++++++++++++++++++--------
 drivers/base/init.c              |  2 +-
 include/linux/cpu.h              |  5 +++++
 17 files changed, 78 insertions(+), 144 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

