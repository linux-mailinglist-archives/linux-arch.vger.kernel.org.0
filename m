Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6D21F0CC
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgGNMQt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 08:16:49 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40297 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728471AbgGNMQs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 08:16:48 -0400
Received: from [192.168.0.4] (ip5f5af29b.dynamic.kabel-deutschland.de [95.90.242.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B7E0220643C4C;
        Tue, 14 Jul 2020 14:16:44 +0200 (CEST)
Subject: Re: [PATCH 00/22] add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        x86@kernel.org
References: <20200624203200.78870-1-samitolvanen@google.com>
 <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
 <CABCJKuedpxAqndgL=jHT22KtjnLkb1dsYaM6hQYyhqrWjkEe6A@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <2ac9e722-949b-aa92-3553-df1bf69bf9e5@molgen.mpg.de>
Date:   Tue, 14 Jul 2020 14:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABCJKuedpxAqndgL=jHT22KtjnLkb1dsYaM6hQYyhqrWjkEe6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dear Sami,


Am 13.07.20 um 01:34 schrieb Sami Tolvanen:
> On Sat, Jul 11, 2020 at 9:32 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>> Thank you very much for sending these changes.
>>
>> Do you have a branch, where your current work can be pulled from? Your
>> branch on GitHub [1] seems 15 months old.
> 
> The clang-lto branch is rebased regularly on top of Linus' tree.
> GitHub just looks at the commit date of the last commit in the tree,
> which isn't all that informative.

Thank you for clearing this up, and sorry for not checking myself.

>> Out of curiosity, I applied the changes, allowed the selection for i386
>> (x86), and with Clang 1:11~++20200701093119+ffee8040534-1~exp1 from
>> Debian experimental, it failed with `Invalid absolute R_386_32
>> relocation: KERNEL_PAGES`:
> 
> I haven't looked at getting this to work on i386, which is why we only
> select ARCH_SUPPORTS_LTO for x86_64. I would expect there to be a few
> issues to address.
> 
>>>    arch/x86/tools/relocs vmlinux > arch/x86/boot/compressed/vmlinux.relocs;arch/x86/tools/relocs --abs-relocs vmlinux
>>> Invalid absolute R_386_32 relocation: KERNEL_PAGES
> 
> KERNEL_PAGES looks like a constant, so it's probably safe to ignore
> the absolute relocation in tools/relocs.c.

Thank you for pointing me to the right direction. I am happy to report, 
that with the diff below (no idea to what list to add the string), Linux 
5.8-rc5 with the LLVM/Clang/LTO patches on top, builds and boots on the 
ASRock E350M1.

```
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 8f3bf34840cef..e91af127ed3c0 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -79,6 +79,7 @@ static const char * const 
sym_regex_kernel[S_NSYMTYPES] = {
         "__end_rodata_hpage_align|"
  #endif
         "__vvar_page|"
+       "KERNEL_PAGES|"
         "_end)$"
  };
```


Kind regards,

Paul
