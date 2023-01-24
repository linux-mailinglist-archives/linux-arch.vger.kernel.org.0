Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE07B678EE6
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jan 2023 04:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjAXDQm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 22:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjAXDQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 22:16:42 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB633466
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 19:16:41 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl3so13447350plb.8
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 19:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGZG93eiXRk22TOPDmFZGXGIOl8nFjO4bOBcCBu5uW8=;
        b=irnAgSykIWbmg9WdpxuRyMCuC9r6EUakDFGK2nhjUH6ns5CB7glOvHSr+w8WdAmM74
         d4VSceT9xSlPEdFgWxtfyT4x81AG5eDXp8YSQSRMxmMvd+0gHAWp9hwb3v6K2I6O8LHx
         +xS/v2NL+vLtzBZaF7XFRPnR598DoWxZIRk95P8lWODo91fsUYHmTkuEnx+mbpHZzRiX
         RmFt/pZPihavSWUDUJvkUs2DVsuNAb7Ao7kog/4VqsKUo9i4zW/9NuCtEkr3W6gAJiIU
         b226eHn4FvJCFMMMySsSGi6Enl3ZscnElE1NS9TjLXundxfkTXoNQsKAzsitrOMN6Q00
         +e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bGZG93eiXRk22TOPDmFZGXGIOl8nFjO4bOBcCBu5uW8=;
        b=g+q34uaCj8AlBr9TdIURZyWTWbyvQXCXBW3jS9Vo/S7zWsJhAQJ9fbOPcc9Xc8Nmqk
         EEIbp9yIJD6TLKJOy7a4j2VfihrIFDHkWL5M084/Qg/s8NXLCkc2NozAO7rnJSEVY+u1
         Y/8R/ciVmR2Ut8ViR7wixXGGn9gSpVZSl/NPdCwbNfjNp+x5xpQ0eJED5Na+mSc1vZs2
         PfqSZXqkyVucB/MHv2qyAlO1+X/Ixcd1lT5OSbz0O0aJMGmUs5quLmSEDXtI1dfgVCxJ
         FCJZmyEWdJBbkTzGhTydrz6GYM7gyzbK60Zqtk7LX6841aoGzxvWq+4+wlqpgz2yD74p
         hvQQ==
X-Gm-Message-State: AFqh2kr46RGq+glpFDHoeB3jjF3/nCqG0YYuuM7cvM4Ww8wq9OO8Dpg3
        MJFZ8oPn2m9RPIHvAIT7DBQXeW9s1n58qA==
X-Google-Smtp-Source: AMrXdXskD2W7zrNiaiZ6X+Pl5+Tp/VgiW0zZf5Jhb6BD28XXzBRcQy84AtLhiISjIw0wPIJMdQLWJA==
X-Received: by 2002:a05:6a21:9101:b0:ad:db18:6d0d with SMTP id tn1-20020a056a21910100b000addb186d0dmr27460888pzb.59.1674530200792;
        Mon, 23 Jan 2023 19:16:40 -0800 (PST)
Received: from localhost (121-44-64-35.tpgi.com.au. [121.44.64.35])
        by smtp.gmail.com with ESMTPSA id p5-20020a170903248500b00189a50d2a3esm419719plw.241.2023.01.23.19.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 19:16:39 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 24 Jan 2023 13:16:34 +1000
Message-Id: <CQ03EVK32Y3F.3QPL2RUNVGILM@bobo>
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
 <CPVVOWQ6SE2S.NQ3R9R77MFKI@bobo>
 <e8fac6e0-487f-37c3-5be4-19518ffa845e@gmail.com>
In-Reply-To: <e8fac6e0-487f-37c3-5be4-19518ffa845e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon Jan 23, 2023 at 6:16 PM AEST, Nadav Amit wrote:
>
>
> On 1/19/23 6:22 AM, Nicholas Piggin wrote:
> > On Thu Jan 19, 2023 at 8:22 AM AEST, Nadav Amit wrote:
> >>
> >>
> >>> On Jan 18, 2023, at 12:00 AM, Nicholas Piggin <npiggin@gmail.com> wro=
te:
> >>>
> >>> +static void do_shoot_lazy_tlb(void *arg)
> >>> +{
> >>> +	struct mm_struct *mm =3D arg;
> >>> +
> >>> + 	if (current->active_mm =3D=3D mm) {
> >>> + 		WARN_ON_ONCE(current->mm);
> >>> + 		current->active_mm =3D &init_mm;
> >>> + 		switch_mm(mm, &init_mm, current);
> >>> + 	}
> >>> +}
> >>
> >> I might be out of touch - doesn=E2=80=99t a flush already take place w=
hen we free
> >> the page-tables, at least on common cases on x86?
> >>
> >> IIUC exit_mmap() would free page-tables, and whenever page-tables are
> >> freed, on x86, we do shootdown regardless to whether the target CPU TL=
B state
> >> marks is_lazy. Then, flush_tlb_func() should call switch_mm_irqs_off()=
 and
> >> everything should be fine, no?
> >>
> >> [ I understand you care about powerpc, just wondering on the effect on=
 x86 ]
> >=20
> > Now I come to think of it, Rik had done this for x86 a while back.
> >=20
> > https://lore.kernel.org/all/20180728215357.3249-10-riel@surriel.com/
> >=20
> > I didn't know about it when I wrote this, so I never dug into why it
> > didn't get merged. It might have missed the final __mmdrop races but
> > I'm not not sure, x86 lazy tlb mode is too complicated to know at a
> > glance. I would check with him though.
>
> My point was that naturally (i.e., as done today), when exit_mmap() is=20
> done, you release the page tables (not just the pages). On x86 it means=
=20
> that you also send shootdown IPI to all the *lazy* CPUs to perform a=20
> flush, so they would exit the lazy mode.
>
> [ this should be true for 99% of the cases, excluding cases where there
>    were not page-tables, for instance ]
>
> So the patch of Rik, I think, does not help in the common cases,=20
> although it may perhaps make implicit actions more explicit in the code.

If that's what it does, then sure. IIRC x86 didn't used to work that way
long ago, but you would know what it does today. You might find it
doesn't need much arch change to work. OTOH Andy has major problems with
active_mm and some other x86 use-after-free weirdness that that I wasn't
able to comprehend. He'll be naking x86 implementation until that's all
cleaned up so better try to understand what's going on with that first.

Thanks,
Nick
