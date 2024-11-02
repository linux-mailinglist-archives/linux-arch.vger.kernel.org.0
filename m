Return-Path: <linux-arch+bounces-8792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2711D9BA230
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 20:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D0B1C2040E
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B0A1AA7B7;
	Sat,  2 Nov 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="cdf9yJhC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958D14F12F;
	Sat,  2 Nov 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577233; cv=none; b=BeGnlUk2/LWqwmequSpyGxUFFtgHYJFAsEZaXax1aixXPxoAU9rKdZTgwbFEiEMO7nxxSDGANtjTcfxtMZCsb22isPAVR2MBpuRIOCeU1U+X7U4kuUQa4DaWZy3HwK6ExKKCa4uY6zKql1sRiW/0CvV31WG0sAguQ8pv4BfruQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577233; c=relaxed/simple;
	bh=JdArpWA9vFt1hkUkWUm005K/eH4T5f2zOfSeWwDv19Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LbStU4spbqGW2wZ8ejtlN0x4/BObuRllTyw8JVwAZdQEVJ97ZP3drVwnkFx9xPMH9JmLqH6/bkNWDX+H2rTj449IU6ll4YjsOQcYYPSaaB4/3K3X26LCT/G2qXm1atzM2HXeclABznB3qfIDNBHY7idT1RpCYikoD6tVMV9MFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=cdf9yJhC; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FB082805B4;
	Sat,  2 Nov 2024 20:53:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1730577227; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=iBgrUxzme4W2cd1/xJd7CFK8K4SzsQKvQfKry0TV6As=;
	b=cdf9yJhCJo9REzvuK5pxQZIJ52OQDqKVDZRFO4hDKxrhXK6LFkUQ8n0iToBucy6M47lXGU
	3QD98eIW/8gRb8m5yPBOyaj7C6Eyroi7aCMp1LJuM0PM0vwkna9K+C1AjYGlEXz/kDQ4md
	7SukJUauJe0xVSdhjeSdLGo2r4DOlYc7xMx5nzLYhjGcYVFt3QFOEuxOHyO1eV8jtbHr1E
	FxbAbA1RQba+JA93Bu9kgr2JYWm/BxT3kWT9Deaq/Kz1Snt1IPCOO2ORyMf6BzSyswUn5X
	h/6DwKQbZpipNrQYsXtu0sFSu3GbZT9z42S57mieVG0z4sKUiAlCt2+PXlCw6w==
Message-ID: <3183ab86-8f1f-4624-9175-31e77d773699@cachyos.org>
Date: Sat, 2 Nov 2024 20:53:43 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] Add AutoFDO support for Clang build
From: Peter Jung <ptr1337@cachyos.org>
To: Rong Xu <xur@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>,
 Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>,
 workflows@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Maksim Panchenko <max4bolt@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>,
 Krzysztof Pszeniczny <kpszeniczny@google.com>,
 Sriraman Tallam <tmsriram@google.com>, Stephane Eranian <eranian@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241102175115.1769468-1-xur@google.com>
 <20241102175115.1769468-2-xur@google.com>
 <09349180-027a-4b29-a40c-9dc3425e592c@cachyos.org>
