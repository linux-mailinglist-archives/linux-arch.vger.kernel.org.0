Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0A258994
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgIAHui (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgIAHud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 03:50:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E55C061244;
        Tue,  1 Sep 2020 00:50:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u20so348849pfn.0;
        Tue, 01 Sep 2020 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=jx4ijV48pwkIXlEWTCV3kDv1viRliVSaJ9ejxp3xhoM=;
        b=Gu+J64Tks9uYyPaMRIQ/8V2pHoO5Lffox20RipKXlRjHDaPSkNEA9w/P9gzP7tuiXC
         pqFcnhhXZHsX6nGtN/2hA+LrfaCqvjyhkaMz+JsgD8pvANzp+gZpwrMlINQf3wKGWLoi
         RLl6DdPsasJ8DfrRa3440bJk1+NyvyXYJHyOH1VIUF2mTmtRFopcolxtdJFRV06xeC03
         e+1WzE3ACXeKt2eqqaee4n3luLhIUXd2Ury98fv7hy5SO7K5VMeoK/vhITl3WUAEOlxy
         KSDsVXYY/RBz6VHjcUD7DoDCk001RSF2ObOP3LSXqfol9qzhEECJszREEsFEzSypJxqp
         XQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=jx4ijV48pwkIXlEWTCV3kDv1viRliVSaJ9ejxp3xhoM=;
        b=KA4RFrbgfdtrYtOgWTGydN2Ekk9GW7r6Let1QBV+JawC4yonQxxI7AmqAp9tWri3EK
         C5Ew2DjUx5sV+tol3F3aKe9BcXcO6vYLq0eSBsdkBooqVIEoJFWGQQTb2Xzr/Pd/Vqdr
         npGyO1gglgcS+Kl4MofzUBISIA0YyU9Gkqi2+i69EXSVm6PrXJGzMWi57aWBPE7RPLL4
         Az0luwsDqvi25h/msUsTriFjbUfcm+0fkJrgNLDXPetgReAn2kadtqgw51MqLkqlPjGP
         oMM7Jx3vxekyeQGq5KJM466s/QiXy3zDlfRzbtv+GT4/xU0LHXdWpOPB16mZnKI+iD/2
         S4Xw==
X-Gm-Message-State: AOAM531zWHfFynOslqaaQ5jNOq+qWcx3+Vr07uZcfMyW92FazuH21Lux
        T+O6flFvmDvu2cJrR1EqQes=
X-Google-Smtp-Source: ABdhPJySDrdLwU7jnwyr/UTlWsUOS+xFQepQCqThWcvpUucdNdxugC+OL2ioqTY/JTHWg9DOYbezpg==
X-Received: by 2002:a63:4c57:: with SMTP id m23mr439797pgl.77.1598946631169;
        Tue, 01 Sep 2020 00:50:31 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id s1sm1171322pgh.47.2020.09.01.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 00:50:30 -0700 (PDT)
Date:   Tue, 01 Sep 2020 17:50:24 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 09/23] m68k: use asm-generic/mmu_context.h for no-op
 implementations
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>
References: <20200826145249.745432-1-npiggin@gmail.com>
        <20200826145249.745432-10-npiggin@gmail.com>
        <CAMuHMdX5qo+2XpEm5QNbuwWRn508Ewee9rHYtmCBadj0x=3VnA@mail.gmail.com>
        <1598941313.t5y1w43jgl.astroid@bobo.none>
        <CAMuHMdWfACYhp8434GOx0qx2oHSBTX3Tq+=gtqNtYahnP-t1JQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWfACYhp8434GOx0qx2oHSBTX3Tq+=gtqNtYahnP-t1JQ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1598945161.7wv2e8mu4h.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Geert Uytterhoeven's message of September 1, 2020 5:03 pm:
> Hi Nick,
>=20
> On Tue, Sep 1, 2020 at 8:23 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>> Excerpts from Geert Uytterhoeven's message of August 27, 2020 7:33 pm:
>> > On Wed, Aug 26, 2020 at 4:53 PM Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> >> Cc: linux-m68k@lists.linux-m68k.org
>> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> >
>> > With the below fixed:
>> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> >
>> >> --- a/arch/m68k/include/asm/mmu_context.h
>> >> +++ b/arch/m68k/include/asm/mmu_context.h
>> >> @@ -79,19 +76,6 @@ static inline void switch_mm(struct mm_struct *pre=
v, struct mm_struct *next,
>> >>         set_context(tsk->mm->context, next->pgd);
>> >>  }
>> >>
>> >> -/*
>> >> - * After we have set current->mm to a new value, this activates
>> >> - * the context for the new mm so we see the new mappings.
>> >> - */
>> >> -static inline void activate_mm(struct mm_struct *active_mm,
>> >> -       struct mm_struct *mm)
>> >> -{
>> >> -       get_mmu_context(mm);
>> >> -       set_context(mm->context, mm->pgd);
>> >> -}
>> >
>> > Assumed switch_mm() in [PATCH v2 01/23] is revived with the above body=
.
>>
>> I'm not sure what you mean here. We can remove this because it's a copy
>> of switch_mm above, and that's what the new header defaults to if you
>> don't provide an active_mm.
>=20
> IC.  I thought it started relying on <asm-generic/mmu_context.h> for this=
,
> where you removed switch_mm().
>=20
> Seems I missed the definition above.

It's supposed to all build incrementally, I'll try to make sure it's
right...

>=20
>> Patch 1 should not have changed that, it should only affect the nommu
>> architectures (and actually didn't touch m68k because it was not using
>> the asm-generic/mmu_context.h header).
>=20
> OK. Sorry for the noise.

No problem thanks for looking at it.

Thanks,
Nick
