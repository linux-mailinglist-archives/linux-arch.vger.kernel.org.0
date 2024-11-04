Return-Path: <linux-arch+bounces-8838-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB5C9BB9CD
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 17:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8E61C2268E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B001C07F1;
	Mon,  4 Nov 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="gBzZ8Ebe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA01C07EC;
	Mon,  4 Nov 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736366; cv=none; b=dtNzgHX8F4wtfVUdaUX8zIHHAvCV5RpU/KMM6yw5jL7SkKG9v0x0LlcpTJtRJBrDJ8XzLC7/6ULfNhg6666hyPy+0BvaiNTsNK/xQqLPu6y23hcQxi0dWEj+8Ey19wp1dHKtfCkn5tfPPESWE89kAumUbhpVijc+AY2aJ4/GElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736366; c=relaxed/simple;
	bh=7ZX/yKOs59hpCNIwhc75CDMFDztu8GVRreFYUik0AsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtQ3pwDsIxiioAlZcbjJUBWIDOjWz0TzBIfnJMKSVfnhvDqaPjaCOJzg1ESKUKySiZACXEumWfPqf9eU1aeXqbNggN73tzNoYfdsqgdT1PiRkPdccd/EkZUIJ1Kxj0zpK5JDDX6ab84Bn32XB4Kc6sMXTctzzsBL2wwfwt6hONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=gBzZ8Ebe; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68D432805A2;
	Mon,  4 Nov 2024 17:05:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1730736359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=78/2oLkCdDHGBvs3uMZj3vtPS/+5QCyX/4kNxVy7H4Q=;
	b=gBzZ8EbeWQI8MgAt4JyBxlZjhTloI+6ztk2v2rJqIFn59azcp0ZYtSQT5vARD9NtiuR9Ox
	0HcDfuptMwj6k77huTolotwxGTBWqWwk6ZrP4OTN1i2Np48JG4xI/DBZY7oHDqtTF6Y/8T
	J2gFnJvsFUeePDPJ5x7zhz5qu7OnNupJ5l6wM7Wuez67vPymwA4t6/wK1yQHFqgrPJR4IV
	nMop9crreSSOMbB4cch2Tn7ufItQYgi/ANkAv/26SaUTyZZIFPzUNJf7IormfU+1cZKQjq
	0V/RtFROlo56MtRyTG4zqyli1ABpCY1LtfekneEWXbvqA8x2HujcGZv19metMA==
Message-ID: <d535cdfa-610d-4f41-b1e4-aa36f5d7e298@cachyos.org>
Date: Mon, 4 Nov 2024 17:05:50 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] Add AutoFDO support for Clang build
To: Han Shen <shenhan@google.com>
Cc: Rong Xu <xur@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>,
 Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Juergen Gross <jgross@suse.com>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
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
 Sriraman Tallam <tmsriram@google.com>, Stephane Eranian
 <eranian@google.com>, x86@kernel.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20241102175115.1769468-1-xur@google.com>
 <20241102175115.1769468-2-xur@google.com>
 <09349180-027a-4b29-a40c-9dc3425e592c@cachyos.org>
 <3183ab86-8f1f-4624-9175-31e77d773699@cachyos.org>
 <CACkGtrgOw8inYCD96ot_w9VwzoFvvgCReAx0P-=Rxxqj2FT4_A@mail.gmail.com>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <CACkGtrgOw8inYCD96ot_w9VwzoFvvgCReAx0P-=Rxxqj2FT4_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Han,

Thanks for the test. I will look into my current setup again and will 
let you know.

Please do not see this as blocker for now. :)

Regards,

Peter

