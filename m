Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62DB23BABD
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 14:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHDMwS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 08:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHDMwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 08:52:18 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BE6C06174A;
        Tue,  4 Aug 2020 05:52:18 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k12so13627624otr.1;
        Tue, 04 Aug 2020 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=pMO7xyI02u/N3BhtYFkNjauZHH09qS1894eAogsqric=;
        b=dqIg4irnWWoY+Y5RxKJEqmwSgROMfRLLQIvLQwZca2rpKDo+n6etnvAPBYGleJ2+rw
         jBiX/nOfWx/KPTZ+doBnbFLdjLRLYeTh/KC+XddIFecTlCgj3Kz6xWUknyUmLCEZj1pF
         3/yiVCFgroeRsYd+JHeXuLL+PDpZvBTSoyXnk1zINW6r6exODy/+inAb/JZ9SgJA9+Gi
         YMpWh1BkQ1EqMT59UfeO02muIwdsbe/bCllv+ixdsQB+3LNrsSgFNOOhk+nLb/NNAJXc
         mm6zfNBrDtQ09G+t5EP4VXefsJl+NAzUp21zavSkxdQ709N3ZafisgwGqq/DdhpmOuoS
         G/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=pMO7xyI02u/N3BhtYFkNjauZHH09qS1894eAogsqric=;
        b=miZ+VmBXEUKfFTu+ijNYuOna1/VqK1PIElAiqn5MIIfVmQ7ttDtRcJqLb91wqxQJxp
         eGtTabL+VfVbr86ILJjcEFRnGXuxbvqxA//IZIHXAi1WNgr6qORXGVYHChVyMF5XfRzr
         ntLzUsjmAxK0RR3Rn07buw6JezemDKVGzTEijGBO1taXu8xM0ONu/H2zU7Juv7RTIBt/
         NFjCSY2kAX2Dy2aBcJ7EDnOToz7UptSzQbECFjuQwqkQb4rAdjbwdW2IVC7VFztCqN2P
         PjjxS4Npp/r9Ijc9xjIkku8p53V9x3cd7K44HD8ldBLrFp01ysBCe19cHNKQeWRTD2RO
         yXOw==
X-Gm-Message-State: AOAM5306947phWW2hNEfrgOOidBKPsYoW+eRdx03r9ABtMl1hUTGfRqS
        fU6zEbe/KTNYKPSjL3IM5gYH3AfMvelz9rgrEgo=
X-Google-Smtp-Source: ABdhPJwantcnKcYDUuZ2NeqMXi+nkqQYITvuIUuQn8NpTq7Q1pEvWayGqwiPzaoF9nt+Lij6f/xZwIc/mvJLcfV14IM=
X-Received: by 2002:a05:6830:148f:: with SMTP id s15mr16155634otq.323.1596545537578;
 Tue, 04 Aug 2020 05:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
 <c17e330c-69f7-da7a-feae-cb8b8f5d7ea0@gmail.com> <20200720165205.GI30452@arm.com>
 <CAKgNAkggayFEjHgPNu1HzvXGfSDoCq=Y-Ni4iv=RBYk2Eb6U1Q@mail.gmail.com> <20200729145630.GH21941@arm.com>
In-Reply-To: <20200729145630.GH21941@arm.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 4 Aug 2020 14:52:05 +0200
Message-ID: <CAKgNAkhrjuAXOey2Mp64oitqyjyTu1Zbtx0dy5J2-qzpyFf33Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> > >         There is already inconsistency here: there are may top-level
> > >         lists using ".IP *" in prctl.2, and plenty of places where the
> > >         default indentation is used.
> >
> > I must admit that I'm in the process of rethinking bulleted lists, and
> > I have not come to a conclusion (and that's why nothing is said in
> > man-pages(7), and also why there is currently inconsistency).
> >
> > Using .IP with the default indent (8n) results in a very deep indent
> > between the glyph and the text, so it's not my preference.
>
> Is it worth trying to change the default indent in the macro package, or
> will that just upset other people?

I imagine it would break other stuff.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
