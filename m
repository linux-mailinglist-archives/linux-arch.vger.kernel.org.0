Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8737E20439A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 00:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgFVW1v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 18:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbgFVW1u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:27:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C145C061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:27:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so9077073pfn.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JI0wkwVCNwXzxyeXGfReWogDJ8TItG8DNO4AEUQrZHU=;
        b=dXhvjxgsKaYVqQPZKIedonRiQSDzKyvMILv82JolQOk3j6k4i+l8LLeVQR0zMdWyMF
         NV4K5H1nj1Fe6XqV4PoiAxy70HQrCiGYUADhUS3shyAnm3nLjJyCum+9jvjgntLPNBNg
         s10y2Bg2EUA1xvV2Tk/e1CQRLU91b62R9aXyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JI0wkwVCNwXzxyeXGfReWogDJ8TItG8DNO4AEUQrZHU=;
        b=Tc3nPq1TXYgMRZpj/vAKuNsl2W4hbhbcp1uLHXu5wqXSGIms7eRQziADMSeXF1EvM/
         ByKquat2PG+e1SQwKyamg/gW/7HMeylqaM8c+ZN5gqKqxdrqBveBxhfnb/REmbkQoMx2
         Jp8IDUY/a9phC6tYub4+spB19nSTWwZBBq31bTyFMbvw7/REWR+0GR1SFasXpAVnnBzV
         87jJf1YJxZM4uPHt+RqbNDv7kC5UdFoUmPyW10uSh2m+4SUG3iS+9kXU6KlWjRbf1X+Z
         314/w1UOaCpm3FheiZ6l7cKDWib5XbxlMQJ+EJ0lC8jORn5nCMNvtKL/C6k+etGh3frQ
         /54g==
X-Gm-Message-State: AOAM532knsmMz8Fzl9A1SRmZawo8xUmymaxM7TQnWLFCkhOPjG4Q2EsA
        4AhBcQqwpn65GlQO1pnkeZZdfw==
X-Google-Smtp-Source: ABdhPJw5Vi6XCzy6KcvEhS8a1/qSQm1bAo70j7dQ+DEeYLhkCjl8U+R/8n9cXiPZR7Z/RPMXOKbyzA==
X-Received: by 2002:a62:2743:: with SMTP id n64mr21722151pfn.163.1592864869777;
        Mon, 22 Jun 2020 15:27:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fv7sm453463pjb.41.2020.06.22.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:27:49 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:27:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <202006221524.CEB86E036B@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
 <20200622220043.6j3vl6v7udmk2ppp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622220043.6j3vl6v7udmk2ppp@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 03:00:43PM -0700, Fangrui Song wrote:
> On 2020-06-22, Kees Cook wrote:
> > For vmlinux linking, no architecture uses the .gnu.version* section,
> > so remove it via the common DISCARDS macro in preparation for adding
> > --orphan-handling=warn more widely.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > include/asm-generic/vmlinux.lds.h | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index db600ef218d7..6fbe9ed10cdb 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -934,6 +934,7 @@
> > 	*(.discard)							\
> > 	*(.discard.*)							\
> > 	*(.modinfo)							\
> > +	*(.gnu.version*)						\
> > 	}
> > 
> > /**
> > -- 
> > 2.25.1
> 
> I wonder what lead to .gnu.version{,_d,_r} sections in the kernel.

This looks like a bug in bfd.ld? There are no versioned symbols in any
of the input files (and no output section either!)

The link command is:
$ ld -m elf_x86_64 --no-ld-generated-unwind-info -z noreloc-overflow -pie \
--no-dynamic-linker   --orphan-handling=warn -T \
arch/x86/boot/compressed/vmlinux.lds \
arch/x86/boot/compressed/kernel_info.o \
arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o \
arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o \
arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o \
arch/x86/boot/compressed/cpuflags.o \
arch/x86/boot/compressed/early_serial_console.o \
arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o \
arch/x86/boot/compressed/mem_encrypt.o \
arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o \
-o arch/x86/boot/compressed/vmlinux

None of the inputs have the section:

$ for i in arch/x86/boot/compressed/kernel_info.o \
arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o \
arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o \
arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o \
arch/x86/boot/compressed/cpuflags.o \
arch/x86/boot/compressed/early_serial_console.o \
arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o \
arch/x86/boot/compressed/mem_encrypt.o \
arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o \
; do echo -n $i": "; readelf -Vs $i | grep 'version'; done
arch/x86/boot/compressed/kernel_info.o: No version information found in this file.
arch/x86/boot/compressed/head_64.o: No version information found in this file.
arch/x86/boot/compressed/misc.o: No version information found in this file.
arch/x86/boot/compressed/string.o: No version information found in this file.
arch/x86/boot/compressed/cmdline.o: No version information found in this file.
arch/x86/boot/compressed/error.o: No version information found in this file.
arch/x86/boot/compressed/piggy.o: No version information found in this file.
arch/x86/boot/compressed/cpuflags.o: No version information found in this file.
arch/x86/boot/compressed/early_serial_console.o: No version information found in this file.
arch/x86/boot/compressed/kaslr.o: No version information found in this file.
arch/x86/boot/compressed/kaslr_64.o: No version information found in this file.
arch/x86/boot/compressed/mem_encrypt.o: No version information found in this file.
arch/x86/boot/compressed/pgtable_64.o: No version information found in this file.
arch/x86/boot/compressed/acpi.o: No version information found in this file.

And it's not in the output:

$ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
No version information found in this file.

So... for the kernel we need to silence it right now.

-- 
Kees Cook
