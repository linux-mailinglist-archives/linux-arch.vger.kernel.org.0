Return-Path: <linux-arch+bounces-15300-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9661CAA1A2
	for <lists+linux-arch@lfdr.de>; Sat, 06 Dec 2025 06:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C377F30DA707
	for <lists+linux-arch@lfdr.de>; Sat,  6 Dec 2025 05:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F21241696;
	Sat,  6 Dec 2025 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgEHZqtn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0332D0C7F
	for <linux-arch@vger.kernel.org>; Sat,  6 Dec 2025 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765000570; cv=none; b=XFYPp/fzJ7vHx3vX6veIhyBtTQ1vyfMC0TGgwRfAqbGtACVz1kCf5tAt0aSfLXJgqv4az4YhjXxYOXWXy14bcp+Mo+WuJcQnjR1JH+9hHnfsVNuiTVwND45kU2fo6RN2Fep7+9m+PfQw3CQirSKEWL0gJWrvUSPOign7YIcftTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765000570; c=relaxed/simple;
	bh=Q2UpzGVzQ7GyqvIfwF3lOwJ/eL4xbQ28HO+AIZXRBVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuhfp6iyPRBmvpGAQDVJwLDMAzcZ7icVhq6mUL41PrnoMTgpskzukhDet3Gz0piUg4eIjJjSvIEFVh/ceXvwtHBdiHE/j10MKtR3Umcl8vq+qEXT5PKGRyqYLq9QCI/6MsmgPSiI9Vbz9E2fnznSXBUkLsxSmNydmJ/B89Yghz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgEHZqtn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29555415c5fso33587415ad.1
        for <linux-arch@vger.kernel.org>; Fri, 05 Dec 2025 21:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765000566; x=1765605366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrbaEeZyFtbngXF37obLkCJVhms+uI4jT2nngSTJ7L0=;
        b=fgEHZqtn9cOuPfRdjwJa3T+eCv/ElVEiS5tcrFKJiAYYbebMiPWGDmXH5gzQncypt4
         yFamfoqTx/xPTSDnFCQUoHfufd3INIFdMlJj1opkap+9QoYKTspiioWO1fZ55kFYcPTd
         7/AuYG1nBA9se9UIPMa/5EAFhHlPsN/XyjNvPopUHPRxhY1YONEBmtGJqZkDmdJ1oovF
         5gkz05uXtvL1n5ZdIZqaLyPYLOeMtlI2ejC9yhxCLlGJAlpgsNzcoiLFCoecegHoBVts
         Qs7CJUr7cDOlimmUeQDBVa2di/BMQgAikW1F8L/bxpPLwNysfGFqqiUG6/7+YX/heTuc
         N3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765000566; x=1765605366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YrbaEeZyFtbngXF37obLkCJVhms+uI4jT2nngSTJ7L0=;
        b=Nu2ND6k2Kx5ZEBBqW33QwvqPcZf9KeUso0rS1xjO5kfi0KIQpTnediy4T79ZRW2NUV
         7TcSCZlovslcKP3mOlBhSdpcMSl4Gp3eqXQJQpa3wwYr1hCbkenUZ9cuVl5WripYQSlK
         cgYZZDqfJ1yNhtQdQZmCKoYHKPBzbVzcFRbS3R5ehq6vBu9tmp9oATc1BMhQJtEpnkHb
         TbDUpKALXE8Pb18qzE0d3t8P+bHi6j1n2kRqN/RpESORRWbce4ZOScopugTzxX5UGLPI
         QF/mocDOxkWZLBj9y36DwVs6c9u5/St/Il/aV6DU9WpnN5cS7DdPJy24l8Z1qLu+VkJK
         dI0g==
X-Forwarded-Encrypted: i=1; AJvYcCWTYeHA95cEdg6vlUS1ZT8kyJaAPxdoGwJJiPkCEniqYS9f86W8K5tzkFXY3+Cznu+41SeRy/O6mq9V@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJhCfjP8cf3evkrU+40ZaFiHXt/h/1XguMvrQyGbekov7vaj3
	0+zPcB6HrZcK9yQcK+rp0XoorkC+54mlxQafzf8Ff3KO+W9kleD3lEiD
