Return-Path: <linux-arch+bounces-12030-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51EABE296
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 20:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B37B7ABB9F
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FDB27E1AB;
	Tue, 20 May 2025 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YshlzDFY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EC262815;
	Tue, 20 May 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765449; cv=none; b=qPe8mUg/XQ2THXqqeAsxtdlaMfzpymWXpoU4uJ/6fU7JPb1iHnVskM42Sk4X1kq0sAtLLI2+SzifLwI/YkAPBCfwkxeypRM5edpYdnbPBG2n+xLIhaucgtUDRDCpqs8bzdKI6lVD7HR+4uigmDcgn3sMsHW1DrAAquzXX0XZZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765449; c=relaxed/simple;
	bh=ZmnsqxfQ/jk4uY36O0+7yWCTD6YuJ+6QFNdCQ1zwa4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCmd64mCDMq2Q5kQVz9h8hKYJ9Jetb5sJurkcB3gJi1LOq6df5aLjDzEluLL36J0JDHij6ruumud24LSIBLzEUwkyPPDDarncnKvkXdjaSYbssTcUcaHdZeeSZtdVApKLhsGSTDMktPTNDIe2h6QOeNCvh/IPkWvl0FaGpG4Oq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YshlzDFY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-601d10de7e1so4281752a12.1;
        Tue, 20 May 2025 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747765446; x=1748370246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nffkF+u3gxWSeDAE8Itf37lA75RK6Rf3vh9YRGkMt4g=;
        b=YshlzDFYd5zEKXnBRxZa3Lrnm+esUCVeqkl8A95FXlSGXA+iHk3ug5mSYEAeQJTQU4
         6ERC84WM8WbQFY/T7YGLlTqY/M3QwzwjgCNuslyw4brpFkolNhYHdLFOVAhl882AaPv/
         p7WIQZQiLORjx6Rmny4p3gF2Tbuv/UZO3EsGJZVRbm7CkcdFPqButMwkE/aeiTp+wVlJ
         C0BBN/WmLtyp7lOvji4mH63B4inswBKwcanydq01lGhhXQtD6rSXN9XFS8SiaEYE6s7m
         P6bsPMwyr/8GbwwwS45veYzcKrQ4/U80jYuqLbTWqWNyLTAQ4SwPplo6Qaa/N9IQUOMq
         PWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747765446; x=1748370246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nffkF+u3gxWSeDAE8Itf37lA75RK6Rf3vh9YRGkMt4g=;
        b=A1M0lRja9/agwePzXQ0K4hcnG+Fp5HOSFNiB9VkfK6oLuXxQa0W4eRaCVP18e2YqJl
         /BPzCzMkmPyIt8xv9C7HCGvIKKpPstHqx9j9jd08nZGdSQlMepO/K4w3z4quQxgJpi91
         mZMWY0XPjCQuv3zlLmKNIyWez7J89R2Ofm+D6eyT3ge69KDGC1ld3ELRYmr6GmgmB58B
         DYwIyMPx1VQUZgbIvRTuKpborsk2BAzPIBw1V3zPledAH4/apwN6jqlMTaX2Ep542kCw
         JZAEtQ/GeUWfVour1pTRu2x64mARc/mQ2iH04jnpOG7SPNZE3piRLQDmaF9QN1B9ctzv
         Oz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaikNgBLKEmJ06YGg87qj+1/8CzgZnTCS5osKnORnX0r42nql/2JD79mZ6eXv1Xyn3ljGJtYpkZbHCKAxH@vger.kernel.org, AJvYcCXp/MXsLJZvjdaOvXftSMf3uEZrhboOVVKGi/CVNx96v/n9RwfdrnYLckAAkqqf/ljM0WN0qf6h2Kyb@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZKzoxaO0rWO218FdEBNMXNdEh35D0753BIcbvxjYrYW4lBV6
	p7RBwX6VrLqiY9vK/dfWdCSGE0WrSN8BVQJU04+pQMWhHmNWqVSo3Y8I
