Return-Path: <linux-arch+bounces-13544-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9600B55C55
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 03:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043251CC7DAB
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 01:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776DE19AD8B;
	Sat, 13 Sep 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8rWdZ3v"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722E14A60C
	for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725316; cv=none; b=ueN7oZ4kCZN+6QIn85ixcdXLl2/60va5t5OBdaHZ7Uex1drwObbC7/COKg/83tnFikp90u2FClv+srF08Amky/4Lp6XxCsvxr87k/LKoZfEhXcCutuiDc8AFj4ILvjddFXDDPg1hWLrgSdqUruvVUs1jKUu8sbCeCk0PgC+t8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725316; c=relaxed/simple;
	bh=ZZkhjwhbE6/y3ircTGqTXeD3vHrC5P1n1IkbBCMXiHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhp/d891OI+a6pfYxBFXG3GoFInb1avbgYfNitUk2USGbgYbOx3zl/z33TwBOCyPEduVc4XyFJtonjambq4BkVYW23GK1KfxQgYJ+kjhbIr+kkho5/NgWGCt3gEGBUyTD0rQxcrHocJm/sPicNBCwwtEFDigto9jm7EgQEmYf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8rWdZ3v; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07c38680b3so226982766b.1
        for <linux-arch@vger.kernel.org>; Fri, 12 Sep 2025 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725311; x=1758330111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZEc0E3RkrtT53PvUmeExPdZ+yV/ZVWq9ufU5BOWTEg=;
        b=Q8rWdZ3vPQO1IDpapVGlhe3nSOw6j7XOwKTltsOQUoqihFACKG7eINVSNY+6Egf1rz
         90lgEMndfc+LJNqp6Bw9t8ThVQ9YcGTLnXt4oOQQjnIiW539pIwvpIKLF2/M1970rnmG
         pF64Klv2fcCQ12ZentyM3dPxge5HtBxxT1o0lSI5zeEIQ6oEBFm+nmc0OIU8DRXsa8AF
         PHG5ixPgYhjikb9K0Kk7wBIAta4uu/bmCq+LgT6KPw9CuIbMv9L+7pWh69ssFc/sVlxg
         2+UB7ZZgZABxPVpf6CdhmNDZ+v4yJor6u01ZLFjrHuprYzxjaWXtkZ0Xqy+GHquIIOw7
         6Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725311; x=1758330111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZEc0E3RkrtT53PvUmeExPdZ+yV/ZVWq9ufU5BOWTEg=;
        b=MzQ0HFQ9kAaM9U2usCM994dkTVJ+9RWeB3nXXbdccwMDhvcHS3q7PHV6Q3o40k4guo
         2Pred9CrHDAiCiYQXKTAl1JsTrDkhpw5tbxGnceXw0+xFq2FL2+9eAxoMtplNAmCKcnh
         ZseXzPFzFsks0iTlWwweMUS9/Et/KU4bt4SW9dT+C33VU80eSQ0PMQ6q1XRliASGiiVV
         KCgJ13R2kb14Af5NpJz0LWvHNNUih9Wd9ijCYfJsWivmJqZawjg9yD1Yi/LFV5fbmK/t
         rcVFILvcJDaR+nAJA6WkAhsA/5yNHN8rVzJrGA45XnBNndA9ea8cwcSNwG2vLxPYby90
         L3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWA7K6I3J4STscFwkkt+jtDEwpucLIgLAYQMTgrTw1sxHeWRsEx0kVBWnhs5xfvVgTh/7mWa8TrNLLK@vger.kernel.org
X-Gm-Message-State: AOJu0YyEH7sTVY0RYv8d5YyIffqPmujqI5m9cVzGSpLXAe/JVThr8iXa
	vhPmraKzUZVWb3fqTu9WJbgY8PPFvtPAfE48CYHWmyII6y/zuBtmBVfY
