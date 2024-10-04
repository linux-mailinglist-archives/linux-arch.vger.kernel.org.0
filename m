Return-Path: <linux-arch+bounces-7687-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7B69900DE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 12:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B6E1C21386
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C714B061;
	Fri,  4 Oct 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b="KRo6qNI3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.syndicat.com (mail.syndicat.com [62.146.89.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD113F435;
	Fri,  4 Oct 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.89.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037374; cv=none; b=nujVhxMaJo/SSIsZdaP5Lb8UWV6g2lMdCWV4tFDp9Qot+n2m3j3PZWCb4C3MU4TgQ4idSpn0g4BItfFYVS3HlrjXxdI58Y3BYJiY8WvGkKdhmS2HLEkyKpVJpSp4MBzBnVSNR3uWy4ivPYd4A5/IqmbVAyyPdTl9GM5BklGFcuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037374; c=relaxed/simple;
	bh=vdctQ+XdtXjp+LuDNywuKSwzK11nUf6sTcWCnoyJ3PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/XWngEhnMCzloPdW6W2BsuUMFRbidqQd/LrkIvOe3WznyqOhAR8TabQfVooIZ4paVXDfybJ1wneA2Rk+WTTh+D0hbHMVR3loRl6NSnXZ9qqMCETvx2JNXJ8D3KIv+1CDpOd4SWxLc6/d9seopQNETKYHC2/+oCuVXKCHygBagg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com; spf=pass smtp.mailfrom=syndicat.com; dkim=pass (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b=KRo6qNI3; arc=none smtp.client-ip=62.146.89.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syndicat.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=syndicat.com; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:Reply-To:To:From:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gnWmZWCrvdHdUoJIiJKL/ASDqKHG0meBTUeP1jt0FcA=; b=KRo6qNI3wjFiDwcHIdPAV8k+aw
	szdS9o9JhmB0xya0PKnOJ8WvmN2tvDr+xCy7+foV2gOYM0lTL+3N3d1DVkO009N6GW4uY0aqmF8oM
	0V4mmg/NuPiP7imyZ6E/6KchlCO9wg0/c/l53aHzbllk/apjTpjEg0pbMdWzFTe12Ff8=;
Received: from localhost.syndicat.com ([127.0.0.1]:55171 helo=localhost)
	by mail.syndicat.com with esmtp (Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1swfBL-0000iX-2v;
	Fri, 04 Oct 2024 12:05:07 +0200
X-Virus-Scanned: amavisd-new at syndicat.com
Received: from mail.syndicat.com ([127.0.0.1])
	by localhost (mail.syndicat.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9JbcnnV20ida; Fri,  4 Oct 2024 12:05:07 +0200 (CEST)
Received: from [62.89.4.53] (port=53170 helo=gongov.localnet)
	by mail.syndicat.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1swfBL-0003vW-16;
	Fri, 04 Oct 2024 12:05:07 +0200
From: Niels Dettenbach <nd@syndicat.com>
To: Borislav Petkov <bp@alien8.de>
Reply-To: x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Juergen Gross <jgross@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
Date: Fri, 04 Oct 2024 12:05:05 +0200
Message-ID: <864022534.0ifERbkFSE@gongov>
Organization: Syndicat IT&Internet
Disposition-Notification-To: x86@kernel.org
In-Reply-To: <878qv8ypkl.ffs@tglx>
References: <2210883.Icojqenx9y@gongov> <878qv8ypkl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Report-Abuse-To: abuse@syndicat.com (see https://www.syndicat.com/kontakt/kontakte/)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.syndicat.com
X-AntiAbuse: Original Domain - 
X-AntiAbuse: Sender Address Domain - syndicat.com

Virtual machines under Xen Hypervisor (DomU) running in Xen PV mode use a=20
special, nonstandard synthetized CPU topology which "just works" under=20
kernels 6.9.x while newer kernels wrongly assuming a "crash kernel" and=20
disable SMP (reducing to one CPU core) because the newer topology=20
implementation produces a wrong error "[Firmware Bug]: APIC enumeration=20
order not specification compliant" after new topology checks which are=20
improper for Xen PV platform. As a result, the kernel disables SMP and=20
activates just one CPU core within the PV DomU "VM" (DomU in PV mode).

The patch disables the regarding checks if it is running in Xen PV=20
mode (only) and bring back SMP / all CPUs as in the past to such DomU=20
VMs. The Xen subsystem takes care of the proper interaction between "guest"=
=20
(DomU) and the "host" (Dom0).

Signed-off-by: Niels Dettenbach <nd@syndicat.com>

=2D--


The current behaviour leads all of our production Xen Host platforms=20
(amd64 - HPE proliant) unusable after updating to newer linux kernels=20
(with just one CPU available/activated per VM) while older kernels and
other OS (current NetBSD PV DomU) still work fully (and stable since many=20
years on the platform).=20

Xen PV mode is still provided by current Xen and widely used - even=20
if less wide as the newer Xen PVH mode today. So a solution probably=20
will be required and the other exemptions in topology.c seems to support th=
at=20
as well.

So we assume that bug affects stable@vger.kernel.org as well.


dmesg from affected kernel on affected DomU PV:

=2D- snip --
[    0.640364] CPU topo: Enumerated BSP APIC 0 is not marked in APICBASE MSR
[    0.640367] CPU topo: Assuming crash kernel. Limiting to one CPU to=20
prevent machine INIT
[    0.640368] CPU topo: [Firmware Bug]: APIC enumeration order not=20
specification compliant
[    0.640376] CPU topo: Max. logical packages:   1
[    0.640378] CPU topo: Max. logical dies:       1
[    0.640379] CPU topo: Max. dies per package:   1
[    0.640386] CPU topo: Max. threads per core:   1
[    0.640388] CPU topo: Num. cores per package:     1
[    0.640389] CPU topo: Num. threads per package:   1
[    0.640390] CPU topo: Allowing 1 present CPUs plus 0 hotplug CPUs
[    0.640402] Cannot find an available gap in the 32-bit address range
=2D- snap --


after patch applied:
=2D- snip --
[    0.369439] CPU topo: Max. logical packages:   1
[    0.369441] CPU topo: Max. logical dies:       1
[    0.369442] CPU topo: Max. dies per package:   1
[    0.369450] CPU topo: Max. threads per core:   2
[    0.369452] CPU topo: Num. cores per package:     3
[    0.369453] CPU topo: Num. threads per package:   6
[    0.369453] CPU topo: Allowing 6 present CPUs plus 0 hotplug CPUs
=2D- snap --

We tested the patch intensely under productive / high load since 2 weeks no=
w=20
with no issues (no crashes emulated).


references:

arch/x86/kernel/cpu/topology.c
[line 448]
=2D- snip --
        /*
         * XEN PV is special as it does not advertise the local APIC
         * properly, but provides a fake topology for it so that the
         * infrastructure works. So don't apply the restrictions vs. APIC
         * here.
         */
=2D-snap --


Am Dienstag, 1. Oktober 2024, 14:28:58  schrieben Sie:
> Please Cc LKML on such things as docuemnted...
>=20
> On Mon, Sep 30 2024 at 09:43, Niels Dettenbach wrote:
> > Virtual machines under Xen Hypervisor (DomU) running in Xen PV mode use=
 a
> > special, nonstandard synthetized CPU topology which "just works" under
> > kernels 6.9.x while newer kernels wrongly assuming a "crash kernel" and
> > disable SMP (reducing to one CPU core) because the newer topology
> > implementation produces a wrong error "[Firmware Bug]: APIC enumeration
> > order not specification compliant" after new topology checks which are
> > improper for Xen PV platform.
>=20
> Why are they incorrect for XENPV? If the hypervisor exposes a topology
> via CPUID then that topology wants to be correct. Everything else is a
> firmware bug. And no, we are not papering over that.
>=20
> > As a result, the kernel disables SMT and activates just one CPU core
> > within the VM (DomU).
>=20
> I'm not seing how that happens due to the firmware bug issue. That's a
> different problem and has nothing to do with
> topology_register[_boot]_apic().
>=20
> > The patch disables the regarding checks if it is running in Xen PV
> > mode (only) and bring back SMP / all CPUs as in the past to such DomU
> > VMs.
>=20
> So what enumerates the APICs on your systems? Is the topology exposed
> via ACPI? If not, then this can't happen at all.
>=20
> And please report this with LKML cc'ed with the above questions
> answered.

Hi Thomas,

my patch just extends existing exceptions for xen in topology.c

i took the exact inline explanation of my patch from existing (so i assume=
=20
approved) code in topology.c - please have a look (line 449 of arch/x86/
kernel/cpu/topology.c).

xen is "part" of the linux kernel and in PV mode DomU (guest) the xen Dom0=
=20
(=E2=80=9Ehost=E2=80=9C) apic topology is "emulated" by Xen itself in a =E2=
=80=9Enon-standard=E2=80=9C but=20
working structure while Xen in PV DomU takes care of the frontend side. The=
=20
patch only affects this very special constellation / setup.


In production environments different kernel / xen versions typically are us=
ed=20
=2D means: even if the Xen project will =E2=80=9Efix=E2=80=9C / or adapt to=
 that new behaviour=20
of linux kernel, it still breaks compatibility on affected existing Xen (PV=
)=20
productive installations for at least several years.


The >6.9 kernel runs SMP fine if i boot it on the same bare metal of that=20
different HP proliant machines (means instead of booting it as Xen PV guest=
=20
onto a Linux xen Dom0 on that hardware) so the hardwares firmware could not=
=20
be the issue here, while it is affected in Xen DomU VM guests (in PV mode)=
=20
only on different hardware with different (but older) Xen versions / binari=
es=20
(in Xen PV mode only). So from my prospective and as far as i read  the who=
le=20
topology.c (i'm not a skilled kernel developer) which helds several such=20
exemptions from different tests/checks / fnctions this is a (known) Xen=20
specialty.

I know that Xen PV mode gets more succeeded by the newer xen PVHM mode thes=
e=20
days, but PV mode is officially supported by Xen as linux kernel and still=
=20
used in productive scenarios.

see i.e.:=20
https://xen-orchestra.com/blog/xen-virtualization-modes/
https://wiki.xenproject.org/wiki/Understanding_the_Virtualization_Spectrum



many thanks for your time,


niels.




=2D-- linux/arch/x86/kernel/cpu/topology.c.orig   2024-09-11 09:53:16.19409=
5250=20
+0200
+++ linux/arch/x86/kernel/cpu/topology.c        2024-09-30 09:39:11.0413267=
86=20
+0200
@@ -131,6 +131,18 @@ static __init bool check_for_real_bsp(u3
        bool is_bsp =3D false, has_apic_base =3D boot_cpu_data.x86 >=3D 6;
        u64 msr;

+
+        /*
+         * XEN PV is special as it does not advertise the local APIC
+         * properly, but provides a fake topology for it so that the
+         * infrastructure works. So don't apply the restrictions vs. APIC
+         * here.
+         */
+       if (xen_pv_domain()) {
+               topo_info.real_bsp_apic_id =3D topo_info.boot_cpu_apic_id;
+               return false;
+       }
+
        /*
         * There is no real good way to detect whether this a kdump()
         * kernel, but except on the Voyager SMP monstrosity which is not










