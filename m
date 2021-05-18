Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43558387674
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348497AbhERK2h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 06:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348487AbhERK2g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 06:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621333638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Th9b0uelp+zuS5Dolk9edCcQodErGvwWmi6QbbSzCQ8=;
        b=hu4cwNlgqIF9y6apOx12S2Ln9ed/WSIc5qETK3CNvMU7q+r+gTr9soTYGttRGNOEuNjaSM
        pif+hPFuDmB8R2mJotHO4CzpzJhMpNxX4EHGbSKhfFIAr+uY9x3aA88hXNFEMEcnWGVn3z
        Gw01N0VUayxiTcznVWu9omKv/9drT/I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-UGPLxcZTNsuHflsTOcDe8A-1; Tue, 18 May 2021 06:27:16 -0400
X-MC-Unique: UGPLxcZTNsuHflsTOcDe8A-1
Received: by mail-wr1-f72.google.com with SMTP id i102-20020adf90ef0000b029010dfcfc46c0so5398343wri.1
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 03:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Th9b0uelp+zuS5Dolk9edCcQodErGvwWmi6QbbSzCQ8=;
        b=heC67DQ8FRS6nlQX4jpKcVk+5SIIdXZStSMEagId2KLB8Z+lJF0gzeTjv7o3kUwEKo
         KLjZXcXGbQ08vjafIbgbDWrlpYOHMSNxAqrP6IE994hTU8KJcaCDmAPXZet5UwOC1b/L
         LSdCMCkWzSpMB8N4BnyPQRmvOIoi38lLU/ODYJlQlLBwXnYk4nJAgSbGnOWBwExgj0PE
         L0D4zU2I7FjlasyPqoTMHOCFTftsfvIZVwioQTOmfrMJOcn/XHCR4PwL3/yzwMgoOiYv
         uOWeqHNLyTaMUGLhwnkXXTiqQcs4fXs/xbIep+47x9LBvu4VpoSg18c5OncVluv2N4tk
         cX4w==
X-Gm-Message-State: AOAM532GfjhDqRJud7o6c9x0Ccff6PFI4E7nh/M2p6RR6fsaUN7lDWbT
        eANLtSIXXW8VhTIi8InGICkRv1xGX43MP9GA+ITAPGHkZ7269dEpI0IcsARAbu81B5/gyMMwWRO
        XhLs1XKRdDTD5EFOk1xKt2A==
X-Received: by 2002:a05:600c:35cc:: with SMTP id r12mr4525776wmq.157.1621333635632;
        Tue, 18 May 2021 03:27:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL+bP4BGJ/+tDiLE4ZHcq1wv671RbTKwVIAcgFztdQnfjanbuq/Gm2r3B/QzaKSEduy6Y9Cg==
X-Received: by 2002:a05:600c:35cc:: with SMTP id r12mr4525739wmq.157.1621333635433;
        Tue, 18 May 2021 03:27:15 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id z3sm1173826wrq.42.2021.05.18.03.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 03:27:15 -0700 (PDT)
Subject: Re: [PATCH v19 6/8] PM: hibernate: disable when there are active
 secretmem users
To:     Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-7-rppt@kernel.org>
 <20210518102424.GD82842@C02TD0UTHF1T.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <47d0e5b1-ffee-d694-4865-8718619c1be0@redhat.com>
Date:   Tue, 18 May 2021 12:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518102424.GD82842@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.05.21 12:24, Mark Rutland wrote:
> On Thu, May 13, 2021 at 09:47:32PM +0300, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> It is unsafe to allow saving of secretmem areas to the hibernation
>> snapshot as they would be visible after the resume and this essentially
>> will defeat the purpose of secret memory mappings.
>>
>> Prevent hibernation whenever there are active secret memory users.
> 
> Have we thought about how this is going to work in practice, e.g. on
> mobile systems? It seems to me that there are a variety of common
> applications which might want to use this which people don't expect to
> inhibit hibernate (e.g. authentication agents, web browsers).
> 
> Are we happy to say that any userspace application can incidentally
> inhibit hibernate?

It's worth noting that secretmem has to be explicitly enabled by the 
admin to even work.

-- 
Thanks,

David / dhildenb

