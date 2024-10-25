Return-Path: <linux-arch+bounces-8552-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5168E9B0DFE
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DDB1F24ED4
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B488921440E;
	Fri, 25 Oct 2024 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MN8T4iDD"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883820EA53
	for <linux-arch@vger.kernel.org>; Fri, 25 Oct 2024 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883317; cv=none; b=Vqj+/TsP309msScIBxBep3HablgM0GAWEkYDJblfqFYgRx6Fd0B9ybKhdCdj/7S4RnBDVMv+k31EEdIXJB/jEQglm1+gJ/4mw5LvnUGBErdP9EMxpXZArcXnfoTwuQqkFwB23YkUiXLM2e2GTms1thoxCjh72Y5pdwP3FnfCOSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883317; c=relaxed/simple;
	bh=Atqhu9Vvs2j4kgk125WY6kREgeM34LSEqvCjPbaLUVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP3uyIotJbBhDEWljomvBKeUsFiy7CVKUuho1DVVPi3sYlS5puixsVxlD1yQxAsEg9QgV1EpLsgMdH67jpHCKC5rhxELCkkvDKywBAXXZqEzqqhTy3NsWMJqtpfijMGuFSnzAPc8mFqY2Wti0kFpFOsONbJ9nTVpNavWJOpwx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MN8T4iDD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729883313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MVSXZyg6q4vB/F/dlOCG25S11OL3q8xNphEevi1OUr8=;
	b=MN8T4iDDmPw+XqdUU08L4vXuvsHcMQwrblpMXIbkM9pTK8EKaBcpw8XImLUcmX5zw97Aoh
	ccXgkjE4TUG0DrU9rJwBGtBL3BxvbG1gJ+kty81dQzOGPkWlop8b1v3soG0+MxiF4tHLDw
	9WZycaRW3i36u5UKuBHJxqYcGyOoZ5s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-9wbl8gDqOxS_JtZ106U0Kg-1; Fri, 25 Oct 2024 15:08:31 -0400
X-MC-Unique: 9wbl8gDqOxS_JtZ106U0Kg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso17834465e9.0
        for <linux-arch@vger.kernel.org>; Fri, 25 Oct 2024 12:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729883308; x=1730488108;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MVSXZyg6q4vB/F/dlOCG25S11OL3q8xNphEevi1OUr8=;
        b=YpIr4ENHcOcWScCyiNmYzzXmPz0uSHUS37KngB+w83BP1swLt/lN+yBB145DNzb4Q3
         mwnxow86rudpKla8hCvDOVB374whNaTJIuQL2D2Wp60zGlBba/OdvI7lpFKajNuAOsKZ
         h9RMgqnTnqiBmK0OMwvckMU6clFPah7EyTXWe+MbcGQ5VazCG5pF4m7T/ZM+0NaTEeuE
         6D3HWkl2XpZXoMZNcbcnfVrOLjF6ldWcGRvmEmqmZjosB2SFgbwHMAGuq1esueupyG3u
         94v3rM2euMCm6od3LCrZqRuEk7o+YFextrWpEhdyAP04d0vTQJf0dr+tOI/5t1qOpqNf
         ZbFw==
X-Forwarded-Encrypted: i=1; AJvYcCV+MjnEws1iN5OPq8vtaL+B0sA+S8Zrdx39fLOMGN4irH5sXy76KyOiyCfx7A8pm8ZE9osLzTskztOp@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3pOXGn2sPnmEeHCqi5a7xIf5Ooyk9CwQ4wnGfNsLo5W9j1h0
	0B6/3lXa6fSNnCcrsG1ehI5p+/wf4iPlbUM4rQJ+0qa9hL4ccK0eRNpI0wVXhA88K6Li+aEskZX
	8aHOeVmMPODRyWbTByb1HCIhXuVotZfZ0aLy/cX3oQCU0P8XZF/F/ktN/W9M=
X-Received: by 2002:a05:600c:4e8e:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4319ad146ebmr1855615e9.25.1729883308646;
        Fri, 25 Oct 2024 12:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4/uB4vkEM8EwI0WND/9FVu+Ru6uZegvdPG4ihlFPwI38k6kKKl957e+0DOV/SgltwNfr85Q==
X-Received: by 2002:a05:600c:4e8e:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4319ad146ebmr1855235e9.25.1729883308239;
        Fri, 25 Oct 2024 12:08:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:d800:499c:485a:c734:f290? (p200300cbc70dd800499c485ac734f290.dip0.t-ipconnect.de. [2003:cb:c70d:d800:499c:485a:c734:f290])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5430absm56204345e9.6.2024.10.25.12.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 12:08:27 -0700 (PDT)
Message-ID: <c072049b-d6ef-47ce-b281-006ae0f721b3@redhat.com>
Date: Fri, 25 Oct 2024 21:08:24 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
 <20241023160405.33995c68f20c141325a8fadb@linux-foundation.org>
 <635de052-35a6-40e0-82ea-4349f3aecc06@lucifer.local>
 <a089ff3b-119e-44a0-a780-3abca01886f7@redhat.com>
 <e62ef664-1c71-48e0-a695-6a53b6d46922@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e62ef664-1c71-48e0-a695-6a53b6d46922@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> We already discussed in the past that we need a better and more efficient
>> way to walk page tables. I have part of that on my TODO list, but I'm
>> getting distracted.
> 
> Yes I remember an LSF session on this, it's a really obvious area of improvement
> that stands out at the moment for sure.
> 
> Having worked several 12+ hour days in a row though recently I can relate to
> workload making this difficult though :)

Yes :)

> 
>>
>> *Inserting* (not walking/modifying existing things as most users to) as done
>> in this patch is slightly different though, likely "on thing that fits all"
>> will not apply to all page table walker user cases.
> 
> Yeah, there's also replace scenarios which then have to do egregious amounts of
> work to make sure we do everything right, in fact there's duplicates of this in
> mm/madvise.c *grumble grumble*.
> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> OK so I guess I'll hold off my TODOs on this as you are looking in this area and
> I trust you :)

It will probably take me a while until I get to it, though. I'd focus on 
walking (and batching what we can) first, then on top modifying existing 
entries.

The "install something where there is nothing yet" (incl. populating 
fresh page tables etc.) case probably deserves a separate "walker".

If you end up having spare cycles and want to sync on a possible design 
for some part of that bigger task -- removing the old pagewalk logic -- 
please do reach out! :)

-- 
Cheers,

David / dhildenb


