Return-Path: <linux-arch+bounces-14499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F274C2F8C5
	for <lists+linux-arch@lfdr.de>; Tue, 04 Nov 2025 08:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED053422ACC
	for <lists+linux-arch@lfdr.de>; Tue,  4 Nov 2025 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B543016E2;
	Tue,  4 Nov 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Y9AGAfS6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87E30148B
	for <linux-arch@vger.kernel.org>; Tue,  4 Nov 2025 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239866; cv=none; b=VJoJ554myExkoex3zUK69dvpVi4FevEBNlgTHFRv+DPyTFYeRxLU3T5PuN5bs+Hgp6J46LilGWThXPAFNi1zBVOYCppBv3cN68QtUBvWZ+gmugjgwKNVYR7qigp2MB5my4BhTnPw3FfNf58YJKw5tDBSStEFHJgSQTs2qgNaYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239866; c=relaxed/simple;
	bh=kozgR2bF/PtNnK2OEUoSAkSJQo/VAj/GNONwopx8ngQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDGit+6AIg5J9I4QkTjkLXYBH6hIdIffcgInRUlXrpfVEnf5AicIq5ElH85lcpwgZp9l3VpO9n2q2Heaj9DhV2nIxufuwuY8aVocjP6DuoTSLTeX/LDnVFZnMjKdgwgOvFwuUgC7Gq2vgwPDJiTXWwV+4FZrWVbOM9sttc4mDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b=Y9AGAfS6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7815092cd0bso70784057b3.2
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 23:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1762239863; x=1762844663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6l6pzKIRf2CaQyzb8arm8RPOyxld4gNWkvkOyQHxQ7Q=;
        b=Y9AGAfS6/6E3Loz0K1+sSpNPIyESnm5Oz0LyixpofLk7mXsgmampgK5SmlcpFWqplu
         4Iv7AgHpjGB43Z6mv49EnfJBF+0xlB+sO8XE395LEz/BTr/s2i3Pq7A4fVFtaAV3fV/1
         nFLB5YSkdnndfbe1f+tjTBnkCXAfW0zXcEY+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762239863; x=1762844663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6l6pzKIRf2CaQyzb8arm8RPOyxld4gNWkvkOyQHxQ7Q=;
        b=smC3Pr4VdNkF3FGxZLStHaEsonZnAiYdw74qmP5qDRAAKvmDJePkI1d/TF8cDy1NWd
         V1HTRnjCoLeQkCZmw51a9rLmfSoK1fkeP5/NTpmPhpHHyo72P1IWr5qrMOBcCHyCbtWH
         q4W8onmjkw3Y6rCTrKFCX0hwJy+LS9Jw1sy2obBdn21LaDP4Bm2PDVr2cAGdFa/a4Zge
         0ZGQHjQOnmMcwwn7qIdL4m6MGX3x4fYGATw+vZcHHzIZUDoAqjEFcmopw36vZi7gfvJU
         1Qh0ME3XhVi+CsCr+rGMs1x6ZLk5Dv7VFnhcMpcWDaW7XPbcg0iY4XRSICiBYd0LrhYk
         Zs/A==
X-Forwarded-Encrypted: i=1; AJvYcCWK8pENPtu8FnqoAyncVFlZB+SQ9Oauf3/lfeWl65kDnm82IWx9Z+eA9yJQqpHPfYQreEScK0bE6nRa@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbeUXcnPvQtUBI42HLa6UYFxOt/LbB0/ekFx68TwdUVA0ncdK
	CzS9ENw4e12JcO28CKJPWz/1KlnrmhxgS+tDh5klmQmqaC0S9QSpX3phMGSTrFLqsd406yRxEHJ
	B4e7B8SEJGnjAtYFAyDjY/UAAe/86HwZ2ZLps
X-Gm-Gg: ASbGncuve7fUpbN2dhyZh1luaFk68dd5rgh2vhYrD5ON+CwRQ3xnXJWhsTL6KQqqoNw
	j0X37A/G7OR8M7pfs758qtbHNJd5KYoADmENzTIcwrHRGm21HkNY8DNG3FNPpp/KOPha3L0IKl/
	fbhzFXd9EDNP90BSNYbB55+1d1B9Kt0QGIj2vzETS1RzIot1jatQJ+3PP6RSprGF5neti/Xfq5U
	s8WoHmd5I4Eu2loOK4DHFBEmuOUfY6GjcNcpTP7j2ECIPQAFh8CvWON0rU5
X-Google-Smtp-Source: AGHT+IFJBjehpZRazbrX4sxglEPNYBXDbTAQEQZibveYrzz1dLz6+53cXBYq9yJJEUsz5lUlpgsEEl7cOp/NvjZI5BM=
X-Received: by 2002:a05:690c:6d0e:b0:786:5499:635d with SMTP id
 00721157ae682-78654996814mr230032727b3.43.1762239862987; Mon, 03 Nov 2025
 23:04:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 4 Nov 2025 17:34:11 +1030
X-Gm-Features: AWmQ_bn8HcCW2KtRWcMvD45zaa42-UQ99Lvjjf4YKp_PiE6Rkp2XovRGeCKLx_Y
Message-ID: <CACPK8XeQf9UJuu39bGcm2mySWrKYvUadOgFRmpas+AS9fXA2WA@mail.gmail.com>
Subject: Re: [PATCH v22 00/28] riscv control-flow integrity for usermode
To: debug@rivosinc.com
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, jim.shu@sifive.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	Zong Li <zong.li@sifive.com>, Michael Ellerman <mpe@tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"

Hello Deepak,

