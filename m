Return-Path: <linux-arch+bounces-7466-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438098810F
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 11:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEEE286403
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1418E364;
	Fri, 27 Sep 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="VtGT/OA1"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434AE18A959;
	Fri, 27 Sep 2024 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428021; cv=none; b=RH7HXmH54XhHh8fKv96ZY+f01Bd2cDIs+/nahwYQdSTS+IqGlvCBjves/mVBYEisSDpPXEkkXGuDowQrAVJqsap2vVkQ8Zw7icAWXlN5yQuUClbsj71BC7f4ox9GZ4XXi5jIF+TfGc5hS/pigoU2twh7JzESu/FI4VTNKJgX5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428021; c=relaxed/simple;
	bh=Eu20caTVDuYFkjSNbtlsKZAt0thZ1W9gzLCf/RaCc6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vAmaqK7KX8jpbLfYDcOVSFJ53iqWtXoGn8rcb4WIOvWNyLTWcp+rN5kG97mOXsa5h9gn3tzVyVr6lCuCFp+lUvvlKnI9AfWls+U8mcIF12Q70TzguAmO0IoG7qh0wuIDJs3Lak3GLoFxk11lMDaJoAeGMQfPVPC/gfBbCuAb0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=VtGT/OA1; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XeUc6G+ijEKJod2eAolRc/0pDu+4naba5TZ9vLUildU=; t=1727428018; x=1728032818; 
	b=VtGT/OA1B9TATzpKxHZc6QRrY/kCjyitI2Iy9O8Mbt4oWI8z7nDYWzP53EtSOLYx3q1G6XMkkYI
	K1wquzz8XITNK806PlpxPzHf5eG6UtpccWhvt3jPbC2J11VVh6rnOAv+8UPdIKQMBHqk6JPMPmy5o
	Im2abz+NXGHe9B7JtAU8fyBgwfMnibtNc08/63E3MkNGtCb+zp1P9RHMS90uZgAcWTClXKGCrsY3X
	DbEJOze0ZRrPHKpVd/8fM1quHCe4uuvnuFlzjNdW+qqaWt8E0oUBj5JIbK+dkUFvOAraDzj27cHN1
	XJBWwLgjADfW+ENyAXceQKnWJ7MewbXJC3Ug==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1su6w4-00000003BAD-3bb0; Fri, 27 Sep 2024 11:06:48 +0200
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1su6w4-00000001TWj-2adp; Fri, 27 Sep 2024 11:06:48 +0200
Message-ID: <fbc1dde6650a3e729fab57decbb5bf4ef14436ce.camel@physik.fu-berlin.de>
Subject: Re: [PATCH V2 3/3] SH: cpuinfo: Fix a warning for
 CONFIG_CPUMASK_OFFSTACK
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Kexy Biscuit <kexybiscuit@aosc.io>, Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 loongarch@lists.linux.dev, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang
 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 27 Sep 2024 11:06:47 +0200
In-Reply-To: <a45f1209-ff29-4010-b035-921cb136d58d@aosc.io>
References: <20220714084136.570176-1-chenhuacai@loongson.cn>
	 <20220714084136.570176-3-chenhuacai@loongson.cn>
	 <3a5a4bee5c0739a3b988a328376a6eed3c385fda.camel@physik.fu-berlin.de>
	 <CAAhV-H5bw3xcym2-GpyntQEad1h2eB8xDQGwVr_bRRKAOakzoQ@mail.gmail.com>
	 <8947f91ba1a10f98723a5982f0fc13ee589d3bf7.camel@physik.fu-berlin.de>
	 <a45f1209-ff29-4010-b035-921cb136d58d@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Fri, 2024-09-27 at 13:31 +0800, Kexy Biscuit wrote:
