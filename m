Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8131A79C5
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439463AbgDNLlh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439459AbgDNLlg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 07:41:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D3C061A0C;
        Tue, 14 Apr 2020 04:41:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t4so4540275plq.12;
        Tue, 14 Apr 2020 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=8Esq4uJjc7hCqZPSyfuH3UXfV8N/MZeW3NHhinZ8EQA=;
        b=ocqZqq6sP10NyE5Oqrsyu24BO4bUv9d+CybYLvjUEA0qRTbQq8IAo2pJTWQfIqu4RO
         sPTYsA+WN55nEjfpiAKwJ3efgvE0y02zIRGr4QJLeGvUEOTkWEwmF8lPwgWo+rxrPEs5
         VDTf42M1YbD+ARAsRZhdeD47bvnZpwfdPk63IxzHlEP4FOS+xZOTFLokGOmvq6qCsYSC
         9tfWtMbUwXgESksl6KkJnUtYDYhwxUwpcnrbpFt8xAH3B/hJvFo4WpPegEXCjs4dhUzZ
         W26SU5gqovyT9qgqJ6qWu6cT8BV0oBUpmf+pSVOyif6EAbW821Qd95yr49cfUdak8sxQ
         mhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=8Esq4uJjc7hCqZPSyfuH3UXfV8N/MZeW3NHhinZ8EQA=;
        b=WGFvk2eopzzhnzAKMqczAIyD6wLlBVfs7PY3INiZdxfU4MPoGd4n3TTWjqarVcnweU
         C5Yt9OmQcvvdATPOIYsmM1eOXWh0r4RUve1Me1zIlD6+oqn2mXTKOVexUMrQ1Ov+/o0X
         ynOXyCsBNxbUJlVv0/wwC/ZkXbv4XCxbcLcSRlPLyTi6IEgqAjHU7pp70Qm47VbQa8ws
         Jf3MRlCZfJv0WkX8lIv3Wu3p5whHDO113j81OCw19rXVwykUvjsP5Uc/P1H7L3FI/5BQ
         MUYifou97+SfNF2BarIGH0Re0WqMR+xW+pdPB0CanvoGes7kyAcQxhxrkQnC/O1YhLYa
         EaMw==
X-Gm-Message-State: AGi0PuYM1E+KZqhuTkSMqNpb470s3CdfuWvXcLewXGUJuc9u8cjggT1f
        v1t7DbgwdN962Kd9Oo4Vx+k=
X-Google-Smtp-Source: APiQypLIBjtk6RQd/AotCq9xnqN6ML09PMuOg/nS9Dm4xLrHmr38av9P0xvvmudk1+K5veWBSwJi4w==
X-Received: by 2002:a17:90a:2281:: with SMTP id s1mr27766299pjc.68.1586864495571;
        Tue, 14 Apr 2020 04:41:35 -0700 (PDT)
Received: from localhost ([203.18.28.220])
        by smtp.gmail.com with ESMTPSA id 132sm11155833pfc.183.2020.04.14.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 04:41:35 -0700 (PDT)
Date:   Tue, 14 Apr 2020 21:39:53 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <20200413134106.GN21484@bombadil.infradead.org>
In-Reply-To: <20200413134106.GN21484@bombadil.infradead.org>
MIME-Version: 1.0
Message-Id: <1586863931.xb4yeowkao.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Matthew Wilcox's message of April 13, 2020 11:41 pm:
> On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
>> +static int vmap_pages_range_noflush(unsigned long start, unsigned long =
end,
>> +				    pgprot_t prot, struct page **pages,
>> +				    unsigned int page_shift)
>> +{
>> +	if (page_shift =3D=3D PAGE_SIZE) {
>=20
> ... I think you meant 'page_shift =3D=3D PAGE_SHIFT'

Thanks, good catch. I obviously didn't test the fallback path (the
other path works for small pages, it just goes one at a time).

> Overall I like this series, although it's a bit biased towards CPUs
> which have page sizes which match PMD/PUD sizes.  It doesn't offer the
> possibility of using 64kB page sizes on ARM, for example.

No, it's just an incremental step on existing huge vmap stuff in
tree, so such a thing would be out of scope.

> But it's a
> step in the right direction.
>=20

I don't know about moving kernel maps away from a generic Linux page
table format. I quite like moving to it and making it as generic as
possible.

On the other hand, I also would like to make some arch-specific
allowances for certain special cases that may not fit within the
standard page table format, but it might be a much more specific and
limited interface than the general vmalloc stuff.

Thanks,
Nick
