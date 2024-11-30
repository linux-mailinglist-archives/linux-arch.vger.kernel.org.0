Return-Path: <linux-arch+bounces-9196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CA9DF04E
	for <lists+linux-arch@lfdr.de>; Sat, 30 Nov 2024 13:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CA0B21927
	for <lists+linux-arch@lfdr.de>; Sat, 30 Nov 2024 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4194315D5CE;
	Sat, 30 Nov 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GWUf/UUt"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF651474D3;
	Sat, 30 Nov 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732969597; cv=none; b=HDse0AxDKEq7YlJRVdPwx5uVoG+vjT/5JlnGqNkRceMGtFa1suY0pcx2rN8vaGv7q+/FupEJUPTR1lepnXU1dYKkuZSlZvDVhHHCuOXy7775OuK5CC1nwEc8k9W6hC+zI4w/bxHFzC0S1alvyex8LaVyXVA5u+7n8f1Kii/1+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732969597; c=relaxed/simple;
	bh=z0K3Q0sj0LQ1spLuLoShahbeHYa305BCVD8UYZTR13M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0bQawhZRkN8zkqlYGo3UPIh6bBuSW/oiJkFhA2Yf89uRsiv8o/RuZ4AwKMHGSTdFqObvr/Hi/r9yb1FqumGpUj94g5KrBEkT8iwPEj+Cl7seOjQTk+9qQKL6/lemS1GB1Y34zRLX22Yb/2c+aDUH4R7lxK12n9STxLIU+gzVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GWUf/UUt; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KW2SziV8Wa3Uewwj5yveby6tJ3bU6qMDTrg+jh/M0jk=; t=1732969593; x=1733574393; 
	b=GWUf/UUtyoOjnn4MomI+kxUkELhWcFcyGCq5Qg8MjYM7fRXoURFF4a/SZuWS2kTyI8vnN4dcPaM
	+VMRb0SQw3UlOaHQPbnAUrCtoR1tKCQPFrisxtpKJL3EUstsoSWpkjW4xvoteS7pirRknegRwgVCB
	UeSP9Ut0W2LZojIwpnoIr7KIordZq/x2tFcRbcLQSwtm8kbkGs2dPijOjfTZiZ/cr3UMb9yEztvFG
	Cl0oV8RLZr9rZx111qHnGXrMnt5JZn5ke0Kf96kARvA1MgZF5UbCm3XaQ9RKoOyIP3m0t1CKbkTKI
	63M0bi5zd7HSdNrCMqkbib0KoYQ5A9+4Wurg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tHMYG-00000003zuh-1mt2; Sat, 30 Nov 2024 13:26:20 +0100
Received: from dynamic-078-054-081-111.78.54.pool.telefonica.de ([78.54.81.111] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tHMYG-00000001QkK-0rW7; Sat, 30 Nov 2024 13:26:20 +0100
Message-ID: <4484ee7c2eb6a3a5aadb9cff745b07453c76a8d2.camel@physik.fu-berlin.de>
Subject: Re: [PATCH V2 3/3] SH: cpuinfo: Fix a warning for
 CONFIG_CPUMASK_OFFSTACK
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: loongarch@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>, Guo Ren	
 <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang	
 <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, 	stable@vger.kernel.org
Date: Sat, 30 Nov 2024 13:26:19 +0100
In-Reply-To: <20220714084136.570176-3-chenhuacai@loongson.cn>
References: <20220714084136.570176-1-chenhuacai@loongson.cn>
	 <20220714084136.570176-3-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Thu, 2022-07-14 at 16:41 +0800, Huacai Chen wrote:
> When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS is selected,
> cpu_max_bits_warn() generates a runtime warning similar as below while
> we show /proc/cpuinfo. Fix this by using nr_cpu_ids (the runtime limit)
> instead of NR_CPUS to iterate CPUs.
>=20
> [    3.052463] ------------[ cut here ]------------
> [    3.059679] WARNING: CPU: 3 PID: 1 at include/linux/cpumask.h:108 show=
_cpuinfo+0x5e8/0x5f0
> [    3.070072] Modules linked in: efivarfs autofs4
> [    3.076257] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19-rc5+ #1052
> [    3.099465] Stack : 9000000100157b08 9000000000f18530 9000000000cf846c=
 9000000100154000
> [    3.109127]         9000000100157a50 0000000000000000 9000000100157a58=
 9000000000ef7430
> [    3.118774]         90000001001578e8 0000000000000040 0000000000000020=
 ffffffffffffffff
> [    3.128412]         0000000000aaaaaa 1ab25f00eec96a37 900000010021de80=
 900000000101c890
> [    3.138056]         0000000000000000 0000000000000000 0000000000000000=
 0000000000aaaaaa
> [    3.147711]         ffff8000339dc220 0000000000000001 0000000006ab4000=
 0000000000000000
> [    3.157364]         900000000101c998 0000000000000004 9000000000ef7430=
 0000000000000000
> [    3.167012]         0000000000000009 000000000000006c 0000000000000000=
 0000000000000000
> [    3.176641]         9000000000d3de08 9000000001639390 90000000002086d8=
 00007ffff0080286
> [    3.186260]         00000000000000b0 0000000000000004 0000000000000000=
 0000000000071c1c
> [    3.195868]         ...
> [    3.199917] Call Trace:
> [    3.203941] [<90000000002086d8>] show_stack+0x38/0x14c
> [    3.210666] [<9000000000cf846c>] dump_stack_lvl+0x60/0x88
> [    3.217625] [<900000000023d268>] __warn+0xd0/0x100
> [    3.223958] [<9000000000cf3c90>] warn_slowpath_fmt+0x7c/0xcc
> [    3.231150] [<9000000000210220>] show_cpuinfo+0x5e8/0x5f0
> [    3.238080] [<90000000004f578c>] seq_read_iter+0x354/0x4b4
> [    3.245098] [<90000000004c2e90>] new_sync_read+0x17c/0x1c4
> [    3.252114] [<90000000004c5174>] vfs_read+0x138/0x1d0
> [    3.258694] [<90000000004c55f8>] ksys_read+0x70/0x100
> [    3.265265] [<9000000000cfde9c>] do_syscall+0x7c/0x94
> [    3.271820] [<9000000000202fe4>] handle_syscall+0xc4/0x160
> [    3.281824] ---[ end trace 8b484262b4b8c24c ]---
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/sh/kernel/cpu/proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
> index a306bcd6b341..5f6d0e827bae 100644
> --- a/arch/sh/kernel/cpu/proc.c
> +++ b/arch/sh/kernel/cpu/proc.c
> @@ -132,7 +132,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> =20
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> -	return *pos < NR_CPUS ? cpu_data + *pos : NULL;
> +	return *pos < nr_cpu_ids ? cpu_data + *pos : NULL;
>  }
>  static void *c_next(struct seq_file *m, void *v, loff_t *pos)
>  {

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

