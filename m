Return-Path: <linux-arch+bounces-14191-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A43CBEDECD
	for <lists+linux-arch@lfdr.de>; Sun, 19 Oct 2025 08:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F16394E4791
	for <lists+linux-arch@lfdr.de>; Sun, 19 Oct 2025 06:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE02248A3;
	Sun, 19 Oct 2025 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIJFRYOv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF220D4E9
	for <linux-arch@vger.kernel.org>; Sun, 19 Oct 2025 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854148; cv=none; b=EaeqWwLy5j65NkH2DR+2M1V7YEKckyY/pw2b5nfa5KbKpSJPSl9yzAFM2f8fyLxj+5KLScNlnXTV9tbLzAboeqD5dV13+vbyn5Eep8aIxz4fm0z+dV7gZQJISDhgTdO4426AZ+xkD//SiGJdogmgGZrBH2H0FC68+Ty4i/2BG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854148; c=relaxed/simple;
	bh=QbgwpdTyi8DYwUUDm609KswE/m2Q+kwHqpRNMxhZtOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K23zPxSwoCEw2nRJ7AnKWgtGpkdWHc1mCDgA1BQx7YuzFxVrbnguAmj3fV6U5aNK/nHFTTHt2jfEFMxDpjcNSyBYbOsa2xjVJOM7VX4Adxe+PRe/80mFW9WpieNgZXrsa1lOh9HFMY4MzFba7ej+nwjbX0coD74ZQXHGJyR18N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIJFRYOv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47114a40161so35176355e9.3
        for <linux-arch@vger.kernel.org>; Sat, 18 Oct 2025 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854143; x=1761458943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYC/hQuGeMEF947/LuK3VJRiyEjbNIGm04998G60uow=;
        b=fIJFRYOv4Fm3RSAeLkQ3y5RaQM6SkG5JVBVhPU5FXz3NDjzFu9SjaNdUYI7mFnKIka
         2IuR2TFBG0Jq0iJMzcBTbir8SyV01CTyADWtCgGsE+LX64S3BVAsDp8d9ZXBJjiuEPvN
         uRvzPMiVWt0YEmYMHAhZIzL5L3GeZ3dY3YDyVQJuX9jZ0h0fwhpvguBUkFie7VtOt5Wn
         5WNkEJ4tuTdUWsN0mMlWYJSXIWI4t5QrLKDLN2UNQHErt2ohjIXwcpeCrCF4iKDEWGkT
         xt+nTZcTc27xp9gln3ooj/s/XILLSaVJgvlKzzXW4fKm92ExonLLi5/YJJwWryJI+f/D
         uB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854143; x=1761458943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYC/hQuGeMEF947/LuK3VJRiyEjbNIGm04998G60uow=;
        b=CM9oPFkvFOpEvyqMirHe4UVrRB27+ibUtVou+p3Iy7PQRO0kP3ySbsqEEADEPsvRgq
         GP3r7a+maYuq1LwqPwMy4GqryhsduAKlJlh0TH/lPMDespJjRUq5cQxBEEiOE0ms4xOg
         69z1PUXZkFOBApvzFrPWXXbFx4napopZPCHfLhZVZ6VO20s7fv27qlQ94vmIG49lEuXA
         QaBcIA0N6L6YGKUkJ0ernfsx4CQef5Z12DD0rBBehY0zVrMQ8rRksUCcWWcfO/FglY3w
         xuMQ4Hd5zHnmJXsyEgKcM3dZDLBJbTsbC7KIYCV+K4x9ec5C7RdwDu5Oh6fIvB1Myz3T
         gjMA==
X-Forwarded-Encrypted: i=1; AJvYcCVDiIO8FObouNvBLpRIBJHFBLQON0vTmZ85lQ0yvDKzLz/bh8PPHnqmsrh/wvtGC5ncWY5OHNAj1P7B@vger.kernel.org
X-Gm-Message-State: AOJu0YwqH/b7c86jcXXFuKjjQYprM/8BxLAI/KifY4dX5ld+dfdQ1hld
	PMWc8ew5WN/dWprCVRgU9wZrH2PNTVgwYt05t+M6G+wHGEUD2AALT8/b
X-Gm-Gg: ASbGnctzN8uNH/BJeRw3kkN5Ib6MPfkWpyCDjXW2L+sqwImUdfTJqyPkqHmmFnQxEX3
	Fw1t8FneH//BocHKOl4r6W3k+ktqVcxVctMy5HJYp9iA7GMRRDtlu9avS5TYeC1M9c6f3QSLPur
	R3zYmAPEwCd74je+C9oBPObRELSvENPqQBS43/WJkZQUj6nWakXThX8XqzmSw4BaQqSF9ba95Wh
	4O9ev38DH4ribSe/E/KrQcyPQl0P0bnylcWtc7EEEsuCzI8H2Mr9Wap/G/aHbhJnJ+vDB7Viq6i
	w7UwBm/bFbsmnQwFD87o1Pv+Ruz8WongTqTZUdWGqpmOdW0ZmlY3Lw2/gWhCcLFn5VI09aVEL/d
	0f4raaQDaJBoAnPkbrDAIwAg3i+IK31mldFDSHulawN648RJusjeohd31VThfx4hGgqHIRREvbl
	7u
