Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE8C2CF956
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 05:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLEEtt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 23:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgLEEts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 23:49:48 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F941C0613D1;
        Fri,  4 Dec 2020 20:49:08 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id l23so4375091pjg.1;
        Fri, 04 Dec 2020 20:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Nb9T4leS4Okb7bkKk074tEGv/Gy3QayUZQ2lyWI+CyQ=;
        b=gsJHXW8CYsLyLTGSztE7txvh3vIMuAuI05hKOHlhR0HFrQBO6CTfJYEIeyx8ndojh1
         0FV2zvl0jvqa9Mnjdo8U9Tn4iteqER/YF57+OwBL3Oao94w7Fsy5uq1mr4qK3Di89Qm3
         zrgeYMS+VqwCFbZrM4vin8093CMu9ZrdafYMjQS75LMmG1L4BmOowHHo/TZeuFDDwfYX
         Td27wU3NTZ8hTWseuXT6puZdomZRynpZbhCGO2yimfIVAk5gaL6Gjrax2Ic6A0rjXeXb
         Rp4LeNAyAgUZO2fmQFhnksDdyz0pfUZA5AroTTuKFIjh0Ml/LbzvjNafCw0TvDfT8pkn
         OV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Nb9T4leS4Okb7bkKk074tEGv/Gy3QayUZQ2lyWI+CyQ=;
        b=UEyfMDNtKGt/4ei/tE0J1P+XzWayJTucG9tycqzyNh/kIuGK8Wv3pJ9maUclr684av
         1xSGMXKq4OdlQ9+NKImrBr5Bg7wBFG2ozOh5AyeDginCl/1q5t3u3Epjdw5xDcFIDnoo
         dUaG4sN4uVClSvt15biv4/o3wEGsfWqj1ipa86eiFCQqhOfwH6qQGlHalVcGMvpSsj0i
         0cnn5eyyiq+FBFSQeMEZqBe8rj0BchjSyu1KM2YL+XzsxvDPmODnYrnGZRpJPmrp96P0
         ehVkdpE3RFKgRRggX3gXZpE2jEUHK7Mv222a/xNHntIYvndpsF8ZN1Aet5J9xiuzmt3q
         3vqg==
X-Gm-Message-State: AOAM5310OYAEDq9nAIX71K1QcF6FeN5/c5B89i7Ju1zrYAPRDghZJJ3Q
        OF0sSM1mBK8xyKYAbbdeAJI=
X-Google-Smtp-Source: ABdhPJyib/qkhvo5CnfZZZ++38N/B+omKeTLXjREaNcrLJrVPtGwsFQpMnAhzrFUjxmdaRS0GTqXjA==
X-Received: by 2002:a17:902:8309:b029:da:1140:df85 with SMTP id bd9-20020a1709028309b02900da1140df85mr6851672plb.46.1607143748095;
        Fri, 04 Dec 2020 20:49:08 -0800 (PST)
Received: from localhost ([1.129.238.242])
        by smtp.gmail.com with ESMTPSA id q23sm6620406pfg.18.2020.12.04.20.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 20:49:07 -0800 (PST)
Date:   Sat, 05 Dec 2020 14:49:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v8 11/12] mm/vmalloc: Hugepage vmalloc mappings
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "hch@infradead.org" <hch@infradead.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>
References: <20201128152559.999540-1-npiggin@gmail.com>
        <20201128152559.999540-12-npiggin@gmail.com>
        <e9d3a50e1b18f9ea1cdfdc221bef75db19273417.camel@intel.com>
        <1607068679.lfd133za4h.astroid@bobo.none>
        <2e8e1f3e47736e8f5e749cee85b7036cbf9cb1b5.camel@intel.com>
In-Reply-To: <2e8e1f3e47736e8f5e749cee85b7036cbf9cb1b5.camel@intel.com>
MIME-Version: 1.0
Message-Id: <1607142139.ple4gyiix8.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Edgecombe, Rick P's message of December 5, 2020 4:33 am:
> On Fri, 2020-12-04 at 18:12 +1000, Nicholas Piggin wrote:
>> Excerpts from Edgecombe, Rick P's message of December 1, 2020 6:21
>> am:
>> > On Sun, 2020-11-29 at 01:25 +1000, Nicholas Piggin wrote:
>> > > Support huge page vmalloc mappings. Config option
>> > > HAVE_ARCH_HUGE_VMALLOC
>> > > enables support on architectures that define HAVE_ARCH_HUGE_VMAP
>> > > and
>> > > supports PMD sized vmap mappings.
>> > >=20
>> > > vmalloc will attempt to allocate PMD-sized pages if allocating
>> > > PMD
>> > > size
>> > > or larger, and fall back to small pages if that was unsuccessful.
>> > >=20
>> > > Allocations that do not use PAGE_KERNEL prot are not permitted to
>> > > use
>> > > huge pages, because not all callers expect this (e.g., module
>> > > allocations vs strict module rwx).
>> >=20
>> > Several architectures (x86, arm64, others?) allocate modules
>> > initially
>> > with PAGE_KERNEL and so I think this test will not exclude module
>> > allocations in those cases.
>>=20
>> Ah, thanks. I guess archs must additionally ensure that their
>> PAGE_KERNEL allocations are suitable for huge page mappings before
>> enabling the option.
>>=20
>> If there is interest from those archs to support this, I have an
>> early (un-posted) patch that adds an explicit VM_HUGE flag that could
>> override the pessemistic arch default. It's not much trouble to add
>> this=20
>> to the large system hash allocations. It's very out of date now but
>> I=20
>> can at least give what I have to anyone doing an arch support that
>> wants it.
>=20
> Ahh, sorry, I totally missed that this was only enabled for powerpc.
>=20
> That patch might be useful for me actually. Or maybe a VM_NOHUGE, since
> there are only a few places where executable vmallocs are created? I'm
> not sure what the other issues are.

Yeah good question, VM_HUGE might be safer but maybe it would be=20
possible there's only a few problems that have to be annotated with
VM_NOHUGE, good point. I'll dig it out and see.

> I am endeavoring to have small module allocations share large pages, so
> this infrastructure is a big help already.
> https://lore.kernel.org/lkml/20201120202426.18009-1-rick.p.edgecombe@inte=
l.com/

Oh nice that's what I wanted to do next! We should try get this work
for x86 as well then.

Thanks,
Nick
