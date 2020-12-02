Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E62CBFE8
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgLBOjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 09:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLBOjA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 09:39:00 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA63C0613D6
        for <linux-arch@vger.kernel.org>; Wed,  2 Dec 2020 06:38:14 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t7so881946pfh.7
        for <linux-arch@vger.kernel.org>; Wed, 02 Dec 2020 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2Fs7ai24DqkxtxArlzcoZyYT9VSvAAqY62xWW9SRJew=;
        b=Aqhw72HvwohUbOEi6rnKx9BddRB1CRUmPb2IMo1f4RmfGdCYe9u3D9NZMkRb5cU1z9
         LISZNoxZulsQN7YNMxLulCsAlKJOEQMKvvLepnYWweR/W8SfB45Oo+TxQCszPAHqrh5i
         CZVyU1HG1zQ7hcGKGrg29b/R262ttz0hQUkFOMg1ueTdqNO+383GrXT+zmcLFDoGR62C
         0WZlSNYpAfDgthqkbWr8bv7YVQBwj69qk36lnk770I4oA/ch2+oTwFY3Puqa/hkPiIcx
         AeUdypd4eqCRKXmdISsemrQKK2dBXuA4WNpYgABbMDy6tsRZjyQptpkHLMmFEMqy8I9M
         utMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2Fs7ai24DqkxtxArlzcoZyYT9VSvAAqY62xWW9SRJew=;
        b=VRLY0MHWR3n9E6cd9fb1kr8uGm1zmxMUwsA7gX8qoyaYVLlGtLqd77tGyO0k5r8BHq
         9YFnbO0TZMnoH0Q6H0HCmS6+wPBCt1w4VxBEd94GFsU4kT4DOYz7DSKwHCUApElwuclf
         vNu269Sw35qzbaFlFeBBQVMGJdrUqQvd0+6Tx3IBteX+XNNFXiZzKggvYb5JwQGOxSOi
         BPydF/SniLXT7O9j6PEVjve9XCaLJHc//IF/IbxHNRBc8vevkAI/9VAvfEGwroBcek8R
         S98QW6diAvT1U+eBubCLy/B2o2qUlp8VCrW2AsSrWubyw9qy/1ga5nxmmTyL2L72f+NN
         /dNQ==
X-Gm-Message-State: AOAM533z4GlPigNcQdWovDZWp9GmrmLBytNGqpEAg4Uepxn0IiEFMn3O
        z2WfSqQoe/KtcZ8qQGI5oNCVfA==
X-Google-Smtp-Source: ABdhPJwaO8pUqbasz2rROJKI5S5GnLlk3tolWP+I1H3Ly/oqX6s2LQgHUDIB7w1VUr6E/FfWpXKIQQ==
X-Received: by 2002:a62:2ec3:0:b029:197:6ca1:2498 with SMTP id u186-20020a622ec30000b02901976ca12498mr2880584pfu.32.1606919893717;
        Wed, 02 Dec 2020 06:38:13 -0800 (PST)
Received: from [192.168.0.122] (c-67-180-165-146.hsd1.ca.comcast.net. [67.180.165.146])
        by smtp.gmail.com with ESMTPSA id x5sm20050pjr.38.2020.12.02.06.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 06:38:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date:   Wed, 2 Dec 2020 06:38:12 -0800
Message-Id: <BA2FB4C0-55EA-481A-824C-95B94EA29FAB@amacapital.net>
References: <20201202141957.GJ3021@hirez.programming.kicks-ass.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>
In-Reply-To: <20201202141957.GJ3021@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Dec 2, 2020, at 6:20 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFOn Sun, Nov 29, 2020 at 02:01:39AM +1000, Nicholas Piggin wrote:
>> +         * - A delayed freeing and RCU-like quiescing sequence based on
>> +         *   mm switching to avoid IPIs completely.
>=20
> That one's interesting too. so basically you want to count switch_mm()
> invocations on each CPU. Then, periodically snapshot the counter on each
> CPU, and when they've all changed, increment a global counter.
>=20
> Then, you snapshot the global counter and wait for it to increment
> (twice I think, the first increment might already be in progress).
>=20
> The only question here is what should drive this machinery.. the tick
> probably.
>=20
> This shouldn't be too hard to do I think.
>=20
> Something a little like so perhaps?

I don=E2=80=99t think this will work.  A CPU can go idle with lazy mm and no=
hz forever.  This could lead to unbounded memory use on a lightly loaded sys=
tem.

