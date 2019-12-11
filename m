Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372F111ABDE
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfLKNTY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 08:19:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44003 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbfLKNTY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 08:19:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id x14so13159817oic.10;
        Wed, 11 Dec 2019 05:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTkf+Ktwg9EN62GCiWaT7c0zhgnuyXYMKB3RnMBCoH0=;
        b=qaqPMo7c+hmeAmnEKMDJUOJRDrqPaNj7opPLMgqOLJ0B1+DnXGIWne+DDaC8Pxas+4
         d5kvnqRa+q3Ap83QPW7i5ouBwdFT6OSKJBv5Jq/OnLMQRZRMKN8NcUGeYplYgn89eE3H
         Kk68ZCrYjTMEBk1or2ymCb0sGAi9QLxZ1Xj5nOVmbaI/JBgE9i/n2NWBfMqUTtNCKY+N
         O4ni448Kx1lO9zDKvExK/ZAC/XzvVNFUHtd2++pwQh1rz/DIFO38IskGqldlLV5jEmyI
         8/ZqSgv7ZTl8SLBUuNdWXJZpcAv4hzCPVtEjYmVz6Rs8Jn8VH+QIssGKLP/k9gPXF+SU
         OGMQ==
X-Gm-Message-State: APjAAAU/3YZsVXZi//VxOtXorqGq6JtpUPfIWVoWkAnICUDRUKJ5ENhG
        RTiwz6oHIS1NFSnvK2Yk2QwlQvquM/jIeJr0TMo=
X-Google-Smtp-Source: APXvYqyE6D637ZfRt9JtwXbrAhQRetOOxev9A7WV3C24h2T4AFLlyRgkWlO82BfFotgCVrPUvj4kVl1vMdhmVhEfkDc=
X-Received: by 2002:aca:36c5:: with SMTP id d188mr2823451oia.54.1576070363144;
 Wed, 11 Dec 2019 05:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20191211120713.360281197@infradead.org> <20191211122955.769069740@infradead.org>
In-Reply-To: <20191211122955.769069740@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Dec 2019 14:19:11 +0100
Message-ID: <CAMuHMdUA-Bj+q4g2NimMv3nnu5v=X81BEkoSgUTOTLG+rsPK4g@mail.gmail.com>
Subject: Re: [PATCH 02/17] asm-gemeric/tlb: Remove stray function declarations
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 1:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> We removed the actual functions a while ago.
>
> Fixes: 1808d65b55e4 ("asm-generic/tlb: Remove arch_tlb*_mmu()")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
