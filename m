Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64FB25315E
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgHZOda (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgHZOdM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:33:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03748C061574;
        Wed, 26 Aug 2020 07:33:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j11so979120plk.9;
        Wed, 26 Aug 2020 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=AygPhIRiiTHUpr1pkdw/du88lBepQF3siyg0s1NHteQ=;
        b=ZAui/jR/CwDpdtAKBUQOn6w/6EFshzTWU77n6wX1/tw2IAXE4Bb3QkFkgJCLRShaV5
         utLegFIfttO2Gx0mEoLOLG2pvCgjQsIN4PY2NyY1+gNbrxMBy+DMr54xvJWl/mdEBVPr
         QgxanJkkq9C/N2//qQ5L6N76Ha86ET2/i7M6iPWNJjuTjcgrLyzcBCYHhyIi9y/KuMUg
         i1vMV+D8JvrJfbwTFGCai1OUyyLXF8Iqc2vUsPaKwnSC+oGJw/rYpPpYzW+QXSmlUvI1
         pRN7yV0OMoNKOnrR0hAI/1nuDxkb9cYfJTTOjkQhqozkAfsPPWe1NBWBXhKmSD8d1c37
         uitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=AygPhIRiiTHUpr1pkdw/du88lBepQF3siyg0s1NHteQ=;
        b=Wr67VZp23NEhvIHih+yioxfy6IMXqiKNmmXvyP5iMZti8z0dsdY+/euInw6PvKuWw3
         Ft05yQE71xC53p4wftG0MSrNF+SuAMlJL2PtBWmFTJAPsesUy9NboGPNBRGeTX37TGLz
         Eb4KsFraq9M0pJBMT1xL7+05Gukrad7S+HF2TWJy2lxn6046L1pLvIhKLDtwXNgcPLr8
         JazM4Lp6CilcFwpNjVnlsYO35QWuHwqWkXi3kjPeWBcceiw+muolQp0TETNPW809lpCI
         vJ3cWAE+T+r4VakKj8PsHKphg++nBNoe8xAe0poJRA+CgWx5MD5w7aTPcyH+vZxQBOMa
         BZJw==
X-Gm-Message-State: AOAM530hVGv0BFQKPPFp+76qCQ4GuOKmSz4TK0o43JhcnPPWd6YpLREW
        vxTn96MWN89ytVKh+BPt46E=
X-Google-Smtp-Source: ABdhPJxZdzZq9AvbLwTQl7LVD5O/slshPyqOTFJ84mHYa5luHRCEvJImAFN6vU1uDUdJELgynVfgLQ==
X-Received: by 2002:a17:90b:4c84:: with SMTP id my4mr6193251pjb.213.1598452391561;
        Wed, 26 Aug 2020 07:33:11 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id a19sm3208848pfn.10.2020.08.26.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:33:10 -0700 (PDT)
Date:   Thu, 27 Aug 2020 00:33:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 14/24] openrisc: use asm-generic/mmu_context.h for no-op
 implementations
To:     Stafford Horne <shorne@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, openrisc@lists.librecores.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
References: <20200728033405.78469-1-npiggin@gmail.com>
        <20200728033405.78469-15-npiggin@gmail.com>
        <20200729114554.GG80756@lianli.shorne-pla.net>
In-Reply-To: <20200729114554.GG80756@lianli.shorne-pla.net>
MIME-Version: 1.0
Message-Id: <1598452354.xwvdyvp4t6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Stafford Horne's message of July 29, 2020 9:45 pm:
> On Tue, Jul 28, 2020 at 01:33:55PM +1000, Nicholas Piggin wrote:
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>> Cc: Stafford Horne <shorne@gmail.com>
>> Cc: openrisc@lists.librecores.org
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/openrisc/include/asm/mmu_context.h | 8 +++-----
>>  arch/openrisc/mm/tlb.c                  | 2 ++
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/arch/openrisc/include/asm/mmu_context.h b/arch/openrisc/inc=
lude/asm/mmu_context.h
>> index ced577542e29..a6702384c77d 100644
>> --- a/arch/openrisc/include/asm/mmu_context.h
>> +++ b/arch/openrisc/include/asm/mmu_context.h
>> @@ -17,13 +17,13 @@
>> =20
>>  #include <asm-generic/mm_hooks.h>
>> =20
>> +#define init_new_context init_new_context
>>  extern int init_new_context(struct task_struct *tsk, struct mm_struct *=
mm);
>> +#define destroy_context destroy_context
>>  extern void destroy_context(struct mm_struct *mm);
>>  extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>  		      struct task_struct *tsk);
>> =20
>> -#define deactivate_mm(tsk, mm)	do { } while (0)
>> -
>>  #define activate_mm(prev, next) switch_mm((prev), (next), NULL)
>> =20
>>  /* current active pgd - this is similar to other processors pgd
>> @@ -32,8 +32,6 @@ extern void switch_mm(struct mm_struct *prev, struct m=
m_struct *next,
>> =20
>>  extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fa=
ult.c */
>> =20
>> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_str=
uct *tsk)
>> -{
>> -}
>> +#include <asm-generic/mmu_context.h>
>=20
> This looks ok.
>=20
>>  #endif
>> diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
>> index 4b680aed8f5f..821aab4cf3be 100644
>> --- a/arch/openrisc/mm/tlb.c
>> +++ b/arch/openrisc/mm/tlb.c
>> @@ -159,6 +159,7 @@ void switch_mm(struct mm_struct *prev, struct mm_str=
uct *next,
>>   * instance.
>>   */
>> =20
>> +#define init_new_context init_new_context
>>  int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>>  {
>>  	mm->context =3D NO_CONTEXT;
>> @@ -170,6 +171,7 @@ int init_new_context(struct task_struct *tsk, struct=
 mm_struct *mm)
>>   * drops it.
>>   */
>> =20
>> +#define destroy_context destroy_context
>>  void destroy_context(struct mm_struct *mm)
>>  {
>>  	flush_tlb_mm(mm);
>=20
> I don't think we need the #define's in the .c file.  Do we?

You're right, I fixed that and the same issue in another arch.

Thanks,
Nick
