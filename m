Return-Path: <linux-arch+bounces-7176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070379731E2
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 12:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB521C256A5
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FFE190052;
	Tue, 10 Sep 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6DdW6h0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE718C036;
	Tue, 10 Sep 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963100; cv=none; b=qsEirgQG+FppePz1nGKbscO2VvxZK/373KnelkIj6CZRUVYASbflkgjuLV1himjHe15OJKpTPinRWFvSiQASAb3y7v40Lb+rY1a4/j7gzZH9SZjISrJ85elB91BtkkFPZhd6XzYf8iD37PsjzvpDwOD4+Wli1fBmhMc+ysZlckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963100; c=relaxed/simple;
	bh=uJ6Haww29Y/Ox3i5fyLkpcLuLl/ubvsgbGXbdf8ov4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+q+FH+yS2GZplxxY4G7ijz0KPzJbzNcZtq4jQcr9UPp87bvWuqW0qgfc6MoZNhl6laPXc//HNBBX9QGsJZ6mycp71/NlCZZMu3zC1FeaTMLcUfkMORvKIw7/kkRohVifPoge9WKBPMkyKtsTmNfReW796SaWFcsMyich0mebOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6DdW6h0; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-49bc672bb46so1697717137.2;
        Tue, 10 Sep 2024 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725963096; x=1726567896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQmJ8OiDL4jfL7sYbo0B2mlXfFD8ef2+8NRrKxSfTGw=;
        b=U6DdW6h01pvlXHt7crHxlPdGYfKFqjENsvpkyULFOBWoMuICuDlEeIucHh7kfiU4Yo
         eEBLMmBOv3rM5dVc3gUSNi13szl13xN2RS0/dYjhI776JngNliGgdFcT9R5rcopCu/Fg
         6jHutdG2JMpoiWDN2Gw9OQE9aHKmkmG0OWrjDSrl7v7cyiyeDtfUrDBCIFCRIc2Sngqp
         Mss0Mn0ozNbkacc6QIUpy1w2LjDDuVDyqRPV2Rx47cdztRq5ZgiDayiYZrNryGr3alnR
         j7l0yE/kGBgzHzLw9Ut490NdKRlx2chmvuvURFoXSwVVRa9tFg9h+M+1G2NON3t1hK1v
         wg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725963096; x=1726567896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQmJ8OiDL4jfL7sYbo0B2mlXfFD8ef2+8NRrKxSfTGw=;
        b=oyJICOoneAyB7I2XgYAAhmmOj1iYMPaxGx8+PxGAq6bfkoy9V6WY0/waObQYhov0UN
         pWsI/i26tMBsCjJPa//WbvhG/rQ1IAy57OLAC3n2ALjB/k7Jrhme9iC6hIpw6pOorcRF
         alKHiUFIfcF4RSxS54FTgtkTKW6fwhb/mnytt9rfeoC6tFIsdlUDbibbeAo3SfIX7nFs
         mzNDXpUR6detGhBB/PRJlCcl6DFnZLx4y0w8VEZUNGNRbBYaDP0ceM24e4/38gkR4y91
         883UkIxg1z3WoqG5Qw8urcDe5/TjQF7GM+fNeIs3416Rcm3nc4K9HLKKkRNvdd5ekja0
         58UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhpzTYMwFldQJmiXojwvDLClmwmD/xdgllUkKlxApyijGP7nibFDny8nFoBnmjH7PBp9XNa1EmbQ4bHA==@vger.kernel.org, AJvYcCWE2buo9Ig32Xo3Xb9k/wGrhZkSyjBMO/BQbu7ZiiMqsYNIxsaLewjZOToq29OtwOEwgiYKlK47@vger.kernel.org, AJvYcCX6q0UFCm967YUEi9hUBvQVNHFSt1+Lsjz3JHTAXIPhEyOTmQ2yqyYFm2lwu7dObsxsxph+9Iyt/P+h8l4V@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hmIU/TzmwNs/2c7tD3bPGEMNnWhr6GCdbyaryr3Nt14tM2c/
	YeGGKIndTJdwHL7gc0Vh8T8aBDqSnSAZjIkThajEfH31GmSO0GM9v/0aW1U0GjPAxfohhc2Zhlv
	w0Phk64R/DXZ8/gesZq6rAtJOut6GqV7G32M=
X-Google-Smtp-Source: AGHT+IEmpZVEwqZ+bhiOnzlaJwcH5S6rfnFDFZ17PVc0DDTsUpXEdy87IqJlVCZF44wEx7so4hQznj34+tyE3FZMtuE=
X-Received: by 2002:a05:6102:292a:b0:498:cdb0:1d03 with SMTP id
 ada2fe7eead31-49bde263682mr15677331137.23.1725963095757; Tue, 10 Sep 2024
 03:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805153639.1057-1-justinjiang@vivo.com> <20240805153639.1057-3-justinjiang@vivo.com>
 <CAGsJ_4zXtJvBdgpDs+yyEwfdJ0gy+_dgrWLF1zxMgBbaLBeiYA@mail.gmail.com>
 <400918d7-aaaf-4ccc-af8e-ab48576746d1@vivo.com> <CAGsJ_4yAeuEFbmOoAqW4FRv3x9WNtfu3TZcuXOqb7sf3Jsgd9g@mail.gmail.com>
 <1e7e24a7-e602-4654-ba3f-d3e4d1a2a65e@vivo.com> <CAGsJ_4yhSVggqh-v7AjV1v3oTpVaQkMxyY4YYT1vRd5na_tpTQ@mail.gmail.com>
 <90e13734-526f-44fb-8a5c-8e8199a5aef3@vivo.com>
