Return-Path: <linux-arch+bounces-5518-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D185937889
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 15:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13311C21051
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDAC13C679;
	Fri, 19 Jul 2024 13:33:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE71E489;
	Fri, 19 Jul 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396036; cv=none; b=WS8gSMtt4N9taxJNKdSjzsv7zYv9OaBGvW8K2biUjzOYuFLDcdxnpAMqPGix4xPVCbMV7Dsa5D6yg5VI/oJqU8U1VFVDty+UbgEKJqLNXiX11fM+GoBB6bNF6RnVPtFDz54lCPR7vwXsta3mm0cyrg7mulGnHCavzaAQdWQ//Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396036; c=relaxed/simple;
	bh=QcL5agAg50dx73nvzJdxQZPBrGmrIB51uy787OOzoi4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEtztCKep4jZOFziTHPqVObxw1G+a/639mENYrg4XbPZT3wYhcAhlxLOD1aNFx9TRADjPYLAxsjUJG/AA2Iqx3cZAiZ66rIBI7ei2jeoe+4vW1J1jWWhpv217F1Mk9cs4oYdJpMSYJvoTCnJ5Sxd/Dqo8CNRpjgCTJKEwom15Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WQVw90sR6z6JBj4;
	Fri, 19 Jul 2024 21:32:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D842140A87;
	Fri, 19 Jul 2024 21:33:49 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 19 Jul
 2024 14:33:48 +0100
Date: Fri, 19 Jul 2024 14:33:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "Borislav
 Petkov" <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand
	<david@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens
	<hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "John Paul Adrian
 Glaubitz" <glaubitz@physik.fu-berlin.de>, Michael Ellerman
	<mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon
	<will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH 00/17] mm: introduce numa_memblks
Message-ID: <20240719143347.000077d9@huawei.com>
In-Reply-To: <20240716111346.3676969-1-rppt@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 16 Jul 2024 14:13:29 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>=20
> Hi,
>=20
> Following the discussion about handling of CXL fixed memory windows on
> arm64 [1] I decided to bite the bullet and move numa_memblks from x86 to
> the generic code so they will be available on arm64/riscv and maybe on
> loongarch sometime later.
>=20
> While it could be possible to use memblock to describe CXL memory windows,
> it currently lacks notion of unpopulated memory ranges and numa_memblks
> does implement this.
>=20
> Another reason to make numa_memblks generic is that both arch_numa (arm64
> and riscv) and loongarch use trimmed copy of x86 code although there is no
> fundamental reason why the same code cannot be used on all these platform=
s.
> Having numa_memblks in mm/ will make it's interaction with ACPI and FDT
> more consistent and I believe will reduce maintenance burden.
>=20
> And with generic numa_memblks it is (almost) straightforward to enable NU=
MA
> emulation on arm64 and riscv.
>=20
> The first 5 commits in this series are cleanups that are not strictly
> related to numa_memblks.
>=20
> Commits 6-11 slightly reorder code in x86 to allow extracting numa_memblks
> and NUMA emulation to the generic code.
>=20
> Commits 12-14 actually move the code from arch/x86/ to mm/ and commit 15
> does some aftermath cleanups.
>=20
> Commit 16 switches arch_numa to numa_memblks.
>=20
> Commit 17 enables usage of phys_to_target_node() and
> memory_add_physaddr_to_nid() with numa_memblks.

Hi Mike,

I've lightly tested with emulated CXL + Generic Ports and Generic
Initiators as well as more normal cpus and memory via qemu on arm64 and it's
looking good.

=46rom my earlier series, patch 4 is probably still needed to avoid
presenting nodes with nothing in them at boot (but not if we hotplug
memory then remove it again in which case they disappear)
https://lore.kernel.org/all/20240529171236.32002-5-Jonathan.Cameron@huawei.=
com/
However that was broken/inconsistent before your rework so I can send that
patch separately.=20

Thanks for getting this sorted!  I should get time to do more extensive
testing and review in next week or so.

Jonathan

