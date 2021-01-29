Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6637308FCA
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhA2WIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhA2WIa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:08:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDEAC061574
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:07:50 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g3so6100047plp.2
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDLk3Gi8vfPdyllbM1ZaiSSr9IGaOarIqu+88E328X4=;
        b=WVsNujE5VVA2Er6vgcG75izrIGDXnkBM63vzzKe5rfEmHsH50G8WmQh9J1/tDMBxwK
         /iuIV1R6jdnj76638BjJkOed2U0yY+BA+2YVuSpKsaVLcLmLvZtJN3hCjVn6XWdAp9z+
         VZ+leM5IBKUFVYRINJzqsGhXdR/bzzCEyDFtE759bKIrXg4NdvB6gNRpQ4aIWM1mfdSX
         HSlpRuD5pyztnE3RYxkH1OW5E7qLHNceE8PdSYeksB8JiOcG0RJaufe3R7x41GQOLlTM
         dHZI15xl7W7bgToSCWbw/Y6dmGYQS0nBYhYI/REKO7lvaMk+cM2fphEZFEZogOG31lOK
         Qy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDLk3Gi8vfPdyllbM1ZaiSSr9IGaOarIqu+88E328X4=;
        b=lgyX9ehhBrnGOlQ2ba3gvvVJMDGbIdqYcIbnBXjp/oaP7a6P+0wEKdjtiklFoFwToO
         1xB+ujQXaPR8JJgBAOY7xP891hOguZfymq75/A2Kj1kTF6ERzXnPBzw8vCyFoDzOq1tu
         Ur8EdLufFS7vnhFHI6pmlUE2IY0RuxSfEZdm5r8dnUF0wamgMesS7EoFtHwhjAfy9i8l
         dCp9Qap/DrJ5IL3j7En5DSHhfL1C4YfOr+dfK1wnGqZh9iB1dR9BThRnkANgRBGRuBy+
         J29dhp4m3XydywSo6t5LN6T3L7rap+WuEKwu2PQTLCYf1thNaLad+Fj5WAOLK0P7kcSh
         eRcQ==
X-Gm-Message-State: AOAM530dWk0s8Dk60da30wBTkRnfpCrt+Hz+r0vQJmnnJ1Vymx0ZS/4m
        QqJTn38Lrxyex4BhQxk4L9mDXeul9I7W6iy5imtnxA==
X-Google-Smtp-Source: ABdhPJykxbLtSd9YUcZjLW9Ag/O/mA8mq2zBGwkwGAE2iF60v4hh0lpnY363ReCMCLCtqJ1owge5iQDUXkjmRrYCtD0=
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr6395756pjn.25.1611958070273;
 Fri, 29 Jan 2021 14:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <20210129215158.xs2pidjkex2gtqs7@google.com>
In-Reply-To: <20210129215158.xs2pidjkex2gtqs7@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 14:07:39 -0800
Message-ID: <CAKwvOd=A8sk8fthHSaY_1qeJOg07FF9c6vFumszY_RS6a8n8pA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
To:     Fangrui Song <maskray@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 1:52 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2021-01-29, Nick Desaulniers wrote:
> >diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> >index 34b7e0d2346c..f8d5455cd87f 100644
> >--- a/include/asm-generic/vmlinux.lds.h
> >+++ b/include/asm-generic/vmlinux.lds.h
> >@@ -843,7 +843,11 @@
> >               .debug_types    0 : { *(.debug_types) }                 \
> >               /* DWARF 5 */                                           \
> >               .debug_macro    0 : { *(.debug_macro) }                 \
> >-              .debug_addr     0 : { *(.debug_addr) }
> >+              .debug_addr     0 : { *(.debug_addr) }                  \
> >+              .debug_line_str 0 : { *(.debug_line_str) }              \
> >+              .debug_loclists 0 : { *(.debug_loclists) }              \
> >+              .debug_rnglists 0 : { *(.debug_rnglists) }              \
> >+              .debug_str_offsets      0 : { *(.debug_str_offsets) }
>
> Add .debug_names for -gdwarf-5 -gpubnames
>
> The internal linker script of GNU ld 2.36 will have it.
> https://sourceware.org/pipermail/binutils/2021-January/115064.html
>
> (Compilers don't generate .debug_sup, I added to GNU ld just for
> future-proof.).

If we don't use `-gpubnames`, do I need to future proof the kernel's
linker script? YAGNI? :-P

(Since I need to make changes anyways, ok, I will add it to be safe.
Thanks for the sugguestion).
-- 
Thanks,
~Nick Desaulniers
