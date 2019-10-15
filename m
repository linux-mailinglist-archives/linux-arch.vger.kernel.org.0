Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA7D82AC
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfJOVtE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 17:49:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42597 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfJOVtE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 17:49:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so21793009lje.9
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wItDXbX3LEWoTo1/kp4dk8aeAZ/2xJzKQP/tyONQ97k=;
        b=hzBYiXjPBdQglMHyHwZdH7Hfwgp8qRgeHE6/0plo981vFS0npABggAoHWs92Y0M4j4
         6yInWWbjRDRm/aBcc9LUQovQyVPjXs9u2abaLNMMyRfQw3SRznL+/RbI8WTdojuOz1np
         +b80D6JSR28AZDW+EGzyd7AudQJVj7qyOksd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wItDXbX3LEWoTo1/kp4dk8aeAZ/2xJzKQP/tyONQ97k=;
        b=RTFXyUlu7lVJtveK0cEcABRWBs9YyofKkIOkxqq3LIzWcuFio38NQqVHF0SavQkrAe
         M7mM8pR7YUdIao/ZDbQ7k8Bwt083Gqqx9eomHvyNHSXQpZQ5YbOBZsbDEpkXSWyBb+rA
         DfQf0HabyFUqxGpFOOaN/KrmiT9QT1MfSgzFat8WwvYlsugcceVRDn85eI8NbDUPBhtW
         gZZmI3lDE4Au6+5g6r0JHJ0sOdlZqxXWvtck42VBDM7rfuLbbS5c88GqrGPvNo3+JmkZ
         lsiEWN8rA8qWAUzcS45yxfzAf4RMCd0i0cLYfzBvUhZzKlHV5LOuULzt3cl1BTNTu6xI
         Bk6Q==
X-Gm-Message-State: APjAAAXh9k8EN5JfEFJSndEvyyOrYyXnX1dvWrP06NJEGP3SBf8cFzIy
        NBJ7YiTnJx9Y/jT6QCSPipvd/D3UvGA=
X-Google-Smtp-Source: APXvYqxjHdvt2eoWtufThjJ8/RgrM0iqrGZh7MD3m33qihyPA0VB/OKPuis6QUUUkq3Qt01WMcZW3g==
X-Received: by 2002:a2e:8204:: with SMTP id w4mr23819585ljg.3.1571176141201;
        Tue, 15 Oct 2019 14:49:01 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j84sm5643371ljb.91.2019.10.15.14.48.59
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 14:48:59 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c195so15669600lfg.9
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:48:59 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr4137650lfe.106.1571176138790;
 Tue, 15 Oct 2019 14:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191926.9281-1-vgupta@synopsys.com> <20191015191926.9281-2-vgupta@synopsys.com>
In-Reply-To: <20191015191926.9281-2-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 14:48:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3QC7tj3rmTPg5RmK_ugVKYs-jKqX=TaASWfd73Owaig@mail.gmail.com>
Message-ID: <CAHk-=wi3QC7tj3rmTPg5RmK_ugVKYs-jKqX=TaASWfd73Owaig@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This is a non-functional change anyways since ARC has software page walker
> with 2 lookup levels (pgd -> pte)

Could we encourage other architectures to do the same, and get rid of
all uses of __ARCH_USE_5LEVEL_HACK?

            Linus