X-Gm-Gg: ASbGncs+F82BVVUeb+zBywN/sZKPjqlCgsIMpWTditG7wxqFjhxLkMUraAZdBDrOUjY
	q8D1K5Hbg73tFet0s+g4TrLmnYUq3bhbKqx2bI+8KnpBKdQsLVI+lQuYUkvio1uuKCIdBLaSflN
	Ri/6JG2QSRBPub/VGs/dmzNkl7lItumqotG1W+D52CG+q5I2qVrGCYE+f77w2ZGqWnxKWjjUkGG
	N7OftMtXoCl/hUdcwa45ogqF9QNQuqkLQvD9f4YGBKGlyskesXcEOndUn9T8cE8PoZpNFVRjtrB
	ZyIbRA0m5nV2ELD98Y6P74TMU0C8g9tORxTMdxd6F0vWmyD0InMK2odlm0g/R3AdkNihYMovE9p
	XVDLE8IA3vSGZzg5rK5P6yR+Hiyd0ww==
X-Google-Smtp-Source: AGHT+IEAi4xtonmhCaT33K2Hzh7yyRfMcFV0HvMSUAxXUtkPqhwfRFML0tJIQIoV7OGJ/h1kr7fV7w==
X-Received: by 2002:a17:907:3d0c:b0:b04:7880:3e8c with SMTP id a640c23a62f3a-b07c3820252mr475574166b.38.1757725311044;
        Fri, 12 Sep 2025 18:01:51 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b317124esm476784166b.46.2025.09.12.18.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:01:50 -0700 (PDT)
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
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 20/62] doc: remove Documentation/power/swsusp-dmcrypt.rst
Date: Sat, 13 Sep 2025 00:37:59 +0000
Message-ID: <20250913003842.41944-21-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It contains obsolete initrd and lilo based instructions

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/power/index.rst                 |   1 -
 Documentation/power/swsusp-dmcrypt.rst        | 140 ------------------
 .../translations/zh_CN/power/index.rst        |   1 -
 3 files changed, 142 deletions(-)
 delete mode 100644 Documentation/power/swsusp-dmcrypt.rst

diff --git a/Documentation/power/index.rst b/Documentation/power/index.rst
index a0f5244fb427..9f1758c92e48 100644
--- a/Documentation/power/index.rst
+++ b/Documentation/power/index.rst
@@ -22,7 +22,6 @@ Power Management
     suspend-and-cpuhotplug
     suspend-and-interrupts
     swsusp-and-swap-files
-    swsusp-dmcrypt
     swsusp
     video
     tricks
