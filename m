Return-Path: <linux-arch+bounces-8446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A03B9AC009
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 09:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5FE1F26127
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 07:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E231552FD;
	Wed, 23 Oct 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjwuUp+M"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01C154BFC
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667952; cv=none; b=mPJveJU2WG3QUgHOhwidB8Z08UrfqGmqpfiqBTFN/fwoBfwISuNjFMYBI1NwTlQ8lHr27vO9IPHTQIEh0cNiB0NBBcXAExX43qhgkej5TUTbXmxI0OBUEpvEfHIFKBOUZT7vyWwNz41Bb+exOhtPqsZfNP98WDST4mFCGHhX97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667952; c=relaxed/simple;
	bh=bKrUGf4U7cuFbm/oePLuNwJ0rXtkr0eVGYDs+YteWIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LK5rHv5veTbYMczIQlTPnzo7CPALVvwHoNZm785pxOYz4U2BPiyA8p7FCELzmqGA83bj3Ym65ANDO6Rq85un1JjW9/r7D4WoXPlnhTqU6OvKcNkfV5uQU9vX049Lm07q3odSlNlc8iTJ9MpSji5Z4yUQaCtBhq87fb2ZKc8p+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjwuUp+M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729667949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2J8ZqubO+8AlKbFE9Qv2kRLiKggvUmjZRZtAw8rfrEY=;
	b=XjwuUp+M7Sq75P4Tkp6gUAtALTFniP9d/EDhT8BqCUMGQhTAhXGKiC0YfybY9NTvNxR4vH
	iyzCRj5cuOoIi/HH9DkI/MNmkq5gMjzfXqOy3ImYvKIZuIGnOazLvsYTT0ykJJWAhMzWXh
	9tnAEyvWY6yLtNZIMZO/DQllPVa5Q4Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-YvPQ21cBMlKvCTPuQP6h7Q-1; Wed, 23 Oct 2024 03:19:08 -0400
X-MC-Unique: YvPQ21cBMlKvCTPuQP6h7Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d5116f0a6so3169819f8f.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 00:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729667947; x=1730272747;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2J8ZqubO+8AlKbFE9Qv2kRLiKggvUmjZRZtAw8rfrEY=;
        b=gEeua36mzS6vrq+vS5PJSonAWc6g/wdw3MU5dhONz/y34xlWWepdVcRnJc1/rcv3C/
         sfG4Y2Z/wqpolCxhfGFYIPlLpaLiQBku5kLAewgXO1JqohQ+n34Vma8KX7akYKF/CcoG
         DrrNaRdVg9U+bvUr6mOrccSe+Ho7Ko/uPL2M8w8AVq7KxzTO7ITN2KqE0YVWHUr9N6os
         3GQYZzXGTqL4aFdcfOaTuussL7AS+RZwvaaW5944y9E+eIIU86fKu/wdRzIzBvP4sI3E
         LlBfPwQ5FnjYeUE0/ZCEIXr3/aofTp/URP+YqrVCM9k4ahxW9hbDEyVNlupTp2WMi8Re
         hanQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAN+ddtrhpaOgycxynlbodUxMAvM1rTellugViYhJcGs0mKd5Gkd09yJ7s8tDe6ECunATvSkKqUsyN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4x/TaTA4+a/wDFP/4KO7cM0T7jkdmJRrRLKQhctEr+OP851h
	9UK2dNotlmXCt87EV/P+R/LLN8czcoLo5XoYul+VB5sGJ9kMnO0jhd4mC/ntmVzT7sMCsk8WWr6
	IN6Bh7OGx0UJeQVRVm1ycGM7OCLASc+D8qm3htkuQ2XjGDuin+j9y17UUyoI=
X-Received: by 2002:a05:6000:d08:b0:37d:446b:7dfa with SMTP id ffacd0b85a97d-37efcf7ebd9mr912446f8f.39.1729667946894;
        Wed, 23 Oct 2024 00:19:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqzEDQ57fgD1+CK3sngwj8y5ncZ+zhRCIKvEIDF/zJ+B/m+m+ZwPj3lma4Yv4rl/K1V35C/w==
X-Received: by 2002:a05:6000:d08:b0:37d:446b:7dfa with SMTP id ffacd0b85a97d-37efcf7ebd9mr912404f8f.39.1729667946324;
        Wed, 23 Oct 2024 00:19:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5? (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de. [2003:cb:c70c:cd00:c139:924e:3595:3b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37d25sm8269356f8f.23.2024.10.23.00.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 00:19:05 -0700 (PDT)
Message-ID: <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com>
Date: Wed, 23 Oct 2024 09:19:03 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
To: Dmitry Vyukov <dvyukov@google.com>, fw@deneb.enyo.de
Cc: James.Bottomley@HansenPartnership.com, Liam.Howlett@oracle.com,
 akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org,
 chris@zankel.net, deller@gmx.de, hch@infradead.org,
 ink@jurassic.park.msu.ru, jannh@google.com, jcmvbkbc@gmail.com,
 jeffxu@chromium.org, jhubbard@nvidia.com, linux-alpha@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-parisc@vger.kernel.org, lorenzo.stoakes@oracle.com,
 mattst88@gmail.com, muchun.song@linux.dev, paulmck@kernel.org,
 richard.henderson@linaro.org, shuah@kernel.org, sidhartha.kumar@oracle.com,
 surenb@google.com, tsbogend@alpha.franken.de, vbabka@suse.cz,
 willy@infradead.org, elver@google.com
References: <87a5eysmj1.fsf@mid.deneb.enyo.de>
 <20241023062417.3862170-1-dvyukov@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241023062417.3862170-1-dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.24 08:24, Dmitry Vyukov wrote:
> Hi Florian, Lorenzo,
> 
> This looks great!
> 
> What I am VERY interested in is if poisoned pages cause SIGSEGV even when
> the access happens in the kernel. Namely, the syscall still returns EFAULT,
> but also SIGSEGV is queued on return to user-space.
> 
> Catching bad accesses in system calls is currently the weak spot for
> all user-space bug detection tools (GWP-ASan, libefence, libefency, etc).
> It's almost possible with userfaultfd, but catching faults in the kernel
> requires admin capability, so not really an option for generic bug
> detection tools (+inconvinience of userfaultfd setup/handler).
> Intercepting all EFAULT from syscalls is not generally possible
> (w/o ptrace, usually not an option as well), and EFAULT does not always
> mean a bug.
> 
> Triggering SIGSEGV even in syscalls would be not just a performance
> optimization, but a new useful capability that would allow it to catch
> more bugs.

Right, we discussed that offline also as a possible extension to the 
userfaultfd SIGBUS mode.

I did not look into that yet, but I was wonder if there could be cases 
where a different process could trigger that SIGSEGV, and how to (and if 
to) handle that.

For example, ptrace (access_remote_vm()) -> GUP likely can trigger that. 
I think with userfaultfd() we will currently return -EFAULT, because we 
call get_user_page_vma_remote() that is not prepared for dropping the 
mmap lock. Possibly that is the right thing to do, but not sure :)

These "remote" faults set FOLL_REMOTE -> FAULT_FLAG_REMOTE, so we might 
be able to distinguish them and perform different handling.

-- 
Cheers,

David / dhildenb


