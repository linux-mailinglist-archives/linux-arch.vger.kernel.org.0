Return-Path: <linux-arch+bounces-12206-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A37ACDD99
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 14:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B0A3A5EAF
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588028EA79;
	Wed,  4 Jun 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfIgIcjP"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9728ECF5
	for <linux-arch@vger.kernel.org>; Wed,  4 Jun 2025 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039232; cv=none; b=ccCQ0CM4BFwRCzTNKIJCEJTbMGPePqfcXLml2MeWQZ8C23gOZXrwtG8InuJBsg5C87UzWIczWv/osf2n5FLdhh5TL0my877zo20zOJ5heRwUWqNYDrHDT+OfJ6TfICWTIPJTXowLPXeiTAIa/RGdvvgAyFMU800r+XCJCgzqJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039232; c=relaxed/simple;
	bh=M91WX10OykSuts3tq0EmaMg+DxK8RsoijLDtBFghApE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoRHc40VvrSY5s8Bhw+veLFgxPJAagj8bxwUqlPFA1KB9Z1acshkkdGUeElc0ADZVLkBilg04OV0qjM10ONxGwWDb+p3Tqt1Arsi6fkcSxe7zBd594VjVR2xpY/2aLVRa6ObWNlPvhK96VVFXcs8pPfz2F4dkfkAr7CHYqMSPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VfIgIcjP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749039230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sGZd5jkJzXRR5Y1KNgGDi9lodbqrFlXTwmeW8YPSQr0=;
	b=VfIgIcjP/+5YGxJQWS063JHlccMRdK/h4JenOqWXazfEEkO8AgX329axq8+D1zMvMTzK2t
	dfvwVUQn5BJX0tKXqTfu9Vk/X/HLt5SqcR3XA5IEx8Nw93bahitaolk1sg7UZFLyFWdwsg
	haFBL6QLdo48jVcqL7gI6LE5Yb/JsD4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-_48gh5BsMK67MtPpeRtuWg-1; Wed, 04 Jun 2025 08:13:48 -0400
X-MC-Unique: _48gh5BsMK67MtPpeRtuWg-1
X-Mimecast-MFC-AGG-ID: _48gh5BsMK67MtPpeRtuWg_1749039228
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f55ea44dso2977822f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Jun 2025 05:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749039227; x=1749644027;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sGZd5jkJzXRR5Y1KNgGDi9lodbqrFlXTwmeW8YPSQr0=;
        b=dEOVytXJlf8V1/PZ2KQ8RjMHeNP+EAEhWtt9oPr/Vbf7oFNwJv649b9aRS6lBQPbsV
         voawZgahkC2AQiymo70NlZW3SRoPR2Ox+unH72KqWAavjK/ZCH+Q+9bIfHE3WqHHzzSR
         DjRmIsGVK2u+rqxb7OIeLrmOTL1f19pYmE9taOVccc9yJoGrI1Bq1V+T66SOGPOPLFA4
         E+u/X0eHdBSoRUo46oiXzGB+7yghL1i0QBrxZ94uQ0edx6drWg9wRkR+IgPUZFp5ICfg
         oFMXXUah9FgCKfvw8zBbdXnPSlreDcwDkmOp5L48LSj66Mf6feJntYXbMgI0wVnqaS3q
         dxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ce8hDZ82R0e0iR3Y2P9QeiLJQqoowquxmAKA2nTl+bUcHecKjv1Ec/xWkT45NVSyVIvYMBC1ImpF@vger.kernel.org
X-Gm-Message-State: AOJu0YwArj81Vclwo3E//8L2nXYd2yy0nfaxVgFF6Yd8DjBOmncTB0q1
	+Havhca1QdCOjBDGdhpSQbB2mBGJHS2hJutog4deU7XOuq4gPXbLPW0UtXWsk18RwGkK3JxiCS+
	UVkU5oHfHTsu6JwDwLaGj2MzfNXJNDSPHb0SYHiaJqNt7yw2Is10hqeXKIxvVHTQ=
X-Gm-Gg: ASbGnct9tbdJ3ugmnFI7pPtI6ylw68cEB00hO8ATa8gB4rn3EjYlpH0wQf94OcW38DV
	qn0HxcAiyncP/skEwV+AAZOJ9/QkzVkbV3zgsSKN5M+Ny9as4nhJ6hyhDnWsCvjUSDCrhWSbwmB
	Ut2oJQg5t/A5Xq8Doqv9wnCZOmzhap5WKUMPXusgb0gi3tOeIX+4YqJ7IyAKApbajwOBvHxUQVQ
	Od13wM8ayogS9HcyHgNaC8KN+hCBKq58p/8dffrpzGkSdbxvW5KHC24Dc+Of0JhoZT3kSeuOVXk
	2E1tdlByg14TQzhc917xcol72SYfDFkwufxl16SO/RzWgyWH5a9yLS0x3msObBEc3oE+qbG4iQm
	ztM0EwznDjyfwoElg5n22iaOxAuwCZR/11tzOSis=
X-Received: by 2002:a5d:5f85:0:b0:3a4:d0fe:429f with SMTP id ffacd0b85a97d-3a51d922d28mr1874004f8f.14.1749039227560;
        Wed, 04 Jun 2025 05:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqYcUXaR9htAa65DIl0cC7t2Xtvb0tAc+5MHwkqiAmRAUKyw5KpJnBDKbemV1jQ4tddElXPQ==
X-Received: by 2002:a5d:5f85:0:b0:3a4:d0fe:429f with SMTP id ffacd0b85a97d-3a51d922d28mr1873983f8f.14.1749039227138;
        Wed, 04 Jun 2025 05:13:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf? (p200300d82f1bb8006fdb1af24fbd1fdf.dip0.t-ipconnect.de. [2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c525sm21478526f8f.23.2025.06.04.05.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 05:13:46 -0700 (PDT)
Message-ID: <2129a260-3553-4cbc-a33c-fb81f0dc2d57@redhat.com>
Date: Wed, 4 Jun 2025 14:13:45 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add tlb trace events to MMU GATHER AND TLB
 INVALIDATION
To: Tal Zussman <tz2294@columbia.edu>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250603-tlb-maintainers-v1-1-726d193c6693@columbia.edu>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250603-tlb-maintainers-v1-1-726d193c6693@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.25 00:50, Tal Zussman wrote:
> The MMU GATHER AND TLB INVALIDATION entry lists other TLB-related files.
> Add the tlb.h tracepoint file there as well.
> 
> Link: https://lore.kernel.org/linux-mm/ce048e11-f79d-44a6-bacc-46e1ebc34b24@redhat.com/
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


