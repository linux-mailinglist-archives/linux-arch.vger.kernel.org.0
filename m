Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8764448BBFB
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 01:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbiALAmu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 19:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbiALAmu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 19:42:50 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017FFC06173F
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 16:42:50 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x15so1568047plg.1
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 16:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=nPA/d9GpVAzZlRMdpQ0UK1uHKNH4tM81MZUNkRzDgiQ=;
        b=UESrMGVEIjHiAAuGVWaBatN7/caiK0qTuvYSfayFaTpOQj1aGJT1tk6mlU3bMSTEd+
         KJ7FUFf/Wt5H+Cl9uZwTZPbYbVhst8fco0ylvCpkprofj3Yjyq7/3/FhEPhMi81OMtOl
         vhEERYI0q2qz4QFxiNr72YrBfUloXrXDX14s8P3c2v9SzxaPs1GFNXdcJCWFwQNblgqU
         KNJ17NGZsGV6Y4WGamllapmKiWnMRmCOOGGfaZD5LvTeCAr+YLZ1xJTHBXtnaSJ9nilj
         /GZkfhTcPoajKlf12nk7ySnPcZX5wuNsMj+ZSGNPKyMjM5bn7x3agxN0SOR/zXateqJL
         8elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=nPA/d9GpVAzZlRMdpQ0UK1uHKNH4tM81MZUNkRzDgiQ=;
        b=HWysfXXs7bVvWNZuI0KBVfj6HcRUHqZrwR+wqgyF30AMl0DZq0nqrVHpI6tC3zFekb
         ohLedp6M+kKCW5Q2EYSwtQFPmnI8UM+B509X9qgWeknAdWlZ5DsdoVDuzSU71roJt/GR
         pdiMcF6k2HVwiZfd8VtpoYGI0R+gQ+Ar1CQKNsrrSAOVJn6AdX3aRM9wWae4ru41B63Y
         8u+cTYxgjbwfbT51A5JkJbgAtwAAIUn9Wr0QH8guQ8UPpHtNA31Ch6GAC63yHLHCJAhc
         I3USxfSBVHPUH5AsXwOaQST/ig27Eg6GBlVtBFB8xiS0YqL5X/5UOG0daAu0WCyZKg4n
         73GQ==
X-Gm-Message-State: AOAM5306WPB71io0y4bljOpD+Tx6MOgTbPjQkAbmBUv5KyQT5s7F2tgL
        kTW73VfkFxA/0rFCwjI2Aqo=
X-Google-Smtp-Source: ABdhPJxQqkIW1AimBLkPfmP6lPZ1FBO91GZeJ8nhYStZe8weK5PPHBxLDYb6JWLtsuKp9CU5jB8IVw==
X-Received: by 2002:a63:ae45:: with SMTP id e5mr6295310pgp.476.1641948169473;
        Tue, 11 Jan 2022 16:42:49 -0800 (PST)
Received: from localhost (124-171-74-95.tpgi.com.au. [124.171.74.95])
        by smtp.gmail.com with ESMTPSA id z31sm461361pgl.10.2022.01.11.16.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 16:42:49 -0800 (PST)
Date:   Wed, 12 Jan 2022 10:42:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
To:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
        <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
        <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
        <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
        <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
        <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
        <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
        <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
        <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
        <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
        <1641790309.2vqc26hwm3.astroid@bobo.none>
        <0d905aef-f53c-4102-931f-a22edd084fae@www.fastmail.com>
        <1641867901.xve7qy78q6.astroid@bobo.none>
        <c35e696f-7463-49f6-ab89-793ba2dba6bf@www.fastmail.com>
        <1641939251.s7ciy8cys4.astroid@bobo.none>
In-Reply-To: <1641939251.s7ciy8cys4.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1641946506.hgz759d78c.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of January 12, 2022 8:48 am:
> Anyway I will try to take a look over and review bits I can before the
> 5.18 merge window. For 5.17 my series has been ready to go for a year or
> so and very small so let's merge that first since Linus wants to try go
> with that approach rather than the refcount one.

5.19 and 5.18 respectively.

Thanks,
Nick
