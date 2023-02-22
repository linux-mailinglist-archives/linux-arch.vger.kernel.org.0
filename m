Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255D669FE44
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 23:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjBVWOG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 17:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjBVWNn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 17:13:43 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE00C47429
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 14:13:36 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c32so5119519pgc.7
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 14:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbCbSZMDoolIYT4QTJLVLMs17uxD1iPtRBFug2ILkwU=;
        b=cg3FMFAJuPi2c8A7CQq/nKwBx0D1yuWtBSTFipKwbm37PB7JPMt6VRIcZf0lJ+HlNx
         y6U+XsxuwVdAbzt6Qp4UA6rpXOMpRum4XkQvLx2s54YYOsMrpX+PwJDKFbr9qFwOZDqs
         ZKVNjwmhE2KCDfh7MIFEUpU3LEj0h7ML8m+oYXdEKJhTv9hy9gc4w72j5+tx83vU2t7g
         mOPDCHHVxaUeKtbERi4NLvScRG2IakMiXN8m53KCwQyGjBxDSkhczUtmBX6EN3dlgi8/
         j758QR7+YMgV5CRAMKphCigP1SaYUyDuK8hKY6YrrwXqElaGNEGn9r4yQ+aFePJk/i68
         ebag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbCbSZMDoolIYT4QTJLVLMs17uxD1iPtRBFug2ILkwU=;
        b=AN74QWOZdrN30cemAeBsC5Nt/hoEIvpEOkk2kY93SGtZ7/lbMZiqtqQLny+7HMpE+t
         AH1ovDR47d0JL93PKTcPGLiav16QmyZHl1/foriHH0pfnIWBsiUsvgP9t/RgssH3XasN
         jlSDs2eO+/oHlXoHLoLQg72jhnAgTaOUuuCL5j0+yP8iKYJruvmUF+fporlIi80iGQyz
         d4gEyuRdtVIEWWV+VYCBKh3/hF4gB9h3Py53qK4aCRdA8/+XeEwd/jQ1KeM2MZ8WkCgS
         oCkrvD1stKDTyel3dHZiWtoMsXPTTIF2HNgBdLQkVplznuZSoEMUl+wCpFUqFZywrOKy
         Udiw==
X-Gm-Message-State: AO0yUKXHHjYPCOVjIyslWLBYs+BTOT04evMUIXmFSOLsXC3MJQdkYOt7
        u7odKRPyEyLculPozJ5zKJ/xLw==
X-Google-Smtp-Source: AK7set9H/13butg6xLlG1KNCEtebGT6HdRa76qfXxIkiBRaYjFkm+4KsL1gIBDSnN+I8dUYeXvdEDQ==
X-Received: by 2002:aa7:9407:0:b0:5a9:ea47:cd00 with SMTP id x7-20020aa79407000000b005a9ea47cd00mr8932796pfo.17.1677104016042;
        Wed, 22 Feb 2023 14:13:36 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id k7-20020aa792c7000000b0058d92d6e4ddsm4895952pfa.5.2023.02.22.14.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:13:35 -0800 (PST)
Date:   Wed, 22 Feb 2023 14:13:33 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 18/41] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Message-ID: <20230222221333.GA945966@debug.ba.rivosinc.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-19-rick.p.edgecombe@intel.com>
 <366c0af9-850f-24b1-3133-976fa92c51e2@redhat.com>
 <9e25a24f3783f3960e2c1e5e68a6c6fdf3d89442.camel@intel.com>
 <ef855af5-6a77-55d4-6e54-1e83d2e112a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ef855af5-6a77-55d4-6e54-1e83d2e112a0@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 21, 2023 at 09:34:35AM +0100, David Hildenbrand wrote:
>On 20.02.23 23:08, Edgecombe, Rick P wrote:
>>On Mon, 2023-02-20 at 13:56 +0100, David Hildenbrand wrote:
>>>On 18.02.23 22:14, Rick Edgecombe wrote:
>>>>From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>>>
>>>>The x86 Control-flow Enforcement Technology (CET) feature includes
>>>>a new
>>>>type of memory called shadow stack. This shadow stack memory has
>>>>some
>>>>unusual properties, which requires some core mm changes to function
>>>>properly.
>>>>
>>>>A shadow stack PTE must be read-only and have _PAGE_DIRTY set.
>>>>However,
>>>>read-only and Dirty PTEs also exist for copy-on-write (COW) pages.
>>>>These
>>>>two cases are handled differently for page faults. Introduce
>>>>VM_SHADOW_STACK to track shadow stack VMAs.
>>>
>>>I suggest simplifying and abstracting that description.
>>>
>>>"New hardware extensions implement support for shadow stack memory,
>>>such
>>>as x86 Control-flow Enforcement Technology (CET). Let's add a new VM
>>>flag to identify these areas, for example, to be used to properly
>>>indicate shadow stack PTEs to the hardware."
>>
>>Ah yea, that top blurb was added to all the non-x86 arch patches after
>>some feedback from Andrew Morton. He had said basically (in some more
>>colorful language) that the changelogs (at the time) were written
>>assuming the reader knows what a shadow stack is.
>
>Okay. It's a bit repetitive, though.
>
>Ideally, we'd just explain it in the cover letter in detail and 
>Andrews's script would include the cover letter in the first commit. 
>IIRC, that's what usually happens.
>
>>
>>So it might be worth keeping a little more info in the log?
>
>Copying the same paragraph into each commit is IMHO a bit repetitive. 
>But these are just my 2 cents.
>
>[...]
>
>>>Should we abstract this to CONFIG_ARCH_USER_SHADOW_STACK, seeing
>>>that
>>>other architectures might similarly need it?
>>
>>There was an ARCH_HAS_SHADOW_STACK but it got removed following this
>>discussion:
>>
>>https://lore.kernel.org/lkml/d09e952d8ae696f687f0787dfeb7be7699c02913.camel@intel.com/
>>
>>Now we have this new RFC for riscv as potentially a second
>>implementation. But it is still very early, and I'm not sure anyone
>>knows exactly what the similarities will be in a mature version. So I
>>think it would be better to refactor in an ARCH_HAS_SHADOW_STACK later
>>(and similar abstractions) once that series is more mature and we have
>>an idea of what pieces will be shared. I don't have a problem in
>>principle with an ARCH config, just don't think we should do it yet.
>
>Okay, easy to factor out later.

I would be more than happy if this config name would've been abstracted out and arches can
choose to implement. It's a bit sad that it was generic earlier and was later changed due
to lack of support from other architectures. Now there are three architectures who either
already support shadow stack (x86), announced the support (aarch64) or are planning to
support (riscv).

However given patch reduction I will get due to `pte_mkwrite` refactor, I am in favor of
future refactor for config.
>
>Acked-by: David Hildenbrand <david@redhat.com>
>
>-- 
>Thanks,
>
>David / dhildenb
>
