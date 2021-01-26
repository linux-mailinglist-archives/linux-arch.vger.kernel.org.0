Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE1E303977
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 10:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391392AbhAZJvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 04:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390746AbhAZJuv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 04:50:51 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305DDC0613D6;
        Tue, 26 Jan 2021 01:50:11 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p18so11139735pgm.11;
        Tue, 26 Jan 2021 01:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=0BoP+OYH6EXdZxnw4jTi+ce0h1kJJ+YvrP995HEeEfk=;
        b=HAPMFftRZxQG/fBZeVQHKpfYqezKjPzUFWYma5LOeOZuhMrSgaQnFghwR82Hi0Tcad
         6i4fqeK0OEgAe0lPjMHX+w/LEXKabwaw3WgD+7gti+Eq3I7UGN+6+YRRaTKc5T6KgGFT
         x+FH14E2Wga0siPTYUQdnIEKHn+e2plYn73AjOkuryD4Sp/FSHEuDne1lLKJVidRQtNt
         obqeveTlFYP05jEmDI0GDr5yXXaz9RQ4vG8/zio/JQSQ+/5P7bwkD8IJjsswZP/7emSG
         r4VtW5DBjjmSYLx8gY9cAkgVlI/TN/bJJNxZzeydR0tM7Q0sJIlZvG5IcVD30HdqeCXI
         GG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=0BoP+OYH6EXdZxnw4jTi+ce0h1kJJ+YvrP995HEeEfk=;
        b=YooTI0/33TN9V53TRNs+qRrMK0VH0lvfblPpJHp2Ya9wMLzN7rRS3QhjTY/FZg8DFY
         4cM8wtna3dcLoC/VGJh3CWJ5oKa7/yj1kO1MafqyQkkziIJ1XJ8gpIbwuhdIzQqUmVVV
         Q2CI6mcu4c4CLAP7Hm1YhzeKeEfgU/VQPshajkFdYf8Iw8GOEPIXntNaukvQux9IRVgp
         HjSszteuwf64mj9U1PpEeJMuvNCWtT6KTnmcH6cT1OzPLdmTU9alvUNBpuIJb1gX+VZU
         r1WHp5vANrGGzbwxUXD9zh7OUe7HtJc/5mRqJbFrXt4E9jdmQxZPGS1rDvyNL3KdDUFD
         t8+w==
X-Gm-Message-State: AOAM531kXYHSO34/A1ljVsHBLh2cI7naboWrdOXqdo1IQMAWXxjfiFH5
        2R1zdK8Ren3CLW6TUiBUTSs=
X-Google-Smtp-Source: ABdhPJzy2Ur7IdM2ZfVTsqMbS5tBjuUgvkwINi0xes7/ASkks7ScG4l9nU4ZAYkMr3Wud5aCblU1YA==
X-Received: by 2002:aa7:8b0f:0:b029:1c0:e782:ba29 with SMTP id f15-20020aa78b0f0000b02901c0e782ba29mr4498133pfd.37.1611654610729;
        Tue, 26 Jan 2021 01:50:10 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id c11sm17063325pfl.185.2021.01.26.01.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 01:50:10 -0800 (PST)
Date:   Tue, 26 Jan 2021 19:50:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: RE: [PATCH v10 11/12] mm/vmalloc: Hugepage vmalloc mappings
To:     Andrew Morton <akpm@linux-foundation.org>,
        'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        David Laight <David.Laight@ACULAB.COM>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        =?iso-8859-1?q?Zefan=0A?= Li <lizefan@huawei.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
        <20210124082230.2118861-12-npiggin@gmail.com>
        <933352bd-dcf3-c483-4d7a-07afe1116cf1@csgroup.eu>
        <7749b310046c4b9baa07037af1d97d87@AcuMS.aculab.com>
In-Reply-To: <7749b310046c4b9baa07037af1d97d87@AcuMS.aculab.com>
MIME-Version: 1.0
Message-Id: <1611654541.je6x6v0xw5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from David Laight's message of January 25, 2021 10:24 pm:
> From: Christophe Leroy
>> Sent: 25 January 2021 09:15
>>=20
>> Le 24/01/2021 =C3=A0 09:22, Nicholas Piggin a =C3=A9crit=C2=A0:
>> > Support huge page vmalloc mappings. Config option HAVE_ARCH_HUGE_VMALL=
OC
>> > enables support on architectures that define HAVE_ARCH_HUGE_VMAP and
>> > supports PMD sized vmap mappings.
>> >
>> > vmalloc will attempt to allocate PMD-sized pages if allocating PMD siz=
e
>> > or larger, and fall back to small pages if that was unsuccessful.
>> >
>> > Architectures must ensure that any arch specific vmalloc allocations
>> > that require PAGE_SIZE mappings (e.g., module allocations vs strict
>> > module rwx) use the VM_NOHUGE flag to inhibit larger mappings.
>> >
>> > When hugepage vmalloc mappings are enabled in the next patch, this
>> > reduces TLB misses by nearly 30x on a `git diff` workload on a 2-node
>> > POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%.
>> >
>> > This can result in more internal fragmentation and memory overhead for=
 a
>> > given allocation, an option nohugevmalloc is added to disable at boot.
>> >
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> >   arch/Kconfig            |  10 +++
>> >   include/linux/vmalloc.h |  18 ++++
>> >   mm/page_alloc.c         |   5 +-
>> >   mm/vmalloc.c            | 192 ++++++++++++++++++++++++++++++--------=
--
>> >   4 files changed, 177 insertions(+), 48 deletions(-)
>> >
>>=20
>> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> > index 0377e1d059e5..eef61e0f5170 100644
>> > --- a/mm/vmalloc.c
>> > +++ b/mm/vmalloc.c
>>=20
>> > @@ -2691,15 +2746,18 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
>> >   #endif /* CONFIG_VMAP_PFN */
>> >
>> >   static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_m=
ask,
>> > -				 pgprot_t prot, int node)
>> > +				 pgprot_t prot, unsigned int page_shift,
>> > +				 int node)
>> >   {
>> >   	const gfp_t nested_gfp =3D (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZE=
RO;
>> > -	unsigned int nr_pages =3D get_vm_area_size(area) >> PAGE_SHIFT;
>> > -	unsigned long array_size;
>> > -	unsigned int i;
>> > +	unsigned int page_order =3D page_shift - PAGE_SHIFT;
>> > +	unsigned long addr =3D (unsigned long)area->addr;
>> > +	unsigned long size =3D get_vm_area_size(area);
>> > +	unsigned int nr_small_pages =3D size >> PAGE_SHIFT;
>> >   	struct page **pages;
>> > +	unsigned int i;
>> >
>> > -	array_size =3D (unsigned long)nr_pages * sizeof(struct page *);
>> > +	array_size =3D (unsigned long)nr_small_pages * sizeof(struct page *)=
;
>>=20
>> array_size() is a function in include/linux/overflow.h
>>=20
>> For some reason, it breaks the build with your series.
>=20
> I can't see the replacement definition for array_size.
> The old local variable is deleted.

Yeah I saw that after taking another look. Must have sent in a bad diff.=20
The v11 fixed that and a couple of other compile issues.

Thanks,
Nick
