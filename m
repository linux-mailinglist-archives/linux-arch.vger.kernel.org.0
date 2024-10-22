Return-Path: <linux-arch+bounces-8427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF49AB69B
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1104281CD4
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F01CB324;
	Tue, 22 Oct 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMnBV/x6"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889391C9ED8
	for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624703; cv=none; b=ILjq8xPnuc1+MChTvH15MvsXpbdzNiczy+NbiNJs+xEJIIRuUlVjSJuezaxKwpFu1wHtAf8oSEBvHehihcdKFiBH4gB0TAZgSADL1QjP24wdUhXnEYciHNdfn9RIQADbOVp47mkyKFvXKzi6NGE9p6HC9tjZTDoZT3R039exE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624703; c=relaxed/simple;
	bh=ktGBOrU2ibyKA1CLQpoQeK9t4bLhf2yY7EYFTFIdFqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvAdxsFEpjfwxt34WSf765uK9ZABjU1XM0nvIV0i5OAO3MzqZbm1DX7/vaBYxDn9scl9Jm6UIOPQR/e7oeY9QnYGl1tPkm1qBrNeNe4zlWDiRG/mLMPGZ9LDo4uA0kP8nedIuTQA9C3VVtt1zyooHQ0rc1RyeBzIjoUc8tr26T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMnBV/x6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729624700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nMzc8QHGqocB61rX5XoKNwKEs55suX3e2g56nFdKa9s=;
	b=MMnBV/x6QVhw71zKf2GIslaFB0eiZwy8cbZFQH8MZr7/ulbqVVY8EcCxOJtbYTurnHKox6
	h0RMRZRJ34Sklr92KwUNKJaAMTIRdfFhufV7WDeYIF89ZtPV2Fzsvcfk1EWDVlwk/Zw6nE
	X/wEgY8epgqaD/jhjTlwAVRT2nhtqIM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ie7arWsYNvOSEAbIKr9pRA-1; Tue, 22 Oct 2024 15:18:18 -0400
X-MC-Unique: ie7arWsYNvOSEAbIKr9pRA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d52ca258eso2958888f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 12:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729624697; x=1730229497;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nMzc8QHGqocB61rX5XoKNwKEs55suX3e2g56nFdKa9s=;
        b=gKiKO5WnM+xqWBK6k+gbKFmps5YftnNhXywKTEaZyuNmXoBib2njA+YvM5r9UWWNWS
         5YY6Z0V/Mzsn/JkBUUupagFfw6HvFhvRqjih185hxVRk5y9mJEpKOztl0K0mMZ18nEz/
         TObUm2qHiqIoMRAs8c8UP4/UPa1ZzuApDlbLIrx8nfa9TWPNxPH1iGDhYPS1HU+1WFfh
         ngdTxjM/P9lAMfph8MN59t3H4arTfjMQsNLxvw5OMlx7VQA11L29YP0Yq2Ca0ouU/Jhu
         OlNht1r/291TED4MJybEKLiypb8123u6f4AXWTA6od6ZPOWVydPfvQiZP69qTBbCLVxS
         IV+A==
X-Forwarded-Encrypted: i=1; AJvYcCVfnqRYkYCI09VWKFZdHiol5W3PHYufB6Vynd2SiL6/uSj92V33inUI3fPGSbmovv4jXblJi5Sj2xPp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmoo5YmctLyx4YujcbltpFqYaL/muv1RNippHs7wV8kr4jHjCm
	R61xxL6FaEZ8/F6BnAJcMJMHFuer8JZHTh2fiNC+fGtZet5mlKD35sZMaaY+byK1Kk+O6tsXIJ1
	/35HdUieSJts/WL9e6zJOdmDlnzboSSLfTo7J9aFuo9lA/yShobb3Bg+9mm4=
X-Received: by 2002:adf:e5ce:0:b0:37c:d11e:949 with SMTP id ffacd0b85a97d-37efcf1af60mr18278f8f.28.1729624697267;
        Tue, 22 Oct 2024 12:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoPK9FsuMMcR3vFXuE14B+EV27LkHnlyKqvIJrsQXoZ6JmxepIiPSXUkeIqXtkohYh9SxL/g==
X-Received: by 2002:adf:e5ce:0:b0:37c:d11e:949 with SMTP id ffacd0b85a97d-37efcf1af60mr18238f8f.28.1729624696851;
        Tue, 22 Oct 2024 12:18:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f700:352b:d857:b95d:9072? (p200300cbc705f700352bd857b95d9072.dip0.t-ipconnect.de. [2003:cb:c705:f700:352b:d857:b95d:9072])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93dfesm7173437f8f.66.2024.10.22.12.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 12:18:16 -0700 (PDT)
Message-ID: <2eaaff77-ec6e-405a-825a-168fe49c0884@redhat.com>
Date: Tue, 22 Oct 2024 21:18:14 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
To: Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
 <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
 <9727ada4-0048-499b-a43f-ac0a625bae5d@redhat.com>
 <73134e10-19eb-4e52-b87f-5fbfd322b575@lucifer.local>
 <0f7a6b69-5706-4010-ba7a-68a071922c80@redhat.com>
 <b92c58da-ec94-409b-8cdf-46eb3d2c7870@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b92c58da-ec94-409b-8cdf-46eb3d2c7870@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.24 23:35, Vlastimil Babka wrote:
> On 10/21/24 23:20, David Hildenbrand wrote:
>>> I don't think there's really any value in that. There's just no sensible
>>> situation in which a user would care about this I don't think.
>>
>> Making sure nobody touches an area, and wile doing that somebody already
>> touched that area? I guess it could be worked around by
>> mprotect(PROT_NONE),madvise(GUARD),mprotect(PROT_READ|PROT_WRITE) ...
>> which is not particularly nice :)
>>
>>>
>>> And if you're saying 'hey do MADV_DONTNEED if this fails and keep trying!'
>>> then why not just do that in the kernel?
>>
>> Heh, no!
>>
>> If user space doesn't expect there to be something, it should *fail*.
>> That's likely going to be the majority of use cases for guard pages
>> (happy to be told otherwise). No retry.
>>
>> And if user space expects there to be something it should zap ahead of
>> time (which some allocators maybe already do to free up memory after
>> free()) to then install the guard. No retry.
>>
>> There is this case where user space might be unsure. There, it might
>> make sense to retry exactly once.
> 
> I've thought so too and the RFC was implemented like this, but Jann came up
> with a scenario where a THP can cause the range including our
> to-be-installed guard pte to be populated even if the userspace is not
> trying to access that exact address, see here:
> 
> https://lore.kernel.org/all/CAG48ez3vqbqyWb4bLdpqSUnhwqGo2OQetecNhEGPdCGDr94nbQ@mail.gmail.com/

Ah, THP, I should have realized that myself. Yes indeed, in some cases 
we'll have to zap because something was already populated. Not sure how 
often it will happen in practice, will depend on the use case.

For use cases like one "one static guard page every 2MiB", I would 
assume we install the guard pages early, before expecting any page 
faults in that area. Likely there are other ones where it might happen 
more frequently.

For uffd that does not apply, because khugepaged backs off with uffd 
enabled and the only way to resolve a fault is using uffd -- which 
places exactly what was requested by user space. So, no populated PTEs 
without actual page faults on the corresponding virtual addresses.

-- 
Cheers,

David / dhildenb