On 04.11.24 05:50, Han Shen wrote:
> Hi Peter, thanks for reporting the issue. I am trying to reproduce it
> in the up-to-date archlinux environment. Below is what I have:
>    0. pacman -Syu
>    1. cloned archlinux build files from
> https://aur.archlinux.org/linux-mainline.git the newest mainline
> version is 6.12rc5-1.
>    2. changed the PKGBUILD file to include the patches series
>    3. changed the "config" to turn on clang autofdo
>    4. collected afdo profiles
>    5. MAKEFLAGS="-j48 V=1 LLVM=1 CLANG_AUTOFDO_PROFILE=$(pwd)/perf.afdo" \
>          makepkg -s --skipinteg --skippgp
>    6. install and reboot
> The above steps succeeded.
> You mentioned the error happens at "module_install", can you instruct
> me how to execute the "module_install" step?
> 
> Thanks,
> Han
> 
> On Sat, Nov 2, 2024 at 12:53 PM Peter Jung<ptr1337@cachyos.org> wrote:
>>
>>
>> On 02.11.24 20:46, Peter Jung wrote:
>>>
>>> On 02.11.24 18:51, Rong Xu wrote:
>>>> Add the build support for using Clang's AutoFDO. Building the kernel
>>>> with AutoFDO does not reduce the optimization level from the
>>>> compiler. AutoFDO uses hardware sampling to gather information about
>>>> the frequency of execution of different code paths within a binary.
>>>> This information is then used to guide the compiler's optimization
>>>> decisions, resulting in a more efficient binary. Experiments
>>>> showed that the kernel can improve up to 10% in latency.
>>>>
>>>> The support requires a Clang compiler after LLVM 17. This submission
>>>> is limited to x86 platforms that support PMU features like LBR on
>>>> Intel machines and AMD Zen3 BRS. Support for SPE on ARM 1,
>>>>    and BRBE on ARM 1 is part of planned future work.
>>>>
>>>> Here is an example workflow for AutoFDO kernel:
>>>>
>>>> 1) Build the kernel on the host machine with LLVM enabled, for example,
>>>>          $ make menuconfig LLVM=1
>>>>       Turn on AutoFDO build config:
>>>>         CONFIG_AUTOFDO_CLANG=y
>>>>       With a configuration that has LLVM enabled, use the following
>>>>       command:
>>>>          scripts/config -e AUTOFDO_CLANG
>>>>       After getting the config, build with
>>>>         $ make LLVM=1
>>>>
>>>> 2) Install the kernel on the test machine.
>>>>
>>>> 3) Run the load tests. The '-c' option in perf specifies the sample
>>>>      event period. We suggest     using a suitable prime number,
>>>>      like 500009, for this purpose.
>>>>      For Intel platforms:
>>>>         $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c
>>>> <count> \
>>>>           -o <perf_file> -- <loadtest>
>>>>      For AMD platforms:
>>>>         The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
>>>>        For Zen3:
>>>>         $ cat proc/cpuinfo | grep " brs"
>>>>         For Zen4:
>>>>         $ cat proc/cpuinfo | grep amd_lbr_v2
>>>>         $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k
>>>> -a \
>>>>           -N -b -c <count> -o <perf_file> -- <loadtest>
>>>>
>>>> 4) (Optional) Download the raw perf file to the host machine.
>>>>
>>>> 5) To generate an AutoFDO profile, two offline tools are available:
>>>>      create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
>>>>      of the AutoFDO project and can be found on GitHub
>>>>      (https://github.com/google/autofdo), version v0.30.1 or later. The
>>>>      llvm_profgen tool is included in the LLVM compiler itself. It's
>>>>      important to note that the version of llvm_profgen doesn't need to
>>>>      match the version of Clang. It needs to be the LLVM 19 release or
>>>>      later, or from the LLVM trunk.
>>>>         $ llvm-profgen --kernel --binary=<vmlinux> --
>>>> perfdata=<perf_file> \
>>>>           -o <profile_file>
>>>>      or
>>>>         $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file> \
>>>>           --format=extbinary --out=<profile_file>
>>>>
>>>>      Note that multiple AutoFDO profile files can be merged into one via:
>>>>         $ llvm-profdata merge -o <profile_file>  <profile_1> ...
>>>> <profile_n>
>>>>
>>>> 6) Rebuild the kernel using the AutoFDO profile file with the same config
>>>>      as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
>>>>         $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<profile_file>
>>>>
>>>> Co-developed-by: Han Shen<shenhan@google.com>
>>>> Signed-off-by: Han Shen<shenhan@google.com>
>>>> Signed-off-by: Rong Xu<xur@google.com>
>>>> Suggested-by: Sriraman Tallam<tmsriram@google.com>
>>>> Suggested-by: Krzysztof Pszeniczny<kpszeniczny@google.com>
>>>> Suggested-by: Nick Desaulniers<ndesaulniers@google.com>
>>>> Suggested-by: Stephane Eranian<eranian@google.com>
>>>> Tested-by: Yonghong Song<yonghong.song@linux.dev>
>>>> Tested-by: Yabin Cui<yabinc@google.com>
>>>> Tested-by: Nathan Chancellor<nathan@kernel.org>
>>>> Reviewed-by: Kees Cook<kees@kernel.org>
>>> Tested-by: Peter Jung<ptr1337@cachyos.org>
>>>
>> The compilations and testing with the "make pacman-pkg" function from
>> the kernel worked fine.
>>
>> One problem I do face:
>> When I apply a AutoFDO profile together with the PKGBUILD [1] from
>> archlinux im running into issues at "module_install" at the packaging.
>>
>> See following log:
>> ```
>> make[2]: *** [scripts/Makefile.modinst:125:
>> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko]
>> Error 1
>> make[2]: *** Deleting file
>> '/tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko'
>>     INSTALL
>> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/crypto/cryptd.ko
>> make[2]: *** Waiting for unfinished jobs....
>> ```
>>
>>
>> This can be fixed with removed "INSTALL_MOD_STRIP=1" to the passed
>> parameters of module_install.
>>
>> This explicitly only happens, if a profile is passed - otherwise the
>> packaging works without problems.
>>
>> Regards,
>>
>> Peter Jung
>>


