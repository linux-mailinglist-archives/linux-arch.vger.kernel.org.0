Return-Path: <linux-arch+bounces-14546-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A89C37F04
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 22:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F5348E64
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B942DC328;
	Wed,  5 Nov 2025 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="QVUjeqd3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD32DCBFC
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377385; cv=none; b=jE5aIHd4nWoaODZ98reeObGQGwoLlWA3GD6xn7LCR+pYNASy0wlWlYLRwSd/322+kJA8wiWg4v6qj5TEmXjQURfbm+Y5nCf/kth6kR86bhosyjX2Zc0CzCJsoh7vltBeesRwTJa8/7sJ3jqtkG3+bY2DO5MRFlPX93VOJOQH4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377385; c=relaxed/simple;
	bh=MUuSQMMFm7rsszh+tEpt1DpEUZIKd+AvF16JNtf+f78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1bmmn9W5iWUOK4gvUgsK4F7rUPUAlUFehimddM8wlgQauT5v5OKf9kz+i9okWGNklPSbguzpvZfy/v4xKaA6JdUQ8lGXluATEhsvcDOoBvQPW0oqOKeziMYLgXOSzX5hBuSscCnBWqCGbybSJbnMnVU5UC49nlIlpQPxQ9whS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=QVUjeqd3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2957850c63bso3517605ad.0
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2025 13:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762377382; x=1762982182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D1ax2+b/BmZMbWQLmn1abjqqCYtcXZuyWWUp9gYac88=;
        b=QVUjeqd3I/ISPYvwHkX5zl1duD++foY7I87kyrugd7YXBcjkYcAkinbRTx3kbaeqm7
         KEl3bLQqvgsTCcBLBI618uIRJN4lL2jU83HX0ZTeAglac/2A+VEk1Qjtc5Au8myQt1ui
         sZZSdWUSLlBxtUt/X8+3jVl7aVtHWSZMausAKmO2GIOTFrGknwwyeQXxzbN8ICGuRX+0
         3ISRol/N5YPyYbJXlG124y04aPpEq1HRGEPiC7cB+gJiJ5MXIBZVvLJXHdmFOXk7SB3X
         maguTgO12M7aVkybsewzKpb5uyvizHvDM1Es0vFvuOP5y4Fp0z1JK2pr/fIUucbEEYdP
         61JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377382; x=1762982182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1ax2+b/BmZMbWQLmn1abjqqCYtcXZuyWWUp9gYac88=;
        b=ua+1csHj6Ex5uCw8K4ZmcXD6AmK2aIL4CahNq7cncRItEAMGUB06QosDGPNQNOtGwR
         CsAlN3ZWJE6p8abht3vBYqw7kVIX2T3lrzGwe7N8l3C61uk484jFutsMzMWYGvm/FxA3
         SICywL9cRTJRvraeMUWSKfYN+z+Tdl9s7GuQVcSetrMoANEcRQuzDgrvokB1iXzsLtTU
         uMwRyF/xbqySI+9AIQjmmv6nPy7KeQosMCwVsnzPJ4Ixz38B9Xmlhw0wtMgBOpHwcLYQ
         LwpjIhfCmxcmrbnF90GEvkXCxhAuED6UyXCpssKZQBs9mVE0sYGqzEqZU8NYdMpwUCVz
         38bg==
X-Forwarded-Encrypted: i=1; AJvYcCW6Lu0u69eb4dU6390c4jwhryZJA5Ju32JGngp8xlWleTxz7qKg/iRJQZh6eJC5eTIWts9ne7Lwqm+o@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15F6SbYvMqcFCJcbRfYZPJdLIQ1HGnOwRG8a/PbqBzt3KIu0O
	yqXPwZwB5ji9HRlRd6dVwMpms5aCHkVy1LKmH+uqtcLcUbW2SfpDX8EvsqJL2Xcko8Q=
