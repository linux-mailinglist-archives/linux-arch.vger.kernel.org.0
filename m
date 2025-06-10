Return-Path: <linux-arch+bounces-12315-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E9AD3D5A
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 17:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800747B0A9B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE1237194;
	Tue, 10 Jun 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV0FkpdT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6FC133;
	Tue, 10 Jun 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569449; cv=none; b=BiKMe8P9fK+fOQ9Hvmp/OELgNN54gnKs4H5YXb+Hvm//2AXdhkn0THXpWHDchewDBdGNw5GbTncziaECAseE05B/gZuxXPgDvvNhTNdHx1FBSXzmUav/1awyBEhGI/E6Jc1oqqM04uyGYTuNRmv5CtqcoFih0jSRfdgbRvX93LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569449; c=relaxed/simple;
	bh=Pu66h1FXrk1ccRbzPP0xh+nMsa8oTTl9nJfsbwgc0oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWqi6zzyrQUYMMF6DXSx0ceskb6O51DtzNjebSTT0IvQ/aQIbt6MfxRD1Gr3YA5oDx3oAF82hx5clLj6J9yT6uPqbYaur48eyU5BzxlNGgcmQd3qNKiz5U+arA8+IMQnuJUjqJFQeOSYhvR/LT1wtpdfBrjwWrBxuJTRqS0CsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV0FkpdT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-addda47ebeaso1080619666b.1;
        Tue, 10 Jun 2025 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749569445; x=1750174245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KxXjMWsc4kiONjKU0EHZgLfdDeBtPvIvaVMvTA9nU4=;
        b=IV0FkpdTrwInyiJBl9v6FLXflPWk3xnRMtqljAhqojloYFQqlMjteelepa+5iu/40i
         AaL6D7zUvsrAwWNrHfO4VmF5AjMHwOOo0yj0Mncm/C1Sn+VU5OVlKmjRRk8HvvTzajjc
         mPjakDL3agohHw3fmqf+EtboPUPo7/ZAJ5JNj1mvLktUDV2UH4TiWmm6PK52oPWDA+gG
         8pvq7F4VtvxZ5xGjzmyNYTF85tZ7rAKdDSH4qzkuGirWmn3LXNyZuWXeFfFlKSAiLFHH
         2dE8Qm/E5UArJqjmYlx7RsvSV/SzZrYo7vFIXX0hUZhk7+4+pkjRDYGBTczzLVywHKAR
         a+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749569445; x=1750174245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KxXjMWsc4kiONjKU0EHZgLfdDeBtPvIvaVMvTA9nU4=;
        b=M7PEkUOKXhr2n9vuNUfnhYAGbEYlWpYzSndtoK9WRliXiEbOi5rJ7Kha9Jcj0XOvX1
         ZSDjmbtal9YvniMjDvEzTsgIbji7Z1j6cV37uWpzv0+0jrM5ajpoeXMQPN6AjGMmFKGd
         AAkyFg7wPE//CjdSqTzQicyf0aevhKewuGhTSGrhpYzgnM1YGB2o7XLVNd9rcHsGCrBE
         bQNmC1zZ5tw3cvyVXxoy5Mk79X7dPSpPylKnGQOkN/h48qIZ+CKv1jSXUFIjD8KC7Oh4
         NDI2XHnI+XPPcssVm6UbXbANp9Qoz4vZkx6IH8ywukWpPUnIHT/1nMRJFUd9X8xpvrFU
         LGOA==
