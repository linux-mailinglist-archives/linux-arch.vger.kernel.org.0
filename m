Return-Path: <linux-arch+bounces-6672-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D61960DA7
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 16:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C006284E74
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFBC1C4ED8;
	Tue, 27 Aug 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mCRNv9IW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576B19DF5F;
	Tue, 27 Aug 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769171; cv=none; b=egiD7d7NtyHPprAizoadfTct5f3+Nb6NCWi59QfWG4097tqZUC1MwW5sYhhJ6b4fP5j9lv1toD9veVOLQ6+sOqYOON/ZR8pUSo1TTuRPPYqsVyQwhBHWdIJw/G+ULyYo14lsLd0nZ7p604uv0g3PCq0aBXGyznggs+1uLwVe2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769171; c=relaxed/simple;
	bh=+i/nSB4MQD4pa2Vx+WL6vcT1TBaM6Vw+9VfW3njmnb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyTWyDuRM33rIJmQ+z2rKtp3hzPGxsmGlIEJ/KBpamJdhTd7tOTfjMvl9cdYXoHS6qt6dhFDQOKQocTmypL32I4de10SMLoD0xKVwzTVmF8325+ryMdPX36dIrzMWKu9BrWKy5UPpkLvKqdq7BMqYYjx5X9QY1qC9x6a9dwAZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mCRNv9IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46E4C4DDE7;
	Tue, 27 Aug 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mCRNv9IW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724769169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6EiTP7YUiMCTixUtkSu12qMU0S08UZOww6+NntFPv4=;
	b=mCRNv9IWmJrq/8skbYXs9KstYV3cnPCSjmBJDW87gYzLRZLtMZSVBc1IrYQb4wxK29z0sB
	lI9XyVDIKDmWb4wV8HlsgwsHTQbu8shF0vcl4bMiy0SFwc4PufW03fExsQ1jEVEVZ/g9TB
	BER7NhKdPxSVW6QYGEZvnflpMu9iDqw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e1dc3313 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 14:32:49 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db50abf929so507392b6e.2;
        Tue, 27 Aug 2024 07:32:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULOq3cTDdOIEgFfkV/OmHhZgYtezl+tC/2CJqtooRfkJVBnm9PaTOq3nbj3WKJ+19O0SwAQrMW7XZi@vger.kernel.org, AJvYcCVj4r797xwQVvGxG0hOUBuN8wlRTEfX2lMxc+c9RWqXwaM/ZcnkRbDNFBhXVUyYd107YWnIyy0iDBE9VHTt@vger.kernel.org, AJvYcCXE4nel9cxqQBb1dHzsxE+TMis3H4EkPVvsi2IqyVMRYmYNYejiPaFBFdwc1NLHqS618of+8MRO5ddpSEvf@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/OQhpnkrPAankht1yRI6hmfeKGJJW81ZNDmLUm74RfaU1YPm
	hFWLhHpVoTN5Ak9dUfGXjCOdYGW1kA61rUtqiCotLtIUIiV+yNp/TkyLnjoD5cvXsenp3vgS4Tl
	KHa/yaULIcopWfX/cvG6rDbGhE3o=
X-Google-Smtp-Source: AGHT+IE3yX8Ebk3AyN00/aPIkDwy4SLqUEpG3vRr/HgzOmjGEDePwpoBjlaYidrerGNXt5y/Ahxl99wyDP5tLpHt4M0=
X-Received: by 2002:a05:6870:e311:b0:261:21e9:1f19 with SMTP id
 586e51a60fabf-273e66201b6mr15981110fac.35.1724769168318; Tue, 27 Aug 2024
 07:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <ZszlGPqfrULzi3KG@zx2c4.com> <fd3cd385-131a-43b2-8ce9-05547a4f2d1d@linaro.org>
 <Zs3V3FYwz57tyGgp@zx2c4.com> <907e86f6-c9e8-41b1-9538-b1bb13d481ae@linaro.org>
 <4d966dc6-655e-4700-bc59-e03693d874cb@csgroup.eu> <b0e44997-06e0-4b03-b94a-1c54da5516ac@linaro.org>
 <8631deef-c2f0-4499-8e30-8bc48001ef5a@csgroup.eu> <84975137-de73-4ac9-a691-d87d9c0a5b75@linaro.org>
 <Zs3ijKpXasyf29-h@zx2c4.com> <9666ada7-5f34-4085-8e4d-10eb197da3f5@linaro.org>
