Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2CA2F8827
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 23:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbhAOWGN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 17:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbhAOWGM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 17:06:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ABFC061793
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 14:05:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 15so6886873pgx.7
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 14:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KN78Q17MGRiBbbDRSKVXa79TEYkMqvDyXwMUFINzonU=;
        b=oCaduNG4QbuGqwh1onPGbaLjRDDKevaN8DaXoeXbxEBsQU06c3p0l3GM/MONvKCJ5c
         /1cSKHx+XZbuoa+UIHkSdOEuOD7/3fw1qPb7jnl15lXWsQqck23jZr4tLw6L8VybNJFt
         EZVMNndQM4tIWKTavPqhTV2f7N5dvi0XqaaS0r8P/MD8fY6rFrpoSFDjEOsHKxZzreZ1
         f/U3T/Klvug/QInnPrKH5qv1Thnjtl2zcBgKuugefxx9nlUTvVYhof4VNChQwdtAfz4Q
         lEHpoF5fq2a86PwLM00GdEUXm3O01/JJJ7qB/n0Yt8z3krshDGlQvciROuYZNXBevYMi
         aXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KN78Q17MGRiBbbDRSKVXa79TEYkMqvDyXwMUFINzonU=;
        b=Mh5AgFZvnjNHZM0tCIm42A+73mtYudYWsiRqFjoPMj1l6AfVO9kIx6TszOyCcCwmVV
         tcnl4xCuH3qSIfAxyi0d93ruTWRHNtii4oZz4DjpIMKEvWVJfRj8qPtt/KvbP4MY1goX
         uL+ZOzzNzyAMgEhsspMAETi+TcNxMpbNi8YGiDt5tQEvZUCJEAJPzqtxxNNi0uPMmN27
         Hfz2lWvnTMOtvjA1c9oSysXIdNvrG7sX/1qHh/3p6As34LkSVlljUsenePM8SM/Wm6In
         HA8mbmRgCZxLNCQG1OtGXfS/Mew0C3HRUidMWTfhkzOfZyxSXsKj1Tf2pQAzrt0T2W4c
         ye+w==
X-Gm-Message-State: AOAM530+DF5rAkz2hOh9B+oldsNe9zfgT2bPjFfvFjzqNRa0vIDQnrfS
        4vLb3uqTx+EGMjOz4fK/ufiSRg==
X-Google-Smtp-Source: ABdhPJwzV8dwpmzdHcLPY+EwjPVL3iiv//cO15VZQnk6SRoMw1Uopnd4ioameiyB1W5rUWFsT1UNag==
X-Received: by 2002:aa7:9707:0:b029:19d:c5a8:155e with SMTP id a7-20020aa797070000b029019dc5a8155emr14810092pfg.62.1610748332125;
        Fri, 15 Jan 2021 14:05:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id x19sm502602pfp.207.2021.01.15.14.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:05:31 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:05:28 -0800
From:   Fangrui Song <maskray@google.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v5 2/3] Kbuild: make DWARF version a choice
Message-ID: <20210115220528.pyyr7hls2lgca3o7@google.com>
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-3-ndesaulniers@google.com>
 <CA+icZUXYFdrHQYkM6J5WajaP6zCBHB2gEnDt6p1W6gRsTk__Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+icZUXYFdrHQYkM6J5WajaP6zCBHB2gEnDt6p1W6gRsTk__Zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-01-15, Sedat Dilek wrote:
>On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
><ndesaulniers@google.com> wrote:
>>
>> Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
>> explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
>> way that's forward compatible with existing configs, and makes adding
>> future versions more straightforward.
>>
>> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
>> Suggested-by: Fangrui Song <maskray@google.com>
>> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> ---
>>  Makefile          | 13 ++++++-------
>>  lib/Kconfig.debug | 21 ++++++++++++++++-----
>>  2 files changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index d49c3f39ceb4..4eb3bf7ee974 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -826,13 +826,12 @@ else
>>  DEBUG_CFLAGS   += -g
>>  endif
>>
>> -ifneq ($(LLVM_IAS),1)
>> -KBUILD_AFLAGS  += -Wa,-gdwarf-2
>> -endif
>> -
>> -ifdef CONFIG_DEBUG_INFO_DWARF4
>> -DEBUG_CFLAGS   += -gdwarf-4
>> -endif
>> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
>> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
>> +DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
>> +# Binutils 2.35+ required for -gdwarf-4+ support.
>> +dwarf-aflag    := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
>> +KBUILD_AFLAGS  += $(dwarf-aflag)
>>
>>  ifdef CONFIG_DEBUG_INFO_REDUCED
>>  DEBUG_CFLAGS   += $(call cc-option, -femit-struct-debug-baseonly) \
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index dd7d8d35b2a5..e80770fac4f0 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -256,13 +256,24 @@ config DEBUG_INFO_SPLIT
>>           to know about the .dwo files and include them.
>>           Incompatible with older versions of ccache.
>>
>> +choice
>> +       prompt "DWARF version"
>
>Here you use "DWARF version" so keep this for v2 and v4.
>
>> +       help
>> +         Which version of DWARF debug info to emit.
>> +
>> +config DEBUG_INFO_DWARF2
>> +       bool "Generate DWARF Version 2 debuginfo"
>
>s/DWARF Version/DWARF version
>
>> +       help
>> +         Generate DWARF v2 debug info.
>> +
>>  config DEBUG_INFO_DWARF4
>> -       bool "Generate dwarf4 debuginfo"
>> +       bool "Generate DWARF Version 4 debuginfo"
>
>Same here: s/DWARF Version/DWARF version

DWARF Version 2 is fine and preferable.

I have checked DWARF Version 2/3/4/5 specifications.
"DWARF Version 2" is the official way that version is referred to...

>
>- Sedat -
>
>>         help
>> -         Generate dwarf4 debug info. This requires recent versions
>> -         of gcc and gdb. It makes the debug information larger.
>> -         But it significantly improves the success of resolving
>> -         variables in gdb on optimized code.
>> +         Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
>> +         It makes the debug information larger, but it significantly
>> +         improves the success of resolving variables in gdb on optimized code.
>> +
>> +endchoice # "DWARF version"
>>
>>  config DEBUG_INFO_BTF
>>         bool "Generate BTF typeinfo"
>> --
>> 2.30.0.284.gd98b1dd5eaa7-goog
>>
