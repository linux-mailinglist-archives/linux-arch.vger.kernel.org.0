Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF33DC3AB
	for <lists+linux-arch@lfdr.de>; Sat, 31 Jul 2021 08:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhGaGBS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 31 Jul 2021 02:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbhGaGBR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 31 Jul 2021 02:01:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD6C0613D3
        for <linux-arch@vger.kernel.org>; Fri, 30 Jul 2021 23:01:09 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e5so13589188pld.6
        for <linux-arch@vger.kernel.org>; Fri, 30 Jul 2021 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RnJbeFRABx8gv+E+NAXey4lvwWkcIEVkiEIkxS1UNwc=;
        b=azNSPWyE526BJD25Kig41e/gXZuaCnVwVtmfP/XFktm31kW6IWgDV558SlzkEo/XN6
         aJjHbwyHPNxcpZyhqo3fDd3UiLK7HBtztgkTaq3x3JKUITY/O2N3Zemakxue44EvrNx8
         vrZZf6hRZbsoBPAsWiiMWzGR2Xu9cw6oyHzRzhPmaglu1tsu3ZGZ6Q50dYJz70t6S8vm
         u8kyWdLjAPRBQ2YyckxY631Voo/H2xTYGz6YznrmzzRZpvUE+yWJcBNfSWBUecvR9MKF
         DY7vxvbSItyF/XXB9m9a5aoe6FxDRpAkuYyYSQ0qrO8Ms41bXxw4WcMuRcJcNsGVEAWw
         yu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RnJbeFRABx8gv+E+NAXey4lvwWkcIEVkiEIkxS1UNwc=;
        b=KPXUsv/ptq8QvDYBiigy/9k6vFNrzLW0tENJ+6ucJUz1ymQRk+Hkh+WMtwnCvkgW3+
         2FaUS/ABEWKKI/QPl0Cscdc3eIsP7UkktAeDoow2JlsYeZvh3GWQIR1UA6BNJcbmWsFt
         YorGIkNzvQMiEBvSfEHk1vD5+OTVI5Q7XCmIqLuc46YWIPkEQa2mQMzEa1OfPm9itJGj
         uNQ8odw4W4PWL9gFli4FE0FLqiGftwvKtVcAWNgUVdaSZSiiTXt/FzqlTxrv62s0qcJQ
         hmFFSOj5VfE7q2mDXQQtKGasWK9AmCXFpKRQWN0C51rQh7ciwQ63LZxDVUUMH1ypB46k
         SyXw==
X-Gm-Message-State: AOAM532VhfdDzdjKULzQp/rHnCUXHr0NprGLHghhPcEPXak7nBFJOwvx
        DhATZc8NipQl6yETVJzMDPlKxg==
X-Google-Smtp-Source: ABdhPJxiEDXou0jFqjJs2vDftAvISpJh7DtbwCekHl/+Ra3AI1c094rlWyAyzBjgNLOhZRVDT/sb2A==
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr6926387pju.51.1627711268627;
        Fri, 30 Jul 2021 23:01:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:160:995:7f22:dc59])
        by smtp.gmail.com with ESMTPSA id e35sm4090000pjk.28.2021.07.30.23.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 23:01:07 -0700 (PDT)
Date:   Fri, 30 Jul 2021 23:01:02 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        clang-built-linux@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] vmlinux.lds.h: Handle clang's module.{c,d}tor sections
Message-ID: <20210731060102.3p7sknifz4d62ocn@google.com>
References: <20210730223815.1382706-1-nathan@kernel.org>
 <20210731023107.1932981-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210731023107.1932981-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reviewed-by: Fangrui Song <maskray@google.com>

On 2021-07-30, Nathan Chancellor wrote:
>A recent change in LLVM causes module_{c,d}tor sections to appear when
>CONFIG_K{A,C}SAN are enabled, which results in orphan section warnings
>because these are not handled anywhere:
>
>ld.lld: warning: arch/x86/pci/built-in.a(legacy.o):(.text.asan.module_ctor) is being placed in '.text.asan.module_ctor'
>ld.lld: warning: arch/x86/pci/built-in.a(legacy.o):(.text.asan.module_dtor) is being placed in '.text.asan.module_dtor'
>ld.lld: warning: arch/x86/pci/built-in.a(legacy.o):(.text.tsan.module_ctor) is being placed in '.text.tsan.module_ctor'
>
>Fangrui explains: "the function asan.module_ctor has the SHF_GNU_RETAIN
>flag, so it is in a separate section even with -fno-function-sections
>(default)".

If my theory is true, we should see orphan section warning with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
before my sanitizer change.

>Place them in the TEXT_TEXT section so that these technologies continue
>to work with the newer compiler versions. All of the KASAN and KCSAN
>KUnit tests continue to pass after this change.
>
>Cc: stable@vger.kernel.org
>Link: https://github.com/ClangBuiltLinux/linux/issues/1432
>Link: https://github.com/llvm/llvm-project/commit/7b789562244ee941b7bf2cefeb3fc08a59a01865
>Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>---
>
>v1 -> v2:
>
>* Fix inclusion of .text.tsan.* (Nick)
>
>* Drop .text.asan as it does not exist plus it would be handled by a
>  different line (Fangrui)
>
>* Add Fangrui's explanation about why the LLVM commit caused these
>  sections to appear.
>
> include/asm-generic/vmlinux.lds.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index 17325416e2de..62669b36a772 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -586,6 +586,7 @@
> 		NOINSTR_TEXT						\
> 		*(.text..refcount)					\
> 		*(.ref.text)						\
>+		*(.text.asan.* .text.tsan.*)				\

When kmsan is upstreamed, we may need to add .text.msan.* :)

(
I wondered why we cannot just change the TEXT_MAIN pattern to .text.*

For large userspace applications, separating .text.unlikely .text.hot can help
do things like hugepage and mlock, which can improve instruction cache
localize and reduce instruction TLB miss rates,,, but not sure this
helps much for the kernel.

Or perhaps some .text.FOOBAR has special usage which cannot be placed
into the output .text
)


> 		TEXT_CFI_JT						\
> 	MEM_KEEP(init.text*)						\
> 	MEM_KEEP(exit.text*)						\
>
>base-commit: 4669e13cd67f8532be12815ed3d37e775a9bdc16
>-- 
>2.32.0.264.g75ae10bc75
>
