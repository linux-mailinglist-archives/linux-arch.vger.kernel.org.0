Return-Path: <linux-arch+bounces-12058-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821FFABFBC4
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55BEA2074B
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239E248F73;
	Wed, 21 May 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9ea8YYD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D24242D66;
	Wed, 21 May 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846673; cv=none; b=XwZgOLiTOO5z9Nl5fc729edObnlMWBD3wqGTXz2kWHA2bIo8tDSZtM5kXgUw6F2R4+zQWCEcqA7FdTxg2yqbDvE6dXmaDKbZNfkLaYM8IvXT+VE8dRoNM6FuaSCvdYo+dx5HrlwUS6mus4xQy6QP5W0+qAjE/vhmb9PPxzGn5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846673; c=relaxed/simple;
	bh=/GlespiNmMT4+BqUyJVqesFiv1fxp1eFp6PVyIszOPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jh2nBeV+oS5+6b8lt5WTcRmMT9KBtk6/wstiCJzVufK5LRKXhOrRX8N52C3s8MsUDa+4UNxyQdZhpSvZZTqus/qkZqEVOllEy7yG9AuxV7VYIug0IFnit57OPZI2ZNACjFF1h0r+VRNxzOdtRIX9Uha0JJyiOQmSWSHtDrrHL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9ea8YYD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-601fb2b7884so5621133a12.2;
        Wed, 21 May 2025 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747846669; x=1748451469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRYUFAK7jSYA/NtgtlJwU68PcUllDyACt8wTHZPGFbo=;
        b=X9ea8YYD6gpMKdelTo7bkq4hdKBGgOeE3uoSgg6S5SI3YunUvYHIh4uQsld19vzWHN
         50fgut1ljwBbVG89fKmWmKWsDb2bR18V8K+IAEpiRrB5jAyCngK7Fsbr0Hm7TZYwbccy
         3NNQwgB5MTzVyiMs1IGdr7AT5VNqd+VhlAcUF9/6CluAZAN9mB0qvn8zhf4eJBL2RMRy
         glrF0ZArrYfkYVxF/ZLeh/rA0Op+nRj2FZ/KIlk0zDWs7dO8OtqOqK2esJYyooOR8V1v
         NWxvjtgE4W+KB7cw2bFkWeDZk2IkS6sCmybOl/3sWCAa3bu+RSI1y1VYY0CTG8cjb5Cz
         Zdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846669; x=1748451469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRYUFAK7jSYA/NtgtlJwU68PcUllDyACt8wTHZPGFbo=;
        b=g2r6RegZa0gqBNGl4B94TvBTY0F2LVYn08v4slypWJGU/PHDa3Bb+VrkDl9VWh47AA
         uH+TPS9Cs9gPcDkqqQ8a4hsiy575JTWLKBeXbQNrR6mJoIxq2YVItGKD+Ngu4e31b8VF
         t54XBSI4d/1v1lqOrohL54BAifYRvcbhMGHf6qW8mpGQjZoGZtDb11hFQD3TrOStG74t
         y2Tq6/jHsFgQe/WOlTupEBSqG73hkaAv6VH/x9v6kcXW1yvP7bgJCdCQckBORqtngWbp
         //lSUy4FzIEBWb857dfSYFR1sWfN8eiR+JBgN+n/eS1B75dTb5Oe75UGqhB6awa1kcgs
         Q7fw==
X-Forwarded-Encrypted: i=1; AJvYcCU2VKYHNmjmJiaTM8V5AwXFCBuoZXqaamgeKB5PFdZtvvJhZZ/ZCHkhefmVTuQQCm06PiA64D4t+ZhlaF1D@vger.kernel.org, AJvYcCXEzJT5/dkjB1uImUN5RVVwl51LjsJXSRbE92QacX0mbM64rJrXn3N3ld+YmH/mdpbNVC4mlKs7GfX1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Va+gGbDu+fzSVKsmCG1xUwUio7qxmoqAkct68yfAU/BEKb8P
	QUuf64VkYU0s5yXYb7o3riZC4yO28cbMyhVC8j0KaQ8x6gPQNgronD8r
X-Gm-Gg: ASbGnctm7tiulXyykU6+9r08axqBQw9S+aYTFhqT0YIep7PYsX0jeEqXPSOj1g4kO9u
	QWNBuXUjFcW2S+jsyDOj+IHSTQEYaMAIdVsO/+a8+f+ydiuQi6JZnzONXe4DqcOuMYTvax8W3Vq
	RgF/EGWpXE8Egrzj//2pAhbOfyRDTLsFrBsbT+SshvGRs4VANKECT4fA4WCG47VdU24b6ij/SLR
	VehJFoz7SrDRItnOM3x++ww/ydCAStv9g76Kt+CgjOJ+WDTNbeZvKOyjzMj+B7uhi4lxLAwZnGn
	vrV66t1oLf4AmsrlPsWUQnJ3+WxH0O73BXG44tPvfNQvdObu13oA4JR6Nd6M4SzcQXARD9AZOa9
	0LyrRdVrpMBNIsb8yMZXVSAhxtCFmEMKXJZDoVQ==
X-Google-Smtp-Source: AGHT+IHSvbQT6sn4S7mMgkqSNKRdTOlaQgHRPK4MjnFPlaTQGercmFbLQYTx5FF7F5wgccYvySsRbw==
X-Received: by 2002:a05:6402:1e89:b0:600:9f83:c314 with SMTP id 4fb4d7f45d1cf-60119cc7219mr19075932a12.26.1747846669303;
        Wed, 21 May 2025 09:57:49 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:8d0:f08c:4e6a:b32f? ([2620:10d:c092:600::8a7e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ac336d5sm9221196a12.54.2025.05.21.09.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 09:57:49 -0700 (PDT)
Message-ID: <b78e0fd8-e6b9-47c6-bec8-a44a8be242f1@gmail.com>
Date: Wed, 21 May 2025 17:57:48 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 SeongJae Park <sj@kernel.org>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/05/2025 17:28, Shakeel Butt wrote:
> On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
>> On Tue, May 20, 2025 at 03:02:09PM -0700, Shakeel Butt wrote:
>>
> [...]
>>
>> So, something Liam mentioned off-list was the beautifully named
>> 'mmadvise()'. Idea being that we have a system call _explicitly for_
>> mm-wide modifications.
>>
>> With Barry's series doing a prctl() for something similar, and a whole host
>> of mm->flags existing for modifying behaviour, it would seem a natural fit.
>>
>> I could do a respin that does something like this instead.
>>
> 
> Please let's first get consensus on this before starting the work.
> 
> Usama, David, Johannes and others, WDYT?
> 

I would like that. Introducing another method might make the conversation a
lot more complex than it already is?

I have addressed the feedback from Lorenzo for the prctl series, but am
holding back sending it as RFC v4.
The v3 has a NACK on it so I would imagine it would discourage people
from reviewing it. If we are still progressing with sending patches, would it
make sense for me to wait a couple of days to see if there are any more comments
on it and send the RFC v4?




