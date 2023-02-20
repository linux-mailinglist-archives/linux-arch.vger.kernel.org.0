Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34069CB87
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 13:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBTM7g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 07:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjBTM7f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 07:59:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C87465B4
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676897923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AKvjdo8vNmSKS+z7HPo/X/JWX/EOdQCIVgjr3Q6aZc=;
        b=MPpQr/fPELoz3eGJgrQzS337HzUUrUmSJtXHwe0/VI0tHFNqsSA0+2hlELGkZqR7P9JaEa
        N9JB3jK8D9iycXFr9PUUT+d4xgziSXUKF/73673UHaxBGtH/z1fhNA3L8bKe4ADex9zZF0
        EjJWL2QaU5fHMlAT540H5RmbN8Aqo7w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-19-sCjlRi4VPESx0Uz-W41SXw-1; Mon, 20 Feb 2023 07:58:42 -0500
X-MC-Unique: sCjlRi4VPESx0Uz-W41SXw-1
Received: by mail-wr1-f71.google.com with SMTP id i11-20020a5d584b000000b002c5400f5c76so253918wrf.14
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 04:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AKvjdo8vNmSKS+z7HPo/X/JWX/EOdQCIVgjr3Q6aZc=;
        b=1ns/9XzP+W9GwgcW0EYDGTJoBA5HBHVB/jCOFcN9BFWw9p+jZDe7gxMRuCJ/P0EA/g
         MOVFVdjB2Eeja/HS2gbwoQDVcm7S93RBi3J0br5OzXVZjt/Z7okRQmH/MZZd1nIUFBSk
         1c2MCHfDQkkoUPBdFCm52cx2Ck4QEy6YQM7ooA4Y1Uiu15m4yk8R2ENRQmTsoSyO+mxq
         FBUAHghdaG+rNJTN2h8HscU7UoiwsPdQgTNNo3WB2r0HZImBgixBRcgm3nhGn3l+Hcne
         5aFrk3EipzMiA9JR2XeB0bUN/rVtrEfGfdt5Cd4m4B4dwia8m9lzG2cUOFXeSuzVB+Xr
         Ec0g==
X-Gm-Message-State: AO0yUKUNkXy4ldPiA8Z4bw3ywdLYiZXT/TdH4Nt5Lxs3yCXVNOb8F3zr
        /RPPLpLVhf83gzOIXLiG6cxGIwWsNZfOeAYPMPrmtPallVGd2xKrHyhKb/isJmaYhwL7knYAA/+
        qfwPkh0Wfh+zWI1OSU2b2sQ==
X-Received: by 2002:a05:6000:1866:b0:2c4:669:fda4 with SMTP id d6-20020a056000186600b002c40669fda4mr629375wri.0.1676897921371;
        Mon, 20 Feb 2023 04:58:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/e+EH7H8iOfIcBc3Hls/umJBU/aGvav4lBivPqpX1AbbE4EERHr1HRg6ifH06VjqfdXoHU7w==
X-Received: by 2002:a05:6000:1866:b0:2c4:669:fda4 with SMTP id d6-20020a056000186600b002c40669fda4mr629366wri.0.1676897921034;
        Mon, 20 Feb 2023 04:58:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id z3-20020adff1c3000000b002c559def236sm76762wro.57.2023.02.20.04.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 04:58:40 -0800 (PST)
Message-ID: <6ccc8d30-336a-12af-1179-5dc4eca3048d@redhat.com>
Date:   Mon, 20 Feb 2023 13:58:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
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
        debug@rivosinc.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-23-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-23-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.02.23 22:14, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Account shadow stack pages to stack memory.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> v3:
>   - Remove unneeded VM_SHADOW_STACK check in accountable_mapping()
>     (Kirill)
> 
> v2:
>   - Remove is_shadow_stack_mapping() and just change it to directly bitwise
>     and VM_SHADOW_STACK.
> 
> Yu-cheng v26:
>   - Remove redundant #ifdef CONFIG_MMU.
> 
> Yu-cheng v25:
>   - Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping().
> ---
>   mm/mmap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 425a9349e610..9f85596cce31 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3290,6 +3290,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
>   		mm->exec_vm += npages;
>   	else if (is_stack_mapping(flags))
>   		mm->stack_vm += npages;
> +	else if (flags & VM_SHADOW_STACK)
> +		mm->stack_vm += npages;

Why not modify is_stack_mapping() ?

-- 
Thanks,

David / dhildenb