In-Reply-To: <9666ada7-5f34-4085-8e4d-10eb197da3f5@linaro.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 27 Aug 2024 16:32:35 +0200
X-Gmail-Original-Message-ID: <CAHmME9oogQTLjc=pxBcUd99cyoV_7n1_rNsQRfz4J_+FXNDPUw@mail.gmail.com>
Message-ID: <CAHmME9oogQTLjc=pxBcUd99cyoV_7n1_rNsQRfz4J_+FXNDPUw@mail.gmail.com>
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, "Theodore Ts'o" <tytso@mit.edu>, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:30=E2=80=AFPM Adhemerval Zanella Netto
<adhemerval.zanella@linaro.org> wrote:
>
>
>
> On 27/08/24 11:28, Jason A. Donenfeld wrote:
> > On Tue, Aug 27, 2024 at 11:14:27AM -0300, Adhemerval Zanella Netto wrot=
e:
> >>
> >>
> >> On 27/08/24 11:10, Christophe Leroy wrote:
> >>>
> >>>
> >>> Le 27/08/2024 =C3=A0 16:01, Adhemerval Zanella Netto a =C3=A9crit :
> >>>> [Vous ne recevez pas souvent de courriers de adhemerval.zanella@lina=
ro.org. D=C3=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/Le=
arnAboutSenderIdentification ]
> >>>>
> >>>> On 27/08/24 11:00, Christophe Leroy wrote:
> >>>>>
> >>>>>
> >>>>> Le 27/08/2024 =C3=A0 15:39, Adhemerval Zanella Netto a =C3=A9crit :
> >>>>>> [Vous ne recevez pas souvent de courriers de adhemerval.zanella@li=
naro.org. D=C3=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/=
LearnAboutSenderIdentification ]
> >>>>>>
> >>>>>> On 27/08/24 10:34, Jason A. Donenfeld wrote:
> >>>>>>> On Tue, Aug 27, 2024 at 10:17:18AM -0300, Adhemerval Zanella Nett=
o wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 26/08/24 17:27, Jason A. Donenfeld wrote:
> >>>>>>>>> Hi Adhemerval,
> >>>>>>>>>
> >>>>>>>>> Thanks for posting this! Exciting to have it here.
> >>>>>>>>>
> >>>>>>>>> Just some small nits for now:
> >>>>>>>>>
> >>>>>>>>> On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wr=
ote:
> >>>>>>>>>> +static __always_inline ssize_t getrandom_syscall(void *buffer=
, size_t len, unsigned int flags)
> >>>>>>>>>> +{
> >>>>>>>>>> +  register long int x8 asm ("x8") =3D __NR_getrandom;
> >>>>>>>>>> +  register long int x0 asm ("x0") =3D (long int) buffer;
> >>>>>>>>>> +  register long int x1 asm ("x1") =3D (long int) len;
> >>>>>>>>>> +  register long int x2 asm ("x2") =3D (long int) flags;
> >>>>>>>>>
> >>>>>>>>> Usually it's written just as `long` or `unsigned long`, and lik=
ewise
> >>>>>>>>> with the cast. Also, no space after the cast.
> >>>>>>>>
> >>>>>>>> Ack.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +#define __VDSO_RND_DATA_OFFSET  480
> >>>>>>>>>
> >>>>>>>>> This is the size of the data currently there?
> >>>>>>>>
> >>>>>>>> Yes, I used the same strategy x86 did.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>    #include <asm/page.h>
> >>>>>>>>>>    #include <asm/vdso.h>
> >>>>>>>>>>    #include <asm-generic/vmlinux.lds.h>
> >>>>>>>>>> +#include <vdso/datapage.h>
> >>>>>>>>>> +#include <asm/vdso/vsyscall.h>
> >>>>>>>>>
> >>>>>>>>> Possible to keep the asm/ together?
> >>>>>>>>
> >>>>>>>> Ack.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a =
given positive
> >>>>>>>>>> + * number of blocks of output with nonnce 0, taking an input =
key and 8-bytes
> >>>>>>>>>
> >>>>>>>>> nonnce -> nonce
> >>>>>>>>
> >>>>>>>> Ack.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> -ARCH ?=3D $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x=
86_64/x86/)
> >>>>>>>>>> +ARCH ?=3D $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x=
86_64/x86/ -e s/aarch64.*/arm64/)
> >>>>>>>>>>    SODIUM :=3D $(shell pkg-config --libs libsodium 2>/dev/null=
)
> >>>>>>>>>>
> >>>>>>>>>>    TEST_GEN_PROGS :=3D vdso_test_gettimeofday
> >>>>>>>>>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> >>>>>>>>>>    TEST_GEN_PROGS +=3D vdso_standalone_test_x86
> >>>>>>>>>>    endif
> >>>>>>>>>>    TEST_GEN_PROGS +=3D vdso_test_correctness
> >>>>>>>>>> -ifeq ($(uname_M),x86_64)
> >>>>>>>>>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
> >>>>>>>>>>    TEST_GEN_PROGS +=3D vdso_test_getrandom
> >>>>>>>>>>    ifneq ($(SODIUM),)
> >>>>>>>>>>    TEST_GEN_PROGS +=3D vdso_test_chacha
> >>>>>>>>>
> >>>>>>>>> You'll need to add the symlink to get the chacha selftest runni=
ng:
> >>>>>>>>>
> >>>>>>>>>     $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vd=
so
> >>>>>>>>>     $ git add tools/arch/arm64/vdso
> >>>>>>>>>
> >>>>>>>>> Also, can you confirm that the chacha selftest runs and works?
> >>>>>>>>
> >>>>>>>> Yes, last time I has to built it manually since the Makefile mac=
hinery seem
> >>>>>>>> to be broken even on x86_64.  In a Ubuntu vm I have:
> >>>>>>>>
> >>>>>>>> tools/testing/selftests/vDSO$ make
> >>>>>>>>     CC       vdso_test_gettimeofday
> >>>>>>>>     CC       vdso_test_getcpu
> >>>>>>>>     CC       vdso_test_abi
> >>>>>>>>     CC       vdso_test_clock_getres
> >>>>>>>>     CC       vdso_standalone_test_x86
> >>>>>>>>     CC       vdso_test_correctness
> >>>>>>>>     CC       vdso_test_getrandom
> >>>>>>>>     CC       vdso_test_chacha
> >>>>>>>> In file included from /home/azanella/Projects/linux/linux-git/in=
clude/linux/limits.h:7,
> >>>>>>>>                    from /usr/include/x86_64-linux-gnu/bits/local=
_lim.h:38,
> >>>>>>>>                    from /usr/include/x86_64-linux-gnu/bits/posix=
1_lim.h:161,
> >>>>>>>>                    from /usr/include/limits.h:195,
> >>>>>>>>                    from /usr/lib/gcc/x86_64-linux-gnu/13/include=
/limits.h:205,
> >>>>>>>>                    from /usr/lib/gcc/x86_64-linux-gnu/13/include=
/syslimits.h:7,
> >>>>>>>>                    from /usr/lib/gcc/x86_64-linux-gnu/13/include=
/limits.h:34,
> >>>>>>>>                    from /usr/include/sodium/export.h:7,
> >>>>>>>>                    from /usr/include/sodium/crypto_stream_chacha=
20.h:14,
> >>>>>>>>                    from vdso_test_chacha.c:6:
> >>>>>>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:99:6: error: miss=
ing binary operator before token "("
> >>>>>>>>      99 | # if INT_MAX =3D=3D 32767
> >>>>>>>>         |      ^~~~~~~
> >>>>>>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:102:7: error: mis=
sing binary operator before token "("
> >>>>>>>>     102 | #  if INT_MAX =3D=3D 2147483647
> >>>>>>>>         |       ^~~~~~~
> >>>>>>>> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:126:6: error: mis=
sing binary operator before token "("
> >>>>>>>>     126 | # if LONG_MAX =3D=3D 2147483647
> >>>>>>>>         |      ^~~~~~~~
> >>>>>>>> make: *** [../lib.mk:222: /home/azanella/Projects/linux/linux-gi=
t/tools/testing/selftests/vDSO/vdso_test_chacha] Error 1
> >>>>>>>
> >>>>>>> You get that even with the latest random.git? I thought Christoph=
e's
> >>>>>>> patch fixed that, but maybe not and I should just remove the depe=
ndency
> >>>>>>> on the sodium header instead.
> >>>>>>
> >>>>>> On x86_64 I tested with Linux master.  With random.git it is a dif=
ferent issue:
> >>>>>>
> >>>>>> linux-git/tools/testing/selftests/vDSO$ make
> >>>>>>     CC       vdso_test_gettimeofday
> >>>>>>     CC       vdso_test_getcpu
> >>>>>>     CC       vdso_test_abi
> >>>>>>     CC       vdso_test_clock_getres
> >>>>>>     CC       vdso_standalone_test_x86
> >>>>>>     CC       vdso_test_correctness
> >>>>>>     CC       vdso_test_getrandom
> >>>>>>     CC       vdso_test_chacha
> >>>>>> /usr/bin/ld: /tmp/ccKpjnSM.o: in function `main':
> >>>>>> vdso_test_chacha.c:(.text+0x276): undefined reference to `crypto_s=
tream_chacha20'
> >>>>>> collect2: error: ld returned 1 exit status
> >>>>>>
> >>>>>> If I move -lsodium to the end of the compiler command it works.
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> Try a "make clean" maybe ?
> >>>>>
> >>>>> I have Fedora 38 and no build problem with latest random tree:
> >>>>>
> >>>>> $ make V=3D1
> >>>>> gcc -std=3Dgnu99 -D_GNU_SOURCE=3D    vdso_test_gettimeofday.c parse=
_vdso.c -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_te=
st_gettimeofday
> >>>>> gcc -std=3Dgnu99 -D_GNU_SOURCE=3D    vdso_test_getcpu.c parse_vdso.=
c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_ge=
tcpu
> >>>>> gcc -std=3Dgnu99 -D_GNU_SOURCE=3D    vdso_test_abi.c parse_vdso.c  =
-o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_abi
> >>>>> gcc -std=3Dgnu99 -D_GNU_SOURCE=3D    vdso_test_clock_getres.c  -o /=
home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_clock_get=
res
> >>>>> gcc -std=3Dgnu99 -D_GNU_SOURCE=3D -nostdlib -fno-asynchronous-unwin=
d-tables -fno-stack-protector    vdso_standalone_test_x86.c parse_vdso.c  -=
o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_standalone_=
test_x86
> >>>>> gcc -std=3Dgnu99 -D_GNU_SOURCE=3D  -ldl  vdso_test_correctness.c  -=
o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_correc=
tness
> >>>>> gcc -std=3Dgnu99 -D_GNU_SOURCE=3D -isystem /home/chleroy/linux-powe=
rpc/tools/testing/selftests/../../../tools/include -isystem /home/chleroy/l=
inux-powerpc/tools/testing/selftests/../../../include/uapi    vdso_test_get=
random.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftes=
ts/vDSO/vdso_test_getrandom
> >>>>> gcc -std=3Dgnu99 -D_GNU_SOURCE=3D -idirafter /home/chleroy/linux-po=
werpc/tools/testing/selftests/../../../tools/include -idirafter /home/chler=
oy/linux-powerpc/tools/testing/selftests/../../../arch/x86/include -idiraft=
er /home/chleroy/linux-powerpc/tools/testing/selftests/../../../include -D_=
_ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=3D0 -Wa,--noexecstack =
-lsodium     vdso_test_chacha.c /home/chleroy/linux-powerpc/tools/testing/s=
elftests/../../../tools/arch/x86/vdso/vgetrandom-chacha.S  -o /home/chleroy=
/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_chacha
> >>>>> $
> >>>>
> >>>> It is a clean tree (git clean -dfx), and I take there is no need to =
build a kernel
> >>>> prior hand.
> >>>
> >>> I meeant 'make clean'
> >>>
> >>>
> >>> Right, I have not built any x86 kernel at the moment.
> >>>
> >>> Just :
> >>> $ pwd
> >>> /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO
> >>>
> >>> $ make clean
> >>>
> >>> then
> >>>
> >>> $ make V=3D1
> >>
> >> The issue is Ubuntu linker is configure to use --as-needed by default,=
 this
