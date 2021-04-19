Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F76363E59
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 11:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhDSJPj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 05:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237649AbhDSJPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Apr 2021 05:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618823708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJHH0NX3OsQ2e3bz8MbvbRBxnLsHKmu/POOlzwxl9eU=;
        b=QX2G3CzJ/NKD5UOg85qHAZTkn4RiYHvYTExtbc+L2jA7dhUw0gVsiT0k5iKqRzYhEVDons
        pF1+55fvvZBvw9Gn3JVIcieUx0XziS9/K+8s9SJ1s9J0VSkh8kwTvP28dW+dEFJcvlIqU0
        KMPI/jgfhyYGNVdLCq+Z1xq5xuU5A5w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-THuJSLFQNSmBR0JFDUhmeQ-1; Mon, 19 Apr 2021 05:15:06 -0400
X-MC-Unique: THuJSLFQNSmBR0JFDUhmeQ-1
Received: by mail-ed1-f71.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso10823233edc.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Apr 2021 02:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JJHH0NX3OsQ2e3bz8MbvbRBxnLsHKmu/POOlzwxl9eU=;
        b=Y3reYOrNsQsoGK66dxOnAgPkU+RLfEVrPyWvN+1zRcf8eUUUdAGZLA2qKJv4d1JtiY
         M4Um8xmj/+AffFz/fz+bCXVsapeaUXVfkP6FcR4bKZQ6gK5x50vC4pbkTdAETmcbI/RH
         ao4Y+zDZ9s5ojrVeCDVQ0oM7iB+MVl9/nFl/Frt6H5+gHkBjyGR+d8BGKsJnCjdk0nCq
         PqYyehACNePnvKNoQppUfdokNvIc4NemEUc+J6AhvCxP709gnVqkL8DSEFfKE3IdiIWv
         nYpwnL/sZU2ceY8zd3EiKay/Iw/Jzyk+kVdTL+iaedZ24uEkB9rm4u1XYfvF6RPelp4O
         KfeQ==
X-Gm-Message-State: AOAM530nYh1BmofVPsvMvcOF4mAlW+C6tc+hy2VR8eCr3jJ3EQmpb/Eh
        HnBy7ZDuv3ELx/yHRXY/kbaD5K5f+hfeCdTKqIlk0EFSpdDzXoHfmqPTFA7sOs/wbXfJ/eAWNse
        UdHakRZ7WksWL6/0ud6RX5w==
X-Received: by 2002:a05:6402:42d1:: with SMTP id i17mr23711255edc.131.1618823705481;
        Mon, 19 Apr 2021 02:15:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYzYlDX/eTm99p4Oo7Oz5LAmRLoDDSSTEdvjwkyJC6GdKrJUD2OsxJ6l4DnJdCX72CgXH3hg==
X-Received: by 2002:a05:6402:42d1:: with SMTP id i17mr23711232edc.131.1618823705193;
        Mon, 19 Apr 2021 02:15:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69b8.dip0.t-ipconnect.de. [91.12.105.184])
        by smtp.gmail.com with ESMTPSA id y16sm12144407edc.62.2021.04.19.02.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 02:15:04 -0700 (PDT)
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
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
        x86@kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20210419084218.7466-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
Date:   Mon, 19 Apr 2021 11:15:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210419084218.7466-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19.04.21 10:42, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Kernel test robot reported -4.2% regression of will-it-scale.per_thread_ops
> due to commit "mm: introduce memfd_secret system call to create "secret"
> memory areas".
> 
> The perf profile of the test indicated that the regression is caused by
> page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):
> 
>   27.76  +2.5  30.23       perf-profile.children.cycles-pp.gup_pgd_range
>    0.00  +3.2   3.19 ± 2%  perf-profile.children.cycles-pp.page_mapping
>    0.00  +3.7   3.66 ± 2%  perf-profile.children.cycles-pp.page_is_secretmem
> 
> Further analysis showed that the slow down happens because neither
> page_is_secretmem() nor page_mapping() are not inline and moreover,
> multiple page flags checks in page_mapping() involve calling
> compound_head() several times for the same page.
> 
> Make page_is_secretmem() inline and replace page_mapping() with page flag
> checks that do not imply page-to-head conversion.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> @Andrew,
> The patch is vs v5.12-rc7-mmots-2021-04-15-16-28, I'd appreciate if it would
> be added as a fixup to the memfd_secret series.
> 
>   include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
>   mm/secretmem.c            | 12 +-----------
>   2 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index 907a6734059c..b842b38cbeb1 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -4,8 +4,32 @@
>   
>   #ifdef CONFIG_SECRETMEM
>   
> +extern const struct address_space_operations secretmem_aops;
> +
> +static inline bool page_is_secretmem(struct page *page)
> +{
> +	struct address_space *mapping;
> +
> +	/*
> +	 * Using page_mapping() is quite slow because of the actual call
> +	 * instruction and repeated compound_head(page) inside the
> +	 * page_mapping() function.
> +	 * We know that secretmem pages are not compound and LRU so we can
> +	 * save a couple of cycles here.
> +	 */
> +	if (PageCompound(page) || !PageLRU(page))
> +		return false;

I'd assume secretmem pages are rare in basically every setup out there. 
So maybe throwing in a couple of likely()/unlikely() might make sense.

> +
> +	mapping = (struct address_space *)
> +		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
> +

Not sure if open-coding page_mapping is really a good idea here -- or 
even necessary after the fast path above is in place. Anyhow, just my 2 
cents.

The idea of the patch makes sense to me.

-- 
Thanks,

David / dhildenb

