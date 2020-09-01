Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9D2588C5
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIAHJd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAHJb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 03:09:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE46C0612AC;
        Tue,  1 Sep 2020 00:09:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so266754pfc.12;
        Tue, 01 Sep 2020 00:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=jFgH868brKLfolG8ClhHF9TtNA3LHrtGgMA4zxAiKX0=;
        b=lXBGg1pTqn6cby0WgpOe3/q47uedcKbwy1UqSIzT6KgmufWJuQxrOoKcdUDcd6c0FB
         wxDe+BzsSkSf/ZsTcdMlFn8n0qtwjIOY1FNVQVRsuX+JX0I3QopCxJtSdXL182io0Hxv
         snQXH27sz8ZOgxhixuD9Il92w2qq0U53YTe5i/flbm12Tqe5qieAFyEzzBNQvBSJxATc
         CFC8owh4UiGrCzHKI4q7VFcsviOX/0TnqVMTS66tG795pMo7UKiv0Q1yPUQI0SnK1qRH
         1fpabcG8UpprkbzupiPnCrPNP8p98/XHl2dfGHxuuPTOkJRkjndY2tsjbjnLhZfkcAid
         7xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=jFgH868brKLfolG8ClhHF9TtNA3LHrtGgMA4zxAiKX0=;
        b=LAspN3VfX7gEU+FQXP3Z9NwrFgJy1HCvydxXCKDTiDnz4PvfPFWCXXpVOEESDVtf7c
         wKeqLxsAqiWE2bFR6C4oZqSflvDXOvjOq1JT7YKBC2d/8h0NK4+jf4hC7qDMzh4Gp2Jv
         x9lC2gVN73l13YAbLyrkiIRFTshQzaG2mEuqoYkT9j73a1NzxhD/1q73XW8/u1908swS
         YJ6cNHe3E5ZTTN5fAyq7kt1C9gn5FhN/YDLYoQWefWiRxFmsWUbymOncaXg1ixp55Noy
         O1cejNRA8yLHBYz9y3xcufRpMc0z0RFYZMeAfWY7syzo5m4jGBg8eIOY05b2QHk/5lLS
         bAtA==
X-Gm-Message-State: AOAM533eTFBCpoN6kfYcD8c0/o+9axAI0zsPwSbh4AVl0pZtmeV3nrFr
        x0Ay7msEBfvQzLjWlDk4cWjgM1uzCHc=
X-Google-Smtp-Source: ABdhPJw8IvUUs2LGl7PRJUTj57KcLBnaKUUSmv/YtwZ3U7UATVswK2AawtjMtjLfDcaS087AMzr53A==
X-Received: by 2002:aa7:9685:: with SMTP id f5mr556166pfk.232.1598944169271;
        Tue, 01 Sep 2020 00:09:29 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id z26sm537750pfa.55.2020.09.01.00.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 00:09:28 -0700 (PDT)
Date:   Tue, 01 Sep 2020 17:09:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 10/23] microblaze: use asm-generic/mmu_context.h for
 no-op implementations
To:     linux-arch@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200826145249.745432-1-npiggin@gmail.com>
        <20200826145249.745432-11-npiggin@gmail.com>
        <4d2bdc87-f39c-3737-0aa8-b2efe7b2d93e@monstr.eu>
        <1598940875.v2bbea400c.astroid@bobo.none>
        <2daa0a52-5e48-8078-cfeb-bd8ff29cc992@xilinx.com>
In-Reply-To: <2daa0a52-5e48-8078-cfeb-bd8ff29cc992@xilinx.com>
MIME-Version: 1.0
Message-Id: <1598944138.dirzqy8hof.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Michal Simek's message of September 1, 2020 4:41 pm:
>=20
>=20
> On 01. 09. 20 8:15, Nicholas Piggin wrote:
>> Excerpts from Michal Simek's message of September 1, 2020 12:15 am:
>>>
>>>
>>> On 26. 08. 20 16:52, Nicholas Piggin wrote:
>>>> Cc: Michal Simek <monstr@monstr.eu>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>> ---
>>>>  arch/microblaze/include/asm/mmu_context_mm.h | 8 ++++----
>>>>  arch/microblaze/include/asm/processor.h      | 3 ---
>>>>  2 files changed, 4 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/micro=
blaze/include/asm/mmu_context_mm.h
>>>> index a1c7dd48454c..c2c77f708455 100644
>>>> --- a/arch/microblaze/include/asm/mmu_context_mm.h
>>>> +++ b/arch/microblaze/include/asm/mmu_context_mm.h
>>>> @@ -33,10 +33,6 @@
>>>>     to represent all kernel pages as shared among all contexts.
>>>>   */
>>>> =20
>>>> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_s=
truct *tsk)
>>>> -{
>>>> -}
>>>> -
>>>>  # define NO_CONTEXT	256
>>>>  # define LAST_CONTEXT	255
>>>>  # define FIRST_CONTEXT	1
>>>> @@ -105,6 +101,7 @@ static inline void get_mmu_context(struct mm_struc=
t *mm)
>>>>  /*
>>>>   * We're finished using the context for an address space.
>>>>   */
>>>> +#define destroy_context destroy_context
>>>>  static inline void destroy_context(struct mm_struct *mm)
>>>>  {
>>>>  	if (mm->context !=3D NO_CONTEXT) {
>>>> @@ -126,6 +123,7 @@ static inline void switch_mm(struct mm_struct *pre=
v, struct mm_struct *next,
>>>>   * After we have set current->mm to a new value, this activates
>>>>   * the context for the new mm so we see the new mappings.
>>>>   */
>>>> +#define activate_mm activate_mm
>>>>  static inline void activate_mm(struct mm_struct *active_mm,
>>>>  			struct mm_struct *mm)
>>>>  {
>>>> @@ -136,5 +134,7 @@ static inline void activate_mm(struct mm_struct *a=
ctive_mm,
>>>> =20
>>>>  extern void mmu_context_init(void);
>>>> =20
>>>> +#include <asm-generic/mmu_context.h>
>>>> +
>>>>  # endif /* __KERNEL__ */
>>>>  #endif /* _ASM_MICROBLAZE_MMU_CONTEXT_H */
>>>> diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze=
/include/asm/processor.h
>>>> index 1ff5a82b76b6..616211871a6e 100644
>>>> --- a/arch/microblaze/include/asm/processor.h
>>>> +++ b/arch/microblaze/include/asm/processor.h
>>>> @@ -122,9 +122,6 @@ unsigned long get_wchan(struct task_struct *p);
>>>>  #  define KSTK_EIP(task)	(task_pc(task))
>>>>  #  define KSTK_ESP(task)	(task_sp(task))
>>>> =20
>>>> -/* FIXME */
>>>> -#  define deactivate_mm(tsk, mm)	do { } while (0)
>>>> -
>>>>  #  define STACK_TOP	TASK_SIZE
>>>>  #  define STACK_TOP_MAX	STACK_TOP
>>>> =20
>>>>
>>>
>>> I am fine with the patch but I pretty much don't like that commit
>>> message is empty and there is only subject.
>>> With fixing that you can add my:
>>> Acked-by: Michal Simek <monstr@monstr.eu>
>>=20
>> Thanks for the review, will do. Any suggestion for a useful commit messa=
ge?
>=20
> What about?
> Wire asm-generic/mmu_context.h to provide generic empty hooks for arch
> code simplification.

Sure I'll add it.

Thanks,
Nick
