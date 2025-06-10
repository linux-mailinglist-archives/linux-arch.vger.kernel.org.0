Return-Path: <linux-arch+bounces-12317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 695BDAD3E13
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 18:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF59189A59C
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756B1F0E2D;
	Tue, 10 Jun 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn3tHalQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F0134BD;
	Tue, 10 Jun 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571252; cv=none; b=SouwrKgCrOg5lV5KUuOpeqvc86qzwOCwdNSynB0TXWl1ztIo+aIUxDVd+zSyqsN9lvzW/yNrgG3vW+dgtKAVrluMTYfRWx3jFNI+rfDRWAXZi0fIfdbip+hgOIEWXRgdtRQO1mrSsQJ5Jy5lYDKadqISX0nfT6ZpUjf5Kfv0ixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571252; c=relaxed/simple;
	bh=dwrbNjF4dM7M6m7q+dJ3SHCKp4jowPNsh/S6CnW/xW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8na1gSQa75nDwZDQr2R4NG4IPXCafux/gHKVVYMKkA5swGhUZJm/G9tdlJBcZmAb5QhtXpZG5ead7guJ3fTnGrm4jehKDMQ7OJXJ7B+LPmRUA7hQsxStoyl4pB5+KJac2M1hudNR9crbRwBtFJHuEtGVbywbew/ogYT+4e5ihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn3tHalQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade5a0442dfso408941466b.1;
        Tue, 10 Jun 2025 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749571249; x=1750176049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQWLfYp5I1ceHGB1pz5r/aQqCgyzKtMLW4swedU4Rqo=;
        b=Nn3tHalQhMPQ4qLC8hDoPw5M9XBTuWP7rvHPQVqqPB8F75a/ryVk3X01iF7+fjS6v0
         bMMW7krIXOdIw1YoI5PvobfnMaIgvEaAlxh6+B+QfGHkWsdqaHZvD03I7hgwPMziwAjD
         69RvNQrPKns9Y+EcxWOgAsTTzKpd2pp17lPoSGLJkpZ+0h8k788/VNuLWQSyjvCTaMgP
         jzQOJ3JY1TzOCZ4HxVrNhpsnY8G7aDlWsuKPSMvQhPOpT/Qg1QfgEj+DSHh/Md7r4oiO
         G0bQQHxO3fQ4HvBGI/lqUtNP0Pyl1vXpy/Ly8uoL3LmgXtwrtm9qqCqHSo5yUH11rsUx
         chgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571249; x=1750176049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQWLfYp5I1ceHGB1pz5r/aQqCgyzKtMLW4swedU4Rqo=;
        b=Ou0IoQcrzou7dHcp/z6Y9siZIBLRucGp1qNNIurP+Mup/gqhkXO7fJoT56U/hfCeNC
         e3EnK04tgz23dKvdQNBTXWzhgy805pPgARHjZhjKCujhk11q1QRNkfKKMlcNASf43nKT
         M7qO3ZHK23/H9DOxZKJAcamICUfozoLP4Cyy+sSRFSA1DbtmhUwWzg5zknUc99PCnGBp
         PwTbq1IbMCotGRPH+IBI4s1YffruBN2LXcfYuupPUKyIu2H7MjHpAUPxg/ibttFZecM+
         9B7AoBRVsMvumU97rneKd3aaaRATQI9Bqs+dxX0QzoBrrQ0HTcub0EDlZqEHTCZIxoKA
         f7sg==
X-Forwarded-Encrypted: i=1; AJvYcCV3EKJONGjAAVSSfDWzJ2e1OvcA5alLAHuuzsu1wIJWclvLlPdafRYuvHL3JUD2Sx/D2UvpV4lStUI=@vger.kernel.org, AJvYcCWsUzRVCtuuAKOnZG0vAY5aj+XFL81ncHeky1Tvsd82estwXkTdAn+K53FCIvKmstdGEOWdKpLYl6M5Ci9/@vger.kernel.org, AJvYcCX/s4tORsVXfBSTNL4ZqDFsWsoWrPN8tkgEdkRMHNb2olvol3bDBWElcw3czVfyq88mexpHJ0j37D8Vkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5ygrFYcBCguf3GmZ2YJoloQWCQnUb8ZxPKGOjWxV0690WPLG
	Ppc8mDf6TfgxssFNmOIkm7GCc4Mssaoss9SHLeQ0GkfzQRcZuV0IsYEk
