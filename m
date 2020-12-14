Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6382D9233
	for <lists+linux-arch@lfdr.de>; Mon, 14 Dec 2020 05:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgLNEIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Dec 2020 23:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLNEIV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Dec 2020 23:08:21 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30CEC0613D3;
        Sun, 13 Dec 2020 20:07:41 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t37so11600105pga.7;
        Sun, 13 Dec 2020 20:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=PWh+Vdx5/CQGyHUaGmwrxc21bpz+T3vvjsxDr9do1W0=;
        b=jBTloPwFVdlwdlyZC+hyxpB8boEXRewMRO9QCB0wjdmJOmvQb80Ek4uI5dvhIFgIUN
         wSKp+HV+IHGiktwJA1TU+TMZf+X7ZRlOLvK0X4IEYwtvStmIsH2unXn4Ek85lTmYj0eP
         Wnr1x3fWaGpVL1qqbaasFyRoQxNoWidjeeDS7jMm6BIAgHEljWpEp0mJGpKO26gbxkPN
         jD3d4spmbJmrIjKKZ+IzejsU0bowKWdXcuMRD/DC2XuOsVdrFbv4SMYpMXeiX8rw5r5N
         KY3WPknXhjPc5qPpz7J7VoDsQVWeQTs7DhT73S/0wyCEWsVGzZ1wMh0Esl6ayKxhsjZe
         pGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=PWh+Vdx5/CQGyHUaGmwrxc21bpz+T3vvjsxDr9do1W0=;
        b=tPRFa7othU/S2Gt3niHTX+kLCg4pERyFg+K/ekaO7O0JuGNgGEPxKdx7yJBCxWy/ay
         ipYKvhgCjVafZmifTLG2NqjIdsabsME4nQWj3pysGPVqQkD3ATmpVby0lGP7vY9jjvSd
         AUJuE3jjtPyGrPiY3Gj1ag9kTHnJ+O+3OYzIUN7Zr3TH7wU/ifCs9fLPJAiV2QeAIOzG
         ejyinW1RzcVJ9Xz7fi1B9EOnmFNo+vVl8HIVofj6N3aHXdphvI5IqQJ+Tr1fWOx9Adem
         6acJrbO6JyH17nw3GPQ5VNOays/dCuaiu0JzIp+nz/ne/WgeWOV3/YQ1ZSguaMevSr1d
         aH2A==
X-Gm-Message-State: AOAM533EjpP4hOjygM1c0ow5E81FypaK8XfGylmAkI6epyy+0kg4EKn5
        3wy3CzTvlMcd/pgKP8z9d9Q=
X-Google-Smtp-Source: ABdhPJyIyQ6qEDAOiugwK5Wi7/4KOuz1OqcXosU9vwHYM/fnFbs9BdwPCBgfN29SdfYCrzjFH+R7Vw==
X-Received: by 2002:a62:6c2:0:b029:19e:b63a:91e9 with SMTP id 185-20020a6206c20000b029019eb63a91e9mr18792139pfg.79.1607918861170;
        Sun, 13 Dec 2020 20:07:41 -0800 (PST)
Received: from localhost ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id 37sm14724169pjz.41.2020.12.13.20.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 20:07:40 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:07:27 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <1607152918.fkgmomgfw9.astroid@bobo.none>
        <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
        <1607209402.fogfsh8ov4.astroid@bobo.none>
        <CALCETrWFjOXAd5=ctX3tzgUbyfwM+bT-f8WY_QWOeuDdFxhWbg@mail.gmail.com>
        <1607224014.8xeujbleij.astroid@bobo.none>
        <CALCETrV5BzXuUYm5YAoEKPZZPfLrbHckvwBHzWKrxZS8hqzHEg@mail.gmail.com>
In-Reply-To: <CALCETrV5BzXuUYm5YAoEKPZZPfLrbHckvwBHzWKrxZS8hqzHEg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1607918323.6muyu2l982.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of December 11, 2020 10:11 am:
>> On Dec 5, 2020, at 7:59 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>=20
>> I'm still going to persue shoot-lazies for the merge window. As you
>> see it's about a dozen lines and a if (IS_ENABLED(... in core code.
>> Your change is common code, but a significant complexity (which
>> affects all archs) so needs a lot more review and testing at this
>> point.
>=20
> I don't think it's ready for this merge window.

Yes next one I meant (aka this one for development perspective :)).

> I read the early
> patches again, and I think they make the membarrier code worse, not
> better.

Mathieu and I disagree, so we are at an impasse. I addressed your=20
comment about not being able to do the additional core sync avoidance=20
from the exit tlb call (you can indeed do so in your arch code) and=20
about exit_lazy_tlb being a call into the scheduler (it's not) and
about the arch code not being able to reconcile lazy tlb mm with the
core scheduler code (you can).

I fundamentally think the core sync is an issue with what the membarrier
/ arch specifics are doing with lazy tlb mm switching, and not something
the core scheduler needs to know about at all. I don't see the big
problem with essentially moving it from an explicit call to=20
exit_lazy_tlb (which from scheduler POV describes better what it is=20
doing, not how).

> I'm not fundamentally opposed to the shoot-lazies concept,
> but it needs more thought and it needs a cleaner foundation.

Well shoot lazies actually doesn't really rely on that membarrier
change at all, it just came as a nice looking cleanup so that part
can be dropped from the series. It's not really foundational.

Thanks,
Nick
