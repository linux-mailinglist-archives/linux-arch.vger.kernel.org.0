Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE01A7A75
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 14:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439958AbgDNMPW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgDNMPT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 08:15:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6DC061A0C;
        Tue, 14 Apr 2020 05:15:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r4so5912589pgg.4;
        Tue, 14 Apr 2020 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=WHNX39DWF5Hlf3u8CwKDc+Fsn/bhcoFrdGg2YrrvOo0=;
        b=YPCaSFzn0oIdss6PgqWqExMDv2Ya4MqFKlIMtqX30ds70r7RnGgcscEiuorDHOmIxt
         bkg/vokkN/rRhBD6LJ9mw3mjhOahMg1Uwg9Qx2UNZFWTj0IMg9WnUDxB+ULJSCbA1ldn
         KSpVK42kxhB9z/aw0NH4UBeJI+KqGuxcHQoEPZCHcqOEDmAKdAwLZgWjuAma+5C/4TbG
         JmUnZp5MHDPoBd4ygsIhvDZ8ijEsX/e2wJi1VmDzroDN1oJ8TnkuqyUyr4ayZCZKIFK0
         GcKo9BxipK0dpFhF+pZwLrt75E6HD72Q17JUhc4ZADldaZQrqxB3dU1lD6phiCSp3nG2
         3WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=WHNX39DWF5Hlf3u8CwKDc+Fsn/bhcoFrdGg2YrrvOo0=;
        b=YBYS45sJ7ypatJRpv4s/T2c+nXi2fCmSxhDLYPnkTW627qjLBZ7HLRFT9haK9u/MfG
         4BOaTPgvM0qbey/PbNkFwjnwS2MecToI5OXy54qxKxBVoa79X32W5b6kIMYDoz3Mv3pI
         q68PwV/ORPGuxRQBF4BA086idEwV5WIBsdzJzNTR/wE+Ag0JCFTdx+10qsowAbBX2hR7
         A78zxkUnL37sWoLPJ0A9buYQiL3iNv4l3Ny/mrRs0KFomQQ/YKJ6EnwO686hpI0bRNa3
         aKzvz4VZuQG5yV362mOpVtRQ2zP7DsF9K5jR+gcpoNIvKIbBvtpWRHihgb7JInZuvStU
         4Bgw==
X-Gm-Message-State: AGi0Pua6lulmws6TDsoYrDK92i/dHHSqJ26cXq6ayZ5m/1GBvcNnJpkU
        F9ZgxuqyYov6OQDk9ILmdv8=
X-Google-Smtp-Source: APiQypIal3O38c4Mqwm4P9dpr8g1+GmgXzDHXceCqIscl9w/plzTRFxfjFtpP2vU89kIf2d05y9VAA==
X-Received: by 2002:a63:1820:: with SMTP id y32mr11205009pgl.182.1586866517492;
        Tue, 14 Apr 2020 05:15:17 -0700 (PDT)
Received: from localhost ([203.18.28.220])
        by smtp.gmail.com with ESMTPSA id h11sm10999819pfn.125.2020.04.14.05.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 05:15:16 -0700 (PDT)
Date:   Tue, 14 Apr 2020 22:13:44 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <20200414072316.GA5503@infradead.org>
In-Reply-To: <20200414072316.GA5503@infradead.org>
MIME-Version: 1.0
Message-Id: <1586864403.0qfilei2ft.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christoph Hellwig's message of April 14, 2020 5:23 pm:
> On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
>> For platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmap mappi=
ngs,
>> have vmalloc attempt to allocate PMD-sized pages first, before falling b=
ack
>> to small pages. Allocations which use something other than PAGE_KERNEL
>> protections are not permitted to use huge pages yet, not all callers exp=
ect
>> this (e.g., module allocations vs strict module rwx).
>>=20
>> This gives a 6x reduction in dTLB misses for a `git diff` (of linux), fr=
om
>> 45600 to 6500 and a 2.2% reduction in cycles on a 2-node POWER9.
>>=20
>> This can result in more internal fragmentation and memory overhead for a
>> given allocation. It can also cause greater NUMA unbalance on hashdist
>> allocations.
>>=20
>> There may be other callers that expect small pages under vmalloc but use
>> PAGE_KERNEL, I'm not sure if it's feasible to catch them all. An
>> alternative would be a new function or flag which enables large mappings=
,
>> and use that in callers.
>=20
> Why do we even use vmalloc in this case rather than just doing a huge
> page allocation?

Which case? Usually the answer would be because you don't want to use
contiguous physical memory and/or you don't want to use the linear=20
mapping.

> What callers are you intersted in?

The dentry and inode caches for this test, obviously.

Lots of other things could possibly benefit though, other system=20
hashes like networking, but lot of other vmalloc callers that might
benefit right away, some others could use some work to batch up
allocation sizes to benefit.

Thanks,
Nick