>=20
> [1] https://lore.kernel.org/all/20240529171236.32002-1-Jonathan.Cameron@h=
uawei.com/
>=20
> Mike Rapoport (Microsoft) (17):
>   mm: move kernel/numa.c to mm/
>   MIPS: sgi-ip27: make NODE_DATA() the same as on all other
>     architectures
>   MIPS: loongson64: rename __node_data to node_data
>   arch, mm: move definition of node_data to generic code
>   arch, mm: pull out allocation of NODE_DATA to generic code
>   x86/numa: simplify numa_distance allocation
>   x86/numa: move FAKE_NODE_* defines to numa_emu
>   x86/numa_emu: simplify allocation of phys_dist
>   x86/numa_emu: split __apicid_to_node update to a helper function
>   x86/numa_emu: use a helper function to get MAX_DMA32_PFN
>   x86/numa: numa_{add,remove}_cpu: make cpu parameter unsigned
>   mm: introduce numa_memblks
>   mm: move numa_distance and related code from x86 to numa_memblks
>   mm: introduce numa_emulation
>   mm: make numa_memblks more self-contained
>   arch_numa: switch over to numa_memblks
>   mm: make range-to-target_node lookup facility a part of numa_memblks
>=20
>  arch/arm64/include/asm/Kbuild                 |   1 +
>  arch/arm64/include/asm/mmzone.h               |  13 -
>  arch/arm64/include/asm/topology.h             |   1 +
>  arch/loongarch/include/asm/Kbuild             |   1 +
>  arch/loongarch/include/asm/mmzone.h           |  16 -
>  arch/loongarch/include/asm/topology.h         |   1 +
>  arch/loongarch/kernel/numa.c                  |  21 -
>  arch/mips/include/asm/mach-ip27/mmzone.h      |   1 -
>  .../mips/include/asm/mach-loongson64/mmzone.h |   4 -
>  arch/mips/loongson64/numa.c                   |  20 +-
>  arch/mips/sgi-ip27/ip27-memory.c              |   2 +-
>  arch/powerpc/include/asm/mmzone.h             |   6 -
>  arch/powerpc/mm/numa.c                        |  26 +-
>  arch/riscv/include/asm/Kbuild                 |   1 +
>  arch/riscv/include/asm/mmzone.h               |  13 -
>  arch/riscv/include/asm/topology.h             |   4 +
>  arch/s390/include/asm/Kbuild                  |   1 +
>  arch/s390/include/asm/mmzone.h                |  17 -
>  arch/s390/kernel/numa.c                       |   3 -
>  arch/sh/include/asm/mmzone.h                  |   3 -
>  arch/sh/mm/init.c                             |   7 +-
>  arch/sh/mm/numa.c                             |   3 -
>  arch/sparc/include/asm/mmzone.h               |   4 -
>  arch/sparc/mm/init_64.c                       |  11 +-
>  arch/x86/Kconfig                              |   9 +-
>  arch/x86/include/asm/Kbuild                   |   1 +
>  arch/x86/include/asm/mmzone.h                 |   6 -
>  arch/x86/include/asm/mmzone_32.h              |  17 -
>  arch/x86/include/asm/mmzone_64.h              |  18 -
>  arch/x86/include/asm/numa.h                   |  24 +-
>  arch/x86/include/asm/sparsemem.h              |   9 -
>  arch/x86/mm/Makefile                          |   1 -
>  arch/x86/mm/amdtopology.c                     |   1 +
>  arch/x86/mm/numa.c                            | 618 +-----------------
>  arch/x86/mm/numa_internal.h                   |  24 -
>  drivers/acpi/numa/srat.c                      |   1 +
>  drivers/base/Kconfig                          |   1 +
>  drivers/base/arch_numa.c                      | 223 ++-----
>  drivers/cxl/Kconfig                           |   2 +-
>  drivers/dax/Kconfig                           |   2 +-
>  drivers/of/of_numa.c                          |   1 +
>  include/asm-generic/mmzone.h                  |   5 +
>  include/asm-generic/numa.h                    |   6 +-
>  include/linux/numa.h                          |   5 +
>  include/linux/numa_memblks.h                  |  58 ++
>  kernel/Makefile                               |   1 -
>  kernel/numa.c                                 |  26 -
>  mm/Kconfig                                    |  11 +
>  mm/Makefile                                   |   3 +
>  mm/numa.c                                     |  57 ++
>  {arch/x86/mm =3D> mm}/numa_emulation.c          |  42 +-
>  mm/numa_memblks.c                             | 565 ++++++++++++++++
>  52 files changed, 847 insertions(+), 1070 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/mmzone.h
>  delete mode 100644 arch/loongarch/include/asm/mmzone.h
>  delete mode 100644 arch/riscv/include/asm/mmzone.h
>  delete mode 100644 arch/s390/include/asm/mmzone.h
>  delete mode 100644 arch/x86/include/asm/mmzone.h
>  delete mode 100644 arch/x86/include/asm/mmzone_32.h
>  delete mode 100644 arch/x86/include/asm/mmzone_64.h
>  create mode 100644 include/asm-generic/mmzone.h
>  create mode 100644 include/linux/numa_memblks.h
>  delete mode 100644 kernel/numa.c
>  create mode 100644 mm/numa.c
>  rename {arch/x86/mm =3D> mm}/numa_emulation.c (94%)
>  create mode 100644 mm/numa_memblks.c
>=20
>=20
> base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826