diff --git a/Documentation/power/swsusp-dmcrypt.rst b/Documentation/power/swsusp-dmcrypt.rst
deleted file mode 100644
index afb29a58fdf8..000000000000
--- a/Documentation/power/swsusp-dmcrypt.rst
+++ /dev/null
@@ -1,140 +0,0 @@
-=======================================
-How to use dm-crypt and swsusp together
-=======================================
-
-Author: Andreas Steinmetz <ast@domdv.de>
-
-
-
-Some prerequisites:
-You know how dm-crypt works. If not, visit the following web page:
-http://www.saout.de/misc/dm-crypt/
-You have read Documentation/power/swsusp.rst and understand it.
-You did read Documentation/filesystems/ramfs-rootfs-initramfs.rst and know how an initrd works.
-You know how to create or how to modify an initrd.
-
-Now your system is properly set up, your disk is encrypted except for
-the swap device(s) and the boot partition which may contain a mini
-system for crypto setup and/or rescue purposes. You may even have
-an initrd that does your current crypto setup already.
-
-At this point you want to encrypt your swap, too. Still you want to
-be able to suspend using swsusp. This, however, means that you
-have to be able to either enter a passphrase or that you read
-the key(s) from an external device like a pcmcia flash disk
-or an usb stick prior to resume. So you need an initrd, that sets
-up dm-crypt and then asks swsusp to resume from the encrypted
-swap device.
-
-The most important thing is that you set up dm-crypt in such
-a way that the swap device you suspend to/resume from has
-always the same major/minor within the initrd as well as
-within your running system. The easiest way to achieve this is
-to always set up this swap device first with dmsetup, so that
-it will always look like the following::
-
-  brw-------  1 root root 254, 0 Jul 28 13:37 /dev/mapper/swap0
-
-Now set up your kernel to use /dev/mapper/swap0 as the default
-resume partition, so your kernel .config contains::
-
-  CONFIG_PM_STD_PARTITION="/dev/mapper/swap0"
-
-Prepare your boot loader to use the initrd you will create or
-modify. For lilo the simplest setup looks like the following
-lines::
-
-  image=/boot/vmlinuz
-  initrd=/boot/initrd.gz
-  label=linux
-  append="root=/dev/ram0 init=/linuxrc rw"
-
-Finally you need to create or modify your initrd. Lets assume
-you create an initrd that reads the required dm-crypt setup
-from a pcmcia flash disk card. The card is formatted with an ext2
-fs which resides on /dev/hde1 when the card is inserted. The
-card contains at least the encrypted swap setup in a file
-named "swapkey". /etc/fstab of your initrd contains something
-like the following::
-
-  /dev/hda1   /mnt    ext3      ro                            0 0
-  none        /proc   proc      defaults,noatime,nodiratime   0 0
-  none        /sys    sysfs     defaults,noatime,nodiratime   0 0
-
-/dev/hda1 contains an unencrypted mini system that sets up all
-of your crypto devices, again by reading the setup from the
-pcmcia flash disk. What follows now is a /linuxrc for your
-initrd that allows you to resume from encrypted swap and that
-continues boot with your mini system on /dev/hda1 if resume
-does not happen::
-
-  #!/bin/sh
-  PATH=/sbin:/bin:/usr/sbin:/usr/bin
-  mount /proc
-  mount /sys
-  mapped=0
-  noresume=`grep -c noresume /proc/cmdline`
-  if [ "$*" != "" ]
-  then
-    noresume=1
-  fi
-  dmesg -n 1
-  /sbin/cardmgr -q
-  for i in 1 2 3 4 5 6 7 8 9 0
-  do
-    if [ -f /proc/ide/hde/media ]
-    then
-      usleep 500000
-      mount -t ext2 -o ro /dev/hde1 /mnt
-      if [ -f /mnt/swapkey ]
-      then
-        dmsetup create swap0 /mnt/swapkey > /dev/null 2>&1 && mapped=1
-      fi
-      umount /mnt
-      break
-    fi
-    usleep 500000
-  done
-  killproc /sbin/cardmgr
-  dmesg -n 6
-  if [ $mapped = 1 ]
-  then
-    if [ $noresume != 0 ]
-    then
-      mkswap /dev/mapper/swap0 > /dev/null 2>&1
-    fi
-    echo 254:0 > /sys/power/resume
-    dmsetup remove swap0
-  fi
-  umount /sys
-  mount /mnt
-  umount /proc
-  cd /mnt
-  pivot_root . mnt
-  mount /proc
-  umount -l /mnt
-  umount /proc
-  exec chroot . /sbin/init $* < dev/console > dev/console 2>&1
-
-Please don't mind the weird loop above, busybox's msh doesn't know
-the let statement. Now, what is happening in the script?
-First we have to decide if we want to try to resume, or not.
-We will not resume if booting with "noresume" or any parameters
-for init like "single" or "emergency" as boot parameters.
-
-Then we need to set up dmcrypt with the setup data from the
-pcmcia flash disk. If this succeeds we need to reset the swap
-device if we don't want to resume. The line "echo 254:0 > /sys/power/resume"
-then attempts to resume from the first device mapper device.
-Note that it is important to set the device in /sys/power/resume,
-regardless if resuming or not, otherwise later suspend will fail.
-If resume starts, script execution terminates here.
-
-Otherwise we just remove the encrypted swap device and leave it to the
-mini system on /dev/hda1 to set the whole crypto up (it is up to
-you to modify this to your taste).
-
-What then follows is the well known process to change the root
-file system and continue booting from there. I prefer to unmount
-the initrd prior to continue booting but it is up to you to modify
-this.
diff --git a/Documentation/translations/zh_CN/power/index.rst b/Documentation/translations/zh_CN/power/index.rst
index bc54983ba515..4ee880e65107 100644
--- a/Documentation/translations/zh_CN/power/index.rst
+++ b/Documentation/translations/zh_CN/power/index.rst
@@ -32,7 +32,6 @@ TODOList:
     * suspend-and-cpuhotplug
     * suspend-and-interrupts
     * swsusp-and-swap-files
-    * swsusp-dmcrypt
     * swsusp
     * video
     * tricks
-- 
2.47.2


