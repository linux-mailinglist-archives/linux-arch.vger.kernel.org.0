Return-Path: <linux-arch+bounces-8856-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AA9BCF6A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 15:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D318D1C23A69
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749C1D5CD7;
	Tue,  5 Nov 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="QwlXgt1f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896239FF3;
	Tue,  5 Nov 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817237; cv=none; b=qmJGPF/RZ3GT6bnRLOAXF77O8r1RkfREr9TVmRKTjTMzbHpObPKxWKzUsbl3VmaLeDEggnLgNpgTRidcSxsUt+U2+ImudAhZM0SfaUF21gnS8TM3Kd4FqqlCvPT6tcScJhsGHN92WhVC8gTmJvAIe8FCtae45ZN4XhMcl32LOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817237; c=relaxed/simple;
	bh=gsW8mBSI6cY3pRx1Tnd7rSPcm9Ju7jaDrhLeixfTBRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUyYsbndX7/fHq5XbUnsBklbco9spRtjyzHYDcR4zDaeeaTw4qNmWF0QgSWusvH8kCBNTWKiwVSqt0LigVLcRM3e7ZIem1wE7tfM3xShOC5EnyLaVGJQI1KEzK3SQv1HCcXucW01V0W2oNffza7vyOlTGTvhyq/ItmfypftXd9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=QwlXgt1f; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 045952805AD;
	Tue,  5 Nov 2024 15:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1730817231; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IFyVI7raGwOORp7kXv0MX/2J7dD25+2v6npetzMKfw4=;
	b=QwlXgt1fNIREa3Bj3xNUJEH6SxJ9atiLd5/fDEk4nap12xPqziY7rGNsBeKDER8yIr/NIQ
	fqDuL2qvfCvIfKpP+1BS2wRySY2Ka/XQwv4ETerMAow0nQcB2UEP/10nORQs+VkoH3YG93
	qWDL0wXafzNbD9uRNYNcnHS6XKOn2DwVCw270EP3VDHSwZPD9afyXHlqA4s43wjeyvh8rk
	vK7R6dxhNfJHGCtR1/ZmpkNkeqVmpqtznhWRsstHEGvkCgx3XIJwDeKr2XKy/Upd4JZjSE
	TcwVpTyw9AYmND9rasqETLV+CXfEXKd6bIMvCjRNk02LGVGbYrAown6sxi3bjw==
Message-ID: <449fddd2-342f-48cc-9a11-8a34814f1284@cachyos.org>
Date: Tue, 5 Nov 2024 15:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] Add AutoFDO support for Clang build
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
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
 <67c07d2f-fb1f-4b7d-96e2-fb5ceb8fc692@cachyos.org>
 <CACkGtrgJHtG5pXR1z=6G4XR6ffT5jEi3jZQo=UhYj091naBhsA@mail.gmail.com>
 <CAF1bQ=SbeR3XhFc7JYGOh69JZfAwQV8nupAQM+ZxpzNEFUFxJw@mail.gmail.com>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <CAF1bQ=SbeR3XhFc7JYGOh69JZfAwQV8nupAQM+ZxpzNEFUFxJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Rong,

Glad that you were able to reproduce the issue!
Thanks for finding the root cause as well as the part of the code. This 
really helps.

I was able to do a successful packaging with binutils 2.42.
Lets forward this to the binutils tracker and hope this will be soon 
solved. :)

I have tested this also on the latest commit 
(e1e4078ac59740a79cd709d61872abe15aba0087) and the issue is also 
reproducible there.

Thanks for your time! I dont see this as blocker. :)
It gets time to get this series merged :P

Best regards,

Peter



