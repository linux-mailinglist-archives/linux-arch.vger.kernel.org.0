Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401A02F8814
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 23:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbhAOWAo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 17:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbhAOWAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 17:00:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A33C0613D3
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 14:00:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y12so5839058pji.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 14:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t+cXnlBFq8WTb5dbUuQjMhr2A9oyhYcZeyKpPnSTr6w=;
        b=QLLEcyFZlJw4ynxsEl/y7diypFyFaKmWF4wjvz1MVPrhe8yqb7TUO+Ovl53eFy26Zv
         Vyg5Vk3uZvPqK6588DPWboXivEXa3KNLyYY/5n2ObfYjdy4O8kNybJEOXXl4z31Wu3tg
         WeoiETvHF9c1TpKB8iy6QCpos8IBMCYYU3wG2Vc8MjyO2spULnzUloAeRMeO6+qIeouz
         d1Ichh/XhTrAxPSBVitupF2zoFqmu3mNARKz4godC+9BNADtNnj9GLukfhzs1afjTJw5
         DwF4Syp3TUFPUuyh9EkhGKWCv+2155I4WZAM7aFVKXa79UtaLT6u/71833Pwz4pTBnli
         4pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+cXnlBFq8WTb5dbUuQjMhr2A9oyhYcZeyKpPnSTr6w=;
        b=ap4SwgwR+3Mr8S1cgvgOUKcV3uLHzgsgiwPuJnqx/dL7c/8YCeweKKqWhmM7f9AEql
         cXZxbxMLdXqlVamMwxP7Xb1nFm2yL/QgfxR5dnJAfhr8cpvhJmQp3xz/1wZZ4akSbe+W
         Y2fOhoy0VaPDNSw9QASlybw2wgfieX9hZZZTlbUxQf25RQA5kMG5iYnsD9CVewg+2ne8
         i6WP4nDbKHGx+pdAOo9/av1++tbZGsLW5aD4dDslc+6PC7Bk/q7ONM73p3UVo26GBV0v
         Lh9/x0uQx7KxoZ5CdblwipsYp9ZnhFYQhoXIUER1BVxSD0QZXkStkGGbgUfNt2y+7FA9
         07Pg==
X-Gm-Message-State: AOAM531HLG1A3jQTmxcXDrIwStTkDSwR7EbOxPbE1vLMZdG3Ne5HkHfM
        c+P2TwPUAGLXfMKhL9Lr69c49g==
X-Google-Smtp-Source: ABdhPJzep3S44Y7zZ4tUZ7UjgW93naxrl5+2ShLyVoxK0xq3SG+/UcqzXcTgycoKPrvPPFwBliHnKg==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr12832398pjb.207.1610748002351;
        Fri, 15 Jan 2021 14:00:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id 14sm8710459pfi.131.2021.01.15.14.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:00:01 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:59:58 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 1/3] Remove $(cc-option,-gdwarf-4) dependency from
 CONFIG_DEBUG_INFO_DWARF4
Message-ID: <20210115215958.3cqewpk7hycfr3hm@google.com>
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210115210616.404156-2-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-01-15, Nick Desaulniers wrote:
>From: Masahiro Yamada <masahiroy@kernel.org>
>
>The -gdwarf-4 flag is supported by GCC 4.5+, and also by Clang.
>
>You can see it at https://godbolt.org/z/6ed1oW
>
>  For gcc 4.5.3 pane,    line 37:    .value 0x4
>  For clang 10.0.1 pane, line 117:   .short 4
>
>Given Documentation/process/changes.rst stating GCC 4.9 is the minimal
>version, this cc-option is unneeded.
>
>Note
>----
>
>CONFIG_DEBUG_INFO_DWARF4 controls the DWARF version only for C files.
>
>As you can see in the top Makefile, -gdwarf-4 is only passed to CFLAGS.
>
>  ifdef CONFIG_DEBUG_INFO_DWARF4
>  DEBUG_CFLAGS    += -gdwarf-4
>  endif
>
>This flag is used when compiling *.c files.
>
>On the other hand, the assembler is always given -gdwarf-2.
>
>  KBUILD_AFLAGS   += -Wa,-gdwarf-2
>
>Hence, the debug info that comes from *.S files is always DWARF v2.
>This is simply because GAS supported only -gdwarf-2 for a long time.
>
>Recently, GAS gained the support for --dwarf-[3|4|5] options. [1]

The gas commit description has a typo. The supported options are -gdwarf-[345] or --gdwarf-[345].
-gdwarf2 and --gdwarf2 are kept for compatibility.

Looks good otherwise.

>And, also we have Clang integrated assembler. So, the debug info
>for *.S files might be improved if we want.
>
>In my understanding, the current code is intentional, not a bug.
>
>[1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=31bf18645d98b4d3d7357353be840e320649a67d
>
>Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>---
> lib/Kconfig.debug | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>index 78361f0abe3a..dd7d8d35b2a5 100644
>--- a/lib/Kconfig.debug
>+++ b/lib/Kconfig.debug
>@@ -258,7 +258,6 @@ config DEBUG_INFO_SPLIT
>
> config DEBUG_INFO_DWARF4
> 	bool "Generate dwarf4 debuginfo"
>-	depends on $(cc-option,-gdwarf-4)
> 	help
> 	  Generate dwarf4 debug info. This requires recent versions
> 	  of gcc and gdb. It makes the debug information larger.
>-- 
>2.30.0.284.gd98b1dd5eaa7-goog
>
