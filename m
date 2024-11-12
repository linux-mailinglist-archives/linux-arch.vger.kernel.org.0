Return-Path: <linux-arch+bounces-9027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B629C4B60
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 01:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1B31F23F88
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 00:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7722038C7;
	Tue, 12 Nov 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="EI8qZFPz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE22038BA
	for <linux-arch@vger.kernel.org>; Tue, 12 Nov 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373180; cv=none; b=V0OTs8k1Vk6vNm/gE3xT4u5eSm1cgIMzFFtHIzcMRXydO5ftQmwT58jN9RSpwDjuIiafQgyzbjlNUmpy7DCN9jnwnUyZVfxU39vfD1d02U47g+qRFeK4WqdtavxtEWopQ357Rr7EQ7dL24V6s/uwzeWA5Dj2B/VoMNfCckffiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373180; c=relaxed/simple;
	bh=vl/gZZOX/UQNHQwVhGhWo6Q/nOcInYX8OF9wEj7gD4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYLz0ziYFPNRKcEwxp3lCsszAn1zp6Kse6AslLZJn1xzSWEtHudTGZJXgVRY4NJSfV0JcbOIellCHmKdGbeM0rDQBM8uMwIKebhOp4UqobpVU8c5a8OsLfq1Y/EIdZVVb6jhYMYv0mSRjamRV8LfVqndckm8GeviOdTXKEwoQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=EI8qZFPz; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b1511697a5so350967185a.2
        for <linux-arch@vger.kernel.org>; Mon, 11 Nov 2024 16:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731373178; x=1731977978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dgryruqvz3oynCw+eynUzr+rPfTLudMm2oFpIDaJpIA=;
        b=EI8qZFPzuxhXEoZltyam9xvlv7GDfzxxFwz/5jVkBe4ansBxzCjTYAYEYS/6dxNKBs
         8ew/eFno4jz/zR54h+Hg20lAKR69IKI0yiZNBr5JTSghFlUYdfwwAeiSDwSmVQ36WqTn
         U0/H/QHMzFW6SfNH6nOrO7ar6hqZVLzjQy+94Vu609jF171CRgYNT9/4ao71v+eq5ERX
         5FMosQjErnWAkWbbzUl5IXiEVnLGrXE/xNmr4H3eEfoZmdiPn5ao6+Jhr5aBXGks25+O
         LMhPZWMsCRYWQw2Qqoz0hV25EXgM4kgJAdyu/uf58uhQVuF/9OhaEgk3arRx6tt7smsQ
         exJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731373178; x=1731977978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dgryruqvz3oynCw+eynUzr+rPfTLudMm2oFpIDaJpIA=;
        b=ulQCBb6y1Ge12hqzqHJgFNULzIYKx1nKP1NNyKTR0PXsFASFABo/Ix44Yeb2fzCPaX
         KiZRUcRS4Vme1frJwM0jxppbN0ToFhimBoSp+G9g4CKX6hqtskrLuWFZKoa1g6A2uIk1
         w+l6uS26aOoCiseSWYhldvtT9K72WnWX2MofbCzNRjzW6yIKHkiM8BmigF90OE+4iLtZ
         bSUpSjuA4nYXPQ+L8PxDM1wASyuffPtXiLbP1bbonP2MN6mC7XO2Q4MV/BUDsQUah/Kc
         YMF3Igdbdjogc9gZ5k9i7pSRjS2PAsUF2VFxMTreGClLAisRnNfsTSUqLeboRNMohZV8
         cM3g==
X-Forwarded-Encrypted: i=1; AJvYcCUrKMF7r7xkLqSt4yK/nhr2rX5vGtk9rzt2PkmWt1mYMY3pj4iTSpnJCr7sHZFakO7CfqjzP5FXp/js@vger.kernel.org
X-Gm-Message-State: AOJu0YwAKXUVbjLsstn2ozk2t5edZVu1Be5kV5vzUYacSc0ZAK9gdUtE
	qW/f6MTRYO+Y8xW5gH1rJr7SmJ5SVrdFEJQGlWbGcchUANgnRfRf0hqa4hUXmw==
X-Google-Smtp-Source: AGHT+IHwCd43sTsu98WuNqYuXULodJh8oMVMDF/iNnhpfWU3O1q7dXshmn4PYa1T6jBdvqusm4gnKQ==
X-Received: by 2002:a05:620a:454d:b0:7b2:5e0:c439 with SMTP id af79cd13be357-7b331ec6103mr2066623485a.30.1731373178443;
        Mon, 11 Nov 2024 16:59:38 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::2c91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac63da6sm545393885a.58.2024.11.11.16.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:59:37 -0800 (PST)
Date: Mon, 11 Nov 2024 19:59:33 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, torvalds@linux-foundation.org
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <62634bbe-edd6-4973-a96a-df543f39f240@rowland.harvard.edu>
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>

On Mon, Nov 11, 2024 at 10:15:30PM +0100, Szőke Benjamin wrote:
> warning: the following paths have collided (e.g. case-sensitive paths
> on a case-insensitive filesystem) and only one from the same
> colliding group is in the working tree:
> 
>   'tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus'
>   'tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus'

I support the idea of renaming one of these files.  Not to make things 
work on case-insensitive filesystems, but simply because having two 
files with rather long (and almost nonsensical) names that are identical 
aside from one single letter is an excellent way to confuse users.

Come on -- just look at the error report above.  Can you tell at a 
glance, without going through and carefully comparing the two strings 
letter-by-letter, exactly what the difference is?  Do you really think 
anybody could?

I haven't looked to see if there are any other similar examples in the 
litmus-tests directory, but if there are than they should be changed 
too.

Alan

