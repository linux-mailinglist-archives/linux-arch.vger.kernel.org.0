Return-Path: <linux-arch+bounces-15306-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122BCABD9D
	for <lists+linux-arch@lfdr.de>; Mon, 08 Dec 2025 03:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9DF83001847
	for <lists+linux-arch@lfdr.de>; Mon,  8 Dec 2025 02:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC824677A;
	Mon,  8 Dec 2025 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYna8Eyq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8263F9FB
	for <linux-arch@vger.kernel.org>; Mon,  8 Dec 2025 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161167; cv=none; b=Urwam0qy8UVS2yqexqRdciBHz2xOXa4avNRWAx2oFMitCd5TfnHb906aqzp3Uu/c0YXhjENFN8H6QYKvEsRKgHIOL7dAIfYuTXSobui08Gixj1kmvFo7//J7PVukbW8EA0MciUIQkEvTbOoNUtEukPqRkOKwOsnx4N0SRF5EU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161167; c=relaxed/simple;
	bh=LDZzKnxa+uTKJQ1W2cNOvHeQO1Wju4V+jZZPxkOpJmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh8J77JL3pt/1rfB/8SiDzIwFMcAwYrfCAUOcnKQadceq2S92ZEOrZaQsprHUdzIWqz6oLDo6ORL71dCpfsmfFI1Vuf3ncQa+MotosMaDTOGkTCoM7OAZE7dtml2EXbpqzpNK1ik1N+M82X0tykWTJn7LOswSOg2DVXQmao4hy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYna8Eyq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7ba92341f83so5381613b3a.0
        for <linux-arch@vger.kernel.org>; Sun, 07 Dec 2025 18:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765161162; x=1765765962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYtF8RDRQ6VRaXKUfw5cvR+LupuhtEwbZq6O0/1AaHc=;
        b=dYna8EyqTaE7QpaK8kc+K/8MmSwSYUmFCLZ8F3FhTTXjghsCyoDqwsXhi/rl5uZ6Z2
         mOjZdThoZ7xMK1PmSG4EpHETu3CGf10zmxcLdrNEFkgpmHUv6fLOigdwTxdEZdIGylUh
         cLIzade44fbl2/Q06xH5JoYa37+hJ+RLX3sVb1z3STZGgGzVFiX+pMA4a45zXF5HWmM8
         il3T4+IeKPZAVaoJmKdxMZNqzcmWpKdsADvWax4PUFdtR5WCCNqcIjrPLU6AisrVdWdu
         5pgrCM6RV6HECAB4YpJXIwTf5lac3b5xqPozIAaZqPAxYvpIUL+WfPtzfNpnBqOFxTCT
         Tbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765161162; x=1765765962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OYtF8RDRQ6VRaXKUfw5cvR+LupuhtEwbZq6O0/1AaHc=;
        b=dCVwYa4qiTQhCw48WAw+3Mewkm1D+cHPwA+Dq0agajwciEIIAUS/z900NZw4X6DmaC
         /Ka5wd23TQ0hKJJSMJHXu7gWMPGZ2srrJwO03JzTgCEQ6tQqBN/3LFX/5h8l+TUpx27F
         d58QgHHnI6NcZlH3lYKSTK+f3RLeKPjiHu32s+HzegBYSr7Hyh+ws7R4G5PSBoSTkKr8
         k+soe+ILLh25PG5eZ9mQB4b8BlKqdEAnP1vbiT/XQLorxJBXJgLu+CXsGGN4g8OUKGj7
         rPHtx4/PEpzdgsR3qSdwvp3ML1zXXGANoTSa7nu1SFTxaJMY0F0TNB69caIcVhQ0rjEf
         4q0A==
X-Forwarded-Encrypted: i=1; AJvYcCXCHThonleDvZOHFPw7xIaUEK0zz7/I4JKSijsLLKKLhYu78V97PEKAt+GzsbM33s6hx8HMnEn+79rN@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbZ8R1CjE4atUWO6sAfmctrXepvX+Y9NTFQjnoAHKs4OqXF+/
	HgJEvljVVLxITLfpA8L2VgcTKBxg69TPH67MiDvsHRMXnbLC0qkJ+7VQ
X-Gm-Gg: ASbGncty+adHEvo1KoQ4xrtdhBss4nkiB4cE/H/ZauOydsR5HRNMU6duTU5xxww0Gm0
	wnG8IA9s0XG2YgfOck0h85S206g9Y4f2K4mG+Y95B+qElnshRCuppfl/PiMy7Da81sBkDUr0zp2
	tjZty5yuFY4/uO7jPTjmZOVl+hAaV+LkwCVdFhZ4Xx1637vJ9QHVmXU/YiJyQhGaZwU0XDQH2Oa
	ROP8pm2NX+gUazxjgFCPuZaRBiPBwxVq1mO6b6i11Khum2yg/F42ZI6jlgfbaDC7F1TEVW5iMmd
	ITKyRCzjx7gCF1cwbDbe5ztanWL6gqFO4pYosD66zCQHLRYWRw9Rmv+KlJ80i4vV6kQMcu4a/2D
	x5t3IE3FDIlrtO7hGdwurULqjDKDkpeVz8IigH1RpoMqSbJQKS5iBPz3CV4sI+uiicg6IvbU=
X-Google-Smtp-Source: AGHT+IFD9CuAvyh/LldTgp7Zr7VitBVZghYnCn8DknhWR1P71K3h0yhqlnfFLuZIhyuQUfCBStR0eg==
X-Received: by 2002:a05:6a00:1883:b0:7ab:f72e:8f9b with SMTP id d2e1a72fcca58-7e8c3a0ce46mr6066644b3a.25.1765161161990;
        Sun, 07 Dec 2025 18:32:41 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([2403:2c80:6::3075])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2af658d84sm11155165b3a.60.2025.12.07.18.32.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Dec 2025 18:32:41 -0800 (PST)
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
Date: Mon,  8 Dec 2025 10:32:31 +0800
Message-ID: <20251208023231.1257-1-ioworker0@gmail.com>
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

Tested on x86 with two independent processes sharing a 1GiB hugetlbfs file
(aligned a 1GiB boundary).

Before the fix, even though PMD sharing worked (pt_share_count=1),
hugetlb_pmd_shared() returned false because page_count() was still 1,
causing smaps to report it as "Private" and pagemap to set it
PM_MMAP_EXCLUSIVE incorrectly :(

After the fix, hugetlb_pmd_shared() correctly detects the sharing, smaps
reports it as "Shared", and PM_MMAP_EXCLUSIVE is cleared ;)

Tested-by: Lance Yang <lance.yang@linux.dev>

Cheers!

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