Content-Language: en-US
Organization: CachyOS
In-Reply-To: <09349180-027a-4b29-a40c-9dc3425e592c@cachyos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 02.11.24 20:46, Peter Jung wrote:
> 
> 
> On 02.11.24 18:51, Rong Xu wrote:
>> Add the build support for using Clang's AutoFDO. Building the kernel
>> with AutoFDO does not reduce the optimization level from the
>> compiler. AutoFDO uses hardware sampling to gather information about
>> the frequency of execution of different code paths within a binary.
>> This information is then used to guide the compiler's optimization
>> decisions, resulting in a more efficient binary. Experiments
>> showed that the kernel can improve up to 10% in latency.
>>
>> The support requires a Clang compiler after LLVM 17. This submission
>> is limited to x86 platforms that support PMU features like LBR on
>> Intel machines and AMD Zen3 BRS. Support for SPE on ARM 1,
>>   and BRBE on ARM 1 is part of planned future work.
>>
>> Here is an example workflow for AutoFDO kernel:
>>
>> 1) Build the kernel on the host machine with LLVM enabled, for example,
>>         $ make menuconfig LLVM=1
>>      Turn on AutoFDO build config:
>>        CONFIG_AUTOFDO_CLANG=y
>>      With a configuration that has LLVM enabled, use the following
>>      command:
>>         scripts/config -e AUTOFDO_CLANG
>>      After getting the config, build with
>>        $ make LLVM=1
>>
>> 2) Install the kernel on the test machine.
>>
>> 3) Run the load tests. The '-c' option in perf specifies the sample
>>     event period. We suggest     using a suitable prime number,
>>     like 500009, for this purpose.
>>     For Intel platforms:
>>        $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c 
>> <count> \
>>          -o <perf_file> -- <loadtest>
>>     For AMD platforms:
>>        The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
>>       For Zen3:
>>        $ cat proc/cpuinfo | grep " brs"
>>        For Zen4:
>>        $ cat proc/cpuinfo | grep amd_lbr_v2
>>        $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k 
>> -a \
>>          -N -b -c <count> -o <perf_file> -- <loadtest>
>>
>> 4) (Optional) Download the raw perf file to the host machine.
>>
>> 5) To generate an AutoFDO profile, two offline tools are available:
>>     create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
>>     of the AutoFDO project and can be found on GitHub
>>     (https://github.com/google/autofdo), version v0.30.1 or later. The
>>     llvm_profgen tool is included in the LLVM compiler itself. It's
>>     important to note that the version of llvm_profgen doesn't need to
>>     match the version of Clang. It needs to be the LLVM 19 release or
>>     later, or from the LLVM trunk.
>>        $ llvm-profgen --kernel --binary=<vmlinux> -- 
>> perfdata=<perf_file> \
>>          -o <profile_file>
>>     or
>>        $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file> \
>>          --format=extbinary --out=<profile_file>
>>
>>     Note that multiple AutoFDO profile files can be merged into one via:
>>        $ llvm-profdata merge -o <profile_file>  <profile_1> ... 
>> <profile_n>
>>
>> 6) Rebuild the kernel using the AutoFDO profile file with the same config
>>     as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
>>        $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<profile_file>
>>
>> Co-developed-by: Han Shen<shenhan@google.com>
>> Signed-off-by: Han Shen<shenhan@google.com>
>> Signed-off-by: Rong Xu<xur@google.com>
>> Suggested-by: Sriraman Tallam<tmsriram@google.com>
>> Suggested-by: Krzysztof Pszeniczny<kpszeniczny@google.com>
>> Suggested-by: Nick Desaulniers<ndesaulniers@google.com>
>> Suggested-by: Stephane Eranian<eranian@google.com>
>> Tested-by: Yonghong Song<yonghong.song@linux.dev>
>> Tested-by: Yabin Cui<yabinc@google.com>
>> Tested-by: Nathan Chancellor<nathan@kernel.org>
>> Reviewed-by: Kees Cook<kees@kernel.org>
> 
> Tested-by: Peter Jung <ptr1337@cachyos.org>
> 

The compilations and testing with the "make pacman-pkg" function from 
the kernel worked fine.

One problem I do face:
When I apply a AutoFDO profile together with the PKGBUILD [1] from 
archlinux im running into issues at "module_install" at the packaging.

See following log:
```
make[2]: *** [scripts/Makefile.modinst:125: 
/tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko] 
Error 1
make[2]: *** Deleting file 
'/tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko'
   INSTALL 
/tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/crypto/cryptd.ko
make[2]: *** Waiting for unfinished jobs....
```


This can be fixed with removed "INSTALL_MOD_STRIP=1" to the passed 
parameters of module_install.

This explicitly only happens, if a profile is passed - otherwise the 
packaging works without problems.

Regards,

Peter Jung


