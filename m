Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE4112058
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 00:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfLCXjt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Dec 2019 18:39:49 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33476 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfLCXjt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Dec 2019 18:39:49 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so2170151pjb.0
        for <linux-arch@vger.kernel.org>; Tue, 03 Dec 2019 15:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VLxOzUzazoD/qcDrmOBxEpKT8zDKcGdwgU5iRuwbvZA=;
        b=BVDTej5T5iPzOrkTJzDqFc6OR2z4FPZlBL/ec9JzS5BWEHzO3yAsa5FUayJxxboWSk
         /NmsrBFO6off0z0J9KA9ANmo+Kg6ZEEy4JFXANgLAbKUqXOd7nWimwAU3g+7JSyYtniF
         luueY9YGQqvoKS6c6ZgSbMCqcbVgC0gnq6pxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VLxOzUzazoD/qcDrmOBxEpKT8zDKcGdwgU5iRuwbvZA=;
        b=XgeDfMMMdUWy7rBVYcrc0z9xINguJx1x4zk7xtkXaCXjD3rW7IgXqQ3iAqE02jPG81
         xz2bw5ZB4QTS3Tg2odMltugRdKpWNGHIT6dybs5Tyg0K+/Nj3UCnoEr681auJ7Ge5rts
         uOhE1NX6yyqAwYtdVtl7HFH+qiOs4sIxMoiGpSs+rWSGUWaTM3kLBIDTm67C7j8kwjfC
         wwUXwzidUZDLygavp9Z7xQrEZA7cpzBHCzruQ8oFb1LiE2eJVwPyoaeHN2u5mYddes/+
         dwp+2IikSePBG6nrXVn1YDRcfTpJLXD/Hd82lf0iwIJamrqEbPR92RqiOFMdnGjuXEot
         RBOQ==
X-Gm-Message-State: APjAAAWHZHzItOGX36D69NpQAi5gsV80dhanste6fVZkiNyKxhnU8mmv
        +v29jyU/mQL/oXubCSAme9gXvb03AmQ=
X-Google-Smtp-Source: APXvYqxmFcsDN3sphv0XP5SZYxQVF8tmLokQpIt8byFY9Ezv3IKSzcUQbsn+XlYAv+hALGoWbMDaaQ==
X-Received: by 2002:a17:90a:b706:: with SMTP id l6mr23416pjr.53.1575416388603;
        Tue, 03 Dec 2019 15:39:48 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-7daa-d2ea-7edb-cfe8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:7daa:d2ea:7edb:cfe8])
        by smtp.gmail.com with ESMTPSA id z26sm4463572pgu.80.2019.12.03.15.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 15:39:47 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Marco Elver <elver@google.com>
Cc:     linux-s390@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with generic bitops
In-Reply-To: <87r21lef1k.fsf@mpe.ellerman.id.au>
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net> <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com> <87a78xgu8o.fsf@dja-thinkpad.axtens.net> <87y2wbf0xx.fsf@dja-thinkpad.axtens.net> <CANpmjNN-=F6GK_jHPUx8OdpboK7nMV=i=sKKfSsKwKEHnMTG0g@mail.gmail.com> <87r21lef1k.fsf@mpe.ellerman.id.au>
Date:   Wed, 04 Dec 2019 10:39:44 +1100
Message-ID: <87pnh5dlmn.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,
> I only just noticed this thread as I was about to send a pull request
> for these two commits.
>
> I think I agree that test_bit() shouldn't move (yet), but I dislike that
> the documentation ends up being confusing due to this patch.
>
> So I'm inclined to append or squash in the patch below, which removes
> the new headers from the documentation. The end result is the docs look
> more or less the same, just the ordering of some of the functions
> changes. But we don't end up with test_bit() under the "Non-atomic"
> header, and then also documented in Documentation/atomic_bitops.txt.
>
> Thoughts?

That sounds good to me.

Regards,
Daniel

>
> cheers
>
>
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 2caaeb55e8dd..4ac53a1363f6 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -57,21 +57,12 @@ The Linux kernel provides more basic utility functions.
>  Bit Operations
>  --------------
>  
> -Atomic Operations
> -~~~~~~~~~~~~~~~~~
> -
>  .. kernel-doc:: include/asm-generic/bitops/instrumented-atomic.h
>     :internal:
>  
> -Non-atomic Operations
> -~~~~~~~~~~~~~~~~~~~~~
> -
>  .. kernel-doc:: include/asm-generic/bitops/instrumented-non-atomic.h
>     :internal:
>  
> -Locking Operations
> -~~~~~~~~~~~~~~~~~~
> -
>  .. kernel-doc:: include/asm-generic/bitops/instrumented-lock.h
>     :internal:
>  
