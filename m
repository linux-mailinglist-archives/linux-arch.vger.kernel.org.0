Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD4E6777C9
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 10:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjAWJvL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 04:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAWJvK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 04:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742721A0F
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 01:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674467418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSYxORSo5fJ20pO0AdfHiuiQJWJRfHcLYdctAQzz20k=;
        b=H/R+ghhrhsiL4pY11BZXl3daqHx8WZF9OqyOcYz/9Wxd8mXnL9Y7sqFbqcmQ/lezkZ/8f3
        tD3l0mZA8vkuxHZHLPBJ3suL4i0PL9YXfGxIODHHD3mnT746dnerwFpkT9TY5EnSNXAwZf
        NeGlMVtwhjznBVEuGxvOQqEED+TcBQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-599-LK9FTXCqMsWybESIFAVh0A-1; Mon, 23 Jan 2023 04:50:16 -0500
X-MC-Unique: LK9FTXCqMsWybESIFAVh0A-1
Received: by mail-wm1-f72.google.com with SMTP id 12-20020a05600c228c00b003db09699216so2653097wmf.1
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 01:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSYxORSo5fJ20pO0AdfHiuiQJWJRfHcLYdctAQzz20k=;
        b=uq5E+T1DcvoHdHI4g2NPURCdQaZDL53UUuFsGdRa/zK5rKSmTsy5TMV0Pv9UiU1N1W
         Phz3eE22iSUEWquhf/GGuMHHlr7Bss3cb9bHAxGoLou0hD4KKcL03C9nEG3qgx9pHU+N
         UBts2mFWCQKhZ1pujnP2sQMztcH6XS33IbjuO7Vyoek1KeSO1NY/sqEN+nxhH8Iihe/+
         mu/02KkxeXvbLLRTZue4ekFQu0QN0wHi4Cxk7Lxn4ixK7H5AOWA10krcT1TBhYPq3Q0H
         z3ncMZW2fjXRwY+BfF/9QUfGikteKdz4wScl738yqz2/se9TwG2MxyekNzvCYuKU6E6J
         u43g==
X-Gm-Message-State: AFqh2kr6DkaQUio7xRtd0ouupMBHKkSr6BVNTJGSGmPNormT6r6Twyn/
        2p89JSvT5dmpKuyJ2f1B+5JI5nuf1rzh1ju0yAREQlWP8lfs/e+xaHvntTA1kGaCYWonLURtQTw
        wqLjRnEyaQhPAKNT9QW4zjw==
X-Received: by 2002:a05:600c:3b1e:b0:3cf:497c:c4f5 with SMTP id m30-20020a05600c3b1e00b003cf497cc4f5mr23576059wms.13.1674467415693;
        Mon, 23 Jan 2023 01:50:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9yQJkaBPo8s7D1+JPWykvhgcJBeDr0ywpOXES22KIpL3qQHqi+WIix769Us7mHmdo/CB66w==
X-Received: by 2002:a05:600c:3b1e:b0:3cf:497c:c4f5 with SMTP id m30-20020a05600c3b1e00b003cf497cc4f5mr23576006wms.13.1674467415336;
        Mon, 23 Jan 2023 01:50:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c7401000000b003b3307fb98fsm10069782wmc.24.2023.01.23.01.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:50:14 -0800 (PST)
Message-ID: <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
Date:   Mon, 23 Jan 2023 10:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-19-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
In-Reply-To: <20230119212317.8324-19-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19.01.23 22:22, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Since shadow stack memory can be changed from userspace, is both
> VM_SHADOW_STACK and VM_WRITE. But it should not be made conventionally
> writable (i.e. pte_mkwrite()). So some code that calls pte_mkwrite() needs
> to be adjusted.
> 
> One such case is when memory is made writable without an actual write
> fault. This happens in some mprotect operations, and also prot_numa faults.
> In both cases code checks whether it should be made (conventionally)
> writable by calling vma_wants_manual_pte_write_upgrade().
> 
> One way to fix this would be have code actually check if memory is also
> VM_SHADOW_STACK and in that case call pte_mkwrite_shstk(). But since
> most memory won't be shadow stack, just have simpler logic and skip this
> optimization by changing vma_wants_manual_pte_write_upgrade() to not
> return true for VM_SHADOW_STACK_MEMORY. This will simply handle all
> cases of this type.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---

Instead of having these x86-shadow stack details all over the MM space, 
was the option explored to handle this more in arch specific code?

IIUC, one way to get it working would be

1) Have a SW "shadowstack" PTE flag.
2) Have an "SW-dirty" PTE flag, to store "dirty=1" when "write=0".

pte_mkwrite(), pte_write(), pte_dirty ... can then make decisions based 
on the "shadowstack" PTE flag and hide all these details from core-mm.

When mapping a shadowstack page (new page, migration, swapin, ...), 
which can be obtained by looking at the VMA flags, the first thing you'd 
do is set the "shadowstack" PTE flag.

-- 
Thanks,

David / dhildenb