X-Gm-Gg: ASbGncvKt/R0eTQMGPuACe9pThtzk8nf5eXPhKKOlQDm8yTcr/9DLLhqAt2VfEBndBL
	vK8oDfaZkcaUsE08oMXMfRRUCeqrRDrxS+RTHqw0fdzUyejCqFHPVYgx61hAd4toYWO3TLmeQ3u
	K7yso675fX3FtPpPXqzXLsbUOIUaIme3rwLU5psMcf45uUmfrLV0EnPdamNsFQwZ4+9hzZvgOcR
	ki04VYVkIHyJyeh2/fEr9s9IWR5NGzUb8DVrNf2PQiSALA0FgvWglA7YUtSrXhWY0l681JJESRw
	HTwjLLo9wy/bfjmWC3NL+98uyBQjBXTdChagmWYVOXV1tA/cQVa+6iBtBhx4jVxGCkTVGSxDxts
	7rj6+GZRK+cHpf4Hr0bfnDaER5wlzVODuD3vofpnXB9GOlPTyuUcV2s6oG4+TjcDpD6Kp6GKA2w
	==
X-Google-Smtp-Source: AGHT+IEClIJqnfu4ac1OktA9MDlfbK7+ctU0dMbbXWjgWORZv1YG8Z3vrYDot57qQm9pxIBtqkyn+Q==
X-Received: by 2002:a17:903:1a68:b0:299:f838:a279 with SMTP id d9443c01a7336-29df547233bmr13933795ad.2.1765000566526;
        Fri, 05 Dec 2025 21:56:06 -0800 (PST)
Received: from localhost.localdomain ([2403:2c80:6::3077])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaab9c0sm65407775ad.68.2025.12.05.21.56.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Dec 2025 21:56:06 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: david@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	arnd@arndb.de,
	harry.yoo@oracle.com,
	jannh@google.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liushixin2@huawei.com,
	loberman@redhat.com,
	lorenzo.stoakes@oracle.com,
	muchun.song@linux.dev,
	nadav.amit@gmail.com,
	npiggin@gmail.com,
	osalvador@suse.de,
	peterz@infradead.org,
	pfalcato@suse.de,
	prakash.sangappa@oracle.com,
	riel@surriel.com,
	stable@vger.kernel.org,
	vbabka@suse.cz,
	will@kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v1 1/4] mm/hugetlb: fix hugetlb_pmd_shared()
Date: Sat,  6 Dec 2025 13:55:53 +0800
Message-ID: <20251206055553.21759-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251205213558.2980480-2-david@kernel.org>
References: <20251205213558.2980480-2-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>


On Fri,  5 Dec 2025 22:35:55 +0100, David Hildenbrand (Red Hat) wrote:
> We switched from (wrongly) using the page count to an independent
> shared count. Now, shared page tables have a refcount of 1 (excluding
> speculative references) and instead use ptdesc->pt_share_count to
> identify sharing.
> 
> We didn't convert hugetlb_pmd_shared(), so right now, we would never
> detect a shared PMD table as such, because sharing/unsharing no longer
> touches the refcount of a PMD table.
> 
> Page migration, like mbind() or migrate_pages() would allow for migrating
> folios mapped into such shared PMD tables, even though the folios are
> not exclusive. In smaps we would account them as "private" although they
> are "shared", and we would be wrongly setting the PM_MMAP_EXCLUSIVE in the
> pagemap interface.
> 
> Fix it by properly using ptdesc_pmd_is_shared() in hugetlb_pmd_shared().
> 
> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> Cc: <stable@vger.kernel.org>
> Cc: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---

Good catch! Feel free to add:

Reviewed-by: Lance yang <lance.yang@linux.dev>

>  include/linux/hugetlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 019a1c5281e4e..03c8725efa289 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1326,7 +1326,7 @@ static inline __init void hugetlb_cma_reserve(int order)
>  #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>  static inline bool hugetlb_pmd_shared(pte_t *pte)
>  {
> -	return page_count(virt_to_page(pte)) > 1;
> +	return ptdesc_pmd_is_shared(virt_to_ptdesc(pte));
>  }
>  #else
>  static inline bool hugetlb_pmd_shared(pte_t *pte)

