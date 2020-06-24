Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4B9207A39
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405524AbgFXR0Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 13:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405517AbgFXR0Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 13:26:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64F5C0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 10:26:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d6so1425254pjs.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MnQWlAViaAXgR6ChKk9flTU7iy/dP/Hqi3HZ30RWfcA=;
        b=HHUTbvXU8iaNylfrBu2tKAp6t8jvzwGxJv4iQWDRdjnhiP1bSVaMJy3y6z9hlDLo5j
         I3r9BcePoZxu3+e/4tWyl+hlZf6p8Dk3oi6OlIpMi2Bre5oCdOktwagNmvSvXj80p45/
         qBNen7/kYI5dyPaI7TzcMXBYWgXUQStxnApBoGkLKlQUqKFCWrKmo07mBmRdo2Uq2UAY
         SnhyDTWHaTW4W99fdN1AYeItiGEhnJVPXK8z9+1eONtpAatxhfK1DAjRnTnibVGkHFqt
         SVfUg2fkin8g64ceJ6gtvnSPvBarq4d7rDD5V6XBCFnHYOlfMrs3xzt1x+d3BckHFWC3
         AeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MnQWlAViaAXgR6ChKk9flTU7iy/dP/Hqi3HZ30RWfcA=;
        b=L0x8KeW5ZdcI6ezQcSZInPRNaiafhgcn9/1iA9SWEnjalF0XNx7Pw45mrt+de3xyMM
         9lLIDchfmutHOtXwhYFHHRriN0EftErubqK0ffqYzry0VN9+ZVmSzD+d4U96xsQfQs3i
         Y/HdERT7hGEhGrgy7VF7YoHoa5QwYrbGJF73tS0Xj7Y1/B9XWosul+ZxQn2wA42u2s/y
         f//A6tAx5l1w9R6DCOWzsS9/xvnl+fcmPmYL1n+L3jL41lTEErxBP+Qgrh2kMQ2h7qAF
         09v0xwdmMJYj9T7BYrH1tCXVWSE14WdCgcDt2FPcI8M7le3lNdVDbxt/6JXCNKDSLiif
         dupg==
X-Gm-Message-State: AOAM533/8NN3wtGwD2BWrW7IFvdL01OLNPaPhQ4T4qCtE4k+EOrq92eH
        5H2XGXenB8yfE3/KevAV6+IRpQ==
X-Google-Smtp-Source: ABdhPJy/02NChU1UMXqYAoZX4iMBIryqEQ4wkk5JgSfgSZouk+nUj0lvwCKX2dompigE5x6ivL/uXg==
X-Received: by 2002:a17:90a:f3d6:: with SMTP id ha22mr29151692pjb.193.1593019583946;
        Wed, 24 Jun 2020 10:26:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id i191sm21217005pfe.99.2020.06.24.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:26:22 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:26:20 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vmlinux.lds.h: Add .symtab, .strtab, and
 .shstrtab to STABS_DEBUG
Message-ID: <20200624172620.654hhjetiyzpgoxw@google.com>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-3-keescook@chromium.org>
 <20200624153930.GA1337895@rani.riverdale.lan>
 <20200624161643.73x6navnwryckuit@google.com>
 <20200624171121.GA1377921@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200624171121.GA1377921@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2020-06-24, Arvind Sankar wrote:
>On Wed, Jun 24, 2020 at 09:16:43AM -0700, Fangrui Song wrote:
>>
>> On 2020-06-24, Arvind Sankar wrote:
>> >On Tue, Jun 23, 2020 at 06:49:33PM -0700, Kees Cook wrote:
>> >> When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
>> >> and .shstrtab are listed as orphaned. Add them to the STABS_DEBUG section
>> >> so there will be no warnings when --orphan-handling=warn is used more
>> >> widely. (They are added above comment as it is the more common
>> >
>> >Nit 1: is "after .comment" better than "above comment"? It's above in the
>> >sense of higher file offset, but it's below in readelf output.
>>
>> I mean this order:)
>>
>>    .comment
>>    .symtab
>>    .shstrtab
>>    .strtab
>>
>> This is the case in the absence of a linker script if at least one object file has .comment (mostly for GCC/clang version information) or the linker is LLD which adds a .comment
>>
>> >Nit 2: These aren't actually debugging sections, no? Is it better to add
>> >a new macro for it, and is there any plan to stop LLD from warning about
>> >them?
>>
>> https://reviews.llvm.org/D75149 "[ELF] --orphan-handling=: don't warn/error for unused synthesized sections"
>> described that .symtab .shstrtab .strtab are different in GNU ld.
>> Since many other GNU ld synthesized sections (.rela.dyn .plt ...) can be renamed or dropped
>> via output section descriptions, I don't understand why the 3 sections
>> can't be customized.
>
>So IIUC, lld will now warn about .rela.dyn etc only if they're non-empty?

HEAD and future 11.0.0 will not warn about unused synthesized sections
like .rela.dyn

For most synthesized sections, empty = unused.

>>
>> I created a feature request: https://sourceware.org/bugzilla/show_bug.cgi?id=26168
>> (If this is supported, it is a consistent behavior to warn for orphan
>> .symtab/.strtab/.shstrtab
>>
>> There may be 50% chance that the maintainer decides that "LLD diverges"
>> I would disagree: there is no fundamental problems with .symtab/.strtab/.shstrtab which make them special in output section descriptions or orphan handling.)
>>
>
>.shstrtab is a little special in that it can't be discarded if the ELF
>file contains any sections at all. But yeah, there's no reason they
>can't be renamed or placed in a custom location in the file.

https://sourceware.org/pipermail/binutils/2020-March/000179.html
proposes -z nosectionheader. With this option, I believe .shstrtab is
not needed. /DISCARD/ : { *(.shstrtab) }  should achieve a similar effect.
