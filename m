Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2754211E9B7
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 19:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfLMSFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Dec 2019 13:05:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43786 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfLMSFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 13:05:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so382439wre.10
        for <linux-arch@vger.kernel.org>; Fri, 13 Dec 2019 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EYduUcDZi5305eYv3iFGbrJoeNChzA396oztTfjBXU=;
        b=Z6qcTDjwl590xiTBev2JIOwenrYEXB53zCVflq2uJiIg3qv1Y9pXnAAZ8WZv8/mbi5
         X0KUBgnta6sFq5Afijzj0YTeDIfXsvC9j24/4+0BSsiuDaf096c1ID9XuihGm2bC0lCH
         iutnIo99KWUoEkaz6vzXVOzJz9WWMkA63FWcn0CpaeIYDX5Yo88LOdRRXYFwSqSJ8S36
         lbHWSDHF3oYzpnHTFfYPkXypPOmtnnDo4cN9a6p48tvFYzTEmGQ7sELy1hAaQWoPN2XV
         2M24u/AfNr7632cMFNo12oBXbt/X0+MrSVvmcen+7LrM173sKJQtNlfIecsOG+UNybBQ
         Imaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EYduUcDZi5305eYv3iFGbrJoeNChzA396oztTfjBXU=;
        b=cAPEwnOwtJVOixPXAGA+ImiILLsr/H/AJtH+eoWaIO0VTKukKAM0W1XFMgJdSA2PJM
         SIYHt3vmMntkBlzCQmvskCZzoJqO+qdRT/Un/Jf8JTXvHXo1GIzVlQtWLB0WbSFp8s/A
         hzGFMDQ0OPrzOwsIdyxDkS4Xtz2dl99q/1dAkJqSTV5pJ3xtJQkmKG9JN6O6wOXx2+ug
         L8JCPVmbIjJ+ZglgO0jA+wZHdeGDFyZhr/YEGRd4g6fZ5xS0y3ugMPM2KfVkLnnL8uL4
         V8oqh2FdX9C3V0nr7aZVFGDY5xiAJCTn21PkzZO4mBhb9dg+8huaP4fv3w2zSlKho8AB
         p67Q==
X-Gm-Message-State: APjAAAX0iEKl9BA+SZcWgIchBhEV7rGWc4k3cuRBrBv7iaJr1G0eLQPC
        09uH2CHyVV1t2PupWY1jzsEUPICifKoQoLgvtx9B7g==
X-Google-Smtp-Source: APXvYqxP7jBF9PnXnDysL/SrUBCGW3Lv4EcU5tUKWTw5jUIPDgtI/jqhKpKkKz3Y5IvwtOULGC1TyfC1kP6l9kY7Leo=
X-Received: by 2002:a5d:4984:: with SMTP id r4mr13660823wrq.137.1576260322155;
 Fri, 13 Dec 2019 10:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 13 Dec 2019 10:05:10 -0800
Message-ID: <CAMn1gO6f4UUdhBe1sfiAPBW=zr-C3ypUv-Pwgx=wvmJjp4xfyA@mail.gmail.com>
Subject: Re: [PATCH 00/22] arm64: Memory Tagging Extension user-space support
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Kortchinsky <kostyak@google.com>,
        Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 10:40 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
> Hi,
>
> This series proposes the initial user-space support for the ARMv8.5
> Memory Tagging Extension [1].

Thanks for sending out this series. I have been testing it on Android
with the FVP model and my in-development scudo changes that add memory
tagging support [1], and have not noticed any problems so far.

> - Clarify whether mmap(tagged_addr, PROT_MTE) pre-tags the memory with
>   the tag given in the tagged_addr hint. Strong justification is
>   required for this as it would force arm64 to disable the zero page.

We would like to use this feature in scudo to tag large (>128KB on
Android) allocations, which are currently allocated via mmap rather
than from an allocation pool. Otherwise we would need to pay the cost
(perf and RSS) of faulting all of their pages at allocation time
instead of on demand, if we want to tag them.

If we could disable the zero page for tagged mappings only and let the
pages be faulted as they are read, that would work for us.

Peter

[1] https://reviews.llvm.org/D70762