X-Forwarded-Encrypted: i=1; AJvYcCUDHKMa5RGJRtfiv4b5AdB4S/646WNYEiXAPRe7bsp0zddWjR0vx0zSsCQlajh4ZLEZoZl0gtCOf3GJOA==@vger.kernel.org, AJvYcCVqvkkWlhZxjO/YROw2vyqsWT4Tlxhik5i+FmdO6tSL3tvI+hmnET3n2RsWbftq05OBTRmmJewOXyGqyk1H@vger.kernel.org, AJvYcCWgEHAp/4tr/4mU/Qatgfz0zYG3dsqw91mc7nDSzUIrIR+kl8/AQ0KU/NyHby3PNnnkqtEvn7m2Zaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3eQCC6/4yrzGnBzzDTDm8LZZj5o7v1GmuW11HBGchp3loX8d
	Q+u2+U8J9nz3C63m5HjH3+jYmDL2SZ+b8USvvFLfzb00Ft5IQWYNa2tn
X-Gm-Gg: ASbGncuiTK1dEWQ9+eVsu3FJl2ih0P0RFzFjER0wZuzZDJb+Fq6mPYSkE+DmbwLnS4G
	G8x+KRkFY5kzhKQzDcSY6nykYVcqreco0lY0KfRFBIeRFmRsv7eZHzYL6uuslaIGQRwQXa3TTKL
	iVvaD4MrQPQ01+9663FhPnqDy97u6hF4vINQaKK9GsGZXHE9yB4yMXUtyLb3uQlgbBU5UJir2lX
	06tPl9jarUiwsgmiDtYiOih55xq+pB+UaZOx6WPHdNrOjx8O/g67FXMT72YnpW6yrNKDvEuM1uP
	OO2+hxXjBBELFb29Sz3NkbjtZTKYJUZ61XWdI3rOn9ZgD0U0tjh0czdPFBi/jyiiwlE2KJ9f5Xf
	jaSH2Vr3tSplehovY/D9wHqerR5jP39eV8otBmQ==
X-Google-Smtp-Source: AGHT+IH/PmzqOQmwt2N/paPLph3QOSAP//P2dit1qoFl7YHlvMpadlUnH+Ly1IPa8Mqxklhv49Ml6w==
X-Received: by 2002:a17:907:940b:b0:ad8:8883:9fef with SMTP id a640c23a62f3a-ade1aa49831mr1564208466b.26.1749569444828;
        Tue, 10 Jun 2025 08:30:44 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:c2f:a34:6718:ee1d? ([2620:10d:c092:500::7:b9b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d753a6csm736225566b.2.2025.06.10.08.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 08:30:44 -0700 (PDT)
Message-ID: <2fd7f80c-2b13-4478-900a-d65547586db3@gmail.com>
Date: Tue, 10 Jun 2025 16:30:43 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] proposed mctl() API
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 SeongJae Park <sj@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
 <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
 <f8db6b39-f11a-4378-8976-4169f4674e85@gmail.com>
 <fcaa7ce6-3f03-4e3d-aa9f-1b1b53ed88f5@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <fcaa7ce6-3f03-4e3d-aa9f-1b1b53ed88f5@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/06/2025 16:17, Lorenzo Stoakes wrote:
> On Tue, Jun 10, 2025 at 04:03:07PM +0100, Usama Arif wrote:
>>
>>
>> On 30/05/2025 14:10, Lorenzo Stoakes wrote:
>>> On Thu, May 29, 2025 at 06:21:55PM +0100, Usama Arif wrote:
>>>>
>>>>
>>>> My knowledge is security is limited, so please bare with me, but I actually
>>>> didn't understand the security issue and the need for CAP_SYS_ADMIN for
>>>> doing VM_(NO)HUGEPAGE.
>>>>
>>>> A process can already madvise its own VMAs, and this is just doing that
>>>> for the entire process. And VM_INIT_DEF_MASK is already set to VM_NOHUGEPAGE
>>>> so it will be inherited by the parent. Just adding VM_HUGEPAGE shouldnt be
>>>> a issue? Inheriting MMF_VM_HUGEPAGE will mean that khugepaged would enter
>>>> for that process as well, which again doesnt seem like a security issue
>>>> to me.
>>>
>>> W.R.T. the current process, the Issue is one Jann raised, in relation to
>>> propagation of behaviour to privileged (e.g. setuid) processes.
>>>
>>
>> But what is the actual security issue of having hugepages (or not having them) when
>> the process is running with setuid?
> 
> Speak to Jann about this. Security isn't my area. He gave feedback on this,
> which is why I raised it, if you search through previous threads you can find
> it.
> 

Yes, he is in CC here as well. I have read it in the previous thread. Just raising it
here as it was mentioned here :)

