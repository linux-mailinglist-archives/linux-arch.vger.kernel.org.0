Return-Path: <linux-arch+bounces-6670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B52E960D91
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 16:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DAC1F2478F
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138701C4ED4;
	Tue, 27 Aug 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c4RMQczX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB471C4EC2;
	Tue, 27 Aug 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768919; cv=none; b=s2kUqM1C3jyluiIbBlPVqlB6SNY7kazB/WA7RleM7Durr5zuWK7yP9/RKVHFwSuHqSUas+bZmrcbUEEPTimgdTWx2JHq/Y1I3f4zJMESFH2ytWMWjCd0JkABiSy7RQjyNW3iNMAp9ORZicXX6qHKraah7pdDdlVpNwOSAAE2hy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768919; c=relaxed/simple;
	bh=eFSvH7Ee4yizvUmyLi38VxT9hRPbBEoASBk6FEroU+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNowb7cMC1wNwPdCdVS2RQq6vI2GzJmY628SgPwn+lwEYFHb8XoCRg2b/QSiyGNZDfK9SnSn1Czc1E4oxWlFwAHI0Bew+khYS7mwK9dcuPIfW/XJZjmsKNPc353ZIhujJXk4tBQ3WzbbgTma1NbnFNN9KUVN8gQKhM6pC98Z3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=c4RMQczX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D35C61046;
	Tue, 27 Aug 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c4RMQczX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724768915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T37AODMHUWHJO1p2vKozAIaGDW4/lp+xRhQk30aG2XA=;
	b=c4RMQczXFZfnDfxQUgcvGK3G3ciah6tvB6h3CUlwEpyr8OuwiGY3VgHtqfFSJlY3+X+b+O
	CWIbzneEZIe9jXr2sRXs8jqSqZvmF6h58KyKJKJDKjs4QpEXvXsXHTA6yEH68RM7cHsFbi
	SrK/3XshN4CZMWgXMLYTp/S3FhRewts=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2b0d42b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 14:28:35 +0000 (UTC)
Date: Tue, 27 Aug 2024 16:28:28 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <Zs3ijKpXasyf29-h@zx2c4.com>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <ZszlGPqfrULzi3KG@zx2c4.com>
 <fd3cd385-131a-43b2-8ce9-05547a4f2d1d@linaro.org>
 <Zs3V3FYwz57tyGgp@zx2c4.com>
 <907e86f6-c9e8-41b1-9538-b1bb13d481ae@linaro.org>
 <4d966dc6-655e-4700-bc59-e03693d874cb@csgroup.eu>
 <b0e44997-06e0-4b03-b94a-1c54da5516ac@linaro.org>
 <8631deef-c2f0-4499-8e30-8bc48001ef5a@csgroup.eu>
 <84975137-de73-4ac9-a691-d87d9c0a5b75@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84975137-de73-4ac9-a691-d87d9c0a5b75@linaro.org>

