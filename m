Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023422F5167
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 18:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbhAMRtY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 12:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbhAMRtY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 12:49:24 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2BC061575;
        Wed, 13 Jan 2021 09:48:44 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id bd6so1132362qvb.9;
        Wed, 13 Jan 2021 09:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9b8V5ldrJPxRBHqA53wu0d+Zi8BaxVZ6cd708HjPwiQ=;
        b=od8zfmMRP96FRdSxJkv8qPbEH28oasOOMIcp/S8CghoHLT9j9dTarMQaJY2wnukZ1q
         tbvEYsjanXVAo/ov3R0UzRgACnSszGVrkoUE1K6FMn1onySdJvC51PJcwXXQlRRH8qu5
         ShH0lpfWXMiYFYCsyFPfB1M+PVT0yKXkMhDNjncxfChbQu2/BazbtCIB3XxOLC4HkjBl
         5z8U1EcNCeMPJKlLVqEh5qQ0A9r6PkXQCY9C22gSRmdT3caXo4fGrutJIg1nbPXWWOPS
         mC3ET4D8he+0nk9bl/XlAO5GEu/3vPMHYlYa41kfWTQ/ZBjY1AkBPGjSvfMo9eOeF5J+
         Z+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9b8V5ldrJPxRBHqA53wu0d+Zi8BaxVZ6cd708HjPwiQ=;
        b=QepsfhmkQUyGqAJF28eHTk/pJpd94zI6d/ruwWhkr7sAT7pxRJlKkZsRQE0FlbC4HE
         ID4tNk5AveupWqiqx/jnxdaxtFkvZAERaf1fm+JbJsQxOZ/YmiSNU/XAMm+S6TY7ya4f
         pn7t6roaIzfUuTNafZ8thRs3PdPh6yiZIh8bV1swWxapb2wg5RfnkMpnN8bI+kbVJ+P7
         WJtwsFxkeEmWbnXjPRQ3NLwE2xjs4AkI2RB1/HBFef632RJRpaMpLfQXb6f0OInxZCUG
         wmSRF2vtGP6mPXpmrA5JOukYCIgBAVZcTN2Xj3asstQri0bimrgmKiWXm+6asBquz/EG
         9syA==
X-Gm-Message-State: AOAM530aRZmPeI08jmNCi2Ad4l1TYA5qytLBf4O/JwuJ+H0a8CnB1N2F
        C+vyt3YrJ61lK7XigiXwtPs=
X-Google-Smtp-Source: ABdhPJxx5TejvJ1UMbb6Ox5G2kWXTyvjq873WXc0CXR+MyuirCugiGPfDe7uTD981oW+3ZnIYM16fQ==
X-Received: by 2002:ad4:5187:: with SMTP id b7mr3300492qvp.2.1610560123462;
        Wed, 13 Jan 2021 09:48:43 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id f22sm1464173qkl.65.2021.01.13.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:48:42 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:48:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>
Subject: Re: [PATCH v4 1/3] Remove $(cc-option,-gdwarf-4) dependency from
 CONFIG_DEBUG_INFO_DWARF4
Message-ID: <20210113174841.GA4158893@ubuntu-m3-large-x86>
References: <20210113003235.716547-1-ndesaulniers@google.com>
 <20210113003235.716547-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113003235.716547-2-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 12, 2021 at 04:32:33PM -0800, Nick Desaulniers wrote:
> From: Masahiro Yamada <masahiroy@kernel.org>
> 
> The -gdwarf-4 flag is supported by GCC 4.5+, and also by Clang.
> 
> You can see it at https://godbolt.org/z/6ed1oW
> 
>   For gcc 4.5.3 pane,    line 37:    .value 0x4
>   For clang 10.0.1 pane, line 117:   .short 4
> 
> Given Documentation/process/changes.rst stating GCC 4.9 is the minimal
> version, this cc-option is unneeded.
> 
> Note
> ----
> 
> CONFIG_DEBUG_INFO_DWARF4 controls the DWARF version only for C files.
> 
> As you can see in the top Makefile, -gdwarf-4 is only passed to CFLAGS.
> 
>   ifdef CONFIG_DEBUG_INFO_DWARF4
>   DEBUG_CFLAGS    += -gdwarf-4
>   endif
> 
> This flag is used when compiling *.c files.
> 
> On the other hand, the assembler is always given -gdwarf-2.
> 
>   KBUILD_AFLAGS   += -Wa,-gdwarf-2
> 
> Hence, the debug info that comes from *.S files is always DWARF v2.
> This is simply because GAS supported only -gdwarf-2 for a long time.
> 
> Recently, GAS gained the support for --dwarf-[3|4|5] options. [1]
> And, also we have Clang integrated assembler. So, the debug info
> for *.S files might be improved if we want.
> 
> In my understanding, the current code is intentional, not a bug.
> 
> [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=31bf18645d98b4d3d7357353be840e320649a67d
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  lib/Kconfig.debug | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 78361f0abe3a..dd7d8d35b2a5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -258,7 +258,6 @@ config DEBUG_INFO_SPLIT
>  
>  config DEBUG_INFO_DWARF4
>  	bool "Generate dwarf4 debuginfo"
> -	depends on $(cc-option,-gdwarf-4)
>  	help
>  	  Generate dwarf4 debug info. This requires recent versions
>  	  of gcc and gdb. It makes the debug information larger.
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
