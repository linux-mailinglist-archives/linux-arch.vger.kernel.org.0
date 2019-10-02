Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4FC4516
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2019 02:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfJBAkd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 20:40:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46935 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfJBAkd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 20:40:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id k25so16125089oiw.13
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2019 17:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtOW9l/Mzm4WWzQNjfCTvJ0AhTUTSkblWJhPZb6hfmM=;
        b=FRo5cLPvmdDcGKerDWzBLxevEUMFsOs95oNwqAA5YnVlRPDuDp82XzZtRMnRIivrt1
         6jMYweeiVNv6d+8LctOdqgQuOz1j1je5crIDohHrUnbqv/Mtkc8FaWXIXpATZ8vJf3lA
         iB+PnAPg+5q6B6eBGFXz9fP8JohTkfisaSniWzc+b/88aUSvWHV4uKN4i0ugcSgyjO8Q
         kMvBoQa/7mrL24FTI1ZKDlR7MJw0qMXTGSunSEgcc6GXqPvr3EmUVpn2Su1DH3vrki8Q
         GmJuhOz5UYgv4e0CH87W50Na3TCqeeb1Aiy3K9iV38fqo9wtSYcBbwjEfQThm+mZwWQl
         iWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtOW9l/Mzm4WWzQNjfCTvJ0AhTUTSkblWJhPZb6hfmM=;
        b=cT+O+FeVyzFfrZ8E1Jb6UbW2C0xhDN5r1NIAWPRJrzyfa/2SABkRtTWHQNHk52ZOZl
         tRQ+bHXdKaAaHVDQXyYO+WDnezbzLQm/2UdM90kXSW2h5rCCVdLXkgySeie5TpN4Bu1x
         w5UkPUYvG9WSJSfH278yCj9aS1JTKpBpi5W8Pwqiu216CRxwUDt048I/zUIJnExpORAq
         JcMR7X8VsJBU0gPXxzCDbBoHYFuFcPiAPgcRxZvJA7yh3/P8G5ipHEoxtJ3d+Z3qXpao
         bCO2oV80QoQHdlPhEHqxXr129ukcxvAUQkQCCi5bNuq3ZtOwFx+Dyli4IEs1awF0M281
         NsMQ==
X-Gm-Message-State: APjAAAVh6SyjJMyXcXa9yEa79GZTiEkAA8lj2LpLT7V0W7Lqc3dZ+Iie
        h6nTblQNDzN+r7d5buHxOL9jebDjVgwCkVjNdg1Wjw==
X-Google-Smtp-Source: APXvYqyGe4WuOmb3K3A3SDH+9X5RvSUVYSCqMCe8CuZtstj4i29DoW2hybgRQVs1AxubpQXZMw7a6bLv/6k3OKdDiW4=
X-Received: by 2002:aca:4406:: with SMTP id r6mr615626oia.175.1569976832302;
 Tue, 01 Oct 2019 17:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <8736gcjosv.fsf@x220.int.ebiederm.org> <201910011140.EA0181F13@keescook>
 <87imp8hyc8.fsf@x220.int.ebiederm.org>
In-Reply-To: <87imp8hyc8.fsf@x220.int.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 2 Oct 2019 02:40:04 +0200
Message-ID: <CAG48ez1Ly26fP3_3DaGGkHgpyG3zmOmeC95jUmpVUwvjnLG8SQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kostya Serebryany <kcc@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Apelete Seketeli <apelete@seketeli.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Chee Nouk Phoon <cnphoon@altera.com>,
        Chris Zankel <chris@zankel.net>,
        Christian Ruppert <christian.ruppert@abilis.com>,
        Greg Ungerer <gerg@uclinux.org>, Helge Deller <deller@gmx.de>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Josh Boyer <jwboyer@gmail.com>, Jun Nie <jun.nie@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Paul Burton <paul.burton@mips.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Pierrick Hascoet <pierrick.hascoet@abilis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roland Stigge <stigge@antcom.de>,
        Vineet Gupta <vgupta@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+Kostya (code owner for LLVM sanitizer_common) as FYI

On Wed, Oct 2, 2019 at 12:54 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Kees Cook <keescook@chromium.org> writes:
> > On Tue, Oct 01, 2019 at 01:36:32PM -0500, Eric W. Biederman wrote:
[...]
> > I think you can actually take this further and remove (or at least
> > empty) the uapi/linux/sysctl.h file too.
[...]
> I would make it a followup that removes uapi/linux/sysctl.h.  I don't
> see anything in it that isn't about the sysctl system call.  I will keep
> it a separate patch as I can imagine something silly that needs the
> header file to compile.  A separate patch would make a revert easier
> if we find something like that.

Unfortunately, I think that header (or at least parts of it) has to
stay around for now:

Looking through the search results for linux/sysctl.h (ignoring
glibc's sys/sysctl.h, which pulls in linux/sysctl.h, because almost
all of those hits are conditional includes for BSD systems) on
codesearch.debian.net, I noticed that e.g. the ASAN code that GCC and
LLVM use pulls in linux/sysctl.h and uses things from it:

https://github.com/llvm-mirror/compiler-rt/blob/124fd5d9aff57cf47bf077df81ad939b289acc6e/lib/sanitizer_common/sanitizer_platform_limits_posix.cpp#L1063

And indeed, after replacing /usr/include/linux/sysctl.h with an empty
file, a build of LLVM's runtime library component (compiler-rt) (git
HEAD version) falls over with error spew about __sysctl_args:

====================
$ cmake -G Ninja -DCMAKE_BUILD_TYPE=Release
-DLLVM_ENABLE_PROJECTS='clang;compiler-rt' -DCMAKE_C_COMPILER=clang-7
-DCMAKE_CXX_COMPILER=clang++-7 -DLLVM_TARGETS_TO_BUILD="X86"
-DLLVM_USE_LINKER=lld-7 -DBUILD_SHARED_LIBS=Off ../llvm
[...]
$ ninja -j64
FAILED: projects/compiler-rt/lib/sanitizer_common/CMakeFiles/RTSanitizerCommonNoTermination.i386.dir/sanitizer_platform_limits_posix.cpp.o
[...]
[...]/compiler-rt/lib/sanitizer_common/sanitizer_platform_limits_posix.cpp:1063:17:
error: use of undeclared identifier '__sysctl_args'
CHECK_TYPE_SIZE(__sysctl_args);
                ^
[...]/compiler-rt/lib/sanitizer_common/sanitizer_platform_limits_posix.cpp:1064:23:
error: use of undeclared identifier '__sysctl_args'
CHECK_SIZE_AND_OFFSET(__sysctl_args, name);
                      ^
[...]/compiler-rt/lib/sanitizer_common/sanitizer_platform_limits_posix.cpp:1064:1:
error: expected expression
CHECK_SIZE_AND_OFFSET(__sysctl_args, name);
^
[...]/compiler-rt/lib/sanitizer_common/sanitizer_platform_limits_posix.h:1438:34:
note: expanded from macro 'CHECK_SIZE_AND_OFFSET'
                 sizeof(((CLASS *)NULL)->MEMBER));                \
                                 ^
[...]/compiler-rt/lib/sanitizer_common/sanitizer_platform_limits_posix.cpp:1064:23:
error: unknown type name '__sysctl_args'
CHECK_SIZE_AND_OFFSET(__sysctl_args, name);
                      ^
====================
