Return-Path: <linux-arch+bounces-7165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C9D97283E
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 06:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8877E285127
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 04:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB52144D0C;
	Tue, 10 Sep 2024 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etEjPGSq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739D14EC44;
	Tue, 10 Sep 2024 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941915; cv=none; b=Hn3rwdqcF0ACNp0SNOip7Z+wEiAcEHLqfZPdRt/gTpRZ8uNZpXrjQdYcopApOyRUxo5oy/nnpCIhdayV6v/NKbuVzJH49ptBDqRRXBD/BYalZfa2G0agrG0QFHqjJ0S2sSUh4Q3VyxrE00LKLa1yD9wzbDb18N9YdYc7NmhwCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941915; c=relaxed/simple;
	bh=QO+bGIu/OvWbyERSlGE6OBNFM/K+DiqfqPPKrZdSj0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOD9bMF758IHoG9M3gyM6p35QEJoPmEWpvWU6/UAl/viFPBb0R2BVOSYdaQZSsuMgvIGhfN1s9bbk5ykc3DdmUprb1O1j58ty8KFwmFolWj4Rg1DLw/8GjQIPAMOuHLWPv4I1BIIvAxY+XM6MHRSdYI7WdrIqgbyENWmfJ2SCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etEjPGSq; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-49bd27b3507so1415859137.2;
        Mon, 09 Sep 2024 21:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725941912; x=1726546712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQjyuD/v2psDQHuHQBZqQUb8QqpveuVzmeWiCMPuERE=;
        b=etEjPGSq5eLu3hKwX59FP4Y5E4mqQqhKm9UNNC2EI2dVIfXP2YpPyAx/XIcutiCfly
         vSpBca32ygthK0zy68xyHEaxc8gKGJEEX2IaxCYFYBpCN2nAWFkH6xwPUklJ5ST8S1GL
         pt+KJyOG/IgdUcJWl9i550foFlE4YSh76YAGrzpscbBP4KpLMkQ+z6MjXiowfcRdxI9V
         Yp41m+Bz/WwQ6PelndnT458f1I2dAClIlkEg1azYhHvFiqJjnakS2iXhyaWHq9ENWrFs
         3+IMKUM43x+O1ebvZVdYMfzjvOnVWhjAV8kWmUpR8iQ9cGFq9t70FS8Ozc+hL5XY5d2i
         h1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725941912; x=1726546712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQjyuD/v2psDQHuHQBZqQUb8QqpveuVzmeWiCMPuERE=;
        b=ulIi3Sh2W1G4XOzA3aHTe053an/IPrhMaREAROKxa04Yg1VJmdLoOwRg7ymCc8Gzch
         ASnTvE3u0zxOH46Jur5oha43sxSjqswWWwsCluJURhnZCgNLwJo0Y60eh3Wt7p/QZ1tH
         pwy1s38tkzyfL3Tice88nQZRzZcoqoK8FoZ4nDwrkWMLYKlduEC5SsWROp96iC/KkSMZ
         mWHF4VZcNhtSG6RZZwa7Uv2x6Et6mzqVCYdUClJz4K3CNUnYNoZdhJq2jlPWeqyRpQHP
         uPQdJgCk9Sxofr+SoYoXnYzGajwyGvEWr2v4kFmo+DKib0u4EuuoBqv+h5HEbvwL5fXr
         9eJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN7sh1c1asc3DjYr80ocssSbRPfZfJ1v3QCfIKPUiOWT8BDTpHU2lvJgbI6YOXNvhloka5nrYX5xt+UXXY@vger.kernel.org, AJvYcCX+9nkQ1GXMWoEczQNO/zdpqaODZRI4UgIWHNVC1stADL91q5lpyDVmcO1EiW20pYGG5sLI2DhP@vger.kernel.org, AJvYcCX1WNr4n7OFCs7sooWO1HcEKm1i/NSEIavCXoRQWZx0KNbXmDczSJ2VdS2XpVs3F6U6Y2ZhByJfraJkFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+5/mJpYpUdakM11gj8HvSuOJaW/b7FCQlC92VGyW+5ZPOcD3W
	5xSPSnxwPkyhXCY+p3fgI11kq0AOuZ4iqIgI1PtzcpFy5qz2qIblOxz8phZHfHABn24nXhLgbJl
	WdRFhMULMKciESCYVga7+h+/HAaE=
X-Google-Smtp-Source: AGHT+IFOdF22/OaB7Srd0pBSxPzO/WiXbNqZLbTeGHHR2WuP+ABK/RmAKnjuSelxJjG74BtM6ty79xtvcfYDFn8oURI=
X-Received: by 2002:a05:6102:e13:b0:497:1b98:1f82 with SMTP id
 ada2fe7eead31-49c1527c59amr2135580137.6.1725941911650; Mon, 09 Sep 2024
 21:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805153639.1057-1-justinjiang@vivo.com> <20240805153639.1057-3-justinjiang@vivo.com>
 <CAGsJ_4zXtJvBdgpDs+yyEwfdJ0gy+_dgrWLF1zxMgBbaLBeiYA@mail.gmail.com>
 <400918d7-aaaf-4ccc-af8e-ab48576746d1@vivo.com> <CAGsJ_4yAeuEFbmOoAqW4FRv3x9WNtfu3TZcuXOqb7sf3Jsgd9g@mail.gmail.com>
 <1e7e24a7-e602-4654-ba3f-d3e4d1a2a65e@vivo.com>