>>
>> I know the cgroup proposal has been shot down, but lets imagine if this was a cgroup
>> setting, similar to the other memory controls we have, for e.g. memory.swap.{max,high,peak}.
>>
>> We can chown the cgroup so that the property is set by unprivileged process.
>>
>> Having the process swap with setuid when the unprivileged process has swap disabled
>> in the cgroup is not the right behaviour. What currently happens is that the process
>> after obtaining the higher privilege level doesn't swap as well.
>>
>> Similarly for hugepages, if it was a cgroup level setting, having the process give
>> hugepages always with setuid when the unprivileged user had it disabled it or vice versa
>> would not be the right behaviour.
>>
>> Another example is PR_SET_MEMORY_MERGE, setuid does not change how it works as far as
>> I can tell.
>>
>> So madlibs I dont see what the security issue is and why we would need to elevate privileges
>> to do this.
>>
>>> W.R.T. remote processes, obviously we want to make sure we are permitted to do
>>> so.
>>>
>>
>> I know that this needs to be future proof. But I don't actually know of a real world
>> usecase where we want to do any of these things for remote processes.
>> Whether its the existing per process changes like PR_SET_MEMORY_MERGE for KSM and
>> PR_SET_THP_DISABLE for THP or the newer proposals of PR_DEFAULT_MADV_(NO)HUGEPAGE
>> or Barrys proposal.
>> All of them are for the process itself (and its children by fork+exec) and not for
>> remote processes. As we try to make our changes usecase driven, I think we should
>> not add support for remote processes (which is another reason why I think this might
>> sit better in prctl).
> 
> I'm extremely confused as to why you think this propoal is predicated upon
> remote process manipulation? It was simply suggested as a possibility for
> increased flexibility.
> 
> We can just remove this parameter no?
> 

Sure.

> It is entirely orthogonal to the prctl() stuff.
> 
> Overall at this point I share Matthew's point of view on this - we shouldn't be
> doing any of this upstream.

As I replied to Matthew in [1], it would be amazing if it was not needed, but thats not
how it works in the medium term and I dont think it will work even in the long term.
I will paste my answer from [1] below as well:

If we have 2 workloads on the same server, For e.g. one is database where THPs 
just dont do well, but the other one is AI where THPs do really well. How
will the kernel monitor that the database workload is performing worse
and the AI one isnt?

I added THP shrinker to hopefully try and do this automatically, and it does
really help. But unfortunately it is not a complete solution.
There are severely memory bound workloads where even a tiny increase
in memory will lead to an OOM. And if you colocate the container thats running
that workload with one in which we will benefit with THPs, we unfortunately
can't just rely on the system doing the right thing.

It would be awesome if THPs are truly transparent and don't require
any input, but unfortunately I don't think that there is a solution
for this with just kernel monitoring.

This is just a big hint from the user. If the global system policy is madvise
and the workload owner has done their own benchmarks and see benefits
with always, they set DEFAULT_MADV_HUGEPAGE for the process to optin as "always".
If the global system policy is always and the workload owner has done their own 
benchmarks and see worse results with always, they set DEFAULT_MADV_NOHUGEPAGE for 
the process to optin as "madvise". 

[1] https://lore.kernel.org/all/162c14e6-0b16-4698-bd76-735037ea0d73@gmail.com/


I havent seen activity on this thread over the past week, but I was hoping
we can reach a consensus on which approach to use, prctl or mctl.
If its mctl and if you don't think this should be done, please let me know
if you would like me to work on this instead. This is a valid big realworld
usecase that is a real blocker for deploying THPs in workloads in servers.

Thanks!
Usama

