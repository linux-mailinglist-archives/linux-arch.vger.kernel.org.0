Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C9C7A03BF
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbjINM1J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjINM1J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 08:27:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF31FC9;
        Thu, 14 Sep 2023 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1694694421;
        bh=IKd/xoLaYMNT3G43ojUHtX33LcBflkrUDAX5TgQ89VQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rYiR5HRfpS/tMJ5vZ04WGHK5tqlEmN3zl7YBnuBIj4iDXvSjRcMk3Bm1xQR4G2xqA
         ch/6vWdPHmOC2BUMMk4XX30GKkFETwPb6UKi6HR3vSS9M+ZGF48pqFYfp4X0b6Xnoc
         3IT8Xs1CRfVJWHkXJOg3XffMJXWhIzBrBfe0rLT/1FOwmVJNKXhzU+07wARKckah+G
         1nYEufulJtii1DdLYzWI+dlftci66s6CJLfGerDALqoTxKf5zQo5DIOqkNkz913pHl
         hiwkYuo8iIaiLSkIq8iYXaa9BldBulkzz3WoyK+kyoqd71CY/sNwj3K8X+Pby7L5LJ
         Ni+zJOD6zygLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rmc544Ldlz4wxN;
        Thu, 14 Sep 2023 22:26:48 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Cc:     "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "dalias@libc.org" <dalias@libc.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "deller@gmx.de" <deller@gmx.de>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "rmclure@linux.ibm.com" <rmclure@linux.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "slyich@gmail.com" <slyich@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "irogers@google.com" <irogers@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
In-Reply-To: <8b7106881fa227a64b4e951c6b9240a7126ac4a2.camel@intel.com>
References: <20230911180210.1060504-1-sohil.mehta@intel.com>
 <20230911180210.1060504-3-sohil.mehta@intel.com>
 <8b7106881fa227a64b4e951c6b9240a7126ac4a2.camel@intel.com>
Date:   Thu, 14 Sep 2023 22:26:47 +1000
Message-ID: <871qf17xfc.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:
> On Mon, 2023-09-11 at 18:02 +0000, Sohil Mehta wrote:
>> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl
>> b/arch/powerpc/kernel/syscalls/syscall.tbl
>> index 20e50586e8a2..2767b8a42636 100644
>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>> @@ -539,3 +539,4 @@
>> =C2=A0450=C2=A0=C2=A0=C2=A0=C2=A0nospu=C2=A0=C2=A0=C2=A0set_mempolicy_ho=
me_node=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sys_set_mempol=
icy_hom
>> e_node
>> =C2=A0451=C2=A0=C2=A0=C2=A0=C2=A0common=C2=A0=C2=A0cachestat=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sys_cachestat
>> =C2=A0452=C2=A0=C2=A0=C2=A0=C2=A0common=C2=A0=C2=A0fchmodat2=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sys_fchmodat2
>> +453=C2=A0=C2=A0=C2=A0=C2=A0common=C2=A0=C2=A0map_shadow_stack=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0sys_map_shadow_stack
>
> I noticed in powerpc, the not implemented syscalls are manually mapped
> to sys_ni_syscall. It also has some special extra sys_ni_syscall()
> implementation bits to handle both ARCH_HAS_SYSCALL_WRAPPER and
> !ARCH_HAS_SYSCALL_WRAPPER. So wondering if it might need special
> treatment. Did you see those parts?

I don't think it needs any special treatment. It's processed by the same
script as other arches (scripts/syscalltbl.sh). So if there's no compat
or native entry it will default to sys_ni_syscall.

I think it's just habit/historical that we always spell out sys_ni_syscall.

cheers
