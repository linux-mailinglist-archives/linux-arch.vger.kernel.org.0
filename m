Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8A6299664
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 20:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1791416AbgJZTCz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 15:02:55 -0400
Received: from foss.arm.com ([217.140.110.172]:49680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1791414AbgJZTCy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 15:02:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D873139F;
        Mon, 26 Oct 2020 12:02:54 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F22CC3F66E;
        Mon, 26 Oct 2020 12:02:52 -0700 (PDT)
Date:   Mon, 26 Oct 2020 19:02:50 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201026190250.aktgow74haieek7v@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021144112.GA17912@willie-the-truck>
 <20201022134752.wtcdkbi4fjn2blh6@e107158-lin>
 <20201022135559.GB1788090@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022135559.GB1788090@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/22/20 15:55, Greg Kroah-Hartman wrote:
> On Thu, Oct 22, 2020 at 02:47:52PM +0100, Qais Yousef wrote:
> > On 10/21/20 15:41, Will Deacon wrote:
> > > > We already expose MIDR and REVIDR via the current sysfs interface. We
> > > > can expand it to include _all_ the other ID_* regs currently available
> > > > to user via the MRS emulation and we won't have to debate what a new
> > > > interface would look like. The MRS emulation and the sysfs info should
> > > > probably match, though that means we need to expose the
> > > > ID_AA64PFR0_EL1.EL0 field which we currently don't.
> > > > 
> > > > I do agree that an AArch32 cpumask is an easier option both from the
> > > > kernel implementation perspective and from the application usability
> > > > one, though not as easy as automatic task placement by the scheduler (my
> > > > first preference, followed by the id_* regs and the aarch32 mask, though
> > > > not a strong preference for any).
> > > 
> > > If a cpumask is easier to implement and easier to use, then I think that's
> > > what we should do. It's also then dead easy to disable if necessary by
> > > just returning 0. The only alternative I would prefer is not having to
> > > expose this information altogether, but I'm not sure that figuring this
> > > out from MIDR/REVIDR alone is reliable.
> > 
> > So the mask idea is about adding a new
> > 
> > 	/sys/devices/system/cpu/aarch32_cpus
> > 
> > ?
> 
> Is this a file, a directory, or what?  What's the contents?
> 
> Without any of that, I have no idea if it's "ok" or not...

Hopefully the below patch explains better. Note that I added the new attribute
to driver/base/cpu.c, but assuming we will still want to go down this route, we
will need a generic way for archs to add their attributes to
/sys/devices/system/cpu/.

Something like having a special define for archs to append their own
attributes list

	#define SYSFS_SYSTEM_CPU_ARCH_ATTRIBUTES

Or probably there's a way to add this file (attribute) dynamically from arch
code that I just didn't figure out how to do yet.

Thanks

--
Qais Yousef


---------->8------------

From 96dfdfdacb2a26a60ba19051e8c72e839eb5408b Mon Sep 17 00:00:00 2001
From: Qais Yousef <qais.yousef@arm.com>
Date: Mon, 26 Oct 2020 16:33:32 +0000
Subject: [PATCH] arm64: export aarch32_online mask in sysfs

This patch to be applied on top of arm64 Asymmetric AArch32 support.

It explores the option of exporting the AArch32 capable cpus as a mask
on sysfs.

This is to help drive the discussion on the API before sending the next
version which I yet to address some of the review comments.

The output looks like:

	# cat /sys/devices/system/cpu/aarch32_online
	0-5

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  7 +++++++
 arch/arm64/include/asm/cpufeature.h                |  2 ++
 arch/arm64/kernel/cpufeature.c                     |  8 ++++++++
 drivers/base/cpu.c                                 | 12 ++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index b555df825447..9ccb5c3f5ee3 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -36,6 +36,13 @@ Description:	CPU topology files that describe kernel limits related to
 
 		See Documentation/admin-guide/cputopology.rst for more information.
 
+What:		/sys/devices/system/cpu/aarch32_online
+Date:		October 2020
+Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
+Description:	CPU topology file that describes which cpus support AArch32 at
+		EL0. Only available on arm64.
+
+		The value is updated when a cpu becomes online then sticks.
 
 What:		/sys/devices/system/cpu/probe
 		/sys/devices/system/cpu/release
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 2b87f17b2bd4..edd18002ad81 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -380,6 +380,8 @@ cpucap_multi_entry_cap_matches(const struct arm64_cpu_capabilities *entry,
 	return false;
 }
 
+extern cpumask_t aarch32_el0_mask;
+
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0f7307c8ad80..662bbc2b15cd 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1723,6 +1723,13 @@ cpucap_panic_on_conflict(const struct arm64_cpu_capabilities *cap)
 	return !!(cap->type & ARM64_CPUCAP_PANIC_ON_CONFLICT);
 }
 
+cpumask_t aarch32_el0_mask;
+static void cpu_enable_aarch32_el0(struct arm64_cpu_capabilities const *cap)
+{
+	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU))
+		cpumask_set_cpu(smp_processor_id(), &aarch32_el0_mask);
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1809,6 +1816,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.capability = ARM64_HAS_ASYM_32BIT_EL0,
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		.cpu_enable = cpu_enable_aarch32_el0,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index d2136ab9b14a..569baacde508 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -459,6 +459,15 @@ EXPORT_SYMBOL_GPL(cpu_device_create);
 static DEVICE_ATTR(modalias, 0444, print_cpu_modalias, NULL);
 #endif
 
+#ifdef CONFIG_ARM64
+static ssize_t print_aarch32_online(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &aarch32_el0_mask);
+}
+static DEVICE_ATTR(aarch32_online, 0444, print_aarch32_online, NULL);
+#endif
+
 static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 	&dev_attr_probe.attr,
@@ -475,6 +484,9 @@ static struct attribute *cpu_root_attrs[] = {
 #endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
+#endif
+#ifdef CONFIG_ARM64
+	&dev_attr_aarch32_online.attr,
 #endif
 	NULL
 };
-- 
2.25.1

