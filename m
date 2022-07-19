Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB857946C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 09:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiGSHmp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiGSHmp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 03:42:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D01CFF4;
        Tue, 19 Jul 2022 00:42:43 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M9WmQ-1o8EE93mh2-005cve; Tue, 19 Jul 2022 09:42:42 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ef5380669cso131879477b3.9;
        Tue, 19 Jul 2022 00:42:41 -0700 (PDT)
X-Gm-Message-State: AJIora+sI6R0lvS9NJoElRjYTk8+engM5UkA1MG7YoOLXeafFchSTS+z
        yCrCBhKPXjgPJadvVssMJuPCZURb3EwvlAVXMO0=
X-Google-Smtp-Source: AGRyM1tmWmPbrg7yvHE/w+kxpWNdDAwAPOmNtzvkbvYGb5Xfd7R1y42CocaChsPUNrPmhKIX5Ax/Xy/CbxUgIijf0jg=
X-Received: by 2002:a81:d93:0:b0:31c:d32d:4d76 with SMTP id
 141-20020a810d93000000b0031cd32d4d76mr36630570ywn.135.1658216560443; Tue, 19
 Jul 2022 00:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220715185551.3951955-1-f.fainelli@gmail.com>
In-Reply-To: <20220715185551.3951955-1-f.fainelli@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 09:42:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3cuTknZaLZCFGwZtMfbd1qAFWEtXMcvVHsXoJn8EUCOg@mail.gmail.com>
Message-ID: <CAK8P3a3cuTknZaLZCFGwZtMfbd1qAFWEtXMcvVHsXoJn8EUCOg@mail.gmail.com>
Subject: Re: [PATCH] tools: Fixed MIPS builds due to struct flock re-definition
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ky8dpsE7cu3c6Z6P2Yk0eP1n/bwwSDeo5eN+FlUxRFUxs6lZ2lY
 o5Nayj6PLtKg5TNjfnW+TdoOM6+BSNyCXr6NIaLy/Lq4GRchSiZ3yCqGSYWiu/NANHhcjef
 WVWED498wvwni6aK8369+4Cadqz9ujOvvrAShox0UO+H9cNjJkgfyEdqSWIfWHMeWOtMX2W
 TrYj66RUwAAIvX3mMKHEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J8uqqvEuugE=:QUjV7YsZvVnXWDK3Qzu7BU
 AByfWq68sxYQbfLI0/KVYMOAnjwuBI7rHnv+UqNjk4CVsX3P6sbaH+eBL38A7ODhnzJCcY9+Z
 AD2pDbmc83gO0XuflluCPfWbbAhY5M0wHLV3Da7mGvy5rjciszNLYiz3vITNRojE70nc2q3oO
 bKtNSglacDVFCOuHfo106xDCJgi975NlQgCxP7LBiLLRYtNkNQTn97Fr9aX3WiRYgLZsnot0a
 vNDYIVkOdlTitqmPTwWCo8UK81ZOmMjJuBj6yR1ME5e69QF4ypwOZQu79tnc8w4L7PelBR48f
 1NmOijRgK9hSp+wj5Hez0TboxGNO/fUHRPo10QFvYWWLkSbInK6oT28qQ64H/AGrDRkKPp8/S
 3qHgvkA5T8M1JeNYlZYEmVV0UMgLFz3y3gwHcwkpmk+c+z5EK4b0sEir9nrE81D6UBSfxRwrZ
 dh3QIRkVj6pdDxJ0DizLGdru0r0jvhWP8fo8W7q5AykmKMkJSnup9C3n1fraXaPK1KSWqRrv0
 Qe+Fj1Ac5MFMt/j7oBlIRWqc42+AUv1yEgNa7ys0qLXhX4lGTBhTLBxODwnOdcWlalyzSvOkR
 ufladA82CeAKoFyNllAhisruOR5Jt7svIUO+MxkstMSzRdHgYtbNOkSBkiSgNg1u/HVF+EZtP
 Xy0G+kkIskFrsrjk7VQd+kQl+n68c5rj7rMcITR3D5qdORIC0udTdARMiqd9upSIMFl2mvZXw
 2Y0N0Qj14yUfD53XkC6a2hHPi5wLDgUAk4bNlo4Q7kU/TyZq01EnIqcQqddehY2V/aYyCpFoS
 bpJP9BgIub2s2thVwM3cI/ULZiHhvIkCRHkjLbcFR5WMe5+SOhMwMcpXtHsbJPpqvOr0z3tWS
 68hORh5oqzs9w/8bUVMg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 15, 2022 at 8:55 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Building perf for MIPS failed after 9f79b8b72339 ("uapi: simplify
> __ARCH_FLOCK{,64}_PAD a little") with the following error:
>
>   CC
> /home/fainelli/work/buildroot/output/bmips/build/linux-custom/tools/perf/trace/beauty/fcntl.o
> In file included from
> ../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:77,
>                  from ../include/uapi/linux/fcntl.h:5,
>                  from trace/beauty/fcntl.c:10:
> ../include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of
> 'struct flock'
>  struct flock {
>         ^~~~~
> In file included from ../include/uapi/linux/fcntl.h:5,
>                  from trace/beauty/fcntl.c:10:
> ../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:63:8:
> note: originally defined here
>  struct flock {
>         ^~~~~
>
> This is due to the local copy under
> tools/include/uapi/asm-generic/fcntl.h including the toolchain's kernel
> headers which already define 'struct flock' and define
> HAVE_ARCH_STRUCT_FLOCK to future inclusions make a decision as to
> whether re-defining 'struct flock' is appropriate or not.
>
> Make sure what do not re-define 'struct flock'
> when HAVE_ARCH_STRUCT_FLOCK is already defined.
>
> Fixes: 9f79b8b72339 ("uapi: simplify __ARCH_FLOCK{,64}_PAD a little")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  tools/include/uapi/asm-generic/fcntl.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
> index 0197042b7dfb..312881aa272b 100644
> --- a/tools/include/uapi/asm-generic/fcntl.h
> +++ b/tools/include/uapi/asm-generic/fcntl.h
> @@ -185,6 +185,7 @@ struct f_owner_ex {
>
>  #define F_LINUX_SPECIFIC_BASE  1024
>
> +#ifndef HAVE_ARCH_STRUCT_FLOCK
>  struct flock {
>         short   l_type;
>         short   l_whence;
> @@ -209,5 +210,6 @@ struct flock64 {
>         __ARCH_FLOCK64_PAD
>  #endif
>  };
> +#endif /* HAVE_ARCH_STRUCT_FLOCK */
>

I applied this to the asm-generic tree, but now I'm having second thoughts, as
this only changes the tools/include/ version but not the version we ship to user
space. Normally these are meant to be kept in sync.

It appears that commit 306f7cc1e906 ("uapi: always define
F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h") already caused
them to diverge, presumably the uapi version here is correct and we
forgot to adapt the tools version at some point. There are also some
non-functional differences from older patches.

I think the correct fix to address the problem in both versions and
get them back into sync would be something like the patch below.
I have done zero testing on it though.

Christoph and Florian, any other suggestions?

       Arnd

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index f13d37b60775..1ecdb911add8 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -192,6 +192,7 @@ struct f_owner_ex {

 #define F_LINUX_SPECIFIC_BASE  1024

+#ifndef HAVE_ARCH_STRUCT_FLOCK
 struct flock {
        short   l_type;
        short   l_whence;
@@ -216,5 +217,6 @@ struct flock64 {
        __ARCH_FLOCK64_PAD
 #endif
 };
+#endif /* HAVE_ARCH_STRUCT_FLOCK */

 #endif /* _ASM_GENERIC_FCNTL_H */
diff --git a/tools/include/uapi/asm-generic/fcntl.h
b/tools/include/uapi/asm-generic/fcntl.h
index 312881aa272b..1ecdb911add8 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _ASM_GENERIC_FCNTL_H
 #define _ASM_GENERIC_FCNTL_H

@@ -90,7 +91,7 @@

 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-#define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)
+#define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)

 #ifndef O_NDELAY
 #define O_NDELAY       O_NONBLOCK
@@ -115,11 +116,13 @@
 #define F_GETSIG       11      /* for sockets. */
 #endif

+#if __BITS_PER_LONG == 32 || defined(__KERNEL__)
 #ifndef F_GETLK64
 #define F_GETLK64      12      /*  using 'struct flock64' */
 #define F_SETLK64      13
 #define F_SETLKW64     14
 #endif
+#endif /* __BITS_PER_LONG == 32 || defined(__KERNEL__) */

 #ifndef F_SETOWN_EX
 #define F_SETOWN_EX    15
@@ -178,6 +181,10 @@ struct f_owner_ex {
                                   blocking */
 #define LOCK_UN                8       /* remove lock */

+/*
+ * LOCK_MAND support has been removed from the kernel. We leave the symbols
+ * here to not break legacy builds, but these should not be used in new code.
+ */
 #define LOCK_MAND      32      /* This is a mandatory flock ... */
 #define LOCK_READ      64      /* which allows concurrent read operations */
 #define LOCK_WRITE     128     /* which allows concurrent write operations */
