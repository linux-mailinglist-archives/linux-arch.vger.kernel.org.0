Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A341A799A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439313AbgDNLd1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439311AbgDNLdZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 07:33:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02159C061A0C;
        Tue, 14 Apr 2020 04:33:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w3so4552124plz.5;
        Tue, 14 Apr 2020 04:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=KZ+sHNUWTGOOngDZlWZuibRHv6pBV5xa/Uz2LHhglIw=;
        b=VRrPqiVD/QCxdjEBbskkY+yCiShEK6wsEIXtHjLXfpvij1ltRLBYW8NzIJJmPGw7Jl
         7O9rXprSSg2KypN2/n22gPbfrV2ko9yTd5ZQA5X2LQDSyGFUWQu8QBnphH70gUe+/FRK
         5/ysYWz68GwkQi8JYoDLAb1lhU/6pBp5yLlGMV7SiRr2jMJHGt/nW+uAjgiUYV7ycto8
         eFxubCIicj7SXfgr/8LiQbyXdkpfNE6H1TDEa73cP7OLaDzRMX9MMI1VYP3Q3GlNdo69
         gNWUpXzn33RucYnWizv9TVCwAa7EJYfdk5B6bGls6Fic9fwDW2teTKTU4yxceD2TRnfL
         dySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=KZ+sHNUWTGOOngDZlWZuibRHv6pBV5xa/Uz2LHhglIw=;
        b=mBiy8/wAdI2M2+XXMh32TZwhValrMfgMkLY5eQO84F0evBf5al3lHT2GS8Uf/8vKwA
         n3PlW98oUq+nxWucjwGCXe32Ob6skYRKcVYjsO7/e1OjwV9TYNqNTtKXdLG47+iL2ZFs
         Szaiirlo0q/SckrgEPPqqZv2cbnoXUo+VG1v62pVMq3TIdNuNObUZ/4emEY0+ciSPg/5
         Dlq1OKQXUygyk3TsOq5pa+633SNNouKm9wqrohrMTfYX3o6v7KbovmE/rt8IKPAgxUv6
         2EeUaC+qMWlBF7bDVHP4055kSUoymYfBbVtxdeRRhgWurq6N1j5K7mE/iTS7aScX00wC
         wWGQ==
X-Gm-Message-State: AGi0PuZecI8EpWeyRxPbpSw70KbTGhIkt8qMIdmH+59r8mfm27iwJww5
        ySvAO9mJIEfEPYh0JBy1MSc=
X-Google-Smtp-Source: APiQypIcyr6/I0Kkbv3wlFcU4/Xr/0wS9p1hSr/PXKwlPWpCeFL0ysIODdUC3n5T/abK9CdK/6LdFA==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr21744267plk.292.1586864004572;
        Tue, 14 Apr 2020 04:33:24 -0700 (PDT)
Received: from localhost ([203.18.28.220])
        by smtp.gmail.com with ESMTPSA id w2sm11023334pff.195.2020.04.14.04.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 04:33:23 -0700 (PDT)
Date:   Tue, 14 Apr 2020 21:31:49 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/4] mm/vmalloc: fix vmalloc_to_page for huge vmap
 mappings
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-2-npiggin@gmail.com>
        <20200413133444.GM21484@bombadil.infradead.org>
In-Reply-To: <20200413133444.GM21484@bombadil.infradead.org>
MIME-Version: 1.0
Message-Id: <1586863573.ufpx8o7f0i.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Matthew Wilcox's message of April 13, 2020 11:34 pm:
> On Mon, Apr 13, 2020 at 10:53:00PM +1000, Nicholas Piggin wrote:
>> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
>> Whether or not a vmap is huge depends on the architecture details,
>> alignments, boot options, etc., which the caller can not be expected
>> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.
>>=20
>> This change teaches vmalloc_to_page about larger pages, and returns
>> the struct page that corresponds to the offset within the large page.
>> This makes the API agnostic to mapping implementation details.
>=20
> I'm trying to get us away from returning tail pages from various
> functions.  How much of a pain would it be to return the head page
> instead of the tail page?

Well, this is a fix for the interface for HUGE_VMAP stuff so it
doesn't really make sense to change the implementation here. If you
want to change or make a different API that would be a later patch, no?

> Obviously the implementation gets simpler,
> but can the callers cope?  I've been focusing on the page cache, so I
> haven't been looking at the vmalloc side of things at all.

Well callers that operate on ioremap today (and vmalloc tomorrow) won't
cope, because they're expecting a base page. If you wanted to change it
I suspect the way to go would be introduce a new function and move
everyone over individually.

Thanks,
Nick