In-Reply-To: <90e13734-526f-44fb-8a5c-8e8199a5aef3@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 10 Sep 2024 22:11:24 +1200
Message-ID: <CAGsJ_4wPzSJhr_gT3oeSbbRBhqORLr17S9U30zX9x1=vDC2g6g@mail.gmail.com>
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

On Tue, Sep 10, 2024 at 9:22=E2=80=AFPM zhiguojiang <justinjiang@vivo.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/9/10 12:18, Barry Song =E5=86=99=E9=81=93:
> > On Tue, Sep 10, 2024 at 2:39=E2=80=AFAM zhiguojiang <justinjiang@vivo.c=
om> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/9/9 9:59, Barry Song =E5=86=99=E9=81=93:
> >>> On Wed, Sep 4, 2024 at 11:26=E2=80=AFPM zhiguojiang <justinjiang@vivo=
.com> wrote:
> >>>>
> >>>> =E5=9C=A8 2024/9/4 17:16, Barry Song =E5=86=99=E9=81=93:
> >>>>> On Tue, Aug 6, 2024 at 3:36=E2=80=AFAM Zhiguo Jiang <justinjiang@vi=
vo.com> wrote:
> >>>>>> One of the main reasons for the prolonged exit of the process with
> >>>>>> independent mm is the time-consuming release of its swap entries.
> >>>>>> The proportion of swap memory occupied by the process increases ov=
er
> >>>>>> time due to high memory pressure triggering to reclaim anonymous f=
olio
> >>>>>> into swapspace, e.g., in Android devices, we found this proportion=
 can
> >>>>>> reach 60% or more after a period of time. Additionally, the relati=
vely
> >>>>>> lengthy path for releasing swap entries further contributes to the
> >>>>>> longer time required to release swap entries.
> >>>>>>
> >>>>>> Testing Platform: 8GB RAM
> >>>>>> Testing procedure:
> >>>>>> After booting up, start 15 processes first, and then observe the
> >>>>>> physical memory size occupied by the last launched process at diff=
erent
> >>>>>> time points.
> >>>>>> Example: The process launched last: com.qiyi.video
> >>>>>> |  memory type  |  0min  |  1min  |   5min  |   10min  |   15min  =
|
> >>>>>> ------------------------------------------------------------------=
-
> >>>>>> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  =
|
> >>>>>> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  =
|
> >>>>>> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  =
|
> >>>>>> |  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  =
|
> >>>>>> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  =
|
> >>>>>> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  =
|
> >>>>>> Note: min - minute.
> >>>>>>
> >>>>>> When there are multiple processes with independent mm and the high
> >>>>>> memory pressure in system, if the large memory required process is
> >>>>>> launched at this time, system will is likely to trigger the instan=
taneous
> >>>>>> killing of many processes with independent mm. Due to multiple exi=
ting
> >>>>>> processes occupying multiple CPU core resources for concurrent exe=
cution,
> >>>>>> leading to some issues such as the current non-exiting and importa=
nt
> >>>>>> processes lagging.
> >>>>>>
> >>>>>> To solve this problem, we have introduced the multiple exiting pro=
cess
> >>>>>> asynchronous swap entries release mechanism, which isolates and ca=
ches
> >>>>>> swap entries occupied by multiple exiting processes, and hands the=
m over
> >>>>>> to an asynchronous kworker to complete the release. This allows th=
e
> >>>>>> exiting processes to complete quickly and release CPU resources. W=
e have
> >>>>>> validated this modification on the Android products and achieved t=
he
> >>>>>> expected benefits.
> >>>>>>
> >>>>>> Testing Platform: 8GB RAM
> >>>>>> Testing procedure:
> >>>>>> After restarting the machine, start 15 app processes first, and th=
en
> >>>>>> start the camera app processes, we monitor the cold start and prev=
iew
> >>>>>> time datas of the camera app processes.
> >>>>>>
> >>>>>> Test datas of camera processes cold start time (unit: millisecond)=
:
> >>>>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> >>>>>> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
> >>>>>> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
> >>>>>>
> >>>>>> Test datas of camera processes preview time (unit: millisecond):
> >>>>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> >>>>>> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
> >>>>>> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
> >>>>>>
> >>>>>> Base on the average of the six sets of test datas above, we can se=
e that
> >>>>>> the benefit datas of the modified patch:
> >>>>>> 1. The cold start time of camera app processes has reduced by abou=
t 20%.
> >>>>>> 2. The preview time of camera app processes has reduced by about 4=
2%.
> >>>>>>
> >>>>>> It offers several benefits:
> >>>>>> 1. Alleviate the high system cpu loading caused by multiple exitin=
g
> >>>>>>       processes running simultaneously.
> >>>>>> 2. Reduce lock competition in swap entry free path by an asynchron=
ous
> >>>>>>       kworker instead of multiple exiting processes parallel execu=
tion.
> >>>>>> 3. Release pte_present memory occupied by exiting processes more
> >>>>>>       efficiently.
> >>>>>>
> >>>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >>>>>> ---
> >>>>>>     arch/s390/include/asm/tlb.h |   8 +
> >>>>>>     include/asm-generic/tlb.h   |  44 ++++++
> >>>>>>     include/linux/mm_types.h    |  58 +++++++
> >>>>>>     mm/memory.c                 |   3 +-
> >>>>>>     mm/mmu_gather.c             | 296 ++++++++++++++++++++++++++++=
++++++++
> >>>>>>     5 files changed, 408 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/t=
lb.h
> >>>>>> index e95b2c8081eb..3f681f63390f
> >>>>>> --- a/arch/s390/include/asm/tlb.h
> >>>>>> +++ b/arch/s390/include/asm/tlb.h
> >>>>>> @@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct=
 mmu_gather *tlb,
