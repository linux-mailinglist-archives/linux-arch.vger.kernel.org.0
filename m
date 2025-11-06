Return-Path: <linux-arch+bounces-14552-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22110C38B96
	for <lists+linux-arch@lfdr.de>; Thu, 06 Nov 2025 02:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0534B4E7D04
	for <lists+linux-arch@lfdr.de>; Thu,  6 Nov 2025 01:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670F223DED;
	Thu,  6 Nov 2025 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Ws3TrZZh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2F1EF36E
	for <linux-arch@vger.kernel.org>; Thu,  6 Nov 2025 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393297; cv=none; b=apqW15Ejp6YK3mzDMlr0Q/kjOGPFJZ0GiZU5uLsUHQ31VLNL6bk6h/4Www0hfYa2PFeBxFO3tv25fk6m+60QzFnDQ1+48MyWcK/Uqg889LO7lAz/fWDqHAtBFWr6ryF1Uk2qxlxp2Gleq/zIW32q2hdL/8Qc+RcQjLf9hFViG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393297; c=relaxed/simple;
	bh=DWqmxgjdhXUW2ZMnZnzO58ZJTxq5MLD/dRpQjQyCtKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3bmw4L2+fxiQPtW320SzgVXfaWBBMuZ2m1hstqMVgSCHp3iRAS1M/Cxtqkn7pPeGcaJ2eU3ja/t5QM6835+F78n8OPSwk5kQGjvBxtJbMiEeLP6kaqahFY1x3COjqjZL7vrMQ7tSWf2PXkREgYFGEQ4/u03W9ETrA1QUqEfnQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Ws3TrZZh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so324813a12.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2025 17:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762393295; x=1762998095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y/3UjQKHjbZCL5wy1WwIWDTYJrWZHVr72uF4GmKOjZk=;
        b=Ws3TrZZhbTM9tykx/tdyIx7SiJMMKEq1fgm0svwwclLYCZll2scJNW3/fmHvc5NNTT
         X/2DkQWwfkq4/LGKL9mZSUBB3egZUeINLF/86UPoyl6vjb1NqQha2kWQ0twwD+mzSfdW
         FGxkfrpYwjOyNgpieeXL1i0nBAKViux8DE4f6R9ldf97J8gdSMisaXNmoEFjhVkUt2kb
         rmhxutnfm/WKhXteJwwuFGGSh2sk68Jc0HEIhP7UgIZREF/PLZ1gHp1LsEszVahmmHjL
         Is+crcmn4eEWxODAH149Qp4Xwx9HmvNTR1LLS5FLJ2jgsfGlTUx+3dNrDHkCCrFj5wP7
         KM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762393295; x=1762998095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/3UjQKHjbZCL5wy1WwIWDTYJrWZHVr72uF4GmKOjZk=;
        b=Yoiv7R++aJ1ouyecCWdxYdXudBmCWmLUpSbKJbWLvgIAIsHkEU1yLur2dND+YP9GN3
         9wDVMbk3mpuH0M9HSRrQWkE+QWOtZ/0N6x8BP2UVzferqcwQSxjwwY1fBJECMdBmH2P7
         VuoD/1EtZeGjPpd7aVuI5ZEWFL9/XaRPB7xJfOWSU2RiDpBK1UsOknQYUFky1egOnC69
         lmW+qvX0UgIIDMFDDLnpu6OB4nItS18vKeSC2asYc/KF8zKiFF/X8QstgWb9k3FKeUwF
         HL7NoXzwpKxUencdFt5HCVgKAIPrS8bX3NX+cCE9GxXgHg13mU0Um2cuyprETgYFXUN5
         ytgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+E/3S+tFtbSTq6wmxgnO4cUiNiuD/Gb+if+y9UwSk/rMxbVyRQdevVET7d2rkbeOzuEze+JxcnSa+@vger.kernel.org
