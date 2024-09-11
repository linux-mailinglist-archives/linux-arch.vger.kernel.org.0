Return-Path: <linux-arch+bounces-7204-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F8974D90
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 10:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5472C287131
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD78186E53;
	Wed, 11 Sep 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b="J3QNnlT9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.syndicat.com (mail.syndicat.com [62.146.89.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08360186617;
	Wed, 11 Sep 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.89.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044817; cv=none; b=nYiDUPoKF0SylnHATjp1UiDlbYDU7lwOu8S8fzXzp28Of2Ax87QVQx5jW5XC5QtWsh10oV9JptIxGH9LakrIOxuPcZWbEIboMVPbxztJLIYt6fJiWtem0etcp++7YFZV6Hc2haU7PEaLrl3HSsvf0bd1ckjv4CFAyjtzBqDeX0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044817; c=relaxed/simple;
	bh=AFjFLDnq/+lP0SuwMkKNtX86bZmCxqHOAJ/cSvALlBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hQyDLHNIQDMfW+PrS0gSFoAorEr9S7RVLJS8fc+05iDxcObryG2KQy4uwA3GYnlbzNatgdZseRDQ5qCviGPlt+R/Zxd9RIjghthxiIjmV2vK5tDzl5fSn4BaTpy/JoSAMNun2dLExeYPeX8T1dz5rd2EfNnP/UOvqUnW5RzcKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com; spf=pass smtp.mailfrom=syndicat.com; dkim=pass (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b=J3QNnlT9; arc=none smtp.client-ip=62.146.89.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syndicat.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=syndicat.com; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DFhocolaymN+nqIRd1rb2UPYdFMXFFDHYqqmrIgDEWE=; b=J3QNnlT98CH++fdZOijRecXe2P
	MfdLNWCCXx7UjzMVmXmxaacpWHUldmGJnFnCZacSEG9PT4suu0IYm02Y9r/QL2GkOfNOHhOgFQReu
	ALu3Zk7D5WX5zFmd30eg2WU0BfcyQhwN0+7z5tccuHDQbRy6p6vsAGP85Iu/c3opampM=;
Received: from localhost.syndicat.com ([127.0.0.1]:61271 helo=localhost)
	by mail.syndicat.com with esmtp (Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1soJ6R-0007IG-2D;
	Wed, 11 Sep 2024 10:53:31 +0200
X-Virus-Scanned: amavisd-new at syndicat.com
Received: from mail.syndicat.com ([127.0.0.1])
	by localhost (mail.syndicat.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JHSj0EFsB1tc; Wed, 11 Sep 2024 10:53:31 +0200 (CEST)
Received: from p579493d3.dip0.t-ipconnect.de ([87.148.147.211]:40790 helo=gongov.localnet)
	by mail.syndicat.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1soJ6R-00012U-0h;
	Wed, 11 Sep 2024 10:53:31 +0200
From: Niels Dettenbach <nd@syndicat.com>
To: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org, trivial@kernel.org
Subject: [PATCH 1/1] x86: SMT broken on Xen PV DomU since 6.9
Date: Wed, 11 Sep 2024 10:53:30 +0200
Message-ID: <4242435.1IzOArtZ34@gongov>
Organization: Syndicat IT&Internet
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Report-Abuse-To: abuse@syndicat.com (see https://www.syndicat.com/kontakt/kontakte/)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.syndicat.com
X-AntiAbuse: Original Domain - 
X-AntiAbuse: Sender Address Domain - syndicat.com

virtual machines under Xen Hypervisor (DomU) running in Xen PV mode use a 
special, nonstandard synthetized CPU topology which "just works" under 
kernels 6.9.x while newer kernels assuming a "crash kernel" and disable 
SMT (reducing to one CPU core) because the newer topology implementation 
produces a wrong error "[Firmware Bug]: APIC enumeration order not 
specification compliant" after new topology checks which are improper for 
Xen PV platform. As a result, the kernel disables SMT and activates just 
one CPU core within the VM (DomU).

The patch disables the regarding checks if it is running in Xen PV 
mode (only) and bring back SMT / all CPUs as in the past to such DomU 
VMs.

Signed-off-by: Niels Dettenbach <nd@syndicat.com>

---


The current behaviour leads all of our production Xen Host platforms 
unusable after updating to newer linux kernels (with just one CPU 
available/activated per VM) while older kernels other OS still work 
fully (and stable since many years on the platform). 

Xen PV mode is still provided by current Xen and widely used - even 
if less wide as the newer Xen PVH mode today. So a solution probably 
will be required.

So we assume that bug affects stable@vger.kernel.org as well.


dmesg from affected kernel:

-- snip --
Sep 10 14:35:50 ffm1 kernel: [    0.640364] CPU topo: Enumerated BSP APIC 0 is not marked in APICBASE MSR
Sep 10 14:35:50 ffm1 kernel: [    0.640367] CPU topo: Assuming crash kernel. Limiting to one CPU to prevent machine INIT
Sep 10 14:35:50 ffm1 kernel: [    0.640368] CPU topo: [Firmware Bug]: APIC enumeration order not specification compliant
Sep 10 14:35:50 ffm1 kernel: [    0.640376] CPU topo: Max. logical packages:   1
Sep 10 14:35:50 ffm1 kernel: [    0.640378] CPU topo: Max. logical dies:       1
Sep 10 14:35:50 ffm1 kernel: [    0.640379] CPU topo: Max. dies per package:   1
Sep 10 14:35:50 ffm1 kernel: [    0.640386] CPU topo: Max. threads per core:   1
Sep 10 14:35:50 ffm1 kernel: [    0.640388] CPU topo: Num. cores per package:     1
Sep 10 14:35:50 ffm1 kernel: [    0.640389] CPU topo: Num. threads per package:   1
Sep 10 14:35:50 ffm1 kernel: [    0.640390] CPU topo: Allowing 1 present CPUs plus 0 hotplug CPUs
Sep 10 14:35:50 ffm1 kernel: [    0.640402] Cannot find an available gap in the 32-bit address range
-- snap --

We tested the patch intensely under productive / high load since 2 days now with no issues.


references:
arch/x86/kernel/cpu/topology.c
[line 448]
--- snip ---
        /*
         * XEN PV is special as it does not advertise the local APIC
         * properly, but provides a fake topology for it so that the
         * infrastructure works. So don't apply the restrictions vs. APIC
         * here.
         */
---snap ---

Related errors / tickets:
https://forum.qubes-os.org/t/fedora-sees-only-1-cpu-core-after-updating-the-kernel-to-6-9-x/27205/5






--- linux/arch/x86/kernel/cpu/topology.c.orig   2024-09-11 09:53:16.194095250 +0200
+++ linux/arch/x86/kernel/cpu/topology.c        2024-09-11 09:55:17.338448094 +0200
@@ -158,7 +158,7 @@ static __init bool check_for_real_bsp(u3
                is_bsp = !!(msr & MSR_IA32_APICBASE_BSP);
        }

-       if (apic_id == topo_info.boot_cpu_apic_id) {
+       if (!xen_pv_domain() && apic_id == topo_info.boot_cpu_apic_id) {
                /*
                 * If the boot CPU has the APIC BSP bit set then the
                 * firmware enumeration is agreeing. If the CPU does not
@@ -185,7 +185,7 @@ static __init bool check_for_real_bsp(u3
        pr_warn("Boot CPU APIC ID not the first enumerated APIC ID: %x != %x\n",
                topo_info.boot_cpu_apic_id, apic_id);

-       if (is_bsp) {
+       if (!xen_pv_domain() && is_bsp) {
                /*
                 * The boot CPU has the APIC BSP bit set. Use it and complain
                 * about the broken firmware enumeration.







