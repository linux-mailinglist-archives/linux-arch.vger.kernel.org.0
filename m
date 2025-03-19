Return-Path: <linux-arch+bounces-10959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE49A693A2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 16:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E6B4605AF
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C81C8602;
	Wed, 19 Mar 2025 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VHEtRE82"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB91B6556
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398346; cv=none; b=OHyhaLSMDU2Ed0xhdORYQ1R/LKT7VH1gZrIghKB/KO4u/63TiGYlVxf5HmEEEu08mnMtSgZ7JngzH7zporHd46XiXqH/muxcOiZHC9ZGASTNFads6CAf25fjRfA/f6F4pJ3Dy1RC3/3xzJg6MdCZY4GVwsb5DlDT3jm0b9m+Kcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398346; c=relaxed/simple;
	bh=DecHoeVvuZPf1798B6ofl0KEVe3MSa1ULHgC3f/pgt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx7i2NuawnxN+16b4KHLvsIbPID8aR5Xx33hQ8bvOkritnQ15D6RO16ozpu5AZwHTSPjEP8qCibLxIbHP47witf7jKSylZYWmCJ5dOTRC3to3PQbJkCG922Pu/Yjd8DQSxxxXvVVWKEofYZM8WabWSAeZ0Xf4wFJaYwz4um42yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VHEtRE82; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22359001f1aso27942965ad.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742398343; x=1743003143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn9F1c5LdYViJ/xCFgH69JHzYJf0t1bW8IYQTve3Il0=;
        b=VHEtRE82dpW80KhRY2ibVphmyZxSCwFrNEb47iibxNFEoqgYfCoeXH/9f1C+JxXAbT
         PkNtN2RH9ixJHgDd4g2ZrCjIHzNSfTmQkkSzMR6hR2OcmL3z96OUpkeVdVjnkLkJRjuH
         YqVxFgFMdB3x7wAuV0MHrb7qir5rwBztA8CPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398343; x=1743003143;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn9F1c5LdYViJ/xCFgH69JHzYJf0t1bW8IYQTve3Il0=;
        b=K1IuoRG/s5ZRojbqxmGRHJ87y/G7CwnJw3ERsnOD3xSF1LaxWlmjX5jIhDMO6j8JvS
         ewIoTNUVsu2Fr/iZTZNR8CX9FgIN/mm61UB5QQBjx8+WIgrxreWQzBKqMA1hmjrmQguZ
         TnnSnhk1jSSDFZY4cidijBXng8xHN3jrKzEv/LAcvvAYacFKoB4yAZv2mXkt9sDQtgiU
         iSU/7D28CIk6GTg8wh0sETOm/uUU2w8RqdKiZPQ2bYzrdZeKnHN7tszit9wXe9E+fIaj
         j4dheW4pbu8DoYTQxCE6MZ8ZZhnrrlrLHzxmPXj1ig89hQNAPGRZeTUHp/wd6bxOWpG5
         UlLg==
X-Forwarded-Encrypted: i=1; AJvYcCXg60b3puY+JLNCObTTJDAV8iNSQrFbQxwD2FZ4CvQ85s8WmOg0UuzDfH70py1FzrxoYjQEEX4KRWxg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+J2JsLUWGrMMFKOEE4Sp420wSut3B81Uo7uREoqv/PuFjY/fd
	7xnRtj+B7U1nygG2euKJX/tGVuNb/TLWhaV1fWDX4f/aCnEjmNWOGfrY1m3Enyiuyu0o3FLfise
	2
X-Gm-Gg: ASbGncvf/MOEU7tKOiNIjkB1qu709K3sSr1WAAh1rwLtpc1rNQGESXnItxJuwnFqQw+
	6+HRtPVNJKy48BApvNTa4k0F78ETCyLus9CUrmT5RmFOC1CmJB/c3zd1Nsafwq+DXiFmO3H4+Xq
	Ua3T+FbY1X/WLmR1YT9KARQHZTOAnXjJbb2SgKOBWV2W1tv/IRgK5fFUkZqAZOgnSp+Y6VST9FX
	1amA2+XrD2HZM+aj4D/f8BvnFtc0YIiqALBo/RMCgEH7OcxrKBLpmqmI1Gbi3RG/Qw66ytBXvKD
	PhUqDKYz4oGRFjCeZ48UBOgStelcC5rMaA+MH46m7QxmDFM7mds/EgSCNf660vlzy7OGTHifKkr
	l6UBijM9PM0OdkIzYdHIzCGzJQ8I=
X-Google-Smtp-Source: AGHT+IE928EvL/A0pSVSiRkpQ590uJxm0F/MyNYT3ARIPaWUxA9t+V2zDq6An5Z8ZPQuHl4hSSFFbg==
X-Received: by 2002:a05:6a20:a111:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-1fbed315b41mr5956837637.36.1742398343445;
        Wed, 19 Mar 2025 08:32:23 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea96e58sm11106959a12.78.2025.03.19.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:32:22 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:32:19 -0700
From: Joe Damato <jdamato@fastly.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9p6oFlHxkYvUA8N@infradead.org>

On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> > One way to fix this is to add zerocopy notifications to sendfile similar
> > to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> > extensive work done by Pavel [1].
> 
> What is a "zerocopy notification" 

See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
sendmsg and passes MSG_ZEROCOPY a completion notification is added
to the error queue. The user app can poll for these to find out when
the TX has completed and the buffer it passed to the kernel can be
overwritten.

My series provides the same functionality via splice and sendfile2.

[1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html

> and why aren't you simply plugging this into io_uring and generate
> a CQE so that it works like all other asynchronous operations?

I linked to the iouring work that Pavel did in the cover letter.
Please take a look.

That work refactored the internals of how zerocopy completion
notifications are wired up, allowing other pieces of code to use the
same infrastructure and extend it, if needed.

My series is using the same internals that iouring (and others) use
to generate zerocopy completion notifications. Unlike iouring,
though, I don't need a fully customized implementation with a new
user API for harvesting completion events; I can use the existing
mechanism already in the kernel that user apps already use for
sendmsg (the error queue, as explained above and in the
MSG_ZEROCOPY documentation).

Let me know if that answers your question or if you have other
questions.

Thanks,
Joe

