Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90732690
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2019 04:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfFCCWD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Jun 2019 22:22:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45563 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfFCCWD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Jun 2019 22:22:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so9650643pfm.12
        for <linux-arch@vger.kernel.org>; Sun, 02 Jun 2019 19:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=7g16riKDY5MbDiEYTVuQSGlACMGxDSo3Q56OAwRGRyg=;
        b=Y0YVjjCC8r6200gOkyvDgfSivB+jO6RZyJ98Gr3c8rQNsJR8EOsghAoQ4nPaimM1Tg
         F9kMgPBK19Ehe28uiOMq2yl27iB+z16iJ0+jo0lYtPChQxG2yvFkak6uIyqHzt3krawr
         v8IuGXeBtAOfR0D0IY4Ue34Iq2RmV8KQSZUlOb1qSMP9Vpnzkd9AapWl6zuJi/IwNdY+
         8xAhbg5QYeeE5xaCsgtnaoIyuhO4tgAQTSPsyMtpNoiJAW1vp4W2Bs0A+f3KBuiA4+Jp
         L9JS6fO1eTWa+9jMxQU8167mFdI3eqp0UofbRLQ+15+r5knECtwQyirqubEJDq83hfG6
         DxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=7g16riKDY5MbDiEYTVuQSGlACMGxDSo3Q56OAwRGRyg=;
        b=VAHwelp7wWeZMNs+uOvYHbUoNBsmFm2hbjCwloSYH5yDiJk9zhu6tg+DYGHIQb6W2Z
         N4WnGeBlRvLApVXsdExTqMpKyJqkJikw2/fJntT04HWwNmqTQ363VLt3hQ0OZ9suX8am
         lJ8725277rkoCs7WJ2J1zeGPxv1A6D9eqfYKn4qDIIxX+c4QzVwzPU7Ef2ceHp1n0IKP
         ptGa06wTfd9MniQ4C8fkqYo28spw7CxkWqYsh+VoSemD+JN+BV4WbOf17iX+fmOJug0d
         afjZTx3ks79CWvMi/3/YszB6V4U936wnNDUEvDkowB1rZdWQenauxo+8uSFI5ON+WPQL
         w23g==
X-Gm-Message-State: APjAAAW6Aiv+k7dIf762dgT9CQHDhqfmhwuZSI7PG2R8ikIi/JA0Acfd
        MAuNjYKqz71pm7M+5MmCAg4=
X-Google-Smtp-Source: APXvYqwi33nF+j/zzE9YbRqtJC8sDB+xD37ajKbxGJdiK5/840qmnFyF02R6V05i72trVIx+rmarYg==
X-Received: by 2002:a62:a511:: with SMTP id v17mr27463848pfm.129.1559528522768;
        Sun, 02 Jun 2019 19:22:02 -0700 (PDT)
Received: from localhost ([203.111.179.138])
        by smtp.gmail.com with ESMTPSA id a25sm6557531pfn.1.2019.06.02.19.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jun 2019 19:22:02 -0700 (PDT)
Date:   Mon, 03 Jun 2019 12:22:12 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/4] mm/large system hash: use vmalloc for size >
 MAX_ORDER when !hashdist
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Toshi Kani <toshi.kani@hp.com>,
        Uladzislau Rezki <urezki@gmail.com>
References: <20190528120453.27374-1-npiggin@gmail.com>
        <CAHk-=whHWqVPWMeNRYuxAd8xnZscshoXUP8SFPmJivJfds5-HQ@mail.gmail.com>
In-Reply-To: <CAHk-=whHWqVPWMeNRYuxAd8xnZscshoXUP8SFPmJivJfds5-HQ@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1559527990.5jatqytnit.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds's on June 1, 2019 4:30 am:
> On Tue, May 28, 2019 at 5:08 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> The kernel currently clamps large system hashes to MAX_ORDER when
>> hashdist is not set, which is rather arbitrary.
>=20
> I think the *really* arbitrary part here is "hashdist".
>=20
> If you enable NUMA support, hashdist is just set to 1 by default on
> 64-bit, whether the machine actually has any numa characteristics or
> not. So you take that vmalloc() TLB overhead whether you need it or
> not.

Yeah, that's strange it seems to just be an oversight nobody ever
picked up. Patch 2/4 actually fixed that exactly the way you said.

>=20
> So I think your series looks sane, and should help the vmalloc case
> for big hash allocations, but I also think that this whole
> alloc_large_system_hash() function should be smarter in general.
>=20
> Yes, it's called "alloc_large_system_hash()", but it's used on small
> and perfectly normal-sized systems too, and often for not all that big
> hashes.
>=20
> Yes, we tend to try to make some of those hashes large (dentry one in
> particular), but we also use this for small stuff.
>=20
> For example, on my machine I have several network hashes that have
> order 6-8 sizes, none of which really make any sense to use vmalloc
> space for (and which are smaller than a large page, so your patch
> series wouldn't help).
>=20
> So on the whole I have no issues with this series, but I do think we
> should maybe fix that crazy "if (hashdist)" case. Hmm?

Yes agreed. Even after this series with 2MB mappings it's actually a bit=20
sad that we can't use the linear map for the non-NUMA case. My laptop=20
has a 32MB dentry cache and 16MB inode cache so doing a bunch of name=20
lookups is quite a waste of TLB entries (although at least with 2MB=20
pages it doesn't blow the TLB completely).

We might be able to go a step further and use memblock allocator for
those as well, or reserve some boot CMA for that common case ot just
use the linear map for these hashes. I'll look into that.

Thanks,
Nick

=