On Tue, Aug 27, 2024 at 11:14:27AM -0300, Adhemerval Zanella Netto wrote:
> 
> 
> On 27/08/24 11:10, Christophe Leroy wrote:
> > 
> > 
> > Le 27/08/2024 à 16:01, Adhemerval Zanella Netto a écrit :
> >> [Vous ne recevez pas souvent de courriers de adhemerval.zanella@linaro.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> >>
> >> On 27/08/24 11:00, Christophe Leroy wrote:
> >>>
> >>>
> >>> Le 27/08/2024 à 15:39, Adhemerval Zanella Netto a écrit :
> >>>> [Vous ne recevez pas souvent de courriers de adhemerval.zanella@linaro.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> >>>>
> >>>> On 27/08/24 10:34, Jason A. Donenfeld wrote:
> >>>>> On Tue, Aug 27, 2024 at 10:17:18AM -0300, Adhemerval Zanella Netto wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 26/08/24 17:27, Jason A. Donenfeld wrote:
> >>>>>>> Hi Adhemerval,
> >>>>>>>
> >>>>>>> Thanks for posting this! Exciting to have it here.
> >>>>>>>
> >>>>>>> Just some small nits for now:
> >>>>>>>
> >>>>>>> On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
> >>>>>>>> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
> >>>>>>>> +{
> >>>>>>>> +  register long int x8 asm ("x8") = __NR_getrandom;
> >>>>>>>> +  register long int x0 asm ("x0") = (long int) buffer;
> >>>>>>>> +  register long int x1 asm ("x1") = (long int) len;
> >>>>>>>> +  register long int x2 asm ("x2") = (long int) flags;
> >>>>>>>
> >>>>>>> Usually it's written just as `long` or `unsigned long`, and likewise
> >>>>>>> with the cast. Also, no space after the cast.
> >>>>>>
> >>>>>> Ack.
> >>>>>>
> >>>>>>>
> >>>>>>>> +#define __VDSO_RND_DATA_OFFSET  480
> >>>>>>>
> >>>>>>> This is the size of the data currently there?
> >>>>>>
> >>>>>> Yes, I used the same strategy x86 did.
> >>>>>>
> >>>>>>>
> >>>>>>>>    #include <asm/page.h>
> >>>>>>>>    #include <asm/vdso.h>
> >>>>>>>>    #include <asm-generic/vmlinux.lds.h>
> >>>>>>>> +#include <vdso/datapage.h>
> >>>>>>>> +#include <asm/vdso/vsyscall.h>
> >>>>>>>
> >>>>>>> Possible to keep the asm/ together?
> >>>>>>
> >>>>>> Ack.
> >>>>>>
> >>>>>>>
> >>>>>>>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
> >>>>>>>> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
> >>>>>>>
> >>>>>>> nonnce -> nonce
> >>>>>>
> >>>>>> Ack.
> >>>>>>
> >>>>>>>
> >>>>>>>> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> >>>>>>>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
> >>>>>>>>    SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
> >>>>>>>>
> >>>>>>>>    TEST_GEN_PROGS := vdso_test_gettimeofday
> >>>>>>>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> >>>>>>>>    TEST_GEN_PROGS += vdso_standalone_test_x86
> >>>>>>>>    endif
> >>>>>>>>    TEST_GEN_PROGS += vdso_test_correctness
> >>>>>>>> -ifeq ($(uname_M),x86_64)
> >>>>>>>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
> >>>>>>>>    TEST_GEN_PROGS += vdso_test_getrandom
> >>>>>>>>    ifneq ($(SODIUM),)
> >>>>>>>>    TEST_GEN_PROGS += vdso_test_chacha
> >>>>>>>
> >>>>>>> You'll need to add the symlink to get the chacha selftest running:
> >>>>>>>
> >>>>>>>     $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vdso
> >>>>>>>     $ git add tools/arch/arm64/vdso
> >>>>>>>
> >>>>>>> Also, can you confirm that the chacha selftest runs and works?
> >>>>>>
> >>>>>> Yes, last time I has to built it manually since the Makefile machinery seem
> >>>>>> to be broken even on x86_64.  In a Ubuntu vm I have:
> >>>>>>
> >>>>>> tools/testing/selftests/vDSO$ make
> >>>>>>     CC       vdso_test_gettimeofday
> >>>>>>     CC       vdso_test_getcpu
> >>>>>>     CC       vdso_test_abi
> >>>>>>     CC       vdso_test_clock_getres
> >>>>>>     CC       vdso_standalone_test_x86
> >>>>>>     CC       vdso_test_correctness
> >>>>>>     CC       vdso_test_getrandom
> >>>>>>     CC       vdso_test_chacha
> >>>>>> In file included from /home/azanella/Projects/linux/linux-git/include/linux/limits.h:7,
> >>>>>>                    from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
> >>>>>>                    from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
> >>>>>>                    from /usr/include/limits.h:195,
> >>>>>>                    from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:205,
> >>>>>>                    from /usr/lib/gcc/x86_64-linux-gnu/13/include/syslimits.h:7,
> >>>>>>                    from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:34,
> >>>>>>                    from /usr/include/sodium/export.h:7,
> >>>>>>                    from /usr/include/sodium/crypto_stream_chacha20.h:14,
> >>>>>>                    from vdso_test_chacha.c:6:
> >>>>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
> >>>>>>      99 | # if INT_MAX == 32767
> >>>>>>         |      ^~~~~~~
> >>>>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
> >>>>>>     102 | #  if INT_MAX == 2147483647
> >>>>>>         |       ^~~~~~~
> >>>>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
> >>>>>>     126 | # if LONG_MAX == 2147483647
> >>>>>>         |      ^~~~~~~~
> >>>>>> make: *** [../lib.mk:222: /home/azanella/Projects/linux/linux-git/tools/testing/selftests/vDSO/vdso_test_chacha] Error 1
> >>>>>
> >>>>> You get that even with the latest random.git? I thought Christophe's
> >>>>> patch fixed that, but maybe not and I should just remove the dependency
> >>>>> on the sodium header instead.
> >>>>
> >>>> On x86_64 I tested with Linux master.  With random.git it is a different issue:
> >>>>
> >>>> linux-git/tools/testing/selftests/vDSO$ make
> >>>>     CC       vdso_test_gettimeofday
> >>>>     CC       vdso_test_getcpu
> >>>>     CC       vdso_test_abi
> >>>>     CC       vdso_test_clock_getres
> >>>>     CC       vdso_standalone_test_x86
> >>>>     CC       vdso_test_correctness
> >>>>     CC       vdso_test_getrandom
> >>>>     CC       vdso_test_chacha
> >>>> /usr/bin/ld: /tmp/ccKpjnSM.o: in function `main':
> >>>> vdso_test_chacha.c:(.text+0x276): undefined reference to `crypto_stream_chacha20'
> >>>> collect2: error: ld returned 1 exit status
> >>>>
> >>>> If I move -lsodium to the end of the compiler command it works.
> >>>>
> >>>>
> >>>
> >>> Try a "make clean" maybe ?
> >>>
> >>> I have Fedora 38 and no build problem with latest random tree:
> >>>
> >>> $ make V=1
> >>> gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_gettimeofday.c parse_vdso.c -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday
> >>> gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_getcpu.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getcpu
> >>> gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_abi.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_abi
> >>> gcc -std=gnu99 -D_GNU_SOURCE=    vdso_test_clock_getres.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_clock_getres
> >>> gcc -std=gnu99 -D_GNU_SOURCE= -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector    vdso_standalone_test_x86.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_standalone_test_x86
> >>> gcc -std=gnu99 -D_GNU_SOURCE=  -ldl  vdso_test_correctness.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_correctness
> >>> gcc -std=gnu99 -D_GNU_SOURCE= -isystem /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include -isystem /home/chleroy/linux-powerpc/tools/testing/selftests/../../../include/uapi    vdso_test_getrandom.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getrandom
> >>> gcc -std=gnu99 -D_GNU_SOURCE= -idirafter /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include -idirafter /home/chleroy/linux-powerpc/tools/testing/selftests/../../../arch/x86/include -idirafter /home/chleroy/linux-powerpc/tools/testing/selftests/../../../include -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 -Wa,--noexecstack -lsodium     vdso_test_chacha.c /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/arch/x86/vdso/vgetrandom-chacha.S  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_chacha
> >>> $
> >>
> >> It is a clean tree (git clean -dfx), and I take there is no need to build a kernel
> >> prior hand.
> > 
> > I meeant 'make clean'
> > 
> > 
> > Right, I have not built any x86 kernel at the moment.
> > 
> > Just :
> > $ pwd
> > /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO
> > 
> > $ make clean
> > 
> > then
> > 
> > $ make V=1
> 
> The issue is Ubuntu linker is configure to use --as-needed by default, this
> patch fixes the issue:
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index 10ffdda3f2fa..151baf650e4c 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -45,4 +45,4 @@ $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
>                                        -idirafter $(top_srcdir)/arch/$(ARCH)/include \
>                                        -idirafter $(top_srcdir)/include \
>                                        -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 \
> -                                      -Wa,--noexecstack $(SODIUM)
> +                                      -Wa,--noexecstack -Wl,-no-as-needed $(SODIUM)

Oh, it's an as-needed thing. In that case, does this fix it for you?

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 10ffdda3f2fa..834aa862ba2c 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
-SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
+SODIUM_LIBS := $(shell pkg-config --libs libsodium 2>/dev/null)
+SODIUM_CFLAGS := $(shell pkg-config --cflags libsodium 2>/dev/null)

 TEST_GEN_PROGS := vdso_test_gettimeofday
 TEST_GEN_PROGS += vdso_test_getcpu
@@ -13,7 +14,7 @@ endif
 TEST_GEN_PROGS += vdso_test_correctness
 ifeq ($(uname_M),x86_64)
 TEST_GEN_PROGS += vdso_test_getrandom
-ifneq ($(SODIUM),)
+ifneq ($(SODIUM_LIBS),)
 TEST_GEN_PROGS += vdso_test_chacha
 endif
 endif
@@ -41,8 +42,9 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          -isystem $(top_srcdir)/include/uapi

 $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vgetrandom-chacha.S
+$(OUTPUT)/vdso_test_chacha: LDLIBS += $(SODIUM_LIBS)
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -idirafter $(top_srcdir)/arch/$(ARCH)/include \
                                       -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 \
-                                      -Wa,--noexecstack $(SODIUM)
+                                      -Wa,--noexecstack $(SODIUM_CFLAGS)


