Return-Path: <linux-arch+bounces-12011-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8ECABD4F3
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 12:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAF2188EB90
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D9F2741AE;
	Tue, 20 May 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEya9UBO"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ABA26FDAE
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737032; cv=none; b=IflC309tYiZAysn2txsbMfBt46cbkd3FuD8fA9wPelJhYC0OmkQWQUyjd8mgLvYPo0O3WXD5vycOmtZiFi7mTmp+jlYFJGsBr5+xxGHMJjn5JpW3zXtJYKITXQsuO644E0XTqP9MtZKqLzEadtt2rM6KoXiP5NMbhd872Q6vF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737032; c=relaxed/simple;
	bh=AKNcJVWLbGXgHWPW9BjB75Z7YxhLtUOLkLH3h58M5I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAIqKoKH8NxSZt6Y83rXBJe+09qy8sg525SSvZMW5OQsnBhlntIbowBkTq5meFdZBtzVYcmNjbo8Ml7HOABeeS3s1V2WATfL/tO/Btdnoqp4D72VeC9H9B/37obConwxJotDqLDpCHKnR+etGPKfSxfPhlyQz0Vlv+7QJ3ZQHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEya9UBO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747737029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IyqZDF6nTsKA5ptYOVkepI7N/Zyz69GWHnyAHJHWDW8=;
	b=EEya9UBOFdccTmdRaWIWtWoBz3x5EW5hJsf1Da6nmFWx2EhE4lanvgVl3GwlaYG2SR2VjK
	t8HYkC49LtJg1JZ1EhfwZHVJPpLW9yNlqzwByZpNuVfHUccgxAiMdyQMdXVQFwHdTXQbVM
	ZwRfzRE2WZmgAXsHsBkk9YTboYVsQyo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-xTlr_Rd7OgizwUYWSMvD4A-1; Tue, 20 May 2025 06:30:27 -0400
X-MC-Unique: xTlr_Rd7OgizwUYWSMvD4A-1
X-Mimecast-MFC-AGG-ID: xTlr_Rd7OgizwUYWSMvD4A_1747737027
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so28816375e9.0
        for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 03:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747737026; x=1748341826;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IyqZDF6nTsKA5ptYOVkepI7N/Zyz69GWHnyAHJHWDW8=;
        b=u03lqpfc9IFAVO3X3iVnUrDe5UCGNvJ1YcO413aqUqz3pqsBs/HuFJEHMsqW6+aLOX
         E0XK5pq/SSBWjRiKDMYcGbWusa6PxFw6wPZLab5p7h5yRWSqM7k18Z7vGMJxxXzWiMSJ
         fFOnDijskUjMr2FSfoBKpU613kF0VNmHVEe9tBgKXJP+Ltx1eNokn153naQ3SRp+BD13
         6/DGguNOrikooLc6QHFx6b1MNhQKpHFauG1N53t4XmC09UHC9jzvz1p+DHs4XqKKwtcw
         mkLDDZHcI8Gm9axtmiTEzLmvNyTp9rksijBsTy3ps6ecXaKVgW8/Ai6VftbHoWG2X5P6
         HavQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi0wSYhLxYwaUDjWfq4LRnuiZ0WvL5N75LCJwwAAutZXEuysxN9NhH+mHROtz5/jxbmm2FUpaL2nUT@vger.kernel.org
X-Gm-Message-State: AOJu0YzZG1AUknsv/cr8DYYab/DO2A+qBVP5/cPFnWiKWOms2MtvhqMK
	YMenHkSgYaVWJbGpmp9VsY7kVGum3UbxYwA5+2CIMPCLdAoCUh1oI9MGddizIpocOr5e7Z61jKw
	VCmBUDqUzLO4pYKKyKcx+cLoQw9E6gY+4YM0h17EmuPP0ZjNs6AkUCiGT+xbSpu8=
