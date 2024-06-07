Return-Path: <linux-arch+bounces-4755-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A16900E7E
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2024 01:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310832844C0
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 23:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16CA73453;
	Fri,  7 Jun 2024 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJZ9YnJ7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3BED2F0;
	Fri,  7 Jun 2024 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717803499; cv=none; b=UuLzFSWeSio+Yeu0dFmEZaJRAHtjWUpxCLUsgEr3lVeb4xFRfpbcprx8H81QsiFCNOkNNkoali34q9mN/YtZJopgXpp1cXCD14vRSi9Et1Ki9qFcM5+Pog5ZnKTAmkJT5IDn13BSRc8Dgu7HMYchoYaW2Al/nyhonefidbbyLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717803499; c=relaxed/simple;
	bh=welueG0NCW3tdtRAxjJgBVlt0+jRv+pKZMOw64580Jw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZQ+mHWKsYDwDfjyZoG8PldJ0j9YLJ82K/Lr7UQbu4seFxfbQhtx/3GTWjY0J9Oy0XbIL3okFJs9Z7gSdddFhTjYU7wRfbxI/rMDZ5q2k1iWQ3ivUU0Fh9rNuKhiFBSlVqhOcr6Y9gFbsOe7MXbqFtMECvx60Us0ecMUEf4OM00M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJZ9YnJ7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6dfc17006so7728255ad.0;
        Fri, 07 Jun 2024 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717803497; x=1718408297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JW9HzvSm35AD2QfW0Aq+XGJqSljlS2GKUc0oiG2avPA=;
        b=bJZ9YnJ7jFQ6+ZW0oa5W6BTcmlImmoKCV4FH5nMSaqpIPRYH/FoUYxxziKcDdUahdy
         U/OOEstSqUBojxh/w950ogWgfAGNgrZihA5wThOwf7/XJECNuLysAtHWozhxrDb3vdD3
         jJCYtM9A+efQzz6+AHBQRxVEvwGCKZtpCHD/dKb+3IU4V40N12lcY27/KI+yDCpAxDKd
         sAD4vYh/PwoujLP6yEYcoIGNH281l1gcV5zEav5R0y68vPlD5XsBECeThxQLI/GJ0e19
         zFOc2ZxlkcX9Y0E+iacYNs6C0R+tMHeomQ+xuBtFBX673HXxKVsWZYh+DdfAHm+0J3ro
         TSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717803497; x=1718408297;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JW9HzvSm35AD2QfW0Aq+XGJqSljlS2GKUc0oiG2avPA=;
        b=deDjc2O1FFnfC4iAm0u4kBHJ1HFzVO+aCfovbtwVVRdx5vSfa01DsJkH/ngeagLDx6
         NDSACkS/X5x9903NIFHTLme93P+AkYeZY0K30me+zjGKrwSeGP3IyTx1QtNDM4EltMC2
         uAdF4KQKRGHl7qdekUROZL0dfB9Gqu8FT085zeT963Nv9E22stWuwavQsDkNmBK2bTDh
         yg2q3tjciLaAsDq3HpsLn3wHtTyvlsQzZsff59Qzjlafqd34DoCrmyVb3OhXZzOnknVc
         FtCrVDrA6dS2jpqkwtVSWBcxA9QMXQoanDyZ3cIpjD35TtU5QXNb2PWAbCyGcDAEZBpg
         iPGg==
X-Forwarded-Encrypted: i=1; AJvYcCV3E83NuM657V34y35rU98ncryJvSO8Lbg19qBTG+hVmGV5VskfUF6kmhwiKphJ2xZxkXSpA2xbGQWIQ48F+3sdajB8YwN7MoeDsw==
X-Gm-Message-State: AOJu0YxQLCr6lRQO2U0qIsSRkFwqnULpZ0RJttq/VDhntoRayX/35s0Y
	Y/WsRprB3CafZeScxcaDFp2snQiQSDc8KMDtuEpned4l2W1WfWaQ
X-Google-Smtp-Source: AGHT+IH3/usZsj79GZpXfLiWoha1Y+Ns9NOTvhzCb9zkrHK6lcbT1NY2sNKVu4VUFLYDDN0V1Hxr5A==
X-Received: by 2002:a17:903:2443:b0:1f2:f182:f616 with SMTP id d9443c01a7336-1f6d02d4609mr45810045ad.13.1717803497228;
        Fri, 07 Jun 2024 16:38:17 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7d2bb3sm40133475ad.158.2024.06.07.16.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 16:38:16 -0700 (PDT)
Message-ID: <3c5a53e2-b5a9-4197-97a3-247abb7f3061@gmail.com>
Date: Sat, 8 Jun 2024 08:38:12 +0900
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
Content-Language: en-US
In-Reply-To: <f11f7230-7c16-45a3-83be-9aba32e10a3b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/05 13:02, Paul E. McKenney wrote:
> On Wed, Jun 05, 2024 at 10:57:27AM +0900, Akira Yokosawa wrote:
>> On Tue,  4 Jun 2024 15:14:19 -0700, Paul E. McKenney wrote:
>>> Add a citation to Marco's LF mentorship session presentation entitled
>>> "The Kernel Concurrency Sanitizer"
>>>
>>> [ paulmck: Apply Marco Elver feedback. ]
>>>
>>> Reported-by: Marco Elver <elver@google.com>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>> Cc: Andrea Parri <parri.andrea@gmail.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: David Howells <dhowells@redhat.com>
>>> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
>>> Cc: Luc Maranget <luc.maranget@inria.fr>
>>> Cc: Akira Yokosawa <akiyks@gmail.com>
>>
>> Paul,
>>
>> While reviewing this, I noticed that
>> tools/memory-model/Documentation/README has no mention of
>> access-marking.txt.
>>
>> It has no mention of glossary.txt or locking.txt, either.
>>
>> I'm not sure where are the right places in README for them.
>> Can you update it in a follow-up change?
>>
>> Anyway, for this change,
>>
>> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> 
> Thank you, and good catch!  Does the patch below look appropriate?

Well, I must say this is not what I expected.
Please see below.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 834b22ba762fb59024843a64554d38409aaa82ec
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 4 20:59:35 2024 -0700
> 
>     tools/memory-model: Add access-marking.txt to README
>     
>     Given that access-marking.txt exists, this commit makes it easier to find.
>     
>     Reported-by: Akira Yokosawa <akiyks@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
> index db90a26dbdf40..304162743a5b8 100644
> --- a/tools/memory-model/Documentation/README
> +++ b/tools/memory-model/Documentation/README
> @@ -47,6 +47,10 @@ DESCRIPTION OF FILES
>  README
>  	This file.
>  
> +access-marking.txt
> +	Guidelines for marking intentionally concurrent accesses to
> +	shared memory.
> +
>  cheatsheet.txt
>  	Quick-reference guide to the Linux-kernel memory model.
>

What I expected was an entry in the bullet list in the upper half
of README which mentions access-marking.txt along with the update of
alphabetical list of files.

Updating the latter wouldn't worth bothering you.

And you are missing another comment WRT glossary.txt and locking.txt. ;-)

Let me suggest an idea of their positions in the bullet list where the
ordering is important.  Looks reasonable to you ?

  o   simple.txt
  o   ordering.txt
  o   locking.txt               <--new
  o   litmus-test.txt
  o   recipes.txt
  o   control-dependencies.txt
  o   access-marking.txt        <--new
  o   cheatsheet.txt
  o   explanation.txt
  o   references.txt
  o   glossary.txt              <--new

Have I made my point clear enough?

        Thanks, Akira

