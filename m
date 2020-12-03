Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2D2CDFB1
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgLCU2X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 15:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgLCU2X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 15:28:23 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA4C061A4F
        for <linux-arch@vger.kernel.org>; Thu,  3 Dec 2020 12:27:42 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v1so1743759pjr.2
        for <linux-arch@vger.kernel.org>; Thu, 03 Dec 2020 12:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6c6iTUosRVrmzGiP/7D9+PLxepmiQNzcidmSqRByqjY=;
        b=P5vIYvPKNrqAHbY+37GxHogE+dsicUpBmvZgrwQHiqxH1dN/QDFkNS4CHeqX0Klynh
         RPpodRunirGMRa1lbe22VFDlAne/i4zyDGOLxn6tThQN3JMOCkGOe4QMgEsT4rzB2xzU
         NJ+rv9emMXNv5oCTFgKJk9NONjPuYP5XC7FppqfCfhcBKEPF2Weu5X3QFVLM/OSTbuka
         RdNracu5rjrrEeZ6ivk71nZ0I9X/HLaNl9ndqba4TQtG7dqrQuvnTZimGzHOceasfjXp
         uGg7Bp57PhU7d9REcSV+IixxlQibyidOAdEfQqcJC5M6ChGWMGXy21ztAvQWsO0DSa4a
         tSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6c6iTUosRVrmzGiP/7D9+PLxepmiQNzcidmSqRByqjY=;
        b=a25u7rdz7wdlQ5rkxpyRkDSHfX+HuyXFqcd1g4XbLDcXN6gHWRSIR/PQAQCdvV3ZBD
         eIyOG/PUwp5ULK98ciIJuX1BR5f5zNeNMY+K4cjpGMgk2lPfkYwAWIuDohh+zySHDOz/
         PVsjLE3bovq0taGompJRBbuI7MYsK6FiISQTlfzf2JIh9Ke1oDOGbLdm/isiQVPAHHer
         PZ/D5bk4xyVcpG/5W1ZfYEiAgyFzlVxAu/dHtsEF3o0Hf70k0m2mOWartUlg1uBtCBn8
         WVONNjbN0wpYQKRH6Kp0HOgVg4YrQPss4qq5uVEUO7QXRi9IpOqab42G4jU6U+YNUT6y
         aVGQ==
X-Gm-Message-State: AOAM530gGe6R6a84FnY4pfmUJzrpBg3TbXbqrtkot1bqvTLMMcyAcIQ3
        c+TDLzBqd8E+kt9X2MuTo9BCEQ==
X-Google-Smtp-Source: ABdhPJx6QkUBqweo7oQdPA48Ai0FtNZPUHQPt5H2J3HGuEr+QdVmoNFtgjOXybM803OsnuHkeTZtwQ==
X-Received: by 2002:a17:902:b7c3:b029:da:76bc:2aa9 with SMTP id v3-20020a170902b7c3b02900da76bc2aa9mr671331plz.21.1607027262306;
        Thu, 03 Dec 2020 12:27:42 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id o14sm2008267pgh.1.2020.12.03.12.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:27:41 -0800 (PST)
Date:   Thu, 3 Dec 2020 12:27:37 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>, dwmw@amazon.co.uk,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] firmware_loader: Align .builtin_fw to 8
Message-ID: <20201203202737.7c4wrifqafszyd5y@google.com>
References: <20201203170529.1029105-1-maskray@google.com>
 <CAKwvOd=8trq9qndYvf8KD4_3XVfaT_BXcNZhrKP67-YH9WQL0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOd=8trq9qndYvf8KD4_3XVfaT_BXcNZhrKP67-YH9WQL0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-12-03, Nick Desaulniers wrote:
>On Thu, Dec 3, 2020 at 9:05 AM Fangrui Song <maskray@google.com> wrote:
>>
>> arm64 references the start address of .builtin_fw (__start_builtin_fw)
>> with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
>> relocations. The compiler is allowed to emit the
>> R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
>> include/linux/firmware.h is 8-byte aligned.
>>
>> The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
>> multiple of 8, which may not be the case if .builtin_fw is empty.
>> Unconditionally align .builtin_fw to fix the linker error.
>>
>> Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1204
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Fangrui Song <maskray@google.com>
>> ---
>>  include/asm-generic/vmlinux.lds.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index b2b3d81b1535..3cd4bd1193ab 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -459,6 +459,7 @@
>>         }                                                               \
>>                                                                         \
>>         /* Built-in firmware blobs */                                   \
>> +       ALIGN_FUNCTION();                                               \
>
>Thanks for the patch!
>
>I'm going to repeat my question from the above link
>(https://github.com/ClangBuiltLinux/linux/issues/1204#issuecomment-737610582)
>just in case it's not naive:
>
>ALIGN_FUNCTION() C preprocessor macro seems to be used to realign
>code, while STRUCT_ALIGN() seems to be used to realign data.  It looks
>to me like only data is put into .builtin_fw.  If these relocations
>require an alignment of 8, than multiples of 8 should also be fine
>(STRUCT_ALIGN in 32 for all toolchain version, except gcc 4.9 which is
>64; both are multiples of 8 though).  It looks like only structs are
>placed in .builtin_fw; ie. data.  In that case, I worry that using
>ALIGN_FUNCTION/8 might actually be under-aligning data in this
>section.

Regarding STRUCT_ALIGN (32 for GCC>4.9) in
include/asm-generic/vmlinux.lds.h, it is probably not suitable for
.builtin_fw

* Its comment is a bit unclear. It probably should mention that the
   32-byte overalignment is only for global structure variables which are
   at least 32 byte large. But this is just my observation. Adding a GCC
   maintainer to comment on this.
* Even if GCC does overalign defined global struct variables, it is unlikely
   that GCC will leverage this property for undefined `extern struct
   builtin_fw __start_builtin_fw[]` (drivers/base/firmware_loader/main.c)

To make .builtin_fw aligned, I agree that ALIGN_FUNCTION() is probably a
misuse. Maybe I should just use `. = ALIGN(8)` if the kernel linker
script prefers `. = ALIGN(8)` to an output section alignment
(https://sourceware.org/binutils/docs/ld/Output-Section-Description.html#Output-Section-Description
https://lld.llvm.org/ELF/linker_script.html#output-section-alignment)

>Though, in https://github.com/ClangBuiltLinux/linux/issues/1204#issuecomment-737625134
>you're comment:
>
>>> In GNU ld, the empty .builtin_fw is removed
>
>So that's a difference in behavior between ld.bfd and ld.lld, which is
>fine, but it makes me wonder whether we should instead or additionally
>be discarding this section explicitly via linker script when
>CONFIG_FW_LOADER is not set?

Short answer: No, we should not discard .builtin_fw

   .builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {
   __start_builtin_fw = .; ... }

In LLD, either a section reference (`ADDR(.builtin_fw)`) or a
non-PROVIDE symbol assignment __start_builtin_fw makes the section non-discardable.

It can be argued that discarding an output section with a symbol
assignment (GNU ld) is strange because the symbol (st_shndx) will be
defined relative to an arbitrary unrelated section. Retaining the
section can avoid some other issues.

>>         .builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {      \
>>                 __start_builtin_fw = .;                                 \
>>                 KEEP(*(.builtin_fw))                                    \
>> --
>> 2.29.2.576.ga3fc446d84-goog
>>
>
>
>-- 
>Thanks,
>~Nick Desaulniers
