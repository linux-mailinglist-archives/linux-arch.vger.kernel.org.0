Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF93B2078E2
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404874AbgFXQQt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404829AbgFXQQr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 12:16:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B27C0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 09:16:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g17so1224272plq.12
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r9Atz1n5S97FsyRtwbW9FxEwVR3HptLSj7YkFtdgBWc=;
        b=IOKX5uP5HrCSDaBldb1Tlqjq7QjS/iWV7iYPBJGBjm5MBfZlGZ65fHIb7gwqwcoeRw
         dpXx4RbkMXKmlmUkJyMmOhKjGP7uq2faKSrJkx0pPbJOJB7HDj5gJYJ2qr85eHA/cnXV
         H6UkqiZT7Hf4A7Y6EJAKS9VnW6TG4YJJIJmC+zN1+gKqnpwjbbJGFpXjQv5PDJQkvtpY
         D/il9Ds6lNa0aRabxw+vMLX7xAiBD/HhgWYaeid2aqPseFEPjLtTY//si6OJ/tdrxJqy
         ei45oSHSPuORVmZon0PcThpNgkP0FKv3aL/MUReCE1NqPG/qnNGcmVu2OID8z6Gczdpa
         L/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r9Atz1n5S97FsyRtwbW9FxEwVR3HptLSj7YkFtdgBWc=;
        b=kHjjCzjTNKa+WHrtKWU+LBwwLHpwCv4YJjx7QJ/mZLxfkNy+GV30w/j8Z57ZArXWRQ
         uEl1nWcjMuvFqZpzFSwTAP15PEYP44EKLjKmjAwhKTUnuawofF7kaK1s+Ds/K2pMv6On
         ARbF/1g9LpYn+gjIYrhqOw33n2vBFe0Nnlb81l9y29YhBNP4A/dTx+98v7TSgjjljC3h
         wWa0NfVtmrzIT0/Q2dx2OhsloVOl1KagT7ZdCePSFmoZtr1pUFkpvQPIwZPw0iNYcjT9
         srB1B/lrJj4uMpLo5pE4qvbjL8xf3xW/zDppN3B22ilR/v0tq6o+7ZKWr2E9Fl1WokwR
         kgkw==
X-Gm-Message-State: AOAM530FfCQNt5kfwgsdF6Ll1GyI2ArkJInjMwXMafyUdA+eccE3Jzt9
        NT7bBGVCoUJj5+7q3+EjlqgxAw==
X-Google-Smtp-Source: ABdhPJzR5oxdlp9qxvLSBQa9QdrzRcyjkIYkFPOJwAujW1umQ1cg0Dv9Hmvl7bclAIhrUSrRff3SUA==
X-Received: by 2002:a17:90a:7c4e:: with SMTP id e14mr29364901pjl.175.1593015406860;
        Wed, 24 Jun 2020 09:16:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id oc6sm6480133pjb.43.2020.06.24.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 09:16:46 -0700 (PDT)
Date:   Wed, 24 Jun 2020 09:16:43 -0700
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
Message-ID: <20200624161643.73x6navnwryckuit@google.com>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-3-keescook@chromium.org>
 <20200624153930.GA1337895@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200624153930.GA1337895@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2020-06-24, Arvind Sankar wrote:
>On Tue, Jun 23, 2020 at 06:49:33PM -0700, Kees Cook wrote:
>> When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
>> and .shstrtab are listed as orphaned. Add them to the STABS_DEBUG section
>> so there will be no warnings when --orphan-handling=warn is used more
>> widely. (They are added above comment as it is the more common
>
>Nit 1: is "after .comment" better than "above comment"? It's above in the
>sense of higher file offset, but it's below in readelf output.

I mean this order:)

   .comment
   .symtab
   .shstrtab
   .strtab

This is the case in the absence of a linker script if at least one object file has .comment (mostly for GCC/clang version information) or the linker is LLD which adds a .comment

>Nit 2: These aren't actually debugging sections, no? Is it better to add
>a new macro for it, and is there any plan to stop LLD from warning about
>them?

https://reviews.llvm.org/D75149 "[ELF] --orphan-handling=: don't warn/error for unused synthesized sections"
described that .symtab .shstrtab .strtab are different in GNU ld.
Since many other GNU ld synthesized sections (.rela.dyn .plt ...) can be renamed or dropped
via output section descriptions, I don't understand why the 3 sections
can't be customized.

I created a feature request: https://sourceware.org/bugzilla/show_bug.cgi?id=26168
(If this is supported, it is a consistent behavior to warn for orphan
.symtab/.strtab/.shstrtab

There may be 50% chance that the maintainer decides that "LLD diverges"
I would disagree: there is no fundamental problems with .symtab/.strtab/.shstrtab which make them special in output section descriptions or orphan handling.)

>> order[1].)
>>
>> ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
>> ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
>> ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
>>
>> [1] https://lore.kernel.org/lkml/20200622224928.o2a7jkq33guxfci4@google.com/
>>
>> Reported-by: Fangrui Song <maskray@google.com>
>> Reviewed-by: Fangrui Song <maskray@google.com>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  include/asm-generic/vmlinux.lds.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index 1248a206be8d..8e71757f485b 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -792,7 +792,10 @@
>>  		.stab.exclstr 0 : { *(.stab.exclstr) }			\
>>  		.stab.index 0 : { *(.stab.index) }			\
>>  		.stab.indexstr 0 : { *(.stab.indexstr) }		\
>> -		.comment 0 : { *(.comment) }
>> +		.comment 0 : { *(.comment) }				\
>> +		.symtab 0 : { *(.symtab) }				\
>> +		.strtab 0 : { *(.strtab) }				\
>> +		.shstrtab 0 : { *(.shstrtab) }
>>
>>  #ifdef CONFIG_GENERIC_BUG
>>  #define BUG_TABLE							\
>> --
>> 2.25.1
>>
