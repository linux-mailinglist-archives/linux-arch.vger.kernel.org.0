Return-Path: <linux-arch+bounces-12028-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED603ABE0D6
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0E61BA4BF0
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3471C5F10;
	Tue, 20 May 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7GmeViS"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515A248895
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758908; cv=none; b=EkngH/00suvn9rbmu+iFGrTRCY3iEdQoPSDmdFOOzXO6CZjgGEKM+NR6EMfdJd8sCA6jfzHb3NU5gwYOa/zj5fC+OCu/2AB2BaKwGEkkmZ01H66X1Ldk9g/w1qSXNQ9cAghvKeTQcYYd34mWSZuDf9GJkDUc60cE/z4M+2tccm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758908; c=relaxed/simple;
	bh=szeSQ0J+qD3QsqRaON48Nn+Wg54DX3y9D2NVeck5/Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErwKs0ek8da+osEDyvm/9xsGFcAuKADWcpy5yMEzF6C1TRszhEAGgJL8zaniPCprF87dtqaGVKqMkuj9Gu0OqiwxkmBeLd3BjeO4XCYnI+g7K7QfdHbA3vvnYqbFuMwqyL8lDZz4zCWJ+l+0VquKyYNDE9Isfix/tYPiRIfZpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7GmeViS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747758904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1drPzzm4ZSSlsJLuqsPhC6CpqswhlgU+/2J4e5+ruyQ=;
	b=L7GmeViS/nl0qrEI7iWzBcpAPwkWfGI3g7vLjDH0DUhLJSc4SbgPZnMDDAZw5H9vHsjL7g
	1+tCeAUFW6Y+6nFvsMkE82h11vXIU2nkgwYyu7xKAvRC1QOtAu4noEZDNQdF82Z6og7MWQ
	xtMw1fE/GFrCtRHLuhQDoo/S0WH1FeM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-AtWH0ko_MXqUNtw9RnwJ_Q-1; Tue, 20 May 2025 12:35:03 -0400
X-MC-Unique: AtWH0ko_MXqUNtw9RnwJ_Q-1
X-Mimecast-MFC-AGG-ID: AtWH0ko_MXqUNtw9RnwJ_Q_1747758902
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so41901285e9.2
        for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 09:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758902; x=1748363702;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1drPzzm4ZSSlsJLuqsPhC6CpqswhlgU+/2J4e5+ruyQ=;
        b=Ch3PRthntbVPzzRnhKsjne/knjc5isDAYBoVU87IYYYQDb9NgUbbnO4PohS8LzwWZw
         wiz9ywCMXckwuU6xhRWxb2U0/Y5CK3mhkrV6u/+g8BQpJQNq0upGjkm+YhNdgTaqLZRv
         cK14H/LyXdO2YolU0eQsWy651q/xpi40LODc7m+eC3pa8AaG8aGBFj0o8R3grZGTOW9b
         Nz2ALr4JhhXPSE7md7L+AVOWGq8XgIHY0w6TvrNodDlGQfv8KtmL0hzKp14TYDb92Nck
         6hFomw4A4/19hw0sUX9FVRHetH74tQkyH/0xPq9qwl/br9z9QzEg6W2y3Xm4qLHEEheP
         sJvw==
X-Forwarded-Encrypted: i=1; AJvYcCUyls+CMRKTAcrzLei+dKwrXMY99mxslBGLimh5Z9R6gHHFv2nVxe5isTK5u0Pl/5JeoyV1Nt5F8A/F@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIUEfdtUSytgkGEdx4LEv0dOhv5HiFL13mxr80W0/tnPIWVHU
	dUfTo5miAR4NRWY46VpTG2bG1FvQANCPgJHzb+b8q8Evm+OMAAbNeHhbb5uk0XanGsDw5iGJeCC
	UMn+BSUo30vOpKsks97TLE13s+Iwebx/pC7fjMMwP6DiFTxNXdXIwhGO50Dchhrc=
X-Gm-Gg: ASbGncskwfSgxThxADbTqTkrfZlnejJbBPOyJPogakixzV+wxJv09P8JLSWzEuqDoH8
	uB2i6Hmt2QsG07g9SotjO2sovbAcaVPUUD8M2XCmkc5CjBBR1iwwfGH9dk1KE5ePwNHaXjZ/LPx
	XpleLk/tNCywaUYT+C2qmJkfy7G+7wgTCyFySBR5iGfnAOacD8Bj2NL5y4sxIH4o6cyDGUjyNtP
	aqTsdYSZDNUZ74U+ShyPvo4ANLPQAJR9aJWbkUDgmWAJhplT9tfIeH3vyw7vwb+haevUX6Qyo0m
	qfTxoIBE42VRJqDORG0lwlbObzuZXpAB2JXxXhPY14YLuuTkUtlSDojLN2agmG9u1bjizl+gVqT
	UYxnH2vXADTGcvBfNnImn5gKULrBTea9Jq+4AOz8=
X-Received: by 2002:a05:600c:3b94:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-442fd60a517mr158731225e9.1.1747758902293;
        Tue, 20 May 2025 09:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpdgGOmX5Lylf83j7bynkogSQmow7Gg2MaCaySAEhqvRlh5mYvZBVzZh/21C3Jf3I9LVHVew==
X-Received: by 2002:a05:600c:3b94:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-442fd60a517mr158730985e9.1.1747758901871;
        Tue, 20 May 2025 09:35:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84? (p200300d82f287c00a95eac49f2adab84.dip0.t-ipconnect.de. [2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b295fdsm38705305e9.5.2025.05.20.09.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 09:35:01 -0700 (PDT)
Message-ID: <a40547f1-3a47-4ba0-8b7e-8f74f91a6b6d@redhat.com>
Date: Tue, 20 May 2025 18:35:00 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT
 process_madvise() flag
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
 <czd62f2vzwv6fow4ikvzlkjdj5odhc3nhtc72onwip52baobg5@yc5pjiqoqnh4>
 <CAG48ez2+UEifqF=GRat0dStPfDNXzzewHU=zxj0+FbOXL=mKVQ@mail.gmail.com>
 <24272ed3-0d16-412b-a7f4-78d02c347837@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <24272ed3-0d16-412b-a7f4-78d02c347837@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.05.25 18:19, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 06:11:49PM +0200, Jann Horn wrote:
>> On Tue, May 20, 2025 at 10:38 AM Pedro Falcato <pfalcato@suse.de> wrote:
>>> - PMADV_INHERIT_FORK. This makes it so the flag is propagated to child processes (does not imply PMADV_FUTURE)
>>
>> Do we think there will be flags settable through this API that we
>> explicitly _don't_ want to inherit on fork()? My understanding is that
>> sort of the default for fork() is to inherit everything, and things
>> that don't get inherited are weird special cases (like mlock() state).
>> (While the default for execve() is to inherit nothing about the MM.)
> 
> Yeah this is true. It is the exception rather than the rule...
> 
>>
>> (I guess you could make a case that in a fork+exec sequence, the child
>> might not want to create hugepage between fork and exec... but this is
>> probably not the right place to control that?)
> 
>  From my point of view it simply reads better :)
> 
> But perhaps we can drop the fork bit and leave that implied.

Yes, we should. Exec is where the "fun" begins.

-- 
Cheers,

David / dhildenb