X-Google-Smtp-Source: AGHT+IEZ5upR5rvq2pYeoFEK0g1VqqLoHFsnsUnK8lryUbaHf4IrN1h8fWBgNccm4eIUhXw2FJ5z5w==
X-Received: by 2002:a05:600c:820f:b0:471:176d:bf8a with SMTP id 5b1f17b1804b1-4711791cd3dmr68834905e9.35.1760854143309;
        Sat, 18 Oct 2025 23:09:03 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4710cdb9d4dsm83976805e9.5.2025.10.18.23.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 23:09:02 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: ebiggers@kernel.org
Cc: ardb@kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 15/19] lib/crc32: make crc32c() go directly to lib
Date: Sun, 19 Oct 2025 09:08:45 +0300
Message-ID: <20251019060845.553414-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20241202010844.144356-16-ebiggers@kernel.org>
References: <20241202010844.144356-16-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eric Biggers <ebiggers@kernel.org>:
> Now that the lower level __crc32c_le() library function is optimized for

This patch (i. e. 38a9a5121c3b ("lib/crc32: make crc32c() go directly to lib"))
solves actual bug I found in practice. So, please, backport it
to stable kernels.

I did bisect.

It is possible to apply this patch on top of v6.12.48 without conflicts.

The bug actually prevents me for using my system (more details below).

Here is steps to reproduce bug I noticed.

Build kernel so:

$ cat /tmp/mini
CONFIG_64BIT=y
CONFIG_PRINTK=y
CONFIG_SERIAL_8250=y
CONFIG_TTY=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_RD_GZIP=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_DEVTMPFS=y
CONFIG_MODULES=y
CONFIG_BTRFS_FS=m
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_XZ=y
CONFIG_MODULE_COMPRESS_ALL=y
CONFIG_MODULE_DECOMPRESS=y
CONFIG_PRINTK_TIME=y
$ make allnoconfig KCONFIG_ALLCONFIG=/tmp/mini
$ make

Then create initramfs, which contains statically built busybox
(I used busybox v1.37.0 (Debian 1:1.37.0-6+b3)) and modules we just created.

Then run Qemu using command line similar to this:

qemu-system-x86_64 -kernel arch/x86/boot/bzImage -initrd i.gz -append 'console=ttyS0 panic=1 rdinit=/bin/busybox sh' -m 256 -no-reboot -enable-kvm -serial stdio -display none

Then in busybox shell type this:

# mkdir /proc
# busybox mount -t proc proc /proc
# modprobe btrfs

On buggy kernels I get this output:

# modprobe btrfs
[   19.614228] raid6: skipped pq benchmark and selected sse2x4
[   19.614638] raid6: using intx1 recovery algorithm
[   19.616569] xor: measuring software checksum speed
[   19.616937]    prefetch64-sse  : 42616 MB/sec
[   19.617270]    generic_sse     : 41320 MB/sec
[   19.617531] xor: using function: prefetch64-sse (42616 MB/sec)
[   19.619731] Invalid ELF header magic: != ELF
modprobe: can't load module libcrc32c (kernel/lib/libcrc32c.ko.xz): unknown symbol in module, or unknown parameter

The bug is reproducible on all kernels from v6.12 until this commit.
And it is not reproducible on all kernels, which contain this commit.
I found this using bisect.

This bug actually breaks my workflow. I have btrfs as root filesystem.
Initramfs, generated by Debian, doesn't suit my needs. So I'm going
to create my own initramfs from scratch. (Note that I use Debian Trixie,
which has v6.12.48 kernel.) During testing this initramfs in Qemu
I noticed that command "modprobe btrfs" fails with error given above.
(I not yet tried to test this initramfs on real hardware.)

So, this bug actually breaks my workflow.

So, please backport this patch (i. e. 38a9a5121c3b ("lib/crc32: make crc32c() go directly to lib"))
to stable kernels.

I tested that this patch can be applied without conflicts on top of v6.12.48,
and this patch indeed fixes the bug for v6.12.48.

If you want, I can give more info.

It is possible that this is in fact bug in busybox, not in Linux.
But still I think that backporting this patch is good idea.

This busybox thread my be related:
https://lists.busybox.net/pipermail/busybox/2023-May/090309.html

-- 
Askar Safin

