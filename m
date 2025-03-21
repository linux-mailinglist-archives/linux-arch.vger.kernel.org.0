Return-Path: <linux-arch+bounces-11037-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDACA6C4CB
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 22:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5AC17F6F7
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 21:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D16230BF7;
	Fri, 21 Mar 2025 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9PVNs9Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6F22D781
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591160; cv=none; b=NQeHfREennADaxlTpYcg5BguLB8iN7qDqhgdDNhE07oDD26AB0WqRtqge7jXPL5iuyyhL27HT1jK9W2livpdhDI2BWFa76GdVqLp/Jdtk81nv1bi6NFvbD8vISC5hJd1r0qxG4uXuWst5OiJYLL1EIu6g9Nu0k6tTx/ZoL8mOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591160; c=relaxed/simple;
	bh=WsW2DMXDS3L3rkB0DvHWq2Ivir2+trMsAx21I9eHwoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQcq4jUrL3H2Tw8ZSjMZMyZNv3FkVQRa34fmSD3DaWMl7rDWLlmqIw911KVbuxg26JF4NoAcCvj+EOYlSklYNj+Op/vN5AVvAMbT280xEOOxFcgB6vi8S1Z8svVzJuKtrtfQsaVIV6nYM7pqcslKhvu3cOJ+oiJMi8c7AMYNEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9PVNs9Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742591157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRnJoqDrjjM/0a1a+E2erJF3D59Mlmw/EEkVC6fPK4Y=;
	b=N9PVNs9QJWXTJA39SDqCtfmbyHuq5h0gMok/gFUHwMV6ElZplmrEn3F7QDh/tFfHPk+/Ip
	6F2NrFNYya7DB83j073GSrCbA+El5h+7f2VwICNiOB8dgV1mYd/1smIEl81wOnWiPJEVkr
	mCgRntZUEXlllrnyhAynKdxk/ugBm5U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-nxbfbmcINzKg4N25k8Ry8w-1; Fri, 21 Mar 2025 17:05:55 -0400
X-MC-Unique: nxbfbmcINzKg4N25k8Ry8w-1
X-Mimecast-MFC-AGG-ID: nxbfbmcINzKg4N25k8Ry8w_1742591155
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2242f3fd213so35286445ad.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 14:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591154; x=1743195954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRnJoqDrjjM/0a1a+E2erJF3D59Mlmw/EEkVC6fPK4Y=;
        b=iEVVsOMxEEnIcpWNaCuGgAKXLB9TDDm7HveTc7YFn6+3Mhe3hX3bSJkIes+nLLzkui
         STFkHCOG4kJpDOzjveqdOFOwp+VLk0hdPv78Asws+L0qCZf2B6CGGvq1bzgnGwi5wGS6
         mAIoipD6R3C9OMVo/vw2v1mszBjQze8Qf7gdkfxtnpjM3LVIggANr3VS6YlubMrNGJWk
         2eNuI38RHWk6/DcwBRVTFAmaWYHOtxXmdyXfvFwHnI6X7OQkaUhee8eQhkrqTC+xhJoV
         faf/jZtlh5aHG1Jj5N77Zm5C3R6CVr5iH761zA3j6WopBgvDURiEsOCWBYycJ7JqsnE3
         byYA==
X-Forwarded-Encrypted: i=1; AJvYcCWSGdbVAZUw2+I/Chta4rTJE020imfC4dgK3Ta1FRvAP+7+jwLrpoBFdAiiBVPf/2BbPhgEX/U54ExZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOvQnEeG04DYppp6NSQ+SpspCabGO2daOQUAcX7mQPjYIjHvb
	apQRc8sVuvNqZ7SF/Wzoajrqkqm3Ebe6Tr5nD+KPdgVu2fTmt+Jy+8P0kjmAaz6R/pY9RaGkAL3
	ndbEgoX3MpCJ2xrtf9NRWCXBL4qUBohTYpEl0OXSIODH/qwuWr5CpbFW6AFNmLnZmdju7MW8rMM
	HW7DNYEIA09TAiWU1db/O25pLcIV242Wkh43V8Ge5OewphMYE=
X-Gm-Gg: ASbGnctlmYIZGBqMuGk9NMOZgAhm+jrQe4KheylajlYCZ8K/wURb7ly0hXMK1QJuiwx
	aHbR9uVh8gl2PqV4ITkeyXzfrr/xTdtYfGMNOfkdWfBYuUEBafTTYoUbJYMLFNApF6+mgPyo=
