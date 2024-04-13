Return-Path: <linux-arch+bounces-3649-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97D08A3BDD
	for <lists+linux-arch@lfdr.de>; Sat, 13 Apr 2024 11:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FD61C20D71
	for <lists+linux-arch@lfdr.de>; Sat, 13 Apr 2024 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F23D544;
	Sat, 13 Apr 2024 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BRfOI827"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B83A8F0
	for <linux-arch@vger.kernel.org>; Sat, 13 Apr 2024 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712999478; cv=none; b=ppRyCVuZCUNFlbDQyxn96/qAC7DA14/zXRuFckMnQMedQosUGm9E8c6U1mp9jVP1/TlKWG2Za6JoKsdGEbVm9MO1+mVKBQV8z5PSpeWMpuJbP2WvEEvKEJA4s0U02y7VTbUra3k9X7Tg0XNsfXTa6I1Ol9Eh870N3GvGjXClVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712999478; c=relaxed/simple;
	bh=3Wceu16B5STblVGBktGLSg/Q/Lx09Ya+fP91S/KZs5c=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Kym7yiDghsF7w6yUSWWb7mNcYvHsgQAs/hr1f2vhkFLGf6o3SK5H9Bp5R3s3jWRmvVQlC3CvqXArzCBJ3tGI3SSSF0m/8KZOUXM9e4ot82io+ce/8+cvuzyzSbZIHX8OLBmZIdbrhjpSWirAXsgtHON0RkQ2EP8eD0W58lj1r+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BRfOI827; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712999467; x=1713258667;
	bh=3Wceu16B5STblVGBktGLSg/Q/Lx09Ya+fP91S/KZs5c=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BRfOI827xNmuPHGyb740e7y8PyCWXsdkUknVv6J+q+REvXv5YFBdmQsHLhf7mfeiY
	 7HKTwRLf3LfumFDrO9wTd7p+08rynLYWlVbHhbo1T+nZ+py4/lpkD7w25UgYGW7Cqp
	 WideIsgBNAfVV5/4NG2aD8PS7KWxz+Hu5R9PCPjwf+NeYhb2ZPIjQFdrAHrmYShkHt
	 xk5kNTyAqK6njfuuePy8ol7MUN+WEqoDlKjKoRe4sgrJL6NCPEQDu+iC6vmjKN2VTe
	 hBJNvZzrK0iNaiz4UIZHgQ3oXg3soqaVrc4tOGKzkHypZHITS2Od449Hz7paNpgrvF
	 8341SeQCXJWNw==
Date: Sat, 13 Apr 2024 09:10:59 +0000
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
From: public1020 <public1020@proton.me>
Subject: Figure out why kdump is not producing dmesg in CentOS stream 8
Message-ID: <dKQ2ox6nTKV-eeaYajuxSH6wImrjgdyguBDyqmIn6rqJZupzopGIA9IUjrpBWR6BSdmdXQjRV-VrA-6e1ffpP_JfGI_ilc_VVtoU6qgUHtY=@proton.me>
Feedback-ID: 74140009:user:proton
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I created a CentOS 8 stream machine on aws, and configured crashkernel in g=
rub
```
$ cat /proc/cmdline
BOOT_IMAGE=3D(hd0,msdos1)/boot/vmlinuz-4.18.0-552.el8.x86_64 root=3DUUID=3D=
e52ef623-609b-4202-9b2c-ac7aba5c3bee ro console=3DttyS0,115200n8 no_timer_c=
heck net.ifnames=3D0 nvme_core.io_timeout=3D4294967295 nvme_core.max_retrie=
s=3D10 crashkernel=3D128M
```

Then I installed and verified kdump is functioning

