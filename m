Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79736A7A6
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbfGPLrf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 07:47:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46483 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbfGPLre (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 07:47:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id c73so8984772pfb.13;
        Tue, 16 Jul 2019 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=qPnqoEfs2c2FJiT2itcjWmfJK1RsKaw7z2dBi7iQTJ8=;
        b=GWz4yv38B5GHtENqY4vKofVQ91e0o/Wf3To5Ps1dYZG0HD5Ek2EHO2Dc7Ow7eTInF8
         6V2Ylge8TO9m/bByMpQYgvAJMrZvdG3hSLoe3le3WrAf4DJkafN2xpBGM8XjRxts22Wl
         fwEiPyHbfrkm6UMLSuHMn/gd7z8YK8aSErG8WB+A5roIC5O0ZPZ/6GMpagTh5qiyB+K7
         yG6MrQ7ON432Xy90IZVQ3KnMcyWz9iH91bIQQjqhHjYLmAxiZwGFc9kDORakmYFFow9m
         dvKHxsEKn/ChfEWmG3TrgmHbJEuO1ziKFvpkOF6Z/rwgSAH09LcgUIkZ09KBkugy6xrh
         5rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=qPnqoEfs2c2FJiT2itcjWmfJK1RsKaw7z2dBi7iQTJ8=;
        b=FYjnDJAGC0Fe1sK3mfdTuwoQu6n+wYawoYMDkkDkDTyW4gQfMOMQEPb/r+njILVWZf
         vGHsIc+W/T8ju1c7ZcR9J7K0smEOQKXfBuHpsa64R7TZFOph9Et6JefZkKH+HUUP0LlY
         QrwghaDQBKBr+DYW30XnnEYwu+d8h2JxezEDv+lp/+HYIeNs5XMDpyqqPGwaf4HvDia/
         1BH0jhBseU8mkVoJnxPPR3Bv4hHwpNIkbLXfPUxWQInmUGy1AHOseM9G2rPFBRXAH0Iz
         4SssO3aB3jLXNRnBSsZA4X5D7QS47U9JebNeR4eZ98KfBuqvEXnH9QshjZEIudgnMegc
         QRQg==
X-Gm-Message-State: APjAAAVNVv9FWeTUauqAoZB4Y2UZRN9xXgeoIvtDnUMk0VsYES4wePr/
        e+643g7tgAg1qVO8NFOUXIQ=
X-Google-Smtp-Source: APXvYqzHZwrzaDAsguaX2IsIyUiWc2RXpFglPckISYDzHT896XmmxWdI422IRFIGhq+LtZkupLz2ig==
X-Received: by 2002:a63:60a:: with SMTP id 10mr2299610pgg.381.1563277654138;
        Tue, 16 Jul 2019 04:47:34 -0700 (PDT)
Received: from localhost ([203.220.8.141])
        by smtp.gmail.com with ESMTPSA id t10sm19804313pjr.13.2019.07.16.04.47.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 04:47:33 -0700 (PDT)
Date:   Tue, 16 Jul 2019 21:47:27 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/5] Add NUMA-awareness to qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, arnd@arndb.de, bp@alien8.de,
        guohanjun@huawei.com, hpa@zytor.com, jglauber@marvell.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, will.deacon@arm.com, x86@kernel.org
Cc:     daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com, steven.sistare@oracle.com
References: <20190715192536.104548-1-alex.kogan@oracle.com>
In-Reply-To: <20190715192536.104548-1-alex.kogan@oracle.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563277166.m9swqogbqb.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Alex Kogan's on July 16, 2019 5:25 am:
> Our evaluation shows that CNA also improves performance of user=20
> applications that have hot pthread mutexes. Those mutexes are=20
> blocking, and waiting threads park and unpark via the futex=20
> mechanism in the kernel. Given that kernel futex chains, which
> are hashed by the mutex address, are each protected by a=20
> chain-specific spin lock, the contention on a user-mode mutex=20
> translates into contention on a kernel level spinlock.=20

What applications are those, what performance numbers? Arguably that's
much more interesting than microbenchmarks (which are mainly useful to
help ensure the fast paths are not impacted IMO).

Thanks,
Nick
=