X-Gm-Message-State: AOJu0YzgaGjaFu973uD3JTskgHrrEkmAVdevzrMh3sNS74Ih5MnzuaoZ
	xmweY/uB7ZL6dCfaF82q+lnWZot95hlQ7K0Wl86kIcrnKNfwx+HTN8QWos/AmtvncqA=
X-Gm-Gg: ASbGncuCEdGDoeXbSo8cGeaiU3BkTBEwX5uCulujSMEkASLhCaWHfwsknVJzsiX6+mR
	vDfpVgQ348K4PLBL5D7p/+Rh8/vpjT92Ujg/pRIh74F2tKyiJfTvslU/jBEq/jzrILo8EChTSjR
	zPxhYq36NSzTNr/GgJDQEhxdC9Mcm2v3cn16WncXuM19CK2wejAYfwrQouFjsse6vtTd8QKK5OI
	IEZfIXrBxdGPVG/VWKVDMLAZrfaV+uEkMbEGcRN8Y/gnk5LfznIxI9z5SFffnTny4++H/JoKYWD
	qdn7lu6rJClOxPjiHjkFRxyeiyb5rtH4a/zN3a+6Sx+JlZteOKmxxjxI9eqpZE9v9xsZbGkvEl3
	eTy+lkpHZvQJ1MPkcAJ8X+ijb7gDENomFi5HQ3kqKRhwwef2qMUqv0aiO91mwIwFQNJstsimDyF
	axlnL/xYb3RA==
X-Google-Smtp-Source: AGHT+IHb6Ti5gRD7k0lGBKumYHqpCWBANzpfFHQwxKBBfPve3TqFgn6597YsxofzbM/0CWKlQIfmXQ==
X-Received: by 2002:a05:6a20:9155:b0:340:4bb7:8d11 with SMTP id adf61e73a8af0-34f86113dbamr7105999637.48.1762393294562;
        Wed, 05 Nov 2025 17:41:34 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d05c970dsm574481a91.19.2025.11.05.17.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 17:41:34 -0800 (PST)
Date: Wed, 5 Nov 2025 17:41:32 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, jim.shu@sifive.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	Zong Li <zong.li@sifive.com>, Jesse Huang <jesse.huang@sifive.com>,
	Michael Ellerman <mpe@tenstorrent.com>
Subject: Re: [PATCH v22 00/28] riscv control-flow integrity for usermode
Message-ID: <aQv8zMHs0WnKlNwj@debug.ba.rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
 <CACPK8XeQf9UJuu39bGcm2mySWrKYvUadOgFRmpas+AS9fXA2WA@mail.gmail.com>
 <aQuyiVdxyqWNooJ5@debug.ba.rivosinc.com>
 <aQu-o1-e6FK1dByM@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQu-o1-e6FK1dByM@debug.ba.rivosinc.com>

