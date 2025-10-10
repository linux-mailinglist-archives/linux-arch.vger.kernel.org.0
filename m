Return-Path: <linux-arch+bounces-13996-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7715BCC647
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 11:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A1355183
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBFC2C2368;
	Fri, 10 Oct 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc/QyZ0r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F152C158E
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089291; cv=none; b=MeNILbLPL2ped87Y63BddDMU3zvzEWllrlNN7XTFVzTibk7KZ1twxM75hcQlvD3RJSfCR46ps72vUHpw53iPYT2xp8OVnGI9YfNI3En3Kv5+WTwcM0af5oi2FuhXm0xl/Ej/5nZab085kt0xnU/7NinbsldH65bQFDV7JPhnWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089291; c=relaxed/simple;
	bh=MuTIfJDXeKuuHRy0YR/4p4wSgA5RdL8NKtUcZ5ZUNMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPHsc04kVgTQVC1RzhtJmPN3U0yEVHebyc2GMyaFq5wtyC2T5C1b/oJc1iiy0zg81qw/SZ9iApf/xAJJ/V26IHg9V4P3ybCXYpjxGrblqywo4oL2MOOl6PRyklj7LFTXOoT/q3/nVtSLWDMkLuU+g/NcHjGztXW7SbbwhVYxwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc/QyZ0r; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so926148f8f.1
        for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760089279; x=1760694079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq9sBzt27xhVE00MKRZHgRlmEb4HHQG1wzN2xa1Axvc=;
        b=bc/QyZ0rRHG7Q1K/vSrqIr/YpYXynHJ/dwTYESMEMqgNGtN3lObS7c/K2Bx/WiE3LH
         KYaIf6Zy8LCjvEmabKooSgLqRpGBLzEkTalJ2DiNdbLYNLoYj63Xc9eX3Xzxw2G59vns
         HynK9okqQ9jqMS0e84RxzpBb6WHXCCZjEUXVVodrqFqiMm6krfZ42/Xo3K1i5hQxU9/u
         tJ2h94r5/yYjD5IytOC+NGoXDOFbUVPOOpwqpaSZadqdkuZnV3/c9z4YSrdyqOSEPkBA
         psvrXgefmXTgmWA9fQAL2946jSt6A+jDZ/Y4C0HbiWz/7+TZG5yfZtDZNzCdNCaJM/Fz
         38nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089279; x=1760694079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq9sBzt27xhVE00MKRZHgRlmEb4HHQG1wzN2xa1Axvc=;
        b=NyHrkZFxoC4mM+NMVhAkla/YW5MVup0fYca6BvmzOximnTjtElqR16u7yBsIu6jsa2
         NRaTqvkqkLOvHOVjc+6rfKlHU9aN9VcnOvHbFAxXa7ecG8wxukvbDUy5RTNnSR8Fhlm2
         /DWSxgAImhmD8+g+//rRy+qyYz5TS2isGm0X1SVAZdp/Iq2yT8sKNcIPvCsXwFkEbfT3
         asjkElFJXnKyPoSrUpLwiAHMLa0ymYHH1XDqsiVnILeKcDzUQQSWg4VbKjoTrfiA7TaX
         Xt8gK5SVs6gUpGsSUO5kKgJ5BuwCao8AidityBt4l7tDRSckGJX5+/D0m8H69k6QbzMq
         IR/A==
X-Forwarded-Encrypted: i=1; AJvYcCXpOB9Y0V0pbRJxskxLyloysnJzh19AOaHeYV1axlKsAKNBCjjFVF2K3b8zjocQ8o+x006kozIgsbSn@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFUSGl/jUnxyG0Lg2ygy4bgkNGYhioTo/olFDbsgMHY6KL+E1
	W1vRnnLVDOmqVuKaWV2+dckI6JLYSizdGKV79fbGGMqQV4NmdhcnyoKY
X-Gm-Gg: ASbGncsEV++Yub5UZ6w7pOeqUYrOOZ2BpZIlbNGY0PBpvI9XAoPQlgVA6jipr+Jjzep
	zvAU28r6HxOKj0cAMo5z4hh1KFc+ZkKYr5e+ff2NVWIMn6i1LMa0aHOzI5IQ5+qn5biTScWnevE
	WEB05ZV+sUDF0IsNkoDmVdjIs5zsS03DwOh1ylZZrS9VPckNSyI+9jNEJVoS9AHZVEUO4zPuWdd
	ZfN2+cu+orPzZxxN75zGd1k7BL6iXMHqvLbdvzT7QzoRTgbNyoHs2bIavkxhykaxxS2ni3iADCN
	96B2wUcJy1iwUXLtYCjMFcizRUUqiEFmytwyxy5z2KUNSrOhBbPFgVHpcWaBErGBv36+abNom7F
	F8VtjQ/euoRwLuDJSHT3DLINv1a2ak136kGNatw==
X-Google-Smtp-Source: AGHT+IF3lD9WVSidKuzagqFJR/FrlQ6zmxKPnguDbIw0mAThtrjLUEb36T/KN6an53yanBEG5SPxvw==
X-Received: by 2002:a05:6000:186f:b0:425:75b7:4b67 with SMTP id ffacd0b85a97d-4266e8da717mr6986662f8f.58.1760089278315;
        Fri, 10 Oct 2025 02:41:18 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce582b44sm3304938f8f.16.2025.10.10.02.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 02:41:17 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v2 0/3] initrd: remove half of classic initrd support
