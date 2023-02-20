Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293C669C9A3
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 12:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjBTLSx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 06:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjBTLSu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 06:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2132D8
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 03:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676891835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EQNfPCKlm/dnqlucYMgfhMhQeV8s6OOHLtd2gYWnSc=;
        b=f5eV9Sfbr5eRqRvVqV/ovfHcekpO2Q/V577M8avaT5ismeNOqdCWVi44Y8ZYG++qTywQ0p
        KYs//XZIwwa8KnOZcK2MpVbaBdR+q+OGo1bXSoRZG6oBXILL+rvuipEycjtXKsQl9bSnYV
        PfaN0gonGx9WuR0vzeFEPGp67C4DTZM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-SoaHB_tIOnOyrK5UWkGCRw-1; Mon, 20 Feb 2023 06:17:14 -0500
X-MC-Unique: SoaHB_tIOnOyrK5UWkGCRw-1
Received: by mail-wr1-f71.google.com with SMTP id c14-20020adffb0e000000b002bfda39265aso275176wrr.13
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 03:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EQNfPCKlm/dnqlucYMgfhMhQeV8s6OOHLtd2gYWnSc=;
        b=M+F7zdeT2kGYjpoYwlszLDcG9K6mZcOCw2KAauHVJF402Pq14h7/gB7fhqmwWU5XPJ
         qr/lWTg+mafffvCLfK9EuE2b86lLnC3QnKX40kW0UnyqpLESA31kpL2w49JEcPH3a3Hr
         EeCUPjXmDhhc3DxCJMggqPcgGPCSdV88WupUcLIhLqMmauGaEHwXiWC+kxhPhEn6p/Dt
         CApa3uMSl7ToCG0Gt1grmX52NAb1yPear/NZGXo33n4ypdAHUX5J4ZHaGZbrjo791Rd9
         B1vcssoXFSdSjEaAupGlR1ewfAKcDW6j+jQbI3pCbRb/YUpW5xplyHsOnurhOyK5ZicI
         2cdg==
X-Gm-Message-State: AO0yUKXJyQiv/Jv1LS4NhV6G9mrSAgBkJOOH7HIylS+IiW3tPiXCLPfw
        LE680mJ49O/7rqRa/HMdjkh93ZPdImgFt/GpMQ9stQyhEkclhA9P+aDLOcBYIrEc8aUvcX3p39L
        6dbKwbKYt2Rholocxy1ybuA==
X-Received: by 2002:a05:600c:4d89:b0:3e0:1a9:b1e0 with SMTP id v9-20020a05600c4d8900b003e001a9b1e0mr578766wmp.25.1676891833521;
        Mon, 20 Feb 2023 03:17:13 -0800 (PST)
X-Google-Smtp-Source: AK7set8S0E2hPJcQfDWwVBHJ827trXEDgyAecAtZgO3tsbPQgMPJ2pfBI07ijKz0qUw/7N5br62ouQ==
X-Received: by 2002:a05:600c:4d89:b0:3e0:1a9:b1e0 with SMTP id v9-20020a05600c4d8900b003e001a9b1e0mr578749wmp.25.1676891833134;
        Mon, 20 Feb 2023 03:17:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm331492wma.2.2023.02.20.03.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:17:12 -0800 (PST)
Message-ID: <ee0ab9fa-9560-0160-f9ad-3b0ca844884c@redhat.com>
Date:   Mon, 20 Feb 2023 12:17:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 11/41] mm: Introduce pte_mkwrite_kernel()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
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
        debug@rivosinc.com, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-12-rick.p.edgecombe@intel.com>
 <63f288cc.a70a0220.5558c.3c92@mx.google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <63f288cc.a70a0220.5558c.3c92@mx.google.com>
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

On 19.02.23 21:38, Kees Cook wrote:
> On Sat, Feb 18, 2023 at 01:14:03PM -0800, Rick Edgecombe wrote:
>> The x86 Control-flow Enforcement Technology (CET) feature includes a new
>> type of memory called shadow stack. This shadow stack memory has some
>> unusual properties, which requires some core mm changes to function
>> properly.
>>
>> One of these changes is to allow for pte_mkwrite() to create different
>> types of writable memory (the existing conventionally writable type and
>> also the new shadow stack type). Future patches will convert pte_mkwrite()
>> to take a VMA in order to facilitate this, however there are places in the
>> kernel where pte_mkwrite() is called outside of the context of a VMA.
>> These are for kernel memory. So create a new variant called
>> pte_mkwrite_kernel() and switch the kernel users over to it. Have
>> pte_mkwrite() and pte_mkwrite_kernel() be the same for now. Future patches
>> will introduce changes to make pte_mkwrite() take a VMA.
>>
>> Only do this for architectures that need it because they call pte_mkwrite()
>> in arch code without an associated VMA. Since it will only currently be
>> used in arch code, so do not include it in arch_pgtable_helpers.rst.
>>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: xen-devel@lists.xenproject.org
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> I think it's a little weird that it's the only PTE helper taking a vma,
> but it does seem like the right approach.

Right. We could pass the vm flags instead, but not sure if that really 
improves the situation. So unless someone has a better idea, this LGTM.

-- 
Thanks,

David / dhildenb

