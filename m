Return-Path: <linux-arch+bounces-13023-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE10B19B1F
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 07:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F477AACC5
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 05:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14BC1DE4C2;
	Mon,  4 Aug 2025 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="A6bp+/CY"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390B4685;
	Mon,  4 Aug 2025 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285820; cv=none; b=cjoqAZt98gMAPuIwhnEUxw8B2+pmPefVn28LFBW297DQDEhYVZ5yuEdcdIi72GWOqZV7L0+Kk38Qq4cfMRVrwGdGek/vFieMbvnj3cFlI38JDiLsnxUUvvgEaZqre8VxXCRbvh1rpkLwb5/9xrWKyjZSxdlq9uEdwndtjp32sys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285820; c=relaxed/simple;
	bh=luzrs7wTAH9BsYjtrAye3GRmHl9zm3O1HTTMhGSenTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzVvH19GfEruazUTtgj8CmcPeFsdvVWd1S96wvU/TFebWk8hQ3QhhNkG3kVeNCOJljSUKVngv6uLMF2po8WYKG0zUGsFyPPz+ijGt4dRaxSTG3f+WtdwIM0QWRFbEEXTX7ZqAJViT7RpowisZvqzUTv16S4P4cgsie0vwgxaEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=A6bp+/CY; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rqSnw5vzazW0whDpz9dYWOoqZzLvIpG1BBXrJJDFc6Q=; t=1754285817; x=1754890617; 
	b=A6bp+/CYo7bLN4Uyl87zbTudlrkeMSFACh1qh7kIgf4lLYebxiV3Z2Sit+VYonTNuZKIquLnfP2
	muItQfsZyVk8JYWDD7czvpygkil4k0IXfNbAPZWUfEn8JY7P0AdTWBEkg3ibaAdl6/g8CVkKZFCIO
	XBp7LGe5EWFH5jLSu3ENodjOtp4XsvW7lHzAT6Vw+IBQZFTk+917wDJN0Pv43XIi8nbzXAMv2DbbW
	f3nsPzXhdIhhUg7BBBh5UTjhzDOouzDQoVMP2AKoRl44HmfMmquztlyi+YtP1wPTyUd88NYi7PrIo
	R4oEDZZNo4DIlDjnPZaLewIPoXfphVjM2aDw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uinsT-00000001Wpx-3ELv; Mon, 04 Aug 2025 07:36:53 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uinsT-00000000CUV-2G2F; Mon, 04 Aug 2025 07:36:53 +0200
Message-ID: <76c45021481cfe1aaa9fe2cfcd2287ac6c8d4504.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 25/36] sparc64: Implement the new page table range API
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, "Matthew Wilcox (Oracle)"
	 <willy@infradead.org>, linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, "David S. Miller"	
 <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson	
 <andreas@gaisler.com>, Rod Schnell <rods@mw-radio.com>, Sam James
 <sam@gentoo.org>
Date: Mon, 04 Aug 2025 07:36:52 +0200
In-Reply-To: <75cbab0cdab084795422335c0e0d69c6f57b468c.camel@physik.fu-berlin.de>
References: <20230315051444.3229621-1-willy@infradead.org>
		 <20230315051444.3229621-26-willy@infradead.org>
		 <ce6337237169f179c75fe4a1ba1ce98843577360.camel@physik.fu-berlin.de>
		 <83931f05-a613-4972-be76-80bc695915e4@oracle.com>
	 <75cbab0cdab084795422335c0e0d69c6f57b468c.camel@physik.fu-berlin.de>
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

Hi Anthony,

On Mon, 2025-08-04 at 07:12 +0200, John Paul Adrian Glaubitz wrote:
> On Sun, 2025-08-03 at 12:08 -0700, Anthony Yznaga wrote:
> > There was a follow-on fix that addressed a bug with this patch:
> >=20
> > f4b4f3ec1a31 sparc64: add missing initialization of folio in tlb_batch_=
add()
>=20
> Indeed I just tried v6.6 which has this patch and added your sun4u fix an=
d it
> seems to be stable. I was sure I saw problems even with v6.16 though.
>=20
> Let me run more tests.

I'm seeing another crash on v6.16 on sun4u even with your patch applied:

[  456.443492] kernel BUG at fs/ext4/inode.c:1174!
[  456.503059]               \|/ ____ \|/
[  456.503059]               "@'/ .. \`@"
[  456.503059]               /_| \__/ |_\
[  456.503059]                  \__U_/
[  456.696513] apt-get(1217): Kernel bad sw trap 5 [#1]
[  456.761698] CPU: 0 UID: 0 PID: 1217 Comm: apt-get Not tainted 6.16.0+ #2=
4 VOLUNTARY=20
[  456.863502] TSTATE: 0000000011001601 TPC: 0000000010309250 TNPC: 0000000=
010309254 Y: 00000000    Not tainted
[  456.992850] TPC: <ext4_block_write_begin+0x450/0x540 [ext4]>
[  457.067500] g0: 0000000000000000 g1: 0000000000000001 g2: 00000000000000=
00 g3: 0000000000000000
[  457.181869] g4: fff00000141d5c80 g5: 0000000000000008 g6: fff000000be240=
00 g7: 0000000000000001
[  457.296245] o0: 00000000103944b0 o1: 0000000000000496 o2: ffffffffffffff=
bf o3: 0000000000101cca
[  457.410618] o4: 0000000000000000 o5: 0000000000000000 sp: fff000000be26f=
d1 ret_pc: 0000000010309248
[  457.529571] RPC: <ext4_block_write_begin+0x448/0x540 [ext4]>
[  457.604020] l0: fff000003def26e0 l1: 0000000000113cca l2: fff000003def25=
78 l3: 0000000000000002
[  457.718394] l4: 0000000000000000 l5: 0000000000080000 l6: 00000000000120=
00 l7: 0000000000000001
[  457.832770] i0: 0000000000000000 i1: 000c00000026b500 i2: 00000000000010=
00 i3: 0000000000082000
[  457.947146] i4: 00000000103034a0 i5: 0000000000000000 i6: fff000000be270=
c1 i7: 000000001030c8dc
[  458.061528] I7: <ext4_da_write_begin+0x1bc/0x340 [ext4]>
[  458.131389] Call Trace:
[  458.163408] [<000000001030c8dc>] ext4_da_write_begin+0x1bc/0x340 [ext4]
[  458.250447] [<0000000000674230>] generic_perform_write+0x90/0x240
[  458.330606] [<00000000102f50b4>] ext4_buffered_write_iter+0x54/0x120 [ex=
t4]
[  458.422214] [<00000000102f5624>] ext4_file_write_iter+0x3e4/0x780 [ext4]
[  458.510388] [<0000000000749cc4>] vfs_write+0x2c4/0x3e0
[  458.577867] [<0000000000749f4c>] ksys_write+0x4c/0xe0
[  458.644203] [<0000000000749ff4>] sys_write+0x14/0x40
[  458.709397] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
[  458.786048] Disabling lock debugging due to kernel taint
[  458.855904] Caller[000000001030c8dc]: ext4_da_write_begin+0x1bc/0x340 [e=
xt4]
[  458.948653] Caller[0000000000674230]: generic_perform_write+0x90/0x240
[  459.034430] Caller[00000000102f50b4]: ext4_buffered_write_iter+0x54/0x12=
0 [ext4]
[  459.131761] Caller[00000000102f5624]: ext4_file_write_iter+0x3e4/0x780 [=
ext4]
[  459.225648] Caller[0000000000749cc4]: vfs_write+0x2c4/0x3e0
[  459.298846] Caller[0000000000749f4c]: ksys_write+0x4c/0xe0
[  459.370900] Caller[0000000000749ff4]: sys_write+0x14/0x40
[  459.441810] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
[  459.524168] Caller[0000000000000000]: 0x0
[  459.576772] Instruction DUMP:
[  459.576776]  11040e51=20
[  459.615662]  7c04b816=20
[  459.646541]  901220b0=20
[  459.677418] <91d02005>
[  459.708302]  9735a000=20
[  459.739181]  95352000=20
[  459.770076]  d25fa7cf=20
[  459.800945]  7fffe818=20
[  459.831825]  90100019=20
[  459.862706]=20
[  459.941500] systemd[1]: Failed to open /dev/pts device, ignoring: Inappr=
opriate ioctl for device
[  460.063831] systemd[1]: rsyslog.service: Main process exited, code=3Dkil=
led, status=3D6/ABRT
[  460.170962] systemd[1]: rsyslog.service: Failed with result 'signal'.
[  460.267153] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 1.
[  460.388605] systemd[1]: rsyslog.service: Scheduled restart job, restart =
counter is at 1.
[  460.517346] systemd[1]: Starting rsyslog.service - System Logging Servic=
e...
[  460.618299] systemd[1]: Starting systemd-journald.service - Journal Serv=
ice...
[  460.895645] systemd-journald[1237]: Collecting audit messages is disable=
d.
[  461.048068] systemd[1]: Failed to open /dev/pts device, ignoring: Inappr=
opriate ioctl for device
[  461.202783] systemd-journald[1237]: File /var/log/journal/9ac90e257b3e42=
3284cfc21a00cbeeb8/system.journal corrupted or uncleanly shut down, renamin=
g and replacing.
[  461.456867] systemd[1]: Started rsyslog.service - System Logging Service=
.
[  461.616651] systemd-journald[1237]: Time jumped backwards, rotating.
[  461.773305] systemd-journald[1237]: Failed to read journal file /var/log=
/journal/9ac90e257b3e423284cfc21a00cbeeb8/user-1002.journal for rotation, t=
rying to move it out of the way: Device or
resource busy
[  462.065725] systemd[1]: Started systemd-journald.service - Journal Servi=
ce.
[  462.159895] systemd-journald[1237]: Time jumped backwards, rotating.
[  519.719624] kernel BUG at fs/ext4/inode.c:1174!
[  519.779143]               \|/ ____ \|/
[  519.779143]               "@'/ .. \`@"
[  519.779143]               /_| \__/ |_\
[  519.779143]                  \__U_/
[  519.972586] apt(1249): Kernel bad sw trap 5 [#2]
[  520.033239] CPU: 0 UID: 0 PID: 1249 Comm: apt Tainted: G      D         =
    6.16.0+ #24 VOLUNTARY=20
[  520.151048] Tainted: [D]=3DDIE
[  520.188797] TSTATE: 0000000011001603 TPC: 0000000010309250 TNPC: 0000000=
010309254 Y: 00000000    Tainted: G      D           =20
[  520.338725] TPC: <ext4_block_write_begin+0x450/0x540 [ext4]>
[  520.413282] g0: 0000000000000000 g1: 0000000000000001 g2: 00000000000000=
00 g3: 0000000000000000
[  520.527655] g4: fff00000141d40c0 g5: 000000000000000b g6: fff000000a8180=
00 g7: 0000000000000001
[  520.642031] o0: 00000000103944b0 o1: 0000000000000496 o2: fffffffffffffc=
c0 o3: 0000000000101cca
[  520.756408] o4: 0000000000000004 o5: 0000000000000000 sp: fff000000a81af=
d1 ret_pc: 0000000010309248
[  520.875350] RPC: <ext4_block_write_begin+0x448/0x540 [ext4]>
[  520.949799] l0: fff000023439af00 l1: 0000000000113cca l2: fff000023439ad=
98 l3: 0000000000000002
[  521.064174] l4: 0000000000000000 l5: 0000000000080000 l6: 00000000000120=
00 l7: 0000000000000001
[  521.178547] i0: 0000000000000000 i1: 000c000000164a00 i2: 0000000000001f=
c0 i3: 0000000000680000
[  521.292923] i4: 00000000103034a0 i5: 0000000000000000 i6: fff000000a81b0=
c1 i7: 000000001030c8dc
[  521.407297] I7: <ext4_da_write_begin+0x1bc/0x340 [ext4]>
[  521.477195] Call Trace:
[  521.509295] [<000000001030c8dc>] ext4_da_write_begin+0x1bc/0x340 [ext4]
[  521.596330] [<0000000000674230>] generic_perform_write+0x90/0x240
[  521.676495] [<00000000102f50b4>] ext4_buffered_write_iter+0x54/0x120 [ex=
t4]
[  521.768196] [<00000000102f5624>] ext4_file_write_iter+0x3e4/0x780 [ext4]
[  521.856381] [<0000000000749cc4>] vfs_write+0x2c4/0x3e0
[  521.923957] [<0000000000749f4c>] ksys_write+0x4c/0xe0
[  521.990294] [<0000000000749ff4>] sys_write+0x14/0x40
[  522.055486] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
[  522.132122] Caller[000000001030c8dc]: ext4_da_write_begin+0x1bc/0x340 [e=
xt4]
[  522.224873] Caller[0000000000674230]: generic_perform_write+0x90/0x240
[  522.310649] Caller[00000000102f50b4]: ext4_buffered_write_iter+0x54/0x12=
0 [ext4]
[  522.407974] Caller[00000000102f5624]: ext4_file_write_iter+0x3e4/0x780 [=
ext4]
[  522.501864] Caller[0000000000749cc4]: vfs_write+0x2c4/0x3e0
[  522.575062] Caller[0000000000749f4c]: ksys_write+0x4c/0xe0
[  522.647118] Caller[0000000000749ff4]: sys_write+0x14/0x40
[  522.718031] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
[  522.800380] Caller[0000000000000000]: 0x0
[  522.852991] Instruction DUMP:
[  522.852994]  11040e51=20
[  522.891878]  7c04b816=20
[  522.922760]  901220b0=20
[  522.953638] <91d02005>
[  522.984521]  9735a000=20
[  523.015401]  95352000=20
[  523.046284]  d25fa7cf=20
[  523.077163]  7fffe818=20
[  523.108109]  90100019=20
[  523.139044]

I'll try to bisect this one later this week.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

