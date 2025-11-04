Return-Path: <linux-arch+bounces-14506-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD64C33022
	for <lists+linux-arch@lfdr.de>; Tue, 04 Nov 2025 22:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4ECC34B21E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Nov 2025 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1231C2F8BC3;
	Tue,  4 Nov 2025 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="DHQwgRYj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF3242D87
	for <linux-arch@vger.kernel.org>; Tue,  4 Nov 2025 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291063; cv=none; b=dY7GN/u7ou1T6yb0nIYYSkLQNeeblQH0vBkKTwmLzlPw7uacdPiKVl3h4ZOdQYzBRN3H4JOl4JrY8lam/+w1QHs7yXebKeXCbWzJZL2N+f4rKmA//1Xr6yin6hMRYw5q1fIaSPFTMeyd/ec9mhgchaQc6FjVMhsfTCBmQXbN+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291063; c=relaxed/simple;
	bh=65/cD2ZSUAzPQab5ckwiZ9PtfoIo8XCpfmICSE+u320=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pti41HHRl8nK+v9az0QjcVt+MP+5F/jYOhGA0TnFQf+yGG6Xp3F27C3cmunPEsJfp6umxJTDOlTpqLbbhScVW8WkdDZYKVguIDwaCE7PDbiPAZziBGGGk4M6waLFnW3/oSKqV5dmoWLXpe/K/u9cmt0yMobOw3+MlewdAijWDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=DHQwgRYj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29568d93e87so30041825ad.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 13:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762291060; x=1762895860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGjWT2vMzqtOZS9xN5d6Q0YRIr9cvpctAWp7WzNW7AA=;
        b=DHQwgRYjJfgGVZGDktDqb2za90/TsjArMQ1NacLYlwHmXd/GGDLWpWi+rrOWHejdeO
         bOZA3WSK6EbyvSUKA6F8T6lRvmPe1AKpbLkUOloc2Tst0UYCTTFeDg7KukADO2Yj/A2x
         VjlNc6mPtOm9G+zINbuXbfqVqcup5UGVd6CBFHln9rYQG5chwLRJ9MMpI6o3SNWk7C2R
         r1dk2pojUd/Ehn9COBVI293w1sWbpesYVf6fABK3Fg8WgkV273Afy/JLAoncW7xFm6sg
         pb1QWOvTMxB9lg61sqgTq3HRXYG5r20mHOxM3NrzfQvxOwjWGVTlMD0nb9VMl/PRFfBN
         ZEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762291060; x=1762895860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGjWT2vMzqtOZS9xN5d6Q0YRIr9cvpctAWp7WzNW7AA=;
        b=HfXsOen2C/qfHLq0N9V9oLAWy5QdP7/cqf/ewO39HH9dixgseWpc2ILGlF710mORlV
         rfJdwDl+1cLmIobGKxmNlDLiiTWfxSRHa66ivixX8hfQg1aLrk9yGToEYhPZgTt38caK
         0YF9Upk2FJ410NHQ+OfS0bTovgorlWZC4egrSMBlFxJR+lqKtR6pNONqzccdQlsdz3BA
         yVy7NrqxAUj2TKC5dRwRRJPmRJwVR41wiuhbjRAFJ6Dma22cRQ4P5R1r2onNjVziDw41
         OHB0skMBU+GVA2Z/QtOLNJA3nCa2Z1XrSz/4IjpM+fXMMc+TgpF0sOsSwcqcC0w2F6Q5
         S0sw==
X-Forwarded-Encrypted: i=1; AJvYcCV08lFtan0HZoqg6P95e8uJVdi1VvxslKd7jsqryf+hU0eUrdLYmY4io6HtiTxP04S0p6B7jNbC8dTX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BsaQH0P26MS8qdMeJytzvU4N3HI5U18RDBOaXYLEmGTyoAX5
	G7G8AChQhk/oENNzVOzA3E8O9SLmK0DzPckWk156ZEm3IiXsU5RP6itFO3DgW1rS2bc=