```
# systemctl status kdump
=E2=97=8F kdump.service - Crash recovery kernel arming
=C2=A0 =C2=A0Loaded: loaded (/usr/lib/systemd/system/kdump.service; enabled=
; vendor preset: enabled)
=C2=A0 =C2=A0Active: active (exited) since Sat 2024-04-13 08:42:55 UTC; 40s=
 ago
=C2=A0 Process: 808 ExecStart=3D/usr/bin/kdumpctl start (code=3Dexited, sta=
tus=3D0/SUCCESS)
=C2=A0Main PID: 808 (code=3Dexited, status=3D0/SUCCESS)

Apr 13 08:42:43 ip-172-31-2-139.ap-east-1.compute.internal dracut[1101]: **=
* Install squash loader ***
Apr 13 08:42:43 ip-172-31-2-139.ap-east-1.compute.internal dracut[1101]: **=
* Stripping files ***
Apr 13 08:42:44 ip-172-31-2-139.ap-east-1.compute.internal dracut[1101]: **=
* Stripping files done ***
Apr 13 08:42:44 ip-172-31-2-139.ap-east-1.compute.internal dracut[1101]: **=
* Squashing the files inside the initramfs ***
Apr 13 08:42:54 ip-172-31-2-139.ap-east-1.compute.internal dracut[1101]: **=
* Squashing the files inside the initramfs done ***
Apr 13 08:42:54 ip-172-31-2-139.ap-east-1.compute.internal dracut[1101]: **=
* Creating image file '/boot/initramfs-4.18.0-552.el8.x86_64kdump.img' ***
Apr 13 08:42:55 ip-172-31-2-139.ap-east-1.compute.internal dracut[1101]: **=
* Creating initramfs image file '/boot/initramfs-4.18.0-552.el8.x86_64kdump=
.img' done ***
Apr 13 08:42:55 ip-172-31-2-139.ap-east-1.compute.internal kdumpctl[814]: k=
dump: kexec: loaded kdump kernel
Apr 13 08:42:55 ip-172-31-2-139.ap-east-1.compute.internal kdumpctl[814]: k=
dump: Starting kdump: [OK]
Apr 13 08:42:55 ip-172-31-2-139.ap-east-1.compute.internal systemd[1]: Star=
ted Crash recovery kernel arming.
```

Now I need to mimic kernel crash, so I used sysrq to do that

```
echo c > /proc/sysrq-trigger
```

However, after reboot, I didn't see a dmesg file in /var/crash as in CentOS=
 7.X

```
# ls /var/crash
- nothing, empty folder -
```

The only thing I can see is /var/log/kdump.log

```
+ 2024-04-13 08:35:56 /usr/bin/kdumpctl@679: ret=3D0
+ 2024-04-13 08:35:56 /usr/bin/kdumpctl@680: set +x
+ 2024-04-13 08:42:55 /usr/bin/kdumpctl@675: /sbin/kexec -s -d -p '--comman=
d-line=3DBOOT_IMAGE=3D(hd0,msdos1)/boot/vmlinuz-4.18.0-552.el8.x86_64 ro co=
nsole=3DttyS0,115200n8 no_timer_check net.ifnames=3D0 nvme_core.io_timeout=
=3D4294967295 nvme_core.max_retries=3D10 irqpoll nr_cpus=3D1 reset_devices =
cgroup_disable=3Dmemory mce=3Doff numa=3Doff udev.children-max=3D2 panic=3D=
10 rootflags=3Dnofail acpi_no_memhotplug transparent_hugepage=3Dnever nokas=
lr novmcoredd hest_disable disable_cpu_apicid=3D0' --initrd=3D/boot/initram=
fs-4.18.0-552.el8.x86_64kdump.img /boot/vmlinuz-4.18.0-552.el8.x86_64
Try gzip decompression.
Try LZMA decompression.
+ 2024-04-13 08:42:55 /usr/bin/kdumpctl@679: ret=3D0
+ 2024-04-13 08:42:55 /usr/bin/kdumpctl@680: set +x
+ 2024-04-13 08:44:31 /usr/bin/kdumpctl@675: /sbin/kexec -s -d -p '--comman=
d-line=3DBOOT_IMAGE=3D(hd0,msdos1)/boot/vmlinuz-4.18.0-552.el8.x86_64 ro co=
nsole=3DttyS0,115200n8 no_timer_check net.ifnames=3D0 nvme_core.io_timeout=
=3D4294967295 nvme_core.max_retries=3D10 irqpoll nr_cpus=3D1 reset_devices =
cgroup_disable=3Dmemory mce=3Doff numa=3Doff udev.children-max=3D2 panic=3D=
10 rootflags=3Dnofail acpi_no_memhotplug transparent_hugepage=3Dnever nokas=
lr novmcoredd hest_disable disable_cpu_apicid=3D0' --initrd=3D/boot/initram=
fs-4.18.0-552.el8.x86_64kdump.img /boot/vmlinuz-4.18.0-552.el8.x86_64
Try gzip decompression.
Try LZMA decompression.
+ 2024-04-13 08:44:31 /usr/bin/kdumpctl@679: ret=3D0
+ 2024-04-13 08:44:31 /usr/bin/kdumpctl@680: set +x
```

I need the dmesg to understand what's causing the crash. How can I do that?

P.S I have a kernel module that triggers a crash but I don't know why, and =
to demonstrated the problem with kdump, I use sysrq so anyone want to help =
can easily reproduce it.