On Fri, 24 Oct 2025 at 03:31, Deepak Gupta via B4 Relay
<devnull+debug.rivosinc.com@kernel.org> wrote:
>
> v22: fixing build error due to -march=zicfiss being picked in gcc-13 and above
> but not actually doing any codegen or recognizing instruction for zicfiss.
> Change in v22 makes dependence on `-fcf-protection=full` compiler flag to
> ensure that toolchain has support and then only CONFIG_RISCV_USER_CFI will be
> visible in menuconfig.

Following our discussion at the riscv summit I spent some time with
this patch set with the goal of giving a test run on emulation. I only
got as far as qemu, as I couldn't get the selftests passing there.

I had trouble running the podman container so I built a toolchain
using the riscv-gnu-toolchain branch (cfi-dev, d19f3009f6c2) you
pointed to.

The opensbi branch was a bit old and wouldn't build with GCC 15, so I
tried to rebase and noticed the patches were already upstream. Have
you tested using v1.7 (or newer) there? Is there something I missed,
do we need more patches on upstream opensbi?

I booted it in qemu 10.1.2 with the zicfi extensions both on and off.

qemu-system-riscv64 -M virt,aia=aplic-imsic,aia-guests=5 \
  -cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true
  -smp 8 -nographic -bios fw_dynamic.elf
  -m 1024M -kernel arch/riscv/boot/Image \
  -initrd selftests/selftests.cpio \
  -append 'init=mini-init command="cfitests"'

My results:

no zicfi, no z*mop (crash, as expected):
-------------------------------------------------

Running command: cfitests
system_opcode_insn: Invalid opcode for CSR read/write instruction[
0.462709] cfitests[85]: unhandled signal 4 code 0x1 at
0x0000000000011c44 in cfitests[1c44,10000+6d000]
[    0.463141] CPU: 4 UID: 0 PID: 85 Comm: cfitests Not tainted
6.18.0-rc3-tt-defconfig-jms-00090-g6e2297f1edbc #93 NONE
[    0.463338] Hardware name: riscv-virtio,qemu (DT)
[    0.463573] epc : 0000000000011c44 ra : 00000000000104e0 sp :
00007fffebd0ddb0
...
[    0.465177] status: 0000000200004020 badaddr: 00000000ce104073
cause: 0000000000000002
[    0.465410] Code: 0893 05d0 4501 0073 0000 b7f5 4501 b7f9 0017 0000
(4073) ce10

no zicfi, z*mop (failed to start, as expected):
-----------------------------------------------------------

Running command: cfitests
TAP version 13
# Starting risc-v CFI tests
Bail out! Get landing pad status failed with -22

zicfi, z*mop (failed to start, unexpected):
-------------------------------------------------------
Running command: cfitests
TAP version 13
# Starting risc-v CFI tests
Bail out! Get landing pad status failed with -22

I went digging to see why the zicfi enabled kernel failed. The
userspace binary was built with CFI:

$ riscv64-unknown-linux-gnu-readelf -n selftests/cfitests

Displaying notes found in: .note.gnu.property
  Owner                Data size     Description
  GNU                  0x00000010    NT_GNU_PROPERTY_TYPE_0
      Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS

I then tested your opensbi tree with some hacks to get it built with a
newer compiler. This produced different results, which was unexpected:

Running command: cfitests
TAP version 13
# Starting risc-v CFI tests
Bail out! Landing pad is not enabled, should be enabled via glibc
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0

The selftest binary and the little toy init that starts it are both
statically linked and built against the toolchain's glibc, so I would
expect this to work.

$ riscv64-unknown-linux-gnu-readelf -n sifive-cfi-build/sysroot/usr/lib/libc.a

File: sifive-cfi-build/sysroot/usr/lib/libc.a(init-first.o)

Displaying notes found in: .note.gnu.property
  Owner                Data size        Description
  GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
      Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS

The kernel seems to have detected that CFI is available and is built with it:

$ grep CFI .config
CONFIG_RISCV_USER_CFI=y
CONFIG_ARCH_SUPPORTS_CFI=y

I did notice the func-sig-dev gcc branch is a few commits ahead of
what the sifive riscv-gnu-toolchain points to.

I had to context switch to some other tasks at this point. I wanted to
do some more digging to work out what was wrong, but I haven't found
time, so here are my notes in the hope that they are useful. I'll let
you know if I discover anything further.

Cheers,

Joel


> How to test this series
> =======================
>
> Toolchain
> ---------
> $ git clone git@github.com:sifive/riscv-gnu-toolchain.git -b cfi-dev
> $ riscv-gnu-toolchain/configure --prefix=<path-to-where-to-build> --with-arch=rv64gc_zicfilp_zicfiss --enable-linux --disable-gdb  --with-extra-multilib-test="rv64gc_zicfilp_zicfiss-lp64d:-static"
> $ make -j$(nproc)
>
> Qemu
> ----
> Get the lastest qemu
> $ cd qemu
> $ mkdir build
> $ cd build
> $ ../configure --target-list=riscv64-softmmu
> $ make -j$(nproc)
>
> Opensbi
> -------
> $ git clone git@github.com:deepak0414/opensbi.git -b v6_cfi_spec_split_opensbi
> $ make CROSS_COMPILE=<your riscv toolchain> -j$(nproc) PLATFORM=generic
>
> Linux
> -----
> Running defconfig is fine. CFI is enabled by default if the toolchain
> supports it.
>
> $ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc) defconfig
> $ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc)
>
> Running
> -------
>
> Modify your qemu command to have:
> -bios <path-to-cfi-opensbi>/build/platform/generic/firmware/fw_dynamic.bin
> -cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true

