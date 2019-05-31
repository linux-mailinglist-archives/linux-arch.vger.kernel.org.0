Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED2314C5
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfEaSbP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 14:31:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38814 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfEaSbP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 14:31:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id o13so10533207lji.5
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OI/XkyWscYGF3A6q2jZ5I5FXRspFschNtLNhVlAhmaA=;
        b=XIhW5QA8Xo4JHcGzA63mCXQV36Thq0SGB3HcmpD47Io+dSV1aXANbYc5EtOg1o2Na5
         cP5NY7zZZbPkTEogRr8MiiyM9Ejv2cDEHDIstDA9/aCsb2qtbSu3Kdt3sDl/vlELdHbK
         jAm3CuPDjICN+xqs//OTC5MWMsJRG2G18ibag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OI/XkyWscYGF3A6q2jZ5I5FXRspFschNtLNhVlAhmaA=;
        b=jkBjqD4SBroZkDQVmZQ8tv9VnDY2Cmta4UekOlv7uZsOvfH33uxYYmU2XJkkAyUhbx
         tPQbIdT4MmgNz4uTNfqxHAf4FekD+1KPIJUja+iNeL62Y5KG3FMd7Mv1orE24Wk01NYq
         hJj5wOyEvdeDEVSGKJPxHJwf0mmlghPJQY34chYoEi/+hPCKVFKERBjDmKW5YnJ9ZAER
         UPG8tRAx5ui6ePS3NOqOH704siUrrMKErNfc0xxCgG+bzQViNeqiF/0cTmWzWH9hlXfx
         tiprd+4JBlNtxZ7iK8sMcQCkxBVP5eu6xDMI6l5EgCnXcUW9InDop81ieQ40XFqCwcmy
         qYzA==
X-Gm-Message-State: APjAAAU8giPR1ro2/fNeU0IwP4aBYdrGzkhUf5xX2V41+TC7TqWBPKdk
        Y4O+GJNI5fiAuabogADf+OGFAynZyhM=
X-Google-Smtp-Source: APXvYqyt/DnRcbhOfSdguxt/yjFtUPO05+ZzPJ5FK0z+ewR0pX9H/nj7eE3Pi7X6mIdMj+nFHSeWZw==
X-Received: by 2002:a2e:864e:: with SMTP id i14mr6742542ljj.141.1559327472963;
        Fri, 31 May 2019 11:31:12 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y2sm1315542lfc.35.2019.05.31.11.31.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 11:31:12 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id h19so10534271ljj.4
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 11:31:11 -0700 (PDT)
X-Received: by 2002:a2e:914d:: with SMTP id q13mr6747997ljg.140.1559327471592;
 Fri, 31 May 2019 11:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190528120453.27374-1-npiggin@gmail.com>
In-Reply-To: <20190528120453.27374-1-npiggin@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 May 2019 11:30:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHWqVPWMeNRYuxAd8xnZscshoXUP8SFPmJivJfds5-HQ@mail.gmail.com>
Message-ID: <CAHk-=whHWqVPWMeNRYuxAd8xnZscshoXUP8SFPmJivJfds5-HQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/large system hash: use vmalloc for size >
 MAX_ORDER when !hashdist
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Toshi Kani <toshi.kani@hp.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 28, 2019 at 5:08 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The kernel currently clamps large system hashes to MAX_ORDER when
> hashdist is not set, which is rather arbitrary.

I think the *really* arbitrary part here is "hashdist".

If you enable NUMA support, hashdist is just set to 1 by default on
64-bit, whether the machine actually has any numa characteristics or
not. So you take that vmalloc() TLB overhead whether you need it or
not.

So I think your series looks sane, and should help the vmalloc case
for big hash allocations, but I also think that this whole
alloc_large_system_hash() function should be smarter in general.

Yes, it's called "alloc_large_system_hash()", but it's used on small
and perfectly normal-sized systems too, and often for not all that big
hashes.

Yes, we tend to try to make some of those hashes large (dentry one in
particular), but we also use this for small stuff.

For example, on my machine I have several network hashes that have
order 6-8 sizes, none of which really make any sense to use vmalloc
space for (and which are smaller than a large page, so your patch
series wouldn't help).

So on the whole I have no issues with this series, but I do think we
should maybe fix that crazy "if (hashdist)" case. Hmm?

                   Linus
