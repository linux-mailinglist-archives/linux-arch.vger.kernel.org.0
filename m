Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB572F84E
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbjFNIvG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjFNIvB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 04:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1981BD2
        for <linux-arch@vger.kernel.org>; Wed, 14 Jun 2023 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686732618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5B5lUZSMuFMfr+ki8+YhMEK1JVBx4VqBUAAdrrVgwzA=;
        b=hxSN69zsSWGrEQJ5q9QLKHwy6wctoeLSJZ91Opv4NejCs3KBXrDzeFv5IdPUGwPv4Eesg9
        8aPbPwFCPK8657vDGHSQgH1T+4nz8X1OtKCyrM0P5fvr296cW/OwAosCHFTGyoIgtzp9Xo
        NVsqt3gyNR4XlmU6aRn4KN8r8OnPGcA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-oWrgbljQN22agwacmAISmA-1; Wed, 14 Jun 2023 04:50:09 -0400
X-MC-Unique: oWrgbljQN22agwacmAISmA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f76712f950so336913e87.0
        for <linux-arch@vger.kernel.org>; Wed, 14 Jun 2023 01:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732607; x=1689324607;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B5lUZSMuFMfr+ki8+YhMEK1JVBx4VqBUAAdrrVgwzA=;
        b=bRuSTY+pHYR6+fCzywnzTuZZ7qUT/RhTtZU6FcW/VaZARm9svcYc1H/SJ5DjfsMLkz
         9cDlDQMQ16AsZczrGPZmqQEcTMf2AoYBcZGp7jME10wr3Kiz4gajIQMbTSn0QhLbKI18
         vu9MHx43pJKpOWAhm3bh6A5Z+0eFxQQiTkoPlQLbcZWSJKuTvvUM4G9ITUOsxuyS10Vr
         //jmXp8XzOMEWsf5ibynRSYH6zEC+WO1AOoomvJVwgBxrHXaFC77ZyGsuytrsblYqYvg
         E4lvZ5rCqFfjU1nN0Equb2+c5NtLvuQ5hzatOr0PZkrz98syADMH55nUb5yqo7KK7SlO
         biSw==
X-Gm-Message-State: AC+VfDyN1vfsy4C8NEbEbbxujcMR+s4rf9GoVFOw0QlxoZUihVg8ULAm
        07nhrGpJtJHJ2/ocKZpLdC7EjkLEt4PUZTZDmQT/z4m+Vw7Bv0Onx+JCnTYjGJHPyq5MNbBNpSq
        y43zXjKfVB0Y0DgdpovHbiw==
X-Received: by 2002:a19:5001:0:b0:4f2:769a:120e with SMTP id e1-20020a195001000000b004f2769a120emr7189231lfb.2.1686732607637;
        Wed, 14 Jun 2023 01:50:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QcwYxgnMHB8zt+5nd3J5mySSLf2a3UMLrVPLHrR3mI+MG14rCyMyhPKMJcoHtf3oiHRZR5Q==
X-Received: by 2002:a19:5001:0:b0:4f2:769a:120e with SMTP id e1-20020a195001000000b004f2769a120emr7189170lfb.2.1686732607272;
        Wed, 14 Jun 2023 01:50:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003f7ec896cefsm16882043wmd.8.2023.06.14.01.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 01:50:06 -0700 (PDT)
Message-ID: <42a95041-e1a7-f343-8432-e2ce07af4e9e@redhat.com>
Date:   Wed, 14 Jun 2023 10:50:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 05/42] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
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
        debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Pengfei Xu <pengfei.xu@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-6-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613001108.3040476-6-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 13.06.23 02:10, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Future patches will introduce a new VM flag VM_SHADOW_STACK that will be
> VM_HIGH_ARCH_BIT_5. VM_HIGH_ARCH_BIT_1 through VM_HIGH_ARCH_BIT_4 are
> bits 32-36, and bit 37 is the unrelated VM_UFFD_MINOR_BIT. For the sake
> of order, make all VM_HIGH_ARCH_BITs stay together by moving
> VM_UFFD_MINOR_BIT from 37 to 38. This will allow VM_SHADOW_STACK to be
> introduced as 37.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/mm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9ec20cbb20c1..6f52c1e7c640 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -370,7 +370,7 @@ extern unsigned int kobjsize(const void *objp);
>   #endif
>   
>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> -# define VM_UFFD_MINOR_BIT	37
> +# define VM_UFFD_MINOR_BIT	38
>   # define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
>   #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>   # define VM_UFFD_MINOR		VM_NONE

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

