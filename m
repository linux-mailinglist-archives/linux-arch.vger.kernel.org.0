Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1B6B2D37
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 19:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCISzT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 13:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCISzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 13:55:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5D023645
        for <linux-arch@vger.kernel.org>; Thu,  9 Mar 2023 10:55:16 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id d10so1646284pgt.12
        for <linux-arch@vger.kernel.org>; Thu, 09 Mar 2023 10:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678388116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KFB3WZvPj45QQFE1vG91JPQ7IHpeNLpOum3l/eyO9A=;
        b=h59h3vE4/2ufFxQJ24xAYjQ7i6vDw3EWfYwoHOQUniZZgxYCC2dAvg7O9KNg4qB/+x
         fNJ+NOnKKj1iQLTXTBqPzpcXhTK+/9SZ4MkSEIoIFNjGV0kCAr3BEIU2xsm3C7FEdj+A
         T/XxUJI3yE96YUHGXzcl3NneJzDNKNf8d0TBlXmFWBCT0+wU0kagQR3JnRr+dN6ZvhYN
         8ReN8Ny1kOTBj0tXalrMuP3uRpkMMjxpE0gkZDV/sAcpMYA3kPTsJ7iYuY5BqM2aCYS+
         svz0XeMNtQEIWJet0C8FJZktTq3PE9u9q7hGuQL4WdFUgol4tP6+KITMRimE5edYQDc8
         dhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KFB3WZvPj45QQFE1vG91JPQ7IHpeNLpOum3l/eyO9A=;
        b=zs5EZBfh0H70Q1mNeFAYiz991r4jpEDjmHJUWAHLulNsWp+57omz3MWDMNeA5ERH8s
         fB6cXoLsP8bGTChQolJYqPLKKjatqBJDmGzyd+LtsTYj28q/Y89mr4rrRVN2gNUj2Bya
         KZWy5+sGSAj3adExvApDXK6giRTmxbGhXfFy44ozOnwFD5ytllv5k4fn5tRojz0uX+AL
         ep0OIyc4vUebEheXJx/xPr4oS2kUY73m/PuYuMmEn5p2gKsUJmcKkbsBMpH/Vs3B4DAF
         xVlslMx2d/FuvzPcq7Wowo5fikyfE6FADLOLvLMBBVyoIUlU+603vqpoQDL9Yjr6Qdf1
         cY+g==
X-Gm-Message-State: AO0yUKVbnsx4jT3FDhkv+ZU8WNHqieodRz30cdbYriCP0nDgWBbkj4Wm
        b1sM+cSP/k1P0praREcn3A09nA==
X-Google-Smtp-Source: AK7set/1H5/0frCN8PzNRC2CTwJPM7bfZzkBZoC0SUtpBiwsmBbJNbV+PGyPeJ21Szf11t5mXLGWBQ==
X-Received: by 2002:a62:7b0c:0:b0:61d:e8bb:1cb0 with SMTP id w12-20020a627b0c000000b0061de8bb1cb0mr4545332pfc.1.1678388115841;
        Thu, 09 Mar 2023 10:55:15 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id i2-20020aa787c2000000b005b34d81b010sm11804401pfo.91.2023.03.09.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:55:15 -0800 (PST)
Date:   Thu, 9 Mar 2023 10:55:11 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, nd@arm.com, al.grant@arm.com
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Message-ID: <20230309185511.GA1964069@debug.ba.rivosinc.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-34-rick.p.edgecombe@intel.com>
 <ZADbP7HvyPHuwUY9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZADbP7HvyPHuwUY9@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 02, 2023 at 05:22:07PM +0000, Szabolcs Nagy wrote:
>The 02/27/2023 14:29, Rick Edgecombe wrote:
>> Previously, a new PROT_SHADOW_STACK was attempted,
>...
>> So rather than repurpose two existing syscalls (mmap, madvise) that don't
>> quite fit, just implement a new map_shadow_stack syscall to allow
>> userspace to map and setup new shadow stacks in one step. While ucontext
>> is the primary motivator, userspace may have other unforeseen reasons to
>> setup it's own shadow stacks using the WRSS instruction. Towards this
>> provide a flag so that stacks can be optionally setup securely for the
>> common case of ucontext without enabling WRSS. Or potentially have the
>> kernel set up the shadow stack in some new way.
>...
>> The following example demonstrates how to create a new shadow stack with
>> map_shadow_stack:
>> void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);
>
>i think
>
>mmap(addr, size, PROT_READ, MAP_ANON|MAP_SHADOW_STACK, -1, 0);
>
>could do the same with less disruption to users (new syscalls
>are harder to deal with than new flags). it would do the
>guard page and initial token setup too (there is no flag for
>it but could be squeezed in).

Discussion on this topic in v6
https://lore.kernel.org/all/20230223000340.GB945966@debug.ba.rivosinc.com/

Again I know earlier CET patches had protection flag and somehow due to pushback
on mailing list, it was adopted to go for special syscall because no one else
had shadow stack.

Seeing a response from Szabolcs, I am assuming arm4 would also want to follow
using mmap to manufacture shadow stack. For reference RFC patches for risc-v shadow stack,
use a new protection flag = PROT_SHADOWSTACK.
https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/

I know earlier discussion had been that we let this go and do a re-factor later as other
arch support trickle in. But as I thought more on this and I think it may just be
messy from user mode point of view as well to have cognition of two different ways of
creating shadow stack. One would be special syscall (in current libc) and another `mmap`
(whenever future re-factor happens)

If it's not too late, it would be more wise to take `mmap`
approach rather than special `syscall` approach.


>
>most of the mmap features need not be available (EINVAL) when
>MAP_SHADOW_STACK is specified.
>
>the main drawback is running out of mmap flags so extension
>is limited. (but the new syscall has limitations too).
