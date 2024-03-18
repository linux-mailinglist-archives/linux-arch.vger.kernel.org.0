Return-Path: <linux-arch+bounces-3025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C44487EE8E
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 18:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27247281781
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9A654FAF;
	Mon, 18 Mar 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="PwxAXigj"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3054F96;
	Mon, 18 Mar 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782199; cv=none; b=MNYFrrZ/rCjcdnvFBfHjb+RwClmUP9+nnX6vtP7uQtGWFua2w3TTc43OoNlWrYoSSHIliMzRoa+aEbLfjrJjIIKK/PM3Qz9y+pSy4fZvnbauxLM6TDg6YH+dgPvmdmzBMghFsYwquP2u4ba8828Jvv1mi5Ofzl69bIM+c+Elc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782199; c=relaxed/simple;
	bh=ZJ0Yl89U9llZ0p0C+sMdlprx7w/Tc3XWYJKBs/3ywLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jsFY9i7TUp21TzJSIUPNfExlasjJdMGxsLncvNKFM+MeWmVpwcDZ6j31uuhUXEdb8U/fRTFy+nAepN0z2I7MXZKXMAcj/DgXLLQp5i1GEYPRN5WqnYU5Oik1Fo1zJxEGSC+4XuV5/1PjAkRamte77oGgWn0xdmoLlTn8zJ2lWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=PwxAXigj; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FmyUqYcWu+Mpw64II+TwnYmYNV9dyEjqcVO8sG58mwg=; t=1710782196; x=1711386996; 
	b=PwxAXigjoDeov5+cA6M5HFgHDvM2JcVH6LGK2JHsrJW/TlcJa8/4eXCy2bT8fF27dvVuiVNgYEf
	q/jaSv67iRBmK3N7YFEBhg0ix0ZvsA6Grg9f05PKwGYYU4HbZHOB/0tEM3HoSeS35mF7OOQb/4ONO
	eUVCGvMmFyh8MO5W+i2/2pAlEuN0l25mKaIois5nnqypAkekrnrhF+HfZ8F2OePRONIEsXymkNc8o
	7SccCqLuVUJKSNpTURpZeI4PEcz1ZQbWO7uHrD+F2rYgwGnoQvsqFLpn/Bf69+9CuZ2kSbeFX+5CU
	hGbRw+R8EL5RE7kTb9AI6DLi+HQuHyDcQg8A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rmGXJ-000000004sZ-0N4g; Mon, 18 Mar 2024 18:12:33 +0100
Received: from dynamic-077-013-176-050.77.13.pool.telefonica.de ([77.13.176.50] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rmGXI-00000001XLr-3SQ9; Mon, 18 Mar 2024 18:12:32 +0100
Message-ID: <8947f91ba1a10f98723a5982f0fc13ee589d3bf7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH V2 3/3] SH: cpuinfo: Fix a warning for
 CONFIG_CPUMASK_OFFSTACK
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 loongarch@lists.linux.dev, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang
 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 18 Mar 2024 18:12:31 +0100
In-Reply-To: <CAAhV-H5bw3xcym2-GpyntQEad1h2eB8xDQGwVr_bRRKAOakzoQ@mail.gmail.com>
References: <20220714084136.570176-1-chenhuacai@loongson.cn>
	 <20220714084136.570176-3-chenhuacai@loongson.cn>
	 <3a5a4bee5c0739a3b988a328376a6eed3c385fda.camel@physik.fu-berlin.de>
	 <CAAhV-H5bw3xcym2-GpyntQEad1h2eB8xDQGwVr_bRRKAOakzoQ@mail.gmail.com>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Hucai,