In-Reply-To: <1e7e24a7-e602-4654-ba3f-d3e4d1a2a65e@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 10 Sep 2024 16:18:15 +1200
Message-ID: <CAGsJ_4yhSVggqh-v7AjV1v3oTpVaQkMxyY4YYT1vRd5na_tpTQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: tlb: add tlb swap entries batch async release
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-arch@vger.kernel.org, cgroups@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 2:39=E2=80=AFAM zhiguojiang <justinjiang@vivo.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/9/9 9:59, Barry Song =E5=86=99=E9=81=93:
> > On Wed, Sep 4, 2024 at 11:26=E2=80=AFPM zhiguojiang <justinjiang@vivo.c=
om> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/9/4 17:16, Barry Song =E5=86=99=E9=81=93:
> >>> On Tue, Aug 6, 2024 at 3:36=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo=
.com> wrote:
> >>>> One of the main reasons for the prolonged exit of the process with
> >>>> independent mm is the time-consuming release of its swap entries.
> >>>> The proportion of swap memory occupied by the process increases over
> >>>> time due to high memory pressure triggering to reclaim anonymous fol=
io
> >>>> into swapspace, e.g., in Android devices, we found this proportion c=
an
> >>>> reach 60% or more after a period of time. Additionally, the relative=
ly
> >>>> lengthy path for releasing swap entries further contributes to the
> >>>> longer time required to release swap entries.
> >>>>
> >>>> Testing Platform: 8GB RAM
> >>>> Testing procedure:
> >>>> After booting up, start 15 processes first, and then observe the
> >>>> physical memory size occupied by the last launched process at differ=
ent
> >>>> time points.
> >>>> Example: The process launched last: com.qiyi.video
> >>>> |  memory type  |  0min  |  1min  |   5min  |   10min  |   15min  |
> >>>> -------------------------------------------------------------------
> >>>> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
> >>>> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
> >>>> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
> >>>> |  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
> >>>> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
> >>>> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
> >>>> Note: min - minute.
> >>>>
> >>>> When there are multiple processes with independent mm and the high
> >>>> memory pressure in system, if the large memory required process is
> >>>> launched at this time, system will is likely to trigger the instanta=
neous
> >>>> killing of many processes with independent mm. Due to multiple exiti=
ng
> >>>> processes occupying multiple CPU core resources for concurrent execu=
tion,
> >>>> leading to some issues such as the current non-exiting and important
> >>>> processes lagging.
> >>>>
> >>>> To solve this problem, we have introduced the multiple exiting proce=
ss
> >>>> asynchronous swap entries release mechanism, which isolates and cach=
es
> >>>> swap entries occupied by multiple exiting processes, and hands them =
over
> >>>> to an asynchronous kworker to complete the release. This allows the
> >>>> exiting processes to complete quickly and release CPU resources. We =
have
> >>>> validated this modification on the Android products and achieved the
> >>>> expected benefits.
> >>>>
> >>>> Testing Platform: 8GB RAM
> >>>> Testing procedure:
> >>>> After restarting the machine, start 15 app processes first, and then
> >>>> start the camera app processes, we monitor the cold start and previe=
w
> >>>> time datas of the camera app processes.
> >>>>
> >>>> Test datas of camera processes cold start time (unit: millisecond):
> >>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> >>>> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
> >>>> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
> >>>>
> >>>> Test datas of camera processes preview time (unit: millisecond):
> >>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> >>>> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
> >>>> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
> >>>>
> >>>> Base on the average of the six sets of test datas above, we can see =
that
> >>>> the benefit datas of the modified patch:
> >>>> 1. The cold start time of camera app processes has reduced by about =
20%.
> >>>> 2. The preview time of camera app processes has reduced by about 42%=
.
> >>>>
> >>>> It offers several benefits:
> >>>> 1. Alleviate the high system cpu loading caused by multiple exiting
> >>>>      processes running simultaneously.
> >>>> 2. Reduce lock competition in swap entry free path by an asynchronou=
s
> >>>>      kworker instead of multiple exiting processes parallel executio=
n.
> >>>> 3. Release pte_present memory occupied by exiting processes more
> >>>>      efficiently.
> >>>>
> >>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >>>> ---
> >>>>    arch/s390/include/asm/tlb.h |   8 +
> >>>>    include/asm-generic/tlb.h   |  44 ++++++
> >>>>    include/linux/mm_types.h    |  58 +++++++
> >>>>    mm/memory.c                 |   3 +-
> >>>>    mm/mmu_gather.c             | 296 +++++++++++++++++++++++++++++++=
+++++
> >>>>    5 files changed, 408 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb=
.h
> >>>> index e95b2c8081eb..3f681f63390f
> >>>> --- a/arch/s390/include/asm/tlb.h
> >>>> +++ b/arch/s390/include/asm/tlb.h
> >>>> @@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct m=
mu_gather *tlb,
> >>>>                   struct page *page, bool delay_rmap, int page_size)=
;
> >>>>    static inline bool __tlb_remove_folio_pages(struct mmu_gather *tl=
b,
> >>>>                   struct page *page, unsigned int nr_pages, bool del=
ay_rmap);
> >>>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb=
,
> >>>> +               swp_entry_t entry, int nr);
> >>>>
> >>>>    #define tlb_flush tlb_flush
> >>>>    #define pte_free_tlb pte_free_tlb
> >>>> @@ -69,6 +71,12 @@ static inline bool __tlb_remove_folio_pages(struc=
t mmu_gather *tlb,
> >>>>           return false;
> >>>>    }
> >>>>
> >>>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb=
,
> >>>> +               swp_entry_t entry, int nr)
> >>>> +{
> >>>> +       return false;
> >>>> +}
> >>>> +
> >>>>    static inline void tlb_flush(struct mmu_gather *tlb)
> >>>>    {
> >>>>           __tlb_flush_mm_lazy(tlb->mm);
> >>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> >>>> index 709830274b75..8b4d516b35b8
> >>>> --- a/include/asm-generic/tlb.h
> >>>> +++ b/include/asm-generic/tlb.h
> >>>> @@ -294,6 +294,37 @@ extern void tlb_flush_rmaps(struct mmu_gather *=
tlb, struct vm_area_struct *vma);
> >>>>    static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct=
 vm_area_struct *vma) { }