X-Gm-Gg: ASbGncuKCYPtL1jfHM7kTF3F9LOJ7Ux2UfHrdvu07mtZrHS5fdy0eE1xr6YzxSewcT7
	+ZvI1dS16Q6aPRrTPhyk4KJaKQKLFg1m98zzkRm2N7V4g78Q7T0iTAbXvkPPNoZs1YVrd//eHpa
	srph/kqhaDZGJ3t3Ya6qr/WUkk0/R/jpPMdkuNOSHJ+fVaFWoB7ufb3wkrH+QED0FpDsB+cIYFZ
	pxtoINlU1H+tWHqGPH2HsCcrDVawg3yPKpVCilz9tsoxVLxjqrBIwG7VtSVzK5GM3NSnoi6+XS9
	xmDw/MO23WMdO8QrnOexeKyvvKOo7tVEIVnxpd3z78B0fA0E6c1QLFFWtR/7mh0Wshrff/y/88t
	ASWf0MYhNUAKTVSjGLk9L3oVZYELmiw75ouU=
X-Google-Smtp-Source: AGHT+IFTobyzwp/Ssql6CtGjBJbbB1JEAC6BoxecpIJmcboc9SYnQ2a6Sjk18KiBZWcMeWJN4+yURQ==
X-Received: by 2002:a17:907:2d1f:b0:ad2:40ee:5e29 with SMTP id a640c23a62f3a-ad536b56f88mr1563874466b.10.1747765445523;
        Tue, 20 May 2025 11:24:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1c0a:f3ac:4087:51c8? ([2620:10d:c092:500::7:66a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4ca5c5sm764129766b.162.2025.05.20.11.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 11:24:05 -0700 (PDT)
Message-ID: <ae53fa82-d8de-4c02-95f7-7650a03ea8e7@gmail.com>
Date: Tue, 20 May 2025 19:24:04 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Zi Yan <ziy@nvidia.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <dd062c92-faa9-46a6-99a8-bcc46209e102@redhat.com>
 <c54d2c5b-e061-4e77-ac10-3c29d5ccf419@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <c54d2c5b-e061-4e77-ac10-3c29d5ccf419@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/05/2025 18:47, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 05:28:35PM +0200, David Hildenbrand wrote:
>> On 19.05.25 22:52, Lorenzo Stoakes wrote:
>>> REVIEWERS NOTES:
>>> ================
>>>
>>> This is a VERY EARLY version of the idea, it's relatively untested, and I'm
>>> 'putting it out there' for feedback. Any serious version of this will add a
>>> bunch of self-tests to assert correct behaviour and I will more carefully
>>> confirm everything's working.
>>>
>>> This is based on discussion arising from Usama's series [0], SJ's input on
>>> the thread around process_madvise() behaviour [1] (and a subsequent
>>> response by me [2]) and prior discussion about a new madvise() interface
>>> [3].
>>>
>>> [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
>>> [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
>>> [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
>>> [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
>>>
>>> ================
>>>
>>> Currently, we are rather restricted in how madvise() operations
>>> proceed. While effort has been put in to expanding what process_madvise()
>>> can do (that is - unrestricted application of advice to the local process
>>> alongside recent improvements on the efficiency of TLB operations over
>>> these batvches), we are still constrained by existing madvise() limitations
>>> and default behaviours.
>>>
>>> This series makes use of the currently unused flags field in
>>> process_madvise() to provide more flexiblity.
>>>
>>
>> In general, sounds like an interesting approach.
> 
> Thanks!
> 
> If you agree this is workable, then I'll go ahead and put some more effort
> into writing tests etc. on the next respin.
> 

So the prctl and process_madvise patches both are trying to accomplish a
similar end goal.

Would it make sense to discuss what would be the best way forward before we
continue developing the solutions? If we are not at that stage and a clear
picture has not formed yet, happy to continue refining the solutions.
But just thought I would check. 

I feel like changing process_madvise which was designed to work on an array
of iovec structures to have flags to skip errors and ignore the iovec
makes it function similar to a prctl call is not the right approach.
IMHO, prctl is a more direct solution to this.

I know that Lonenzo doesn't like prctl and wants to unify this in process_madvise.
But if in the end, we want to have a THP auto way which is truly transparent,
would it not be better to just have this as prctl and not change the madvise
structure? Maybe in a few years we wont need any of this, and it will be lost
in prctl and madvise wouldn't have changed for this?

Again, this is just to have a discussion (and not an aggressive argument :)),
and would love to get feedback from everyone in the community.
If its too early to have this discussion, its completely fine and we can
still keep developing the RFCs :)

Thanks!
Usama