On Wed, Nov 05, 2025 at 01:16:19PM -0800, Deepak Gupta wrote:
>On Wed, Nov 05, 2025 at 12:24:41PM -0800, Deepak Gupta wrote:
>>On Tue, Nov 04, 2025 at 05:34:11PM +1030, Joel Stanley wrote:
>>>Hello Deepak,
>>>
>>>On Fri, 24 Oct 2025 at 03:31, Deepak Gupta via B4 Relay
>>><devnull+debug.rivosinc.com@kernel.org> wrote:
>>>>
>>>>v22: fixing build error due to -march=zicfiss being picked in gcc-13 and above
>>>>but not actually doing any codegen or recognizing instruction for zicfiss.
>>>>Change in v22 makes dependence on `-fcf-protection=full` compiler flag to
>>>>ensure that toolchain has support and then only CONFIG_RISCV_USER_CFI will be
>>>>visible in menuconfig.
>>>
>>>Following our discussion at the riscv summit I spent some time with
>>>this patch set with the goal of giving a test run on emulation. I only
>>>got as far as qemu, as I couldn't get the selftests passing there.
>>>
>>>I had trouble running the podman container so I built a toolchain
>>>using the riscv-gnu-toolchain branch (cfi-dev, d19f3009f6c2) you
>>>pointed to.
>>>
>>>The opensbi branch was a bit old and wouldn't build with GCC 15, so I
>>>tried to rebase and noticed the patches were already upstream. Have
>>>you tested using v1.7 (or newer) there? Is there something I missed,
>>>do we need more patches on upstream opensbi?
>>>
>>>I booted it in qemu 10.1.2 with the zicfi extensions both on and off.
>>>
>>>qemu-system-riscv64 -M virt,aia=aplic-imsic,aia-guests=5 \
>>>-cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true
>>>-smp 8 -nographic -bios fw_dynamic.elf
>>>-m 1024M -kernel arch/riscv/boot/Image \
>>>-initrd selftests/selftests.cpio \
>>>-append 'init=mini-init command="cfitests"'
>>>
>>>My results:
>>>
>>>no zicfi, no z*mop (crash, as expected):
>>>-------------------------------------------------
>>>
>>>Running command: cfitests
>>>system_opcode_insn: Invalid opcode for CSR read/write instruction[
>>>0.462709] cfitests[85]: unhandled signal 4 code 0x1 at
>>>0x0000000000011c44 in cfitests[1c44,10000+6d000]
>>>[    0.463141] CPU: 4 UID: 0 PID: 85 Comm: cfitests Not tainted
>>>6.18.0-rc3-tt-defconfig-jms-00090-g6e2297f1edbc #93 NONE
>>>[    0.463338] Hardware name: riscv-virtio,qemu (DT)
>>>[    0.463573] epc : 0000000000011c44 ra : 00000000000104e0 sp :
>>>00007fffebd0ddb0
>>>...
>>>[    0.465177] status: 0000000200004020 badaddr: 00000000ce104073
>>>cause: 0000000000000002
>>>[    0.465410] Code: 0893 05d0 4501 0073 0000 b7f5 4501 b7f9 0017 0000
>>>(4073) ce10
>>>
>>>no zicfi, z*mop (failed to start, as expected):
>>>-----------------------------------------------------------
>>>
>>>Running command: cfitests
>>>TAP version 13
>>># Starting risc-v CFI tests
>>>Bail out! Get landing pad status failed with -22
>>>
>>>zicfi, z*mop (failed to start, unexpected):
>>>-------------------------------------------------------
>>>Running command: cfitests
>>>TAP version 13
>>># Starting risc-v CFI tests
>>>Bail out! Get landing pad status failed with -22
>>>
>>>I went digging to see why the zicfi enabled kernel failed. The
>>>userspace binary was built with CFI:
>>>
>>>$ riscv64-unknown-linux-gnu-readelf -n selftests/cfitests
>>>
>>>Displaying notes found in: .note.gnu.property
>>>Owner                Data size     Description
>>>GNU                  0x00000010    NT_GNU_PROPERTY_TYPE_0
>>>    Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS
>>>
>>>I then tested your opensbi tree with some hacks to get it built with a
>>>newer compiler. This produced different results, which was unexpected:
>>>
>>>Running command: cfitests
>>>TAP version 13
>>># Starting risc-v CFI tests
>>>Bail out! Landing pad is not enabled, should be enabled via glibc
>>># Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>
>Ok so I think atleast I have narrowed down the issue. It seems like
>something is going on with how libc will initialize cfi in case of
>static compile.
>I enabled logging whenever prctl set/get are called and my rootfs
>binaries which are all dynamically linked are setting cfi prctls
>correctly. Except when I run statically compiled `cfitest`. It bails
>on "Shadow stack is not enabled" (unlike in your case where it bails
>saying landing pad is not enabled).

I think I have figured out why its happening on my end.
In case of, riscv-gnu-toolchain's "cfi-dev" branch's glibc submodule
is not setting rest of the parameters for prctl to `0` (for static compile)
https://github.com/sifive/riscv-glibc/blob/20b27db7d9aa8f25419b0cbaf62004e53713315e/sysdeps/riscv/libc-start.h#L73

