Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461C9258816
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 08:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIAGXx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 02:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgIAGXu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 02:23:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB8C0612AC;
        Mon, 31 Aug 2020 23:23:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so147430pgh.6;
        Mon, 31 Aug 2020 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=RVGLHamJzIsi2NPjK9hiUaVNhWfKazmqgrgVWvgKEHQ=;
        b=u/8xKySagQqUxNK94lZKIgRUUzmd+kNZBlVT095jfGRKwLcRzmv2xy2s+ZfLwXqtgQ
         P7hlJKRJaerCDkgROptY+FHAS8AJhu0ygp1h2yGBnXYlud/cuxQRKHiONIKBwsLFM+og
         FlWBsXuxhVqT+jGhz8HXYTIVtbh0IEYyZbkk7Tn/mjqdwrM5vMaWWmsyXBcrTbQ7TRaN
         LX9pjncHTcPhjUV4VmcHBgASGhV1vXfJTLeu9w3CnuUpS9NMv8/Ao6IdQz/USBEnasNM
         28MPFs47TCVMKdHti+xFDxzFU7yereCiyF8rZamDfG2RvFpYv+QRsdItbsMHgjFkf//P
         +BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=RVGLHamJzIsi2NPjK9hiUaVNhWfKazmqgrgVWvgKEHQ=;
        b=IpUg/uLdYfnot/ADiWVPu/Ftm/E9ReEcnV4PcgdXqunkl4rSqOFpNkujPagtD+4IlD
         uPQvFh92tg0opzGakiAAEGZm4a3e4+wjQVIsvlD2Bq6q8himPAJvMmMTaF8wJ32fYTAt
         3fdSbVe77BhF2tfNQtVUtP2dLlkONjN1w/edNMf8YEECgyR6E5Oty8mCtntDPSFxMWBz
         HvpkE7I9lDgGutVrHFigT3wN1ATouG6wX/iSWLgbLH/a/QOTjRzwt6LDfdwWRp5xwNqb
         bc/5sdhk+WixHe+AhDvFfjF1oqUDOZF0hbdmzJqhJL1L+zOzxXga8JcN8KphL06l/PZI
         SvWg==
X-Gm-Message-State: AOAM531tK/owfL+hbH1NzSRuNVbdPnNsHuE/bKJg8GdN25qVpdU3r2HU
        FZ3xdOwLVH7ks9l2Ww6BKbU=
X-Google-Smtp-Source: ABdhPJxcnRzndGcAWpqS1MuYZXOgZ414SHNOTOUHPUuMitSjLhvCnI030JLXSMoPjWtiVx2ujhJTUw==
X-Received: by 2002:aa7:8c0f:: with SMTP id c15mr432295pfd.284.1598941429288;
        Mon, 31 Aug 2020 23:23:49 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w203sm358260pfc.97.2020.08.31.23.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 23:23:48 -0700 (PDT)
Date:   Tue, 01 Sep 2020 16:23:43 +1000
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
In-Reply-To: <CAMuHMdX5qo+2XpEm5QNbuwWRn508Ewee9rHYtmCBadj0x=3VnA@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1598941313.t5y1w43jgl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Geert Uytterhoeven's message of August 27, 2020 7:33 pm:
> On Wed, Aug 26, 2020 at 4:53 PM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: linux-m68k@lists.linux-m68k.org
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> With the below fixed:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
>> --- a/arch/m68k/include/asm/mmu_context.h
>> +++ b/arch/m68k/include/asm/mmu_context.h
>> @@ -79,19 +76,6 @@ static inline void switch_mm(struct mm_struct *prev, =
struct mm_struct *next,
>>         set_context(tsk->mm->context, next->pgd);
>>  }
>>
>> -/*
>> - * After we have set current->mm to a new value, this activates
>> - * the context for the new mm so we see the new mappings.
>> - */
>> -static inline void activate_mm(struct mm_struct *active_mm,
>> -       struct mm_struct *mm)
>> -{
>> -       get_mmu_context(mm);
>> -       set_context(mm->context, mm->pgd);
>> -}
>=20
> Assumed switch_mm() in [PATCH v2 01/23] is revived with the above body.

I'm not sure what you mean here. We can remove this because it's a copy
of switch_mm above, and that's what the new header defaults to if you
don't provide an active_mm.

Patch 1 should not have changed that, it should only affect the nommu
architectures (and actually didn't touch m68k because it was not using
the asm-generic/mmu_context.h header).

Thanks,
Nick
