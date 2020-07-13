Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0666821D77B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgGMNrY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgGMNrX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 09:47:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF19AC061755;
        Mon, 13 Jul 2020 06:47:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so6052206pgh.3;
        Mon, 13 Jul 2020 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=mRbOWPWSQUmvbKy0Vhub198si/9PqoOoJ0fQEFD1GNw=;
        b=CtIxbjVvQWa4NtOA2BUa9bC75CZlL25vYzXPl0w/DuaxfU7K7Mef69GwIEcJ/9v5p6
         OyTNMFwhm1f7HQM2uGsZmLP6xjXBKRuhMQ9hjYqV97z8vDpzvMPKqVrCZulwKV7l0ws5
         K3UvPYHj/ywEJNqexpv9wcG57oWMcuiEgeUfm8PlVDi9B4tbFzDLz+RsIOz47QLajLgr
         bl4VArfJGMgjlFM+VPivRlfKklIGQka+bNxVx5kmcekxM4Un3QInWNH/VVOGvCzsetup
         O936Idv00TK0lxrJMmpDZv2HzgcR7mQsgOx8oeQ7xRjaoRoTVDzsffuYhhhu9CHwevtT
         ptHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=mRbOWPWSQUmvbKy0Vhub198si/9PqoOoJ0fQEFD1GNw=;
        b=lgNHXKOJ8zllkJIzBxx24sq0d5JyWO8mQocRF1uwr3MCWPv36+rO6Y0R5KiQS1eVZ3
         GMBq8h/LIgnWSWX5RfKL9Fp1brO3OaFyjXFmtypdKaAqI9EgGlhjr7XYA6hEzczwvAkm
         JS+TNDP3kqhx1b2t925k0RhCOqrgiFuyhhBRQmU4RXSYNjo12qN6HpZaQtZIvvAGiWQh
         AMKiTbQ85zfw98hE8KxI1S2F77+A6TT/bnAvQvq7BBXMXoN8gFaYlBJz9vHluetVN2fy
         46LP1rvCADxawynHnf9B7a3lpkkyd1M08XZ3ZZZTKPNz/H2flTJZ6TKAzrlkGQnEmTCA
         +6ug==
X-Gm-Message-State: AOAM530J2fmChkXtmDXFPrQV/h2/aW1ZYyPQNr6LbnU9yrQcLI5Jkdps
        AwhjzxhUKUqRJJlZ8JjE9bY=
X-Google-Smtp-Source: ABdhPJy5mkqYezxWFiByUdDFyfgS7gHSAPhE+WWD7boFv7QO+6zf4EAUVlnl8xvc6AjqSYD9L+nxnA==
X-Received: by 2002:a63:e057:: with SMTP id n23mr67589534pgj.368.1594648043180;
        Mon, 13 Jul 2020 06:47:23 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id h15sm15368954pjc.14.2020.07.13.06.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:47:20 -0700 (PDT)
Date:   Mon, 13 Jul 2020 23:47:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <20200710015646.2020871-5-npiggin@gmail.com>
        <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
        <1594613902.1wzayj0p15.astroid@bobo.none>
In-Reply-To: <1594613902.1wzayj0p15.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1594647408.wmrazhwjzb.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>> serialize.  There are older kernels for which it does not promise to
>> serialize.  And I have plans to make it stop serializing in the
>> nearish future.
>=20
> You mean x86's return from interrupt? Sounds fun... you'll konw where to=20
> update the membarrier sync code, at least :)

Oh, I should actually say Mathieu recently clarified a return from
interrupt doesn't fundamentally need to serialize in order to support
membarrier sync core.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-July/214171.html

So you may not need to do anything more if you relaxed it.

Thanks,
Nick
