Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1824E38A
	for <lists+linux-arch@lfdr.de>; Sat, 22 Aug 2020 00:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHUWmr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgHUWmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 18:42:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6BC061573;
        Fri, 21 Aug 2020 15:42:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so1430724pjr.0;
        Fri, 21 Aug 2020 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=4UWlKWRwFhMMQv4f/JDXmRT+IPsV6O51XHRajg1UNPE=;
        b=p7LCpJWhWXdAx14JgK9TDLJJ3BCvufZbmghRyHVQLMM0vpPRzQq3iDkxgW+5B2M8Fr
         TZjTY1SBBZ5eRzY2WIrfka7rQfiLpRXq/DXb2rpBQ+pfzVWBHZx50fKSz9oVqrlsclkk
         DfcOtMu4MHaLkKhfCyYyrR/ZqL+GKNv8V5ESRlW++QX72hA8d7MOA5UxxSbDEMvckjm2
         oJAwLvOw7f6jQF9dr5YdN0vs8KCf5DkGkL1irNYBf3a0WocvL+APIsazA5tedsv8U3WK
         JHV9yWGMZVp5FTd+wR4YZHJfGjbC5amLwRi0zjCmvUkC6Y4hPphjuXzaTdTDm9MKbST7
         WhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=4UWlKWRwFhMMQv4f/JDXmRT+IPsV6O51XHRajg1UNPE=;
        b=TrPhX5kO6vzGfPOa2FpoHQZ9Z6jlozkdxnTvh71KQRGR+Bpy20/MuoyYj0jH7cen+r
         vl2dFGOvTCkEPDI9382YhPPU9Q69GxAgMqpHfpcExdZB4c+86Wp5LxZiqJUPmQN3+T/U
         DTbud/FpXHOzfnTpeHvC92p9ieCXep/8dRKIISVlreHHNTbhUnZwjHr7eCkJiP1zGb+a
         A3c342K59VD94u7w5746pTiV/WtJFSB7KZh1QDHhp+E1zWttc2H+7GKvtSA2Ql/TsUfQ
         sZ1SE7Wui9zGLouSg8IqcfV3eG2s2p1vWsYyq+H4NBzuSZwob26ljMmjvPzujH2I/KUC
         hyrA==
X-Gm-Message-State: AOAM533eW/9T37zmrkzbyAO4+QwuWiKFHloRb4qHrRXUgmX9NJEbldK5
        orSfPJzXbGVzL8ySWySsLJs=
X-Google-Smtp-Source: ABdhPJzyk5gtyaEQvYqdChTxy/Co2Lk+Pe4/qWzCnpygMz9yMFZCgfiZ1vuBUvB8wjDn5B/HdIgtuA==
X-Received: by 2002:a17:902:b081:: with SMTP id p1mr4122273plr.195.1598049766139;
        Fri, 21 Aug 2020 15:42:46 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id z126sm3602084pfc.94.2020.08.21.15.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:42:45 -0700 (PDT)
Date:   Sat, 22 Aug 2020 08:42:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 01/12] mm/vmalloc: fix vmalloc_to_page for huge vmap
 mappings
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
        <20200821151216.1005117-2-npiggin@gmail.com>
        <20200821130757.289570e4bb491672087d3396@linux-foundation.org>
In-Reply-To: <20200821130757.289570e4bb491672087d3396@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1598049375.u9pf1rciw6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andrew Morton's message of August 22, 2020 6:07 am:
> On Sat, 22 Aug 2020 01:12:05 +1000 Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
>> Whether or not a vmap is huge depends on the architecture details,
>> alignments, boot options, etc., which the caller can not be expected
>> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.
>=20
> I assume this doesn't matter in current mainline?
> If wrong, then what are the user-visible effects and why no cc:stable?

I haven't heard any reports, but in theory it could cause a prolem. The
commit 029c54b095995 from the changelog was made to paper over it. But
that was fixed properly afterward I think by 737326aa510b.

Not sure of the user visible problems currently. I think generally you
wouldn't do vmalloc_to_page() on ioremap() memory, so maybe callilng it
a regression is a bit strong. _Technically_ a regression, maybe.

Thanks,
Nick
