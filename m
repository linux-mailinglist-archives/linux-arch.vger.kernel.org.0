Return-Path: <linux-arch+bounces-12071-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714DAC0BD5
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 14:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77264A7646
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544A919DF4C;
	Thu, 22 May 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf/LT4bQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23714F70
	for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917938; cv=none; b=QIA551FWuFDsiKFiEvQnUQp133DhzUw2CF4cpuaBQEdqUN0VylSoiENyo5gk9N38HiR3Bv4eYLGV+aaj2GEOIM2FNsv/MMKm7i59TLqrCJvzkTT/cWBHIZniqKL+sip2iQjjrovln0PnwQmr4thlr41rU7KSL5JN7PVcj4V4aU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917938; c=relaxed/simple;
	bh=L6oN4TEbJXWKjCqKln7BMTq7PnoiNYt2AaepG+UWifE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvdCmrJHOmci0hVL/mUWBu9H7pEjAA0SotxR6agSRL40dYLYo82wOurmqXIjjQel8R1GbADqR7RiJh4nvR5WMI+KJMcCrI4tqvPCxX3+654QH3afZgDGz7g+VM3Xd3EY/TOxKeR/xiJJm55S2SR1Gl9Po82+3fnUej+BPZRq6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yf/LT4bQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747917935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eRFcaFYX+qSRgSAeLgBdmkZoJSJLPDhARbv/1pGSI9c=;
	b=Yf/LT4bQJBxcpwl50imik/NXPcJdWb7BA7BlPH8Sv9kxIdzV0B1A98eYyWcQwgmZHxbH47
	ToRsKqeE4l8VN1Ixix3Er4UBZS+GH0WwXfAet9aSxWxB5v11qC0kYoQqS6w6tU41OIkM+E
	0vk2FF3h02YZxZJFnZcx9LOs0OqG4CE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-lYtApU5kOsuLWXzPkehf9w-1; Thu, 22 May 2025 08:45:34 -0400
X-MC-Unique: lYtApU5kOsuLWXzPkehf9w-1
X-Mimecast-MFC-AGG-ID: lYtApU5kOsuLWXzPkehf9w_1747917933
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso4271955f8f.0
        for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 05:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747917933; x=1748522733;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eRFcaFYX+qSRgSAeLgBdmkZoJSJLPDhARbv/1pGSI9c=;
        b=kRR3OzPVz7iGbCGXADXwqxKiFGiD60FaPPHYSdW5xQiHoAqUBbcGROfB3Ti9bW4TGj
         rBVTTJ/2/TJffmVhDh4GLEhhwCBGUomRFmexuaix9/ySFknCYv2vawr8C730kzQkwUtJ
         xs/F0jZ+Xk4Ik9vDwlbFdSHzuuuaTpMzEvjzn1akxXWJA4NygIRIGH18YuXH0LFgaxAp
         pO6Depl+14NqxDq6k9kW0J4OLMB+8cQmR+RzbcTKSWNsedNsnSu2IaBCTl1o225WEgOj
         tFiyAZKo6Vhm96gr/uc1ZtBJ/8Wx98UBwZ23wjjsvRFsFQLnMPvCj2nRvO+0NBKnclev
         PQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQufC1T9Q4oql25Dzk1loRfG/ooqSxetxqbnSMAPKJYzp4d/vT6JUF+uPP8FSPZnR4lRErU/ir8PGg@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzPwIwERXHfsF12OkyLPkcdyzEFl3USDQZXaQIQwRvQqIHl5X
	u1W//bvOA8bHawJk9d2ze4cBKvQeiiT2B53lXCATJ62uTQj1rukRuuqI8tqeP9TpvhW5uzv97JJ
	ID7vWbkCwylofnlQdAS+nCrXW6juC+6zmFwFhia+drRMhcgHsPyFpa+btfpBOyko=
X-Gm-Gg: ASbGncs3QivAI8E1IZC6t77iQQPQdXq7lERbyqKij6Rp8MMd/IMMMy+OwHuODH6J0vV
	mwR9HDJG4feGaSXGAGigAsE1dn178mTksxR+gfW3/83ishQEwAmUQMBtmyWB87Sy2iKgckH2NlL
	k2utaKTc74ruX765jtgpNgbU6VL8InEwQ26mxQbTEKklRtoDNUOcCON8TXJ0guls1I2Focan47W
	atl8ETceVgKR21DDTTzGaB7Z0zqwq2pMROG1A3Sml3WX9zC/XbhSKWNWDhGlOoy0MHhZjEbVZrE
	6XEU3v9GY50UPHeeOwS7LgfFUrlDMmB74+/Smht41dWW5H8JhZm4MzZyjzsBVBNcns1a9J+SxSm
	4l8uoxxuhkzf5JV4m9/DmIeYb4aZiF/edtlAzvO8=
X-Received: by 2002:a05:6000:40e1:b0:3a3:71fb:78c6 with SMTP id ffacd0b85a97d-3a371fb81admr13316180f8f.16.1747917932787;
        Thu, 22 May 2025 05:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGATTUyMI5wCRgZJ4zH5+H7LebThZzPBo614IkDGW05G+5aleNlUae/RzllnsyfpZ1GYDQmuw==
X-Received: by 2002:a05:6000:40e1:b0:3a3:71fb:78c6 with SMTP id ffacd0b85a97d-3a371fb81admr13316146f8f.16.1747917932277;
        Thu, 22 May 2025 05:45:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:2e00:6e71:238a:de9f:e396? (p200300d82f222e006e71238ade9fe396.dip0.t-ipconnect.de. [2003:d8:2f22:2e00:6e71:238a:de9f:e396])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29548sm111600495e9.4.2025.05.22.05.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 05:45:31 -0700 (PDT)
Message-ID: <a8aedeb6-2179-4e53-8310-5b81438c2b80@redhat.com>
Date: Thu, 22 May 2025 14:45:30 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
To: Johannes Weiner <hannes@cmpxchg.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
 Usama Arif <usamaarif642@gmail.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <20250521173200.GA1065351@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250521173200.GA1065351@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.25 19:32, Johannes Weiner wrote:
> On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
>> So, something Liam mentioned off-list was the beautifully named
>> 'mmadvise()'. Idea being that we have a system call _explicitly for_
>> mm-wide modifications.

As stated elsewhere (e.g., THP cabal yesterday): mctrl() or sth like 
that might be better.

... or anything else that doesn't (ab)use the "advise" terminology in an 
interface that will not only consume advises.

>>
>> With Barry's series doing a prctl() for something similar, and a whole host
>> of mm->flags existing for modifying behaviour, it would seem a natural fit.
> 
> That's an interesting idea.
> 
> So we'd have THP policies and Barry's FADE_ON_DEATH to start; and it
> might also be a good fit for the coredump stuff and ksm if we wanted
> to incorporate them into that (although it would duplicate the
> existing proc/prctl knobs). The other MMF_s are internal AFAICS.
> 
> I think my main concern would be making something very generic and
> versatile without having sufficiently broad/popular usecases for it.
> 
> But no strong feelings either way. Like I said, I don't have a strong
> dislike for prctl(), but this idea would obviously be cleaner if we
> think there is enough of a demand for a new syscall.

Same here. I am not 100% sure process_madvise() is really the right 
thing to extend, but I do enjoy the SET_DEFAULT_EXEC option. I am also 
not a big fan of prctl() ...

-- 
Cheers,

David / dhildenb


