Return-Path: <linux-arch+bounces-4759-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0AA90140A
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 02:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA804B215D2
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 00:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6C368;
	Sun,  9 Jun 2024 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7nsZ2S0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D351367;
	Sun,  9 Jun 2024 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717891461; cv=none; b=amRF6XforGR1chsfFa6rvZakqHj+BWg1rI/DREY4LfKTugjKVoojqF5GrleYdxk4gZo/ly7yiMclNa+9zH/B9Bu19nK6gxm7MyKBgoQiHEDd+Er5zK2nbRdH7eC0bj3GPlukqWqMeC3iN6DOkKqJaKKT4hOG6jqBr0UzkunYARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717891461; c=relaxed/simple;
	bh=E87V4JfAoOPrdLIRnIrrMEZJYH4ni/PVxRCNolBbXUk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LKJxLVfouHxJUg0gVB5F++Rf5t73IL/xhl/+FH8PHBEC8UZ/xNNiheHRLbtVqykCQMU6LzJJNHxoHmZPjf1A/umkao9OvJhYT9sG7idW/m2f76EAn87/teTjQYlalQ4KSFlJuE9EFGuj/cEg/p7VOCYI2khxTw3/J+y3ACsINTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7nsZ2S0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f6f031549bso7591945ad.3;
        Sat, 08 Jun 2024 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717891459; x=1718496259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R4DiYmrDM9WuiqCUk6d8962w9mDc3uxUQIRfmiIP+g4=;
        b=b7nsZ2S0Kpf7aBLTEEIpsCkcCiAuQrCce7PngnFEJ0J2O47KHBdFBFKmyIf4puXxXB
         LV/jyrchos0gAKJ8C09DrOZ5BXs8l+C0JWO56RLWuUDObeHzR4O17XT6pPAq64Svrwsx
         ejVNuEx4QgyGe+lcJLvptFNNERSA/yrRaCsP2gpBcJBr8DtSa34IWCztw8xQypbQBMzY
         pk/dJZlUaOgcxVApsBa9GYdMXmDiU6Q1hSlcI+HQpE8fMChXlVvgYUaNr5+3BqzssKeq
         VveT0bxcFlYvOXHE+cTVZxxlR0iWYVsZv06FCBnvLc1/ZKvhOW7ae2USxwo8uJcka9Ru
         UAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717891459; x=1718496259;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4DiYmrDM9WuiqCUk6d8962w9mDc3uxUQIRfmiIP+g4=;
        b=jW3nmqRm7AiTnCY8Qzr32yAclZXEGsMVtgZRMcU/otXW/6PGQOiwfhw7c17RxchOaD
         juP3av3V6zhYeiLpOjLml6vObVHx78keadW1zR2ZdZQAD33L3eAOdUQA6iE+tBBt7idd
         5rMDQBe/BSEzqvZvo4Lw0IzqGEvphNmbpbtBHrp/K6tG0yC4nvUH0fkmqzNkyAAm9IMG
         QOm/vJlDHcSs3in8vD6crX4ZfpbmefH0iNkwRYyHX7JURYJr/iL9kudgQ8FAZV8pnvYT
         IYS7R2US9sx5MbPnWNe0mEub52pe61rEV/OIF98PjEOpNlGpLTmqTzyQKRiqSVohy7lw
         kx9w==
X-Forwarded-Encrypted: i=1; AJvYcCW5XZdRzMYWGH1GJrOEOqKCvFt/QUpngvSnaFTqRybi+rhX+kOFaUI4XLpv5vBbIWMvbRUxZ1Ty+9poNxBm45yyVp8CeENc4Glcbw==
X-Gm-Message-State: AOJu0Ywoevj8ppZqdH5f738pI8CQrErnt3FBoVeYVq+0CrTMp3v/yU7d
	Or/S6cDeLiWJjoBuFDRQEkTtokW78OQQVzyTI4CBgERcOCtcDpbX
X-Google-Smtp-Source: AGHT+IE+CFBySHJU8B2QPWQ4xCh6axAZY3QaBrbCrRKRI5T+2Fyo/3wpSzjxHDtTe723K/sKx0iaIg==
X-Received: by 2002:a17:902:6506:b0:1f6:ee9e:f60c with SMTP id d9443c01a7336-1f6ee9efdbemr24024875ad.58.1717891459496;
        Sat, 08 Jun 2024 17:04:19 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f96f18e8sm13029685ad.230.2024.06.08.17.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 17:04:19 -0700 (PDT)
Message-ID: <a3ff0522-fd2d-4c87-9c7b-00cbdd5f3c68@gmail.com>
Date: Sun, 9 Jun 2024 09:04:14 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH memory-model 3/3] tools/memory-model: Add KCSAN LF
 mentorship session citation
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
 parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
 boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr, Marco Elver <elver@google.com>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-3-paulmck@kernel.org>
 <42fa4660-b3bf-4d09-bbad-064f9d4cc727@gmail.com>
 <f11f7230-7c16-45a3-83be-9aba32e10a3b@paulmck-laptop>
 <3c5a53e2-b5a9-4197-97a3-247abb7f3061@gmail.com>
 <6bb5f789-f143-493c-a804-62b7c81dabb0@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <6bb5f789-f143-493c-a804-62b7c81dabb0@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/09 0:48, Paul E. McKenney wrote:
> On Sat, Jun 08, 2024 at 08:38:12AM +0900, Akira Yokosawa wrote:
>> On 2024/06/05 13:02, Paul E. McKenney wrote:
>>> On Wed, Jun 05, 2024 at 10:57:27AM +0900, Akira Yokosawa wrote:
>>>> On Tue,  4 Jun 2024 15:14:19 -0700, Paul E. McKenney wrote:
>>>>> Add a citation to Marco's LF mentorship session presentation entitled
>>>>> "The Kernel Concurrency Sanitizer"
>>>>>
>>>>> [ paulmck: Apply Marco Elver feedback. ]
>>>>>
>>>>> Reported-by: Marco Elver <elver@google.com>
>>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>>>> Cc: Andrea Parri <parri.andrea@gmail.com>
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>>>> Cc: David Howells <dhowells@redhat.com>
>>>>> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
>>>>> Cc: Luc Maranget <luc.maranget@inria.fr>
>>>>> Cc: Akira Yokosawa <akiyks@gmail.com>
>>>>
>>>> Paul,
>>>>
>>>> While reviewing this, I noticed that
>>>> tools/memory-model/Documentation/README has no mention of
>>>> access-marking.txt.
>>>>
>>>> It has no mention of glossary.txt or locking.txt, either.
>>>>
>>>> I'm not sure where are the right places in README for them.
>>>> Can you update it in a follow-up change?
>>>>
>>>> Anyway, for this change,
>>>>
>>>> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
>>>
>>> Thank you, and good catch!  Does the patch below look appropriate?
>>
>> Well, I must say this is not what I expected.
>> Please see below.
> 
> OK, I was clearly in way too much of a hurry when doing this, and please
> accept my apologies for my inattention.  I am therefore going to do
> what I should have done in the first place, which is to ask you if you
> would like to send a patch fixing this.  If so, I would be quite happy
> to replace mine with yours.

OK.
I think I can submit a draft patch after fixing perfbook's build error
caused by changes in core LaTeX packages released last week.

Can you wait for a while ?

        Thanks, Akira