Date: Fri, 10 Oct 2025 09:40:44 +0000
Message-ID: <20251010094047.3111495-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intro
====
This patchset removes half of classic initrd (initial RAM disk) support,
i. e. linuxrc code path, which was deprecated in 2020.
Initramfs still stays, RAM disk itself (brd) still stays.
And other half of initrd stays, too.
init/do_mounts* are listed in VFS entry in
MAINTAINERS, so I think this patchset should go through VFS tree.
I tested the patchset on 8 (!!!) archs in Qemu (see details below).
If you still use initrd, see below for workaround.

In 2020 deprecation notice was put to linuxrc initrd code path.
In previous version of this patchset I tried to remove initrd
fully, but Nicolas Schichan reported that he still uses
other code path (root=/dev/ram0 one) on million devices [4].
root=/dev/ram0 code path did not contain deprecation notice.

So, in this version of patchset I remove deprecated code path,
i. e. linuxrc one, while keeping other, i. e. root=/dev/ram0 one.

Also I put deprecation notice to remaining code path, i. e. to
root=/dev/ram0 one. I plan to send patches for full removal
of initrd after one year, i. e. in September 2026 (of course,
initramfs will still work).

Also, I tried to make this patchset small to make sure it
can be reverted easily. I plan to send cleanups later.

Details
====
Other user-visible changes:

- Removed kernel command line parameters "load_ramdisk" and
"prompt_ramdisk", which did nothing and were deprecated
- Removed /proc/sys/kernel/real-root-dev . It was used
for initrd only
- Command line parameters "noinitrd" and "ramdisk_start=" are deprecated

This patchset is based on current mainline (7f7072574127).

Testing
====
I tested my patchset on many architectures in Qemu using my Rust
program, heavily based on mkroot [1].

I used the following cross-compilers:

aarch64-linux-musleabi
armv4l-linux-musleabihf
armv5l-linux-musleabihf
armv7l-linux-musleabihf
i486-linux-musl
i686-linux-musl
mips-linux-musl
mips64-linux-musl
mipsel-linux-musl
powerpc-linux-musl
powerpc64-linux-musl
powerpc64le-linux-musl
riscv32-linux-musl
riscv64-linux-musl
s390x-linux-musl
sh4-linux-musl
sh4eb-linux-musl
x86_64-linux-musl

taken from this directory [2].

So, as you can see, there are 18 triplets, which correspond to 8 subdirs in arch/.

For every triplet I tested that:
- Initramfs still works (both builtin and external)
- Direct boot from disk still works
- Remaining initrd code path (root=/dev/ram0) still works

Workaround
====
If "retain_initrd" is passed to kernel, then initramfs/initrd,
passed by bootloader, is retained and becomes available after boot
as read-only magic file /sys/firmware/initrd [3].

No copies are involved. I. e. /sys/firmware/initrd is simply
a reference to original blob passed by bootloader.

This works even if initrd/initramfs is not recognized by kernel
in any way, i. e. even if it is not valid cpio archive, nor
a fs image supported by classic initrd.

This works both with my patchset and without it.

This means that you can emulate classic initrd so:
link builtin initramfs to kernel; in /init in this initramfs
copy /sys/firmware/initrd to some file in / and loop-mount it.

This is even better than classic initrd, because:
- You can use fs not supported by classic initrd, for example erofs
- One copy is involved (from /sys/firmware/initrd to some file in /)
as opposed to two when using classic initrd

Still, I don't recommend using this workaround, because
I want everyone to migrate to proper modern initramfs.
But still you can use this workaround if you want.

Also: it is not possible to directly loop-mount
/sys/firmware/initrd . Theoretically kernel can be changed
to allow this (and/or to make it writable), but I think nobody needs this.
And I don't want to implement this.

On Qemu's -initrd and GRUB's initrd
====
Don't panic, this patchset doesn't remove initramfs
(which is used by nearly all Linux distros). And I don't
have plans to remove it.

Qemu's -initrd option and GRUB's initrd command refer
to initrd bootloader mechanism, which is used to
load both initrd and (external) initramfs.

So, if you use Qemu's -initrd or GRUB's initrd,
then you likely use them to pass initramfs, and thus
you are safe.

v1: https://lore.kernel.org/lkml/20250913003842.41944-1-safinaskar@gmail.com/

v1 -> v2 changes:
- A lot. I removed most patches, see cover letter for details

[1] https://github.com/landley/toybox/tree/master/mkroot
[2] https://landley.net/toybox/downloads/binaries/toolchains/latest
[3] https://lore.kernel.org/all/20231207235654.16622-1-graf@amazon.com/
[4] https://lore.kernel.org/lkml/20250918152830.438554-1-nschichan@freebox.fr/

Askar Safin (3):
  init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command
    line parameters
  initrd: remove deprecated code path (linuxrc)
  init: remove /proc/sys/kernel/real-root-dev

 .../admin-guide/kernel-parameters.txt         |   8 +-
 Documentation/admin-guide/sysctl/kernel.rst   |   6 -
 arch/arm/configs/neponset_defconfig           |   2 +-
 fs/init.c                                     |  14 ---
 include/linux/init_syscalls.h                 |   1 -
 include/linux/initrd.h                        |   2 -
 include/uapi/linux/sysctl.h                   |   1 -
 init/do_mounts.c                              |  11 +-
 init/do_mounts.h                              |  18 +--
 init/do_mounts_initrd.c                       | 105 +-----------------
 init/do_mounts_rd.c                           |  24 +---
 11 files changed, 18 insertions(+), 174 deletions(-)


base-commit: 7f7072574127c9e971cad83a0274e86f6275c0d5
-- 
2.47.3


