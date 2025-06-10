Return-Path: <linux-arch+bounces-12321-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7115AD3FDF
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 19:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C231BA07E5
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB1243946;
	Tue, 10 Jun 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTTNpxAN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9323504C;
	Tue, 10 Jun 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749574976; cv=none; b=HhJL3eFDCrnTuyqCgrVApaEAemjNw+crBc8kHszTZ0L5dfnV1UuYYBUpSL4pykenKpqMgxbcfBCaPa6mqSFiWRM2DKswqi38/OofZi82sm2QcNRSPQgWU+rkT7SADMIu+pWNVo28jG5ym+Trrv5+S7zrEQU+kcyijYkNylvKIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749574976; c=relaxed/simple;
	bh=9W7HsRXyelERoAPYEnmWpZVNSSibgcPUxsvcR8XNGUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USqQWAuWbuA45XMFKh3PeJ7VGRcfOxSg93DFMqQuEV4DfsXOLMO/NokwAtVGevKlk/nu9cYubhfPrYPSWKanuMJhIw50J27CfCvEGM/qrC4ZqX7epR5BP4gUduwIKVkqveYl24JIaDeI+YjA26HCGqKd7FCDr/3XxhGgUdSvcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTTNpxAN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb4e36904bso1118728366b.1;
        Tue, 10 Jun 2025 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749574972; x=1750179772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZ7WoPO17MArlU44RnHfwxsqfSq5i/WMEMR9bfmcvug=;
        b=kTTNpxANPdd29aiJpOplSQWZvnuT+foV6HpdjTAMEd7IsMUoYKsQpZU9GrVrwY1Pci
         +Tp0Kx889pCNcTfEC05legtC/QRVuGKXzUxG8NVhcvfudTMDPkhUw0fQ1hn26OH3Ol60
         Km63CXGDJ/r40QPHD47kB3P5aEi4dfFaftpLryuflaDHP+wBIj9RdLpgG3ZU7rkNXoB+
         b/WKdzu8YPqb9r7RMJUQFERSYAHHFyZ9j5iHpnGhNPKdVtmfCBMtdTWuIxvGuu+cWSyk
         sT5cmD6/nKDNJz3CQqqY0mwfEr+LwUf7nfRzjhG32bZVMDYNMSmaUGY9P5ZXmPbqpqZr
         CrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749574972; x=1750179772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZ7WoPO17MArlU44RnHfwxsqfSq5i/WMEMR9bfmcvug=;
        b=nThhwTlI1KXEDUetlhocbomPhl/clfQQ0EELsd2BYjLoffRjl4CpNBxP1MBMlg1yma
         VIEUb9LOlILOIDkjecYFxQ4J7TJmyBfHIrPg6Vr6anejFuCACxwEENl0zYacX0Q+n/MI
         4BaaVIWd9J86C0FUXpiemReLFfey2K39gGuqNVdaN9wTGfMDJgO0mqlzo4EjOpNlgzGw
         QmhOH1S81okw55EmZBTg1rfBsTI376Uh7oqAXPSjA43hpwATs16yqgeYiRX/VI/k54eG
         Rf7WZnG7ankNLM/QgBJj55N+kDfLYWW05DBgfVgRAB9BArCzWGtan78x1Nh/Ax110kqJ
         ZP9g==
X-Forwarded-Encrypted: i=1; AJvYcCV9UUI2dle9b2bUSWyA1p6hlKb2GSksfImmWOTL2WJfiegl9CPXivYIBYSbP16zGvbIlc2pWDhLolb2e7Sy@vger.kernel.org, AJvYcCVJJEA6iKeg8F8h74q2g3EMkUNdamitF7OIGmrT4KdKuNy0JyK6V/UoHwbh39ehIt8fN5OJHWclw48=@vger.kernel.org, AJvYcCXIdkrplaIzLe3/2FiMncIUwNko/6disvK/bbKtX4Pb1Q8qWI0lyTKC+peV7sJ7MryXTlqwtyiJ87tuXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0Fu0HGMgnPVdTQsEDY6OmcIWf+d0oidz1QFT6avnQqJRcW0v
	M8T0jjOaFQmgqlqVNvCz0cbGx/W/qmCSq3TQkkNFL4ZPM+LIPhdUVkyv
X-Gm-Gg: ASbGncvH5UZS424XESp7S7P/XYl0J2rD3n39a1NtwRSBWQAhq1VeWjtKk4oVxgeq+YM
	LlYAqXArxuM61ry2FmaVyk1XwmMdmgOAbL6ywRI2DGBgg22edKd68l1e3k73f/z5Ip6t+oIr8TY
	kE5qBDN1px2tq2iZHV6abXJOb+qKNUJpU6kcHQvTuHCFz+0zQadMmHNSv3mbNHOdJ248RHivlsm
	GtoVxSytjWG/0sHd1+KwJ9wYhXdUeXyg82KUmtmIBY4mbqZMJ/nd9QmnRGWWIi2PIn1+2e/2McJ
	4drV0DRZG9XR2ym2bL+cFmjhgD+9vU6QKwqJr89bQ2SIdOU2q6SuqOoA95XxnWdB1gfRyHbGzs3
	nhUyzi0eRUP/0xLMUTUS787tcOj11yOh2jDF/3Q==
