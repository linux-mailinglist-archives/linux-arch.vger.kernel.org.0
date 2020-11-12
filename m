Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AAD2B0EE5
	for <lists+linux-arch@lfdr.de>; Thu, 12 Nov 2020 21:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKLUP0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Nov 2020 15:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbgKLUPZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Nov 2020 15:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605212123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHPfrB8xVjlPFSCqejvi+QTUrEERRY3Dc+wUeNVcoBQ=;
        b=L+l8d/CHHyMnmK9PK8luogmH5f6KHcfXeBffVE7TzuOlEu2j3UI3j97K/sFR8HQddRGW01
        ZxqtNdAORQauJnz70m/0lkm5NDTASABGg40z01W7R2D1icqezbLKIUWvcZoVOdkRE0CMeF
        8Py45g2tnbbNJm9CEty/P8ecrR571+Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-5qkq1JPnOEW3D2vWx7L7SQ-1; Thu, 12 Nov 2020 15:15:22 -0500
X-MC-Unique: 5qkq1JPnOEW3D2vWx7L7SQ-1
Received: by mail-wr1-f69.google.com with SMTP id e18so2457066wrs.23
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2020 12:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vHPfrB8xVjlPFSCqejvi+QTUrEERRY3Dc+wUeNVcoBQ=;
        b=qwZFEJq95U6pqzD4ojYjCuB4BLBVIYNvHGr/698xGJYBFmnaqj8f/M55ltd3DwfDq4
         2OdXxslRvygBtgXchYOY14QKJBBmj5JRGtMBiOenLJtFT3hoiYCjh2b4NvMFl6YOKGLR
         Ew1IYFueCCPEgLl1X6RaAOUqXCeKhLHGvT4FOwPet8iQ+lxAXtcrHc3aKtStLJ2R037G
         /CR5dr/JDwwI3BUQCxrnUv7nxLZvdwSXiuLMeGL6Ke7EjjIpMsn3IJu3ITQrIQbIt6rG
         sxYViojeBW1GMGyfVNY26evyTG8gtBOLyeP2LeVs0K1mh4iG3fymQLgebu+r96ZLL3Nw
         zTug==
X-Gm-Message-State: AOAM531n1lVq4vSUtIvtD8uOHvtmV4KayoIU9ZJDrLBf87gx0RwLwm74
        F6joM0zOAl/6PIy0CPh49s7d5HYQnmlGO/W6DyrYU4KfPOmeCl95E6Vi02qvgHEgbEveS8gy08n
        91JZblCHMOVF/kkG7S/oaFg==
X-Received: by 2002:adf:e350:: with SMTP id n16mr1455245wrj.419.1605212120779;
        Thu, 12 Nov 2020 12:15:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxji2+rXiblNfD29iXHuiDwrhuPVpa0KNLoEK9tHEW4ondrhf0pVB9gNYs6gWjo3tNv0xhLcA==
X-Received: by 2002:adf:e350:: with SMTP id n16mr1455211wrj.419.1605212120462;
        Thu, 12 Nov 2020 12:15:20 -0800 (PST)
Received: from [192.168.3.114] (p5b0c631d.dip0.t-ipconnect.de. [91.12.99.29])
        by smtp.gmail.com with ESMTPSA id 35sm8578483wro.71.2020.11.12.12.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 12:15:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8 2/9] mmap: make mlock_future_check() global
Date:   Thu, 12 Nov 2020 21:15:18 +0100
Message-Id: <7A16CA44-782D-4ABA-8D93-76BDD0A90F94@redhat.com>
References: <20201112190827.GP4758@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
In-Reply-To: <20201112190827.GP4758@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Am 12.11.2020 um 20:08 schrieb Mike Rapoport <rppt@kernel.org>:
>=20
> =EF=BB=BFOn Thu, Nov 12, 2020 at 05:22:00PM +0100, David Hildenbrand wrote=
:
>>> On 10.11.20 19:06, Mike Rapoport wrote:
>>> On Tue, Nov 10, 2020 at 06:17:26PM +0100, David Hildenbrand wrote:
>>>> On 10.11.20 16:14, Mike Rapoport wrote:
>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>>=20
>>>>> It will be used by the upcoming secret memory implementation.
>>>>>=20
>>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>>> ---
>>>>>   mm/internal.h | 3 +++
>>>>>   mm/mmap.c     | 5 ++---
>>>>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>> index c43ccdddb0f6..ae146a260b14 100644
>>>>> --- a/mm/internal.h
>>>>> +++ b/mm/internal.h
>>>>> @@ -348,6 +348,9 @@ static inline void munlock_vma_pages_all(struct vm=
_area_struct *vma)
>>>>>   extern void mlock_vma_page(struct page *page);
>>>>>   extern unsigned int munlock_vma_page(struct page *page);
>>>>> +extern int mlock_future_check(struct mm_struct *mm, unsigned long fla=
gs,
>>>>> +                  unsigned long len);
>>>>> +
>>>>>   /*
>>>>>    * Clear the page's PageMlocked().  This can be useful in a situatio=
n where
>>>>>    * we want to unconditionally remove a page from the pagecache -- e.=
g.,
>>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>>> index 61f72b09d990..c481f088bd50 100644
>>>>> --- a/mm/mmap.c
>>>>> +++ b/mm/mmap.c
>>>>> @@ -1348,9 +1348,8 @@ static inline unsigned long round_hint_to_min(un=
signed long hint)
>>>>>       return hint;
>>>>>   }
>>>>> -static inline int mlock_future_check(struct mm_struct *mm,
>>>>> -                     unsigned long flags,
>>>>> -                     unsigned long len)
>>>>> +int mlock_future_check(struct mm_struct *mm, unsigned long flags,
>>>>> +               unsigned long len)
>>>>>   {
>>>>>       unsigned long locked, lock_limit;
>>>>>=20
>>>>=20
>>>> So, an interesting question is if you actually want to charge secretmem=

>>>> pages against mlock now, or if you want a dedicated secretmem cgroup
>>>> controller instead?
>>>=20
>>> Well, with the current implementation there are three limits an
>>> administrator can use to control secretmem limits: mlock, memcg and
>>> kernel parameter.
>>>=20
>>> The kernel parameter puts a global upper limit for secretmem usage,
>>> memcg accounts all secretmem allocations, including the unused memory in=

>>> large pages caching and mlock allows per task limit for secretmem
>>> mappings, well, like mlock does.
>>>=20
>>> I didn't consider a dedicated cgroup, as it seems we already have enough=

>>> existing knobs and a new one would be unnecessary.
>>=20
>> To me it feels like the mlock() limit is a wrong fit for secretmem. But
>> maybe there are other cases of using the mlock() limit without actually
>> doing mlock() that I am not aware of (most probably :) )?
>=20
> Secretmem does not explicitly calls to mlock() but it does what mlock()
> does and a bit more. Citing mlock(2):
>=20
>  mlock(),  mlock2(),  and  mlockall()  lock  part  or all of the calling
>  process's virtual address space into RAM, preventing that  memory  from
>  being paged to the swap area.
>=20
> So, based on that secretmem pages are not swappable, I think that
> RLIMIT_MEMLOCK is appropriate here.
>=20

The page explicitly lists mlock() system calls. E.g., we also don=E2=80=98t a=
ccount for gigantic pages - which might be allocated from CMA and are not sw=
appable.



>> I mean, my concern is not earth shattering, this can be reworked later. A=
s I
>> said, it just feels wrong.
>>=20
>> --=20
>> Thanks,
>>=20
>> David / dhildenb
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.
>=20