X-Gm-Gg: ASbGncvyL3vXtAUoo6888zzK1m5a8kFDeDwkaMZCf4J8HdUuhCkhTm6QcB8xjsKXhkj
	RhPVm9uvr7CW0U/bq5ZGrwtN9iiBdRIzrf8m8RrNWfHynDEPekbKZXY+0WIytpe7s6fP5T7CO8y
	AdREE04ctKUiHFaE9R4y99h5Irhalig5Sv+BIIaS4Gh32EvATSGCzxzrO5JbK5MpcCH0gRaOF0r
	YFZkkVcs0LRGG2riA9QwumSxDyWFGUrJsSM9Q84Ccx3uLWxAkFr8EFgS2xeDHD/5grqrNc52lKG
	Yeuxq6ex0ChSWZaf1h2Wq/ujhm4hfkPLdnsVbpgDFIVVLV/Is5O2bZ6R7q0aqg76Fw06iw3c32t
	/anma+u0qXNJIaPFpaKv6YwGwuJliKK9agISTPyjseFvhFSnb
X-Google-Smtp-Source: AGHT+IHKS0te2rXw07wqy+zzfCiWuP4078dBifqY5s3F/kkc1JYi2TIxO7c+n7JrTLgvZbBM0fwI2g==
X-Received: by 2002:a17:907:6d0c:b0:ad8:8c09:a51a with SMTP id a640c23a62f3a-ade1aa0fb2cmr1690627766b.4.1749571248678;
        Tue, 10 Jun 2025 09:00:48 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:c2f:a34:6718:ee1d? ([2620:10d:c092:500::7:b9b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db57856sm746559866b.63.2025.06.10.09.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 09:00:48 -0700 (PDT)
Message-ID: <8c762435-f5d8-4366-84de-308c8280ff3d@gmail.com>
Date: Tue, 10 Jun 2025 17:00:47 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <aEhTYkzsTsaBua40@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/06/2025 16:46, Matthew Wilcox wrote:
> On Tue, Jun 10, 2025 at 04:30:43PM +0100, Usama Arif wrote:
>> If we have 2 workloads on the same server, For e.g. one is database where THPs 
>> just dont do well, but the other one is AI where THPs do really well. How
>> will the kernel monitor that the database workload is performing worse
>> and the AI one isnt?
> 
> It can monitor the allocation/access patterns and see who's getting
> the benefit.  The two workloads are in competition for memory, and
> we can tell which pages are hot and which cold.
> 
> And I don't believe it's a binary anyway.  I bet there are some
> allocations where the database benefits from having THPs (I mean, I know
> a database which invented the entire hugetlbfs subsystem so it could
> use PMD entries and avoid one layer of TLB misses!)
> 

Sure, but this is just an example. Workload owners are not going to spend time
trying to see how each allocation works and if its hot, they put it in hugetlbfs.
Ofcourse hugetlbfs has its own drawbacks of reserving pages.
This is one of the reasons that we have THPs.

But they will try THPs. i.e. if they see performance benefits from just turning
a knob, they will take it otherwise leave it.

>> I added THP shrinker to hopefully try and do this automatically, and it does
>> really help. But unfortunately it is not a complete solution.
>> There are severely memory bound workloads where even a tiny increase
>> in memory will lead to an OOM. And if you colocate the container thats running
>> that workload with one in which we will benefit with THPs, we unfortunately
>> can't just rely on the system doing the right thing.
> 
> Then maybe THP aren't for you.  If your workloads are this sensitive,
> perhaps you should be using a mechanism which gives you complete control
> like hugetlbfs.

Yes, completely agree, THPs aren't for the workloads that are this sensitive.
But that's why we need this, to disable it for them if the global policy is always,
or enable it on other services that are not sensitive and benefit from THPs
if the global policy is madvise. We have to keep in mind that these workloads
will be colocated on the same server. 

and hugetlbfs isnt transparent enough.. :)


