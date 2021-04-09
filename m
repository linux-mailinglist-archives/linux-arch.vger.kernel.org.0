Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6039035A0B7
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhDIOKg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 10:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhDIOKe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 10:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617977421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWNREvrOtHiS/gdxlthAoSyaX95CLmAUl3lJOVpNYCw=;
        b=HVG2h4NPktIH9peZbk0OxVKW4B8fztS6t8AegK6uBr6anSAW9ntMGf0rhViMoo/LGTydOe
        ZNtvjfdyvRg3ZwUCUo/8x/XCQAKaXxwE67CXokR2J4cd2LJVzk4DcJ19XhI55AUcxtiGmc
        AhezPw0ULUL17hKdmQtarbUOGc93JJA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-At573QT1MFS_0dhve0Go0A-1; Fri, 09 Apr 2021 10:10:19 -0400
X-MC-Unique: At573QT1MFS_0dhve0Go0A-1
Received: by mail-wm1-f71.google.com with SMTP id n67-20020a1c59460000b0290114d1a03f5bso851055wmb.6
        for <linux-arch@vger.kernel.org>; Fri, 09 Apr 2021 07:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=EWNREvrOtHiS/gdxlthAoSyaX95CLmAUl3lJOVpNYCw=;
        b=f6fjsiiitOsqpe0g/h/1k59gTONuBBEv/sRKVqf/mUPxwI+NRHnasYdZCz3OyV6/Yx
         6NBy8a2uu/iXsfaODi7As162PUbQ5o7l2UkjbJct7Y/52EXPj1thzLtvcxv1DxLzClA0
         FR4bDSC105V1P45GzGKHxOBd3l2saL8D+oPgXZBKfPdWUNuuXbR+bWiY8MxTardy8jB3
         AcSDeFFsMK/7ffLpGbKD7OuNUoObhIWT2CMKPYUluFfKsrxAy3cxf6pr2Av7JHhs0kYC
         eN0R+hFIMJhEuTS+OWK39aKkrmWIIe8/UD6UaqWRrk05ntntgZ2tsuF+2lsOPaPKMITF
         aGKg==
X-Gm-Message-State: AOAM533/O0oYD2ZSbhI/uEVMd3FZU5bFun1sTsE6EitbIKb++8AXzvhG
        XPEjrlWQ6VkDrcEYvfDRt2MyRbu3iT5l135XeiLvSmWRnycpaSym8ak5QIbvQGJFprkj/SgG/1Z
        JFHA+hQf0mPyBEaFRJx7E9Q==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr14121452wma.51.1617977417419;
        Fri, 09 Apr 2021 07:10:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK2eQJebQQhfMGzxEK9Jzyvz7ElE085TfiU8H50Wp6kUuTBF1Ga0ilIdJhVRoRW8OfQyc2eA==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr14121423wma.51.1617977417130;
        Fri, 09 Apr 2021 07:10:17 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6302.dip0.t-ipconnect.de. [91.12.99.2])
        by smtp.gmail.com with ESMTPSA id u8sm4960453wrr.42.2021.04.09.07.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 07:10:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7] RISC-V: enable XIP
Date:   Fri, 9 Apr 2021 16:10:15 +0200
Message-Id: <F096121C-8F7A-4E9A-B319-2C5F656610EA@redhat.com>
References: <YHBdzPsHantT9r8t@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
In-Reply-To: <YHBdzPsHantT9r8t@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Am 09.04.2021 um 15:59 schrieb Mike Rapoport <rppt@linux.ibm.com>:
>=20
> =EF=BB=BFOn Fri, Apr 09, 2021 at 02:46:17PM +0200, David Hildenbrand wrote=
:
>>>>> Also, will that memory properly be exposed in the resource tree as
>>>>> System RAM (e.g., /proc/iomem) ? Otherwise some things (/proc/kcore)
>>>>> won't work as expected - the kernel won't be included in a dump.
>>> Do we really need a XIP kernel to included in kdump?
>>> And does not it sound weird to expose flash as System RAM in /proc/iomem=
? ;-)
>>=20
>> See my other mail, maybe we actually want something different.
>>=20
>>>=20
>>>> I have just checked and it does not appear in /proc/iomem.
>>>>=20
>>>> Ok your conclusion would be to have struct page, I'm going to implement=
 this
>>>> version then using memblock as you described.
>>>=20
>>> I'm not sure this is required. With XIP kernel text never gets into RAM,=
 so
>>> it does not seem to require struct page.
>>>=20
>>> XIP by definition has some limitations relatively to "normal" operation,=

>>> so lack of kdump could be one of them.
>>=20
>> I agree.
>>=20
>>>=20
>>> I might be wrong, but IMHO, artificially creating a memory map for part o=
f
>>> flash would cause more problems in the long run.
>>=20
>> Can you elaborate?
>=20
> Nothing particular, just a gut feeling. Usually, when you force something
> it comes out the wrong way later.
>=20
>>>=20
>>> BTW, how does XIP account the kernel text on other architectures that
>>> implement it?
>>=20
>> Interesting point, I thought XIP would be something new on RISC-V (well, a=
t
>> least to me :) ). If that concept exists already, we better mimic what
>> existing implementations do.
>=20
> I had quick glance at ARM, it seems that kernel text does not have memory
> map and does not show up in System RAM.
>=20

Does it show up in a different way or not at all?

> --=20
> Sincerely yours,
> Mike.
>=20