Kernel will reject the prctl for cfi set/get, if any of the not required
parameter is set to `0`.

Although latest glibc patches from Jesse on libc-alpha do that correctly
https://public-inbox.org/libc-alpha/20251027042634.2665717-8-jesse.huang@sifive.com/T/#u

>
>Shortlog
>"""
>Welcome to Buildroot
>buildroot login: root
>[   51.361564] login[129]: arch_set_shadow_stack_status set successfully, shadow stack base 7fffbb977000size 800000
>[   51.362708] login[129]: arch_set_indir_br_lp_status set successfully
>[   51.363805] login[129]: arch_get_indir_br_lp_status called
>[   51.364296] login[129]: arch_get_shadow_stack_status called
>[   51.448918] bash[129]: arch_set_shadow_stack_status set successfully, shadow stack base 7fff9b516000size 800000
>[   51.450030] bash[129]: arch_set_indir_br_lp_status set successfully
>[   51.450568] bash[129]: arch_get_indir_br_lp_status called
>[   51.451047] bash[129]: arch_get_shadow_stack_status called
>[   51.552710] id[130]: arch_set_shadow_stack_status set successfully, shadow stack base 7fff7fa2a000size 800000
>[   51.553798] id[130]: arch_set_indir_br_lp_status set successfully
>[   51.554306] id[130]: arch_get_indir_br_lp_status called
>[   51.554757] id[130]: arch_get_shadow_stack_status called
># mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt
>[   65.484939] mount[131]: arch_set_shadow_stack_status set successfully, shadow stack base 7fffa71a0000size 800000
>[   65.487002] mount[131]: arch_set_indir_br_lp_status set successfully
>[   65.488482] mount[131]: arch_get_indir_br_lp_status called
>[   65.489346] mount[131]: arch_get_shadow_stack_status called
># /mnt/cfitests
>[   74.235075] cfitests[132]: arch_set_indir_br_lp_status set successfully
>[   74.249763] cfitests[132]: arch_get_indir_br_lp_status called
>[   74.250823] cfitests[132]: arch_get_shadow_stack_status called
>TAP version 13
># Starting risc-v tests
>[   74.374286] cfitests[132]: arch_get_indir_br_lp_status called
>[   74.375497] cfitests[132]: arch_get_shadow_stack_status called
>Bail out! Shadow stack is not enabled, should be enabled via glibc
># Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>#
>"""
>
>Full log (with cfi prctls get/set) of boot at pastebin below
>https://pastebin.com/JbX2Yv5W
>
>CCed: Jesse Huang who is leading glibc patches. Can help us figure out
>why statically compiled binaries are failing to set cfi prctls appropriately.
>
>Paul,
>
>Given that it's not an issue in kernel changes, we should still be going ahead
>with it for 6.19
>
>>>
>>>The selftest binary and the little toy init that starts it are both
>>>statically linked and built against the toolchain's glibc, so I would
>>>expect this to work.
>>>
>>>$ riscv64-unknown-linux-gnu-readelf -n sifive-cfi-build/sysroot/usr/lib/libc.a
>>>
>>>File: sifive-cfi-build/sysroot/usr/lib/libc.a(init-first.o)
>>>
>>>Displaying notes found in: .note.gnu.property
>>>Owner                Data size        Description
>>>GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
>>>    Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS
>>>
>>>The kernel seems to have detected that CFI is available and is built with it:
>>>
>>>$ grep CFI .config
>>>CONFIG_RISCV_USER_CFI=y
>>>CONFIG_ARCH_SUPPORTS_CFI=y
>>>
>>>I did notice the func-sig-dev gcc branch is a few commits ahead of
>>>what the sifive riscv-gnu-toolchain points to.
>>>
>>>I had to context switch to some other tasks at this point. I wanted to
>>>do some more digging to work out what was wrong, but I haven't found
>>>time, so here are my notes in the hope that they are useful. I'll let
>>>you know if I discover anything further.
>>
>>
>>I have it working on my end with latest upstream opensbi (no hacks, same
>>compiler)
>>
>>"""
>>$ git log
>>commit 38a6106b1099646f25657bba53cefb80886721a7 (HEAD -> master, origin/master, origin/HEAD)
>>Author: Benoît Monin <benoit.monin@bootlin.com>
>>Date:   Mon Oct 27 14:12:17 2025 +0100
>>
>>   lib: utils/ipi: mswi: add MIPS P8700 compatible
>>....
>>"""
>>
>>I am surprised that change of compiler on opensbi changed errorcode for userspace
>>in your setup. That's quite bizarre.
>>
>>Output from cfitests (with toolchain that's on docker. I didn't compile from
>>cfi-dev branch).
>>
>># /mnt/cfitests
>>TAP version 13
>># Starting risc-v tests
>># Landing pad and shadow stack are enabled for binary
>># cfi_ptrace_test, ptrace test succeeded
>># Executing RISC-V shadow stack self tests
>>1..5
>># Exercising shadow stack fork test
>># Parent pid 133 and child pid 135
>># dummy calls for sspush and sspopchk in context of parent
>># Spewing out shadow stack ptr: 7fffbf4a9fb8
>> This is to ensure shadow stack is indeed enabled and working
>># Waiting on child to finish
>># dummy calls for sspush and sspopchk in context of child
>># Spewing out shadow stack ptr: 7fffbf4a9fb8
>> This is to ensure shadow stack is indeed enabled and working
>>ok 1 shstk fork test
>># Exercising shadow stack map test
>>ok 2 map shadow stack syscall
>># Exercising shadow stack gup tests
>>ok 3 shadow stack gup tests
>># Exercising shadow stack signal test
>>ok 4 shadow stack signal tests
>># Exercising shadow stack protection test (WPT)
>>ok 5 memory protections of shadow stack memory
>># Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
>>#
>>
>>Is there a place where I can grab your kselftest `cfitests` binary?
>>
>>Only difference I can see is that `cfitests` in my case is not statically
>>compiled
>>
>>"""
>>$ riscv64-unknown-linux-gnu-readelf -d /scratch/debug/sources/spectacles/cfitests | grep NEEDED
>>0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
>>
>>"""
>>
>>>
>>>Cheers,
>>>
>>>Joel
>>>
>>>
>>>>How to test this series
>>>>=======================
>>>>
>>>>Toolchain
>>>>---------
>>>>$ git clone git@github.com:sifive/riscv-gnu-toolchain.git -b cfi-dev
>>>>$ riscv-gnu-toolchain/configure --prefix=<path-to-where-to-build> --with-arch=rv64gc_zicfilp_zicfiss --enable-linux --disable-gdb  --with-extra-multilib-test="rv64gc_zicfilp_zicfiss-lp64d:-static"
>>>>$ make -j$(nproc)
>>>>
>>>>Qemu
>>>>----
>>>>Get the lastest qemu
>>>>$ cd qemu
>>>>$ mkdir build
>>>>$ cd build
>>>>$ ../configure --target-list=riscv64-softmmu
>>>>$ make -j$(nproc)
>>>>
>>>>Opensbi
>>>>-------
>>>>$ git clone git@github.com:deepak0414/opensbi.git -b v6_cfi_spec_split_opensbi
>>>>$ make CROSS_COMPILE=<your riscv toolchain> -j$(nproc) PLATFORM=generic
>>>>
>>>>Linux
>>>>-----
>>>>Running defconfig is fine. CFI is enabled by default if the toolchain
>>>>supports it.
>>>>
>>>>$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc) defconfig
>>>>$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc)
>>>>
>>>>Running
>>>>-------
>>>>
>>>>Modify your qemu command to have:
>>>>-bios <path-to-cfi-opensbi>/build/platform/generic/firmware/fw_dynamic.bin
>>>>-cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true