X-Received: by 2002:a17:902:ce08:b0:224:2175:b0cd with SMTP id d9443c01a7336-22780db3884mr78325305ad.26.1742591153936;
        Fri, 21 Mar 2025 14:05:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN00ZwsCSvrb1GxmsoNJZNu7MKJs1Ucfk1lD2MiRFFRVzqqr5ClONI/dVh1idt8Msn85KVY7jetnaUeKy09VA=
X-Received: by 2002:a17:902:ce08:b0:224:2175:b0cd with SMTP id
 d9443c01a7336-22780db3884mr78324575ad.26.1742591153425; Fri, 21 Mar 2025
 14:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313114329.284104-1-acarmina@redhat.com> <20250313114329.284104-11-acarmina@redhat.com>
 <b6bb68f0-7e93-4db2-9fe6-f615f06ddeb1@roeck-us.net>
In-Reply-To: <b6bb68f0-7e93-4db2-9fe6-f615f06ddeb1@roeck-us.net>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Fri, 21 Mar 2025 22:05:42 +0100
X-Gm-Features: AQ5f1JoQT0Axds-sBfJ5O3FpL2NPQAbk3ZSqHh9aN-1kzXKN_DmP6zsQowxJbF0
Message-ID: <CAGegRW4GinPmsav5=VBfjXBKy4cUEs5FWv-ixXODk7ajZ69vYg@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] s390: Add support for suppressing warning backtraces
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, 
	Arthur Grillo <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Jani Nikula <jani.nikula@intel.com>, 
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Guenter,
Sorry for being late to the party.

On Fri, Mar 21, 2025 at 6:06=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/13/25 04:43, Alessandro Carminati wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> >
> > Add name of functions triggering warning backtraces to the __bug_table
> > object section to enable support for suppressing WARNING backtraces.
> >
> > To limit image size impact, the pointer to the function name is only ad=
ded
> > to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
> > CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
> > parameter is replaced with a (dummy) NULL parameter to avoid an image s=
ize
> > increase due to unused __func__ entries (this is necessary because
> > __func__ is not a define but a virtual variable).
> >
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > ---
> >   arch/s390/include/asm/bug.h | 17 ++++++++++++++---
> >   1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
> > index c500d45fb465..44d4e9f24ae0 100644
> > --- a/arch/s390/include/asm/bug.h
> > +++ b/arch/s390/include/asm/bug.h
> > @@ -8,6 +8,15 @@
> >
> >   #ifdef CONFIG_DEBUG_BUGVERBOSE
> >
> > +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> > +# define HAVE_BUG_FUNCTION
> > +# define __BUG_FUNC_PTR      "       .long   %0-.\n"
> > +# define __BUG_FUNC  __func__
>
> gcc 7.5.0 on s390 barfs; it doesn't like the use of "__func__" with "%0-.=
"
>
> drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c: In function 'anx_dp_=
aux_transfer':
> ././include/linux/compiler_types.h:492:20: warning: asm operand 0 probabl=
y doesn't match constraints
>
> I was unable to find an alternate constraint that the compiler would acce=
pt.
>
> I don't know if the same problem is seen with older compilers on other ar=
chitectures,
> or if the problem is relevant in the first place.
>
> gcc 10.3.0 and later do not have this problem. I also tried s390 builds w=
ith gcc 9.4
> and 9.5 but they both crash for unrelated reasons.
>
> If this is a concern, the best idea I have is to make KUNIT_SUPPRESS_BACK=
TRACE
> depend on, say,
>         depends on CC_IS_CLANG || (CC_IS_GCC && GCC_VERSION >=3D 100300)
>
> A more complex solution might be to define an architecture flag such
> as HAVE_SUPPRESS_BACKTRACE, make that conditional on the gcc version
> for s390 only, and make KUNIT_SUPPRESS_BACKTRACE depend on it.

I've spent some time trying to better define the problem.
Although it may seem trivial, the old compiler simply doesn't work=E2=80=94=
I
believe the issue is a bit more complex.

So, let me share some code and then comment on it.
$ cat bug-s390.c
#include "bug_entry.h"
#define asm_inline asm __inline
# define __BUG_FUNC_PTR " .long %0-.\n"
# define __BUG_FUNC __func__
#define __EMIT_BUG(x) do { \
asm_inline volatile( \
"0: mc 0,0\n" \
".section .rodata.str,\"aMS\",@progbits,1\n" \
"1: .asciz \""__FILE__"\"\n" \
".previous\n" \
".section __bug_table,\"aw\"\n" \
"2: .long 0b-.\n" \
" .long 1b-.\n" \
__BUG_FUNC_PTR \
" .short %1,%2\n" \
" .org 2b+%3\n" \
".previous\n" \
: : "i" (__BUG_FUNC), \
    "i" (__LINE__), \
    "i" (x), \
    "i" (sizeof(struct bug_entry))); \
} while (0)