> >>>>>>                    struct page *page, bool delay_rmap, int page_si=
ze);
> >>>>>>     static inline bool __tlb_remove_folio_pages(struct mmu_gather =
*tlb,
> >>>>>>                    struct page *page, unsigned int nr_pages, bool =
delay_rmap);
> >>>>>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *t=
lb,
> >>>>>> +               swp_entry_t entry, int nr);
> >>>>>>
> >>>>>>     #define tlb_flush tlb_flush
> >>>>>>     #define pte_free_tlb pte_free_tlb
> >>>>>> @@ -69,6 +71,12 @@ static inline bool __tlb_remove_folio_pages(str=
uct mmu_gather *tlb,
> >>>>>>            return false;
> >>>>>>     }
> >>>>>>
> >>>>>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *t=
lb,
> >>>>>> +               swp_entry_t entry, int nr)
> >>>>>> +{
> >>>>>> +       return false;
> >>>>>> +}
> >>>>>> +
> >>>>>>     static inline void tlb_flush(struct mmu_gather *tlb)
> >>>>>>     {
> >>>>>>            __tlb_flush_mm_lazy(tlb->mm);
> >>>>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> >>>>>> index 709830274b75..8b4d516b35b8
> >>>>>> --- a/include/asm-generic/tlb.h
> >>>>>> +++ b/include/asm-generic/tlb.h
> >>>>>> @@ -294,6 +294,37 @@ extern void tlb_flush_rmaps(struct mmu_gather=
 *tlb, struct vm_area_struct *vma);
> >>>>>>     static inline void tlb_flush_rmaps(struct mmu_gather *tlb, str=
uct vm_area_struct *vma) { }
> >>>>>>     #endif
> >>>>>>
> >>>>>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
> >>>>>> +struct mmu_swap_batch {
> >>>>>> +       struct mmu_swap_batch *next;
> >>>>>> +       unsigned int nr;
> >>>>>> +       unsigned int max;
> >>>>>> +       encoded_swpentry_t encoded_entrys[];
> >>>>>> +};
> >>>>>> +
> >>>>>> +#define MAX_SWAP_GATHER_BATCH  \
> >>>>>> +       ((PAGE_SIZE - sizeof(struct mmu_swap_batch)) / sizeof(void=
 *))
> >>>>>> +
> >>>>>> +#define MAX_SWAP_GATHER_BATCH_COUNT    (10000UL / MAX_SWAP_GATHER=
_BATCH)
> >>>>>> +
> >>>>>> +struct mmu_swap_gather {
> >>>>>> +       /*
> >>>>>> +        * the asynchronous kworker to batch
> >>>>>> +        * release swap entries
> >>>>>> +        */
> >>>>>> +       struct work_struct free_work;
> >>>>>> +
> >>>>>> +       /* batch cache swap entries */
> >>>>>> +       unsigned int batch_count;
> >>>>>> +       struct mmu_swap_batch *active;
> >>>>>> +       struct mmu_swap_batch local;
> >>>>>> +       encoded_swpentry_t __encoded_entrys[MMU_GATHER_BUNDLE];
> >>>>>> +};
> >>>>>> +
> >>>>>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
> >>>>>> +               swp_entry_t entry, int nr);
> >>>>>> +#endif
> >>>>>> +
> >>>>>>     /*
> >>>>>>      * struct mmu_gather is an opaque type used by the mm code for=
 passing around
> >>>>>>      * any data needed by arch specific code for tlb_remove_page.
> >>>>>> @@ -343,6 +374,18 @@ struct mmu_gather {
> >>>>>>            unsigned int            vma_exec : 1;
> >>>>>>            unsigned int            vma_huge : 1;
> >>>>>>            unsigned int            vma_pfn  : 1;
> >>>>>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
> >>>>>> +       /*
> >>>>>> +        * Two states of releasing swap entries
> >>>>>> +        * asynchronously:
> >>>>>> +        * swp_freeable - have opportunity to
> >>>>>> +        * release asynchronously future
> >>>>>> +        * swp_freeing - be releasing asynchronously.
> >>>>>> +        */
> >>>>>> +       unsigned int            swp_freeable : 1;
> >>>>>> +       unsigned int            swp_freeing : 1;
> >>>>>> +       unsigned int            swp_disable : 1;
> >>>>>> +#endif
> >>>>>>
> >>>>>>            unsigned int            batch_count;
> >>>>>>
> >>>>>> @@ -354,6 +397,7 @@ struct mmu_gather {
> >>>>>>     #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
> >>>>>>            unsigned int page_size;
> >>>>>>     #endif
> >>>>>> +       struct mmu_swap_gather *swp;
> >>>>>>     #endif
> >>>>>>     };
> >>>>>>
> >>>>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >>>>>> index 165c58b12ccc..2f66303f1519
> >>>>>> --- a/include/linux/mm_types.h
> >>>>>> +++ b/include/linux/mm_types.h
> >>>>>> @@ -283,6 +283,64 @@ typedef struct {
> >>>>>>            unsigned long val;
> >>>>>>     } swp_entry_t;
> >>>>>>
> >>>>>> +/*
> >>>>>> + * encoded_swpentry_t - a type marking the encoded swp_entry_t.
> >>>>>> + *
> >>>>>> + * An 'encoded_swpentry_t' represents a 'swp_enrty_t' with its th=
e highest
> >>>>>> + * bit indicating extra context-dependent information. Only used =
in swp_entry
> >>>>>> + * asynchronous release path by mmu_swap_gather.
> >>>>>> + */
> >>>>>> +typedef struct {
> >>>>>> +       unsigned long val;
> >>>>>> +} encoded_swpentry_t;
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * The next item in an encoded_swpentry_t array is the "nr" argum=
ent, specifying the
> >>>>>> + * total number of consecutive swap entries associated with the s=
ame folio. If this
> >>>>>> + * bit is not set, "nr" is implicitly 1.
> >>>>>> + *
> >>>>>> + * Refer to include\asm\pgtable.h, swp_offset bits: 0 ~ 57, swp_t=
ype bits: 58 ~ 62.
> >>>>>> + * Bit63 can be used here.
> >>>>>> + */
> >>>>>> +#define ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT (1UL << (BITS_PER_LON=
G - 1))
> >>>>>> +
> >>>>>> +static __always_inline encoded_swpentry_t
> >>>>>> +encode_swpentry(swp_entry_t entry, unsigned long flags)
> >>>>>> +{
> >>>>>> +       encoded_swpentry_t ret;
> >>>>>> +
> >>>>>> +       VM_WARN_ON_ONCE(flags & ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NE=
XT);
> >>>>>> +       ret.val =3D flags | entry.val;
> >>>>>> +       return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline unsigned long encoded_swpentry_flags(encoded_swpent=
ry_t entry)
> >>>>>> +{
> >>>>>> +       return ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline swp_entry_t encoded_swpentry_data(encoded_swpentry_=
t entry)
> >>>>>> +{
> >>>>>> +       swp_entry_t ret;
> >>>>>> +
> >>>>>> +       ret.val =3D ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.v=
al;
> >>>>>> +       return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static __always_inline encoded_swpentry_t encode_nr_swpentrys(uns=
igned long nr)
> >>>>>> +{
> >>>>>> +       encoded_swpentry_t ret;
> >>>>>> +
> >>>>>> +       VM_WARN_ON_ONCE(nr & ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
> >>>>>> +       ret.val =3D nr;
> >>>>>> +       return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static __always_inline unsigned long encoded_nr_swpentrys(encoded=
_swpentry_t entry)
> >>>>>> +{
> >>>>>> +       return ((~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT) & entry.val=
);
> >>>>>> +}
> >>>>>> +
> >>>>>>     /**
> >>>>>>      * struct folio - Represents a contiguous set of bytes.
> >>>>>>      * @flags: Identical to the page flags.
> >>>>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>>>> index d6a9dcddaca4..023a8adcb67c
> >>>>>> --- a/mm/memory.c
> >>>>>> +++ b/mm/memory.c
> >>>>>> @@ -1650,7 +1650,8 @@ static unsigned long zap_pte_range(struct mm=
u_gather *tlb,
> >>>>>>                            if (!should_zap_cows(details))
> >>>>>>                                    continue;
> >>>>>>                            rss[MM_SWAPENTS] -=3D nr;
> >>>>>> -                       free_swap_and_cache_nr(entry, nr);
> >>>>>> +                       if (!__tlb_remove_swap_entries(tlb, entry,=
 nr))
> >>>>>> +                               free_swap_and_cache_nr(entry, nr);
> >>>>>>                    } else if (is_migration_entry(entry)) {
> >>>>>>                            folio =3D pfn_swap_entry_folio(entry);
> >>>>>>                            if (!should_zap_folio(details, folio))
> >>>>>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> >>>>>> index 99b3e9408aa0..33dc9d1faff9
> >>>>>> --- a/mm/mmu_gather.c
> >>>>>> +++ b/mm/mmu_gather.c
> >>>>>> @@ -9,11 +9,303 @@
> >>>>>>     #include <linux/smp.h>
> >>>>>>     #include <linux/swap.h>
> >>>>>>     #include <linux/rmap.h>
> >>>>>> +#include <linux/oom.h>
> >>>>>>
> >>>>>>     #include <asm/pgalloc.h>
> >>>>>>     #include <asm/tlb.h>
> >>>>>>
> >>>>>>     #ifndef CONFIG_MMU_GATHER_NO_GATHER
> >>>>>> +/*
> >>>>>> + * The swp_entry asynchronous release mechanism for multiple proc=
esses with
> >>>>>> + * independent mm exiting simultaneously.
> >>>>>> + *
> >>>>>> + * During the multiple exiting processes releasing their own mm s=
imultaneously,
> >>>>>> + * the swap entries in the exiting processes are handled by isola=
ting, caching
> >>>>>> + * and handing over to an asynchronous kworker to complete the re=
lease.
> >>>>>> + *
> >>>>>> + * The conditions for the exiting process entering the swp_entry =
asynchronous
> >>>>>> + * release path:
> >>>>>> + * 1. The exiting process's MM_SWAPENTS count is >=3D SWAP_CLUSTE=
R_MAX, avoiding
> >>>>>> + *    to alloc struct mmu_swap_gather frequently.
> >>>>>> + * 2. The number of exiting processes is >=3D NR_MIN_EXITING_PROC=
ESSES.
> >>>>> Hi Zhiguo,
> >>>>>
> >>>>> I'm curious about the significance of NR_MIN_EXITING_PROCESSES. It =
seems that
> >>>>> batched swap entry freeing, even with one process, could be a
> >>>>> bottleneck for a single
> >>>>> process based on the data from this patch:
> >>>>>
> >>>>> mm: attempt to batch free swap entries for zap_pte_range()
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/=
?h=3Dmm-stable&id=3Dbea67dcc5ee
> >>>>> "munmap bandwidth becomes 3X faster."
> >>>>>
> >>>>> So what would happen if you simply set NR_MIN_EXITING_PROCESSES to =
1?
> >>>> Hi Barry,
> >>>>
> >>>> Thanks for your comments.
> >>>>
> >>>> The reason for NR_MIN_EXITING_PROCESSES =3D 2 is that previously we
> >>>> conducted the multiple android apps continuous startup performance
> >>>> test on the case of NR_MIN_EXITING_PROCESSES =3D 1, and the results
> >>>> showed that the startup time had deteriorated slightly. However,
> >>>> the patch's logic in this test was different from the one I submitte=
d
> >>>> to the community, and it may be due to some other issues with the
> >>>> previous old patch.
> >>>>
> >>>> However, we have conducted relevant memory performance tests on this
> >>>> patches submitted to the community (NR_MIN_EXITING_PROCESSES=3D2), a=
nd
> >>>> the results are better than before the modification. The patches hav=
e
> >>>> been used on multiple projects.
> >>>> For example:
> >>>> Test the time consumption and subjective fluency experience of
> >>>> launching 30 android apps continuously for two rounds.
> >>>> Test machine: RAM 16GB
> >>>> |        | time(s) | Frame-droped rate(%) |
> >>>> | before | 230.76  |         0.54         |
> >>>> | after  | 225.23  |         0.74         |
> >>>> We can see that the patch has been optimized 5.53s for startup time =
and
> >>>> 0.2% frame-droped rate and better subjective smoothness experience.
> >>>>
> >>>> Perhaps the patches submitted to the community has also improved the
> >>>> multiple android apps continuous startup performance in the case
> >>>> of NR_MIN_EXITING_PROCESSES=3D1. If necessary, I will conduct releva=
nt
> >>>> tests to verify this situation in the future.
> >> Thanks Barry for your valuable suggestions.
> >>> Using a fixed value like 2 feels more like a workaround than a solid =
solution.
> >>> It would be better if we could eliminate this hack.
> >> Ok, I will conduct more tests for tring to solve this parameter issue.
> >>> Additionally, this type of asynchronous reclamation might struggle to=
 scale
> >>> effectively, particularly on NUMA systems with many CPU cores.
> >>>
> >>> Many kernel threads are per-node, like kswapd. For instance, if we ha=
ve 100
> >>> threads running on 100 CPUs executing zap_pte_range(), your approach,=
 which
> >>> relies on a single async thread to reclaim swap entries, might lead t=
o
> >>> performance
> >>> regressions.
> >>>
> >>> We might need to consider a more adaptable approach that can evaluate
> >>> the machine's
> >>> topology and dynamically determine the appropriate number of async
> >>> threads, rather
> >>> than hard-coding it to just one. Otherwise, there could be ongoing
> >>> concerns about
> >>> whether this solution is truly applicable to all systems.
> >> Can we dynamically determine the number of asynchronous kworkers to be
> >> created based on the number of exiting processes at a certain moment,
> >> for example, every 8 exiting processes corresponds to one asynchronous
> >> kworker?
> >>
> >> | The number of exiting processes | The number of asynchronous kworker=
s |
> >> |          [1, 8]                 | 1                    |
> >> |          [9, 16]                | 2                    |
> >> |          ...                    | ...                   |
> >> |      [8*N+1, 8*(N+1)]           | N+1                   |
> >> N >=3D 0
> > I'm not entirely sure. Another potential approach could be to use a
> > dedicated thread
> > for each NUMA node, but we would need data to confirm if this is the
> > right solution.
> I feel that this may be a feasible async approach, where the async
> kworker of each NUMA node is responsible for maintaining and releasing
> swap entries mapped by the exiting processes executing on the
> corresponding local CPUs. Not sure how many CPUs each NUMA node can
> contain? However, I currently do not have a NUMA environment for this
> testing verification.

Yes, I get it. As someone working on phones, we don=E2=80=99t have NUMA mac=
hines,
but our code still impacts them. That=E2=80=99s what makes things so tricky=
:-)

> >>> Alternatively, we might be able to develop a method to speed up
> >>> batched freeing in a
> >>> synchronous manner after collecting the mmu_swap_batch. mmu_gather is=
n't
> >>> async, but it can still speed up tlb flush, right?
> >> The synchronous manner may have some optimization effect, but it seems
> >> that the optimization effect on the CPUs load occupied by multiple
> >> exiting processes is not significant. In addition, David stated in the
> >> latest comment that swap entry seems unrelated to tlb.
> >>> For phones with just 8 CPU cores, I definitely like your patch.
> >>> However, since we're
> >>> aiming for something which can affect all systems, the situation migh=
t be more
> >>> complex.
> >> Yes, this pacth still needs further improvement to adapt to all system=
s.
> > If we want to keep things simple, another approach might be to profile =
the
> > hotspots within swap_free_nr(), identifying the most time-consuming par=
ts,
> > and then optimize them based on the data we collect from your
> > mmu_swap_batch. Then we don't have to make things async. Have you ever
> > profiled the hotspots?
> The hotspots seems to have been implemented in the __swap_entries_free()
> in the patches you submitted, releasing continuous swap entries at once.
> Moreover, there may be duplication between the mmu_swap_batch and
> swapsots_cache.=F0=9F=99=82

I assume you're referring to how __swap_entries_free() in the patch "mm:
attempt to batch free swap entries for zap_pte_range()" addresses the
hotspots, potentially eliminating the swap entry release as a bottleneck on=
ce
we have mTHP. However, for platforms that don=E2=80=99t use mTHP, is this s=
till a
significant issue?

Have you ever profiled the code and identified the exact bottleneck? If so,
we can brainstorm ideas to address it together. Honestly, I wasn=E2=80=99t =
sure which
specific line was causing swap_free to be so slow, but __swap_entries_free(=
)
significantly improves performance for the mTHP case.

> >
> >>>>>> + *
> >>>>>> + * Since the time for determining the number of exiting processes=
 is dynamic,
> >>>>>> + * the exiting process may start to enter the swp_entry asynchron=
ous release
> >>>>>> + * at the beginning or middle stage of the exiting process's swp_=
entry release
> >>>>>> + * path.
> >>>>>> + *
> >>>>>> + * Once an exiting process enters the swp_entry asynchronous rele=
ase, all remaining
> >>>>>> + * swap entries in this exiting process need to be fully released=
 by asynchronous
> >>>>>> + * kworker theoretically.
> >>>>> Freeing a slot can indeed release memory from `zRAM`, potentially r=
eturning
> >>>>> it to the system for allocation. Your patch frees swap slots asynch=
ronously;
> >>>>> I assume this doesn=E2=80=99t slow down the memory freeing process =
for `zRAM`, or
> >>>>> could it even slow down the freeing of `zRAM` memory? Freeing compr=
essed
> >>>>> memory might not be as crucial compared to freeing uncompressed mem=
ory with
> >>>>> present PTEs?
> >>>> Yes, freeing uncompressed memory with present PTEs is more important
> >>>> compared to freeing compressed 'zRAM' memory.
> >>>>
> >>>> I guess that the multiple exiting processes releasing swap entries
> >>>> simultaneously may result in the swap_info->lock competition pressur=
e
> >>>> in swapcache_free_entries(), affecting the efficiency of releasing s=
wap
> >>>> entries. However, if the asynchronous kworker is used, this issue ca=
n
> >>>> be avoided, and perhaps the improvement is minor.
> >>>>
> >>>> The freeing of zRAM memory does not slow down. We have observed trac=
es
> >>>> in the camera startup scene and found that the asynchronous kworker
> >>>> can release all swap entries before entering the camera preview.
> >>>> Compared to not using the asynchronous kworker, the exiting processe=
s
> >>>> completed after entering the camera preview.
> >>>>>> + *
> >>>>>> + * The function of the swp_entry asynchronous release:
> >>>>>> + * 1. Alleviate the high system cpu load caused by multiple exiti=
ng processes
> >>>>>> + *    running simultaneously.
> >>>>>> + * 2. Reduce lock competition in swap entry free path by an async=
hronous kworker
> >>>>>> + *    instead of multiple exiting processes parallel execution.
> >>>>>> + * 3. Release pte_present memory occupied by exiting processes mo=
re efficiently.
> >>>>>> + */
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * The min number of exiting processes required for swp_entry asy=
nchronous release
> >>>>>> + */
> >>>>>> +#define NR_MIN_EXITING_PROCESSES 2
> >>>>>> +
> >>>>>> +static atomic_t nr_exiting_processes =3D ATOMIC_INIT(0);
> >>>>>> +static struct kmem_cache *swap_gather_cachep;
> >>>>>> +static struct workqueue_struct *swapfree_wq;
> >>>>>> +static DEFINE_STATIC_KEY_TRUE(tlb_swap_asyncfree_disabled);
> >>>>>> +
> >>>>>> +static int __init tlb_swap_async_free_setup(void)
> >>>>>> +{
> >>>>>> +       swapfree_wq =3D alloc_workqueue("smfree_wq", WQ_UNBOUND |
> >>>>>> +               WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
> >>>>>> +       if (!swapfree_wq)
> >>>>>> +               goto fail;
> >>>>>> +
> >>>>>> +       swap_gather_cachep =3D kmem_cache_create("swap_gather",
> >>>>>> +               sizeof(struct mmu_swap_gather),
> >>>>>> +               0, SLAB_TYPESAFE_BY_RCU | SLAB_PANIC | SLAB_ACCOUN=
T,
> >>>>>> +               NULL);
> >>>>>> +       if (!swap_gather_cachep)
> >>>>>> +               goto kcache_fail;
> >>>>>> +
> >>>>>> +       static_branch_disable(&tlb_swap_asyncfree_disabled);
> >>>>>> +       return 0;
> >>>>>> +
> >>>>>> +kcache_fail:
> >>>>>> +       destroy_workqueue(swapfree_wq);
> >>>>>> +fail:
> >>>>>> +       return -ENOMEM;
> >>>>>> +}
> >>>>>> +postcore_initcall(tlb_swap_async_free_setup);
> >>>>>> +
> >>>>>> +static void __tlb_swap_gather_free(struct mmu_swap_gather *swap_g=
ather)
> >>>>>> +{
> >>>>>> +       struct mmu_swap_batch *swap_batch, *next;
> >>>>>> +
> >>>>>> +       for (swap_batch =3D swap_gather->local.next; swap_batch; s=
wap_batch =3D next) {
> >>>>>> +               next =3D swap_batch->next;
> >>>>>> +               free_page((unsigned long)swap_batch);
> >>>>>> +       }
> >>>>>> +       swap_gather->local.next =3D NULL;
> >>>>>> +       kmem_cache_free(swap_gather_cachep, swap_gather);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void tlb_swap_async_free_work(struct work_struct *w)
> >>>>>> +{
> >>>>>> +       int i, nr_multi, nr_free;
> >>>>>> +       swp_entry_t start_entry;
> >>>>>> +       struct mmu_swap_batch *swap_batch;
> >>>>>> +       struct mmu_swap_gather *swap_gather =3D container_of(w,
> >>>>>> +               struct mmu_swap_gather, free_work);
> >>>>>> +
> >>>>>> +       /* Release swap entries cached in mmu_swap_batch. */
> >>>>>> +       for (swap_batch =3D &swap_gather->local; swap_batch && swa=
p_batch->nr;
> >>>>>> +           swap_batch =3D swap_batch->next) {
> >>>>>> +               nr_free =3D 0;
> >>>>>> +               for (i =3D 0; i < swap_batch->nr; i++) {
> >>>>>> +                       if (unlikely(encoded_swpentry_flags(swap_b=
atch->encoded_entrys[i]) &
> >>>>>> +                           ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT)) =
{
> >>>>>> +                               start_entry =3D encoded_swpentry_d=
ata(swap_batch->encoded_entrys[i]);
> >>>>>> +                               nr_multi =3D encoded_nr_swpentrys(=
swap_batch->encoded_entrys[++i]);
> >>>>>> +                               free_swap_and_cache_nr(start_entry=
, nr_multi);
> >>>>>> +                               nr_free +=3D 2;
> >>>>>> +                       } else {
> >>>>>> +                               start_entry =3D encoded_swpentry_d=
ata(swap_batch->encoded_entrys[i]);
> >>>>>> +                               free_swap_and_cache_nr(start_entry=
, 1);
> >>>>>> +                               nr_free++;
> >>>>>> +                       }
> >>>>>> +               }
> >>>>>> +               swap_batch->nr -=3D nr_free;
> >>>>>> +               VM_BUG_ON(swap_batch->nr);
> >>>>>> +       }
> >>>>>> +       __tlb_swap_gather_free(swap_gather);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static bool __tlb_swap_gather_mmu_check(struct mmu_gather *tlb)
> >>>>>> +{
> >>>>>> +       /*
> >>>>>> +        * Only the exiting processes with the MM_SWAPENTS counter=
 >=3D
> >>>>>> +        * SWAP_CLUSTER_MAX have the opportunity to release their =
swap
> >>>>>> +        * entries by asynchronous kworker.
> >>>>>> +        */
> >>>>>> +       if (!task_is_dying() ||
> >>>>>> +           get_mm_counter(tlb->mm, MM_SWAPENTS) < SWAP_CLUSTER_MA=
X)
> >>>>>> +               return true;
> >>>>>> +
> >>>>>> +       atomic_inc(&nr_exiting_processes);
> >>>>>> +       if (atomic_read(&nr_exiting_processes) < NR_MIN_EXITING_PR=
OCESSES)
> >>>>>> +               tlb->swp_freeable =3D 1;
> >>>>>> +       else
> >>>>>> +               tlb->swp_freeing =3D 1;
> >>>>>> +
> >>>>>> +       return false;
> >>>>>> +}
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * __tlb_swap_gather_init - Initialize an mmu_swap_gather structu=
re
> >>>>>> + * for swp_entry tear-down.
> >>>>>> + * @tlb: the mmu_swap_gather structure belongs to tlb
> >>>>>> + */
> >>>>>> +static bool __tlb_swap_gather_init(struct mmu_gather *tlb)
> >>>>>> +{
> >>>>>> +       tlb->swp =3D kmem_cache_alloc(swap_gather_cachep, GFP_ATOM=
IC | GFP_NOWAIT);
> >>>>>> +       if (unlikely(!tlb->swp))
> >>>>>> +               return false;
> >>>>>> +
> >>>>>> +       tlb->swp->local.next  =3D NULL;
> >>>>>> +       tlb->swp->local.nr    =3D 0;
> >>>>>> +       tlb->swp->local.max   =3D ARRAY_SIZE(tlb->swp->__encoded_e=
ntrys);
> >>>>>> +
> >>>>>> +       tlb->swp->active      =3D &tlb->swp->local;
> >>>>>> +       tlb->swp->batch_count =3D 0;
> >>>>>> +
> >>>>>> +       INIT_WORK(&tlb->swp->free_work, tlb_swap_async_free_work);
> >>>>>> +       return true;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void __tlb_swap_gather_mmu(struct mmu_gather *tlb)
> >>>>>> +{
> >>>>>> +       if (static_branch_unlikely(&tlb_swap_asyncfree_disabled))
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       tlb->swp =3D NULL;
> >>>>>> +       tlb->swp_freeable =3D 0;
> >>>>>> +       tlb->swp_freeing =3D 0;
> >>>>>> +       tlb->swp_disable =3D 0;
> >>>>>> +
> >>>>>> +       if (__tlb_swap_gather_mmu_check(tlb))
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       /*
> >>>>>> +        * If the exiting process meets the conditions of
> >>>>>> +        * swp_entry asynchronous release, an mmu_swap_gather
> >>>>>> +        * structure will be initialized.
> >>>>>> +        */
> >>>>>> +       if (tlb->swp_freeing)
> >>>>>> +               __tlb_swap_gather_init(tlb);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void __tlb_swap_gather_queuework(struct mmu_gather *tlb, b=
ool finish)
> >>>>>> +{
> >>>>>> +       queue_work(swapfree_wq, &tlb->swp->free_work);
> >>>>>> +       tlb->swp =3D NULL;
> >>>>>> +       if (!finish)
> >>>>>> +               __tlb_swap_gather_init(tlb);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static bool __tlb_swap_next_batch(struct mmu_gather *tlb)
> >>>>>> +{
> >>>>>> +       struct mmu_swap_batch *swap_batch;
> >>>>>> +
> >>>>>> +       if (tlb->swp->batch_count =3D=3D MAX_SWAP_GATHER_BATCH_COU=
NT)
> >>>>>> +               goto free;
> >>>>>> +
> >>>>>> +       swap_batch =3D (void *)__get_free_page(GFP_ATOMIC | GFP_NO=
WAIT);
> >>>>>> +       if (unlikely(!swap_batch))
> >>>>>> +               goto free;
> >>>>>> +
> >>>>>> +       swap_batch->next =3D NULL;
> >>>>>> +       swap_batch->nr   =3D 0;
> >>>>>> +       swap_batch->max  =3D MAX_SWAP_GATHER_BATCH;
> >>>>>> +
> >>>>>> +       tlb->swp->active->next =3D swap_batch;
> >>>>>> +       tlb->swp->active =3D swap_batch;
> >>>>>> +       tlb->swp->batch_count++;
> >>>>>> +       return true;
> >>>>>> +free:
> >>>>>> +       /* batch move to wq */
> >>>>>> +       __tlb_swap_gather_queuework(tlb, false);
> >>>>>> +       return false;
> >>>>>> +}
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * __tlb_remove_swap_entries - the swap entries in exiting proces=
s are
> >>>>>> + * isolated, batch cached in struct mmu_swap_batch.
> >>>>>> + * @tlb: the current mmu_gather
> >>>>>> + * @entry: swp_entry to be isolated and cached
> >>>>>> + * @nr: the number of consecutive entries starting from entry par=
ameter.
> >>>>>> + */
> >>>>>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
> >>>>>> +                            swp_entry_t entry, int nr)
> >>>>>> +{
> >>>>>> +       struct mmu_swap_batch *swap_batch;
> >>>>>> +       unsigned long flags =3D 0;
> >>>>>> +       bool ret =3D false;
> >>>>>> +
> >>>>>> +       if (tlb->swp_disable)
> >>>>>> +               return ret;
> >>>>>> +
> >>>>>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
> >>>>>> +               return ret;
> >>>>>> +
> >>>>>> +       if (tlb->swp_freeable) {
> >>>>>> +               if (atomic_read(&nr_exiting_processes) <
> >>>>>> +                   NR_MIN_EXITING_PROCESSES)
> >>>>>> +                       return ret;
> >>>>>> +               /*
> >>>>>> +                * If the current number of exiting processes
> >>>>>> +                * is >=3D NR_MIN_EXITING_PROCESSES, the exiting
> >>>>>> +                * process with swp_freeable state will enter
> >>>>>> +                * swp_freeing state to start releasing its
> >>>>>> +                * remaining swap entries by the asynchronous
> >>>>>> +                * kworker.
> >>>>>> +                */
> >>>>>> +               tlb->swp_freeable =3D 0;
> >>>>>> +               tlb->swp_freeing =3D 1;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       VM_BUG_ON(tlb->swp_freeable || !tlb->swp_freeing);
> >>>>>> +       if (!tlb->swp && !__tlb_swap_gather_init(tlb))
> >>>>>> +               return ret;
> >>>>>> +
> >>>>>> +       swap_batch =3D tlb->swp->active;
> >>>>>> +       if (unlikely(swap_batch->nr >=3D swap_batch->max - 1)) {
> >>>>>> +               __tlb_swap_gather_queuework(tlb, false);
> >>>>>> +               return ret;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       if (likely(nr =3D=3D 1)) {
> >>>>>> +               swap_batch->encoded_entrys[swap_batch->nr++] =3D e=
ncode_swpentry(entry, flags);
> >>>>>> +       } else {
> >>>>>> +               flags |=3D ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT;
> >>>>>> +               swap_batch->encoded_entrys[swap_batch->nr++] =3D e=
ncode_swpentry(entry, flags);
> >>>>>> +               swap_batch->encoded_entrys[swap_batch->nr++] =3D e=
ncode_nr_swpentrys(nr);
> >>>>>> +       }
> >>>>>> +       ret =3D true;
> >>>>>> +
> >>>>>> +       if (swap_batch->nr >=3D swap_batch->max - 1) {
> >>>>>> +               if (!__tlb_swap_next_batch(tlb))
> >>>>>> +                       goto exit;
> >>>>>> +               swap_batch =3D tlb->swp->active;
> >>>>>> +       }
> >>>>>> +       VM_BUG_ON(swap_batch->nr > swap_batch->max - 1);
> >>>>>> +exit:
> >>>>>> +       return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void __tlb_batch_swap_finish(struct mmu_gather *tlb)
> >>>>>> +{
> >>>>>> +       if (tlb->swp_disable)
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       if (tlb->swp_freeable) {
> >>>>>> +               tlb->swp_freeable =3D 0;
> >>>>>> +               VM_BUG_ON(tlb->swp_freeing);
> >>>>>> +               goto exit;
> >>>>>> +       }
> >>>>>> +       tlb->swp_freeing =3D 0;
> >>>>>> +       if (unlikely(!tlb->swp))
> >>>>>> +               goto exit;
> >>>>>> +
> >>>>>> +       __tlb_swap_gather_queuework(tlb, true);
> >>>>>> +exit:
> >>>>>> +       atomic_dec(&nr_exiting_processes);
> >>>>>> +}
> >>>>>>
> >>>>>>     static bool tlb_next_batch(struct mmu_gather *tlb)
> >>>>>>     {
> >>>>>> @@ -386,6 +678,9 @@ static void __tlb_gather_mmu(struct mmu_gather=
 *tlb, struct mm_struct *mm,
> >>>>>>            tlb->local.max  =3D ARRAY_SIZE(tlb->__pages);
> >>>>>>            tlb->active     =3D &tlb->local;
> >>>>>>            tlb->batch_count =3D 0;
> >>>>>> +
> >>>>>> +       tlb->swp_disable =3D 1;
> >>>>>> +       __tlb_swap_gather_mmu(tlb);
> >>>>>>     #endif
> >>>>>>            tlb->delayed_rmap =3D 0;
> >>>>>>
> >>>>>> @@ -466,6 +761,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
> >>>>>>
> >>>>>>     #ifndef CONFIG_MMU_GATHER_NO_GATHER
> >>>>>>            tlb_batch_list_free(tlb);
> >>>>>> +       __tlb_batch_swap_finish(tlb);
> >>>>>>     #endif
> >>>>>>            dec_tlb_flush_pending(tlb->mm);
> >>>>>>     }
> >>>>>> --
> >>>>>> 2.39.0
> >>>>>>
> >>> Thanks
> >>> Barry
> >> Thanks
> >> Zhiguo
> >>
> > Thanks
> > Barry
>

Thanks
Barry

