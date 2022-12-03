Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B2641365
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiLCCbQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbiLCCbP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:31:15 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D82DE1197
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:31:14 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so6668490pjj.4
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNJdEKc96rBGuItANfeOJmqGPSpLhwEduadMg72X9+I=;
        b=kXbx/zxPoqU2brUX0DUwi+fETzDpdoO6MchLW2gG+HaV3D/7RMyQboruFgqlHaf9l7
         nKvHOB/M1V0b/np2bfytJHetMFVIxhQ/PsQdMLv1ulc+LQCiUetldzoa6QLpEPjA/FrA
         HEUGEydrFepn5uv44DSxjg69QjmB/S+jEDqeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNJdEKc96rBGuItANfeOJmqGPSpLhwEduadMg72X9+I=;
        b=JwnGw4dFD79kJdDYZ/MnSoCIc4nmGFlbmQtvW1vp/2J0RJ5aKG/BcwR5ANUjwN1dFg
         Bd50Yd2354TF8oR9GqtH+TurDB8wEJBfjI4uN/dktDqJ4wEuA3/y6/aTMpKuyZs6orkg
         qlRL5fmuJVd9VuQw7yoU765yScHb7vDGFkAMLG24zIuVhZ5Yxd+eRsdLvgZ823QZnr67
         7iZWTZT9QckGjOHZdJ/eLlswdlf/oOL1Ku/o98ypgncCoIhxt1GCMyMSOAcqjTFZ2DLG
         s5dBw0Ji7CTi04jITxS95d1J7XfxSyfbpVhARtmILbxL/xNnD/4PbMmCdCUwfkWLH42N
         H0Dg==
X-Gm-Message-State: ANoB5pnbDZSqEt4CTUWHqgYle/+xZzSGQ/51une+vHLRyQUhRLz0cfdO
        to8XE+cMlQbHcH+l5cBMWNCNYA==
X-Google-Smtp-Source: AA0mqf57wxPc/IcFFwXPdN4t6wwPtuIbaiBBr+XKGhmHjfx+eusyVOWa3AYDyygGChHHhwdagn5RJA==
X-Received: by 2002:a17:90a:fb50:b0:219:5e9:f260 with SMTP id iq16-20020a17090afb5000b0021905e9f260mr42436295pjb.16.1670034674099;
        Fri, 02 Dec 2022 18:31:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79a49000000b0056b9df2a15esm117188pfj.62.2022.12.02.18.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:31:13 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:31:12 -0800
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
Subject: Re: [PATCH v4 10/39] x86/mm: Introduce _PAGE_COW
Message-ID: <202212021831.61BD0D9A5@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-11-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-11-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:37PM -0800, Rick Edgecombe wrote:
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
> This is a prepratory patch. Changes to actually start marking _PAGE_COW
> will follow once other pieces are in place.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
