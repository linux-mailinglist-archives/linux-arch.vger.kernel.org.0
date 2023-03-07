Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A06ADC33
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 11:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCGKoT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Mar 2023 05:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCGKns (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2023 05:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C84776A6
        for <linux-arch@vger.kernel.org>; Tue,  7 Mar 2023 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678185778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkSFfGl4soWJh275ABriCY4OJqXhUGnQB2a/+uhCoY0=;
        b=Ga+DmfsLH/bGC5x6YuRDSY6nFAtYaB1+RtPKnHVp7JAen3iWUZfsWHZx5SDyf75pKaXM1w
        PHtFPV4J9CNuUPVROJ0JSfTevnaU+etTWHkp/o0iRWP9jF6OzdO/OWd3PT1CSx1q1uhVq9
        n4grMkvv0QcSBMxqKbi4Pl51Ez1DL8c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-M97TsjayPKyOQpOwJl2qXA-1; Tue, 07 Mar 2023 05:42:56 -0500
X-MC-Unique: M97TsjayPKyOQpOwJl2qXA-1
Received: by mail-wm1-f69.google.com with SMTP id c7-20020a7bc847000000b003e00be23a70so8088542wml.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Mar 2023 02:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678185775;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkSFfGl4soWJh275ABriCY4OJqXhUGnQB2a/+uhCoY0=;
        b=gpwgciJGW2M4Ww9dO4AKDeZ82tD+JyF3NHBPmvXLBx4QnMDdsIGA6rmOb6ASSV6EhN
         Ie2OlHdEZS/wsoRXN58HwJXd8nA2n1SnKE/zrENUoI1y4zs6oZYDFGEaSfxXrZ0WMUrh
         Bq1WGCmDf1W+Hc+V2ulR9I8WrPvbxBhrC4ZitJrF2qAwivigO6gcDAgd8XQSnGzYESyx
         wRwC6SWZTyWF5Vy5NlvNp9LOlH9N1kc1ycL9aTkxeUsueWaXpnSFVIZXfUfoWvWgMXlU
         Zy59hi1Iu1avke8wX1XaSiN6LKwe9hM2M+bouOFYGObega//xJ/cQmeOLBkiMwIzYmRr
         /sqw==
X-Gm-Message-State: AO0yUKWlKXl3avnhAdsmYSvGt47mlQoc/qxpVGQ7dii4evQXGBB2MqvJ
        5fpREAoYya0VfQOys/R0v7PDdnuUgaJPH/aa78RgDRrfakWkn6TtFrT8/Wr/FLuGk9P2u04v/JZ
        6mpwiPbR03VzqeDlj+vgrGw==
X-Received: by 2002:a05:600c:4687:b0:3e2:201a:5bcc with SMTP id p7-20020a05600c468700b003e2201a5bccmr12423846wmo.33.1678185775733;
        Tue, 07 Mar 2023 02:42:55 -0800 (PST)
X-Google-Smtp-Source: AK7set9qXIxQ9yHJKIfCwELq7tomci3ICaGJvPRazUwNeud11Cy9qjJe48+RLn1VklykElHsR9Tgqw==
X-Received: by 2002:a05:600c:4687:b0:3e2:201a:5bcc with SMTP id p7-20020a05600c468700b003e2201a5bccmr12423799wmo.33.1678185775374;
        Tue, 07 Mar 2023 02:42:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:a100:e20:41da:c49b:8974? (p200300cbc707a1000e2041dac49b8974.dip0.t-ipconnect.de. [2003:cb:c707:a100:e20:41da:c49b:8974])
        by smtp.gmail.com with ESMTPSA id h8-20020a5d5048000000b002c592535839sm12176234wrt.17.2023.03.07.02.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 02:42:54 -0800 (PST)
Message-ID: <1467f1b3-a529-50d3-9539-1056b2912d48@redhat.com>
Date:   Tue, 7 Mar 2023 11:42:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory
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
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-23-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230227222957.24501-23-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 27.02.23 23:29, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Account shadow stack pages to stack memory. Do this by adding a
> VM_SHADOW_STACK check in is_stack_mapping().
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> v7:
>   - Change is_stack_mapping() to know about VM_SHADOW_STACK so the
>     additions in vm_stat_account() can be dropped. (David Hildenbrand)
> 
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
>   mm/internal.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 7920a8b7982e..1d13d5580f64 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -491,14 +491,14 @@ static inline bool is_exec_mapping(vm_flags_t flags)
>   }
>   
>   /*
> - * Stack area - automatically grows in one direction
> + * Stack area


Maybe "Stack area (including shadow stacks)"


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