On Mon, 2024-03-18 at 22:21 +0800, Huacai Chen wrote:
> Hi, SuperH maintainers,
>=20
> On Wed, Feb 8, 2023 at 8:59=E2=80=AFPM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> >=20
> > On Thu, 2022-07-14 at 16:41 +0800, Huacai Chen wrote:
> > > When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS is selecte=
d,
> > > cpu_max_bits_warn() generates a runtime warning similar as below whil=
e
> > > we show /proc/cpuinfo. Fix this by using nr_cpu_ids (the runtime limi=
t)
> > > instead of NR_CPUS to iterate CPUs.
> > >=20
> > > [    3.052463] ------------[ cut here ]------------
> > > [    3.059679] WARNING: CPU: 3 PID: 1 at include/linux/cpumask.h:108 =
show_cpuinfo+0x5e8/0x5f0
> > > [    3.070072] Modules linked in: efivarfs autofs4
> > > [    3.076257] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19-rc5+ #105=
2
> > > [    3.099465] Stack : 9000000100157b08 9000000000f18530 9000000000cf=
846c 9000000100154000
> > > [    3.109127]         9000000100157a50 0000000000000000 900000010015=
7a58 9000000000ef7430
> > > [    3.118774]         90000001001578e8 0000000000000040 000000000000=
0020 ffffffffffffffff
> > > [    3.128412]         0000000000aaaaaa 1ab25f00eec96a37 900000010021=
de80 900000000101c890
> > > [    3.138056]         0000000000000000 0000000000000000 000000000000=
0000 0000000000aaaaaa
> > > [    3.147711]         ffff8000339dc220 0000000000000001 0000000006ab=
4000 0000000000000000
> > > [    3.157364]         900000000101c998 0000000000000004 9000000000ef=
7430 0000000000000000
> > > [    3.167012]         0000000000000009 000000000000006c 000000000000=
0000 0000000000000000
> > > [    3.176641]         9000000000d3de08 9000000001639390 900000000020=
86d8 00007ffff0080286
> > > [    3.186260]         00000000000000b0 0000000000000004 000000000000=
0000 0000000000071c1c
> > > [    3.195868]         ...
> > > [    3.199917] Call Trace:
> > > [    3.203941] [<90000000002086d8>] show_stack+0x38/0x14c
> > > [    3.210666] [<9000000000cf846c>] dump_stack_lvl+0x60/0x88
> > > [    3.217625] [<900000000023d268>] __warn+0xd0/0x100
> > > [    3.223958] [<9000000000cf3c90>] warn_slowpath_fmt+0x7c/0xcc
> > > [    3.231150] [<9000000000210220>] show_cpuinfo+0x5e8/0x5f0
> > > [    3.238080] [<90000000004f578c>] seq_read_iter+0x354/0x4b4
> > > [    3.245098] [<90000000004c2e90>] new_sync_read+0x17c/0x1c4
> > > [    3.252114] [<90000000004c5174>] vfs_read+0x138/0x1d0
> > > [    3.258694] [<90000000004c55f8>] ksys_read+0x70/0x100
> > > [    3.265265] [<9000000000cfde9c>] do_syscall+0x7c/0x94
> > > [    3.271820] [<9000000000202fe4>] handle_syscall+0xc4/0x160
> > > [    3.281824] ---[ end trace 8b484262b4b8c24c ]---
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  arch/sh/kernel/cpu/proc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
> > > index a306bcd6b341..5f6d0e827bae 100644
> > > --- a/arch/sh/kernel/cpu/proc.c
> > > +++ b/arch/sh/kernel/cpu/proc.c
> > > @@ -132,7 +132,7 @@ static int show_cpuinfo(struct seq_file *m, void =
*v)
> > >=20
> > >  static void *c_start(struct seq_file *m, loff_t *pos)
> > >  {
> > > -     return *pos < NR_CPUS ? cpu_data + *pos : NULL;
> > > +     return *pos < nr_cpu_ids ? cpu_data + *pos : NULL;
> > >  }
> > >  static void *c_next(struct seq_file *m, void *v, loff_t *pos)
> > >  {
> >=20
> > I build-tested the patch and also booted the patched kernel successfull=
y
> > on my SH-7785LCR board.
> >=20
> > Showing the contents of /proc/cpuinfo works fine, too:
> >=20
> > root@tirpitz:~> cat /proc/cpuinfo
> > machine         : SH7785LCR
> > processor       : 0
> > cpu family      : sh4a
> > cpu type        : SH7785
> > cut             : 7.x
> > cpu flags       : fpu perfctr llsc
> > cache type      : split (harvard)
> > icache size     : 32KiB (4-way)
> > dcache size     : 32KiB (4-way)
> > address sizes   : 32 bits physical
> > bogomips        : 599.99
> > root@tirpitz:~>
> >=20
> > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >=20
> > I am not sure yet whether the change is also correct as I don't know wh=
ether
> > it's possible to change the number of CPUs at runtime on SuperH.
> Can this patch be merged? This is the only one still unmerged in the
> whole series.

Thanks for the reminder. I will pick it up for 6.10.

Got sick this week, so I can't pick up anymore patches for 6.9 and will jus=
t
send Linus a PR later this week.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

