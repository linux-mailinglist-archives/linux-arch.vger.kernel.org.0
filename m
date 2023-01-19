Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF8672DB3
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 01:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjASAxS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 19:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjASAxQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 19:53:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5481A4CE6C
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 16:53:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q64so796836pjq.4
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5OwSqaa3k71xkT8WUUyBE4GL1c8ehjEm+lG2U3+ww8=;
        b=VxMM+n7ZQ7ySdPZJagy+lvodZf7Ei6K4cGhxVW6vhCAISwMhETO4P0zAg5TL04X9mG
         so7hd1FvWPuhpb3FnNogypnG+GUvTjMyf29uuxUgkEKMKiKhjWFKZgy7XM+7zlRGbnLM
         XW8EB337vH9O7EDDbXqKRjCsTOjUSBIJYzj9n3ydNn7NDvys/PCYZU4rv+3ZH8698zjJ
         gjaog8MASkt1QYEddmOc4pZ/1fHtFmV0/EHae6jjaC9Tlr2Juoi/5SjXD2FC4l1tgw5X
         xSssM+NTSqUR/rVW3gPshuPqCCXxtCjGCfmoxOxkxaKFRfl3litjPnUrhQfV2nwMz9q0
         bytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O5OwSqaa3k71xkT8WUUyBE4GL1c8ehjEm+lG2U3+ww8=;
        b=CN7OMG4vB+lufilpm6L4c5jfg4D7Xi694z7fgNIkdSdfdNCSL20dGsDpXkpJdqMSNK
         Y/ABg31qp5NHYkp/DLcohg8Qf/E1MoKICXIgBOydSAXGDy990wgdL6GnST1yp3IHJJqb
         b4IIkTpjO1GMjIz3fiZTZ8YxcPL9TwOoAjpQvSoBqCxJmH8nioT7YebOv8MCvMN1ETKo
         qzWaq24U9S2QhUOsAlhgvfORUXBgMBRlT7mKBCGujhsDGAM/gZAECypki2P9GfjTS7OF
         dUtLEdbF57v0uiT4u1vYg93thCviq1NYX313PKiDLnaTBgltjpgPaBwpjhTrSS1786od
         jXTw==
X-Gm-Message-State: AFqh2kpNWiLMo4xrTmXZy+uHRebHokd8E/p+kKd/dAPUs3qwYnCcT4S6
        BEj36zyxDG2a19LCl+fIMio=
X-Google-Smtp-Source: AMrXdXsMSS9dcXgYVyvRoV4FT2tnzvT0wkiLbe+rSWN6jjYwj9dD2M9R08hcXMB91pi0HSAg9oFG6g==
X-Received: by 2002:a17:90a:5a45:b0:229:2bbb:261f with SMTP id m5-20020a17090a5a4500b002292bbb261fmr9919226pji.8.1674089594735;
        Wed, 18 Jan 2023 16:53:14 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090a420b00b002296312adcesm1888963pjg.56.2023.01.18.16.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 16:53:13 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 19 Jan 2023 10:53:08 +1000
Message-Id: <CPVR8BY8XFWE.BF91Z0FOZWH8@bobo>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "linux-arch" <linux-arch@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 3/5] lazy tlb: shoot lazies, non-refcounting lazy tlb
 mm reference handling scheme
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Nadav Amit" <nadav.amit@gmail.com>
X-Mailer: aerc 0.13.0
References: <20230118080011.2258375-1-npiggin@gmail.com>
 <20230118080011.2258375-4-npiggin@gmail.com>
 <5F3590B8-3F25-4EFB-BE3A-D32AAAC0B2F4@gmail.com>
In-Reply-To: <5F3590B8-3F25-4EFB-BE3A-D32AAAC0B2F4@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu Jan 19, 2023 at 8:22 AM AEST, Nadav Amit wrote:
>
>
> > On Jan 18, 2023, at 12:00 AM, Nicholas Piggin <npiggin@gmail.com> wrote=
:
> >=20
> > +static void do_shoot_lazy_tlb(void *arg)
> > +{
> > +	struct mm_struct *mm =3D arg;
> > +
> > + 	if (current->active_mm =3D=3D mm) {
> > + 		WARN_ON_ONCE(current->mm);
> > + 		current->active_mm =3D &init_mm;
> > + 		switch_mm(mm, &init_mm, current);
> > + 	}
> > +}
>
> I might be out of touch - doesn=E2=80=99t a flush already take place when=
 we free
> the page-tables, at least on common cases on x86?
>
> IIUC exit_mmap() would free page-tables, and whenever page-tables are
> freed, on x86, we do shootdown regardless to whether the target CPU TLB s=
tate
> marks is_lazy. Then, flush_tlb_func() should call switch_mm_irqs_off() an=
d
> everything should be fine, no?
>
> [ I understand you care about powerpc, just wondering on the effect on x8=
6 ]

If you can easily piggyback on IPI work you already do in exit_mmap then
that's likely to be preferable. I don't know the details of x86 these
days but there is some discussion about it in last year's thread, it
sounded quite feasible.

This is stil required at final __mmdrop() time because it's still
possible that lazy mm refs will need to be cleaned. exit_mmap() itself
explicitly creates one, so if the __mmdrop() runs on a different CPU,
then there's one. kthreads using the mm could create others. If that
part of it is unclear or under-commented, I can try improve it.

Thanks,
Nick

