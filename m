Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935A639EBCC
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 04:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFHCQm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 22:16:42 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:44921 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHCQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 22:16:42 -0400
Received: by mail-pl1-f174.google.com with SMTP id b12so3805568plg.11;
        Mon, 07 Jun 2021 19:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=GN9OGsGoM5q2Wj6TkWBVaSNZ3ULcmdL6q8p7m1JsxfU=;
        b=KAKRqeqM/EnW/4UM54P+A9EJlb7HswqJaBECriEWn06A6AuPmgEhw53v2jNqs2UbU8
         +ipemHkdCeJ7hZf8DGPXqrGtSQiaUtrrBKnBPdJgYjyVozFXY41ptb5hYLJGLFvhNTev
         ewFaadk+5/gEhStXYpHg6FCtpMK8RgPstlt/1eAppeKlIpE6yPI9Bb4/UIxrHHPu8c2w
         X5/UbsWQsJ4ttdYqBvk9F53mVXHLXCMepOcCypsou/dkksQrag3RLdK7s6a5G5G5JjOS
         lXcVAZaZzBjqUyLDv8FhAI9Arq44OUf5eOICCTpZBJt15aYY9+zUAww9XM7MKW8Xp3eo
         AhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=GN9OGsGoM5q2Wj6TkWBVaSNZ3ULcmdL6q8p7m1JsxfU=;
        b=tIXleNer3+m6lVYGFf7AkKKolqRztf3754SA//6ZpAMkjYvMAbSGREHrjRKUUDrS3J
         NVHWOTG2yNYSSDFQmVaa5moFU32JCMTCoKzkSyxxOeOnIfGznl1eQmHMQmu1SjmmkMO8
         GugBD7DAcgsfyLBU/lQ0kDzbIJX4heU+6rzvbikajp4y/l/YTDAJF7l3fqGC3nqSQei+
         1+hlhDnrXOiRhFAodHW4XKtSSTvKrmP/Eu22/bhYRtlWvMrdeNqFN3FaC6q40x7vyJdT
         cfhjQ/v8SclpuCvy6phCSou1KrS+/XfxD5SNJwGV3HCjlkgWiVRgicmzw4c2RZj+0CHd
         dkhQ==
X-Gm-Message-State: AOAM533RPLvtK7775Z/r5TnfByvpZfshiLtT03q4HIKX1A47530CGo48
        HA35mgymA3niIM8xXRF4fnQ=
X-Google-Smtp-Source: ABdhPJwZostydn6bgzgZ5hc0R5uUZONrVbm87sBVNdPt/3RpSMRkRRnU2eGY1TzJGbBSLvRxXRgFUA==
X-Received: by 2002:a17:90a:ff12:: with SMTP id ce18mr23452289pjb.215.1623118430063;
        Mon, 07 Jun 2021 19:13:50 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id r92sm637379pja.6.2021.06.07.19.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 19:13:49 -0700 (PDT)
Date:   Tue, 08 Jun 2021 12:13:44 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 4/4] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-5-npiggin@gmail.com>
        <20210607165241.4dcd4cf63f96437c5650d179@linux-foundation.org>
In-Reply-To: <20210607165241.4dcd4cf63f96437c5650d179@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1623116405.kj57caxq27.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andrew Morton's message of June 8, 2021 9:52 am:
> On Sat,  5 Jun 2021 11:42:16 +1000 Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> On a 16-socket 192-core POWER8 system, a context switching benchmark
>> with as many software threads as CPUs (so each switch will go in and
>> out of idle), upstream can achieve a rate of about 1 million context
>> switches per second. After this patch it goes up to 118 million.
>=20
> Nice.  Do we have a feel for the benefit on any real-world workloads?

Not really unfortunately. I think it's always been a "known" cacheline,
it just showed up badly on will-it-scale tests recently when Anton was
doing a sweep of low hanging scalability issues on big systems.

We have some very big systems running certain in-memory databases that=20
get into very high contention conditions on mutexes that push context
switch rates right up and with idle times pretty high, which would get
a lot of parallel context switching between user and idle thread, we
might be getting a bit of this contention there.

It's not something at the top of profiles though. And on multi-threaded
workloads like this, the normal refcounting of the user mm still has
fundmaental contention. It's tricky to get the change tested on these
workloads (machine time is very limited and I can't drive the software).

I suspect it could also show in things that do high net or disk IO rates
(enough to need a lot of cores), and do some user processing steps along
the way. You'd potentially get a lot of idle switching.

>=20
> Could any other architectures benefit from these changes?
>=20

The cacheline is going to bounce in the same situations on other archs,=20
so I would say yes. Rik at one stage had some patches to try avoid it
for x86 some years ago, I don't know what happened to those.

The way powerpc has to maintain mm_cpumask for its TLB flushing makes it
relatively easy to do this shootdown, and we decided the additional IPIs
were less of a concern than the bouncing. Others have different concerns,
but I tried to make it generic and add comments explaining what other
archs can do, or possibly different ways it might be achieved.

Thanks,
Nick