> >> patch fixes the issue:
> >>
> >> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/sel=
ftests/vDSO/Makefile
> >> index 10ffdda3f2fa..151baf650e4c 100644
> >> --- a/tools/testing/selftests/vDSO/Makefile
> >> +++ b/tools/testing/selftests/vDSO/Makefile
> >> @@ -45,4 +45,4 @@ $(OUTPUT)/vdso_test_chacha: CFLAGS +=3D -idirafter $=
(top_srcdir)/tools/include \
> >>                                        -idirafter $(top_srcdir)/arch/$=
(ARCH)/include \
> >>                                        -idirafter $(top_srcdir)/includ=
e \
> >>                                        -D__ASSEMBLY__ -DBULID_VDSO -DC=
ONFIG_FUNCTION_ALIGNMENT=3D0 \
> >> -                                      -Wa,--noexecstack $(SODIUM)
> >> +                                      -Wa,--noexecstack -Wl,-no-as-ne=
eded $(SODIUM)
> >
> > Oh, it's an as-needed thing. In that case, does this fix it for you?
> >
> > diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/self=
tests/vDSO/Makefile
> > index 10ffdda3f2fa..834aa862ba2c 100644
> > --- a/tools/testing/selftests/vDSO/Makefile
> > +++ b/tools/testing/selftests/vDSO/Makefile
> > @@ -1,7 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  uname_M :=3D $(shell uname -m 2>/dev/null || echo not)
> >  ARCH ?=3D $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86=
/)
> > -SODIUM :=3D $(shell pkg-config --libs libsodium 2>/dev/null)
> > +SODIUM_LIBS :=3D $(shell pkg-config --libs libsodium 2>/dev/null)
> > +SODIUM_CFLAGS :=3D $(shell pkg-config --cflags libsodium 2>/dev/null)
> >
> >  TEST_GEN_PROGS :=3D vdso_test_gettimeofday
> >  TEST_GEN_PROGS +=3D vdso_test_getcpu
> > @@ -13,7 +14,7 @@ endif
> >  TEST_GEN_PROGS +=3D vdso_test_correctness
> >  ifeq ($(uname_M),x86_64)
> >  TEST_GEN_PROGS +=3D vdso_test_getrandom
> > -ifneq ($(SODIUM),)
> > +ifneq ($(SODIUM_LIBS),)
> >  TEST_GEN_PROGS +=3D vdso_test_chacha
> >  endif
> >  endif
> > @@ -41,8 +42,9 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS +=3D -isystem $=
(top_srcdir)/tools/include \
> >                                           -isystem $(top_srcdir)/includ=
e/uapi
> >
> >  $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vget=
random-chacha.S
> > +$(OUTPUT)/vdso_test_chacha: LDLIBS +=3D $(SODIUM_LIBS)
> >  $(OUTPUT)/vdso_test_chacha: CFLAGS +=3D -idirafter $(top_srcdir)/tools=
/include \
> >                                        -idirafter $(top_srcdir)/arch/$(=
ARCH)/include \
> >                                        -idirafter $(top_srcdir)/include=
 \
> >                                        -D__ASSEMBLY__ -DBULID_VDSO -DCO=
NFIG_FUNCTION_ALIGNMENT=3D0 \
> > -                                      -Wa,--noexecstack $(SODIUM)
> > +                                      -Wa,--noexecstack $(SODIUM_CFLAG=
S)
> >
>
> Nops, 'pkg-config --cflags libsodium' is empty. The -Wl,-no-as-needed is =
simpler
> I think.

The --cflags thing is for a different issue Ruoyao found. My intended
fix here was the LDLIBS +=3D $(SODIUM_LIBS) part, which moves the
`-lsodium` closer to the end of the command line. But it still doesn't
work? Surprising...