X-Gm-Gg: ASbGncvaP0aHCJfZmnaQMPWNZnKvCOPzOgt+IntwzYSRErEkwSZvFLnMy6yWq56vexn
	vJjLLd9kPgC5P98iY88KH5M6hmiVNbe9QBOcIjXa9LKLnQTszAfk+a8cfgViIzIIY2uEUSntWcd
	kitijjk6pSDfQ6Gyoz/cZB2K71Ni0xb3+77LVitFXRb7FmbCCR4FIX2DmiGAygo9T7kyg443oJ6
	SssxiMNuf4kQ+WAyagYMO+0W/dk1oCaEBQlS4bvFguxbyFz3Eqx/UpwlwMAbK/gpL2qQnHkVjYT
	Cr7M1QCCFrwgkR3C85aoZpuiaESki4EjWEM5KQgX8C49F+WSFsmAEpw3l4HJfHxnOshl3f7J805
	0lIpVGy0ihcV1MkxWr4MqhaXOHKCW5XV9bmKJydmRjuRKZS532SHyhlMvJ5TaJ59dJkgGyxiYqb
	9TN5abWU2yhA==
X-Google-Smtp-Source: AGHT+IGIZBQp5DjsGz3HmRAWZhPw8v6GqkWpZnGJFSt/AXCLpNaQaJyXUplBHQF5DvKtwaSJAHwvDg==
X-Received: by 2002:a17:903:2304:b0:295:557e:7468 with SMTP id d9443c01a7336-2965173831dmr10789365ad.28.1762377381822;
        Wed, 05 Nov 2025 13:16:21 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682casm4836705ad.22.2025.11.05.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:16:21 -0800 (PST)
Date: Wed, 5 Nov 2025 13:16:19 -0800
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
Message-ID: <aQu-o1-e6FK1dByM@debug.ba.rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
 <CACPK8XeQf9UJuu39bGcm2mySWrKYvUadOgFRmpas+AS9fXA2WA@mail.gmail.com>
 <aQuyiVdxyqWNooJ5@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQuyiVdxyqWNooJ5@debug.ba.rivosinc.com>

On Wed, Nov 05, 2025 at 12:24:41PM -0800, Deepak Gupta wrote:
>On Tue, Nov 04, 2025 at 05:34:11PM +1030, Joel Stanley wrote:
>>Hello Deepak,
>>
>>On Fri, 24 Oct 2025 at 03:31, Deepak Gupta via B4 Relay
>><devnull+debug.rivosinc.com@kernel.org> wrote:
>>>
>>>v22: fixing build error due to -march=zicfiss being picked in gcc-13 and above
>>>but not actually doing any codegen or recognizing instruction for zicfiss.
>>>Change in v22 makes dependence on `-fcf-protection=full` compiler flag to
>>>ensure that toolchain has support and then only CONFIG_RISCV_USER_CFI will be
>>>visible in menuconfig.
>>
>>Following our discussion at the riscv summit I spent some time with
>>this patch set with the goal of giving a test run on emulation. I only
>>got as far as qemu, as I couldn't get the selftests passing there.
>>
>>I had trouble running the podman container so I built a toolchain
>>using the riscv-gnu-toolchain branch (cfi-dev, d19f3009f6c2) you
>>pointed to.
>>
>>The opensbi branch was a bit old and wouldn't build with GCC 15, so I
>>tried to rebase and noticed the patches were already upstream. Have
>>you tested using v1.7 (or newer) there? Is there something I missed,
>>do we need more patches on upstream opensbi?
>>
>>I booted it in qemu 10.1.2 with the zicfi extensions both on and off.
>>
>>qemu-system-riscv64 -M virt,aia=aplic-imsic,aia-guests=5 \
>> -cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true
>> -smp 8 -nographic -bios fw_dynamic.elf
>> -m 1024M -kernel arch/riscv/boot/Image \
>> -initrd selftests/selftests.cpio \
>> -append 'init=mini-init command="cfitests"'
>>
>>My results:
>>
>>no zicfi, no z*mop (crash, as expected):
>>-------------------------------------------------
>>
>>Running command: cfitests
>>system_opcode_insn: Invalid opcode for CSR read/write instruction[
>>0.462709] cfitests[85]: unhandled signal 4 code 0x1 at
>>0x0000000000011c44 in cfitests[1c44,10000+6d000]
>>[    0.463141] CPU: 4 UID: 0 PID: 85 Comm: cfitests Not tainted
>>6.18.0-rc3-tt-defconfig-jms-00090-g6e2297f1edbc #93 NONE
>>[    0.463338] Hardware name: riscv-virtio,qemu (DT)
>>[    0.463573] epc : 0000000000011c44 ra : 00000000000104e0 sp :
>>00007fffebd0ddb0
>>...
>>[    0.465177] status: 0000000200004020 badaddr: 00000000ce104073
>>cause: 0000000000000002
>>[    0.465410] Code: 0893 05d0 4501 0073 0000 b7f5 4501 b7f9 0017 0000
>>(4073) ce10
>>
>>no zicfi, z*mop (failed to start, as expected):
>>-----------------------------------------------------------
>>
>>Running command: cfitests
>>TAP version 13
>># Starting risc-v CFI tests
>>Bail out! Get landing pad status failed with -22
>>
>>zicfi, z*mop (failed to start, unexpected):
>>-------------------------------------------------------
>>Running command: cfitests
>>TAP version 13
>># Starting risc-v CFI tests
>>Bail out! Get landing pad status failed with -22
>>
>>I went digging to see why the zicfi enabled kernel failed. The
>>userspace binary was built with CFI:
>>
>>$ riscv64-unknown-linux-gnu-readelf -n selftests/cfitests
>>
>>Displaying notes found in: .note.gnu.property
>> Owner                Data size     Description
>> GNU                  0x00000010    NT_GNU_PROPERTY_TYPE_0
>>     Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS
>>
>>I then tested your opensbi tree with some hacks to get it built with a
>>newer compiler. This produced different results, which was unexpected:
>>
>>Running command: cfitests
>>TAP version 13
>># Starting risc-v CFI tests
>>Bail out! Landing pad is not enabled, should be enabled via glibc
>># Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0

