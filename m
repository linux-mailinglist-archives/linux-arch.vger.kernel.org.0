Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1606F2CCE41
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 06:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgLCFGX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 00:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLCFGX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 00:06:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD72C061A4F
        for <linux-arch@vger.kernel.org>; Wed,  2 Dec 2020 21:05:43 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g185so2424270wmf.3
        for <linux-arch@vger.kernel.org>; Wed, 02 Dec 2020 21:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XUBoIVUFuTda74sYhc9AaUfIF0VYHNgbgX6L3CSfTWQ=;
        b=FuUcSxWrRc7RgsOSwe/Ar1EO5Ff3N9odSv2XY0Zqm4g9XP/wOGYy94T5KC5HEmT6Zb
         CllAZYKNVheNctLUSpCVA6zIh60iTARxAlH2IqE8hO8QtRArgPC4FG1cylYSpVKMkKqk
         l/WPKsc5i7rBRvupJpVLvzY7Lu6Dye39+pVi0u97RbqVKvYtdT/QyH/uSImekLuKVcZI
         H2TXJq9pUhq9WbHGZbspm0eqJESP82vmo4Z90qkMrkjglVKyU2w+Rac/C03QfedVdBX2
         LYJ5cEWr8ojZ0eYqFB+t9XwtqTSSuxp1lTUuvAXfuVZpKCZbQNzq80tI6A6eI04Y+GWe
         mHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XUBoIVUFuTda74sYhc9AaUfIF0VYHNgbgX6L3CSfTWQ=;
        b=jYhDOCXjeGLc1bKOLdsmQ73piptPmi0mBZlvpqgHYI7W0MeDDfyGPmIKWjX1niqblV
         AMYKH0uQ4bSXjdIEkacqWddayJtfOwXE7IRkD6YgwF8mlWGT6NYeS139D8EdfZcCTL8k
         oLD+0cWS+dhePyDdir7SS7OimyMA+IjoEu167zFQ01HMLu+p6u7a11/GKL+Mv33LTRD/
         Oc4LbGIln5avKteQyaRCDNDEQFJuStEYSm64sgJwZ8JbtPKPVtuD7W2hiYjTKC/MFIpo
         OLAfHZumkTvmEXREPAd4Va+6TB5gO1wza2QROqI10FZO/ChrNwdj+x3LWEW0ZLyqPG4e
         b7wA==
X-Gm-Message-State: AOAM530hqUbk3HkNiH/VPikN5ONrSlb/AnlcHAd7oDcpQycPV4O0pFBP
        EwjqIqRXMAD7ANP7vM9tHnybtY0HjUqR+Lv2NFBX1g==
X-Google-Smtp-Source: ABdhPJw58yLVfBKzewS+37BuoRbKB9WSMia7+fhXYWK9vuZSkJTJI8hhAr2AGPTvmZJTPupRjW/sGVxlMYUtiS9xZq8=
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr1216271wmd.49.1606971941686;
 Wed, 02 Dec 2020 21:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20201128160141.1003903-1-npiggin@gmail.com> <20201128160141.1003903-7-npiggin@gmail.com>
 <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
 <CALCETrWBtCfD+jZ3S+O8FK-HFPODuhbDEbbfWvS=-iPATNFAOA@mail.gmail.com>
 <CALCETrXAR_9EGaOF8ymVkZycxgZkYk0dR+NjEpTfVzdcS3sOVw@mail.gmail.com> <1606879302.tdngvs3yq4.astroid@bobo.none>
In-Reply-To: <1606879302.tdngvs3yq4.astroid@bobo.none>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 2 Dec 2020 21:05:30 -0800
Message-ID: <CALCETrXi7YEk2KVSyXVuhUF_AYTqENx+XzYJqEhAYs=8oiSouA@mail.gmail.com>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Dec 1, 2020, at 7:47 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> =EF=BB=BFExcerpts from Andy Lutomirski's message of December 1, 2020 4:31=
 am:
>> other arch folk: there's some background here:
>>
>> https://lkml.kernel.org/r/CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31S=
aTOZw@mail.gmail.com
>>
>>> On Sun, Nov 29, 2020 at 12:16 PM Andy Lutomirski <luto@kernel.org> wrot=
e:
>>>
>>> On Sat, Nov 28, 2020 at 7:54 PM Andy Lutomirski <luto@kernel.org> wrote=
:
>>>>
>>>> On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>>>>>
>>>>> On big systems, the mm refcount can become highly contented when doin=
g
>>>>> a lot of context switching with threaded applications (particularly
>>>>> switching between the idle thread and an application thread).
>>>>>
>>>>> Abandoning lazy tlb slows switching down quite a bit in the important
>>>>> user->idle->user cases, so so instead implement a non-refcounted sche=
me
>>>>> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot do=
wn
>>>>> any remaining lazy ones.
>>>>>
>>>>> Shootdown IPIs are some concern, but they have not been observed to b=
e
>>>>> a big problem with this scheme (the powerpc implementation generated
>>>>> 314 additional interrupts on a 144 CPU system during a kernel compile=
).
>>>>> There are a number of strategies that could be employed to reduce IPI=
s
>>>>> if they turn out to be a problem for some workload.
>>>>
>>>> I'm still wondering whether we can do even better.
>>>>
>>>
>>> Hold on a sec.. __mmput() unmaps VMAs, frees pagetables, and flushes
>>> the TLB.  On x86, this will shoot down all lazies as long as even a
>>> single pagetable was freed.  (Or at least it will if we don't have a
>>> serious bug, but the code seems okay.  We'll hit pmd_free_tlb, which
>>> sets tlb->freed_tables, which will trigger the IPI.)  So, on
>>> architectures like x86, the shootdown approach should be free.  The
>>> only way it ought to have any excess IPIs is if we have CPUs in
>>> mm_cpumask() that don't need IPI to free pagetables, which could
>>> happen on paravirt.
>>
>> Indeed, on x86, we do this:
>>
>> [   11.558844]  flush_tlb_mm_range.cold+0x18/0x1d
>> [   11.559905]  tlb_finish_mmu+0x10e/0x1a0
>> [   11.561068]  exit_mmap+0xc8/0x1a0
>> [   11.561932]  mmput+0x29/0xd0
>> [   11.562688]  do_exit+0x316/0xa90
>> [   11.563588]  do_group_exit+0x34/0xb0
>> [   11.564476]  __x64_sys_exit_group+0xf/0x10
>> [   11.565512]  do_syscall_64+0x34/0x50
>>
>> and we have info->freed_tables set.
>>
>> What are the architectures that have large systems like?
>>
>> x86: we already zap lazies, so it should cost basically nothing to do
>
> This is not zapping lazies, this is freeing the user page tables.
>
> "lazy mm" is where a switch to a kernel thread takes on the
> previous mm for its kernel mapping rather than switch to init_mm.

The intent of the code is to flush the TLB after freeing user pages
tables, but, on bare metal, lazies get zapped as a side effect.

Anyway, I'm going to send out a mockup of an alternative approach shortly.
