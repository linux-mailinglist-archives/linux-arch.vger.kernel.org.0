Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89B9204412
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 00:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgFVWwm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 18:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbgFVWwl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:52:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6215BC061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:52:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so9107789pfn.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBEna7C87CRIsVV64iTClb5tnnjO6hHTnZhKwH5ueDo=;
        b=JWy9yt7eE/ncFipoANW28y2XJ1ZnUsCUUuye1QXLafBrvvAcNS3clpffhnGulTIYMe
         yQSD7+sctvULb3ODOC4CGrVArxcrSDxdmlyEazwBC2vNPoVRada5mPERMx2utWUuE8IC
         7QqNq8xQBK1BZ5eiQ2TdAr/PrvKG4QztdYaxHpm00pQ6uXk+DEajdAMH67OTmUZzmcFX
         obfYPcV8hqhIuEKpG96WPafAtrVkZpW4N14+IAV7g02cYoVgu+iXnI/goqfYO5TXgytZ
         IZbEdSgYLstiRglidMLv80uI/uPg+ljIMbgq/rtikaXP9Q4XLpgW4c9wr7CpyS2pqFl+
         LN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBEna7C87CRIsVV64iTClb5tnnjO6hHTnZhKwH5ueDo=;
        b=CIbLTSjT4r0/tnzMeUgHwbKrvzB+Mmm2Vd0OxjlLLwIdWcWnne8Kfqvp8GbTjMSi9/
         W7SpLtdfc8i4/ZOXz+rEfHntlygiroPH+z/MwhcZQJ5M7R1Q0joefpBKEq9H7gTK8rgb
         KK2VA/ZTl/T2yShRDygkLpq91YX3V5yxp0Gg5ABo/w24r1ghtrR2y8Qw1hyGjVHAgV+3
         dif5ymns/CWVA0Y+XM9oo8T7viacC+bvIoVPj7Vsuje40Hv5YW9rF1dCu43/N8G34GCl
         dctJXbIqeNEjpeeaxdfBkpydTcIbDtnjOTqSAmmMsKXJ2k2rZQovb1GKP4i2jy3DTQOz
         dA5A==
X-Gm-Message-State: AOAM530WRreMketMV9vxfLQZ6odm+9iWofsOefdop0gI0vHKqQpaC8v2
        M1SSzSk808nl3QxV6n+PfBHBBg==
X-Google-Smtp-Source: ABdhPJwz5jU1WSrwpcbUa1oaT8ThSDWk9hJYIDWJwP9tAwIGdsFlMwCr5T/Jn3VuSf6jbfPYduXDbA==
X-Received: by 2002:a63:384a:: with SMTP id h10mr14717359pgn.176.1592866360771;
        Mon, 22 Jun 2020 15:52:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id d7sm15198576pfh.78.2020.06.22.15.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:52:40 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:52:37 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <20200622225237.ybol4qmz4mhkmlqc@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
 <20200622220043.6j3vl6v7udmk2ppp@google.com>
 <202006221524.CEB86E036B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202006221524.CEB86E036B@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-06-22, Kees Cook wrote:
>On Mon, Jun 22, 2020 at 03:00:43PM -0700, Fangrui Song wrote:
>> On 2020-06-22, Kees Cook wrote:
>> > For vmlinux linking, no architecture uses the .gnu.version* section,
>> > so remove it via the common DISCARDS macro in preparation for adding
>> > --orphan-handling=warn more widely.
>> >
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > ---
>> > include/asm-generic/vmlinux.lds.h | 1 +
>> > 1 file changed, 1 insertion(+)
>> >
>> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> > index db600ef218d7..6fbe9ed10cdb 100644
>> > --- a/include/asm-generic/vmlinux.lds.h
>> > +++ b/include/asm-generic/vmlinux.lds.h
>> > @@ -934,6 +934,7 @@
>> > 	*(.discard)							\
>> > 	*(.discard.*)							\
>> > 	*(.modinfo)							\
>> > +	*(.gnu.version*)						\
>> > 	}
>> >
>> > /**
>> > --
>> > 2.25.1
>>
>> I wonder what lead to .gnu.version{,_d,_r} sections in the kernel.
>
>This looks like a bug in bfd.ld? There are no versioned symbols in any
>of the input files (and no output section either!)
>
>The link command is:
>$ ld -m elf_x86_64 --no-ld-generated-unwind-info -z noreloc-overflow -pie \
>--no-dynamic-linker   --orphan-handling=warn -T \
>arch/x86/boot/compressed/vmlinux.lds \
>arch/x86/boot/compressed/kernel_info.o \
>arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o \
>arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o \
>arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o \
>arch/x86/boot/compressed/cpuflags.o \
>arch/x86/boot/compressed/early_serial_console.o \
>arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o \
>arch/x86/boot/compressed/mem_encrypt.o \
>arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o \
>-o arch/x86/boot/compressed/vmlinux
>
>None of the inputs have the section:
>
>$ for i in arch/x86/boot/compressed/kernel_info.o \
>arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o \
>arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o \
>arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o \
>arch/x86/boot/compressed/cpuflags.o \
>arch/x86/boot/compressed/early_serial_console.o \
>arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o \
>arch/x86/boot/compressed/mem_encrypt.o \
>arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o \
>; do echo -n $i": "; readelf -Vs $i | grep 'version'; done
>arch/x86/boot/compressed/kernel_info.o: No version information found in this file.
>arch/x86/boot/compressed/head_64.o: No version information found in this file.
>arch/x86/boot/compressed/misc.o: No version information found in this file.
>arch/x86/boot/compressed/string.o: No version information found in this file.
>arch/x86/boot/compressed/cmdline.o: No version information found in this file.
>arch/x86/boot/compressed/error.o: No version information found in this file.
>arch/x86/boot/compressed/piggy.o: No version information found in this file.
>arch/x86/boot/compressed/cpuflags.o: No version information found in this file.
>arch/x86/boot/compressed/early_serial_console.o: No version information found in this file.
>arch/x86/boot/compressed/kaslr.o: No version information found in this file.
>arch/x86/boot/compressed/kaslr_64.o: No version information found in this file.
>arch/x86/boot/compressed/mem_encrypt.o: No version information found in this file.
>arch/x86/boot/compressed/pgtable_64.o: No version information found in this file.
>arch/x86/boot/compressed/acpi.o: No version information found in this file.
>
>And it's not in the output:
>
>$ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
>No version information found in this file.
>
>So... for the kernel we need to silence it right now.

Re-link with -M (or -Map file) to check where .gnu.version{,_d,_r} input
sections come from?

If it is a bug, we should probably figure out which version of binutils
has fixed the bug.
