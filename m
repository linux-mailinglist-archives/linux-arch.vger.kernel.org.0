Return-Path: <linux-arch+bounces-4278-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B148C0704
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 00:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80EB1F230A7
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461EB132C36;
	Wed,  8 May 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsA3Ez9Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B96134CD2;
	Wed,  8 May 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205565; cv=none; b=p6u88cAJwAsWxOUq9pEpjeG1hHL0F10HZx2XcDFzQGvUBfqbzTP9JjesVGj9g+hLaCSvl3Hj97EtvfAgeMo05goBJ0XA/cIeL/YCQyirhh3NEAwPz0sf6/dUqotBdjhN5j5F+j8zHrEG7aK+0PCrMVeVXtvmRpWakeYg2Bb+hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205565; c=relaxed/simple;
	bh=nByr3jM+Y3NxC0MP1AcoNq5+7invfqX5YpdGYrcZgC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmuUBcW46sZ+NcDhzGciLazvDySHsDzYzNIuxPoXmHRy5pIPo61m0dtLyV48leWIJl+xCU9z74Xp2n9usH62pZljEXKNLJXmjXtuNhYVgCzQZJzrSog4xRJWKM52Nkb6xy9onvKp4MLsuSsfti90LixMZ3axaIcBwWOwsB4E7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsA3Ez9Q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f44881ad9eso248779b3a.3;
        Wed, 08 May 2024 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715205563; x=1715810363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMw/YrYkp2g/WGx6rK85U9z1vCqgtkkofZwvEj3MD6Q=;
        b=bsA3Ez9Q9UyQuPb/zRzp4IwvSX8JEdL4a1QxoAJx9UcYdqj9lpU2WjV5wefxCzknX5
         o92PNjBY3Wpy5kDRsMrQxNfUuUrrWjQau/0DN4wMZAlIwaUdso+Q2E83qJDNKsqGZ0fH
         2BUSBUeoWGvuGQJxyGavW40Kq5bkIB+Jj25h3hHFbJK/fcZ5nla6EQqS478MMFweyWZp
         iJeuSkCmlt+gGMrnkCdDE1jphm8450jW9diQvWPK9CgoyXxJ+4FLOMJak2dAcsB0rKIC
         LAVUxYV8RcKh/4UxCnjcUBDeEcYMRzV26xMqGuQxJk4AukA5TLZnVqIqUvuYQd6DQbne
         ZD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715205563; x=1715810363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMw/YrYkp2g/WGx6rK85U9z1vCqgtkkofZwvEj3MD6Q=;
        b=kJTYuBiUuGBObIajJNQkN6/Sb6/b2il5opTBL0HlKUE46hKQ3Yz23ccoW7EjQxQgvc
         uMrCikpZOw0ufeghSa+BDud8pKqhNP1iSbnLmQzmd4whRUGCIpCYwEAQqsiB+4sbXNE+
         IgH84lpQlSupkQT0bsBWYE7DRYdwmYPzBO8PzbDI0wKxEEBsmhsXdt5jXUKv9rm4eNeT
         yNVNNCAQyHVcgIZGTLEqq8gsqHxiy59T9ce8eqOHz+mD7DVQOOpMVYMZpxeHn4dgB1Ki
         C2a6laFmjghRqeXQRFQeUc12p2CUS/llPwxVImg8yQ3sHowt0KfHkB8kZDOjQzHDOk3y
         0RGg==
X-Forwarded-Encrypted: i=1; AJvYcCXKfpFbZGg4GXMwv5C/T/Dc3wTIqj7kyq1t5dHD7UPmiPxMjdu3QUbJK5/9Oy0GdUmBk3SBG/QEfZpo0VeTSRY+CHWsCzEEU96KhBF7VRbJ6XweW7KkB2+hFkxnEcKLdvdpcOgKGHPvfw==
X-Gm-Message-State: AOJu0YxLRIETObrXfHPG58V4iZ1zeBorvJwZk5kdj6CJW3wXemqnK4z+
	ruYgKEjLqD8DprA0WJh58EJgmnNUbUtQO/D2GpjuNzD2MSL9qVym
X-Google-Smtp-Source: AGHT+IH6ZtjPHc9UBBw6l0sdQtIObxtxJJX/ZreuxvxkaqtJ0nTOTorxkq5Pbek0/nk0E0D2THWLdw==
X-Received: by 2002:a05:6a00:2f0d:b0:6f3:ebb3:6bc6 with SMTP id d2e1a72fcca58-6f49c20e6afmr4041629b3a.10.1715205562906;
        Wed, 08 May 2024 14:59:22 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66585sm62052b3a.10.2024.05.08.14.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 14:59:22 -0700 (PDT)
Message-ID: <7e7167fd-cf4d-4d8b-bd83-d9fe8887dbae@gmail.com>
Date: Thu, 9 May 2024 06:59:17 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Add atomic_and()/or()/xor() and
 add_negative
To: Boqun Feng <boqun.feng@gmail.com>, Puranjay Mohan <puranjay@kernel.org>,
 Luc Maranget <luc.maranget@inria.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 "Paul E. McKenney" <paulmck@kernel.org>, Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, puranjay12@gmail.com,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240508143400.36256-1-puranjay@kernel.org>
 <ZjvXZZiew_shyQA3@boqun-archlinux>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <ZjvXZZiew_shyQA3@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 12:49:57 -0700, Boqun Feng wrote:
> On Wed, May 08, 2024 at 02:34:00PM +0000, Puranjay Mohan wrote:
>> Pull-849[1] added the support of '&', '|', and '^' to the herd7 tool's
>> atomics operations.
>>
>> Use these in linux-kernel.def to implement atomic_and()/or()/xor() with
>> all their ordering variants.
>>
>> atomic_add_negative() is already available so add its acquire, release,
>> and relaxed ordering variants.
>>
>> [1] https://github.com/herd/herdtools7/pull/849
> 
> A newer version of herd is required for this feature, right?

Yes, this requires building herd7 from latest source.

herdtools7 7.57 (released recently) happened before pull 849.

Luc, what is your plan on a next release (7.57.1?) ?

>                                                               So please
> also do a change in tools/memory-model/README "REQUIREMENTS" session
> when the new version released.

Puranjay, it would be great if you add some litmus tests which use
additional atomic primitives under tools/memory-model/litmus-tests/
as well.

        Thanks, Akira

> Boqun
> 
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>  tools/memory-model/linux-kernel.def | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)