#define BUG() do { \
__EMIT_BUG(0); \
} while (0)

void f1(){
BUG();
}
void f2(){
BUG();
}
int main() {
BUG();
        f1();
        f2();
return 0;
}
$ # This is a stripped version of the s390x code for bug
$ ~/x-tools/s390x-ibm-linux-gnu_14/bin/s390x-ibm-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu_14/bin/s390x-ibm=
-linux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu_14/bin/.=
./libexec/gcc/s390x-ibm-linux-gnu/14.2.0/lto-wrapper
Target: s390x-ibm-linux-gnu
Configured with:
/home/alessandro/src/s390x-toolchain/.build/s390x-ibm-linux-gnu/src/gcc/con=
figure
--build=3Dx86_64-build_pc-linux-gnu --host=3Dx86_64-build_pc-linux-gnu
--target=3Ds390x-ibm-linux-gnu
--prefix=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu
--exec_prefix=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu
--with-sysroot=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu/s390x-ibm-lin=
ux-gnu/sysroot
--enable-languages=3Dc,c++ --with-pkgversion=3D'crosstool-NG
1.27.0.18_7458341' --enable-__cxa_atexit --disable-libmudflap
--disable-libgomp --disable-libssp --disable-libquadmath
--disable-libquadmath-support --disable-libsanitizer --disable-libmpx
--with-gmp=3D/home/alessandro/src/s390x-toolchain/.build/s390x-ibm-linux-gn=
u/buildtools
--with-mpfr=3D/home/alessandro/src/s390x-toolchain/.build/s390x-ibm-linux-g=
nu/buildtools
--with-mpc=3D/home/alessandro/src/s390x-toolchain/.build/s390x-ibm-linux-gn=
u/buildtools
--with-isl=3D/home/alessandro/src/s390x-toolchain/.build/s390x-ibm-linux-gn=
u/buildtools
--enable-lto --enable-threads=3Dposix --enable-target-optspace
--disable-plugin --disable-nls --disable-multilib
--with-local-prefix=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu/s390x-ib=
m-linux-gnu/sysroot
--enable-long-long
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 14.2.0 (crosstool-NG 1.27.0.18_7458341)
$ ~/x-tools/s390x-ibm-linux-gnu_14/bin/s390x-ibm-linux-gnu-gcc -S -m64
bug-s390.c
$ ~/x-tools/s390x-ibm-linux-gnu_14/bin/s390x-ibm-linux-gnu-gcc -S -m64
-fPIC bug-s390.c
$ ~/x-tools/s390x-ibm-linux-gnu/bin/s390x-ibm-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu/bin/s390x-ibm-li=
nux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu/libexec/=
gcc/s390x-ibm-linux-gnu/7.5.0/lto-wrapper
Target: s390x-ibm-linux-gnu
Configured with:
/home/alessandro/src/cross-s390/.build/s390x-ibm-linux-gnu/src/gcc/configur=
e
--build=3Dx86_64-build_pc-linux-gnu --host=3Dx86_64-build_pc-linux-gnu
--target=3Ds390x-ibm-linux-gnu
--prefix=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu
--exec_prefix=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu
--with-sysroot=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu/s390x-ibm-lin=
ux-gnu/sysroot
--enable-languages=3Dc --with-pkgversion=3D'crosstool-NG
1.27.0.18_7458341' --enable-__cxa_atexit --disable-tm-clone-registry
--disable-libmudflap --disable-libgomp --disable-libssp
--disable-libquadmath --disable-libquadmath-support
--disable-libsanitizer --disable-libmpx --disable-libstdcxx-verbose
--with-gmp=3D/home/alessandro/src/cross-s390/.build/s390x-ibm-linux-gnu/bui=
ldtools
--with-mpfr=3D/home/alessandro/src/cross-s390/.build/s390x-ibm-linux-gnu/bu=
ildtools
--with-mpc=3D/home/alessandro/src/cross-s390/.build/s390x-ibm-linux-gnu/bui=
ldtools
--with-isl=3D/home/alessandro/src/cross-s390/.build/s390x-ibm-linux-gnu/bui=
ldtools
--enable-lto --without-zstd --enable-threads=3Dposix
--enable-target-optspace --disable-plugin --disable-nls
--disable-multilib
--with-local-prefix=3D/home/alessandro/x-tools/s390x-ibm-linux-gnu/s390x-ib=
m-linux-gnu/sysroot
--enable-long-long
Thread model: posix
gcc version 7.5.0 (crosstool-NG 1.27.0.18_7458341)
$ ~/x-tools/s390x-ibm-linux-gnu/bin/s390x-ibm-linux-gnu-gcc  -S -m64 bug-s3=
90.c
$ ~/x-tools/s390x-ibm-linux-gnu/bin/s390x-ibm-linux-gnu-gcc  -S -m64
-fPIC bug-s390.c
bug-s390.c: In function 'f1':
bug-s390.c:2:20: warning: asm operand 0 probably doesn't match constraints
 #define asm_inline asm __inline
                    ^
