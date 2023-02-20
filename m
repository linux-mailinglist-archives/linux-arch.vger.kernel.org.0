Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A669C9B1
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 12:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjBTLWN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 06:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjBTLWH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 06:22:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1832DD50B
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 03:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676892071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3eNuSXSMwT7K8lYDjXpFROOa9BiqxQfFrSmx+/FDJAs=;
        b=OZIU7j/rA0fuofYirYHr5s/0FS9B0tc+kbjeMiQ3T1o6mr53isq5d/LW2nZwV96AEFM4U0
        pdL7y+AiKqHsjdaRjTCefxYgaZnr3PA/dnI1CBmh3jKgJIb3IoCu344tEWTpFjALDB7Rnu
        /JP1v+/edAoBalyEtz9LrjG20sJVYEY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-tcqc4jXrO3K98YHvRamfIQ-1; Mon, 20 Feb 2023 06:21:09 -0500
X-MC-Unique: tcqc4jXrO3K98YHvRamfIQ-1
Received: by mail-wr1-f71.google.com with SMTP id a7-20020a056000188700b002c53d342406so52753wri.2
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 03:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eNuSXSMwT7K8lYDjXpFROOa9BiqxQfFrSmx+/FDJAs=;
        b=pTXhdmT56zM5KFhQ64J4QE5nNUGtJOgjEiI1DFhhYEM7IuBdyESGjZW+coUtfRI13W
         aoVbbJs2nCwNqAmnjmefxdKJtD6uuxxOuOZZZkSgDiWFhovkpKFCv0jW/+wCoCt0qC1Q
         qDPl6NQFn0dnZPDrdk/aKoAFfu4CKYUeA/SyD9Ba/f0N2/r60LhvhyfpYnRPR3CV1Yqx
         ihQOLCxcDE28xLVARGaTtQSbK4uSGPumCzAAJAOmRGo5fHXasmv82LRMEf4kc6BA80zK
         FWY00Ty4jlqgE3dv4J3Tq3lZMaJkrs7VcLajcc/nUSNzrjbc4E9dp6mhAA9yCsIhVsqx
         aTgw==
X-Gm-Message-State: AO0yUKWamg1f0Op9vwSISNzEC4Ot8NMucU/1q82O5hfpr1FFDS02KeMb
        W9+L1VeCsRN9sCzdmJx3xa6s1V0jJSPnPhBJnFgU11psRFfjaiKaMMLc1dlpvyjnsNyH1Ox2m70
        GnN1jiMffCT8aFs/1hW9b3A==
X-Received: by 2002:a05:6000:1a4e:b0:2c6:e824:7a5e with SMTP id t14-20020a0560001a4e00b002c6e8247a5emr258981wry.34.1676892068734;
        Mon, 20 Feb 2023 03:21:08 -0800 (PST)
X-Google-Smtp-Source: AK7set/WJC9Q7hUrS58bH3mA5ByqoqAxQkNSmCC79TeRMp7NDC+620Q0QJhNyWI/4bL39eZvdvEA2Q==
X-Received: by 2002:a05:6000:1a4e:b0:2c6:e824:7a5e with SMTP id t14-20020a0560001a4e00b002c6e8247a5emr258956wry.34.1676892068356;
        Mon, 20 Feb 2023 03:21:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcdef000000b003e21356bddcsm14270316wmj.33.2023.02.20.03.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:21:07 -0800 (PST)
Message-ID: <096f4fba-ec53-0035-02c2-0916833a43c2@redhat.com>
Date:   Mon, 20 Feb 2023 12:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 12/41] s390/mm: Introduce pmd_mkwrite_kernel()
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
Cc:     linux-s390@vger.kernel.org
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-13-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-13-rick.p.edgecombe@intel.com>
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
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One of these changes is to allow for pmd_mkwrite() to create different
> types of writable memory (the existing conventionally writable type and
> also the new shadow stack type). Future patches will convert pmd_mkwrite()
> to take a VMA in order to facilitate this, however there are places in the
> kernel where pmd_mkwrite() is called outside of the context of a VMA.
> These are for kernel memory. So create a new variant called
> pmd_mkwrite_kernel() and switch the kernel users over to it. Have
> pmd_mkwrite() and pmd_mkwrite_kernel() be the same for now. Future patches
> will introduce changes to make pmd_mkwrite() take a VMA.
> 
> Only do this for architectures that need it because they call pmd_mkwrite()
> in arch code without an associated VMA. Since it will only currently be
> used in arch code, so do not include it in arch_pgtable_helpers.rst.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 

Heh, that answers my question to patch #11

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

