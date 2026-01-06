Return-Path: <linux-arch+bounces-15663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C177CF81CF
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 12:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B415E302104C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 11:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74045332ECD;
	Tue,  6 Jan 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiUF3LO9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB33242AB
	for <linux-arch@vger.kernel.org>; Tue,  6 Jan 2026 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699486; cv=none; b=lFxTtEpZxqDNkrEsE7OaL0OGjliZmIqEiYFGOiB5VFZH2GJpHQLrsXQihQbo6bOYtugF4SAkser8Qxq9C7rcfRM97k9M/VTtf84jU0vMwsyF/dgNGHP8cfDS45Vz89rTUF65H3Vf0X8IKEVjNsGO0RaN/VPga0zV1nQAGsMitYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699486; c=relaxed/simple;
	bh=U/UNWaSZOM/1nnt6plnyQwwSA8jtgy4FJfpB9IxR0vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAUSjtTGMDHwA8vJpRdvVeX9hOgMGveJtpI6SdF4tuwc80o9M9cB69rVyIKndwnHnfDV0vtG1QfxqvU0n1fSTQGg8YOp1B+7gTMxkAbNWhlsMikHFA2PcVJnMUS8FBTCJMRWET68r66NJpV1LjAJi+VIJSUc9g5RiNK4eLHHLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiUF3LO9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7633027cb2so163480166b.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Jan 2026 03:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699482; x=1768304282; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiPIfmjv3b05N/bw/XvHmU5o9/AUPMqaF5FRtYSnf34=;
        b=UiUF3LO9e5SX8lDFd+crV/iEOr46Pzj0BOrE44g2fdAsfPQD1TFBNoQRtj5gYQAOLt
         jkcAN0iz5X1x91fWE+yrR0cpIAisv1PONaSiWTBak9zpEHh7VwNUV2px/Zrp8v3oCI1q
         /qh+FZw1GyRq3nyEmay5OELa2LfkpU9r1hxd/goBFzVhDevmteHyuecF1WXucRCKJPft
         jjNejUKANHeLDGPtD4LvMbmJWv27E539ut2nyFsVUmzJAPSzsLRWDkB1FPRQhUP3fPEg
         iccA31hvM0FzTpI0928X35R3p3WSUcjw0qHzHsef3+2go2p29sq9EWk5HvlHbvYKaEal
         LVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699482; x=1768304282;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiPIfmjv3b05N/bw/XvHmU5o9/AUPMqaF5FRtYSnf34=;
        b=ryYxEsd0Om4Th8om1SIyr4eD7I7oxKZlpVmXlh/RAxc21VSiHp211p392elSgMuauF
         q99XE/rzNG3KIrVBlfvVbh3x4RODpK1lGBhLPXZwKeGpFlCaRAyGjLv+n1NTtvFUwCYc
         PUW92IR+MB6FFuEOmqB+0rIRBf2DFbqXYuWNImP0EIzVakBI9R4LJDvbwQA7fBUyv8HH
         c1+kDF+tyGxPZwzPU6t+qeI2YfWXUFNg+vUKzvEP4mq+C+j+CEetmIsNFTHLy6yNq0Ko
         dKPkRsmeybxYiG/S99Ic1ix1VJcyKVeVHlUUdIGbdNNbpl9oE5swm9H+SgHcYhiSOrp6
         uJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwLw5Gb8z20gnoeDQIt0qKYoMOqAqxmwq7FpaJJSA6XRMGVlOrmDX344sseRUhn8OOADa53rOOSPQP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0dy6i7r/gfVlGdbVoUs5u/YIPzG3IBq+W4qXvtRALgcLkq3z
	o4k0GQF7womcPN8ps2gwZUjPEKoqPFAdClKvcpPXyFy/6At6T1gMiLbj
X-Gm-Gg: AY/fxX7w2HX3NtjYSpy/f3ja8OgxR+60rYKcFzeKDzx93FAKFWWRIBczEjyBLs7Qe6p
	sIV0og77VN1n40DAqqhmEUrR0QzIRKdmvUeyu4t3Ywv0eqSxwHKcUWtuB5LLnPD0pAvV6S3rv+1
	MWiGH4app+lNt/6+UdLA/Un5NnHW6ZvpgRyfHvdVmr0Xd7+dRsTr0hqFz2AsWVAXg9u646rTSgH
	K36NxXQNg7k9Yayx9xaL7kAACTmi9IJ1yll+2dQHhQQ/jgaI4lLmMzsb0YTS5dwJ2y+u76ugpOq
	x1hKyGh/Wc8+gUTvwNZ6i0YVrMxZmu43mnd5ryauchE9+YqC1dPInY2j8RqWpNKeXby1Zb4SsW/
	rGyqw8Xw95xm/8pIOkoqEJQz0JxQ/kgV/8KGwLtsjOwqvmcyrRmLmxFQDuGPBO9aY7JdCQ9cQuZ
	7fWJ9uqpRexQ==
X-Google-Smtp-Source: AGHT+IE4vK7Idw33w0dr627IjMwMmN4O113exdBdmGZBRMY89j9Rrr4y7a7t8aNrQBWlB/zASfmhOw==
X-Received: by 2002:a17:907:3f0e:b0:b80:1b27:f2fd with SMTP id a640c23a62f3a-b8426c4e48emr335853166b.54.1767699481671;
        Tue, 06 Jan 2026 03:38:01 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2bc6bbsm212937266b.27.2026.01.06.03.38.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Jan 2026 03:38:01 -0800 (PST)
Date: Tue, 6 Jan 2026 11:38:00 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, will@kernel.org,
	aneesh.kumar@kernel.org, akpm@linux-foundation.org,
	npiggin@gmail.com, peterz@infradead.org, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, arnd@arndb.de,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_gather: remove @delay_remap of
 __tlb_remove_page_size()
Message-ID: <20260106113800.rilod6iajre7wzxs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251231030026.15938-1-richard.weiyang@gmail.com>
 <51e72690-8a0a-4532-b6a2-79a851edc44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e72690-8a0a-4532-b6a2-79a851edc44e@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jan 05, 2026 at 04:44:28PM +0100, David Hildenbrand (Red Hat) wrote:
>On 12/31/25 04:00, Wei Yang wrote:
>> Functioin __tlb_remove_page_size() is only used in
>
>s/Functioin/Function/
>
>> tlb_remove_page_size() with @delay_remap set to false and it is passed
>> directly to __tlb_remove_folio_pages_size().
>> 
>> Remove @delay_remap of __tlb_remove_page_size() and call
>> __tlb_remove_folio_pages_size() with false @delay_remap.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>
>Right, the only code that sets delay_rmap=true is zap_present_folio_ptes()
>where we now only call __tlb_remove_folio_pages() directly.
>
>Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
>

Thanks

>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me

