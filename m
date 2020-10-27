Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9231229A931
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 11:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897396AbgJ0KJI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 06:09:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35008 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897398AbgJ0KJH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 06:09:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id w25so817016edx.2
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2020 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=30KXF4Pr/aWkmgz9WeJeWxLByh2Hd/+V/34/539xHp8=;
        b=vwJDc1uSSMz/gQXsJKLCES3zXyk/SNTJ4WwUVvlvekJyjicFrDjQlC3bBhSYUE8C7C
         QXhE1wGMo/FmAVJT9dA6jm6WJfJ/mXDZPoAr9w0dRRiELb0i7Y3cdHjrpOoHJZeVClrc
         nfhGctq5M+yOyps0eCO1+JLVvs5y6U/tl0xDU28zo3vIN63bj0p37VMs6L65AKGcxnqd
         /tXlPSedQbU9SoBnOjF4PGejR8Az2/YDpn9YQenKYA6CUvt8tQm+xOZYGhcc0yz7zk+w
         aG/U2fvPyyEcSbJkQiBZsAhmn1yIJ84HDtkvg4vL9IdruqiiI8k0YdWk/p2hEouqYHgC
         ulcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=30KXF4Pr/aWkmgz9WeJeWxLByh2Hd/+V/34/539xHp8=;
        b=r/6GQRo1Yhk5eQs8ZCT/t33fcxF0O5r1RHyiIiKssFiB0O2/v7aQAn23brMmWIVs4o
         osQzYR3jIN9ki5D31BerguESv2O34z+Rka8/ZVgLVYbew9zUyIPezy62qM+yPd2Ot2je
         SUq2qwVQmFZa5ZGl9Dne0VlJdZl/ZzR1pblXb9iwe0H9OHF3fabX8LN6lrR3iajuw8/I
         jrfYk4/3ksf7eH/wpv+n2aWAUL6gLZ5QhM0s4yoFVqMDW8SE2mInr7xDHjN7kkGYnf9u
         mbWye9DV+KQUrJJS7kXMIpBaYbAfTjvdt4Ruzmk/yxHy2/a1Cb37Ws2XSfQn5RDoTgwZ
         Cq1w==
X-Gm-Message-State: AOAM530B8NznvstrgO0PyKxSwl+xMsZaBn40q40bwKWBJJWtGwy8GDz9
        +T+EFtmMom+3rUcYeDmvXvzBtA==
X-Google-Smtp-Source: ABdhPJySr5YXJAYGtUDoWBkyIPhpP8tlUc9V26+2Gotx0C0ZFPYz4VypfmyAIEC3+1ZHXV7GOVXb/Q==
X-Received: by 2002:aa7:dada:: with SMTP id x26mr1379080eds.167.1603793344917;
        Tue, 27 Oct 2020 03:09:04 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t5sm644137edw.45.2020.10.27.03.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 03:09:04 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:08:44 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Collingbourne <pcc@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
Message-ID: <20201027100844.GA1514990@myrica>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org>
 <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Mon, Oct 26, 2020 at 06:38:46PM +0100, Ard Biesheuvel wrote:
> > > > Note that even on plain be2881824ae9eb92, I get:
> > > >
> > > >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> > > >     aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> > > >
> > > > The parent commit obviously doesn't show that (but probably still has
> > > > the problem).
> >
> > Reverting both
> > b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section placement")
> > be2881824ae9eb92 ("arm64/build: Assert for unwanted sections")
> > seems to solve my problems, without any ill effects?
> >
> 
> I cannot reproduce the issue here with my distro GCC+binutils (Debian 8.3.0)

I have the same problem with one of my debug configs and Linux v5.10-rc1,
and can reproduce with the Debian 8.3.0 toolchain, by using the arm64
defconfig and disabling CONFIG_MODULES:

ld -EL -maarch64elf --no-undefined -X -z norelro -shared -Bsymbolic -z notext --no-apply-dynamic-relocs --fix-cortex-a53-843419 --orphan-handling=warn --build-id=sha1 --strip-debug -o .tmp_vmlinux.kallsyms1 -T ./arch/arm64/kernel/vmlinux.lds --whole-archive arch/arm64/kernel/head.o init/built-in.a usr/built-in.a arch/arm64/built-in.a kernel/built-in.a certs/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a crypto/built-in.a block/built-in.a arch/arm64/lib/built-in.a lib/built-in.a drivers/built-in.a sound/built-in.a net/built-in.a virt/built-in.a --no-whole-archive --start-group arch/arm64/lib/lib.a lib/lib.a ./drivers/firmware/efi/libstub/lib.a --end-group
ld: Unexpected GOT/PLT entries detected!
ld: Unexpected run-time procedure linkages detected!

Adding -fno-pie to this command doesn't fix the problem.

Note that when cross-building with a GCC 10.2 and binutils 2.35.1 I also
get several "aarch64-linux-gnu-ld: warning: -z norelro ignored" in
addition to the error, but I don't get that warning with the 8.3.0
toolchain.

Thanks,
Jean

> 
> The presence of .data.rel.ro and .got.plt sections suggests that the
> toolchain is using -fpie and/or -z relro to build shared objects
> rather than a fully linked bare metal binary.
> 
> Which toolchain are you using? Does adding -fno-pie to the compiler
> command line and/or adding -z norelro to the linker command line make
> any difference?
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
