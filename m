Return-Path: <linux-arch+bounces-13539-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A23DB55BFE
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 02:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3996AA43C0
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 00:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD3145B27;
	Sat, 13 Sep 2025 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtiqmCR7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416B139D0A
	for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724990; cv=none; b=kJFIAeD2wevy0bPr9mpTww2PbS4KTUc7Yli0NaXMfpfsm4gXJK0i37U2SNS3FH/MI1XoznDZqkpPo8pWYgMe0GtFCJFI7X29KJcsk+MJtJ3ggMFEs3HGcE58KlzWX9djymxT07CsQIk/j+OoEQUt9cYAmsRZTOYyFIX8MUvnL80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724990; c=relaxed/simple;
	bh=ds9VwpQCIQQEuVYbVkP08KSVWpcFcJ5JA8drV9AyvVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbXFnaiafaDYqx2ZOkZbqhfzKI2YmWTmY65mwbpX8ydKqUaWrtdmom1+nrv9dpQfn+7TTi7Dxd8k54X8gZeB7KVKMBtmGOBFvhhyZxcr9anStb0mspI+5IqVX4nCjzsTsJU+hlZdHW72sjHOJhT6Q+5+Iooi2h+sfgLoWflHTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtiqmCR7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0428b537e5so362615466b.3
        for <linux-arch@vger.kernel.org>; Fri, 12 Sep 2025 17:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724984; x=1758329784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57Y6Vt+tKEG1ezrQxMY6sE7xxEuIy1GPZf6G9mOPdfs=;
        b=dtiqmCR7q8fQrujZcyidoHKzEpXWqVzSbJIyCLsw+S+iaLSpeTjjIImksv6bHWz8s5
         EgMR9qHWRbW+iJ407fN+pRg39jUca5A1RrVCXvryTRkSsCcCRBy7P8v/FjEM2cRULRB/
         Upqt8LUSyYMlpcM2ayIWDP+BuzU7VOzcL0cpdFD/Ypy5kblfRtosXml1v3sfFVyN/CSa
         JaTNPvO43NqTjObdxSrK5wQJ1Nl7QGp/hZaetC2Pg7WLtW0MrNVRtn+Mr877NBUqheaD
         OHVkjgU9fMp/bkTsjOZNPYOvxpS/AbSfChUCHmTHyYL0QF7CELgSjnc2KdPW5fuJspg+
         Nmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724984; x=1758329784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57Y6Vt+tKEG1ezrQxMY6sE7xxEuIy1GPZf6G9mOPdfs=;
        b=OoZmmLLwj9vPyoIpNQOg/i3olLmm/uAmhfr6e5+53+u5kY8tarVtuxUomhOuZGhDaE
         ae27+dzdO38aYn+xnLlL9c4PEvvXtknTG0qH49MuX50vqnIpNvdbdkEcswbhqbIVt8j+
         90D3TI6dmeJnMA8NLVFW9ZKqssIk6oc0xNJ7RbtOfRJyT7pYgDqIbwMwHTqJg8ZZuhSc
         MkKU3rlp+yBR0GOSZkp3KuUNBF+twB74QIjYKSma/4Jg6CQzsWkmI/ycwPLF4uK4roth
         3Dx25zaOixVECAfymJYH+mTFJubbVuZLcbvLM9WeYeoUSBCokLoZn8V5pZ2/T271vifH
         aZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUil/OrLm4hIXMQZDMQB7DjXPXqu/hyz/MYleBslzE9Qp/ztOUUKrh8kvUMDIAbWADrkPEb/L9RcTSq@vger.kernel.org
X-Gm-Message-State: AOJu0YwjV8M998FeAMw3mjS6Hoa9kxietN+BI9hr7AGc+TNhNEjDg/k4
	6oCpqFzGp3sKYjmxUpqKkH8gHSB1nK9ZmQ9c2NojxQAbPyEx/fBTlHit
X-Gm-Gg: ASbGncsnSPCBG1I/mGSV8l1RB0FRChbQFWVKbhnhsO/Nhyc2w31ZGrxPKJJ9rMVyoFb
	/t66M0p4RZvt7FWkD221WDBb9uaU72YOmJqm0iF8ESlEHwnXNzqnWE8G5JHaUnOsMC6qD4p7yqv
	1fEOsiE5cMpn6qt2Bk5+rBPWTpyEemaEHkL1IZHunTsMmGydoC9nRx3kh5jtnZB8R4CMwh11ybo
	o2sFExV4k2dlUt062scx73jf/2WbaV1QQMecfKRIAskBfneezhUPy2KCqe/eA1sm5aGEwtoKftz
	PqZnS6LWpts/4ObiBYSXhF1tkdRSyR3dgUmQc0RVE1Jk3w8BCWE/NfyaKeMU35BjjyxgtTgOjnk
	Kj3rrJsdd+X1vnoAA9AGVrykdh7rmHA==
X-Google-Smtp-Source: AGHT+IG1YYL4kFwbVvTnXfTe3odNA00ZLAAz2mLJaF8vV1UmquQWKJyitdN/Fum9NwuVLBLjujgrow==
X-Received: by 2002:a17:907:3fa1:b0:b07:88aa:255b with SMTP id a640c23a62f3a-b07c354ed12mr458973666b.11.1757724983824;
        Fri, 12 Sep 2025 17:56:23 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b33478besm484760966b.99.2025.09.12.17.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:56:23 -0700 (PDT)
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
Subject: [PATCH RESEND 15/62] doc: modernize Documentation/admin-guide/blockdev/ramdisk.rst
Date: Sat, 13 Sep 2025 00:37:54 +0000
Message-ID: <20250913003842.41944-16-safinaskar@gmail.com>
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

