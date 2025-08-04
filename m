Return-Path: <linux-arch+bounces-13026-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90467B19CEB
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 09:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D233A8BC6
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA74233722;
	Mon,  4 Aug 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JDY3dQOP"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3EBB672;
	Mon,  4 Aug 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293738; cv=none; b=S+1fG8Np5AaiioQq1mvnHxB7Ccc1h5waO9fGBa/fol34NBlZC2/42c9E9GxiNJ2n5hknezCu+05XR3qA3fyvlJ5nOcWyDgYOiGNXEJkh2Jc3XW1xhpsQ463m8s81A8HdMJBOkQ9VdUDjOZ7y2G7l9MUF7He5D8nMEFcissLvWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293738; c=relaxed/simple;
	bh=JXpFyaF+uGfiO0UGjNIeZPiv4/TJ36R3HDezgsANFmU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqNPaKggKbWcQFWCcEfdkV+8v17DnRl/w3CnIUAsLh5HTGysOmwdwNPJUEmnOaCi4Ng3/kDoAj0ST1/mzO61ZW2nB7BiPeUuFFPcmEBIQviKN1V/SIaOG4wUZVgnvXRy7V7LJXoLLUByQ9af4zwYboQl/19f7kl/tPuWT6NxBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JDY3dQOP; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1TuNVDnyNHuWlEbTjXz2CCarXdU6W9BSLVaR+b76fg4=; t=1754293735; x=1754898535; 
	b=JDY3dQOPCHuEfiJi/eLcGK0rW8XFRQyXDzAwU9CmDp+PnHR18YTu+OH5exltvZGaU5KPy9kCGaJ
	iBTRg58ooYlwOxvvS0mPggfOxvLfk34k/1YKkduOPzRAnfGRPz03aBLzY4ADHMTbxFiblSKhetfko
	KvtrU1qqMcjs9LSBJC/iZOzbqFLpS8T+sKfafLSr2jn13QAQz5P8q/EBMN0s5qBEHDFQTAB8YE57Y
	yke4M5XNJwJYYsbWtNyI9vrLP/WR3DumDtc7FFEnWyFMOJvO0i6XYqz6+aqhK3coVPVgP6HN4QV66
	Z2DAm4RQFb6JlOF5Sn34zM+QbsVJkJwP01JA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uipwB-000000028Cn-3NOP; Mon, 04 Aug 2025 09:48:51 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uipwB-00000000XPY-2F6Z; Mon, 04 Aug 2025 09:48:51 +0200
Message-ID: <2689df25d95e7c4fab781be2b3a4ac7ff9b50132.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 25/36] sparc64: Implement the new page table range API
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, "Matthew Wilcox (Oracle)"
	 <willy@infradead.org>, linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, "David S. Miller"	
 <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson	
 <andreas@gaisler.com>, Rod Schnell <rods@mw-radio.com>, Sam James
 <sam@gentoo.org>
Date: Mon, 04 Aug 2025 09:48:50 +0200
In-Reply-To: <d424e109e6f1a00b8cf22ec1b40d6dedff38ce52.camel@physik.fu-berlin.de>
References: <20230315051444.3229621-1-willy@infradead.org>
				 <20230315051444.3229621-26-willy@infradead.org>
				 <ce6337237169f179c75fe4a1ba1ce98843577360.camel@physik.fu-berlin.de>
				 <83931f05-a613-4972-be76-80bc695915e4@oracle.com>
			 <75cbab0cdab084795422335c0e0d69c6f57b468c.camel@physik.fu-berlin.de>
		 <76c45021481cfe1aaa9fe2cfcd2287ac6c8d4504.camel@physik.fu-berlin.de>
	 <d424e109e6f1a00b8cf22ec1b40d6dedff38ce52.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Mon, 2025-08-04 at 08:58 +0200, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-08-04 at 07:36 +0200, John Paul Adrian Glaubitz wrote:
> > On Mon, 2025-08-04 at 07:12 +0200, John Paul Adrian Glaubitz wrote:
> > > On Sun, 2025-08-03 at 12:08 -0700, Anthony Yznaga wrote:
> > > > There was a follow-on fix that addressed a bug with this patch:
> > > >=20
> > > > f4b4f3ec1a31 sparc64: add missing initialization of folio in tlb_ba=
tch_add()
> > >=20
> > > Indeed I just tried v6.6 which has this patch and added your sun4u fi=
x and it
> > > seems to be stable. I was sure I saw problems even with v6.16 though.
> > >=20
> > > Let me run more tests.
> >=20
> > I'm seeing another crash on v6.16 on sun4u even with your patch applied=
:
> >=20
> > [  456.443492] kernel BUG at fs/ext4/inode.c:1174!
> > [  456.503059]               \|/ ____ \|/
> > [  456.503059]               "@'/ .. \`@"
> > [  456.503059]               /_| \__/ |_\
> > [  456.503059]                  \__U_/
> > [  456.696513] apt-get(1217): Kernel bad sw trap 5 [#1]
> > [  456.761698] CPU: 0 UID: 0 PID: 1217 Comm: apt-get Not tainted 6.16.0=
+ #24 VOLUNTARY=20
> > [  456.863502] TSTATE: 0000000011001601 TPC: 0000000010309250 TNPC: 000=
0000010309254 Y: 00000000    Not tainted
> > [  456.992850] TPC: <ext4_block_write_begin+0x450/0x540 [ext4]>
> > [  457.067500] g0: 0000000000000000 g1: 0000000000000001 g2: 0000000000=
000000 g3: 0000000000000000
> > [  457.181869] g4: fff00000141d5c80 g5: 0000000000000008 g6: fff000000b=
e24000 g7: 0000000000000001
> > [  457.296245] o0: 00000000103944b0 o1: 0000000000000496 o2: ffffffffff=
ffffbf o3: 0000000000101cca
> > [  457.410618] o4: 0000000000000000 o5: 0000000000000000 sp: fff000000b=
e26fd1 ret_pc: 0000000010309248
> > [  457.529571] RPC: <ext4_block_write_begin+0x448/0x540 [ext4]>
> > [  457.604020] l0: fff000003def26e0 l1: 0000000000113cca l2: fff000003d=
ef2578 l3: 0000000000000002
> > [  457.718394] l4: 0000000000000000 l5: 0000000000080000 l6: 0000000000=
012000 l7: 0000000000000001
> > [  457.832770] i0: 0000000000000000 i1: 000c00000026b500 i2: 0000000000=
001000 i3: 0000000000082000
> > [  457.947146] i4: 00000000103034a0 i5: 0000000000000000 i6: fff000000b=
e270c1 i7: 000000001030c8dc
> > [  458.061528] I7: <ext4_da_write_begin+0x1bc/0x340 [ext4]>
> > [  458.131389] Call Trace:
> > [  458.163408] [<000000001030c8dc>] ext4_da_write_begin+0x1bc/0x340 [ex=
t4]
> > [  458.250447] [<0000000000674230>] generic_perform_write+0x90/0x240
> > [  458.330606] [<00000000102f50b4>] ext4_buffered_write_iter+0x54/0x120=
 [ext4]
> > [  458.422214] [<00000000102f5624>] ext4_file_write_iter+0x3e4/0x780 [e=
xt4]
> > [  458.510388] [<0000000000749cc4>] vfs_write+0x2c4/0x3e0
> > [  458.577867] [<0000000000749f4c>] ksys_write+0x4c/0xe0
> > [  458.644203] [<0000000000749ff4>] sys_write+0x14/0x40
> > [  458.709397] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
> > [  458.786048] Disabling lock debugging due to kernel taint
> > [  458.855904] Caller[000000001030c8dc]: ext4_da_write_begin+0x1bc/0x34=
0 [ext4]
> > [  458.948653] Caller[0000000000674230]: generic_perform_write+0x90/0x2=
40
> > [  459.034430] Caller[00000000102f50b4]: ext4_buffered_write_iter+0x54/=
0x120 [ext4]
> > [  459.131761] Caller[00000000102f5624]: ext4_file_write_iter+0x3e4/0x7=
80 [ext4]
> > [  459.225648] Caller[0000000000749cc4]: vfs_write+0x2c4/0x3e0
> > [  459.298846] Caller[0000000000749f4c]: ksys_write+0x4c/0xe0
> > [  459.370900] Caller[0000000000749ff4]: sys_write+0x14/0x40
> > [  459.441810] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
> > [  459.524168] Caller[0000000000000000]: 0x0
> > [  459.576772] Instruction DUMP:
> > [  459.576776]  11040e51=20
> > [  459.615662]  7c04b816=20
> > [  459.646541]  901220b0=20
> > [  459.677418] <91d02005>
> > [  459.708302]  9735a000=20
> > [  459.739181]  95352000=20
> > [  459.770076]  d25fa7cf=20
> > [  459.800945]  7fffe818=20
> > [  459.831825]  90100019=20
> > [  459.862706]=20
> > [  459.941500] systemd[1]: Failed to open /dev/pts device, ignoring: In=
appropriate ioctl for device
> > [  460.063831] systemd[1]: rsyslog.service: Main process exited, code=
=3Dkilled, status=3D6/ABRT
> > [  460.170962] systemd[1]: rsyslog.service: Failed with result 'signal'=
.
> > [  460.267153] systemd[1]: systemd-journald.service: Scheduled restart =
job, restart counter is at 1.
> > [  460.388605] systemd[1]: rsyslog.service: Scheduled restart job, rest=
art counter is at 1.
> > [  460.517346] systemd[1]: Starting rsyslog.service - System Logging Se=
rvice...
> > [  460.618299] systemd[1]: Starting systemd-journald.service - Journal =
Service...
> > [  460.895645] systemd-journald[1237]: Collecting audit messages is dis=
abled.
> > [  461.048068] systemd[1]: Failed to open /dev/pts device, ignoring: In=
appropriate ioctl for device
> > [  461.202783] systemd-journald[1237]: File /var/log/journal/9ac90e257b=
3e423284cfc21a00cbeeb8/system.journal corrupted or uncleanly shut down, ren=
aming and replacing.
> > [  461.456867] systemd[1]: Started rsyslog.service - System Logging Ser=
vice.
> > [  461.616651] systemd-journald[1237]: Time jumped backwards, rotating.
> > [  461.773305] systemd-journald[1237]: Failed to read journal file /var=
/log/journal/9ac90e257b3e423284cfc21a00cbeeb8/user-1002.journal for rotatio=
n, trying to move it out of the way: Device or
> > resource busy
> > [  462.065725] systemd[1]: Started systemd-journald.service - Journal S=
ervice.
> > [  462.159895] systemd-journald[1237]: Time jumped backwards, rotating.
> > [  519.719624] kernel BUG at fs/ext4/inode.c:1174!
> > [  519.779143]               \|/ ____ \|/
> > [  519.779143]               "@'/ .. \`@"
> > [  519.779143]               /_| \__/ |_\
> > [  519.779143]                  \__U_/
> > [  519.972586] apt(1249): Kernel bad sw trap 5 [#2]
> > [  520.033239] CPU: 0 UID: 0 PID: 1249 Comm: apt Tainted: G      D     =
        6.16.0+ #24 VOLUNTARY=20
> > [  520.151048] Tainted: [D]=3DDIE
> > [  520.188797] TSTATE: 0000000011001603 TPC: 0000000010309250 TNPC: 000=
0000010309254 Y: 00000000    Tainted: G      D           =20
> > [  520.338725] TPC: <ext4_block_write_begin+0x450/0x540 [ext4]>
> > [  520.413282] g0: 0000000000000000 g1: 0000000000000001 g2: 0000000000=
000000 g3: 0000000000000000
> > [  520.527655] g4: fff00000141d40c0 g5: 000000000000000b g6: fff000000a=
818000 g7: 0000000000000001
> > [  520.642031] o0: 00000000103944b0 o1: 0000000000000496 o2: ffffffffff=
fffcc0 o3: 0000000000101cca
> > [  520.756408] o4: 0000000000000004 o5: 0000000000000000 sp: fff000000a=
81afd1 ret_pc: 0000000010309248
> > [  520.875350] RPC: <ext4_block_write_begin+0x448/0x540 [ext4]>
> > [  520.949799] l0: fff000023439af00 l1: 0000000000113cca l2: fff0000234=
39ad98 l3: 0000000000000002
> > [  521.064174] l4: 0000000000000000 l5: 0000000000080000 l6: 0000000000=
012000 l7: 0000000000000001
> > [  521.178547] i0: 0000000000000000 i1: 000c000000164a00 i2: 0000000000=
001fc0 i3: 0000000000680000
> > [  521.292923] i4: 00000000103034a0 i5: 0000000000000000 i6: fff000000a=
81b0c1 i7: 000000001030c8dc
> > [  521.407297] I7: <ext4_da_write_begin+0x1bc/0x340 [ext4]>
> > [  521.477195] Call Trace:
> > [  521.509295] [<000000001030c8dc>] ext4_da_write_begin+0x1bc/0x340 [ex=
t4]
> > [  521.596330] [<0000000000674230>] generic_perform_write+0x90/0x240
> > [  521.676495] [<00000000102f50b4>] ext4_buffered_write_iter+0x54/0x120=
 [ext4]
> > [  521.768196] [<00000000102f5624>] ext4_file_write_iter+0x3e4/0x780 [e=
xt4]
> > [  521.856381] [<0000000000749cc4>] vfs_write+0x2c4/0x3e0
> > [  521.923957] [<0000000000749f4c>] ksys_write+0x4c/0xe0
> > [  521.990294] [<0000000000749ff4>] sys_write+0x14/0x40
> > [  522.055486] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
> > [  522.132122] Caller[000000001030c8dc]: ext4_da_write_begin+0x1bc/0x34=
0 [ext4]
> > [  522.224873] Caller[0000000000674230]: generic_perform_write+0x90/0x2=
40
> > [  522.310649] Caller[00000000102f50b4]: ext4_buffered_write_iter+0x54/=
0x120 [ext4]
> > [  522.407974] Caller[00000000102f5624]: ext4_file_write_iter+0x3e4/0x7=
80 [ext4]
> > [  522.501864] Caller[0000000000749cc4]: vfs_write+0x2c4/0x3e0
> > [  522.575062] Caller[0000000000749f4c]: ksys_write+0x4c/0xe0
> > [  522.647118] Caller[0000000000749ff4]: sys_write+0x14/0x40
> > [  522.718031] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
> > [  522.800380] Caller[0000000000000000]: 0x0
> > [  522.852991] Instruction DUMP:
> > [  522.852994]  11040e51=20
> > [  522.891878]  7c04b816=20
> > [  522.922760]  901220b0=20
> > [  522.953638] <91d02005>
> > [  522.984521]  9735a000=20
> > [  523.015401]  95352000=20
> > [  523.046284]  d25fa7cf=20
> > [  523.077163]  7fffe818=20
> > [  523.108109]  90100019=20
> > [  523.139044]
> >=20
> > I'll try to bisect this one later this week.
>=20
> OK, so v6.8 is fine while v6.9 crashes:
>=20
> [   39.788224] Unable to handle kernel NULL pointer dereference
> [   39.862657] tsk->{mm,active_mm}->context =3D 000000000000004b
> [   39.935941] tsk->{mm,active_mm}->pgd =3D fff000000aa98000
> [   40.004566]               \|/ ____ \|/
> [   40.004566]               "@'/ .. \`@"
> [   40.004566]               /_| \__/ |_\
> [   40.004566]                  \__U_/
> [   40.197871] (udev-worker)(88): Oops [#1]
> [   40.249329] CPU: 0 PID: 88 Comm: (udev-worker) Tainted: P           O =
      6.9.0+ #28
> [   40.353415] TSTATE: 0000004411001605 TPC: 0000000000df092c TNPC: 00000=
00000df0930 Y: 00000000    Tainted: P           O     =20
> [   40.502105] TPC: <strlen+0x60/0xd4>
> [   40.547844] g0: fff000000a3171a1 g1: 0000000000000000 g2: 000000000000=
0000 g3: 0000000000000001
> [   40.662224] g4: fff000000aa4dac0 g5: 0000000010000233 g6: fff000000a31=
4000 g7: 0000000000000000
> [   40.776599] o0: 0000000000000010 o1: 0000000000000010 o2: 000000000101=
0101 o3: 0000000080808080
> [   40.890974] o4: 0000000001010000 o5: 0000000000000000 sp: fff000000a31=
7201 ret_pc: 00000000004d4b08
> [   41.009924] RPC: <module_patient_check_exists.constprop.0+0x48/0x1e0>
> [   41.094557] l0: fff0000100032f40 l1: 0000000000000000 l2: 000000000000=
0000 l3: 0000000000000000
> [   41.208936] l4: 0000000000000000 l5: 0000000000000000 l6: 000000000000=
0000 l7: 0000000000000000
> [   41.323311] i0: 00000001000256d8 i1: 0000000001143000 i2: 000000000114=
3300 i3: 000000000000000b
> [   41.437686] i4: 0000000000000010 i5: fffffffffffffff8 i6: fff000000a31=
72e1 i7: 00000000004d63f0
> [   41.552062] I7: <load_module+0x550/0x1f00>
> [   41.605811] Call Trace:
> [   41.637838] [<00000000004d63f0>] load_module+0x550/0x1f00
> [   41.708752] [<00000000004d7fac>] init_module_from_file+0x6c/0xa0
> [   41.787670] [<00000000004d81c8>] sys_finit_module+0x188/0x280
> [   41.863158] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
> [   41.939790] Caller[00000000004d63f0]: load_module+0x550/0x1f00
> [   42.016423] Caller[00000000004d7fac]: init_module_from_file+0x6c/0xa0
> [   42.101059] Caller[00000000004d81c8]: sys_finit_module+0x188/0x280
> [   42.182266] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
> [   42.264614] Caller[fff000010480e2fc]: 0xfff000010480e2fc
> [   42.334384] Instruction DUMP:
> [   42.334387]  96132080=20
> [   42.373269]  19004040=20
> [   42.404151]  94132101=20
> [   42.435030] <da020000>
> [   42.465914]  9823400a=20
> [   42.496793]  808b000b=20
> [   42.527674]  024ffffd=20
> [   42.558556]  90022004=20
> [   42.589437]  8f336018=20
> [   42.620318]
>=20
> So, the regression was introduced with v6.9. Will bisect this later this =
week.

Hmm, I just ran into another crash on v6.8. The machine didn't crash though=
:

[  489.263666] Unable to handle kernel paging request at virtual address 00=
0c000002400000
[  489.367912] tsk->{mm,active_mm}->context =3D 00000000000013b2
[  489.441150] tsk->{mm,active_mm}->pgd =3D fff000000af04000
[  489.509872]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[  489.703156] sshd-session(3671): Oops [#1]
[  489.755758] CPU: 0 PID: 3671 Comm: sshd-session Not tainted 6.8.0+ #27
[  489.841544] TSTATE: 0000000811001600 TPC: 000000000065d620 TNPC: 0000000=
00065d624 Y: 00000000    Not tainted
[  489.970796] TPC: <unmap_page_range+0x620/0xc60>
[  490.030362] g0: fff000000a939360 g1: 0000000000008800 g2: ffffffffffffff=
ff g3: ffffffffffffffff
[  490.144748] g4: fff0000000d4a100 g5: 0000000002ad4a68 g6: fff000000a6dc0=
00 g7: 0000010000000000
[  490.259118] o0: 000c0000024005a0 o1: fff00001018a4000 o2: 00000001000282=
90 o3: 0000000100028290
[  490.373493] o4: fff0000001afe71c o5: 0000000001099c00 sp: fff000000a6dee=
b1 ret_pc: 000000000065d53c
[  490.492447] RPC: <unmap_page_range+0x53c/0xc60>
[  490.551915] l0: fff00001018f4000 l1: 0000000100028290 l2: fff000000a6df9=
68 l3: fff00001018a4000
[  490.666292] l4: fff00000070a25a0 l5: fff000000a6dfaa8 l6: 00000000000000=
01 l7: 00000000011605a8
[  490.780668] i0: fff000000a9b0900 i1: fff00001018a6000 i2: fff0000000f990=
18 i3: fff0000004308290
[  490.895045] i4: fff00001018f4000 i5: 000c0000024005a0 i6: fff000000a6def=
f1 i7: 000000000065dcd8
[  491.009418] I7: <unmap_single_vma.constprop.0+0x78/0xe0>
[  491.079183] Call Trace:
[  491.111206] [<000000000065dcd8>] unmap_single_vma.constprop.0+0x78/0xe0
[  491.198136] [<000000000065dd9c>] unmap_vmas+0x5c/0x1a0
[  491.265615] [<000000000066a2a4>] exit_mmap+0xc4/0x440
[  491.331950] [<0000000000463d44>] __mmput+0x44/0x140
[  491.396003] [<0000000000463e74>] mmput+0x34/0x60
[  491.456618] [<000000000046a444>] do_exit+0x284/0xaa0
[  491.521816] [<000000000046ae24>] do_group_exit+0x24/0xa0
[  491.591584] [<000000000046aebc>] sys_exit_group+0x1c/0x40
[  491.662496] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
[  491.739127] Disabling lock debugging due to kernel taint
[  491.808896] Caller[000000000065dcd8]: unmap_single_vma.constprop.0+0x78/=
0xe0
[  491.901543] Caller[000000000065dd9c]: unmap_vmas+0x5c/0x1a0
[  491.974740] Caller[000000000066a2a4]: exit_mmap+0xc4/0x440
[  492.046795] Caller[0000000000463d44]: __mmput+0x44/0x140
[  492.116564] Caller[0000000000463e74]: mmput+0x34/0x60
[  492.182901] Caller[000000000046a444]: do_exit+0x284/0xaa0
[  492.253815] Caller[000000000046ae24]: do_group_exit+0x24/0xa0
[  492.329301] Caller[000000000046aebc]: sys_exit_group+0x1c/0x40
[  492.405935] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
[  492.488282] Caller[fff0000102ad4a74]: 0xfff0000102ad4a74
[  492.558054] Instruction DUMP:
[  492.558057]  c6756010=20
[  492.596937]  02ff7fd9=20
[  492.627825]  c2356018=20
[  492.658702] <c25f6008>
[  492.689581]  8610001d=20
[  492.720460]  84086001=20
[  492.751343]  82007fff=20
[  492.782223]  87789401=20
[  492.813105]  c258e018=20

[  492.894311] Fixing recursive fault but reboot is needed!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