> On 3/19/2024 1:12 AM, John Paul Adrian Glaubitz wrote:
> > Hi Hucai,
> >=20
> > On Mon, 2024-03-18 at 22:21 +0800, Huacai Chen wrote:
> > > Hi, SuperH maintainers,
> > >=20
> > > On Wed, Feb 8, 2023 at 8:59=E2=80=AFPM John Paul Adrian Glaubitz
> > > <glaubitz@physik.fu-berlin.de> wrote:
> > > >=20
> > > > On Thu, 2022-07-14 at 16:41 +0800, Huacai Chen wrote:
> > > > > When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS is sel=
ected,
> > > > > cpu_max_bits_warn() generates a runtime warning similar as below =
while
> > > > > we show /proc/cpuinfo. Fix this by using nr_cpu_ids (the runtime =
limit)
> > > > > instead of NR_CPUS to iterate CPUs.
> > > > >=20
> > > > > [    3.052463] ------------[ cut here ]------------
> > > > > [    3.059679] WARNING: CPU: 3 PID: 1 at include/linux/cpumask.h:=
108 show_cpuinfo+0x5e8/0x5f0
> > > > > [    3.070072] Modules linked in: efivarfs autofs4
> > > > > [    3.076257] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19-rc5+ =
#1052
> > > > > [    3.099465] Stack : 9000000100157b08 9000000000f18530 90000000=
00cf846c 9000000100154000
> > > > > [    3.109127]         9000000100157a50 0000000000000000 90000001=
00157a58 9000000000ef7430
> > > > > [    3.118774]         90000001001578e8 0000000000000040 00000000=
00000020 ffffffffffffffff
> > > > > [    3.128412]         0000000000aaaaaa 1ab25f00eec96a37 90000001=
0021de80 900000000101c890
> > > > > [    3.138056]         0000000000000000 0000000000000000 00000000=
00000000 0000000000aaaaaa
> > > > > [    3.147711]         ffff8000339dc220 0000000000000001 00000000=
06ab4000 0000000000000000
> > > > > [    3.157364]         900000000101c998 0000000000000004 90000000=
00ef7430 0000000000000000
> > > > > [    3.167012]         0000000000000009 000000000000006c 00000000=
00000000 0000000000000000
> > > > > [    3.176641]         9000000000d3de08 9000000001639390 90000000=
002086d8 00007ffff0080286
> > > > > [    3.186260]         00000000000000b0 0000000000000004 00000000=
00000000 0000000000071c1c
> > > > > [    3.195868]         ...
> > > > > [    3.199917] Call Trace:
> > > > > [    3.203941] [<90000000002086d8>] show_stack+0x38/0x14c
> > > > > [    3.210666] [<9000000000cf846c>] dump_stack_lvl+0x60/0x88
> > > > > [    3.217625] [<900000000023d268>] __warn+0xd0/0x100
> > > > > [    3.223958] [<9000000000cf3c90>] warn_slowpath_fmt+0x7c/0xcc
> > > > > [    3.231150] [<9000000000210220>] show_cpuinfo+0x5e8/0x5f0
> > > > > [    3.238080] [<90000000004f578c>] seq_read_iter+0x354/0x4b4
> > > > > [    3.245098] [<90000000004c2e90>] new_sync_read+0x17c/0x1c4
> > > > > [    3.252114] [<90000000004c5174>] vfs_read+0x138/0x1d0
> > > > > [    3.258694] [<90000000004c55f8>] ksys_read+0x70/0x100
> > > > > [    3.265265] [<9000000000cfde9c>] do_syscall+0x7c/0x94
> > > > > [    3.271820] [<9000000000202fe4>] handle_syscall+0xc4/0x160
> > > > > [    3.281824] ---[ end trace 8b484262b4b8c24c ]---
> > > > >=20
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > ---
> > > > >   arch/sh/kernel/cpu/proc.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.=
c
> > > > > index a306bcd6b341..5f6d0e827bae 100644
> > > > > --- a/arch/sh/kernel/cpu/proc.c
> > > > > +++ b/arch/sh/kernel/cpu/proc.c
> > > > > @@ -132,7 +132,7 @@ static int show_cpuinfo(struct seq_file *m, v=
oid *v)
> > > > >=20
> > > > >   static void *c_start(struct seq_file *m, loff_t *pos)
> > > > >   {
> > > > > -     return *pos < NR_CPUS ? cpu_data + *pos : NULL;
> > > > > +     return *pos < nr_cpu_ids ? cpu_data + *pos : NULL;
> > > > >   }
> > > > >   static void *c_next(struct seq_file *m, void *v, loff_t *pos)
> > > > >   {
> > > >=20
> > > > I build-tested the patch and also booted the patched kernel success=
fully
> > > > on my SH-7785LCR board.
> > > >=20
> > > > Showing the contents of /proc/cpuinfo works fine, too:
> > > >=20
> > > > root@tirpitz:~> cat /proc/cpuinfo
> > > > machine         : SH7785LCR
> > > > processor       : 0
> > > > cpu family      : sh4a
> > > > cpu type        : SH7785
> > > > cut             : 7.x
> > > > cpu flags       : fpu perfctr llsc
> > > > cache type      : split (harvard)
> > > > icache size     : 32KiB (4-way)
> > > > dcache size     : 32KiB (4-way)
> > > > address sizes   : 32 bits physical
> > > > bogomips        : 599.99
> > > > root@tirpitz:~>
> > > >=20
> > > > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > >=20
> > > > I am not sure yet whether the change is also correct as I don't kno=
w whether
> > > > it's possible to change the number of CPUs at runtime on SuperH.
> > > Can this patch be merged? This is the only one still unmerged in the
> > > whole series.
> >=20
> > Thanks for the reminder. I will pick it up for 6.10.
> >=20
> > Got sick this week, so I can't pick up anymore patches for 6.9 and will=
 just
> > send Linus a PR later this week.
> >=20
> > Adrian
> >=20
>=20
> Gentle ping on this, can we get this patch merged into 6.12?

Thanks a lot for the reminder. Since the merge window is about to close, I'=
ll
pick this up for 6.13 as it hasn't been reviewed yet from what I can see.

I will definitely pick it up for 6.13 and I'm sorry for the very long delay=
.

However, when this patch got posted back then, I wasn't a kernel maintainer=
 yet.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