Update it to reflect initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../admin-guide/blockdev/ramdisk.rst          | 103 ++----------------
 1 file changed, 7 insertions(+), 96 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/ramdisk.rst b/Documentation/admin-guide/blockdev/ramdisk.rst
index e57c61108dbc..6289e085f18f 100644
--- a/Documentation/admin-guide/blockdev/ramdisk.rst
+++ b/Documentation/admin-guide/blockdev/ramdisk.rst
@@ -5,18 +5,14 @@ Using the RAM disk block device with Linux
 .. Contents:
 
 	1) Overview
-	2) Kernel Command Line Parameters
-	3) Using "rdev"
-	4) An Example of Creating a Compressed RAM Disk
+	2) Module parameters
 
 
 1) Overview
 -----------
 
-The RAM disk driver is a way to use main system memory as a block device.  It
-is required for initrd, an initial filesystem used if you need to load modules
-in order to access the root filesystem (see Documentation/admin-guide/initrd.rst).  It can
-also be used for a temporary filesystem for crypto work, since the contents
+The RAM disk driver is a way to use main system memory as a block device.
+It can also be used for a temporary filesystem for crypto work, since the contents
 are erased on reboot.
 
 The RAM disk dynamically grows as more space is required. It does this by using
@@ -30,109 +26,24 @@ and (re)build the kernel.
 
 To use RAM disk support with your system, run './MAKEDEV ram' from the /dev
 directory.  RAM disks are all major number 1, and start with minor number 0
-for /dev/ram0, etc.  If used, modern kernels use /dev/ram0 for an initrd.
-
-The new RAM disk also has the ability to load compressed RAM disk images,
-allowing one to squeeze more programs onto an average installation or
-rescue floppy disk.
+for /dev/ram0, etc.
 
 
-2) Parameters
----------------------------------
+2) Module parameters
+--------------------
 
-2a) Kernel Command Line Parameters
-
-	ramdisk_size=N
+	rd_size=N
 		Size of the ramdisk.
 
 This parameter tells the RAM disk driver to set up RAM disks of N k size.  The
 default is 4096 (4 MB).
 
-2b) Module parameters
-
 	rd_nr
 		/dev/ramX devices created.
 
 	max_part
 		Maximum partition number.
 
-	rd_size
-		See ramdisk_size.
-
-3) Using "rdev"
----------------
-
-"rdev" is an obsolete, deprecated, antiquated utility that could be used
-to set the boot device in a Linux kernel image.
-
-Instead of using rdev, just place the boot device information on the
-kernel command line and pass it to the kernel from the bootloader.
-
-You can also pass arguments to the kernel by setting FDARGS in
-arch/x86/boot/Makefile and specify in initrd image by setting FDINITRD in
-arch/x86/boot/Makefile.
-
-Some of the kernel command line boot options that may apply here are::
-
-  ramdisk_size=M
-
-If you make a boot disk that has LILO, then for the above, you would use::
-
-	append = "ramdisk_size=M"
-
-4) An Example of Creating a Compressed RAM Disk
------------------------------------------------
-
-To create a RAM disk image, you will need a spare block device to
-construct it on. This can be the RAM disk device itself, or an
-unused disk partition (such as an unmounted swap partition). For this
-example, we will use the RAM disk device, "/dev/ram0".
-
-Note: This technique should not be done on a machine with less than 8 MB
-of RAM. If using a spare disk partition instead of /dev/ram0, then this
-restriction does not apply.
-
-a) Decide on the RAM disk size that you want. Say 2 MB for this example.
-   Create it by writing to the RAM disk device. (This step is not currently
-   required, but may be in the future.) It is wise to zero out the
-   area (esp. for disks) so that maximal compression is achieved for
-   the unused blocks of the image that you are about to create::
-
-	dd if=/dev/zero of=/dev/ram0 bs=1k count=2048
-
-b) Make a filesystem on it. Say ext2fs for this example::
-
-	mke2fs -vm0 /dev/ram0 2048
-
-c) Mount it, copy the files you want to it (eg: /etc/* /dev/* ...)
-   and unmount it again.
-
-d) Compress the contents of the RAM disk. The level of compression
-   will be approximately 50% of the space used by the files. Unused
-   space on the RAM disk will compress to almost nothing::
-
-	dd if=/dev/ram0 bs=1k count=2048 | gzip -v9 > /tmp/ram_image.gz
-
-e) Put the kernel onto the floppy::
-
-	dd if=zImage of=/dev/fd0 bs=1k
-
-f) Put the RAM disk image onto the floppy, after the kernel. Use an offset
-   that is slightly larger than the kernel, so that you can put another
-   (possibly larger) kernel onto the same floppy later without overlapping
-   the RAM disk image. An offset of 400 kB for kernels about 350 kB in
-   size would be reasonable. Make sure offset+size of ram_image.gz is
-   not larger than the total space on your floppy (usually 1440 kB)::
-
-	dd if=/tmp/ram_image.gz of=/dev/fd0 bs=1k seek=400
-
-g) Make sure that you have already specified the boot information in
-   FDARGS and FDINITRD or that you use a bootloader to pass kernel
-   command line boot options to the kernel.
-
-That is it. You now have your boot/root compressed RAM disk floppy. Some
-users may wish to combine steps (d) and (f) by using a pipe.
-
 
 						Paul Gortmaker 12/95
 
-- 
2.47.2