> >>>>    #endif
> >>>>
> >>>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
> >>>> +struct mmu_swap_batch {
> >>>> +       struct mmu_swap_batch *next;
> >>>> +       unsigned int nr;
> >>>> +       unsigned int max;
> >>>> +       encoded_swpentry_t encoded_entrys[];
> >>>> +};
> >>>> +
> >>>> +#define MAX_SWAP_GATHER_BATCH  \
> >>>> +       ((PAGE_SIZE - sizeof(struct mmu_swap_batch)) / sizeof(void *=
))
> >>>> +
> >>>> +#define MAX_SWAP_GATHER_BATCH_COUNT    (10000UL / MAX_SWAP_GATHER_B=
ATCH)
> >>>> +
> >>>> +struct mmu_swap_gather {
> >>>> +       /*
> >>>> +        * the asynchronous kworker to batch
> >>>> +        * release swap entries
> >>>> +        */
> >>>> +       struct work_struct free_work;
> >>>> +
> >>>> +       /* batch cache swap entries */
> >>>> +       unsigned int batch_count;
> >>>> +       struct mmu_swap_batch *active;
> >>>> +       struct mmu_swap_batch local;
> >>>> +       encoded_swpentry_t __encoded_entrys[MMU_GATHER_BUNDLE];
> >>>> +};
> >>>> +
> >>>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
> >>>> +               swp_entry_t entry, int nr);
> >>>> +#endif
> >>>> +
> >>>>    /*
> >>>>     * struct mmu_gather is an opaque type used by the mm code for pa=
ssing around
> >>>>     * any data needed by arch specific code for tlb_remove_page.
> >>>> @@ -343,6 +374,18 @@ struct mmu_gather {
> >>>>           unsigned int            vma_exec : 1;
> >>>>           unsigned int            vma_huge : 1;
> >>>>           unsigned int            vma_pfn  : 1;
> >>>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
> >>>> +       /*
> >>>> +        * Two states of releasing swap entries
> >>>> +        * asynchronously:
> >>>> +        * swp_freeable - have opportunity to
> >>>> +        * release asynchronously future
> >>>> +        * swp_freeing - be releasing asynchronously.
> >>>> +        */
> >>>> +       unsigned int            swp_freeable : 1;
> >>>> +       unsigned int            swp_freeing : 1;
> >>>> +       unsigned int            swp_disable : 1;
> >>>> +#endif
> >>>>
> >>>>           unsigned int            batch_count;
> >>>>
> >>>> @@ -354,6 +397,7 @@ struct mmu_gather {
> >>>>    #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
> >>>>           unsigned int page_size;
> >>>>    #endif
> >>>> +       struct mmu_swap_gather *swp;
> >>>>    #endif
> >>>>    };
> >>>>
> >>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >>>> index 165c58b12ccc..2f66303f1519
> >>>> --- a/include/linux/mm_types.h
> >>>> +++ b/include/linux/mm_types.h
> >>>> @@ -283,6 +283,64 @@ typedef struct {
> >>>>           unsigned long val;
> >>>>    } swp_entry_t;
> >>>>
> >>>> +/*
> >>>> + * encoded_swpentry_t - a type marking the encoded swp_entry_t.
> >>>> + *
> >>>> + * An 'encoded_swpentry_t' represents a 'swp_enrty_t' with its the =
highest
> >>>> + * bit indicating extra context-dependent information. Only used in=
 swp_entry
> >>>> + * asynchronous release path by mmu_swap_gather.
> >>>> + */
> >>>> +typedef struct {
> >>>> +       unsigned long val;
> >>>> +} encoded_swpentry_t;
> >>>> +
> >>>> +/*
> >>>> + * The next item in an encoded_swpentry_t array is the "nr" argumen=
t, specifying the
> >>>> + * total number of consecutive swap entries associated with the sam=
e folio. If this
> >>>> + * bit is not set, "nr" is implicitly 1.
> >>>> + *
> >>>> + * Refer to include\asm\pgtable.h, swp_offset bits: 0 ~ 57, swp_typ=
e bits: 58 ~ 62.
> >>>> + * Bit63 can be used here.
> >>>> + */
> >>>> +#define ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT (1UL << (BITS_PER_LONG =
- 1))
> >>>> +
> >>>> +static __always_inline encoded_swpentry_t
> >>>> +encode_swpentry(swp_entry_t entry, unsigned long flags)
> >>>> +{
> >>>> +       encoded_swpentry_t ret;
> >>>> +
> >>>> +       VM_WARN_ON_ONCE(flags & ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT=
);
> >>>> +       ret.val =3D flags | entry.val;
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +static inline unsigned long encoded_swpentry_flags(encoded_swpentry=
_t entry)
> >>>> +{
> >>>> +       return ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
> >>>> +}
> >>>> +
> >>>> +static inline swp_entry_t encoded_swpentry_data(encoded_swpentry_t =
entry)
> >>>> +{
> >>>> +       swp_entry_t ret;
> >>>> +
> >>>> +       ret.val =3D ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val=
;
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +static __always_inline encoded_swpentry_t encode_nr_swpentrys(unsig=
ned long nr)
> >>>> +{
> >>>> +       encoded_swpentry_t ret;
> >>>> +
> >>>> +       VM_WARN_ON_ONCE(nr & ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
> >>>> +       ret.val =3D nr;
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +static __always_inline unsigned long encoded_nr_swpentrys(encoded_s=
wpentry_t entry)
> >>>> +{
> >>>> +       return ((~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT) & entry.val);
> >>>> +}
> >>>> +
> >>>>    /**
> >>>>     * struct folio - Represents a contiguous set of bytes.
> >>>>     * @flags: Identical to the page flags.
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index d6a9dcddaca4..023a8adcb67c
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>> @@ -1650,7 +1650,8 @@ static unsigned long zap_pte_range(struct mmu_=
gather *tlb,
> >>>>                           if (!should_zap_cows(details))
> >>>>                                   continue;
> >>>>                           rss[MM_SWAPENTS] -=3D nr;
> >>>> -                       free_swap_and_cache_nr(entry, nr);
> >>>> +                       if (!__tlb_remove_swap_entries(tlb, entry, n=
r))
> >>>> +                               free_swap_and_cache_nr(entry, nr);
> >>>>                   } else if (is_migration_entry(entry)) {
> >>>>                           folio =3D pfn_swap_entry_folio(entry);
> >>>>                           if (!should_zap_folio(details, folio))
> >>>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> >>>> index 99b3e9408aa0..33dc9d1faff9
> >>>> --- a/mm/mmu_gather.c
> >>>> +++ b/mm/mmu_gather.c
> >>>> @@ -9,11 +9,303 @@
> >>>>    #include <linux/smp.h>
> >>>>    #include <linux/swap.h>
> >>>>    #include <linux/rmap.h>
> >>>> +#include <linux/oom.h>
> >>>>
> >>>>    #include <asm/pgalloc.h>
> >>>>    #include <asm/tlb.h>
> >>>>
> >>>>    #ifndef CONFIG_MMU_GATHER_NO_GATHER
> >>>> +/*
> >>>> + * The swp_entry asynchronous release mechanism for multiple proces=
ses with
> >>>> + * independent mm exiting simultaneously.
> >>>> + *
> >>>> + * During the multiple exiting processes releasing their own mm sim=
ultaneously,
> >>>> + * the swap entries in the exiting processes are handled by isolati=
ng, caching
> >>>> + * and handing over to an asynchronous kworker to complete the rele=
ase.
> >>>> + *
> >>>> + * The conditions for the exiting process entering the swp_entry as=
ynchronous
> >>>> + * release path:
> >>>> + * 1. The exiting process's MM_SWAPENTS count is >=3D SWAP_CLUSTER_=
MAX, avoiding
> >>>> + *    to alloc struct mmu_swap_gather frequently.
> >>>> + * 2. The number of exiting processes is >=3D NR_MIN_EXITING_PROCES=
SES.
> >>> Hi Zhiguo,
> >>>
> >>> I'm curious about the significance of NR_MIN_EXITING_PROCESSES. It se=
ems that
> >>> batched swap entry freeing, even with one process, could be a
> >>> bottleneck for a single
> >>> process based on the data from this patch:
> >>>
> >>> mm: attempt to batch free swap entries for zap_pte_range()
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=
=3Dmm-stable&id=3Dbea67dcc5ee
> >>> "munmap bandwidth becomes 3X faster."
> >>>
> >>> So what would happen if you simply set NR_MIN_EXITING_PROCESSES to 1?
> >> Hi Barry,
> >>
> >> Thanks for your comments.
> >>
> >> The reason for NR_MIN_EXITING_PROCESSES =3D 2 is that previously we
> >> conducted the multiple android apps continuous startup performance
> >> test on the case of NR_MIN_EXITING_PROCESSES =3D 1, and the results
> >> showed that the startup time had deteriorated slightly. However,
> >> the patch's logic in this test was different from the one I submitted
> >> to the community, and it may be due to some other issues with the
> >> previous old patch.
> >>
> >> However, we have conducted relevant memory performance tests on this
> >> patches submitted to the community (NR_MIN_EXITING_PROCESSES=3D2), and
> >> the results are better than before the modification. The patches have
> >> been used on multiple projects.
> >> For example:
> >> Test the time consumption and subjective fluency experience of
> >> launching 30 android apps continuously for two rounds.
> >> Test machine: RAM 16GB
> >> |        | time(s) | Frame-droped rate(%) |
> >> | before | 230.76  |         0.54         |
> >> | after  | 225.23  |         0.74         |
> >> We can see that the patch has been optimized 5.53s for startup time an=
d
> >> 0.2% frame-droped rate and better subjective smoothness experience.
> >>
> >> Perhaps the patches submitted to the community has also improved the
> >> multiple android apps continuous startup performance in the case
> >> of NR_MIN_EXITING_PROCESSES=3D1. If necessary, I will conduct relevant
> >> tests to verify this situation in the future.
> Thanks Barry for your valuable suggestions.
> > Using a fixed value like 2 feels more like a workaround than a solid so=
lution.
> > It would be better if we could eliminate this hack.
> Ok, I will conduct more tests for tring to solve this parameter issue.
> >
> > Additionally, this type of asynchronous reclamation might struggle to s=
cale
> > effectively, particularly on NUMA systems with many CPU cores.
> >
> > Many kernel threads are per-node, like kswapd. For instance, if we have=
 100
> > threads running on 100 CPUs executing zap_pte_range(), your approach, w=
hich
> > relies on a single async thread to reclaim swap entries, might lead to
> > performance
> > regressions.
> >
> > We might need to consider a more adaptable approach that can evaluate
> > the machine's
> > topology and dynamically determine the appropriate number of async
> > threads, rather
> > than hard-coding it to just one. Otherwise, there could be ongoing
> > concerns about
> > whether this solution is truly applicable to all systems.
> Can we dynamically determine the number of asynchronous kworkers to be
> created based on the number of exiting processes at a certain moment,
> for example, every 8 exiting processes corresponds to one asynchronous
> kworker?
>
> | The number of exiting processes | The number of asynchronous kworkers |
> |          [1, 8]                 | 1                    |
> |          [9, 16]                | 2                    |
> |          ...                    | ...                   |
> |      [8*N+1, 8*(N+1)]           | N+1                   |
> N >=3D 0

I'm not entirely sure. Another potential approach could be to use a
dedicated thread
for each NUMA node, but we would need data to confirm if this is the
right solution.

> > Alternatively, we might be able to develop a method to speed up
> > batched freeing in a
> > synchronous manner after collecting the mmu_swap_batch. mmu_gather isn'=
t
> > async, but it can still speed up tlb flush, right?
> The synchronous manner may have some optimization effect, but it seems
> that the optimization effect on the CPUs load occupied by multiple
> exiting processes is not significant. In addition, David stated in the
> latest comment that swap entry seems unrelated to tlb.
> > For phones with just 8 CPU cores, I definitely like your patch.
> > However, since we're
> > aiming for something which can affect all systems, the situation might =
be more
> > complex.
> Yes, this pacth still needs further improvement to adapt to all systems.

If we want to keep things simple, another approach might be to profile the
hotspots within swap_free_nr(), identifying the most time-consuming parts,
and then optimize them based on the data we collect from your
mmu_swap_batch. Then we don't have to make things async. Have you ever
profiled the hotspots?

> >>>> + *
> >>>> + * Since the time for determining the number of exiting processes i=
s dynamic,
> >>>> + * the exiting process may start to enter the swp_entry asynchronou=
s release
> >>>> + * at the beginning or middle stage of the exiting process's swp_en=
try release
> >>>> + * path.
> >>>> + *
> >>>> + * Once an exiting process enters the swp_entry asynchronous releas=
e, all remaining
> >>>> + * swap entries in this exiting process need to be fully released b=
y asynchronous
> >>>> + * kworker theoretically.
> >>> Freeing a slot can indeed release memory from `zRAM`, potentially ret=
urning
> >>> it to the system for allocation. Your patch frees swap slots asynchro=
nously;
> >>> I assume this doesn=E2=80=99t slow down the memory freeing process fo=
r `zRAM`, or
> >>> could it even slow down the freeing of `zRAM` memory? Freeing compres=
sed
> >>> memory might not be as crucial compared to freeing uncompressed memor=
y with
> >>> present PTEs?
> >> Yes, freeing uncompressed memory with present PTEs is more important
> >> compared to freeing compressed 'zRAM' memory.
> >>
> >> I guess that the multiple exiting processes releasing swap entries
> >> simultaneously may result in the swap_info->lock competition pressure
> >> in swapcache_free_entries(), affecting the efficiency of releasing swa=
p
> >> entries. However, if the asynchronous kworker is used, this issue can
> >> be avoided, and perhaps the improvement is minor.
> >>
> >> The freeing of zRAM memory does not slow down. We have observed traces
> >> in the camera startup scene and found that the asynchronous kworker
> >> can release all swap entries before entering the camera preview.
> >> Compared to not using the asynchronous kworker, the exiting processes
> >> completed after entering the camera preview.
> >>>> + *
> >>>> + * The function of the swp_entry asynchronous release:
> >>>> + * 1. Alleviate the high system cpu load caused by multiple exiting=
 processes
> >>>> + *    running simultaneously.
> >>>> + * 2. Reduce lock competition in swap entry free path by an asynchr=
onous kworker
> >>>> + *    instead of multiple exiting processes parallel execution.
> >>>> + * 3. Release pte_present memory occupied by exiting processes more=
 efficiently.
> >>>> + */
> >>>> +
> >>>> +/*
> >>>> + * The min number of exiting processes required for swp_entry async=
hronous release
> >>>> + */
> >>>> +#define NR_MIN_EXITING_PROCESSES 2
> >>>> +
> >>>> +static atomic_t nr_exiting_processes =3D ATOMIC_INIT(0);
> >>>> +static struct kmem_cache *swap_gather_cachep;
> >>>> +static struct workqueue_struct *swapfree_wq;
> >>>> +static DEFINE_STATIC_KEY_TRUE(tlb_swap_asyncfree_disabled);
> >>>> +
> >>>> +static int __init tlb_swap_async_free_setup(void)
> >>>> +{
> >>>> +       swapfree_wq =3D alloc_workqueue("smfree_wq", WQ_UNBOUND |
> >>>> +               WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
> >>>> +       if (!swapfree_wq)
> >>>> +               goto fail;
> >>>> +
> >>>> +       swap_gather_cachep =3D kmem_cache_create("swap_gather",
> >>>> +               sizeof(struct mmu_swap_gather),
> >>>> +               0, SLAB_TYPESAFE_BY_RCU | SLAB_PANIC | SLAB_ACCOUNT,
> >>>> +               NULL);
> >>>> +       if (!swap_gather_cachep)
> >>>> +               goto kcache_fail;
> >>>> +
> >>>> +       static_branch_disable(&tlb_swap_asyncfree_disabled);
> >>>> +       return 0;
> >>>> +
> >>>> +kcache_fail:
> >>>> +       destroy_workqueue(swapfree_wq);
> >>>> +fail:
> >>>> +       return -ENOMEM;
> >>>> +}
> >>>> +postcore_initcall(tlb_swap_async_free_setup);
> >>>> +
> >>>> +static void __tlb_swap_gather_free(struct mmu_swap_gather *swap_gat=
her)
> >>>> +{
> >>>> +       struct mmu_swap_batch *swap_batch, *next;
> >>>> +
> >>>> +       for (swap_batch =3D swap_gather->local.next; swap_batch; swa=
p_batch =3D next) {
> >>>> +               next =3D swap_batch->next;
> >>>> +               free_page((unsigned long)swap_batch);
> >>>> +       }
> >>>> +       swap_gather->local.next =3D NULL;
> >>>> +       kmem_cache_free(swap_gather_cachep, swap_gather);
> >>>> +}
> >>>> +
> >>>> +static void tlb_swap_async_free_work(struct work_struct *w)
> >>>> +{
> >>>> +       int i, nr_multi, nr_free;
> >>>> +       swp_entry_t start_entry;
> >>>> +       struct mmu_swap_batch *swap_batch;
> >>>> +       struct mmu_swap_gather *swap_gather =3D container_of(w,
> >>>> +               struct mmu_swap_gather, free_work);
> >>>> +
> >>>> +       /* Release swap entries cached in mmu_swap_batch. */
> >>>> +       for (swap_batch =3D &swap_gather->local; swap_batch && swap_=
batch->nr;
> >>>> +           swap_batch =3D swap_batch->next) {
> >>>> +               nr_free =3D 0;
> >>>> +               for (i =3D 0; i < swap_batch->nr; i++) {
> >>>> +                       if (unlikely(encoded_swpentry_flags(swap_bat=
ch->encoded_entrys[i]) &
> >>>> +                           ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT)) {
> >>>> +                               start_entry =3D encoded_swpentry_dat=
a(swap_batch->encoded_entrys[i]);
> >>>> +                               nr_multi =3D encoded_nr_swpentrys(sw=
ap_batch->encoded_entrys[++i]);
> >>>> +                               free_swap_and_cache_nr(start_entry, =
nr_multi);
> >>>> +                               nr_free +=3D 2;
> >>>> +                       } else {
> >>>> +                               start_entry =3D encoded_swpentry_dat=
a(swap_batch->encoded_entrys[i]);
> >>>> +                               free_swap_and_cache_nr(start_entry, =
1);
> >>>> +                               nr_free++;
> >>>> +                       }
> >>>> +               }
> >>>> +               swap_batch->nr -=3D nr_free;
> >>>> +               VM_BUG_ON(swap_batch->nr);
> >>>> +       }
> >>>> +       __tlb_swap_gather_free(swap_gather);
> >>>> +}
> >>>> +
> >>>> +static bool __tlb_swap_gather_mmu_check(struct mmu_gather *tlb)
> >>>> +{
> >>>> +       /*
> >>>> +        * Only the exiting processes with the MM_SWAPENTS counter >=
=3D
> >>>> +        * SWAP_CLUSTER_MAX have the opportunity to release their sw=
ap
> >>>> +        * entries by asynchronous kworker.
> >>>> +        */
> >>>> +       if (!task_is_dying() ||
> >>>> +           get_mm_counter(tlb->mm, MM_SWAPENTS) < SWAP_CLUSTER_MAX)
> >>>> +               return true;
> >>>> +
> >>>> +       atomic_inc(&nr_exiting_processes);
> >>>> +       if (atomic_read(&nr_exiting_processes) < NR_MIN_EXITING_PROC=
ESSES)
> >>>> +               tlb->swp_freeable =3D 1;
> >>>> +       else
> >>>> +               tlb->swp_freeing =3D 1;
> >>>> +
> >>>> +       return false;
> >>>> +}
> >>>> +
> >>>> +/**
> >>>> + * __tlb_swap_gather_init - Initialize an mmu_swap_gather structure
> >>>> + * for swp_entry tear-down.
> >>>> + * @tlb: the mmu_swap_gather structure belongs to tlb
> >>>> + */
> >>>> +static bool __tlb_swap_gather_init(struct mmu_gather *tlb)
> >>>> +{
> >>>> +       tlb->swp =3D kmem_cache_alloc(swap_gather_cachep, GFP_ATOMIC=
 | GFP_NOWAIT);
> >>>> +       if (unlikely(!tlb->swp))
> >>>> +               return false;
> >>>> +
> >>>> +       tlb->swp->local.next  =3D NULL;
> >>>> +       tlb->swp->local.nr    =3D 0;
> >>>> +       tlb->swp->local.max   =3D ARRAY_SIZE(tlb->swp->__encoded_ent=
rys);
> >>>> +
> >>>> +       tlb->swp->active      =3D &tlb->swp->local;
> >>>> +       tlb->swp->batch_count =3D 0;
> >>>> +
> >>>> +       INIT_WORK(&tlb->swp->free_work, tlb_swap_async_free_work);
> >>>> +       return true;
> >>>> +}
> >>>> +
> >>>> +static void __tlb_swap_gather_mmu(struct mmu_gather *tlb)
> >>>> +{
> >>>> +       if (static_branch_unlikely(&tlb_swap_asyncfree_disabled))
> >>>> +               return;
> >>>> +
> >>>> +       tlb->swp =3D NULL;
> >>>> +       tlb->swp_freeable =3D 0;
> >>>> +       tlb->swp_freeing =3D 0;
> >>>> +       tlb->swp_disable =3D 0;
> >>>> +
> >>>> +       if (__tlb_swap_gather_mmu_check(tlb))
> >>>> +               return;
> >>>> +
> >>>> +       /*
> >>>> +        * If the exiting process meets the conditions of
> >>>> +        * swp_entry asynchronous release, an mmu_swap_gather
> >>>> +        * structure will be initialized.
> >>>> +        */
> >>>> +       if (tlb->swp_freeing)
> >>>> +               __tlb_swap_gather_init(tlb);
> >>>> +}
> >>>> +
> >>>> +static void __tlb_swap_gather_queuework(struct mmu_gather *tlb, boo=
l finish)
> >>>> +{
> >>>> +       queue_work(swapfree_wq, &tlb->swp->free_work);
> >>>> +       tlb->swp =3D NULL;
> >>>> +       if (!finish)
> >>>> +               __tlb_swap_gather_init(tlb);
> >>>> +}
> >>>> +
> >>>> +static bool __tlb_swap_next_batch(struct mmu_gather *tlb)
> >>>> +{
> >>>> +       struct mmu_swap_batch *swap_batch;
> >>>> +
> >>>> +       if (tlb->swp->batch_count =3D=3D MAX_SWAP_GATHER_BATCH_COUNT=
)
> >>>> +               goto free;
> >>>> +
> >>>> +       swap_batch =3D (void *)__get_free_page(GFP_ATOMIC | GFP_NOWA=
IT);
> >>>> +       if (unlikely(!swap_batch))
> >>>> +               goto free;
> >>>> +
> >>>> +       swap_batch->next =3D NULL;
> >>>> +       swap_batch->nr   =3D 0;
> >>>> +       swap_batch->max  =3D MAX_SWAP_GATHER_BATCH;
> >>>> +
> >>>> +       tlb->swp->active->next =3D swap_batch;
> >>>> +       tlb->swp->active =3D swap_batch;
> >>>> +       tlb->swp->batch_count++;
> >>>> +       return true;
> >>>> +free:
> >>>> +       /* batch move to wq */
> >>>> +       __tlb_swap_gather_queuework(tlb, false);
> >>>> +       return false;
> >>>> +}
> >>>> +
> >>>> +/**
> >>>> + * __tlb_remove_swap_entries - the swap entries in exiting process =
are
> >>>> + * isolated, batch cached in struct mmu_swap_batch.
> >>>> + * @tlb: the current mmu_gather
> >>>> + * @entry: swp_entry to be isolated and cached
> >>>> + * @nr: the number of consecutive entries starting from entry param=
eter.
> >>>> + */
> >>>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
> >>>> +                            swp_entry_t entry, int nr)
> >>>> +{
> >>>> +       struct mmu_swap_batch *swap_batch;
> >>>> +       unsigned long flags =3D 0;
> >>>> +       bool ret =3D false;
> >>>> +
> >>>> +       if (tlb->swp_disable)
> >>>> +               return ret;
> >>>> +
> >>>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
> >>>> +               return ret;
> >>>> +
> >>>> +       if (tlb->swp_freeable) {
> >>>> +               if (atomic_read(&nr_exiting_processes) <
> >>>> +                   NR_MIN_EXITING_PROCESSES)
> >>>> +                       return ret;
> >>>> +               /*
> >>>> +                * If the current number of exiting processes
> >>>> +                * is >=3D NR_MIN_EXITING_PROCESSES, the exiting
> >>>> +                * process with swp_freeable state will enter
> >>>> +                * swp_freeing state to start releasing its
> >>>> +                * remaining swap entries by the asynchronous
> >>>> +                * kworker.
> >>>> +                */
> >>>> +               tlb->swp_freeable =3D 0;
> >>>> +               tlb->swp_freeing =3D 1;
> >>>> +       }
> >>>> +
> >>>> +       VM_BUG_ON(tlb->swp_freeable || !tlb->swp_freeing);
> >>>> +       if (!tlb->swp && !__tlb_swap_gather_init(tlb))
> >>>> +               return ret;
> >>>> +
> >>>> +       swap_batch =3D tlb->swp->active;
> >>>> +       if (unlikely(swap_batch->nr >=3D swap_batch->max - 1)) {
> >>>> +               __tlb_swap_gather_queuework(tlb, false);
> >>>> +               return ret;
> >>>> +       }
> >>>> +
> >>>> +       if (likely(nr =3D=3D 1)) {
> >>>> +               swap_batch->encoded_entrys[swap_batch->nr++] =3D enc=
ode_swpentry(entry, flags);
> >>>> +       } else {
> >>>> +               flags |=3D ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT;
> >>>> +               swap_batch->encoded_entrys[swap_batch->nr++] =3D enc=
ode_swpentry(entry, flags);
> >>>> +               swap_batch->encoded_entrys[swap_batch->nr++] =3D enc=
ode_nr_swpentrys(nr);
> >>>> +       }
> >>>> +       ret =3D true;
> >>>> +
> >>>> +       if (swap_batch->nr >=3D swap_batch->max - 1) {
> >>>> +               if (!__tlb_swap_next_batch(tlb))
> >>>> +                       goto exit;
> >>>> +               swap_batch =3D tlb->swp->active;
> >>>> +       }
> >>>> +       VM_BUG_ON(swap_batch->nr > swap_batch->max - 1);
> >>>> +exit:
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +static void __tlb_batch_swap_finish(struct mmu_gather *tlb)
> >>>> +{
> >>>> +       if (tlb->swp_disable)
> >>>> +               return;
> >>>> +
> >>>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
> >>>> +               return;
> >>>> +
> >>>> +       if (tlb->swp_freeable) {
> >>>> +               tlb->swp_freeable =3D 0;
> >>>> +               VM_BUG_ON(tlb->swp_freeing);
> >>>> +               goto exit;
> >>>> +       }
> >>>> +       tlb->swp_freeing =3D 0;
> >>>> +       if (unlikely(!tlb->swp))
> >>>> +               goto exit;
> >>>> +
> >>>> +       __tlb_swap_gather_queuework(tlb, true);
> >>>> +exit:
> >>>> +       atomic_dec(&nr_exiting_processes);
> >>>> +}
> >>>>
> >>>>    static bool tlb_next_batch(struct mmu_gather *tlb)
> >>>>    {
> >>>> @@ -386,6 +678,9 @@ static void __tlb_gather_mmu(struct mmu_gather *=
tlb, struct mm_struct *mm,
> >>>>           tlb->local.max  =3D ARRAY_SIZE(tlb->__pages);
> >>>>           tlb->active     =3D &tlb->local;
> >>>>           tlb->batch_count =3D 0;
> >>>> +
> >>>> +       tlb->swp_disable =3D 1;
> >>>> +       __tlb_swap_gather_mmu(tlb);
> >>>>    #endif
> >>>>           tlb->delayed_rmap =3D 0;
> >>>>
> >>>> @@ -466,6 +761,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
> >>>>
> >>>>    #ifndef CONFIG_MMU_GATHER_NO_GATHER
> >>>>           tlb_batch_list_free(tlb);
> >>>> +       __tlb_batch_swap_finish(tlb);
> >>>>    #endif
> >>>>           dec_tlb_flush_pending(tlb->mm);
> >>>>    }
> >>>> --
> >>>> 2.39.0
> >>>>
> > Thanks
> > Barry
> Thanks
> Zhiguo
>

Thanks
Barry