X-Gm-Gg: ASbGncsrI5Q1JDEyUZYK7a/yM334JNRsxg4uodPpMC+XYEZpUKeuShvTrrSsjow84jk
	BZ8VGI5rho3KR1RSq5J6kCbdVnmXliFU+y7uQXY1TLwRks+o6N/eSF2Xg5ibMrlaFxMO+u63LXT
	bcUBerhecI6f/TV3ZONoccFv/7hsL578pLpURJNihy/EX0hhL3rtN/LeHz6b6qAnKhKCFyVy2VK
	ZGfaV7PSpOYeiOGf60RTXeOilxzdSBSYEsZih7XQ7SSMf5SeUUb0xr1xkk56YzCuxHc2gqiSRN0
	3trj3r1N9/vTjIUmDH28tHlazMNC5HTcum+iGBHuAu2qCsYRJ46aDS+Ttp9Y+gB1HGAmXqR1Y8D
	614L1no4UJqdj4PyFaIjymcHmrIfJf/Q65G9rXpPLzmuS9z5O/sfb+JIcSw8pTJ8/iTqeQMQYf1
	MZRADtAnVnuWJh4uNnWGk2
X-Google-Smtp-Source: AGHT+IH3Rnr9KTQSewiyDJxZYVWcxdCwkU03H2gP4ZOo4Vy5LVvo5/dzAHr56LlVqfHqMMIhppMFyg==
X-Received: by 2002:a17:902:ce01:b0:295:2c8e:8e44 with SMTP id d9443c01a7336-2962ae94470mr13204245ad.59.1762291059617;
        Tue, 04 Nov 2025 13:17:39 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998eb6sm37348165ad.29.2025.11.04.13.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 13:17:39 -0800 (PST)
Date: Tue, 4 Nov 2025 13:17:36 -0800
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
	Zong Li <zong.li@sifive.com>,
	Michael Ellerman <mpe@tenstorrent.com>
Subject: Re: [PATCH v22 00/28] riscv control-flow integrity for usermode
Message-ID: <aQptcHayBOY1sw1J@debug.ba.rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
 <CACPK8XeQf9UJuu39bGcm2mySWrKYvUadOgFRmpas+AS9fXA2WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACPK8XeQf9UJuu39bGcm2mySWrKYvUadOgFRmpas+AS9fXA2WA@mail.gmail.com>

Hi Joel,

Thanks a lot for testing it out.

Comments inline.

On Tue, Nov 04, 2025 at 05:34:11PM +1030, Joel Stanley wrote:
>Hello Deepak,
>
>On Fri, 24 Oct 2025 at 03:31, Deepak Gupta via B4 Relay
><devnull+debug.rivosinc.com@kernel.org> wrote:
>>
>> v22: fixing build error due to -march=zicfiss being picked in gcc-13 and above
>> but not actually doing any codegen or recognizing instruction for zicfiss.
>> Change in v22 makes dependence on `-fcf-protection=full` compiler flag to
>> ensure that toolchain has support and then only CONFIG_RISCV_USER_CFI will be
>> visible in menuconfig.
>
>Following our discussion at the riscv summit I spent some time with
>this patch set with the goal of giving a test run on emulation. I only
>got as far as qemu, as I couldn't get the selftests passing there.
>
>I had trouble running the podman container so I built a toolchain
>using the riscv-gnu-toolchain branch (cfi-dev, d19f3009f6c2) you
>pointed to.
>
>The opensbi branch was a bit old and wouldn't build with GCC 15, so I
>tried to rebase and noticed the patches were already upstream. Have
>you tested using v1.7 (or newer) there? Is there something I missed,
>do we need more patches on upstream opensbi?
>
>I booted it in qemu 10.1.2 with the zicfi extensions both on and off.
>
>qemu-system-riscv64 -M virt,aia=aplic-imsic,aia-guests=5 \
>  -cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true
>  -smp 8 -nographic -bios fw_dynamic.elf
>  -m 1024M -kernel arch/riscv/boot/Image \
>  -initrd selftests/selftests.cpio \
>  -append 'init=mini-init command="cfitests"'
>
>My results:
>
>no zicfi, no z*mop (crash, as expected):
>-------------------------------------------------
>
>Running command: cfitests
>system_opcode_insn: Invalid opcode for CSR read/write instruction[
>0.462709] cfitests[85]: unhandled signal 4 code 0x1 at
>0x0000000000011c44 in cfitests[1c44,10000+6d000]
>[    0.463141] CPU: 4 UID: 0 PID: 85 Comm: cfitests Not tainted
>6.18.0-rc3-tt-defconfig-jms-00090-g6e2297f1edbc #93 NONE
>[    0.463338] Hardware name: riscv-virtio,qemu (DT)
>[    0.463573] epc : 0000000000011c44 ra : 00000000000104e0 sp :
>00007fffebd0ddb0
>...
>[    0.465177] status: 0000000200004020 badaddr: 00000000ce104073
>cause: 0000000000000002
>[    0.465410] Code: 0893 05d0 4501 0073 0000 b7f5 4501 b7f9 0017 0000
>(4073) ce10
>
>no zicfi, z*mop (failed to start, as expected):
>-----------------------------------------------------------
>
>Running command: cfitests
>TAP version 13
># Starting risc-v CFI tests
>Bail out! Get landing pad status failed with -22
>
>zicfi, z*mop (failed to start, unexpected):
>-------------------------------------------------------
>Running command: cfitests
>TAP version 13
># Starting risc-v CFI tests
>Bail out! Get landing pad status failed with -22
>
>I went digging to see why the zicfi enabled kernel failed. The
>userspace binary was built with CFI:
>
>$ riscv64-unknown-linux-gnu-readelf -n selftests/cfitests
>
>Displaying notes found in: .note.gnu.property
>  Owner                Data size     Description
>  GNU                  0x00000010    NT_GNU_PROPERTY_TYPE_0
>      Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS
>
>I then tested your opensbi tree with some hacks to get it built with a
>newer compiler. This produced different results, which was unexpected:
>

