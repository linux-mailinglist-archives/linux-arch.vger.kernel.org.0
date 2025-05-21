Return-Path: <linux-arch+bounces-12059-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93378ABFC4B
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B82189A603
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC99262FC7;
	Wed, 21 May 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="1tsEYU7z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AB22C339
	for <linux-arch@vger.kernel.org>; Wed, 21 May 2025 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848728; cv=none; b=LTC8YT/xOSy6CqnateVkjdrpEE9YF2liiavFBFAIbefZ/+7cS/1puxLxG9pCm7gopK6DMeGTyGXCEZH9z4ILjUTeG2xCWJpBxksMPZQ/Lp5imt419VxH2547WiynHXjyFPhR53BAg1OR9OlsGRV6RuRdmDRl2qOcF59u45/iTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848728; c=relaxed/simple;
	bh=1HQ9Vk3NQYjK9IEulVHhOScSL+1dpYQJqOo9HGzxIQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFhH/ctTH8gIX5S7L0oQkSamJ1MsStTeH8nJtLjOuaQ/lFfkx/N28PbM3kcqvt50ZoO2h3iO9yR5yZRj7+mOwC2DNVPFbxYnGWfJm+vHZ+s9uQl35hE8rqRzhoTr0whrOIhoJfjBhldTJRR1d0Lx+EsHnV/Cwy/grWIASbXEh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=1tsEYU7z; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f8d4375aa5so27169366d6.0
        for <linux-arch@vger.kernel.org>; Wed, 21 May 2025 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747848724; x=1748453524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suXlybax90mobQ6FosQJnDKub0BKfCnpHnlxsWJzblg=;
        b=1tsEYU7z43Dwg+/8xlTeYe3ZG+L6L5okyI6H5oAouwJUzX9ANJJAFZykWDnNYkc6Wi
         u0yy706A+dW5w+8uZZqHF0ct7IBHgKTRKoNhSgLCIliuxtooiWJBGZ+QYh+WZMUaIYhS
         ZD3cYcWzukGc+QQZ8ezq88m/RMH5/FnYsfCYJylCgpV4HYbSVcGil6ethZf6uPNvGsvR
         OCESnuy/d6AUkyXduih+0KdaNGrY/wKp3YwYR1/re7HdS6eqma247SZbEEv7LYUJxMks
         KQEXfQlOWYxj4cC++25a2bGSz+HBDix1NWmaUCvBcH/8q7R0YPL40bIhNAar9bSfgkJP
         7llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747848724; x=1748453524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suXlybax90mobQ6FosQJnDKub0BKfCnpHnlxsWJzblg=;
        b=IABvXrrW1aCwWQWxrF9/q/ItvtcSA/qo7kbe4Yc7kgUfLWxdTXe4TPTQvkjOu/yVS6
         Ajbq0MDatOQyXXq3nnpOBqWTBvmnuTBjyCm4hjtRZVNJ2leM0MBlPGQLV/pPZCBTZnW3
         CfEv285DlNsF4czKFEjD4LyS28Zw9CLv62uoHn1hNtLaKLjpn3f3Oj88o1wTi7PpNqTc
         CUY7hb/Y8R+CZh0aLr/ulD8+AYIjQtZ7PKBrWE5ycHXxjlv1joEWjwesEfFtbCGqusZk
         yDKEwHVMAtxBk97NDZ0OSjHgBM6Pk+KsZ7KaDVNhmowCJcMgAQ2B9M6T8k3TzOhvyHEm
         qv4A==
X-Forwarded-Encrypted: i=1; AJvYcCUBCqAfDQ5d3XWSbzic482/EzarX/xU2olgEb5XbjEEol8dnHYNe62z6OVgcgcFS3tzxp/btDK8cDot@vger.kernel.org
X-Gm-Message-State: AOJu0YwzS4oxI71/qfV8dj+N2jJF+FPngTRImTmp10mu6fGqY2gPFoT4
	1nOaYIAbnUlTt6gHL/IYwciYzxgFr6EmmyZDIbl/dchIiQl7+qcsq6SWqwiTbo/Ai4U=
X-Gm-Gg: ASbGnctL0Sh6lZwGbwidwlpor8s8+BuMeDqr/aNIEtKQbmzQH9Td8P6Yp0oOmOfC4Pk
	lJEvH2mYUy7dAUJXKbHlJHcPMVXJG9tx5wrInUHY7jegX7SQ4F4OorB1fppH6HJu5fhSiqJM5w7
	jgLHZj2MWsLV9UHmmECFeutGwTuGUt0xvcNr8/MBSr7JXF4sXvMqFi8D307RvjBajOSmNCr4eyi
	TBwDKIYRy6BZC0E9j5kxmlTqgBPvZpF9j/EPnXTUZkv+heA1kHbDQSAJdDMarBc4myczUZyDIer
	mGMjkXTFA/NEaIxmuSEWAtIkP+HzS2uK9+AP3YqnjiyveaufVQ==
X-Google-Smtp-Source: AGHT+IHk89lrfDbD1tLE6FdDmqd8y2oQPYVuXSrTJcpIGCApzYr4tb3ZCZ1X828zDO3Ual08cgJMXw==
X-Received: by 2002:ad4:5f0d:0:b0:6e8:ddf6:d136 with SMTP id 6a1803df08f44-6f8b096db83mr339660526d6.45.1747848724463;
        Wed, 21 May 2025 10:32:04 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b08bf817sm87730646d6.62.2025.05.21.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 10:32:03 -0700 (PDT)
Date: Wed, 21 May 2025 13:32:00 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <20250521173200.GA1065351@cmpxchg.org>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>

On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
> So, something Liam mentioned off-list was the beautifully named
> 'mmadvise()'. Idea being that we have a system call _explicitly for_
> mm-wide modifications.
> 
> With Barry's series doing a prctl() for something similar, and a whole host
> of mm->flags existing for modifying behaviour, it would seem a natural fit.

That's an interesting idea.

So we'd have THP policies and Barry's FADE_ON_DEATH to start; and it
might also be a good fit for the coredump stuff and ksm if we wanted
to incorporate them into that (although it would duplicate the
existing proc/prctl knobs). The other MMF_s are internal AFAICS.

I think my main concern would be making something very generic and
versatile without having sufficiently broad/popular usecases for it.

But no strong feelings either way. Like I said, I don't have a strong
dislike for prctl(), but this idea would obviously be cleaner if we
think there is enough of a demand for a new syscall.

> I guess let me work that up so we can see how that looks?

I think it's worth exploring!