X-Gm-Gg: ASbGncspeQ289oS/BELu/EW3/PIp9uY/DdLGFd/tSKyNeykkTOOpNydrill8JEUu7ZD
	KNXHeaLXWjTHR6RAs1Foj0velStytxpIPSCsJL1ff+5KkjsamAqSaDJHFjRhHPO7RP/UxBNR9ag
	z5e/v6KJp+rYj9b/pQL2THOzASaR4s3nCWkleP7DR+Cg/C/5tZUiOmu4f/PWv1zw1YqihTEJ2K5
	G3PI2CuBnweXCbX/BaOUqjcviwqIeBCCex6EXeLInzHT4HFEG73osqhRGJC8poyiAYLlYvpUw+L
	kLYkYyk5Xs0cQbWLI9X/lFavFzr2zkb22A0haqAQAophWyTRIS2QMVKSaVwjga5kvrwbO3N/W9p
	tIZ95Kv3VRzSXT4c6tR1wTHdg1vX6Lf+3zsOw4gc=
X-Received: by 2002:a05:6000:1881:b0:38f:4f60:e669 with SMTP id ffacd0b85a97d-3a35fead108mr14152710f8f.29.1747737026546;
        Tue, 20 May 2025 03:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoaw0m714635En0zqDIhccEWnaF7oScgqO/CS2yGTyppvcyz0MOxrqhsvQmQEsW4QqhBt2Ig==
X-Received: by 2002:a05:6000:1881:b0:38f:4f60:e669 with SMTP id ffacd0b85a97d-3a35fead108mr14152674f8f.29.1747737026139;
        Tue, 20 May 2025 03:30:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84? (p200300d82f287c00a95eac49f2adab84.dip0.t-ipconnect.de. [2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm16243981f8f.18.2025.05.20.03.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:30:25 -0700 (PDT)
Message-ID: <becb11bd-e10c-4f59-9ff1-1f7acd2e1ee0@redhat.com>
Date: Tue, 20 May 2025 12:30:24 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] mm: madvise: refactor madvise_populate()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
 Usama Arif <usamaarif642@gmail.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <96503fba082709bc4894ba4134f9fac1d179ba93.1747686021.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <96503fba082709bc4894ba4134f9fac1d179ba93.1747686021.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.05.25 22:52, Lorenzo Stoakes wrote:
> Use a for-loop rather than a while with the update of the start argument at
> the end of the while-loop.
> 
> This is in preparation for a subsequent commit which modifies this
> function, we therefore separate the refactoring from the actual change
> cleanly by separating the two.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   mm/madvise.c | 39 ++++++++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 8433ac9b27e0..63cc69daa4c7 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -967,32 +967,33 @@ static long madvise_populate(struct mm_struct *mm, unsigned long start,
>   	int locked = 1;
>   	long pages;
>   
> -	while (start < end) {
> +	for (; start < end; start += pages * PAGE_SIZE) {
>   		/* Populate (prefault) page tables readable/writable. */
>   		pages = faultin_page_range(mm, start, end, write, &locked);
>   		if (!locked) {
>   			mmap_read_lock(mm);
>   			locked = 1;
>   		}
> -		if (pages < 0) {
> -			switch (pages) {
> -			case -EINTR:
> -				return -EINTR;
> -			case -EINVAL: /* Incompatible mappings / permissions. */
> -				return -EINVAL;
> -			case -EHWPOISON:
> -				return -EHWPOISON;
> -			case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
> -				return -EFAULT;
> -			default:
> -				pr_warn_once("%s: unhandled return value: %ld\n",
> -					     __func__, pages);
> -				fallthrough;
> -			case -ENOMEM: /* No VMA or out of memory. */
> -				return -ENOMEM;
> -			}
> +
> +		if (pages >= 0)
> +			continue;
> +
> +		switch (pages) {
> +		case -EINTR:
> +			return -EINTR;
> +		case -EINVAL: /* Incompatible mappings / permissions. */
> +			return -EINVAL;
> +		case -EHWPOISON:
> +			return -EHWPOISON;
> +		case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
> +			return -EFAULT;
> +		default:
> +			pr_warn_once("%s: unhandled return value: %ld\n",
> +				     __func__, pages);
> +			fallthrough;
> +		case -ENOMEM: /* No VMA or out of memory. */
> +			return -ENOMEM;

Can we limit it to what the patch description says? "Use a for-loop 
rather than a while", or will that be a problem for the follow-up patch?

-- 
Cheers,

David / dhildenb


