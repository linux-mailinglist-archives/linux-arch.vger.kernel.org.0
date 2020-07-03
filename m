Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46243213065
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 02:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGCAPm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 20:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCAPm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 20:15:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE52C08C5C1;
        Thu,  2 Jul 2020 17:15:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so11934616plq.6;
        Thu, 02 Jul 2020 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=nuJRvdB0NXvVZz7pZcV4N1oDW2dnoBAuVAW0OAoXK2w=;
        b=LSEdiF8O8c0k36FJz+J/p1Xm+032fT22eON16GPFoOrZL6GDx9jPsHusIL7FEU0XAV
         lLDoHY9NSZfpcd5oNSgz7AXGqRLd1dfAW9ad86/buGeCa4uTE/vU9OPIKwfaZyBXfnsJ
         uG05dXYdVlfndLY83LDfB7lzK6ZqRQP5RvYyTLEoAscx9LtDbk1kTfrj/Cwbbvqz6uxW
         IUIYgXT0pd0DwhOqvL6wEv82lwldnFjq8WUAnvh0BthjGb+v++4h6R72lTgxl5Ir5SPV
         KaijBTzwUbf0D6ex6rU/rFRlvvyVHMSFetaS1LKZRTYt3D1mhdMNSiJCFStkUNFQKfnS
         w0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=nuJRvdB0NXvVZz7pZcV4N1oDW2dnoBAuVAW0OAoXK2w=;
        b=Hz5uPoOmI34jNibxFQgzG8dcvyTpPuwttGzgdY/dGS6GK8euGDlfSxLRaOd54uwZ7e
         wg1iiQ1X2096xLB0jcr6U3QIZMnPvBS8sNWAwADZWzEAu7D8NKhAnoUq62vCcS6uwXAu
         /WqcPecuG/yIXPQznZMzrrVoyJ5a0k8+GD8XSyIxviX+1bcoEwxfqJEDD3ENPhPrN3wS
         80c7jzkC8CbweoPS71I664qGUHr7W0l4GNgVbip/eVDHWsTt23mSguKcinRIzVT0/4+7
         WWapd1+dgB0ICBKKTBZpwu+F3gZWnFCqpzb7gX6mw3OSq8+WQFmkeKWYPfvBx1g8Mlkm
         sq1A==
X-Gm-Message-State: AOAM532WY+cpTtymdk9IBnjP7f1YFDQiWTyXYeWI9wDg38bzd1wrpoJE
        GyZKyYga0cxBZwowUHIi4lGqmzE3
X-Google-Smtp-Source: ABdhPJzVARbnUoiUECgH/rt6gF7oxr/jO/Or3UFnEeEEE5zO8Q2uC+eAackVR4Z456AOo0TJ+H99Rw==
X-Received: by 2002:a17:902:b78a:: with SMTP id e10mr28875186pls.34.1593735341316;
        Thu, 02 Jul 2020 17:15:41 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id b11sm10202251pfr.179.2020.07.02.17.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 17:15:40 -0700 (PDT)
Date:   Fri, 03 Jul 2020 10:15:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
To:     linux-mm@kvack.org, Zefan Li <lizefan@huawei.com>
Cc:     =?iso-8859-1?q?Borislav=0A?= Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        =?iso-8859-1?q?Thomas=0A?= Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <d148f86c-b27b-63fb-31d2-35b8f52ec540@huawei.com>
In-Reply-To: <d148f86c-b27b-63fb-31d2-35b8f52ec540@huawei.com>
MIME-Version: 1.0
Message-Id: <1593735251.svr5r5cxle.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Zefan Li's message of July 1, 2020 5:10 pm:
>>  static void *__vmalloc_node(unsigned long size, unsigned long align,
>> -			    gfp_t gfp_mask, pgprot_t prot,
>> -			    int node, const void *caller);
>> +			gfp_t gfp_mask, pgprot_t prot, unsigned long vm_flags,
>> +			int node, const void *caller);
>>  static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask=
,
>> -				 pgprot_t prot, int node)
>> +				 pgprot_t prot, unsigned int page_shift,
>> +				 int node)
>>  {
>>  	struct page **pages;
>> +	unsigned long addr =3D (unsigned long)area->addr;
>> +	unsigned long size =3D get_vm_area_size(area);
>> +	unsigned int page_order =3D page_shift - PAGE_SHIFT;
>>  	unsigned int nr_pages, array_size, i;
>>  	const gfp_t nested_gfp =3D (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
>>  	const gfp_t alloc_mask =3D gfp_mask | __GFP_NOWARN;
>>  	const gfp_t highmem_mask =3D (gfp_mask & (GFP_DMA | GFP_DMA32)) ?
>> -					0 :
>> -					__GFP_HIGHMEM;
>> +					0 : __GFP_HIGHMEM;
>> =20
>> -	nr_pages =3D get_vm_area_size(area) >> PAGE_SHIFT;
>> +	nr_pages =3D size >> page_shift;
>=20
> while try out this patchset, we encountered a BUG_ON in account_kernel_st=
ack()
> in kernel/fork.c.
>=20
> BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
>=20
> which obviously should be updated accordingly.

Thanks for finding that. We may have to change this around a bit so=20
nr_pages still appears to be in PAGE_SIZE units for anybody looking.

Thanks,
Nick