Ok so I think atleast I have narrowed down the issue. It seems like
something is going on with how libc will initialize cfi in case of
static compile.
I enabled logging whenever prctl set/get are called and my rootfs
binaries which are all dynamically linked are setting cfi prctls
correctly. Except when I run statically compiled `cfitest`. It bails
on "Shadow stack is not enabled" (unlike in your case where it bails
saying landing pad is not enabled).

Shortlog
"""
Welcome to Buildroot
buildroot login: root
[   51.361564] login[129]: arch_set_shadow_stack_status set successfully, shadow stack base 7fffbb977000size 800000
[   51.362708] login[129]: arch_set_indir_br_lp_status set successfully
[   51.363805] login[129]: arch_get_indir_br_lp_status called
[   51.364296] login[129]: arch_get_shadow_stack_status called
[   51.448918] bash[129]: arch_set_shadow_stack_status set successfully, shadow stack base 7fff9b516000size 800000
[   51.450030] bash[129]: arch_set_indir_br_lp_status set successfully
[   51.450568] bash[129]: arch_get_indir_br_lp_status called
[   51.451047] bash[129]: arch_get_shadow_stack_status called
[   51.552710] id[130]: arch_set_shadow_stack_status set successfully, shadow stack base 7fff7fa2a000size 800000
[   51.553798] id[130]: arch_set_indir_br_lp_status set successfully
[   51.554306] id[130]: arch_get_indir_br_lp_status called
[   51.554757] id[130]: arch_get_shadow_stack_status called
# mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt
[   65.484939] mount[131]: arch_set_shadow_stack_status set successfully, shadow stack base 7fffa71a0000size 800000
[   65.487002] mount[131]: arch_set_indir_br_lp_status set successfully
[   65.488482] mount[131]: arch_get_indir_br_lp_status called
[   65.489346] mount[131]: arch_get_shadow_stack_status called
# /mnt/cfitests
[   74.235075] cfitests[132]: arch_set_indir_br_lp_status set successfully
[   74.249763] cfitests[132]: arch_get_indir_br_lp_status called
[   74.250823] cfitests[132]: arch_get_shadow_stack_status called
TAP version 13
# Starting risc-v tests
[   74.374286] cfitests[132]: arch_get_indir_br_lp_status called
[   74.375497] cfitests[132]: arch_get_shadow_stack_status called
Bail out! Shadow stack is not enabled, should be enabled via glibc
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
#
"""

Full log (with cfi prctls get/set) of boot at pastebin below
https://pastebin.com/JbX2Yv5W

CCed: Jesse Huang who is leading glibc patches. Can help us figure out
why statically compiled binaries are failing to set cfi prctls appropriately.

Paul,

Given that it's not an issue in kernel changes, we should still be going ahead
with it for 6.19

