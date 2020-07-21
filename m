Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFF2228A40
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgGUU7I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUU7I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:59:08 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F4C061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:59:07 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so176726ljc.5
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oK0U7CK9re3KwY6+YWsTmFuqjWG2zA/cc2/NJqjaC58=;
        b=MJZCaND5bM+eLX/atXXRAs6foyLZdDHGe4xkDKocFoD0uopxVHUhAJF2FHiEr07g0i
         laWzz+ZjhXspCUxo4v10aCUKL49bwik1j0t1yx8BhtkyTkMGbYDaV4cQvfR9eOd8QLBe
         Q7fIBTaBylq5TNJhwwHDi6jMkh55DZb7AgFtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oK0U7CK9re3KwY6+YWsTmFuqjWG2zA/cc2/NJqjaC58=;
        b=Jr/dB2gpOFUhl3lJghBNqucjVE5NlwMMrttai4le7lHSu4ll7P9a1lVlA4rnscc+xm
         R97J1idhpKJlfx1V4nmeWWy44zuRRnxcGAzENfXXhRsCuNVknznZqnEsXTp9udrGjb/3
         Te+ZENzO7t/2eSgwQxSoVzwYGh70g8ZqO6FWfNEprhvW1ZcnPRuCM1O16ddv9ST6eNeY
         KVV/hGLGcEXeezRbj5ff3W57HMuWSBxC0gsMhewFfR1a66YfJXGmcNsKQv8n+3gvIozo
         6Xrxap9yR756vhHGkoYkM5Qwky4eEo6FDvDiHbPbMoSdW3Jxxx9omL2aRlT9vInwlZxu
         FzGQ==
X-Gm-Message-State: AOAM533pxYYIe3Rad39m+VvEkbToFUTh0Pz0Sr/kXKir0+R7YNW/v+hQ
        X0rrMADXy8/1fSndPpZw8bZd+MXI7Fk=
X-Google-Smtp-Source: ABdhPJw0oPElRURnYCSN8n6IN/0pzK1l601ZkKxMbWDwqVFUrKk8UnRojIjofKM71J6x8en30ryJGw==
X-Received: by 2002:a2e:8357:: with SMTP id l23mr12718268ljh.290.1595365145856;
        Tue, 21 Jul 2020 13:59:05 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v12sm5992747lfp.12.2020.07.21.13.59.05
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:59:05 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id q4so195860lji.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:59:05 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr13034796ljj.314.1595365143886;
 Tue, 21 Jul 2020 13:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk> <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
In-Reply-To: <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 13:58:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com>
Message-ID: <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 1:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This seems dangerous to me.
>
> Maybe some implementation depends on the fact that they actually do
> the csum 16 bits at a time, and never see an overflow in "int",
> because they keep folding things.
>
> You now break that assumption, and give it an initial value that the
> csum code itself would never generate, and wouldn't handle right.
>
> But I didn't check. Maybe we don't have anything that stupid in the kernel.

I take it back. The very first place I looked seemed to do exactly that.

See "do_csum()" in the kernel. It doesn't handle carry for any of the
usual cases, exactly because it knows it doesn't need to.

Ok, so do_csum() doesn't take that initial value, but it's very much
an example of the kind of algorithm I was thinking of: it does do
things 32 bits at a time and handles the carry bit in that inner loop,
but internally it knows that the val;ues are limited in other places,
and doesn't need to handle carry everywhere.

                Linus