X-Google-Smtp-Source: AGHT+IGXatHfg7cfSKlwjSqN0VephWQcR8xEcFOo9noPah4i9dvsdkIaoWCAYpVPNB6w/FfreH5j2A==
X-Received: by 2002:a17:907:803:b0:ad9:db54:ba47 with SMTP id a640c23a62f3a-ade898381femr13304766b.43.1749574972049;
        Tue, 10 Jun 2025 10:02:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:c2f:a34:6718:ee1d? ([2620:10d:c092:500::7:b9b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade2ea143a6sm682025566b.53.2025.06.10.10.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 10:02:51 -0700 (PDT)
Message-ID: <8e0882d6-2c1b-4097-a7da-471c77a759a7@gmail.com>
Date: Tue, 10 Jun 2025 18:02:50 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] proposed mctl() API
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 SeongJae Park <sj@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Pedro Falcato <pfalcato@suse.de>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
 <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
 <f8db6b39-f11a-4378-8976-4169f4674e85@gmail.com>
 <fcaa7ce6-3f03-4e3d-aa9f-1b1b53ed88f5@lucifer.local>
 <2fd7f80c-2b13-4478-900a-d65547586db3@gmail.com>
 <aEhTYkzsTsaBua40@casper.infradead.org>
 <8c762435-f5d8-4366-84de-308c8280ff3d@gmail.com>
 <aEhct_dQxGAazoiY@casper.infradead.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <aEhct_dQxGAazoiY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/06/2025 17:26, Matthew Wilcox wrote:
> On Tue, Jun 10, 2025 at 05:00:47PM +0100, Usama Arif wrote:
>> On 10/06/2025 16:46, Matthew Wilcox wrote:
>>> On Tue, Jun 10, 2025 at 04:30:43PM +0100, Usama Arif wrote:
>>>> If we have 2 workloads on the same server, For e.g. one is database where THPs 
>>>> just dont do well, but the other one is AI where THPs do really well. How
>>>> will the kernel monitor that the database workload is performing worse
>>>> and the AI one isnt?
>>>
>>> It can monitor the allocation/access patterns and see who's getting
>>> the benefit.  The two workloads are in competition for memory, and
>>> we can tell which pages are hot and which cold.
>>>
>>> And I don't believe it's a binary anyway.  I bet there are some
>>> allocations where the database benefits from having THPs (I mean, I know
>>> a database which invented the entire hugetlbfs subsystem so it could
>>> use PMD entries and avoid one layer of TLB misses!)
>>>
>>
>> Sure, but this is just an example. Workload owners are not going to spend time
>> trying to see how each allocation works and if its hot, they put it in hugetlbfs.
> 
> No, they're not.  It should be automatic.  There are many deficiencies
> in the kernel; this is one of them.
> 
>> Ofcourse hugetlbfs has its own drawbacks of reserving pages.
> 
> Drawback or advantage?  It's a feature.  You're being very strange about
> this.  First you want to reserve THPs for some workloads only, then when
> given a way to do that you complain that ... you have to reserve hugetlb
> pages.  You can't possibly mean both of these things sincerely.
> 

Let me try and explain my view better:

hugetlb requires 2 things, reserving hugepages and passing MAP_HUGETLB at mmap time i.e.
not "transparent". (I know the meaning of transparent even in THP is a bit messed up :))

There are some workload owners that will happily test (and have the resources to do
so) to see what is the best point to use hugetlb. They can go in their code and change
mmap and make the necessary changes to disrupt workload orchestration so that hugetlb
is reserved. This is a small minority.

An extremely large majority of workload owners will not be willing to do this (and don't
have the resources to do so as well).
For them, we have THPs to do it "transparently". If you just give a knob to switch
THP=always on/off for *just their workload* without affecting others on the same server,
they will be happy to try it and other workloads that are running on the same server
in controlled cgroups wont care and won't be affected. i.e.:

- if the machine policy (/sys/kernel/mm/transparent_hugepage/enabled) is madvise, workloads can
  opt-in getting THPs by just having this call (the PR_DEFAULT_MADV_HUGEPAGE version) in systemd.

- if the machine policy is always, and they dont benefit, they can opt-out of getting THPs
  by having this call (the PR_DEFAULT_MADV_NOHUGEPAGE) version in systemd *without* disrupting
  the other workloads that are running on the same server that do.

Doing above is very simple. This is how KSM is done as well. It doesnt require doing any changes
to mmap, i.e. is "transparent" (after the prctl/mctl call :)) and doesn't require reserving anything
for hugetlb before the application starts.



