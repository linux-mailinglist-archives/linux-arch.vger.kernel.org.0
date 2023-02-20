Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23769CB7A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 13:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjBTM5C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 07:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBTM5B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 07:57:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD781C7DF
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 04:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676897772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnuE+FP8MqJnM8uTlOWJU43d7eAFCBGNdcoO7fkWHwc=;
        b=UUVPdhSzjB3Wd2Azpv6Pyf1jHGE6q3+LCtwSel5zHyqdiw5B7iDj7cRf/mBsA75k98+L59
        63sfmJlqM7U9JC/YfmLgKk0E/8MHRVR5iDP3O2VQTC7pXS/zfHhGTtMnUCkMgVNibytWgH
        S9vL6SQZZAl466dA8jcZef18bVdqrTI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-63-ZRVy-ig-OPOF9cNu9v8bzw-1; Mon, 20 Feb 2023 07:56:11 -0500
X-MC-Unique: ZRVy-ig-OPOF9cNu9v8bzw-1
Received: by mail-wm1-f70.google.com with SMTP id z6-20020a05600c220600b003e222c9c5f4so651028wml.4
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 04:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnuE+FP8MqJnM8uTlOWJU43d7eAFCBGNdcoO7fkWHwc=;
        b=EoAsU5mwhNNyM8nR/+AxXign4x70h0aR3OxZO3iHEVdbiKi21YZRyDjVSx9gJ/XTwS
         QKuKLOs6T8EE+Xe5QExA3JRff8YXKwbxOzTX0fKzFUk2St0AnP4UtdTsoOUGmq4JwWtS
         8hE4IJUkVRWmG4OILfaUMQCwYGI15r3pf5jset+HIhlWSb40ABrn0mjQUTMinTCaRoMz
         Jy/AiagxrQc0/YNZQDodw33vy3+XziX7arKF4/MglDcgzUUFgj8NmF/PQmWX7zv+Jbp0
         6pAmHFFPvbQE0iXXB3Qi6NAjT28SAHFelfoARX3LtVBWLANcY3kZUBeBcMZhLobltn2b
         Ntxg==
X-Gm-Message-State: AO0yUKVkYvRBjfWxPOyChOrjiSRPltMr3KbqhG/6xqkpKNCJJnT10NWN
        nDp9wjtrpo8FmjSwPLbd0f2eVo2A3+wTyxwPye8udd94ibihMZ24LWVa0+IFOhGUw3oVnb8g/Gu
        blhG5YUv42lCBpp8xpRslsA==
X-Received: by 2002:a5d:50c4:0:b0:2c5:5ef8:fa3c with SMTP id f4-20020a5d50c4000000b002c55ef8fa3cmr1664927wrt.52.1676897769884;
        Mon, 20 Feb 2023 04:56:09 -0800 (PST)
X-Google-Smtp-Source: AK7set+7AfOXUYCvAhkmGy5DFcawHWyJRb+ybm7J7bcPcMITmh6B+SZWusTYWwFFCaITyNI3WVqPfg==
X-Received: by 2002:a5d:50c4:0:b0:2c5:5ef8:fa3c with SMTP id f4-20020a5d50c4000000b002c55ef8fa3cmr1664890wrt.52.1676897769470;
        Mon, 20 Feb 2023 04:56:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d654e000000b002c5801aa9b0sm1906663wrv.40.2023.02.20.04.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 04:56:08 -0800 (PST)
Message-ID: <366c0af9-850f-24b1-3133-976fa92c51e2@redhat.com>
Date:   Mon, 20 Feb 2023 13:56:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 18/41] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
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
 <20230218211433.26859-19-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-19-rick.p.edgecombe@intel.com>
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
> A shadow stack PTE must be read-only and have _PAGE_DIRTY set. However,
> read-only and Dirty PTEs also exist for copy-on-write (COW) pages. These
> two cases are handled differently for page faults. Introduce
> VM_SHADOW_STACK to track shadow stack VMAs.

I suggest simplifying and abstracting that description.

"New hardware extensions implement support for shadow stack memory, such 
as x86 Control-flow Enforcement Technology (CET). Let's add a new VM 
flag to identify these areas, for example, to be used to properly 
indicate shadow stack PTEs to the hardware."

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> v6:
>   - Add comment about VM_SHADOW_STACK not being allowed with VM_SHARED
>     (David Hildenbrand)

Might want to add some more meat to the patch description why that is 
the case.

> 
> v3:
>   - Drop arch specific change in arch_vma_name(). The memory can show as
>     anonymous (Kirill)
>   - Change CONFIG_ARCH_HAS_SHADOW_STACK to CONFIG_X86_USER_SHADOW_STACK
>     in show_smap_vma_flags() (Boris)
> ---
>   Documentation/filesystems/proc.rst | 1 +
>   fs/proc/task_mmu.c                 | 3 +++
>   include/linux/mm.h                 | 8 ++++++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index e224b6d5b642..115843e8cce3 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -564,6 +564,7 @@ encoded manner. The codes are the following:
>       mt    arm64 MTE allocation tags are enabled
>       um    userfaultfd missing tracking
>       uw    userfaultfd wr-protect tracking
> +    ss    shadow stack page
>       ==    =======================================
>   
>   Note that there is no guarantee that every flag and associated mnemonic will
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index af1c49ae11b1..9e2cefe47749 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>   		[ilog2(VM_UFFD_MINOR)]	= "ui",
>   #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +		[ilog2(VM_SHADOW_STACK)] = "ss",
> +#endif
>   	};
>   	size_t i;
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e6f1789c8e69..76e0a09aeffe 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -315,11 +315,13 @@ extern unsigned int kobjsize(const void *objp);
>   #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
>   #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
>   #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
> +#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
>   #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
>   #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
>   #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
>   #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
>   #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> +#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
>   #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>   
>   #ifdef CONFIG_ARCH_HAS_PKEYS
> @@ -335,6 +337,12 @@ extern unsigned int kobjsize(const void *objp);
>   #endif
>   #endif /* CONFIG_ARCH_HAS_PKEYS */
>   
> +#ifdef CONFIG_X86_USER_SHADOW_STACK


Should we abstract this to CONFIG_ARCH_USER_SHADOW_STACK, seeing that 
other architectures might similarly need it?

-- 
Thanks,

David / dhildenb

