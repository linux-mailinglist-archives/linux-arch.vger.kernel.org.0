Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ED267485D
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 01:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjATAz0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 19:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjATAzV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 19:55:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1E39F07B
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:55:19 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f3so2982954pgc.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXL29dhGPGSlxhwtfxK4fw+n68wsFSVNwNnLqn1osKM=;
        b=jZRlzywpwITHll2KRGT8ul5zgQzLQ5haL7RX7a1uWpmxk7IpWlL0sqakiUMkrLyS00
         GUweQNVDtxHmxEpAU10K778LVljDuRkRIfGg0M9wktSLRM0TM7hkTJZUF2qUVbCmrE0C
         qria/izb3rbVitx2JKW2eXnH48oGsSs+T9tPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXL29dhGPGSlxhwtfxK4fw+n68wsFSVNwNnLqn1osKM=;
        b=mAPbfwk82owdj6SGkghYwzQcfKu7NAvmISG5LOQCyYNqFGETPUD59a9kmILPcR6YSb
         OU4J1vdQ1dF1W1YvO32A08v29LH9yeLRxiDEkmvWs8s19Zna9YBloFSZiQ8LSHJ/DBr4
         0Xn9jXOHQjdH7mBHGI7+3xGm5qwH4aygTw1PGlcaWKW8z31jZzJKppAxQmWCuu0LAdJz
         nCJO/SRlMkHrb0tgY83ZICTkqdkiU0yNe+Hz667Y7snQOW6Tqgkb6UsCL9RD6iZytL5I
         gxxQE9F7L/Fhf4Mxpmkl9vYom7ERA+yzsYoGsAdNY0BUMiY+ZMdyWSMJsn7e6oPL+4eN
         MdFA==
X-Gm-Message-State: AFqh2kpcB1RUqsMeY9LgYnDi4yfEX58f9HBVNaSOSRyEc5feZA4FoIBv
        cjLwtutc9AfqCmYJNy1pgX0/Uw==
X-Google-Smtp-Source: AMrXdXv5B5/j+1dhLV2iD0PUpATQfFIclIsDHZkG7CDLuhZzZXjljtdmKU4p4Wj57OmeTr9d69neOA==
X-Received: by 2002:a05:6a00:21c9:b0:58d:f607:5300 with SMTP id t9-20020a056a0021c900b0058df6075300mr8819113pfj.8.1674176118791;
        Thu, 19 Jan 2023 16:55:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 65-20020a621844000000b005877d374069sm22336822pfy.10.2023.01.19.16.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:55:18 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:55:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v5 10/39] x86/mm: Introduce _PAGE_COW
Message-ID: <202301191655.97E3023EC@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-11-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-11-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:48PM -0800, Rick Edgecombe wrote:
> Some OSes have a greater dependence on software available bits in PTEs than
> Linux. That left the hardware architects looking for a way to represent a
> new memory type (shadow stack) within the existing bits. They chose to
> repurpose a lightly-used state: Write=0,Dirty=1. So in order to support
> shadow stack memory, Linux should avoid creating memory with this PTE bit
> combination unless it intends for it to be shadow stack.
> 
> The reason it's lightly used is that Dirty=1 is normally set by HW
> _before_ a write. A write with a Write=0 PTE would typically only generate
> a fault, not set Dirty=1. Hardware can (rarely) both set Dirty=1 *and*
> generate the fault, resulting in a Write=0,Dirty=1 PTE. Hardware which
> supports shadow stacks will no longer exhibit this oddity.
> 
> So that leaves Write=0,Dirty=1 PTEs created in software. To achieve this,
> in places where Linux normally creates Write=0,Dirty=1, it can use the
> software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY. In other
> words, whenever Linux needs to create Write=0,Dirty=1, it instead creates
> Write=0,Cow=1 except for shadow stack, which is Write=0,Dirty=1.
> Further differentiated by VMA flags, these PTE bit combinations would be
> set as follows for various types of memory:
> 
> (Write=0,Cow=1,Dirty=0):
>  - A modified, copy-on-write (COW) page. Previously when a typical
>    anonymous writable mapping was made COW via fork(), the kernel would
>    mark it Write=0,Dirty=1. Now it will instead use the Cow bit. This
>    happens in copy_present_pte().
>  - A R/O page that has been COW'ed. The user page is in a R/O VMA,
>    and get_user_pages(FOLL_FORCE) needs a writable copy. The page fault
>    handler creates a copy of the page and sets the new copy's PTE as
>    Write=0 and Cow=1.
>  - A shared shadow stack PTE. When a shadow stack page is being shared
>    among processes (this happens at fork()), its PTE is made Dirty=0, so
>    the next shadow stack access causes a fault, and the page is
>    duplicated and Dirty=1 is set again. This is the COW equivalent for
>    shadow stack pages, even though it's copy-on-access rather than
>    copy-on-write.
> 
> (Write=0,Cow=0,Dirty=1):
>  - A shadow stack PTE.
>  - A Cow PTE created when a processor without shadow stack support set
>    Dirty=1.
> 
> There are six bits left available to software in the 64-bit PTE after
> consuming a bit for _PAGE_COW. No space is consumed in 32-bit kernels
> because shadow stacks are not enabled there.
> 
> Implement only the infrastructure for _PAGE_COW. Changes to start
> creating _PAGE_COW PTEs will follow once other pieces are in place.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