Opensbi doesn't need to be built with new compiler. All it needs do are
reflect MPELP bit back to S-mode (if its taking a trap and then reflecting
back to S-mode) and ofcourse have SSE support. Both of these are upstream
in opensbi.

I'll test with upstream opensbi, test and report back.

>Running command: cfitests
>TAP version 13
># Starting risc-v CFI tests
>Bail out! Landing pad is not enabled, should be enabled via glibc
># Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>
>The selftest binary and the little toy init that starts it are both
>statically linked and built against the toolchain's glibc, so I would
>expect this to work.
>
>$ riscv64-unknown-linux-gnu-readelf -n sifive-cfi-build/sysroot/usr/lib/libc.a
>
>File: sifive-cfi-build/sysroot/usr/lib/libc.a(init-first.o)
>
>Displaying notes found in: .note.gnu.property
>  Owner                Data size        Description
>  GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
>      Properties: RISC-V AND feature: CFI_LP_UNLABELED, CFI_SS
>
>The kernel seems to have detected that CFI is available and is built with it:
>
>$ grep CFI .config
>CONFIG_RISCV_USER_CFI=y
>CONFIG_ARCH_SUPPORTS_CFI=y
>
>I did notice the func-sig-dev gcc branch is a few commits ahead of
>what the sifive riscv-gnu-toolchain points to.

Most likely PRCTL_* is not updated in cfi-dev branch? I'll take a look.

>
>I had to context switch to some other tasks at this point. I wanted to
>do some more digging to work out what was wrong, but I haven't found
>time, so here are my notes in the hope that they are useful. I'll let
>you know if I discover anything further.

Thanks once again.
>
>Cheers,
>
>Joel
>
>
>> How to test this series
>> =======================
>>
>> Toolchain
>> ---------
>> $ git clone git@github.com:sifive/riscv-gnu-toolchain.git -b cfi-dev
>> $ riscv-gnu-toolchain/configure --prefix=<path-to-where-to-build> --with-arch=rv64gc_zicfilp_zicfiss --enable-linux --disable-gdb  --with-extra-multilib-test="rv64gc_zicfilp_zicfiss-lp64d:-static"
>> $ make -j$(nproc)
>>
>> Qemu
>> ----
>> Get the lastest qemu
>> $ cd qemu
>> $ mkdir build
>> $ cd build
>> $ ../configure --target-list=riscv64-softmmu
>> $ make -j$(nproc)
>>
>> Opensbi
>> -------
>> $ git clone git@github.com:deepak0414/opensbi.git -b v6_cfi_spec_split_opensbi
>> $ make CROSS_COMPILE=<your riscv toolchain> -j$(nproc) PLATFORM=generic
>>
>> Linux
>> -----
>> Running defconfig is fine. CFI is enabled by default if the toolchain
>> supports it.
>>
>> $ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc) defconfig
>> $ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc)
>>
>> Running
>> -------
>>
>> Modify your qemu command to have:
>> -bios <path-to-cfi-opensbi>/build/platform/generic/firmware/fw_dynamic.bin
>> -cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true

