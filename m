Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0162B362CF3
	for <lists+linux-arch@lfdr.de>; Sat, 17 Apr 2021 04:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhDQCkT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 22:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQCkT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Apr 2021 22:40:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E846C061574;
        Fri, 16 Apr 2021 19:39:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h11so1881996pfn.0;
        Fri, 16 Apr 2021 19:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=rjTC8IKkPWGWDKmkZjVmpYAuXFrvSVsRIGffPplx4nk=;
        b=d+i0hnWpFX+Mj0V53vmK2vj8eRQNdZ7OmdBSqZs2JJu/wGdZaWjUSK5j03u+Qpqm/L
         JZoSxrNu88qDz90SkZdyhY8BYMglj4UmZjcr6iTK6UWLU0FqAmcd8fGLlLW1/vwJH7wv
         uZwheH6dxMQ1lPMdfOj75qaFpNBsekFCKLNIKBUCKAHiCRAF0DdRBY6UyDKiQziz4PNl
         OXUB/cWg0CbBphwRIMSOla1jFmUsP8imKGMwzwRREmU2d5lIuEVgaf0gxRGcDX3ZhLHv
         QWLgav7Bm3QDC+X/8lCvPBVXjQw1dbC6orZs1vwa6Fgu1hfu0U5vP03SdT7jUqw9PySn
         oCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=rjTC8IKkPWGWDKmkZjVmpYAuXFrvSVsRIGffPplx4nk=;
        b=f5VCalrIFWg7N0M6TxgZKY+gC5zQwC6SDKDXrICXoL2gZFVrRxUgvZGnyjnADE2eqO
         QRns5uEF69DBJyWNT67DTADio0sxcBnCU/OIQ4vItXoAEM0fZxYeWeQXSZJhyQSVyEMQ
         U0ingeZ5PEIYTGwcchYDHYWIHCqlg6Joq8tgcI/BchaaHu5cUx2SgfiZUaqEPqEqpTTB
         oKMWtr/L2p0xtydRuZdqoButnYlcQqOPDaCYN3ZsaWtv17yvI0NuuIdtO3rXVHr5kIhz
         ZQrQoHVI/nW5rmOhHXsoAcN/le7FEUs/GIrwJAhD3ppbkVa6MHW49Xafd9gbi4d8f4V1
         2FHg==
X-Gm-Message-State: AOAM5309pNTPGSh7r22FtYxKaXKB1jXlmwFchKCUwoqVaLDJga4MzwfO
        xvLWKBRrnw6eQ/dpB+0zGUo=
X-Google-Smtp-Source: ABdhPJzKHRpN7gEF064yyI6uHK9DoHuLx2LLT4PLDM9LCYl5VihNm2cIzm1UeMD0xnn7UN5ajHvQVg==
X-Received: by 2002:a63:28c2:: with SMTP id o185mr1752428pgo.40.1618627191851;
        Fri, 16 Apr 2021 19:39:51 -0700 (PDT)
Received: from localhost (193-116-90-211.tpgi.com.au. [193.116.90.211])
        by smtp.gmail.com with ESMTPSA id k19sm6304711pgl.1.2021.04.16.19.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 19:39:51 -0700 (PDT)
Date:   Sat, 17 Apr 2021 12:39:45 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v13 14/14] powerpc/64s/radix: Enable huge vmalloc mappings
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?iso-8859-1?q?Rick=0A?= Edgecombe <rick.p.edgecombe@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20210317062402.533919-1-npiggin@gmail.com>
        <20210317062402.533919-15-npiggin@gmail.com>
        <a5c57276-737d-930b-670c-58dc0c815501@csgroup.eu>
        <20210415115529.9703ba8e9f7a38dea39efa56@linux-foundation.org>
In-Reply-To: <20210415115529.9703ba8e9f7a38dea39efa56@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1618627160.9nazv519mt.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andrew Morton's message of April 16, 2021 4:55 am:
> On Thu, 15 Apr 2021 12:23:55 +0200 Christophe Leroy <christophe.leroy@csg=
roup.eu> wrote:
>> > +	 * is done. STRICT_MODULE_RWX may require extra work to support this
>> > +	 * too.
>> > +	 */
>> >  =20
>> > -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GFP=
_KERNEL,
>> > -				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
>>=20
>>=20
>> I think you should add the following in <asm/pgtable.h>
>>=20
>> #ifndef MODULES_VADDR
>> #define MODULES_VADDR VMALLOC_START
>> #define MODULES_END VMALLOC_END
>> #endif
>>=20
>> And leave module_alloc() as is (just removing the enclosing #ifdef MODUL=
ES_VADDR and adding the=20
>> VM_NO_HUGE_VMAP  flag)
>>=20
>> This would minimise the conflits with the changes I did in powerpc/next =
reported by Stephen R.
>>=20
>=20
> I'll drop powerpc-64s-radix-enable-huge-vmalloc-mappings.patch for now,
> make life simpler.

Yeah that's fine.

> Nick, a redo on top of Christophe's changes in linux-next would be best
> please.

Will do.

Thanks,
Nick
