Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D3E38065F
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 11:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhENJmJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 05:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231479AbhENJmI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 05:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620985256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvT1h5Dtf95/bClBJ8t/oO4/WMLk+en4nCrG5Kuj0DQ=;
        b=YHwHH2ihE7MF9kaK0vsik5rPLpZbkAUFbP8cqiMPKL842Jxo4sKcRWxdJaKlQxdLN0ogu5
        AhCDbUdwKZBMnFEFSiTR47nPfi/9qV7pOUIxsDX1FeV+S8ay0s+SgT0GdlGvkPlmz0S6Ij
        yW93BW+P5qecf0Cij/30E7Za6KCFfM8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-1EWD3CQeMCyoc2aWiPVj4w-1; Fri, 14 May 2021 05:40:55 -0400
X-MC-Unique: 1EWD3CQeMCyoc2aWiPVj4w-1
Received: by mail-ed1-f70.google.com with SMTP id h16-20020a0564020950b029038cbdae8cbaso4605812edz.6
        for <linux-arch@vger.kernel.org>; Fri, 14 May 2021 02:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bvT1h5Dtf95/bClBJ8t/oO4/WMLk+en4nCrG5Kuj0DQ=;
        b=pHXsGwgD6zRNRMs3wJr8UEdDwyj5i9lxVNYVzR6hLB/ojQHVS6Tvlh/x4rPXVIwMVJ
         NR7jSBz9G5XrRtOlc7l6Ss4quUtXEaX+Q4soH0+4BtAKpL+sSoyOGtz7/4VaM+zQt6AF
         fderqxzhOhANtn7eTPSUrFI/I/MxVBlN6mOiAbqTu1Jt7PW54Xz3GWgAXW7jJ3T3m8Eg
         Qx7qav6oa4M38PHFpae8xkZaRFZe4XsG20xIeNO8adVSsLMFs9yvhtd8png/vDzH2I7r
         AOiOed3Rmi1u/xG6jPEuBzSjwXSv3AJ0c6P/lgLcO6kWCo0rpMeQOZ77Rv4nUJD79LzL
         CcEw==
X-Gm-Message-State: AOAM531cXF0tzB9t+5KnAI53OT50jQRbq6swURSvYpcyUPCJaC8TKHEH
        NU2BdIKfGMJ/R7O5ixN4eFjczCvJUDswBQFRvIGKNWc0jnAisKJiT8AsvYvLVjCyeGvT4wQva+h
        0KifsHLHr/E4FZsj4eOUTpA==
X-Received: by 2002:a05:6402:2d6:: with SMTP id b22mr55674429edx.274.1620985253912;
        Fri, 14 May 2021 02:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNzAwSfBkG72zB94sJxDLgDbZ+DEQn4gYm5J85sFFQeIUDMZK27eq70zvt8ZCsSnIvH+CO+w==
X-Received: by 2002:a05:6402:2d6:: with SMTP id b22mr55674419edx.274.1620985253764;
        Fri, 14 May 2021 02:40:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id g10sm2885347ejd.109.2021.05.14.02.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 02:40:53 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Mark Rutland <mark.rutland@arm.com>,
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
 <20210513184734.29317-9-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v19 8/8] secretmem: test: add basic selftest for
 memfd_secret(2)
Message-ID: <a573f11d-7716-46cd-1d08-6840560d6877@redhat.com>
Date:   Fri, 14 May 2021 11:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-9-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 13.05.21 20:47, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The test verifies that file descriptor created with memfd_secret does not
> allow read/write operations, that secret memory mappings respect
> RLIMIT_MEMLOCK and that remote accesses with process_vm_read() and
> ptrace() to the secret memory fail.
> 

[...]

> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright IBM Corporation, 2020

2021 ?


-- 
Thanks,

David / dhildenb