>>
>>The selftest binary and the little toy init that starts it are both
>>statically linked and built against the toolchain's glibc, so I would
>>expect this to work.
>>
>>$ riscv64-unknown-linux-gnu-readelf -n sifive-cfi-build/sysroot/usr/lib/libc.a
>>
>>File: sifive-cfi-build/sysroot/usr/lib/libc.a(init-first.o)
>>
>>Displaying notes found in: .note.gnu.property
>> Owner                Data size        Description
>> GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
>>     Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS
>>
>>The kernel seems to have detected that CFI is available and is built with it:
>>
>>$ grep CFI .config
>>CONFIG_RISCV_USER_CFI=y
>>CONFIG_ARCH_SUPPORTS_CFI=y
>>
>>I did notice the func-sig-dev gcc branch is a few commits ahead of
>>what the sifive riscv-gnu-toolchain points to.
>>
>>I had to context switch to some other tasks at this point. I wanted to
>>do some more digging to work out what was wrong, but I haven't found
>>time, so here are my notes in the hope that they are useful. I'll let
>>you know if I discover anything further.
>
>
>I have it working on my end with latest upstream opensbi (no hacks, same
>compiler)
>
>"""
>$ git log
>commit 38a6106b1099646f25657bba53cefb80886721a7 (HEAD -> master, origin/master, origin/HEAD)
>Author: Benoît Monin <benoit.monin@bootlin.com>
>Date:   Mon Oct 27 14:12:17 2025 +0100
>
>    lib: utils/ipi: mswi: add MIPS P8700 compatible
>....
>"""
>
>I am surprised that change of compiler on opensbi changed errorcode for userspace
>in your setup. That's quite bizarre.
>
>Output from cfitests (with toolchain that's on docker. I didn't compile from
>cfi-dev branch).
>
># /mnt/cfitests
>TAP version 13
># Starting risc-v tests
># Landing pad and shadow stack are enabled for binary
># cfi_ptrace_test, ptrace test succeeded
># Executing RISC-V shadow stack self tests
>1..5
># Exercising shadow stack fork test
># Parent pid 133 and child pid 135
># dummy calls for sspush and sspopchk in context of parent
># Spewing out shadow stack ptr: 7fffbf4a9fb8
>  This is to ensure shadow stack is indeed enabled and working
># Waiting on child to finish
># dummy calls for sspush and sspopchk in context of child
># Spewing out shadow stack ptr: 7fffbf4a9fb8
>  This is to ensure shadow stack is indeed enabled and working
>ok 1 shstk fork test
># Exercising shadow stack map test
>ok 2 map shadow stack syscall
># Exercising shadow stack gup tests
>ok 3 shadow stack gup tests
># Exercising shadow stack signal test
>ok 4 shadow stack signal tests
># Exercising shadow stack protection test (WPT)
>ok 5 memory protections of shadow stack memory
># Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
>#
>
>Is there a place where I can grab your kselftest `cfitests` binary?
>
>Only difference I can see is that `cfitests` in my case is not statically
>compiled
>
>"""
>$ riscv64-unknown-linux-gnu-readelf -d /scratch/debug/sources/spectacles/cfitests | grep NEEDED
> 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
>
>"""
>
>>
>>Cheers,
>>
>>Joel
>>
>>
>>>How to test this series
>>>=======================
>>>
>>>Toolchain
>>>---------
>>>$ git clone git@github.com:sifive/riscv-gnu-toolchain.git -b cfi-dev
>>>$ riscv-gnu-toolchain/configure --prefix=<path-to-where-to-build> --with-arch=rv64gc_zicfilp_zicfiss --enable-linux --disable-gdb  --with-extra-multilib-test="rv64gc_zicfilp_zicfiss-lp64d:-static"
>>>$ make -j$(nproc)
>>>
>>>Qemu
>>>----
>>>Get the lastest qemu
>>>$ cd qemu
>>>$ mkdir build
>>>$ cd build
>>>$ ../configure --target-list=riscv64-softmmu
>>>$ make -j$(nproc)
>>>
>>>Opensbi
>>>-------
>>>$ git clone git@github.com:deepak0414/opensbi.git -b v6_cfi_spec_split_opensbi
>>>$ make CROSS_COMPILE=<your riscv toolchain> -j$(nproc) PLATFORM=generic
>>>
>>>Linux
>>>-----
>>>Running defconfig is fine. CFI is enabled by default if the toolchain
>>>supports it.
>>>
>>>$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc) defconfig
>>>$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc)
>>>
>>>Running
>>>-------
>>>
>>>Modify your qemu command to have:
>>>-bios <path-to-cfi-opensbi>/build/platform/generic/firmware/fw_dynamic.bin
>>>-cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true

