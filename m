Return-Path: <linux-arch+bounces-10172-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DFA3993C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5CA18998A1
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398041A5BBC;
	Tue, 18 Feb 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cu0gdBXJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529F23645D
	for <linux-arch@vger.kernel.org>; Tue, 18 Feb 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874819; cv=none; b=k+CAYyHCsbxcr40T3iqlCh+U+CNV4j74XVIYj4URolgztIf9kXXU3NqCGb798kMjodeL9n8tL7gkEVrPnDG1V4IwA42868LaiVuklGg/rGrty/aDRyA3Ua1OVk6XCXRSi/aF0UBnQgvlF1NBlmIzSOGNDJlJOPR4Kc6pQCea6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874819; c=relaxed/simple;
	bh=db+mSdmfnMb8TI+b5scWjVaKxjg5A2SjdYzRDQFZkAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fogN+PYNULZzywHri/MEPbFxVJkW3acOlW364n+GZzTDtaAKsmb9ELmnKzx5cvXddryknH+9wN09o627YFA7PKkrZpaX/+uiKobWX4NBkPvJq9SJYulawAYioLKjAXHi0x2+nVB5Ckn9jgmBuu6WihSeKlP4qyahNkUDY706fE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cu0gdBXJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1LOQMZfXNCEDy18+82jAtJj33pWYHUPkHE+taTmaK4=;
	b=Cu0gdBXJCXQqw/jaZpIPpsw1dnxm14GgzJTjDVxPOvMRuCUhCDpwKC4cbfAUHAlEovrIef
	+QZUYWgmAevPQWCT9f4M6HpW8DeJN5KtFw/UErWeuW/2u6aQMLkJ4GlCA9lxEVmqK1yq6/
	juVZU4KT81lRQHhiqZPxlgWPSrqJSWM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-XsyF8QCVP8GvazaMigyTMg-1; Tue, 18 Feb 2025 05:33:34 -0500
X-MC-Unique: XsyF8QCVP8GvazaMigyTMg-1
X-Mimecast-MFC-AGG-ID: XsyF8QCVP8GvazaMigyTMg_1739874813
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4398ed35b10so5762095e9.1
        for <linux-arch@vger.kernel.org>; Tue, 18 Feb 2025 02:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874813; x=1740479613;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1LOQMZfXNCEDy18+82jAtJj33pWYHUPkHE+taTmaK4=;
        b=BPs9rLcOjy7wzv5xoApXYBnqHM8JaNhk4rd5cwOOw3uEFSKJ0ZkJbYcdLxVFhdfI/Q
         pK25qpF7JyNw7gJWMfokAQH++82XNroiDhsNQ7IIcxvigNvmoyJpFdiljsd12Ip6uY9K
         JUYeMgk+kN3uupa0qm+fnlQjP4C7tlcRSgekjQuz1UApPRWXJX0jKuv40IgK3IiPk95v
         2qRVYQqMpXLhKX5bQTiRBhd7y4ZkwctCVmmicqrUokGbBTn+Cv9cGokRmM0t0r/s96Fd
         cPoY6v4hVM+AqtwKnNv+OhekgdlkmJh2+Qsu59kea/2a9m1EODtcU3GAYvEDRHQJcOa8
         sBhg==
X-Gm-Message-State: AOJu0YxaGkpM4ZY82H9rPj6w4m0mEmuy5x8IHJMIyq2IfHGwe6DBajG5
	fRpzAcJVaXEUd2rcXcAsJRmRz8j2nI1JJoeBWqmzGdXF9DOxGTOkKFtuKKO+jGTzHfKTZZ0eOu1
	7RU8bZYKjHaGrUyU/4VTyQf+Z+zboSGHfjEIdGMJz11gZoXHeV8X8Rp3j5Bw=
X-Gm-Gg: ASbGnctbD6Fk9wQEgYlIX8bSAZiEzCx06RKgy6YpgDK0NZZX5OEsf1RyJvoNDcNxMcF
	2TERtE+U3hia2aah6LQJJPj7T56SCfu3Hy29BKOcXx+Ers4wz9YfgpfyhB28jobiM7UIbWch8fw
	U6WljmkNBTrju9hcSVhj5uUf8cUZdTB4xDVwumo0B0Iwoii2XFpru2c91H5JezPw1aAAUF3Kjx5
	PRbaH3zsqFEQtHIZ/igwYKUOzVCx4Mbjz6VlPzmipTWGexEfBlvN4L9JqtfFTFUCgE5CbCozFeo
	8OxbknITtbo9Dq8CVMdFgW9mdqZh8OuV5m22ZsduSGT4OZJJkgQdAsWjDTNBHULOUMlnADgYR0K
	ywA9umeBZlMPSzsxIgw0usxmjHd3uTth9
X-Received: by 2002:a05:600c:354f:b0:439:6b57:c6b with SMTP id 5b1f17b1804b1-4396e700738mr113217985e9.17.1739874813353;
        Tue, 18 Feb 2025 02:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG10HbiKwPJC3eaXgh0cFDz3lLRmRUxioOtL7qoeXgGZWfhvAtzEULY5k9Shgn7deaLtJSxFg==
X-Received: by 2002:a05:600c:354f:b0:439:6b57:c6b with SMTP id 5b1f17b1804b1-4396e700738mr113217795e9.17.1739874813029;
        Tue, 18 Feb 2025 02:33:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987d1865asm46839995e9.3.2025.02.18.02.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:33:31 -0800 (PST)
Message-ID: <fcf41c06-ca68-4b26-9462-d96f7cda999c@redhat.com>
Date: Tue, 18 Feb 2025 11:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] mm: Add folio_mk_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-8-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217190836.435039-8-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 20:08, Matthew Wilcox (Oracle) wrote:
> Removes a cast from folio to page in four callers of mk_pte().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Yes, that looks good

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


