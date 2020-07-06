Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F82153EF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 10:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgGFIYT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 04:24:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31221 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgGFIYT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 04:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594023857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=quj4+LzktSufcReK8cEx0HO5INxJ+LynwUM2i7cDKgs=;
        b=dMBtrYfGvFWNquTbXNGFL9EjMrDVG36p+Lf8EywCuBXktdMp7yeaJM5UsrdqoUKcUlUxos
        alktbqfmEkf1xE38rVHOT/hydJGFG7WV5htSejb3mTJjWudk9rKXW31P7jZIsW9Ac4LWfD
        aD+DPS3bjhI4M5KZR4cJcNpsSirYiD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-xb6nmaRIP3WDF3FeImt83Q-1; Mon, 06 Jul 2020 04:24:13 -0400
X-MC-Unique: xb6nmaRIP3WDF3FeImt83Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1E3F188360D;
        Mon,  6 Jul 2020 08:24:11 +0000 (UTC)
Received: from [10.36.114.3] (ovpn-114-3.ams2.redhat.com [10.36.114.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DB53108BD32;
        Mon,  6 Jul 2020 08:24:06 +0000 (UTC)
Subject: Re: [PATCH v6 06/26] mm: Add PG_arch_2 page flag
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-7-catalin.marinas@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <27fe044a-8315-5394-575e-8f763696b0cd@redhat.com>
Date:   Mon, 6 Jul 2020 10:24:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703153718.16973-7-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03.07.20 17:36, Catalin Marinas wrote:
> From: Steven Price <steven.price@arm.com>
> 
> For arm64 MTE support it is necessary to be able to mark pages that
> contain user space visible tags that will need to be saved/restored e.g.
> when swapped out.
> 
> To support this add a new arch specific flag (PG_arch_2). This flag is
> only available on 64-bit architectures due to the limited number of
> spare page flags on the 32-bit ones.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> [catalin.marinas@arm.com: use CONFIG_64BIT for guarding this new flag]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
> Notes:
>     v6:
>     - Using CONFIG_64BIT instead of a new CONFIG_ARCH_USES_PG_ARCH_2 option.
>     
>     New in v4.
> 
>  fs/proc/page.c                    | 3 +++
>  include/linux/kernel-page-flags.h | 1 +
>  include/linux/page-flags.h        | 3 +++
>  include/trace/events/mmflags.h    | 9 ++++++++-
>  tools/vm/page-types.c             | 2 ++
>  5 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index f909243d4a66..9f1077d94cde 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -217,6 +217,9 @@ u64 stable_page_flags(struct page *page)
>  	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
>  	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
>  	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
> +#ifdef CONFIG_64BIT
> +	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> +#endif
>  
>  	return u;
>  };
> diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
> index abd20ef93c98..eee1877a354e 100644
> --- a/include/linux/kernel-page-flags.h
> +++ b/include/linux/kernel-page-flags.h
> @@ -17,5 +17,6 @@
>  #define KPF_ARCH		38
>  #define KPF_UNCACHED		39
>  #define KPF_SOFTDIRTY		40
> +#define KPF_ARCH_2		41
>  
>  #endif /* LINUX_KERNEL_PAGE_FLAGS_H */
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 6be1aa559b1e..276140c94f4a 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -135,6 +135,9 @@ enum pageflags {
>  #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
>  	PG_young,
>  	PG_idle,
> +#endif
> +#ifdef CONFIG_64BIT
> +	PG_arch_2,
>  #endif
>  	__NR_PAGEFLAGS,

People are usually *very* picky when it comes to new page flags. It
somewhat concerns me that we bump up __NR_PAGEFLAGS for any 64bit arch.
That feels wrong.


-- 
Thanks,

David / dhildenb

