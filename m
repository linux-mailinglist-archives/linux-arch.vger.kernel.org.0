Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E06204452
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 01:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgFVXPl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 19:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbgFVXPl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 19:15:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8058C061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:15:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p11so440796pff.11
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8ffW2wUqNPKCctA4KQ6FwdGe8r/TZEjq1PeDi/0NFK0=;
        b=GlEhc70tdhL49iFtKY6F5A2HLSZ6Nn50tCeFu2kaMvTNZM35VupKPqb8ILvJBqcgzD
         g9AunA0OO8zrexaCntdxguDr9bb9Un+Y/zuuICMSarL/X4zO8tworfy0xAL6E68lXQPW
         RpQ+mlpTtMYKExX9fEzesbuuB49zTy9mq0r5OTvCRLepMbClRi8zR+3Fz7mcD7rhY2tK
         bLW1N3EU/cObSf88kIGVdWPoMubg6fJx9cwGSMgFiSIGD5b5o059pCNobF5G7LSQIpXC
         CTQO71Wqk32OnnAcOyU3u6p8P7lwWEOTG6hdZbuj+tuUC8WQkQyP4wDweRvCCk4U4Ct8
         JJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8ffW2wUqNPKCctA4KQ6FwdGe8r/TZEjq1PeDi/0NFK0=;
        b=lzHGLW6aM+zmH5QWSD6PfrLG8TbSRYVRypY/5NUArJe7BZO8luw7VVFL9l8YXvPmYw
         AULN3TQUfA2iyCCHL5NQrrxd0PfjS35GqMwokg2zW0j6r165pn6SuxxSnasR25NCkEJV
         9fv1y/ocAnYm0nJeDVUC2+XKZ9rohciF6kTEXItMNVUXzNsavdKOIzPlBXo6y4GBKglB
         ZlwEgljUH35UN1aNM2YGf+yOFBY7E7mYGh/OxpjBCLwrRHsctJq+33+vThUQIaXCNXwM
         W0Fm1pA9QdR1vAI5Ot1Uo5csgYlCs0Jux4Irb19eFLTfcrsm3Q86X3PntEqSyN+LanbQ
         hFsw==
X-Gm-Message-State: AOAM533BV2CoTwHW8gt9mj3DVQih40gcCLMrcOGsL82uufcKKWdNx74/
        R17yue7Kx1JvrId2sdEOaTol4g==
X-Google-Smtp-Source: ABdhPJwMB531qddra4+QBFxIKie7qQPWZ5+ksC7ABlaLqh0dyoEbJom3LN9U9cRYe8OSxoSWC7b1Fw==
X-Received: by 2002:a63:4c48:: with SMTP id m8mr15136063pgl.290.1592867740181;
        Mon, 22 Jun 2020 16:15:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id 6sm14829509pfi.170.2020.06.22.16.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:15:39 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:15:36 -0700
From:   =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        "# 3.4.x" <stable@vger.kernel.org>, Jian Cai <jiancai@google.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmlinux.lds: consider .text.{hot|unlikely}.* part of
 .text too
Message-ID: <20200622231536.7jcshis5mdn3vr54@google.com>
References: <20200617210613.95432-1-ndesaulniers@google.com>
 <20200617212705.tq2q6bi446gydymo@google.com>
 <CAKwvOdniambW9_nVbDnd4A_+bdDdZMd2V1Q=Xw5EJYDGeh=eyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdniambW9_nVbDnd4A_+bdDdZMd2V1Q=Xw5EJYDGeh=eyQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-06-22, Nick Desaulniers wrote:
>On Wed, Jun 17, 2020 at 2:27 PM Fāng-ruì Sòng <maskray@google.com> wrote:
>>
>>
>> On 2020-06-17, Nick Desaulniers wrote:
>> >ld.bfd's internal linker script considers .text.hot AND .text.hot.* to
>> >be part of .text, as well as .text.unlikely and .text.unlikely.*.
>>
>> >ld.lld will produce .text.hot.*/.text.unlikely.* sections.
>>
>> Correction to this sentence. lld is not relevant here.
>>
>> -ffunction-sections combined with profile-guided optimization can
>> produce .text.hot.* .text.unlikely.* sections.  Newer clang may produce
>> .text.hot. .text.unlikely. (without suffix, but with a trailing dot)
>> when -fno-unique-section-names is specified, as an optimization to make
>> .strtab smaller.
>
>Then why was the bug report reporting https://reviews.llvm.org/D79600
>as the result of a bisection, if LLD is not relevant?  Was the
>bisection wrong?

https://reviews.llvm.org/D79600 is an LLVM codegen change, unrelated to LLD..
(As described in the patch, LLD's -z keep-text-section-prefix only
recognizes ".text.exit.*", not ".text.exit")

>The upstream report wasn't initially public, for no good reason.  So I
>didn't include it, but if we end up taking v1, this should have
>
>Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1084760

Thanks for making it public.

>The kernel doesn't use -fno-unique-section-names; is that another flag
>that's added by CrOS' compiler wrapper?
>https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/toolchain-utils/compiler_wrapper/config.go;l=110
>Looks like no.  It doesn't use `-fno-unique-section-names` or
>`-ffunction-sections`.

-fno-unique-section-names is a very rare option. It is not supported by GCC (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95095 ).
clang users use it very rarely, probably because not many people care
about additional strings taken by section names ".text.hot.a" ".text.hot.b" ".text.hot.c"
in the string table ".strtab" (clang since some point of 2018 uses
.strtab instead of .shstrtab which enables more string sharing).

>
>

>
>>
>> We've already seen that GCC can place main in .text.startup without
>> -ffunction-sections. There may be other non -ffunction-sections cases
>> for .text.hot.* or .text.unlikely.*. So it is definitely a good idea to
>> be more specific even if we don't care about -ffunction-sections for
>> now.
>>
>> >Make sure to group these together.  Otherwise these orphan sections may
>> >be placed outside of the the _stext/_etext boundaries.
>> >
>> >Cc: stable@vger.kernel.org
>> >Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=add44f8d5c5c05e08b11e033127a744d61c26aee
>> >Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1de778ed23ce7492c523d5850c6c6dbb34152655
>> >Link: https://reviews.llvm.org/D79600
>> >Reported-by: Jian Cai <jiancai@google.com>
>> >Debugged-by: Luis Lozano <llozano@google.com>
>> >Suggested-by: Fāng-ruì Sòng <maskray@google.com>
>> >Tested-by: Luis Lozano <llozano@google.com>
>> >Tested-by: Manoj Gupta <manojgupta@google.com>
>> >Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> >---
>> > include/asm-generic/vmlinux.lds.h | 4 +++-
>> > 1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> >index d7c7c7f36c4a..fe5aaef169e3 100644
>> >--- a/include/asm-generic/vmlinux.lds.h
>> >+++ b/include/asm-generic/vmlinux.lds.h
>> >@@ -560,7 +560,9 @@
>> >  */
>> > #define TEXT_TEXT                                                     \
>> >               ALIGN_FUNCTION();                                       \
>> >-              *(.text.hot TEXT_MAIN .text.fixup .text.unlikely)       \
>> >+              *(.text.hot .text.hot.*)                                \
>> >+              *(TEXT_MAIN .text.fixup)                                \
>> >+              *(.text.unlikely .text.unlikely.*)                      \
>> >               NOINSTR_TEXT                                            \
>> >               *(.text..refcount)                                      \
>> >               *(.ref.text)                                            \
>> >--
>> >2.27.0.290.gba653c62da-goog
>> >
>
>
>
>--
>Thanks,
>~Nick Desaulniers