On 05.11.24 08:25, Rong Xu wrote:
> We debugged this issue and we found the failure seems to only happen
> with strip (version 2.43) in binutil.
> 
> For a profile-use compilation, either with -fprofile-use (PGO or
> iFDO), or -fprofile-sample-use (AutoFDO),
> an ELF section of .llvm.call-graph-profile is created for the object.
> For some reasons (like to save space?),
> the relocations in this section are of type "rel', rather the more
> common "rela" type.
> 
> In this case,
> $ readelf -r kvm.ko |grep llvm.call-graph-profile
> Relocation section '.rel.llvm.call-graph-profile' at offset 0xf62a00
> contains 4 entries:
> 
> strip (v2.43.0) has difficulty handling the relocations in
> .rel.llvm.call-graph-profile -- it silently failed with --strip-debug.
> But strip (v.2.42) has no issue with kvm.ko. The strip in llvm (i.e.
> llvm-strip) also passes with kvm.ko
> 
> I compared binutil/strip source code for version v2.43.0 and v2.42.
> The different is around here:
> In v2.42 of bfd/elfcode.h
>     1618       if ((entsize == sizeof (Elf_External_Rela)
>     1619            && ebd->elf_info_to_howto != NULL)
>     1620           || ebd->elf_info_to_howto_rel == NULL)
>     1621         res = ebd->elf_info_to_howto (abfd, relent, &rela);
>     1622       else
>     1623         res = ebd->elf_info_to_howto_rel (abfd, relent, &rela);
> 
> In v2.43.0 of bfd/elfcode.h
>     1618       if (entsize == sizeof (Elf_External_Rela)
>     1619           && ebd->elf_info_to_howto != NULL)
>     1620         res = ebd->elf_info_to_howto (abfd, relent, &rela);
>     1621       else if (ebd->elf_info_to_howto_rel != NULL)
>     1622         res = ebd->elf_info_to_howto_rel (abfd, relent, &rela);
> 
> In the 2.43 strip, line 1618 is false and line 1621 is also false.
> "res" is returned as false and the program exits with -1.
> 
> While in 2.42, line 1620 is true and we get "res" from line 1621 and
> program functions correctly.
> 
> I'm not familiar with binutil code base and don't know the reason for
> removing line 1620.
> I can file a bug for binutil for people to further investigate this.
> 
> It seems to me that this issue should not be a blocker for our patch.
> 
> Regards,
> 
> -Rong
> 
> 
> 
> 
> 
> On Mon, Nov 4, 2024 at 12:24 PM Han Shen<shenhan@google.com> wrote:
>> Hi Peter,
>> Thanks for providing the detailed reproduce.
>> Now I can see the error (after I synced to 6.12.0-rc6, I was using rc5).
>> I'll look into that and report back.
>>
>>> I have tested your provided method, but the AutoFDO profile (lld does
>> not get lto-sample-profile=$pathtoprofile passed)
>>
>> I see. You also turned on ThinLTO, which I didn't, so the profile was
>> only used during compilation, not passed to lld.
>>
>> Thanks,
>> Han
>>
>> On Mon, Nov 4, 2024 at 9:31 AM Peter Jung<ptr1337@cachyos.org> wrote:
>>> Hi Han,
>>>
>>> I have tested your provided method, but the AutoFDO profile (lld does
>>> not get lto-sample-profile=$pathtoprofile passed)  nor Clang as compiler
>>> gets used.
>>> Please replace following PKGBUILD and config from linux-mainline with
>>> the provided one in the gist. The patch is also included there.
>>>
>>> https://gist.github.com/ptr1337/c92728bb273f7dbc2817db75eedec9ed
>>>
>>> The main change I am doing here, is passing following to the build array
>>> and replacing "make all":
>>>
>>> make LLVM=1 LLVM_IAS=1 CLANG_AUTOFDO_PROFILE=${srcdir}/perf.afdo all
>>>
>>> When compiling the kernel with makepkg, this results at the packaging to
>>> following issue and can be reliable reproduced.
>>>
>>> Regards,
>>>
>>> Peter
>>>
>>>
>>> On 04.11.24 05:50, Han Shen wrote:
>>>> Hi Peter, thanks for reporting the issue. I am trying to reproduce it
>>>> in the up-to-date archlinux environment. Below is what I have:
>>>>     0. pacman -Syu
>>>>     1. cloned archlinux build files from
>>>> https://aur.archlinux.org/linux-mainline.git the newest mainline
>>>> version is 6.12rc5-1.
>>>>     2. changed the PKGBUILD file to include the patches series
>>>>     3. changed the "config" to turn on clang autofdo
>>>>     4. collected afdo profiles
>>>>     5. MAKEFLAGS="-j48 V=1 LLVM=1 CLANG_AUTOFDO_PROFILE=$(pwd)/perf.afdo" \
>>>>           makepkg -s --skipinteg --skippgp
>>>>     6. install and reboot
>>>> The above steps succeeded.
>>>> You mentioned the error happens at "module_install", can you instruct
>>>> me how to execute the "module_install" step?
>>>>
>>>> Thanks,
>>>> Han
>>>>
>>>> On Sat, Nov 2, 2024 at 12:53 PM Peter Jung<ptr1337@cachyos.org> wrote:
>>>>>
>>>>> On 02.11.24 20:46, Peter Jung wrote:
>>>>>> On 02.11.24 18:51, Rong Xu wrote:
>>>>>>> Add the build support for using Clang's AutoFDO. Building the kernel
>>>>>>> with AutoFDO does not reduce the optimization level from the
>>>>>>> compiler. AutoFDO uses hardware sampling to gather information about
>>>>>>> the frequency of execution of different code paths within a binary.
>>>>>>> This information is then used to guide the compiler's optimization
>>>>>>> decisions, resulting in a more efficient binary. Experiments
>>>>>>> showed that the kernel can improve up to 10% in latency.
>>>>>>>
>>>>>>> The support requires a Clang compiler after LLVM 17. This submission
>>>>>>> is limited to x86 platforms that support PMU features like LBR on
>>>>>>> Intel machines and AMD Zen3 BRS. Support for SPE on ARM 1,
>>>>>>>     and BRBE on ARM 1 is part of planned future work.
>>>>>>>
>>>>>>> Here is an example workflow for AutoFDO kernel:
>>>>>>>
>>>>>>> 1) Build the kernel on the host machine with LLVM enabled, for example,
>>>>>>>           $ make menuconfig LLVM=1
>>>>>>>        Turn on AutoFDO build config:
>>>>>>>          CONFIG_AUTOFDO_CLANG=y
>>>>>>>        With a configuration that has LLVM enabled, use the following
>>>>>>>        command:
>>>>>>>           scripts/config -e AUTOFDO_CLANG
>>>>>>>        After getting the config, build with
>>>>>>>          $ make LLVM=1
>>>>>>>
>>>>>>> 2) Install the kernel on the test machine.
>>>>>>>
>>>>>>> 3) Run the load tests. The '-c' option in perf specifies the sample
>>>>>>>       event period. We suggest     using a suitable prime number,
>>>>>>>       like 500009, for this purpose.
>>>>>>>       For Intel platforms:
>>>>>>>          $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c
>>>>>>> <count> \
>>>>>>>            -o <perf_file> -- <loadtest>
>>>>>>>       For AMD platforms:
>>>>>>>          The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
>>>>>>>         For Zen3:
>>>>>>>          $ cat proc/cpuinfo | grep " brs"
>>>>>>>          For Zen4:
>>>>>>>          $ cat proc/cpuinfo | grep amd_lbr_v2
>>>>>>>          $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k
>>>>>>> -a \
>>>>>>>            -N -b -c <count> -o <perf_file> -- <loadtest>
>>>>>>>
>>>>>>> 4) (Optional) Download the raw perf file to the host machine.
>>>>>>>
>>>>>>> 5) To generate an AutoFDO profile, two offline tools are available:
>>>>>>>       create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
>>>>>>>       of the AutoFDO project and can be found on GitHub
>>>>>>>       (https://github.com/google/autofdo), version v0.30.1 or later. The
>>>>>>>       llvm_profgen tool is included in the LLVM compiler itself. It's
>>>>>>>       important to note that the version of llvm_profgen doesn't need to
>>>>>>>       match the version of Clang. It needs to be the LLVM 19 release or
>>>>>>>       later, or from the LLVM trunk.
>>>>>>>          $ llvm-profgen --kernel --binary=<vmlinux> --
>>>>>>> perfdata=<perf_file> \
>>>>>>>            -o <profile_file>
>>>>>>>       or
>>>>>>>          $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file> \
>>>>>>>            --format=extbinary --out=<profile_file>
>>>>>>>
>>>>>>>       Note that multiple AutoFDO profile files can be merged into one via:
>>>>>>>          $ llvm-profdata merge -o <profile_file>  <profile_1> ...
>>>>>>> <profile_n>
>>>>>>>
>>>>>>> 6) Rebuild the kernel using the AutoFDO profile file with the same config
>>>>>>>       as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
>>>>>>>          $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<profile_file>
>>>>>>>
>>>>>>> Co-developed-by: Han Shen<shenhan@google.com>
>>>>>>> Signed-off-by: Han Shen<shenhan@google.com>
>>>>>>> Signed-off-by: Rong Xu<xur@google.com>
>>>>>>> Suggested-by: Sriraman Tallam<tmsriram@google.com>
>>>>>>> Suggested-by: Krzysztof Pszeniczny<kpszeniczny@google.com>
>>>>>>> Suggested-by: Nick Desaulniers<ndesaulniers@google.com>
>>>>>>> Suggested-by: Stephane Eranian<eranian@google.com>
>>>>>>> Tested-by: Yonghong Song<yonghong.song@linux.dev>
>>>>>>> Tested-by: Yabin Cui<yabinc@google.com>
>>>>>>> Tested-by: Nathan Chancellor<nathan@kernel.org>
>>>>>>> Reviewed-by: Kees Cook<kees@kernel.org>
>>>>>> Tested-by: Peter Jung<ptr1337@cachyos.org>
>>>>>>
>>>>> The compilations and testing with the "make pacman-pkg" function from
>>>>> the kernel worked fine.
>>>>>
>>>>> One problem I do face:
>>>>> When I apply a AutoFDO profile together with the PKGBUILD [1] from
>>>>> archlinux im running into issues at "module_install" at the packaging.
>>>>>
>>>>> See following log:
>>>>> ```
>>>>> make[2]: *** [scripts/Makefile.modinst:125:
>>>>> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko]
>>>>> Error 1
>>>>> make[2]: *** Deleting file
>>>>> '/tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko'
>>>>>      INSTALL
>>>>> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/crypto/cryptd.ko
>>>>> make[2]: *** Waiting for unfinished jobs....
>>>>> ```
>>>>>
>>>>>
>>>>> This can be fixed with removed "INSTALL_MOD_STRIP=1" to the passed
>>>>> parameters of module_install.
>>>>>
>>>>> This explicitly only happens, if a profile is passed - otherwise the
>>>>> packaging works without problems.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Peter Jung
>>>>>


