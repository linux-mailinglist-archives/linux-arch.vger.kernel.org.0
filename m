Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22202587ED
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 08:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgIAGP2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 02:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAGP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 02:15:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6544C0612A3;
        Mon, 31 Aug 2020 23:15:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so141964pgl.3;
        Mon, 31 Aug 2020 23:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Sd4E4Z/MpNGbX5x3P4fOAUXrOsysWLUN6bwhYnFl+mQ=;
        b=nMoXu3Qo0+bs7gWrd8KAo4W2329cg+qL8/bEFl0PfjVHqSlGk2dsJJAg+NE6/N6ELI
         hSuqy6tqBU8SE///Fe37mgUETOeba7abQGH52wDw0CJ/aaC+65AbgLG0Y1+nNkOkuGz+
         m81/nmW3phJTX7yThOEzxrvPdXE1GBe1hCelxjihF5a9XEAwycy8N2oJhf3v2hAEeqF4
         5VD2bEK96UHgA9zLnJq3GoVWVeOx/kvHNFDGOhDjwo863j1KWcPaVj1u79bW0InuTMsu
         Ub6xOhPmQ1D4tEXJDRaqzkyBy+N9eE7GnSzrL9RF/vuj9J3Jt5S2fbQoVbAfOqFEs0Wf
         hFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Sd4E4Z/MpNGbX5x3P4fOAUXrOsysWLUN6bwhYnFl+mQ=;
        b=NEd5Lc9rq00zDUeXmug2fo0KzJwgjxBdkGhzAkSMNJ7xO2HKf4Nl0M4S2wf1Uek0Ao
         pWiCLSdig+ea333j9NINHoy3tTxhQ0rBmVzLs3Cyl3JFvywXn1bNSFO1GhsVReZoVM+A
         MdyVPf6Qg55MrAXB1qB9IC+Jbsi7Im4jYejL+hCLBS6L/usuQ3wYs/RcovACQ01DrlRr
         LE+5j1Z12/s5NjbnSwwvFYVsWhuVpnakR6G5RYNZW/hXTxrIZrBMfKCwcxIdLgpQSCL8
         JAyGzYiHXILKj4E3JtVY1v9ISKxaWdLlMpiTuDiuYCTbo9GKbkT4olQtjogExCOs04t4
         eY4w==
X-Gm-Message-State: AOAM532jzMGDYNKTBCZN69Z96NiLKowB4UI9b+YWH2oPWk1vdF78XzTr
        XiESoFdNXpP9wBI49HNSHs17vqPr7fk=
X-Google-Smtp-Source: ABdhPJzfAPJ+0iytHhGYqTIBnKfvcUDOg4PLgFVUaWo9Zvzz9AEdNSibHf3+lDy936GiI3w6YIzM5w==
X-Received: by 2002:a63:595a:: with SMTP id j26mr208330pgm.406.1598940927149;
        Mon, 31 Aug 2020 23:15:27 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id r33sm580518pgm.75.2020.08.31.23.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 23:15:26 -0700 (PDT)
Date:   Tue, 01 Sep 2020 16:15:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 10/23] microblaze: use asm-generic/mmu_context.h for
 no-op implementations
To:     linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Simek <michal.simek@xilinx.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
        <20200826145249.745432-11-npiggin@gmail.com>
        <4d2bdc87-f39c-3737-0aa8-b2efe7b2d93e@monstr.eu>
In-Reply-To: <4d2bdc87-f39c-3737-0aa8-b2efe7b2d93e@monstr.eu>
MIME-Version: 1.0
Message-Id: <1598940875.v2bbea400c.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Michal Simek's message of September 1, 2020 12:15 am:
>=20
>=20
> On 26. 08. 20 16:52, Nicholas Piggin wrote:
>> Cc: Michal Simek <monstr@monstr.eu>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/microblaze/include/asm/mmu_context_mm.h | 8 ++++----
>>  arch/microblaze/include/asm/processor.h      | 3 ---
>>  2 files changed, 4 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microbl=
aze/include/asm/mmu_context_mm.h
>> index a1c7dd48454c..c2c77f708455 100644
>> --- a/arch/microblaze/include/asm/mmu_context_mm.h
>> +++ b/arch/microblaze/include/asm/mmu_context_mm.h
>> @@ -33,10 +33,6 @@
>>     to represent all kernel pages as shared among all contexts.
>>   */
>> =20
>> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_str=
uct *tsk)
>> -{
>> -}
>> -
>>  # define NO_CONTEXT	256
>>  # define LAST_CONTEXT	255
>>  # define FIRST_CONTEXT	1
>> @@ -105,6 +101,7 @@ static inline void get_mmu_context(struct mm_struct =
*mm)
>>  /*
>>   * We're finished using the context for an address space.
>>   */
>> +#define destroy_context destroy_context
>>  static inline void destroy_context(struct mm_struct *mm)
>>  {
>>  	if (mm->context !=3D NO_CONTEXT) {
>> @@ -126,6 +123,7 @@ static inline void switch_mm(struct mm_struct *prev,=
 struct mm_struct *next,
>>   * After we have set current->mm to a new value, this activates
>>   * the context for the new mm so we see the new mappings.
>>   */
>> +#define activate_mm activate_mm
>>  static inline void activate_mm(struct mm_struct *active_mm,
>>  			struct mm_struct *mm)
>>  {
>> @@ -136,5 +134,7 @@ static inline void activate_mm(struct mm_struct *act=
ive_mm,
>> =20
>>  extern void mmu_context_init(void);
>> =20
>> +#include <asm-generic/mmu_context.h>
>> +
>>  # endif /* __KERNEL__ */
>>  #endif /* _ASM_MICROBLAZE_MMU_CONTEXT_H */
>> diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/i=
nclude/asm/processor.h
>> index 1ff5a82b76b6..616211871a6e 100644
>> --- a/arch/microblaze/include/asm/processor.h
>> +++ b/arch/microblaze/include/asm/processor.h
>> @@ -122,9 +122,6 @@ unsigned long get_wchan(struct task_struct *p);
>>  #  define KSTK_EIP(task)	(task_pc(task))
>>  #  define KSTK_ESP(task)	(task_sp(task))
>> =20
>> -/* FIXME */
>> -#  define deactivate_mm(tsk, mm)	do { } while (0)
>> -
>>  #  define STACK_TOP	TASK_SIZE
>>  #  define STACK_TOP_MAX	STACK_TOP
>> =20
>>=20
>=20
> I am fine with the patch but I pretty much don't like that commit
> message is empty and there is only subject.
> With fixing that you can add my:
> Acked-by: Michal Simek <monstr@monstr.eu>

Thanks for the review, will do. Any suggestion for a useful commit message?

Thanks,
Nick
