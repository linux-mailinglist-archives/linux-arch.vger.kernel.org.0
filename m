Return-Path: <linux-arch+bounces-7719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A8C991B63
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 01:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B8E1C21303
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 23:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93FD146589;
	Sat,  5 Oct 2024 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BghJEQ18"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E11F61C;
	Sat,  5 Oct 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728171493; cv=none; b=MkhGRwL5kySByy9jseb/PRjoGzZEjYHZqSM9MBOnAp2ecQFsCnF50/W2SnQcDzILLdEC0fegXM6EZoF6XSu10aSdrzth/NiwFYR+J/yTnJvMVU6eu44tkgvgYybA2cgRWV/b69iVSRblOPf/wg9wQPSF9e8jnKSG1jwq5oE1PhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728171493; c=relaxed/simple;
	bh=Ub3jK6SsxvGHuG2/fm1/AWnleUfV4tsAHwDVlmCsMmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fsp5e8A7E/+CgIw2ZhxqRBNo6yYefh/KcUqW/IQt39vspBwwIddvQRNhjttpjKqVJtTpfJ/9vKh02hU/e/0Lfm340B124eoPK3F5z0Sm997jsfTUc5h2DciUsJNPnZ0Pwa+Y5MIVa0o6ve6TZmWck19e03LFoYECI+3oag3a9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BghJEQ18; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.0.16] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 495NapwS1593555
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 5 Oct 2024 16:36:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 495NapwS1593555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024091601; t=1728171417;
	bh=m2bDCv+JjGunSzRwzd1ZUTedJ+jUnwm4JpAQk4uZ2LU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BghJEQ18w7kVZdQoBcXCZs0SU3bcgDNp6CXGpXr7UatIaOcHRnO7Ki4rpVZIgv9pe
	 Nz/Yk9sWAKxmvlzBMFe+EzcwMpOVx8UY7o5nMcwClHG2k8LpXw0UQzSqj2Ekiu9nFP
	 wt8vdbGEEzYAHkF9s6cSQNFQmtVxTKG2NMzwvRANGuDKm19FSlXxR5j1m1jSvaYdtx
	 sgCWbTe/DYdl96GonJp4olM5FfNyVaxnYW3tvOSS7nL1Z6OVpcsDWxBZnYXqBOzYxJ
	 3JEuMDZsQny031HV9xMehx7Re34CsvirpbQ/mcBdKSCBdY6WlekkljNm2jzhEgdjiU
	 mKVdT3IwdQMNA==
Message-ID: <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com>
Date: Sat, 5 Oct 2024 16:36:48 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Justin Stitt <justinstitt@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
        rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com>
 <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
 <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
 <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
 <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com>
 <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/24 01:31, Uros Bizjak wrote:
>>
>> movq $sym to leaq sym(%rip) which you said ought to be smaller (and in
>> reality appears to be the same size, 7 bytes) seems like a no-brainer
>> and can be treated as a code quality issue -- in other words, file bug
>> reports against gcc and clang.
> 
> It is the kernel assembly source that should be converted to
> rip-relative form, gcc (and probably clang) have nothing with it.
> 

Sadly, that is not correct; neither gcc nor clang uses lea:

	-hpa


gcc version 14.2.1 20240912 (Red Hat 14.2.1-3) (GCC)

hpa@tazenda:/tmp$ cat foo.c
int foobar;

int *where_is_foobar(void)
{
         return &foobar;
}

hpa@tazenda:/tmp$ gcc -mcmodel=kernel -O2 -c -o foo.o foo.c
hpa@tazenda:/tmp$ objdump -dr foo.o

foo.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <where_is_foobar>:
    0:   48 c7 c0 00 00 00 00    mov    $0x0,%rax
                         3: R_X86_64_32S foobar
    7:   c3                      ret

clang version 18.1.8 (Fedora 18.1.8-1.fc40)

hpa@tazenda:/tmp$ clang -mcmodel=kernel -O2 -c -o foo.o foo.c
hpa@tazenda:/tmp$ objdump -dr foo.o

foo.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <where_is_foobar>:
    0:   48 c7 c0 00 00 00 00    mov    $0x0,%rax
                         3: R_X86_64_32S foobar
    7:   c3                      ret