bug-s390.c:6:2: note: in expansion of macro 'asm_inline'
  asm_inline volatile(     \
  ^~~~~~~~~~
bug-s390.c:25:2: note: in expansion of macro '__EMIT_BUG'
  __EMIT_BUG(0);     \
  ^~~~~~~~~~
bug-s390.c:29:2: note: in expansion of macro 'BUG'
  BUG();
  ^~~
bug-s390.c:2:20: error: impossible constraint in 'asm'
 #define asm_inline asm __inline
                    ^
bug-s390.c:6:2: note: in expansion of macro 'asm_inline'
  asm_inline volatile(     \
  ^~~~~~~~~~
bug-s390.c:25:2: note: in expansion of macro '__EMIT_BUG'
  __EMIT_BUG(0);     \
  ^~~~~~~~~~
bug-s390.c:29:2: note: in expansion of macro 'BUG'
  BUG();
  ^~~
bug-s390.c: In function 'f2':
bug-s390.c:2:20: warning: asm operand 0 probably doesn't match constraints
 #define asm_inline asm __inline
                    ^
bug-s390.c:6:2: note: in expansion of macro 'asm_inline'
  asm_inline volatile(     \
  ^~~~~~~~~~
bug-s390.c:25:2: note: in expansion of macro '__EMIT_BUG'
  __EMIT_BUG(0);     \
  ^~~~~~~~~~
bug-s390.c:32:2: note: in expansion of macro 'BUG'
  BUG();
  ^~~
bug-s390.c: In function 'main':
bug-s390.c:2:20: warning: asm operand 0 probably doesn't match constraints
 #define asm_inline asm __inline
                    ^
bug-s390.c:6:2: note: in expansion of macro 'asm_inline'
  asm_inline volatile(     \
  ^~~~~~~~~~
bug-s390.c:25:2: note: in expansion of macro '__EMIT_BUG'
  __EMIT_BUG(0);     \
  ^~~~~~~~~~
bug-s390.c:35:2: note: in expansion of macro 'BUG'
  BUG();
  ^~~
$ cat linux-6.14-rc7/arch/s390/Makefile| grep "fPIC"
KBUILD_AFLAGS_MODULE +=3D -fPIC
KBUILD_CFLAGS_MODULE +=3D -fPIC
KBUILD_CFLAGS +=3D -fPIC

As you can see, the problem is not that the compiler itself doesn't
work, but rather that -fPIC introduces some complications.
__func__ is a compile-time constant, but this holds true only for
traditionally linked code.
When compiling position-independent code, this assumption no longer applies=
.

GCC makes significant efforts to handle this, and for several
architectures, it manages to solve the problem.
However, this is not universally the case.
Additionally, -fPIC is not widely used in kernel code... I have only
seen it used for VDSO, the x86 boot piggyback decompressor, PowerPC
boot, and the s390x architecture.

That said, GCC has been mitigating this issue, allowing us to treat a
non-compile-time constant as if it were one.
A proof of this is that, at least since GCC 11, the s390x version of
GCC is able to build this code.
Before that... certainly in GCC 7.5 it couldn't.

A simple fix would be to restrict usage to GCC versions greater than
11 for s390.

The real concern is that we have a latent issue that could be
triggered by changes in build settings, as "feature" support varies
across GCC versions and architectures.
For example, while x86_64 at version 14 seems to work both with and
without -fPIC, this is not the case for AArch64, where enabling -fPIC
causes failures even in version 14.

I'm currently working on a long-term fix for this.

>
> Guenter
>


--=20
---
Alessandro


